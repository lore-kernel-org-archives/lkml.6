Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525682371-2-3129085855490392683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682370; b=C7hmJpkZO2DBa0Ny3mVSQKqzGwBZ/DxR3FontMY8sFSWk3onBv
    FnqONQ1JOXCD6EuZvLOwktl6CAOfd6f/DmC1JMSnrhMaUpnvWDN8IfV5vTEtg+by
    7fDikNnW3ZqE+OnoPccvuwuT7H2MYEPnl7QaxOQs8nA+evp/zOKbfM5PxCIFDlIa
    M0snNtZ3wNYZnu9FUcljg7nD5o4PKXYVVHtlcJZFDPXPjzRWG7kUhaoSycZUehSg
    1Lu53hNgCF7uIZtFzktFXanZLyk/DPR3ViiwIp0ErXWrepGczxJFA/y5XI1ofo2V
    QN2l6OVAEgytpl3JwUVws4Oxvo4fE+e8CHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682370; bh=
    s4Ud8sOADiukjyWinyA/R8mIBpmUJpjBZ3MpDbDsZ7U=; b=KkHmKGVMPYE5epnc
    lvyDNL/+9/+B1fAousMQCfSs81qkgxqizV0GLi4Q8WGemWmeaWpbqskb3FyDxaWR
    DFnVIP8P4eh5vrqZLpbHVQSvsTJOXKunHRl+WVfZkxTaPCe4BHJgMVBrUYCv7a/Z
    2wxxmLmVlaxHskFtINnFg3p6sWHP8AGP86rbplPHgA6D0UXok7HJCB+RDicCB2a3
    vsvqQ9DNgXmFbQM4OC9w4MjodRQ+qyzzP9oPbdFQ0P7A8IXB1d605gPFvhZk5wHM
    MIcOaZvSFzMPnOIPIUJxQ0QG6de1mLnbtXdvU4QP43CJ28aRA7z+L5AJUNBCf6Me
    T63ing==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=eHHWrNcC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=eHHWrNcC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMLU/KOYjFe38A1D3LmfB+icXO72idQSViIKZNGnQnzM1l1ioLjrbdWE1W4C4lgz1mCVuQqKupQBEZkOlzY1a64ajzLX+zKApzEv36EZtTlMtiLFNt0j
    EGlVfifTsdBITxJXKQze8wbQQXrQ/ifEoaxisPms980rOWUR4rKza/MtJxEHe+W48NZrCHn2F4VlQNgZSD78ysksFGsldC7liaT4Vqzf/IXO9gc4dpT3DsAM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=dEXyzFMH45tXqPEXBbYA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeEGIj1 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:39:27 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46652 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeEGIiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:50 -0400
X-Google-Smtp-Source: AB8JxZrCUtEuWvOn3qviRESEJ2f96D7bG/h+KJDDUZ4CYL6Cy/2+P6c66HrEP6mXfht5EmXpQ1aqEQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 32/35] Partially revert "locks: fix file locking on overlayfs"
Date: Mon,  7 May 2018 10:38:04 +0200
Message-Id: <20180507083807.28792-33-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This partially reverts commit c568d68341be7030f5647def68851e469b21ca11.

Overlayfs files will now automatically get the correct locks, no need to
hack overlay support in VFS.

It is a partial revert, because it leaves the locks_inode() calls in place
and defines locks_inode() to file_inode().  We could revert those as well,
but it would be unnecessary code churn and it makes sense to document that
we are getting the inode for locking purposes.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/locks.c              | 17 ++++++-----------
 fs/overlayfs/super.c    |  2 +-
 include/linux/fs.h      | 13 +------------
 include/uapi/linux/fs.h |  1 -
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9c0e5f3da66c..40bcbaaa3f52 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -139,11 +139,6 @@
 #define IS_OFDLCK(fl)	(fl->fl_flags & FL_OFDLCK)
 #define IS_REMOTELCK(fl)	(fl->fl_pid <= 0)
 
