Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3904782-1526646874-2-2531411556934730022
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526646873; b=DP3qhMOhHZ7Z/NqEXdoCBXy0KxbLJsp1Mi7iJBmmHid2Y/6QcH
    RnvtfkQdk+CQcbMI3fjzPTsFol0NcXDsAX1B1bawrDhz1yxyHdyIzp6Of2gUwqJJ
    1jqu8GfXAKYRagkdulOsmx4eV9Vi9yLFI9VZ7OUptofunCUnuHfss7vgH3vKU+iB
    484SiZwEiR3dLOBqpHklyq/608D1W+RQHgGhPihufllt9b2LqmEDK0uFeFT1Em3x
    dY20XiETmU6YgPxW4mMCJjF8iUdKmgl1khST4KwspthqGOMk0+jaq7vcRpa6Shh5
    eBS69Q8yge4SUf7UL/q20cHv+H4wOWufe6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526646873; bh=
    OfdE/jV1mUnv+86dCxI15WjPeIpag6nZDWvRDbk+90c=; b=YUENQWD+pmcOqbwW
    4Kfk1RGFJbMo9Kq3ObeXzCd9IDnACK3bOMICnybREyYwWNezx71GW0yz1fJgejyY
    aqBPZliLnBFIUWVx/w0wevSDN/jrne0wHgz8PPjRrukHx+6cFPhY5K/Wu3fwWjBq
    Ut/wfgOjXjkrfKF/RNkUbeJE7Sszp8yInxi4Iky9bV4t+RbzlN4JgWl931hR0QAu
    qRj+vKcK1R3qMJRt4H+TgFny/JD4/2g2QBKg7qz0YrXO9CjfCsV59GWL3QoJp3vB
    d1pXm7FdfEyN3PcxMSItbBLg2Pecr37Xvb7WeWBcisijnDzeelhQgmXCjHyp6oEB
    gJhzVA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Rgm0RJwO x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Rgm0RJwO x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCoCe2Ovpio5bbcwnP8XyRBlmW7AC4cdPqdX2s87Mqa6qcvAO6rjaXMsCn4nNz8yRLsBpJxW/MiaNC4YkKd4rj/OX2Hqwim/4Q5kGOVKegZdygrrFNrE
    x6jGhykNnOCHHvjVC4SqPs1gUZzDB0RbVhFDt64SvN00eXi6T0q7+8+hPEWITTBnujHbwkcfw3UgoTiemRVGtsN+UtBJ7C+YqUsXriM7xFH1EuAtV9krMJ0H
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=57RXW_pN80FEwjSzi5oA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeERMe3 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 08:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbeERMeV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:21 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 03/11] vfs: add an errseq_t pointer to sync_filesystem
Date: Fri, 18 May 2018 08:34:07 -0400
Message-Id: <20180518123415.28181-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

Allow sync_filesystem to take an errseq_t for the purposes of error
reporting. This value is just passed directly to the ->sync_fs op.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 drivers/staging/ncpfs/inode.c | 2 +-
 fs/adfs/super.c               | 2 +-
 fs/affs/super.c               | 2 +-
 fs/befs/linuxvfs.c            | 2 +-
 fs/block_dev.c                | 2 +-
 fs/btrfs/super.c              | 4 ++--
 fs/cachefiles/interface.c     | 2 +-
 fs/cifs/cifsfs.c              | 2 +-
 fs/coda/inode.c               | 2 +-
 fs/cramfs/inode.c             | 2 +-
 fs/debugfs/inode.c            | 2 +-
 fs/efs/super.c                | 2 +-
 fs/ext2/super.c               | 2 +-
 fs/ext4/super.c               | 4 ++--
 fs/fat/inode.c                | 2 +-
 fs/freevxfs/vxfs_super.c      | 2 +-
 fs/fuse/inode.c               | 2 +-
 fs/gfs2/super.c               | 2 +-
 fs/hfs/super.c                | 2 +-
 fs/hfsplus/super.c            | 2 +-
 fs/hpfs/super.c               | 2 +-
 fs/isofs/inode.c              | 2 +-
 fs/jffs2/super.c              | 2 +-
 fs/jfs/super.c                | 2 +-
 fs/minix/inode.c              | 2 +-
 fs/nfs/super.c                | 2 +-
 fs/nilfs2/super.c             | 2 +-
 fs/ntfs/super.c               | 2 +-
 fs/ocfs2/super.c              | 2 +-
 fs/openpromfs/inode.c         | 2 +-
 fs/overlayfs/super.c          | 2 +-
 fs/proc/root.c                | 2 +-
 fs/pstore/inode.c             | 2 +-
 fs/qnx4/inode.c               | 2 +-
 fs/qnx6/inode.c               | 2 +-
 fs/quota/dquot.c              | 2 +-
 fs/reiserfs/super.c           | 2 +-
 fs/romfs/super.c              | 2 +-
 fs/squashfs/super.c           | 2 +-
 fs/super.c                    | 4 ++--
 fs/sync.c                     | 4 ++--
 fs/sysv/inode.c               | 2 +-
 fs/tracefs/inode.c            | 2 +-
 fs/ubifs/super.c              | 2 +-
 fs/udf/super.c                | 2 +-
 fs/ufs/super.c                | 2 +-
 fs/xfs/xfs_super.c            | 2 +-
 include/linux/fs.h            | 2 +-
 48 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/ncpfs/inode.c b/drivers/staging/ncpfs/inode.c
