Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B530C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67FF20672
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDs02AE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbeLPUEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:04:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36712 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbeLPUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:04:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so10605251wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hsHix6gBh/xVjYblPwG4LDHFo/DoSCk+aOYsHRC9vUc=;
        b=EDs02AE1uafZf+A9VhfgeQJqg2f7b77rWWMdFj6i0Xxl6l0rVDFbtLkj+p9BIbypCW
         P3lJexdto3WqioaUoPeBx7iVe3FvPBjOyroGeqPLbYQZy5viL6AwjlMT0BDZdFhi95A6
         RXuWh6dnDwlR0Bph/EvGYec+y9k71OZKV5oKsmVi4ms2h0XTnbxDaxUcOQLsAAPYSs4L
         jUr5sPTO3+L3OSBAyc8E9wB0MTsogMlutYN6wUlHswwwO2Oazz/CRUE8Tu9Hyyvr8ZLe
         dCdAVtV7qYDB5Igab3qdFulaLpGCpF0oC6G3QOIcFDTVq17kj0rIcN64ucxdkKHv07Rc
         kqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hsHix6gBh/xVjYblPwG4LDHFo/DoSCk+aOYsHRC9vUc=;
        b=TJNcZNP65BmmufTrwWBndHr5BqpYR7yF82GBTFa8Fo+884VGs/ZVMXHY5oGEMvfG0I
         uWx1g8v0SQtfqN7uc3di8H7cH2r/zVx6bmJzX+t6yblb078RerTHP8Jhawb3DbseSnqX
         mbKgsNJ5YrtQdS+jrG2HkDf07w8nQzdNxkndj+HdIVMgyrHLl+Akc7xia2cXLgMPoRwx
         3z9jNCMFThlpKu1nOH4ywPk4jKq7XXd26z/2eeN/30eFPzIBgJsunUQH8APYliI+f6Hd
         1bRQ8xER2pl9gqmOIoKHXIQEHJKf/+1HBr0zy5FuzszL0RzK1UO4OztCMRTONl4hnJjd
         U0uw==
X-Gm-Message-State: AA+aEWaELc74MpbkKm/kFnM5OdBKVmeY2GSlG3cUpvQzwtf8dxtHCYKx
        aqfAh88WBfwm5bQpH5pYVgk=
X-Google-Smtp-Source: AFSGD/XfHFxwDn8m3qLSvASLnqCFfHMYZKNgYDM93KThqki8LY3Un+C07ZBSfAVplP6AcxQ0OQ1wWQ==
X-Received: by 2002:a1c:6e01:: with SMTP id j1mr9311371wmc.103.1544990668556;
        Sun, 16 Dec 2018 12:04:28 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id v5sm10535150wrn.71.2018.12.16.12.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 12:04:27 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v3 3/3] fat: New inline functions to determine the FAT variant (32, 16 or 12)
Date:   Sun, 16 Dec 2018 15:04:00 -0500
Message-Id: <1544990640-11604-4-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces 3 new inline functions - is_fat12, is_fat16 and
is_fat32, and replaces every occurrence in the code in which the FS
variant (whether this is FAT12, FAT16 or FAT32) was previously checked
using msdos_sb_info->fat_bits.


Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/fat/cache.c  |  2 +-
 fs/fat/dir.c    |  4 ++--
 fs/fat/fat.h    | 25 ++++++++++++++++++++++---
 fs/fat/fatent.c | 16 +++++++---------
 fs/fat/inode.c  | 12 ++++++------
 fs/fat/misc.c   |  2 +-
 6 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 78d501c..738e427 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -363,7 +363,7 @@ int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	*phys = 0;
 	*mapped_blocks = 0;
