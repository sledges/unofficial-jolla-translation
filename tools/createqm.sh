#!/bin/sh
##############################################
#
# createqm.sh
#
# This script compile ts file to qm file
#
##############################################

PACKAGELISTFILE="tools/packagelist.txt"

if [ -z $POOTLE_LANG ] 
then
    echo "The POOTLE_LANG variable is not set!"
    echo "Please set it with export POOTLE_LANG=hu before calling this script!"
    echo "The variable should match with the language code on the pootle."
    exit -1
fi

if [ -z $QM_SUFFIX ] 
then
    echo "The QM_SUFFIX variable is not set!"
    echo "Please set it with export QM_SUFFIX=hu before calling this script!"
    echo "This variable should be set to the preferred qm file suffix on the target device"
    exit -1
fi

rm -rf usr/share/translations/*
i=0
TS_COUNT=$(wc -l < $PACKAGELISTFILE)
while IFS='' read -r line || [[ -n "$line" ]]; do
    FILENAME=$(echo "$line" | sed "s/.*\///")
    FILENAME=$(echo $FILENAME | awk -F"." '{print $1}')
    lrelease -idbased translations/$POOTLE_LANG/$line -qm usr/share/translations/$FILENAME-${QM_SUFFIX}.qm
done < $PACKAGELISTFILE