-static inline bool is_remote_lock(struct file *filp)
-{
-	return likely(!(filp->f_path.dentry->d_sb->s_flags & SB_NOREMOTELOCK));
-}
-
 static bool lease_breaking(struct file_lock *fl)
 {
 	return fl->fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
@@ -1875,7 +1870,7 @@ EXPORT_SYMBOL(generic_setlease);
 int
 vfs_setlease(struct file *filp, long arg, struct file_lock **lease, void **priv)
 {
-	if (filp->f_op->setlease && is_remote_lock(filp))
+	if (filp->f_op->setlease)
 		return filp->f_op->setlease(filp, arg, lease, priv);
 	else
 		return generic_setlease(filp, arg, lease, priv);
@@ -2022,7 +2017,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 	if (error)
 		goto out_free;
 
-	if (f.file->f_op->flock && is_remote_lock(f.file))
+	if (f.file->f_op->flock)
 		error = f.file->f_op->flock(f.file,
 					  (can_sleep) ? F_SETLKW : F_SETLK,
 					  lock);
@@ -2048,7 +2043,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
-	if (filp->f_op->lock && is_remote_lock(filp))
+	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);
 	posix_test_lock(filp, fl);
 	return 0;
@@ -2191,7 +2186,7 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  */
 int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
 {
-	if (filp->f_op->lock && is_remote_lock(filp))
+	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, cmd, fl);
 	else
 		return posix_lock_file(filp, fl, conf);
@@ -2513,7 +2508,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 	if (list_empty(&flctx->flc_flock))
 		return;
 
-	if (filp->f_op->flock && is_remote_lock(filp))
+	if (filp->f_op->flock)
 		filp->f_op->flock(filp, F_SETLKW, &fl);
 	else
 		flock_lock_inode(inode, &fl);
@@ -2600,7 +2595,7 @@ EXPORT_SYMBOL(posix_unblock_lock);
  */
 int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
 {
-	if (filp->f_op->lock && is_remote_lock(filp))
+	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_CANCELLK, fl);
 	return 0;
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7779fc610767..f2a83fabe2eb 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1479,7 +1479,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &ovl_super_operations;
 	sb->s_xattr = ovl_xattr_handlers;
 	sb->s_fs_info = ofs;
-	sb->s_flags |= SB_POSIXACL | SB_NOREMOTELOCK;
+	sb->s_flags |= SB_POSIXACL;
 
 	err = -ENOMEM;
 	root_dentry = d_make_root(ovl_new_inode(sb, S_IFDIR, 0));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ba3078693d4a..417e692a606a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1050,17 +1050,7 @@ struct file_lock_context {
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);
 
-/*
- * Return the inode to use for locking
- *
- * For overlayfs this should be the overlay inode, not the real inode returned
- * by file_inode().  For any other fs file_inode(filp) and locks_inode(filp) are
- * equal.
- */
-static inline struct inode *locks_inode(const struct file *f)
-{
-	return f->f_path.dentry->d_inode;
-}
+#define locks_inode(f) file_inode(f)
 
 #ifdef CONFIG_FILE_LOCKING
 extern int fcntl_getlk(struct file *, unsigned int, struct flock *);
@@ -1300,7 +1290,6 @@ extern int send_sigurg(struct fown_struct *fown);
 
 /* These sb flags are internal to the kernel */
 #define SB_SUBMOUNT     (1<<26)
-#define SB_NOREMOTELOCK	(1<<27)
 #define SB_NOSEC	(1<<28)
 #define SB_BORN		(1<<29)
 #define SB_ACTIVE	(1<<30)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index d2a8313fabd7..2840ddcece73 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -134,7 +134,6 @@ struct inodes_stat_t {
 
 /* These sb flags are internal to the kernel */
 #define MS_SUBMOUNT     (1<<26)
-#define MS_NOREMOTELOCK	(1<<27)
 #define MS_NOSEC	(1<<28)
 #define MS_BORN		(1<<29)
 #define MS_ACTIVE	(1<<30)
-- 
2.14.3
