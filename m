Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D2F20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ux2/56Rq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D2F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbeLJTml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:42:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52590 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeLJTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:42:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so12147298wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=WEuADFXNBLOzahmDGVbu5/r04ZDUvjhUv8CX/GM2uQ0=;
        b=ux2/56Rq8v0sin+JoFpJKUIzdKydK9SFoGAppMsiRawULJ2QESL5zR1wq9R4y4I9kd
         B1VlcL4QpHiFauwazRtcuvinrPoluA5LjXVoQ5EcLnjR3P/RE5OJDLe4tKk/CDCZFGSG
         lWHpFcLXI1u7ABjjBh+qd+N5plTUROeJjQCZ+wljTwf5GGDe2F234kUfSEHeflHzYX8P
         Y5kC8Zfwsdqrmz+G/wgOx6K19578h+1CbQcX6rEI8wvsTRaXpLe2FE+5HFA5bzgvJFlC
         jWxacEgd4ngt7FQK4ewVpt/9s5YQ1mfENCx3T5RtsW2P8Qt17Ks63Uz7+HAqmBEHTjWr
         aGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=WEuADFXNBLOzahmDGVbu5/r04ZDUvjhUv8CX/GM2uQ0=;
        b=dSWzwruQlEvGiQiGiqmqWdljWyDRnE/k71J174xDfNc8JOYKTdHpXnHw5i9zomSwja
         08TBMWTlHpq4++HsM4AG3FInwnv99z+/s2Rq3OyMj7Jc46H0mLsrgYtZo82MiAK8tsL2
         qPNDyjVHUuv7x2bpsIHuqHTnln9ppztHIDuH4NGXUQMUTA2kGecHMKJ9zoQkPVbHXxmW
         LOBfqE3gsp0gWhtFjJ+LQg5GDDS9NWbbKSqUwzeEwcGV4bdDQ+EykrZq3QSm9w3P2zjR
         iQFQqpstJkUFgBDfogVFtPQcj2P3DbzmhVsOPTijZxLCtJsDq7Uq8UZhZzTVy8lzpCVS
         qj0g==
X-Gm-Message-State: AA+aEWYXDtqmPWkQfk6V30rGxUlWIpJcBALzzgX/SdWoz0vnFgJEFMD8
        k2rvrj2Lam66tiNMIlIL900=
X-Google-Smtp-Source: AFSGD/UXB+qYRuR4Xoxd3QtThlehP0ubb460QoRcuTU9GLFUlrvcB3r+DoXIZPRlDVOvfiX79GnbvQ==
X-Received: by 2002:a1c:7a16:: with SMTP id v22mr10973682wmc.131.1544470956894;
        Mon, 10 Dec 2018 11:42:36 -0800 (PST)
Received: from osboxes.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id t4sm14565082wrm.6.2018.12.10.11.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:42:36 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     hirofumi@mail.parknet.co.jp, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        axboe@kernel.dk, martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, carmeli.tamir@gmail.com
Subject: [PATCH 2/2] fat: New macros to determine the FAT variant (32, 16 or 12)
Date:   Mon, 10 Dec 2018 14:41:57 -0500
Message-Id: <1544470917-6443-3-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces 3 new macros - IS_FAT12, IS_FAT16 and IS_FAT32,
and replaces every occurrence in the code in which the FS variant (whether
this is FAT12, FAT16 or FAT32) was previously checked using
msdos_sb_info->fat_bits.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/fat/cache.c  |  2 +-
 fs/fat/dir.c    |  4 ++--
 fs/fat/fat.h    | 14 +++++++++-----
 fs/fat/fatent.c | 17 +++++++----------
 fs/fat/inode.c  | 12 ++++++------
 fs/fat/misc.c   |  2 +-
 6 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 78d501c..99962b3 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -363,7 +363,7 @@ int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	*phys = 0;
 	*mapped_blocks = 0;
