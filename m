Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3224542-1525804324-2-5444352894078276201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525804324; b=N0JEy6PnmRdkOkG/ZzRNK58tdeSJapEj0o2OD3hLcUGyzeKpZs
    hftVxF4oHoUpInROgWASRQHokJv/RIc4j7gBwU4h6ey8sxh407HPHZgx413gKxlL
    YPjwCTZg9mkwtVj3uNfqiPiZPxPngGX+O3AVvfFdWHFG/LYBESJStBMDYoYKbeJR
    NnbsMsJM+rBTuKqIeyoGddRKk4kYg93xg2Ik5i+6hRLVmHqri02qusqBnFeO44Sz
    ujTIrOS2FTUoXVX/eqnT245OAugvuKQk8qurKt3UeqZPYGhL4CboRa9/GroEDAmW
    crA/bykWBO5mrF/w0tJ+TQfrKVIBbjdavT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525804324; bh=
    RsdkRzbxAkG2+0IkFZXeB02pPYuSyXjVJ1AgJeZRhWQ=; b=hfr5SUJRyTHvMt3c
    YOPhdwWfgf7HdVqK/TwtfoccrOFM0uKLlsg7hW2jYJWU6sA7FzEP5uAXKlSEtFws
    MRhMrVZRrOJI9kaxo7+s0Nhqz6E+ckeRyO9CRC0ymcan0ZwwLw1wZ5RUPBxO+mgA
    a5iG58qA/flmcKLyuxR+oZLS3s48rGgYsnxgfvCQ3HJzAjUKoStnF+gkzyu0FEaZ
    RX8Z3W5pPSASXOGr3Kdw6hq+uSGpTX5+S0iytjG5ZTfXTwmat0KaATVb7sTf+nYa
    VNqf+VFzLin2S+BdBN5nvN3Lxoul1Co2Xn99l9ZEe0rCV+QXT3qO9YLJQwA9bBow
    7pasXA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLqejBEs2u5FbEMkI4eydE5vMNkiV6KZ0PaCCb/eT3ZWlLKINXo4ZLWKYYEtpFCuk6rIlBrgxCHIuqUswNnyioyMYiq63IHeT6akSJTdKqz8VUHaV7ji
    LhZw7GXRKAyqTz1qcIvazxz5Ol6ZxscAYS32vBhj6GMjI1olViG1jeBy0/SZ4aT3K2Upvm+B16X0r9GuZCSbFo2uMwSIzAMSzFCit42KWBWfG0Qv12kC0K7M
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=e5uIJ8CGOZWti3iHL0oA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756081AbeEHSb6 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 14:31:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932598AbeEHSFh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:37 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 33/76] fs/fat: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:53 -0700
Message-Id: <20180508180436.716-34-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/fat/cache.c       | 12 ++++++------
 fs/fat/dir.c         | 26 +++++++++++++-------------
 fs/fat/fat.h         |  2 +-
 fs/fat/fatent.c      | 10 +++++-----
 fs/fat/file.c        | 24 ++++++++++++------------
 fs/fat/inode.c       | 28 ++++++++++++++--------------
 fs/fat/misc.c        |  2 +-
 fs/fat/namei_msdos.c | 22 +++++++++++-----------
 fs/fat/namei_vfat.c  | 18 +++++++++---------
 fs/fat/nfs.c         |  4 ++--
 10 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index e9bed49df6b7..bfe99b4a9ef8 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -224,7 +224,7 @@ static inline void cache_init(struct fat_cache_id *cid, int fclus, int dclus)
 
 int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	const int limit = sb->s_maxbytes >> MSDOS_SB(sb)->cluster_bits;
 	struct fat_entry fatent;
 	struct fat_cache_id cid;
@@ -285,7 +285,7 @@ int fat_get_cluster(struct inode *inode, int cluster, int *fclus, int *dclus)
 
 static int fat_bmap_cluster(struct inode *inode, int cluster)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int ret, fclus, dclus;
 
 	if (MSDOS_I(inode)->i_start == 0)
@@ -306,7 +306,7 @@ int fat_get_mapped_cluster(struct inode *inode, sector_t sector,
 			   sector_t last_block,
 			   unsigned long *mapped_blocks, sector_t *bmap)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int cluster, offset;
 
