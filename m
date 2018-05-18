Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941126-1526647035-2-17205686007590789190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526647034; b=Y1Xh44RnYy8urxWqXKrkGKhwGB580zIb4Qymo5lDeriFxhF4NR
    +FcXKDo0VenKthmIV1bZ8jIc59eJUJtokktKtJKhF7el+bBs98v/nKt/8lVDbsFl
    Hj0Nb1SnoWwEHJc0ZpDCuTJVdnvUo2RUEg0HhGpwDZZWYQYUiySAseSVlSknWuSi
    l4jb7HdvA8qYb3nA1XlOq3nmbaJ29kDSaQF707nRD/Wx6YUeGHizCLIoQ5eFnmAh
    TyLF6KvenW9ejhaSWxzCt8/1fOQTsgVh74Armo71cTnN2CK/k/P06fDJckvr6unX
    TfaQJdn8Phl3dwJ1pR1ge0v0c5N/WJUmRQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526647034; bh=
    +NXVXB6zFjcAofY/QdxNaSNue2mr6tQQvjKqruQIDaU=; b=YYGqXbcOSJe3YYYG
    LUpxqMMIERxzw+k01VeXHvHdiBfxqcg4A1LB1havf2BBLgs7MnovytCnZwt5rPkC
    E+mzJkap+UJZl2+ATNY0au6tojVbevriZ+zeZpIeJzL7WNo1er8afo3H0go1IYnU
    sDIxqNM8tenzMgeuIe3Com9JDf9NdVr+uMKXTADhLtGZJFniZxrx3yn6Golvuigb
    Q7ZgMP5pQtJdrOJ6XL6ELVtXioYd42pD5A3pZmJ5oKZy3ZbMohNkesFvWaH/B0eG
    3J36Kw/C2pP2XZnUQcWniUhK9rU24Bsq4db8zCulsY9i0mXyB8/YQx8lnSp4F/3P
    EOEoNw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=d5A+rVkh x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=d5A+rVkh x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKkoTteH24ALnI2Mg3JmFC8xuKgkmxqJFGBJLk0eUOQHtRKGutPmxg+jlm0zKfGxh0zpvFeHA7MWi8vNGsRlJNXne9ywKTOUNQJI0Y5DdXilQqswZ+Rg
    h/F3TMldpTB+uatFT0st7x13x2oB8k4tN3Zn1ZvTY1U3PgmHACNylaHokOQOIb7P1VyEEJFaJGaDSMhAsI3Y1CA6rfXPncUEtCBZjkvriX1tnv8F8nFVbOoc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=PsGCS_Cs2QAk9rW7mWMA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeERMhL (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 08:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbeERMeT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:19 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 02/11] vfs: add a new errseq_t pointer to sync_fs prototype
Date: Fri, 18 May 2018 08:34:06 -0400
Message-Id: <20180518123415.28181-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518123415.28181-1-jlayton@kernel.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeff Layton <jlayton@redhat.com>

Plumb a new "since" pointer into the ->sync_fs operation. This will
eventually allow us to pass in an optional pointer to an errseq_t to
act as a cursor for error reporting.

For now it's ignored and all of the callers pass in NULL.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/affs/super.c      |  2 +-
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/ioctl.c     |  2 +-
 fs/btrfs/super.c     |  2 +-
 fs/ceph/super.c      |  2 +-
 fs/exofs/super.c     |  2 +-
 fs/ext2/super.c      |  8 ++++----
 fs/ext4/super.c      |  4 ++--
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/file.c       |  6 +++---
 fs/f2fs/namei.c      | 16 ++++++++--------
 fs/f2fs/segment.c    |  2 +-
 fs/f2fs/super.c      |  4 ++--
 fs/gfs2/super.c      |  2 +-
 fs/hfs/super.c       |  2 +-
 fs/hfsplus/super.c   |  8 ++++----
 fs/jffs2/super.c     |  2 +-
 fs/jfs/super.c       |  2 +-
 fs/nilfs2/super.c    |  2 +-
 fs/ocfs2/super.c     |  4 ++--
 fs/overlayfs/super.c |  2 +-
 fs/quota/dquot.c     |  4 ++--
 fs/reiserfs/super.c  |  4 ++--
 fs/sync.c            |  4 ++--
 fs/sysv/inode.c      |  2 +-
 fs/ubifs/super.c     |  2 +-
 fs/udf/super.c       |  4 ++--
 fs/ufs/super.c       |  4 ++--
 fs/xfs/xfs_super.c   |  3 ++-
 include/linux/fs.h   |  7 ++++---
 30 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index b76af8e3c87d..b85a10a930b4 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -55,7 +55,7 @@ affs_put_super(struct super_block *sb)
 }
 
 static int
