#!/bin/bash
SCRIPT_DIR="/root/backup" #这个改成你存放刚刚 载下来的dropbox_uploader.sh的文件夹位置
DROPBOX_DIR="/backup" #这个改成你的备份文件想要放在Dropbox下面的文件夹名称，如果不存在，脚本会自动创建
BACKUP_SRC="/var/www/lixinxing.xyz/content/images  /var/www/lixinxing.xyz/content/data/ghost.db" #这个是你想要备份的本地VPS上的文件，不同的目录用空格分开
BACKUP_DST="/tmp" #这个是你暂时存放备份压缩文件的地方，一般用/tmp即可

# 下面的一般不用改了
NOW=$(date +"%Y.%m.%d")
DESTFILE="$BACKUP_DST/$NOW.tar.gz"

# 压缩文件
tar cfz "$DESTFILE" $BACKUP_SRC

# 用脚本上传到dropbox
$SCRIPT_DIR/dropbox_uploader.sh upload "$DESTFILE"     "$DROPBOX_DIR/$NOW.tar.gz"

# 删除本地的临时文件
rm -f "$NOW-Databases.sql" "$DESTFILE"