@@ -328,7 +328,7 @@ int fat_get_mapped_cluster(struct inode *inode, sector_t sector,
 static int is_exceed_eof(struct inode *inode, sector_t sector,
 			 sector_t *last_block, int create)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	const unsigned long blocksize = sb->s_blocksize;
 	const unsigned char blocksize_bits = sb->s_blocksize_bits;
 
@@ -353,7 +353,7 @@ static int is_exceed_eof(struct inode *inode, sector_t sector,
 int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 	     unsigned long *mapped_blocks, int create, bool from_bmap)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	sector_t last_block;
 
 	*phys = 0;
@@ -371,7 +371,7 @@ int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys,
 			return 0;
 	} else {
 		last_block = inode->i_blocks >>
-				(inode->i_sb->s_blocksize_bits - 9);
+				(inode_sb(inode)->s_blocksize_bits - 9);
 		if (sector >= last_block)
 			return 0;
 	}
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 8e100c3bf72c..dce4b9f0c754 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -48,7 +48,7 @@ static inline loff_t fat_make_i_pos(struct super_block *sb,
 static inline void fat_dir_readahead(struct inode *dir, sector_t iblock,
 				     sector_t phys)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	int sec;
@@ -81,7 +81,7 @@ static inline void fat_dir_readahead(struct inode *dir, sector_t iblock,
 static int fat__get_entry(struct inode *dir, loff_t *pos,
 			  struct buffer_head **bh, struct msdos_dir_entry **de)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	sector_t phys, iblock;
 	unsigned long mapped_blocks;
 	int err, offset;
@@ -121,7 +121,7 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
 	/* Fast stuff first */
 	if (*bh && *de &&
 	   (*de - (struct msdos_dir_entry *)(*bh)->b_data) <
-				MSDOS_SB(dir->i_sb)->dir_per_block - 1) {
+				MSDOS_SB(inode_sb(dir))->dir_per_block - 1) {
 		*pos += sizeof(struct msdos_dir_entry);
 		(*de)++;
 		return 0;
@@ -462,7 +462,7 @@ static int fat_parse_short(struct super_block *sb,
 int fat_search_long(struct inode *inode, const unsigned char *name,
 		    int name_len, struct fat_slot_info *sinfo)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh = NULL;
 	struct msdos_dir_entry *de;
@@ -553,7 +553,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 			 struct dir_context *ctx, int short_only,
 			 struct fat_ioctl_filldir_callback *both)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
@@ -954,7 +954,7 @@ int fat_subdirs(struct inode *dir)
 int fat_scan(struct inode *dir, const unsigned char *name,
 	     struct fat_slot_info *sinfo)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 
 	sinfo->slot_off = 0;
 	sinfo->bh = NULL;
@@ -978,7 +978,7 @@ EXPORT_SYMBOL_GPL(fat_scan);
 int fat_scan_logstart(struct inode *dir, int i_logstart,
 		      struct fat_slot_info *sinfo)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 
 	sinfo->slot_off = 0;
 	sinfo->bh = NULL;
@@ -996,7 +996,7 @@ int fat_scan_logstart(struct inode *dir, int i_logstart,
 
 static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de, *endp;
 	int err = 0, orig_slots;
@@ -1031,7 +1031,7 @@ static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
 
 int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct msdos_dir_entry *de;
 	struct buffer_head *bh;
 	int err = 0, nr_slots;
@@ -1084,7 +1084,7 @@ EXPORT_SYMBOL_GPL(fat_remove_entries);
 static int fat_zeroed_cluster(struct inode *dir, sector_t blknr, int nr_used,
 			      struct buffer_head **bhs, int nr_bhs)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	sector_t last_blknr = blknr + MSDOS_SB(sb)->sec_per_clus;
 	int err, i, n;
 
@@ -1132,7 +1132,7 @@ static int fat_zeroed_cluster(struct inode *dir, sector_t blknr, int nr_used,
 
 int fat_alloc_new_dir(struct inode *dir, struct timespec *ts)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
 	struct msdos_dir_entry *de;
@@ -1196,7 +1196,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 			       int *nr_cluster, struct msdos_dir_entry **de,
 			       struct buffer_head **bh, loff_t *i_pos)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
 	sector_t blknr, start_blknr, last_blknr;
@@ -1275,7 +1275,7 @@ static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
 int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 		    struct fat_slot_info *sinfo)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh, *prev, *bhs[3]; /* 32*slots (672bytes) */
 	struct msdos_dir_entry *uninitialized_var(de);
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 8fc1093da47d..81c3776bc35d 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -156,7 +156,7 @@ static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
  */
 static inline int fat_mode_can_hold_ro(struct inode *inode)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	umode_t mask;
 
 	if (S_ISDIR(inode->i_mode)) {
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index bac10de678cc..97d3c44eeee1 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -347,8 +347,8 @@ static inline int fat_ent_update_ptr(struct super_block *sb,
 
 int fat_ent_read(struct inode *inode, struct fat_entry *fatent, int entry)
 {
-	struct super_block *sb = inode->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct super_block *sb = inode_sb(inode);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	int err, offset;
 	sector_t blocknr;
@@ -406,7 +406,7 @@ static int fat_mirror_bhs(struct super_block *sb, struct buffer_head **bhs,
 int fat_ent_write(struct inode *inode, struct fat_entry *fatent,
 		  int new, int wait)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	const struct fatent_operations *ops = MSDOS_SB(sb)->fatent_ops;
 	int err;
 
@@ -461,7 +461,7 @@ static void fat_collect_bhs(struct buffer_head **bhs, int *nr_bhs,
 
 int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent, prev_ent;
@@ -549,7 +549,7 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 
 int fat_free_clusters(struct inode *inode, int cluster)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	const struct fatent_operations *ops = sbi->fatent_ops;
 	struct fat_entry fatent;
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 4724cc9ad650..b01165f8df4c 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -34,7 +34,7 @@ static int fat_ioctl_get_attributes(struct inode *inode, u32 __user *user_attr)
 static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 {
 	struct inode *inode = file_inode(file);
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	int is_dir = S_ISDIR(inode->i_mode);
 	u32 attr, oldattr;
 	struct iattr ia;
@@ -117,7 +117,7 @@ static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 
 static int fat_ioctl_get_volume_id(struct inode *inode, u32 __user *user_attr)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	return put_user(sbi->vol_id, user_attr);
 }
 
@@ -150,8 +150,8 @@ static long fat_generic_compat_ioctl(struct file *filp, unsigned int cmd,
 static int fat_file_release(struct inode *inode, struct file *filp)
 {
 	if ((filp->f_mode & FMODE_WRITE) &&
-	     MSDOS_SB(inode->i_sb)->options.flush) {
-		fat_flush_inodes(inode->i_sb, inode, NULL);
+	     MSDOS_SB(inode_sb(inode))->options.flush) {
+		fat_flush_inodes(inode_sb(inode), inode, NULL);
 		congestion_wait(BLK_RW_ASYNC, HZ/10);
 	}
 	return 0;
@@ -163,7 +163,7 @@ int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	int res, err;
 
 	res = generic_file_fsync(filp, start, end, datasync);
-	err = sync_mapping_buffers(MSDOS_SB(inode->i_sb)->fat_inode->i_mapping);
+	err = sync_mapping_buffers(MSDOS_SB(inode_sb(inode))->fat_inode->i_mapping);
 
 	return res ? res : err;
 }
@@ -234,7 +234,7 @@ static long fat_fallocate(struct file *file, int mode,
 	loff_t mm_bytes; /* Number of bytes to be allocated for file */
 	loff_t ondisksize; /* block aligned on-disk size in bytes*/
 	struct inode *inode = file->f_mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int err = 0;
 
@@ -279,7 +279,7 @@ static long fat_fallocate(struct file *file, int mode,
 /* Free all clusters after the skip'th cluster. */
 static int fat_free(struct inode *inode, int skip)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int err, wait, free_start, i_start, i_logstart;
 
 	if (MSDOS_I(inode)->i_start == 0)
@@ -348,7 +348,7 @@ static int fat_free(struct inode *inode, int skip)
 
 void fat_truncate_blocks(struct inode *inode, loff_t offset)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	const unsigned int cluster_size = sbi->cluster_size;
 	int nr_clusters;
 
@@ -362,7 +362,7 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	nr_clusters = (offset + (cluster_size - 1)) >> sbi->cluster_bits;
 
 	fat_free(inode, nr_clusters);
-	fat_flush_inodes(inode->i_sb, inode, NULL);
+	fat_flush_inodes(inode_sb(inode), inode, NULL);
 }
 
 int fat_getattr(const struct path *path, struct kstat *stat,
@@ -370,11 +370,11 @@ int fat_getattr(const struct path *path, struct kstat *stat,
 {
 	struct inode *inode = d_inode(path->dentry);
 	generic_fillattr(inode, stat);
-	stat->blksize = MSDOS_SB(inode->i_sb)->cluster_size;
+	stat->blksize = MSDOS_SB(inode_sb(inode))->cluster_size;
 
-	if (MSDOS_SB(inode->i_sb)->options.nfs == FAT_NFS_NOSTALE_RO) {
+	if (MSDOS_SB(inode_sb(inode))->options.nfs == FAT_NFS_NOSTALE_RO) {
 		/* Use i_pos for ino. This is used as fileid of nfs. */
-		stat->ino = fat_i_pos_read(MSDOS_SB(inode->i_sb), inode);
+		stat->ino = fat_i_pos_read(MSDOS_SB(inode_sb(inode)), inode);
 	}
 	return 0;
 }
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index ffbbf0520d9e..09025f390462 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -113,7 +113,7 @@ static inline int __fat_get_block(struct inode *inode, sector_t iblock,
 				  unsigned long *max_blocks,
 				  struct buffer_head *bh_result, int create)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	unsigned long mapped_blocks;
 	sector_t phys, last_block;
@@ -170,7 +170,7 @@ static inline int __fat_get_block(struct inode *inode, sector_t iblock,
 static int fat_get_block(struct inode *inode, sector_t iblock,
 			 struct buffer_head *bh_result, int create)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 	int err;
 
@@ -283,7 +283,7 @@ static ssize_t fat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 static int fat_get_block_bmap(struct inode *inode, sector_t iblock,
 		struct buffer_head *bh_result, int create)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned long max_blocks = bh_result->b_size >> inode->i_blkbits;
 	int err;
 	sector_t bmap;
@@ -391,7 +391,7 @@ static void dir_hash_init(struct super_block *sb)
 
 void fat_attach(struct inode *inode, loff_t i_pos)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 
 	if (inode->i_ino != MSDOS_ROOT_INO) {
 		struct hlist_head *head =   sbi->inode_hashtable
@@ -420,7 +420,7 @@ EXPORT_SYMBOL_GPL(fat_attach);
 
 void fat_detach(struct inode *inode)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	spin_lock(&sbi->inode_hash_lock);
 	MSDOS_I(inode)->i_pos = 0;
 	hlist_del_init(&MSDOS_I(inode)->i_fat_hash);
@@ -443,7 +443,7 @@ struct inode *fat_iget(struct super_block *sb, loff_t i_pos)
 
 	spin_lock(&sbi->inode_hash_lock);
 	hlist_for_each_entry(i, head, i_fat_hash) {
-		BUG_ON(i->vfs_inode.i_sb != sb);
+		BUG_ON(inode_sb(&i->vfs_inode) != sb);
 		if (i->i_pos != i_pos)
 			continue;
 		inode = igrab(&i->vfs_inode);
@@ -466,7 +466,7 @@ static int is_exec(unsigned char *extension)
 
 static int fat_calc_dir_size(struct inode *inode)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	int ret, fclus, dclus;
 
 	inode->i_size = 0;
@@ -483,7 +483,7 @@ static int fat_calc_dir_size(struct inode *inode)
 
 static int fat_validate_dir(struct inode *dir)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 
 	if (dir->i_nlink < 2) {
 		/* Directory should have "."/".." entries at least. */
@@ -502,7 +502,7 @@ static int fat_validate_dir(struct inode *dir)
 /* doesn't deal with root inode */
 int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	int error;
 
 	MSDOS_I(inode)->i_pos = 0;
@@ -614,7 +614,7 @@ static void fat_free_eofblocks(struct inode *inode)
 	/* Release unwritten fallocated blocks on inode eviction. */
 	if ((inode->i_blocks << 9) >
 			round_up(MSDOS_I(inode)->mmu_private,
-				MSDOS_SB(inode->i_sb)->cluster_size)) {
+				MSDOS_SB(inode_sb(inode))->cluster_size)) {
 		int err;
 
 		fat_truncate_blocks(inode, MSDOS_I(inode)->mmu_private);
@@ -626,7 +626,7 @@ static void fat_free_eofblocks(struct inode *inode)
 		 */
 		err = __fat_write_inode(inode, inode_needs_sync(inode));
 		if (err) {
-			fat_msg(inode->i_sb, KERN_WARNING, "Failed to "
+			fat_msg(inode_sb(inode), KERN_WARNING, "Failed to "
 					"update on disk inode for unused "
 					"fallocated blocks, inode could be "
 					"corrupted. Please run fsck");
@@ -825,7 +825,7 @@ static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int __fat_write_inode(struct inode *inode, int wait)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct msdos_dir_entry *raw_entry;
@@ -885,7 +885,7 @@ static int fat_write_inode(struct inode *inode, struct writeback_control *wbc)
 	int err;
 
 	if (inode->i_ino == MSDOS_FSINFO_INO) {
-		struct super_block *sb = inode->i_sb;
+		struct super_block *sb = inode_sb(inode);
 
 		mutex_lock(&MSDOS_SB(sb)->s_lock);
 		err = fat_clusters_flush(sb);
@@ -1372,7 +1372,7 @@ static void fat_dummy_inode_init(struct inode *inode)
 
 static int fat_read_root(struct inode *inode)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	int error;
 
 	MSDOS_I(inode)->i_pos = MSDOS_ROOT_INO;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index f9bdc1e01c98..1fb76fac6d41 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -98,7 +98,7 @@ int fat_clusters_flush(struct super_block *sb)
  */
 int fat_chain_add(struct inode *inode, int new_dclus, int nr_cluster)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	int ret, new_fclus, last;
 
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 582ca731a6c9..b26d3be72b02 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -118,7 +118,7 @@ static int msdos_format_name(const unsigned char *name, int len,
 static int msdos_find(struct inode *dir, const unsigned char *name, int len,
 		      struct fat_slot_info *sinfo)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(dir));
 	unsigned char msdos_name[MSDOS_NAME];
 	int err;
 
@@ -200,7 +200,7 @@ static const struct dentry_operations msdos_dentry_operations = {
 static struct dentry *msdos_lookup(struct inode *dir, struct dentry *dentry,
 				   unsigned int flags)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct fat_slot_info sinfo;
 	struct inode *inode;
 	int err;
@@ -227,7 +227,7 @@ static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 			   int is_dir, int is_hid, int cluster,
 			   struct timespec *ts, struct fat_slot_info *sinfo)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(dir));
 	struct msdos_dir_entry de;
 	__le16 time, date;
 	int err;
@@ -263,7 +263,7 @@ static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 static int msdos_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 			bool excl)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct inode *inode = NULL;
 	struct fat_slot_info sinfo;
 	struct timespec ts;
@@ -308,7 +308,7 @@ static int msdos_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 /***** Remove a directory */
 static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct inode *inode = d_inode(dentry);
 	struct fat_slot_info sinfo;
 	int err;
@@ -344,7 +344,7 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 /***** Make a directory */
 static int msdos_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct fat_slot_info sinfo;
 	struct inode *inode;
 	unsigned char msdos_name[MSDOS_NAME];
@@ -404,7 +404,7 @@ static int msdos_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 static int msdos_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct fat_slot_info sinfo;
 	int err;
 
@@ -588,7 +588,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 		sinfo.bh = NULL;
 	}
 	if (corrupt < 0) {
-		fat_fs_error(new_dir->i_sb,
+		fat_fs_error(inode_sb(new_dir),
 			     "%s: Filesystem corrupted (i_pos %lld)",
 			     __func__, sinfo.i_pos);
 	}
@@ -600,7 +600,7 @@ static int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
-	struct super_block *sb = old_dir->i_sb;
+	struct super_block *sb = inode_sb(old_dir);
 	unsigned char old_msdos_name[MSDOS_NAME], new_msdos_name[MSDOS_NAME];
 	int err, is_hid;
 
@@ -611,12 +611,12 @@ static int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	err = msdos_format_name(old_dentry->d_name.name,
 				old_dentry->d_name.len, old_msdos_name,
-				&MSDOS_SB(old_dir->i_sb)->options);
+				&MSDOS_SB(inode_sb(old_dir))->options);
 	if (err)
 		goto out;
 	err = msdos_format_name(new_dentry->d_name.name,
 				new_dentry->d_name.len, new_msdos_name,
-				&MSDOS_SB(new_dir->i_sb)->options);
+				&MSDOS_SB(inode_sb(new_dir))->options);
 	if (err)
 		goto out;
 
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 2649759c478a..5113f6703339 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -327,7 +327,7 @@ static int vfat_create_shortname(struct inode *dir, struct nls_table *nls,
 				 wchar_t *uname, int ulen,
 				 unsigned char *name_res, unsigned char *lcase)
 {
-	struct fat_mount_options *opts = &MSDOS_SB(dir->i_sb)->options;
+	struct fat_mount_options *opts = &MSDOS_SB(inode_sb(dir))->options;
 	wchar_t *ip, *ext_start, *end, *name_start;
 	unsigned char base[9], ext[4], buf[5], *p;
 	unsigned char charbuf[NLS_MAX_CHARSET_SIZE];
@@ -580,7 +580,7 @@ static int vfat_build_slots(struct inode *dir, const unsigned char *name,
 			    struct timespec *ts,
 			    struct msdos_dir_slot *slots, int *nr_slots)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(dir->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(dir));
 	struct fat_mount_options *opts = &sbi->options;
 	struct msdos_dir_slot *ps;
 	struct msdos_dir_entry *de;
@@ -709,7 +709,7 @@ static int vfat_d_anon_disconn(struct dentry *dentry)
 static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
 				  unsigned int flags)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct fat_slot_info sinfo;
 	struct inode *inode;
 	struct dentry *alias;
@@ -769,7 +769,7 @@ static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
 static int vfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		       bool excl)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct inode *inode;
 	struct fat_slot_info sinfo;
 	struct timespec ts;
@@ -802,7 +802,7 @@ static int vfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct fat_slot_info sinfo;
 	int err;
 
@@ -833,7 +833,7 @@ static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct fat_slot_info sinfo;
 	int err;
 
@@ -858,7 +858,7 @@ static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 
 static int vfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct inode *inode;
 	struct fat_slot_info sinfo;
 	struct timespec ts;
@@ -913,7 +913,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct timespec ts;
 	loff_t new_i_pos;
 	int err, is_dir, update_dotdot, corrupt = 0;
-	struct super_block *sb = old_dir->i_sb;
+	struct super_block *sb = inode_sb(old_dir);
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -1027,7 +1027,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
 		sinfo.bh = NULL;
 	}
 	if (corrupt < 0) {
-		fat_fs_error(new_dir->i_sb,
+		fat_fs_error(inode_sb(new_dir),
 			     "%s: Filesystem corrupted (i_pos %lld)",
 			     __func__, sinfo.i_pos);
 	}
diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index eb192656fba2..67f34ed8aeeb 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -39,7 +39,7 @@ static struct inode *fat_dget(struct super_block *sb, int i_logstart)
 	head = sbi->dir_hashtable + fat_dir_hash(i_logstart);
 	spin_lock(&sbi->dir_hash_lock);
 	hlist_for_each_entry(i, head, i_dir_hash) {
-		BUG_ON(i->vfs_inode.i_sb != sb);
+		BUG_ON(inode_sb(&i->vfs_inode) != sb);
 		if (i->i_logstart != i_logstart)
 			continue;
 		inode = igrab(&i->vfs_inode);
@@ -110,7 +110,7 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
 		      struct inode *parent)
 {
 	int len = *lenp;
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(inode_sb(inode));
 	struct fat_fid *fid = (struct fat_fid *) fh;
 	loff_t i_pos;
 	int type = FILEID_FAT_WITHOUT_PARENT;
-- 
2.15.1