-affs_sync_fs(struct super_block *sb, int wait)
+affs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	affs_commit_super(sb, wait);
 	return __sync_blockdev(sb->s_bdev, wait);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2771cc56a622..58f1058a9012 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3316,7 +3316,7 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
 /* super.c */
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
-int btrfs_sync_fs(struct super_block *sb, int wait);
+int btrfs_sync_fs(struct super_block *sb, int wait, errseq_t *since);
 
 static inline __printf(2, 3) __cold
 void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 632e26d6f7ce..ed3bfd89d8c9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5500,7 +5500,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		ret = btrfs_start_delalloc_roots(fs_info, 0, -1);
 		if (ret)
 			return ret;
-		ret = btrfs_sync_fs(inode->i_sb, 1);
+		ret = btrfs_sync_fs(inode->i_sb, 1, NULL);
 		/*
 		 * The transaction thread may want to do more work,
 		 * namely it pokes the cleaner kthread that will start
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0628092b0b1b..4a404c07acee 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1226,7 +1226,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	return err;
 }
 
-int btrfs_sync_fs(struct super_block *sb, int wait)
+int btrfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b33082e6878f..f8711d572743 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -103,7 +103,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 
 
-static int ceph_sync_fs(struct super_block *sb, int wait)
+static int ceph_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
 
diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index 179cd5c2f52a..2c40233f5dc7 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -364,7 +364,7 @@ static const struct export_operations exofs_export_ops;
 /*
  * Write the superblock to the OSD
  */
-static int exofs_sync_fs(struct super_block *sb, int wait)
+static int exofs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct exofs_sb_info *sbi;
 	struct exofs_fscb *fscb;
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index fd8536bc13da..0366897bf02e 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -41,7 +41,7 @@
 static void ext2_write_super(struct super_block *sb);
 static int ext2_remount (struct super_block * sb, int * flags, char * data);
 static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf);
-static int ext2_sync_fs(struct super_block *sb, int wait);
+static int ext2_sync_fs(struct super_block *sb, int wait, errseq_t *since);
 static int ext2_freeze(struct super_block *sb);
 static int ext2_unfreeze(struct super_block *sb);
 
@@ -1262,7 +1262,7 @@ void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es,
  * may have been checked while mounted and e2fsck may have
  * set s_state to EXT2_VALID_FS after some corrections.
  */
-static int ext2_sync_fs(struct super_block *sb, int wait)
+static int ext2_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
@@ -1293,7 +1293,7 @@ static int ext2_freeze(struct super_block *sb)
 	 * consistent.
 	 */
 	if (atomic_long_read(&sb->s_remove_count)) {
-		ext2_sync_fs(sb, 1);
+		ext2_sync_fs(sb, 1, NULL);
 		return 0;
 	}
 	/* Set EXT2_FS_VALID flag */
@@ -1316,7 +1316,7 @@ static int ext2_unfreeze(struct super_block *sb)
 static void ext2_write_super(struct super_block *sb)
 {
 	if (!sb_rdonly(sb))
-		ext2_sync_fs(sb, 1);
+		ext2_sync_fs(sb, 1, NULL);
 }
 
 static int ext2_remount (struct super_block * sb, int * flags, char * data)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ac2ffdbf54e6..e2b4956969b8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -69,7 +69,7 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
 					struct ext4_super_block *es);
 static void ext4_clear_journal_err(struct super_block *sb,
 				   struct ext4_super_block *es);
-static int ext4_sync_fs(struct super_block *sb, int wait);
+static int ext4_sync_fs(struct super_block *sb, int wait, errseq_t *since);
 static int ext4_remount(struct super_block *sb, int *flags, char *data);
 static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int ext4_unfreeze(struct super_block *sb);
@@ -4855,7 +4855,7 @@ int ext4_force_commit(struct super_block *sb)
 	return ext4_journal_force_commit(journal);
 }
 
-static int ext4_sync_fs(struct super_block *sb, int wait)
+static int ext4_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	int ret = 0, ret2;
 	tid_t target;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1df7f10476d6..9a4356a1f3d4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2703,7 +2703,7 @@ void f2fs_inode_synced(struct inode *inode);
 int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
 void f2fs_quota_off_umount(struct super_block *sb);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