-	if ((sbi->fat_bits != 32) && (inode->i_ino == MSDOS_ROOT_INO)) {
+	if ((!IS_FAT32(sbi)) && (inode->i_ino == MSDOS_ROOT_INO)) {
 		if (sector < (sbi->dir_entries >> sbi->dir_per_block_bits)) {
 			*phys = sector + sbi->dir_start;
 			*mapped_blocks = 1;
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c8366cb..9acbaed 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -57,7 +57,7 @@ static inline void fat_dir_readahead(struct inode *dir, sector_t iblock,
 	if ((iblock & (sbi->sec_per_clus - 1)) || sbi->sec_per_clus == 1)
 		return;
 	/* root dir of FAT12/FAT16 */
-	if ((sbi->fat_bits != 32) && (dir->i_ino == MSDOS_ROOT_INO))
+	if ((!IS_FAT32(sbi)) && (dir->i_ino == MSDOS_ROOT_INO))
 		return;
 
 	bh = sb_find_get_block(sb, phys);
@@ -1313,7 +1313,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		}
 	}
 	if (dir->i_ino == MSDOS_ROOT_INO) {
-		if (sbi->fat_bits != 32)
+		if (!IS_FAT32(sbi))
 			goto error;
 	} else if (MSDOS_I(dir)->i_start == 0) {
 		fat_msg(sb, KERN_ERR, "Corrupted directory (i_pos %lld)",
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index e06fdd3..de7c4c8 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -116,12 +116,16 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
  * this is FAT12, FAT16 or FAT32.
  */
 
-#define FAT_FIRST_ENT(s, x)     ((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
-	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
+#define IS_FAT12(sbi) (sbi->fat_bits == 12)
+#define IS_FAT16(sbi) (sbi->fat_bits == 16)
+#define IS_FAT32(sbi) (sbi->fat_bits == 32)
+
+#define FAT_FIRST_ENT(s, x)     ((IS_FAT32(MSDOS_SB(s)) ? 0x0FFFFF00 : \
+	IS_FAT16(MSDOS_SB(s)) ? 0xFF00 : 0xF00) | (x))
 
 /* maximum number of clusters */
-#define MAX_FAT(s)      (MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
-	MSDOS_SB(s)->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12)
+#define MAX_FAT(s)      (IS_FAT32(MSDOS_SB(s)) ? MAX_FAT32 : \
+	IS_FAT16(MSDOS_SB(s)) ? MAX_FAT16 : MAX_FAT12)
 
 /*
  * MS-DOS file system inode data in memory
@@ -269,7 +273,7 @@ static inline int fat_get_start(const struct msdos_sb_info *sbi,
 				const struct msdos_dir_entry *de)
 {
 	int cluster = le16_to_cpu(de->start);
-	if (sbi->fat_bits == 32)
+	if (IS_FAT32(sbi))
 		cluster |= (le16_to_cpu(de->starthi) << 16);
 	return cluster;
 }
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f58c0ca..da0c922 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -290,27 +290,24 @@ void fat_ent_access_init(struct super_block *sb)
 
 	mutex_init(&sbi->fat_lock);
 
-	switch (sbi->fat_bits) {
-	case 32:
+	if (IS_FAT32(sbi)) {
 		sbi->fatent_shift = 2;
 		sbi->fatent_ops = &fat32_ops;
-		break;
-	case 16:
+	} else if (IS_FAT16(sbi)) {
 		sbi->fatent_shift = 1;
 		sbi->fatent_ops = &fat16_ops;
-		break;
-	case 12:
+	} else if (IS_FAT12(sbi)) {
 		sbi->fatent_shift = -1;
 		sbi->fatent_ops = &fat12_ops;
-		break;
-	}
+	} else
+		fat_fs_error(sb, "invalid FAT variant");
 }
 
 static void mark_fsinfo_dirty(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	if (sb_rdonly(sb) || sbi->fat_bits != 32)
+	if (sb_rdonly(sb) || !IS_FAT32(sbi))
 		return;
 
 	__mark_inode_dirty(sbi->fsinfo_inode, I_DIRTY_SYNC);
@@ -327,7 +324,7 @@ static inline int fat_ent_update_ptr(struct super_block *sb,
 	/* Is this fatent's blocks including this entry? */
 	if (!fatent->nr_bhs || bhs[0]->b_blocknr != blocknr)
 		return 0;
-	if (sbi->fat_bits == 12) {
+	if (IS_FAT12(sbi)) {
 		if ((offset + 1) < sb->s_blocksize) {
 			/* This entry is on bhs[0]. */
 			if (fatent->nr_bhs == 2) {
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index e981e9d..68834fb 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -686,7 +686,7 @@ static void fat_set_state(struct super_block *sb,
 
 	b = (struct fat_boot_sector *) bh->b_data;
 
-	if (sbi->fat_bits == 32) {
+	if (IS_FAT32(sbi)) {
 		if (set)
 			b->fat32.state |= FAT_STATE_DIRTY;
 		else
@@ -1397,7 +1397,7 @@ static int fat_read_root(struct inode *inode)
 	inode->i_mode = fat_make_mode(sbi, ATTR_DIR, S_IRWXUGO);
 	inode->i_op = sbi->dir_ops;
 	inode->i_fop = &fat_dir_operations;
-	if (sbi->fat_bits == 32) {
+	if (IS_FAT32(sbi)) {
 		MSDOS_I(inode)->i_start = sbi->root_cluster;
 		error = fat_calc_dir_size(inode);
 		if (error < 0)
@@ -1424,7 +1424,7 @@ static unsigned long calc_fat_clusters(struct super_block *sb)
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
 	/* Divide first to avoid overflow */
-	if (sbi->fat_bits != 12) {
+	if (!IS_FAT12(sbi)) {
 		unsigned long ent_per_sec = sb->s_blocksize * 8 / sbi->fat_bits;
 		return ent_per_sec * sbi->fat_length;
 	}
@@ -1744,7 +1744,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	}
 
 	/* interpret volume ID as a little endian 32 bit integer */
-	if (sbi->fat_bits == 32)
+	if (IS_FAT32(sbi))
 		sbi->vol_id = bpb.fat32_vol_id;
 	else /* fat 16 or 12 */
 		sbi->vol_id = bpb.fat16_vol_id;
@@ -1770,11 +1770,11 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 
 	total_clusters = (total_sectors - sbi->data_start) / sbi->sec_per_clus;
 
-	if (sbi->fat_bits != 32)
+	if (!IS_FAT32(sbi))
 		sbi->fat_bits = (total_clusters > MAX_FAT12) ? 16 : 12;
 
 	/* some OSes set FAT_STATE_DIRTY and clean it on unmount. */
-	if (sbi->fat_bits == 32)
+	if (IS_FAT32(sbi))
 		sbi->dirty = bpb.fat32_state & FAT_STATE_DIRTY;
 	else /* fat 16 or 12 */
 		sbi->dirty = bpb.fat16_state & FAT_STATE_DIRTY;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index fce0a76..5368c6a 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -64,7 +64,7 @@ int fat_clusters_flush(struct super_block *sb)
 	struct buffer_head *bh;
 	struct fat_boot_fsinfo *fsinfo;
 
-	if (sbi->fat_bits != 32)
+	if (!IS_FAT32(sbi))
 		return 0;
 
 	bh = sb_bread(sb, sbi->fsinfo_sector);
-- 
2.7.4