index bb411610a071..1ba23c4b8ddd 100644
--- a/drivers/staging/ncpfs/inode.c
+++ b/drivers/staging/ncpfs/inode.c
@@ -103,7 +103,7 @@ static void destroy_inodecache(void)
 
 static int ncp_remount(struct super_block *sb, int *flags, char* data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_NODIRATIME;
 	return 0;
 }
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index cfda2c7caedc..695cf6413612 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -212,7 +212,7 @@ static int parse_options(struct super_block *sb, char *options)
 
 static int adfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_NODIRATIME;
 	return parse_options(sb, data);
 }
diff --git a/fs/affs/super.c b/fs/affs/super.c
index b85a10a930b4..bee2cdbd942c 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -570,7 +570,7 @@ affs_remount(struct super_block *sb, int *flags, char *data)
 
 	pr_debug("%s(flags=0x%x,opts=\"%s\")\n", __func__, *flags, data);
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_NODIRATIME;
 
 	memcpy(volume, sbi->s_volume, 32);
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index af2832aaeec5..ffa63673f883 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -951,7 +951,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 static int
 befs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	if (!(*flags & SB_RDONLY))
 		return -EINVAL;
 	return 0;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8f1d13a3f02b..46fd96344d08 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -468,7 +468,7 @@ int fsync_bdev(struct block_device *bdev)
 {
 	struct super_block *sb = get_super(bdev);
 	if (sb) {
-		int res = sync_filesystem(sb);
+		int res = sync_filesystem(sb, NULL);
 		drop_super(sb);
 		return res;
 	}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4a404c07acee..4b3e6676be9d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1732,7 +1732,7 @@ static inline void btrfs_remount_begin(struct btrfs_fs_info *fs_info,
 		wait_event(fs_info->transaction_wait,
 			   (atomic_read(&fs_info->defrag_running) == 0));
 		if (flags & SB_RDONLY)
-			sync_filesystem(fs_info->sb);
+			sync_filesystem(fs_info->sb, NULL);
 	}
 }
 