-int f2fs_sync_fs(struct super_block *sb, int sync);
+int f2fs_sync_fs(struct super_block *sb, int sync, errseq_t *since);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
 int sanity_check_ckpt(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6b94f19b3fa8..a6c9e47b2729 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -260,7 +260,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	if (cp_reason) {
 		/* all the dirty node pages should be flushed for POR */
-		ret = f2fs_sync_fs(inode->i_sb, 1);
+		ret = f2fs_sync_fs(inode->i_sb, 1, NULL);
 
 		/*
 		 * We've secured consistency through sync_fs. Following pino
@@ -1869,7 +1869,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
-		ret = f2fs_sync_fs(sb, 1);
+		ret = f2fs_sync_fs(sb, 1, NULL);
 		if (ret)
 			goto out;
 		f2fs_stop_checkpoint(sbi, false);
@@ -2097,7 +2097,7 @@ static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	ret = f2fs_sync_fs(sbi->sb, 1);
+	ret = f2fs_sync_fs(sbi->sb, 1, NULL);
 
 	mnt_drop_write_file(filp);
 	return ret;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d5098efe577c..62a3082ca6b6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -298,7 +298,7 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	unlock_new_inode(inode);
 
 	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -345,7 +345,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	d_instantiate(dentry, inode);
 
 	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 	return 0;
 out:
 	clear_inode_flag(inode, FI_INC_LINK);
@@ -531,7 +531,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_unlock_op(sbi);
 
 	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 fail:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
@@ -614,7 +614,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 							disk_link.len - 1);
 
 		if (IS_DIRSYNC(dir))
-			f2fs_sync_fs(sbi->sb, 1);
+			f2fs_sync_fs(sbi->sb, 1, NULL);
 	} else {
 		f2fs_unlink(dir, dentry);
 	}
@@ -665,7 +665,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	unlock_new_inode(inode);
 
 	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -717,7 +717,7 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	unlock_new_inode(inode);
 
 	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -979,7 +979,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_unlock_op(sbi);
 
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 	return 0;
 
 put_out_dir:
@@ -1132,7 +1132,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_unlock_op(sbi);
 
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
-		f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 	return 0;
 out_new_dir:
 	if (new_dir_entry) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5854cc4e1d67..d49bb295e0c6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -507,7 +507,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			sync_dirty_inodes(sbi, FILE_INODE);
 			blk_finish_plug(&plug);
 		}
-		f2fs_sync_fs(sbi->sb, true);
+		f2fs_sync_fs(sbi->sb, 1, NULL);
 		stat_inc_bg_cp_count(sbi->stat_info);
 	}
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 70fb16aac0bd..f5f6dc90a700 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1055,7 +1055,7 @@ static void f2fs_put_super(struct super_block *sb)
 	kfree(sbi);
 }
 
-int f2fs_sync_fs(struct super_block *sb, int sync)
+int f2fs_sync_fs(struct super_block *sb, int sync, errseq_t *since)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int err = 0, err2;
@@ -1497,7 +1497,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		set_sbi_flag(sbi, SBI_IS_CLOSE);
-		f2fs_sync_fs(sb, 1);
+		f2fs_sync_fs(sb, 1, NULL);
 		clear_sbi_flag(sbi, SBI_IS_CLOSE);
 	}
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 884dd8b7d7b3..f5a9f2fe7d7a 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -949,7 +949,7 @@ static void gfs2_put_super(struct super_block *sb)
  * Flushes the log to disk.
  */
 
-static int gfs2_sync_fs(struct super_block *sb, int wait)
+static int gfs2_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	int bderr;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 9cb410ebab7c..f8c9b745e33f 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -30,7 +30,7 @@ static struct kmem_cache *hfs_inode_cachep;
 
 MODULE_LICENSE("GPL");
 
-static int hfs_sync_fs(struct super_block *sb, int wait)
+static int hfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	hfs_mdb_commit(sb);
 	return __sync_blockdev(sb->s_bdev, wait);
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 513c357c734b..93f0e96527cf 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -172,7 +172,7 @@ static void hfsplus_evict_inode(struct inode *inode)
 	}
 }
 
-static int hfsplus_sync_fs(struct super_block *sb, int wait)
+static int hfsplus_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_vh *vhdr = sbi->s_vhdr;
@@ -254,7 +254,7 @@ static void delayed_sync_fs(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
-	err = hfsplus_sync_fs(sbi->alloc_file->i_sb, 1);
+	err = hfsplus_sync_fs(sbi->alloc_file->i_sb, 1, NULL);
 	if (err)
 		pr_err("delayed sync fs err %d\n", err);
 }
@@ -291,7 +291,7 @@ static void hfsplus_put_super(struct super_block *sb)
 		vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_UNMNT);
 		vhdr->attributes &= cpu_to_be32(~HFSPLUS_VOL_INCNSTNT);
 
