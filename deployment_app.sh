#!/bin/bash
clear;read -p"Enter artifact file (ex. disc-agora-imas-config-C1234456-2.0.0.zip): " a_file_name;clear
clear;read -s -p"Password: " password;clear
echo "NOTE: Kinit must be active to run script"
klist
echo "Press Enter to continue: "

title=$(echo "$a_file_name" | sed 's/-C.*//')
change_request=$(echo "C"${a_file_name#*C} | sed 's/-.*//')
patch_nr=$(echo "C"${a_file_name#*C} | cut -d '-' -f 2 | sed 's/.zip.*//')

# Setting variables

file_name=$project-$change_request-$patch_nr.zip
log_zipfile_name=$change_request\_unzip.log
log_makefile_name=$change_request-$environment-$(date +%Y%m%d)-apply.log
makefile_location="src/$makefile_name"


# Setting up edge node
if [ $(environment) = 'acc' ]: then
    edge_node = bdxaa102.mgt.ecb.de:/data/disc-ddf/etl/app/ || echo "Failed to connect, exiting..." && rm -rf ../$(change_request) && return
elif [ $(environment) = 'prod' ]: then
    edge_node = bdxap104.mgt.ecb.de:/data/disc-ddf/etl/app/ || echo "Failed to connect, exiting..." && rm -rf ../$(change_request) && return
else
    echo "Something went wrong, exiting and rolling back..."
    eturn
fi

#testing
echo "Edge node: $edge_node"

# Starting execution
# echo ".........starting deployment.........."

# echo "Creating Directory ${change_request} ... "
# mkdir $change_request && cd $_

# echo "Copying artifacts ..."
# sshpass -p "$password" scp -p $(edge_node)/$(a_file_name) || echo "Failed to connect, exiting..." && rm -rf ../$

# echo "Unzipping artifact file ..."
# unzip $a_file_name 2>&1 | tee $log_file_name

# echo "Applying makefile ..."
# make -B apply $(makefile_location) apply ENV=$(Environment) 2>$1 | tee logs/$(log_makefile_name)

# echo "Copying log file to Z:/ drive ..."
# sshpass -p "$password" scp -p /ad-home/$USER/src/logs/$(log_makefile_name) pam-1.mgmt.ecb.de/$USER/$(change_request)

# echo ".........deployment complete, pick up log file from Z drive.........."