Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D4C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AF72084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umsgUGCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbeLONFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:05:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32908 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLONFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:05:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so1149436wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=INglanZvfD72+kpYZCKueZj6j01mCNeOjc00ZDV22z8=;
        b=umsgUGCGsBu3uDchwn0a72H1ZFEvYSM/CNULMd41oDPEqVfAWafI12yFVfCAHBHIRI
         S6tDyHaaAGqRo9F7XgQFTWx6Q7zYUhwgg7QQehoOKfiTHiISfc30x+nBcZFUiXI7WKBN
         Ro07EcyM4O7eP/uGM0lB48XXrvwk/KM0uze9FWte1v3OYUXz8Ca5wBjlAia3e2WzIvO2
         nJXOeAE9LZJQZ9PbOPTXAZ3ATRIcjQJKSBDMhMd3cOlaNBPa2L12Yb/TGz+i9s1buIF0
         SUeAit8OdreDW8kPlC3Qtj9wjBH7Bbv96wmwDkvs7vOBE4O5eHisg2Rf5gmUyfn7NInc
         qTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=INglanZvfD72+kpYZCKueZj6j01mCNeOjc00ZDV22z8=;
        b=cFZWSTIlTRSoQhZbuoThcWSYM6+tAN4yxOIqVIE170ChfiLA041gETpkP6htkSW+7U
         DxIJMXekbmMce2cYiTWb3dNBFw3L4WlnGlfGmyzgkdg9x0Z037jHYZKebhFLmPtnTJ8j
         s071l0Ok2W30eax+c0vKqLdOG9UIxTJn1gqBEvrelZWftBbHZe1/ofQWp8CT0sIJOss7
         VKcxTKwDh1Rr68ZMqMw2jErS46S3g9tgMUr4Iws2I1KCZyP/k3JbDPTPxH/cghZVMdWx
         aaKXWQxF7BxmvyjHEqL8NXS8Zbr5I68nwrVC2SAlKMf4e90G04xnk+FaXmY0/9HUTmtn
         7s9A==
X-Gm-Message-State: AA+aEWZi3j/bXD4SAB3gAe0i/9qsFtn8mgFV9tUXtQpfEgbsWvPoTXwx
        x5iJz18UzwaD+N1NPv/KkC4=
X-Google-Smtp-Source: AFSGD/VsC8hdrjAyYfHvUSMEZJsV8Gju/QcnFlw3dhtF6sDanbA/a0XINyO12z7tnLVoLwssErEseA==
X-Received: by 2002:a1c:8548:: with SMTP id h69mr5867187wmd.11.1544879110921;
        Sat, 15 Dec 2018 05:05:10 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id s1sm9589159wro.9.2018.12.15.05.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Dec 2018 05:05:10 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v2 3/3] fat: New inline functions to determine the FAT variant (32, 16 or 12)
Date:   Sat, 15 Dec 2018 08:04:32 -0500
Message-Id: <1544879072-4251-4-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces 3 new inline functions - IS_FAT12, IS_FAT16 and
IS_FAT32, and replaces every occurrence in the code in which the FS 
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
index 78d501c..30c51b9 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -363,7 +363,7 @@ int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 
 	*phys = 0;
 	*mapped_blocks = 0;
-	if ((sbi->fat_bits != 32) && (inode->i_ino == MSDOS_ROOT_INO)) {
+	if (!IS_FAT32(sbi) && (inode->i_ino == MSDOS_ROOT_INO)) {
 		if (sector < (sbi->dir_entries >> sbi->dir_per_block_bits)) {
 			*phys = sector + sbi->dir_start;
 			*mapped_blocks = 1;
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c8366cb..b0b8f44 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -57,7 +57,7 @@ static inline void fat_dir_readahead(struct inode *dir, sector_t iblock,
 	if ((iblock & (sbi->sec_per_clus - 1)) || sbi->sec_per_clus == 1)
 		return;
 	/* root dir of FAT12/FAT16 */
-	if ((sbi->fat_bits != 32) && (dir->i_ino == MSDOS_ROOT_INO))
+	if (!IS_FAT32(sbi) && (dir->i_ino == MSDOS_ROOT_INO))
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
index 11bc4a2..5b6f1c8 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -142,13 +142,32 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+/*
+ * Functions that determine the variant of the FAT file system (i.e.,
+ * whether this is FAT12, FAT16 or FAT32.
+ */
+static inline bool IS_FAT12(const struct msdos_sb_info *sbi)
+{
+	return sbi->fat_bits == 12;
+}
+
+static inline bool IS_FAT16(const struct msdos_sb_info *sbi)
+{
+	return sbi->fat_bits == 16;
+}
+
+static inline bool IS_FAT32(const struct msdos_sb_info *sbi)
+{
+	return sbi->fat_bits == 32;
+}
+
 /* Maximum number of clusters */
 static inline u32 MAX_FAT(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	return sbi->fat_bits == 32 ? MAX_FAT32 :
-		sbi->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12;
+	return IS_FAT32(sbi) ? MAX_FAT32 :
+		IS_FAT16(sbi) ? MAX_FAT16 : MAX_FAT12;
 }
 
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
@@ -266,7 +285,7 @@ static inline int fat_get_start(const struct msdos_sb_info *sbi,
 				const struct msdos_dir_entry *de)
 {
 	int cluster = le16_to_cpu(de->start);
-	if (sbi->fat_bits == 32)
+	if (IS_FAT32(sbi))
 		cluster |= (le16_to_cpu(de->starthi) << 16);
 	return cluster;
 }
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f58c0ca..9166d96 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -290,19 +290,17 @@ void fat_ent_access_init(struct super_block *sb)
 
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
+	} else {
+		fat_fs_error(sb, "invalid FAT variant, %u bits", sbi->fat_bits);
 	}
 }
 
@@ -310,7 +308,7 @@ static void mark_fsinfo_dirty(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	if (sb_rdonly(sb) || sbi->fat_bits != 32)
+	if (sb_rdonly(sb) || !IS_FAT32(sbi))
 		return;
 
 	__mark_inode_dirty(sbi->fsinfo_inode, I_DIRTY_SYNC);
@@ -327,7 +325,7 @@ static inline int fat_ent_update_ptr(struct super_block *sb,
 	/* Is this fatent's blocks including this entry? */
 	if (!fatent->nr_bhs || bhs[0]->b_blocknr != blocknr)
 		return 0;
-	if (sbi->fat_bits == 12) {
+	if (IS_FAT12(sbi)) {
 		if ((offset + 1) < sb->s_blocksize) {
 			/* This entry is on bhs[0]. */
 			if (fatent->nr_bhs == 2) {
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 708de6d..a84b61b 100644
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