-		hfsplus_sync_fs(sb, 1);
+		hfsplus_sync_fs(sb, 1, NULL);
 	}
 
 	hfs_btree_close(sbi->attr_tree);
@@ -545,7 +545,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 		be32_add_cpu(&vhdr->write_count, 1);
 		vhdr->attributes &= cpu_to_be32(~HFSPLUS_VOL_UNMNT);
 		vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_INCNSTNT);
-		hfsplus_sync_fs(sb, 1);
+		hfsplus_sync_fs(sb, 1, NULL);
 
 		if (!sbi->hidden_dir) {
 			mutex_lock(&sbi->vh_mutex);
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 87bdf0f4cba1..ce773153c1a0 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -96,7 +96,7 @@ static int jffs2_show_options(struct seq_file *s, struct dentry *root)
 	return 0;
 }
 
-static int jffs2_sync_fs(struct super_block *sb, int wait)
+static int jffs2_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index c4b99ad53f9c..722b786731d6 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -703,7 +703,7 @@ static struct dentry *jfs_do_mount(struct file_system_type *fs_type,
 	return mount_bdev(fs_type, flags, dev_name, data, jfs_fill_super);
 }
 
-static int jfs_sync_fs(struct super_block *sb, int wait)
+static int jfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct jfs_log *log = JFS_SBI(sb)->log;
 
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 280a28b62d13..4588ca0c7589 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -491,7 +491,7 @@ static void nilfs_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
-static int nilfs_sync_fs(struct super_block *sb, int wait)
+static int nilfs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	struct nilfs_super_block **sbp;
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 07a1a297c2ed..5eac259e3899 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -115,7 +115,7 @@ static void ocfs2_delete_osb(struct ocfs2_super *osb);
 
 static int ocfs2_statfs(struct dentry *dentry, struct kstatfs *buf);
 
-static int ocfs2_sync_fs(struct super_block *sb, int wait);
+static int ocfs2_sync_fs(struct super_block *sb, int wait, errseq_t *since);
 
 static int ocfs2_init_global_system_inodes(struct ocfs2_super *osb);
 static int ocfs2_init_local_system_inodes(struct ocfs2_super *osb);
@@ -406,7 +406,7 @@ static const struct file_operations ocfs2_osb_debug_fops = {
 	.llseek =	generic_file_llseek,
 };
 
-static int ocfs2_sync_fs(struct super_block *sb, int wait)
+static int ocfs2_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	int status;
 	tid_t target;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e8551c97de51..f660e0e8430d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -266,7 +266,7 @@ static void ovl_put_super(struct super_block *sb)
 }
 
 /* Sync real dirty inodes in upper filesystem (if it exists) */
-static int ovl_sync_fs(struct super_block *sb, int wait)
+static int ovl_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 	struct super_block *upper_sb;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 96522760826c..e9cafa4766c5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -686,7 +686,7 @@ int dquot_quota_sync(struct super_block *sb, int type)
 	/* This is not very clever (and fast) but currently I don't know about
 	 * any other simple way of getting quota data to disk and we must get
 	 * them there for userspace to be visible... */
-	call_sync_fs(sb, 1);
+	call_sync_fs(sb, 1, NULL);
 
 	/*
 	 * Now when everything is written we can discard the pagecache so
@@ -2243,7 +2243,7 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 
 	/* Sync the superblock so that buffers with quota data are written to
 	 * disk (and so userspace sees correct data afterwards). */