-	if ((sbi->fat_bits != 32) && (inode->i_ino == MSDOS_ROOT_INO)) {
+	if (!is_fat32(sbi) && (inode->i_ino == MSDOS_ROOT_INO)) {
 		if (sector < (sbi->dir_entries >> sbi->dir_per_block_bits)) {
 			*phys = sector + sbi->dir_start;
 			*mapped_blocks = 1;
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c8366cb..20acaea 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -57,7 +57,7 @@ static inline void fat_dir_readahead(struct inode *dir, sector_t iblock,
 	if ((iblock & (sbi->sec_per_clus - 1)) || sbi->sec_per_clus == 1)
 		return;
 	/* root dir of FAT12/FAT16 */
-	if ((sbi->fat_bits != 32) && (dir->i_ino == MSDOS_ROOT_INO))
+	if (!is_fat32(sbi) && (dir->i_ino == MSDOS_ROOT_INO))
 		return;
 
 	bh = sb_find_get_block(sb, phys);
@@ -1313,7 +1313,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		}
 	}
 	if (dir->i_ino == MSDOS_ROOT_INO) {
-		if (sbi->fat_bits != 32)
+		if (!is_fat32(sbi))
 			goto error;
 	} else if (MSDOS_I(dir)->i_start == 0) {
 		fat_msg(sb, KERN_ERR, "Corrupted directory (i_pos %lld)",
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 979bb11..922a0c6 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -142,13 +142,32 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+/*
+ * Functions that determine the variant of the FAT file system (i.e.,
+ * whether this is FAT12, FAT16 or FAT32.
+ */
+static inline bool is_fat12(const struct msdos_sb_info *sbi)
+{
+	return sbi->fat_bits == 12;
+}
+
+static inline bool is_fat16(const struct msdos_sb_info *sbi)
+{
+	return sbi->fat_bits == 16;
+}
+
+static inline bool is_fat32(const struct msdos_sb_info *sbi)
+{
+	return sbi->fat_bits == 32;
+}
+
 /* Maximum number of clusters */
 static inline u32 max_fat(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	return sbi->fat_bits == 32 ? MAX_FAT32 :
-		sbi->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12;
+	return is_fat32(sbi) ? MAX_FAT32 :
+		is_fat16(sbi) ? MAX_FAT16 : MAX_FAT12;
 }
 
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
@@ -266,7 +285,7 @@ static inline int fat_get_start(const struct msdos_sb_info *sbi,
 				const struct msdos_dir_entry *de)
 {
 	int cluster = le16_to_cpu(de->start);
-	if (sbi->fat_bits == 32)
+	if (is_fat32(sbi))
 		cluster |= (le16_to_cpu(de->starthi) << 16);
 	return cluster;
 }
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f58c0ca..495edea 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -290,19 +290,17 @@ void fat_ent_access_init(struct super_block *sb)
 
 	mutex_init(&sbi->fat_lock);
 
-	switch (sbi->fat_bits) {
-	case 32:
+	if (is_fat32(sbi)) {
 		sbi->fatent_shift = 2;
 		sbi->fatent_ops = &fat32_ops;
-		break;
-	case 16:
+	} else if (is_fat16(sbi)) {
 		sbi->fatent_shift = 1;
 		sbi->fatent_ops = &fat16_ops;
-		break;
-	case 12:
+	} else if (is_fat12(sbi)) {
 		sbi->fatent_shift = -1;
 		sbi->fatent_ops = &fat12_ops;
-		break;
+	} else {
+		fat_fs_error(sb, "invalid FAT variant, %u bits", sbi->fat_bits);
 	}
 }
 
@@ -310,7 +308,7 @@ static void mark_fsinfo_dirty(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	if (sb_rdonly(sb) || sbi->fat_bits != 32)
+	if (sb_rdonly(sb) || !is_fat32(sbi))
 		return;
 
 	__mark_inode_dirty(sbi->fsinfo_inode, I_DIRTY_SYNC);
@@ -327,7 +325,7 @@ static inline int fat_ent_update_ptr(struct super_block *sb,
 	/* Is this fatent's blocks including this entry? */
 	if (!fatent->nr_bhs || bhs[0]->b_blocknr != blocknr)
 		return 0;
-	if (sbi->fat_bits == 12) {
+	if (is_fat12(sbi)) {
 		if ((offset + 1) < sb->s_blocksize) {
 			/* This entry is on bhs[0]. */
 			if (fatent->nr_bhs == 2) {
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 7ede9db..583dc6f 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -686,7 +686,7 @@ static void fat_set_state(struct super_block *sb,
 
 	b = (struct fat_boot_sector *) bh->b_data;
 
-	if (sbi->fat_bits == 32) {
+	if (is_fat32(sbi)) {
 		if (set)
 			b->fat32.state |= FAT_STATE_DIRTY;
 		else
@@ -1397,7 +1397,7 @@ static int fat_read_root(struct inode *inode)
 	inode->i_mode = fat_make_mode(sbi, ATTR_DIR, S_IRWXUGO);
 	inode->i_op = sbi->dir_ops;
 	inode->i_fop = &fat_dir_operations;
-	if (sbi->fat_bits == 32) {
+	if (is_fat32(sbi)) {
 		MSDOS_I(inode)->i_start = sbi->root_cluster;
 		error = fat_calc_dir_size(inode);
 		if (error < 0)
@@ -1424,7 +1424,7 @@ static unsigned long calc_fat_clusters(struct super_block *sb)
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
 	/* Divide first to avoid overflow */
-	if (sbi->fat_bits != 12) {
+	if (!is_fat12(sbi)) {
 		unsigned long ent_per_sec = sb->s_blocksize * 8 / sbi->fat_bits;
 		return ent_per_sec * sbi->fat_length;
 	}
@@ -1744,7 +1744,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	}
 
 	/* interpret volume ID as a little endian 32 bit integer */
-	if (sbi->fat_bits == 32)
+	if (is_fat32(sbi))
 		sbi->vol_id = bpb.fat32_vol_id;
 	else /* fat 16 or 12 */
 		sbi->vol_id = bpb.fat16_vol_id;
@@ -1770,11 +1770,11 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 
 	total_clusters = (total_sectors - sbi->data_start) / sbi->sec_per_clus;
 
-	if (sbi->fat_bits != 32)
+	if (!is_fat32(sbi))
 		sbi->fat_bits = (total_clusters > MAX_FAT12) ? 16 : 12;
 
 	/* some OSes set FAT_STATE_DIRTY and clean it on unmount. */
-	if (sbi->fat_bits == 32)
+	if (is_fat32(sbi))
 		sbi->dirty = bpb.fat32_state & FAT_STATE_DIRTY;
 	else /* fat 16 or 12 */
 		sbi->dirty = bpb.fat16_state & FAT_STATE_DIRTY;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index fce0a76..4fc950b 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -64,7 +64,7 @@ int fat_clusters_flush(struct super_block *sb)
 	struct buffer_head *bh;
 	struct fat_boot_fsinfo *fsinfo;
 
-	if (sbi->fat_bits != 32)
+	if (!is_fat32(sbi))
 		return 0;
 
 	bh = sb_bread(sb, sbi->fsinfo_sector);
-- 
2.7.4