@@ -1763,7 +1763,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	u32 old_metadata_ratio = fs_info->metadata_ratio;
 	int ret;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	btrfs_remount_prepare(fs_info);
 
 	if (data) {
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 222bc5d8b62c..777468fe8afd 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -391,7 +391,7 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
 	 * written to disc */
 	cachefiles_begin_secure(cache, &saved_cred);
 	down_read(&cache->mnt->mnt_sb->s_umount);
-	ret = sync_filesystem(cache->mnt->mnt_sb);
+	ret = sync_filesystem(cache->mnt->mnt_sb, NULL);
 	up_read(&cache->mnt->mnt_sb->s_umount);
 	cachefiles_end_secure(cache, saved_cred);
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 5a5a0158cc8f..82a4d2f5f4ed 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -574,7 +574,7 @@ static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 
 static int cifs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_NODIRATIME;
 	return 0;
 }
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 97424cf206c0..4c5a87b1ac05 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -95,7 +95,7 @@ void coda_destroy_inodecache(void)
 
 static int coda_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_NOATIME;
 	return 0;
 }
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 017b0ab19bc4..a9ad8f459bbd 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -504,7 +504,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 
 static int cramfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_RDONLY;
 	return 0;
 }
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 13b01351dd1c..129af6748d94 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -135,7 +135,7 @@ static int debugfs_remount(struct super_block *sb, int *flags, char *data)
 	int err;
 	struct debugfs_fs_info *fsi = sb->s_fs_info;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	err = debugfs_parse_options(data, &fsi->mount_opts);
 	if (err)
 		goto fail;
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 6ffb7ba1547a..d558914da832 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -115,7 +115,7 @@ static void destroy_inodecache(void)
 
 static int efs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_RDONLY;
 	return 0;
 }
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 0366897bf02e..0700f3264c7e 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1326,7 +1326,7 @@ static int ext2_remount (struct super_block * sb, int * flags, char * data)
 	struct ext2_mount_options new_opts;
 	int err;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 
 	spin_lock(&sbi->s_lock);
 	new_opts.s_mount_opt = sbi->s_mount_opt;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e2b4956969b8..896ddf8c3421 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5094,7 +5094,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		}
 
 		if (*flags & SB_RDONLY) {
-			err = sync_filesystem(sb);
+			err = sync_filesystem(sb, NULL);
 			if (err < 0)
 				goto restore_opts;
 			err = dquot_suspend(sb, -1);
@@ -5590,7 +5590,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	/* Force all delayed allocation blocks to be allocated.
 	 * Caller already holds s_umount sem */
 	if (test_opt(sb, DELALLOC))
-		sync_filesystem(sb);
+		sync_filesystem(sb, NULL);
 
 	if (!inode || !igrab(inode))
 		goto out;
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index ffbbf0520d9e..1fd6b8516523 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -784,7 +784,7 @@ static int fat_remount(struct super_block *sb, int *flags, char *data)
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	*flags |= SB_NODIRATIME | (sbi->options.isvfat ? 0 : SB_NOATIME);
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 
 	/* make sure we update state on remount. */
 	new_rdonly = *flags & SB_RDONLY;
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index 48b24bb50d02..11362c61408a 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -115,7 +115,7 @@ vxfs_statfs(struct dentry *dentry, struct kstatfs *bufp)
 
 static int vxfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_RDONLY;
 	return 0;
 }
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ef309958e060..44c391b74008 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -140,7 +140,7 @@ static void fuse_evict_inode(struct inode *inode)
 
 static int fuse_remount_fs(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	if (*flags & SB_MANDLOCK)
 		return -EINVAL;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index f5a9f2fe7d7a..d65621c8580e 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1241,7 +1241,7 @@ static int gfs2_remount_fs(struct super_block *sb, int *flags, char *data)
 	struct gfs2_tune *gt = &sdp->sd_tune;
 	int error;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 
 	spin_lock(&gt->gt_spin);
 	args.ar_commit = gt->gt_logd_secs;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index f8c9b745e33f..cdfee76200b6 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -113,7 +113,7 @@ static int hfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int hfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_NODIRATIME;
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 93f0e96527cf..87952852bba2 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -328,7 +328,7 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int hfsplus_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
 	if (!(*flags & SB_RDONLY)) {
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index f2c3ebcd309c..0db5184a5635 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -454,7 +454,7 @@ static int hpfs_remount_fs(struct super_block *s, int *flags, char *data)
 	int o;
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
 
-	sync_filesystem(s);
+	sync_filesystem(s, NULL);
 
 	*flags |= SB_NOATIME;
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index ec3fba7d492f..941f481aeb13 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -113,7 +113,7 @@ static void destroy_inodecache(void)
 
 static int isofs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	if (!(*flags & SB_RDONLY))
 		return -EROFS;
 	return 0;
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index ce773153c1a0..bf438c3538c5 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -243,7 +243,7 @@ static int jffs2_remount_fs(struct super_block *sb, int *flags, char *data)
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 	int err;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	err = jffs2_parse_options(c, data);
 	if (err)
 		return -EINVAL;
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 722b786731d6..4c071086bde3 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -463,7 +463,7 @@ static int jfs_remount(struct super_block *sb, int *flags, char *data)
 	int flag = JFS_SBI(sb)->flag;
 	int ret;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	if (!parse_options(data, sb, &newLVSize, &flag))
 		return -EINVAL;
 
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 72e308c3e66b..286022e07afd 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -123,7 +123,7 @@ static int minix_remount (struct super_block * sb, int * flags, char * data)
 	struct minix_sb_info * sbi = minix_sb(sb);
 	struct minix_super_block * ms;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	ms = sbi->s_ms;
 	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
 		return 0;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 5e470e233c83..02985cde5ff9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2252,7 +2252,7 @@ nfs_remount(struct super_block *sb, int *flags, char *raw_data)
 	struct nfs4_mount_data *options4 = (struct nfs4_mount_data *)raw_data;
 	u32 nfsvers = nfss->nfs_client->rpc_ops->version;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 
 	/*
 	 * Userspace mount programs that send binary options generally send
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 4588ca0c7589..7d7bf435996d 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1126,7 +1126,7 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
 	unsigned long old_mount_opt;
 	int err;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	old_sb_flags = sb->s_flags;
 	old_mount_opt = nilfs->ns_mount_opt;
 
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index bb7159f697f2..64ce51f19aa2 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -469,7 +469,7 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *opt)
 
 	ntfs_debug("Entering with remount options string: %s", opt);
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 
 #ifndef NTFS_RW
 	/* For read-only compiled driver, enforce read-only flag. */
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 5eac259e3899..1e58bff8655b 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -641,7 +641,7 @@ static int ocfs2_remount(struct super_block *sb, int *flags, char *data)
 	struct ocfs2_super *osb = OCFS2_SB(sb);
 	u32 tmp;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 
 	if (!ocfs2_parse_options(sb, data, &parsed_options, 1) ||
 	    !ocfs2_check_set_options(sb, &parsed_options)) {
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 2200662a9bf1..e9ec9d24535a 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -368,7 +368,7 @@ static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 
 static int openprom_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_NOATIME;
 	return 0;
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f660e0e8430d..bc8e0c403fbf 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -289,7 +289,7 @@ static int ovl_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 	upper_sb = ofs->upper_mnt->mnt_sb;
 
 	down_read(&upper_sb->s_umount);
-	ret = sync_filesystem(upper_sb);
+	ret = sync_filesystem(upper_sb, NULL);
 	up_read(&upper_sb->s_umount);
 
 	return ret;
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 61b7340b357a..e9f7608d9b9b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -82,7 +82,7 @@ int proc_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct pid_namespace *pid = sb->s_fs_info;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	return !proc_parse_options(data, pid);
 }
 
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..617562d45614 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -273,7 +273,7 @@ static int pstore_show_options(struct seq_file *m, struct dentry *root)
 
 static int pstore_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	parse_options(data);
 
 	return 0;
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3d46fe302fcb..94028eccaa15 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -44,7 +44,7 @@ static int qnx4_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct qnx4_sb_info *qs;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	qs = qnx4_sb(sb);
 	qs->Version = QNX4_VERSION;
 	*flags |= SB_RDONLY;
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 4aeb26bcb4d0..1c1c31d780c6 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -55,7 +55,7 @@ static int qnx6_show_options(struct seq_file *seq, struct dentry *root)
 
 static int qnx6_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_RDONLY;
 	return 0;
 }
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index e9cafa4766c5..f6f14d6d58c0 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2340,7 +2340,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 		 * the quota file since if blocksize < pagesize, invalidation
 		 * of the cache could fail because of other unrelated dirty
 		 * data */
-		sync_filesystem(sb);
+		sync_filesystem(sb, NULL);
 		invalidate_bdev(sb->s_bdev);
 	}
 
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 490f5bca544e..b1798819f650 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1454,7 +1454,7 @@ static int reiserfs_remount(struct super_block *s, int *mount_flags, char *arg)
 	if (arg && !new_opts)
 		return -ENOMEM;
 