-	call_sync_fs(sb, 1);
+	call_sync_fs(sb, 1, NULL);
 
 	/* Now the quota files are just ordinary files and we can set the
 	 * inode flags back. Moreover we discard the pagecache so that
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index b3a390eab9b7..490f5bca544e 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -64,7 +64,7 @@ static int is_any_reiserfs_magic_string(struct reiserfs_super_block *rs)
 static int reiserfs_remount(struct super_block *s, int *flags, char *data);
 static int reiserfs_statfs(struct dentry *dentry, struct kstatfs *buf);
 
-static int reiserfs_sync_fs(struct super_block *s, int wait)
+static int reiserfs_sync_fs(struct super_block *s, int wait, errseq_t *since)
 {
 	struct reiserfs_transaction_handle th;
 
@@ -108,7 +108,7 @@ static void flush_old_commits(struct work_struct *work)
 		sbi->work_queued = 0;
 	spin_unlock(&sbi->old_work_lock);
 
-	reiserfs_sync_fs(s, 1);
+	reiserfs_sync_fs(s, 1, NULL);
 	up_read(&s->s_umount);
 }
 
diff --git a/fs/sync.c b/fs/sync.c
index 44cdb38a8b67..b512c85bc9c5 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -35,7 +35,7 @@ static int __sync_filesystem(struct super_block *sb, int wait)
 	else
 		writeback_inodes_sb(sb, WB_REASON_SYNC);
 
-	return call_sync_fs(sb, wait);
+	return call_sync_fs(sb, wait, NULL);
 }
 
 /*
@@ -78,7 +78,7 @@ static void sync_fs_one_sb(struct super_block *sb, void *arg)
 
 	if (sb_rdonly(sb))
 		return;
-	call_sync_fs(sb, wait);
+	call_sync_fs(sb, wait, NULL);
 }
 
 static void fdatawrite_one_bdev(struct block_device *bdev, void *arg)
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 2232cf97840b..f202f3d73772 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -32,7 +32,7 @@
 #include <asm/byteorder.h>
 #include "sysv.h"
 
-static int sysv_sync_fs(struct super_block *sb, int wait)
+static int sysv_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct sysv_sb_info *sbi = SYSV_SB(sb);
 	unsigned long time = get_seconds(), old_time;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 6c397a389105..4faaf6f9fdbc 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -449,7 +449,7 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
 	return 0;
 }
 
-static int ubifs_sync_fs(struct super_block *sb, int wait)
+static int ubifs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	int i, err;
 	struct ubifs_info *c = sb->s_fs_info;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 7949c338efa5..12cdc9d5acf0 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -89,7 +89,7 @@ enum { UDF_MAX_LINKS = 0xffff };
 /* These are the "meat" - everything else is stuffing */
 static int udf_fill_super(struct super_block *, void *, int);
 static void udf_put_super(struct super_block *);
-static int udf_sync_fs(struct super_block *, int);
+static int udf_sync_fs(struct super_block *, int, errseq_t *);
 static int udf_remount_fs(struct super_block *, int *, char *);
 static void udf_load_logicalvolint(struct super_block *, struct kernel_extent_ad);
 static int udf_find_fileset(struct super_block *, struct kernel_lb_addr *,
@@ -2345,7 +2345,7 @@ static void udf_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
-static int udf_sync_fs(struct super_block *sb, int wait)
+static int udf_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
 
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 8254b8b3690f..e3f26b566f11 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -680,7 +680,7 @@ static void ufs_put_super_internal(struct super_block *sb)
 	UFSD("EXIT\n");
 }
 
-static int ufs_sync_fs(struct super_block *sb, int wait)
+static int ufs_sync_fs(struct super_block *sb, int wait, errseq_t *since)
 {
 	struct ufs_sb_private_info * uspi;
 	struct ufs_super_block_first * usb1;
@@ -720,7 +720,7 @@ static void delayed_sync_fs(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
-	ufs_sync_fs(sbi->sb, 1);
+	ufs_sync_fs(sbi->sb, 1, NULL);
 }
 
 void ufs_mark_sb_dirty(struct super_block *sb)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8683f8f2666f..1ce4b936c716 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1089,7 +1089,8 @@ xfs_free_fsname(
 STATIC int
 xfs_fs_sync_fs(
 	struct super_block	*sb,
-	int			wait)
+	int			wait,
+	errseq_t		*since)
 {
 	struct xfs_mount	*mp = XFS_M(sb);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 69b76f394954..258877074ff4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1821,7 +1821,7 @@ struct super_operations {
 	int (*drop_inode) (struct inode *);
 	void (*evict_inode) (struct inode *);
 	void (*put_super) (struct super_block *);
-	int (*sync_fs)(struct super_block *sb, int wait);
+	int (*sync_fs)(struct super_block *sb, int wait, errseq_t *since);
 	int (*freeze_super) (struct super_block *);
 	int (*freeze_fs) (struct super_block *);
 	int (*thaw_super) (struct super_block *);
@@ -2499,10 +2499,11 @@ extern const struct file_operations def_chr_fops;
  * Many legacy filesystems don't have a sync_fs op. For them, we just flush
  * the block device (if there is one).
  */
-static inline int call_sync_fs(struct super_block *sb, int wait)
+static inline int call_sync_fs(struct super_block *sb, int wait,
+			       errseq_t *since)
 {
 	if (sb->s_op->sync_fs)
-		return sb->s_op->sync_fs(sb, wait);
+		return sb->s_op->sync_fs(sb, wait, since);
 	return __sync_blockdev(sb->s_bdev, wait);
 }
 
-- 
2.17.0