-	sync_filesystem(s);
+	sync_filesystem(s, NULL);
 	reiserfs_write_lock(s);
 
 #ifdef CONFIG_QUOTA
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 8f06fd1f3d69..afe6d8fbd4bf 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -450,7 +450,7 @@ static int romfs_statfs(struct dentry *dentry, struct kstatfs *buf)
  */
 static int romfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_RDONLY;
 	return 0;
 }
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 8a73b97217c8..074734c26006 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -372,7 +372,7 @@ static int squashfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int squashfs_remount(struct super_block *sb, int *flags, char *data)
 {
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	*flags |= SB_RDONLY;
 	return 0;
 }
diff --git a/fs/super.c b/fs/super.c
index f16e3842faf7..4b4b56a501fd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -426,7 +426,7 @@ void generic_shutdown_super(struct super_block *sb)
 
 	if (sb->s_root) {
 		shrink_dcache_for_umount(sb);
-		sync_filesystem(sb);
+		sync_filesystem(sb, NULL);
 		sb->s_flags &= ~SB_ACTIVE;
 
 		fsnotify_unmount_inodes(sb);
@@ -1466,7 +1466,7 @@ int freeze_super(struct super_block *sb)
 	sb_wait_write(sb, SB_FREEZE_PAGEFAULT);
 
 	/* All writers are done so after syncing there won't be dirty data */
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 
 	/* Now wait for internal filesystem counter */
 	sb->s_writers.frozen = SB_FREEZE_FS;
diff --git a/fs/sync.c b/fs/sync.c
index b512c85bc9c5..fc0b7bd51ae6 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -43,7 +43,7 @@ static int __sync_filesystem(struct super_block *sb, int wait)
  * superblock.  Filesystem data as well as the underlying block
  * device.  Takes the superblock lock.
  */
-int sync_filesystem(struct super_block *sb)
+int sync_filesystem(struct super_block *sb, errseq_t *since)
 {
 	int ret;
 
@@ -169,7 +169,7 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 	sb = f.file->f_path.dentry->d_sb;
 
 	down_read(&sb->s_umount);
-	ret = sync_filesystem(sb);
+	ret = sync_filesystem(sb, NULL);
 	up_read(&sb->s_umount);
 
 	fdput(f);
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index f202f3d73772..6e166f65b03e 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -60,7 +60,7 @@ static int sysv_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	if (sbi->s_forced_ro)
 		*flags |= SB_RDONLY;
 	return 0;
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bea8ad876bf9..d70303524079 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -230,7 +230,7 @@ static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 	int err;
 	struct tracefs_fs_info *fsi = sb->s_fs_info;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	err = tracefs_parse_options(data, &fsi->mount_opts);
 	if (err)
 		goto fail;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 4faaf6f9fdbc..b797158931a7 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1847,7 +1847,7 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
 	int err;
 	struct ubifs_info *c = sb->s_fs_info;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	dbg_gen("old flags %#lx, new flags %#x", sb->s_flags, *flags);
 
 	err = ubifs_parse_options(c, data, 1);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 12cdc9d5acf0..761962ddc245 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -617,7 +617,7 @@ static int udf_remount_fs(struct super_block *sb, int *flags, char *options)
 	int error = 0;
 	struct logicalVolIntegrityDescImpUse *lvidiu = udf_sb_lvidiu(sb);
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	if (lvidiu) {
 		int write_rev = le16_to_cpu(lvidiu->minUDFWriteRev);
 		if (write_rev > UDF_MAX_WRITE_VERSION && !(*flags & SB_RDONLY))
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index e3f26b566f11..ac2d4d271826 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1303,7 +1303,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 	unsigned new_mount_opt, ufstype;
 	unsigned flags;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	mutex_lock(&UFS_SB(sb)->s_lock);
 	uspi = UFS_SB(sb)->s_uspi;
 	flags = UFS_SB(sb)->s_flags;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1ce4b936c716..9255de2767b4 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1282,7 +1282,7 @@ xfs_fs_remount(
 	if (error)
 		return error;
 
-	sync_filesystem(sb);
+	sync_filesystem(sb, NULL);
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 258877074ff4..d40fe9ead5fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2491,7 +2491,7 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 	return false;
 }
 #endif
-extern int sync_filesystem(struct super_block *);
+extern int sync_filesystem(struct super_block *, errseq_t *);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
 
-- 
2.17.0
