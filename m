Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F60ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A302147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="QckjxKf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A302147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeIRBkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:13 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37281 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeIRBkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:12 -0400
Received: by mail-qt0-f193.google.com with SMTP id n6-v6so16559083qtl.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvKjfTv9sMc8QW5mq8Q+c0HrTaKjbq1KCYmsG3HeV8c=;
        b=QckjxKf3Pypy7o1XkIF32bhi+Xa/SbU6Z1yQ0E2C/AoKFbkC5owCnCyhqyz3kxNEbc
         /UkMpgzn9VNUE6LYvFv1ouSXOeuRCgBjTlTc3r0JIFcg/9Z7QOjq9DDyzP1MNbji1b6c
         2qULXj/Y3k3LIeMbTbzHuBBX/NZI8sA4+ZlqRyZk9qHriDmRQibbw3sTm/vCGlsZk2yp
         v40S45YtYRoB/hlbLYsS6jMmeRK2C8F/k36v6QLCFUvUXDtU0a2GJX5lucFQD8eIv6YO
         XEOzZmvohupV3cyQIad8/DKffWvc/zCFa1FNNSVhocKmH8+oxMtrdGc9NTMyP8FCmFvy
         CD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvKjfTv9sMc8QW5mq8Q+c0HrTaKjbq1KCYmsG3HeV8c=;
        b=rhaD9eAzPH8wks/3kaMjhMWPx9+7t0iYy9c7gGD/FrAFbAzhCA9/w+U447dzCtV04W
         YVQFv1tsKdI7bW2L2PrTMwYAmMWSngCHd9cf83094SLUxyAa6UCyicK4RAml2XHGzv1i
         gkbCizyFcX6y/bZPHndX3UaOxpAnjXRm4J0ovE/21oK3dxG/HFDARfO064fvR61oktuM
         XPJaXV9T08c2pfMhWmP+LligE/QVTgptc2l7nZqpDKs+EP8ETE6eZfB+MGH635S/mtQv
         u8Du2mzOTFHjDWWO5P7e034Ee/Da5yQYwvawS0XGQ1PK4VqtJCanUQKKMSfcG2FmwtFB
         CPkA==
X-Gm-Message-State: APzg51CSDiNS55kjqU9YmdiPhiMbyY3QQd8J+zXVpicCy2g6J7ox6FPi
        UpEeAw5fqiw4D/hBW4wqHGWVyy0SPV28J3fc
X-Google-Smtp-Source: ANB0Vdb+bFirp312FYVuxbkcS1GVrZFHvf32UhE95CADYLuyk/ds1VysEQbZnnoJSJ0mmb8yh+wQQw==
X-Received: by 2002:ac8:764c:: with SMTP id i12-v6mr18196750qtr.250.1537215079483;
        Mon, 17 Sep 2018 13:11:19 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:18 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 08/17] orangefs: reorganize setattr functions to track attribute changes
Date:   Mon, 17 Sep 2018 20:10:45 +0000
Message-Id: <20180917201054.3530-9-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OrangeFS accepts a mask indicating which attributes were changed.  The
kernel must not set any bits except those that were actually changed.
The kernel must set the uid/gid of the request to the actual uid/gid
responsible for the change.

Code path for notify_change initiated setattrs is

orangefs_setattr(dentry, iattr)
-> __orangefs_setattr(inode, iattr)

In kernel changes are initiated by calling __orangefs_setattr.

Code path for writeback is

orangefs_write_inode
-> orangefs_inode_setattr

attr_valid and attr_uid and attr_gid change together under i_lock.
I_DIRTY changes separately.

__orangefs_setattr
	lock
	if needs to be cleaned first, unlock and retry
	set attr_valid
	copy data in
	unlock
	mark_inode_dirty

orangefs_inode_setattr
	lock
	copy attributes out
	unlock
	clear getattr_time
	# __writeback_single_inode clears dirty

orangefs_inode_getattr
	# possible to get here with attr_valid set and not dirty
	lock
	if getattr_time ok or attr_valid set, unlock and return
	unlock
	do server operation
	# another thread may getattr or setattr, so check for that
	lock
	if getattr_time ok or attr_valid, unlock and return
	else, copy in
	update getattr_time
	unlock

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/acl.c             |   4 +-
 fs/orangefs/inode.c           |  76 ++++++++++++++++++-----
 fs/orangefs/namei.c           |  36 +++++------
 fs/orangefs/orangefs-kernel.h |   8 ++-
 fs/orangefs/orangefs-utils.c  | 114 +++++++++++++---------------------
 fs/orangefs/super.c           |  11 +---
 6 files changed, 130 insertions(+), 119 deletions(-)

diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 10587413b20e..62e6ab78a915 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -142,7 +142,7 @@ int orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 			rc = __orangefs_set_acl(inode, acl, type);
 		} else {
 			iattr.ia_valid = ATTR_MODE;
-			rc = orangefs_inode_setattr(inode, &iattr);
+			rc = __orangefs_setattr(inode, &iattr);
 		}
 
 		return rc;
@@ -181,7 +181,7 @@ int orangefs_init_acl(struct inode *inode, struct inode *dir)
 		inode->i_mode = mode;
 		iattr.ia_mode = mode;
 		iattr.ia_valid |= ATTR_MODE;
-		orangefs_inode_setattr(inode, &iattr);
+		__orangefs_setattr(inode, &iattr);
 	}
 
 	return error;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index b16b11294573..cf0811ef0e93 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * (C) 2001 Clemson University and The University of Chicago
+ * Copyright 2018 Omnibond Systems, L.L.C.
  *
  * See COPYING in top-level directory.
  */
@@ -202,22 +203,31 @@ static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
 	return ret;
 }
 
-/*
- * Change attributes of an object referenced by dentry.
- */
-int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
+int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 {
-	struct inode *inode = dentry->d_inode;
 	int ret;
 
-	gossip_debug(GOSSIP_INODE_DEBUG,
-		"%s: called on %pd\n",
-		__func__,
-		dentry);
-
-	ret = setattr_prepare(dentry, iattr);
-	if (ret)
-		goto out;
+	if (iattr->ia_valid & ATTR_MODE) {
+		if (iattr->ia_mode & (S_ISVTX)) {
+			if (is_root_handle(inode)) {
+				/*
+				 * allow sticky bit to be set on root (since
+				 * it shows up that way by default anyhow),
+				 * but don't show it to the server
+				 */
+				iattr->ia_mode -= S_ISVTX;
+			} else {
+				gossip_debug(GOSSIP_UTILS_DEBUG,
+					     "User attempted to set sticky bit on non-root directory; returning EINVAL.\n");
+				return -EINVAL;
+			}
+		}
+		if (iattr->ia_mode & (S_ISUID)) {
+			gossip_debug(GOSSIP_UTILS_DEBUG,
+				     "Attempting to set setuid bit (not supported); returning EINVAL.\n");
+			return -EINVAL;
+		}
+	}
 
 	if (iattr->ia_valid & ATTR_SIZE) {
 		ret = orangefs_setattr_size(inode, iattr);
@@ -225,7 +235,24 @@ int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 			goto out;
 	}
 
+again:
+	spin_lock(&inode->i_lock);
+	if (ORANGEFS_I(inode)->attr_valid) {
+		if (uid_eq(ORANGEFS_I(inode)->attr_uid, current_fsuid()) &&
+		    gid_eq(ORANGEFS_I(inode)->attr_gid, current_fsgid())) {
+			ORANGEFS_I(inode)->attr_valid = iattr->ia_valid;
+		} else {
+			spin_unlock(&inode->i_lock);
+			write_inode_now(inode, 1);
+			goto again;
+		}
+	} else {
+		ORANGEFS_I(inode)->attr_valid = iattr->ia_valid;
+		ORANGEFS_I(inode)->attr_uid = current_fsuid();
+		ORANGEFS_I(inode)->attr_gid = current_fsgid();
+	}
 	setattr_copy(inode, iattr);
+	spin_unlock(&inode->i_lock);
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE)
@@ -234,7 +261,25 @@ int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	ret = 0;
 out:
-	gossip_debug(GOSSIP_INODE_DEBUG, "%s: ret:%d:\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Change attributes of an object referenced by dentry.
+ */
+int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
+{
+	int ret;
+	gossip_debug(GOSSIP_INODE_DEBUG, "__orangefs_setattr: called on %pd\n",
+	    dentry);
+	ret = setattr_prepare(dentry, iattr);
+	if (ret)
+	        goto out;
+	ret = __orangefs_setattr(d_inode(dentry), iattr);
+	sync_inode_metadata(d_inode(dentry), 1);
+out:
+	gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_setattr: returning %d\n",
+	    ret);
 	return ret;
 }
 
@@ -303,7 +348,7 @@ int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags
 		iattr.ia_valid |= ATTR_CTIME;
 	if (flags & S_MTIME)
 		iattr.ia_valid |= ATTR_MTIME;
-	return orangefs_inode_setattr(inode, &iattr);
+	return __orangefs_setattr(inode, &iattr);
 }
 
 /* ORANGEFS2 implementation of VFS inode operations for files */
@@ -363,6 +408,7 @@ static int orangefs_set_inode(struct inode *inode, void *data)
 	struct orangefs_object_kref *ref = (struct orangefs_object_kref *) data;
 	ORANGEFS_I(inode)->refn.fs_id = ref->fs_id;
 	ORANGEFS_I(inode)->refn.khandle = ref->khandle;
+	ORANGEFS_I(inode)->attr_valid = 0;
 	hash_init(ORANGEFS_I(inode)->xattr_cache);
 	return 0;
 }
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 7b82fc09291c..16e7f01e4c22 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -83,11 +83,10 @@ static int orangefs_create(struct inode *dir,
 		     __func__,
 		     dentry);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
 	memset(&iattr, 0, sizeof iattr);
-	iattr.ia_valid |= ATTR_MTIME;
-	orangefs_inode_setattr(dir, &iattr);
-	mark_inode_dirty_sync(dir);
+	iattr.ia_valid |= ATTR_MTIME | ATTR_CTIME;
+	iattr.ia_mtime = iattr.ia_ctime = current_time(dir);
+	__orangefs_setattr(dir, &iattr);
 	ret = 0;
 out:
 	gossip_debug(GOSSIP_NAME_DEBUG,
@@ -208,11 +207,11 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
 	if (!ret) {
 		drop_nlink(inode);
 
-		dir->i_mtime = dir->i_ctime = current_time(dir);
 		memset(&iattr, 0, sizeof iattr);
-		iattr.ia_valid |= ATTR_MTIME;
-		orangefs_inode_setattr(dir, &iattr);
-		mark_inode_dirty_sync(dir);
+		iattr.ia_valid |= ATTR_MTIME | ATTR_CTIME;
+		iattr.ia_mtime = iattr.ia_ctime = current_time(dir);
+		__orangefs_setattr(dir, &iattr);
+	ret = 0;
 	}
 	return ret;
 }
@@ -296,11 +295,10 @@ static int orangefs_symlink(struct inode *dir,
 		     get_khandle_from_ino(inode),
 		     dentry);
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
 	memset(&iattr, 0, sizeof iattr);
-	iattr.ia_valid |= ATTR_MTIME;
-	orangefs_inode_setattr(dir, &iattr);
-	mark_inode_dirty_sync(dir);
+	iattr.ia_valid |= ATTR_MTIME | ATTR_CTIME;
+	iattr.ia_mtime = iattr.ia_ctime = current_time(dir);
+	__orangefs_setattr(dir, &iattr);
 	ret = 0;
 out:
 	return ret;
@@ -367,11 +365,10 @@ static int orangefs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	 * NOTE: we have no good way to keep nlink consistent for directories
 	 * across clients; keep constant at 1.
 	 */
-	dir->i_mtime = dir->i_ctime = current_time(dir);
 	memset(&iattr, 0, sizeof iattr);
-	iattr.ia_valid |= ATTR_MTIME;
-	orangefs_inode_setattr(dir, &iattr);
-	mark_inode_dirty_sync(dir);
+	iattr.ia_valid |= ATTR_MTIME | ATTR_CTIME;
+	iattr.ia_mtime = iattr.ia_ctime = current_time(dir);
+	__orangefs_setattr(dir, &iattr);
 out:
 	return ret;
 }
@@ -393,11 +390,10 @@ static int orangefs_rename(struct inode *old_dir,
 		     "orangefs_rename: called (%pd2 => %pd2) ct=%d\n",
 		     old_dentry, new_dentry, d_count(new_dentry));
 
-	new_dir->i_mtime = new_dir->i_ctime = current_time(new_dir);
 	memset(&iattr, 0, sizeof iattr);
-	iattr.ia_valid |= ATTR_MTIME;
-	orangefs_inode_setattr(new_dir, &iattr);
-	mark_inode_dirty_sync(new_dir);
+	iattr.ia_valid |= ATTR_MTIME | ATTR_CTIME;
+	iattr.ia_mtime = iattr.ia_ctime = current_time(new_dir);
+	__orangefs_setattr(new_dir, &iattr);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_RENAME);
 	if (!new_op)
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 6b21ec59738c..9fe60d086e2d 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -192,6 +192,9 @@ struct orangefs_inode_s {
 	sector_t last_failed_block_index_read;
 
 	unsigned long getattr_time;
+	int attr_valid;
+	kuid_t attr_uid;
+	kgid_t attr_gid;
 
 	DECLARE_HASHTABLE(xattr_cache, 4);
 };
@@ -344,7 +347,8 @@ struct inode *orangefs_new_inode(struct super_block *sb,
 			      dev_t dev,
 			      struct orangefs_object_kref *ref);
 
-int orangefs_setattr(struct dentry *dentry, struct iattr *iattr);
+int __orangefs_setattr(struct inode *, struct iattr *);
+int orangefs_setattr(struct dentry *, struct iattr *);
 
 int orangefs_getattr(const struct path *path, struct kstat *stat,
 		     u32 request_mask, unsigned int flags);
@@ -402,7 +406,7 @@ int orangefs_inode_getattr(struct inode *, int);
 
 int orangefs_inode_check_changed(struct inode *inode);
 
-int orangefs_inode_setattr(struct inode *inode, struct iattr *iattr);
+int orangefs_inode_setattr(struct inode *inode);
 
 bool orangefs_cancel_op_in_progress(struct orangefs_kernel_op_s *op);
 
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index d44cbe96719a..a4fac527f85d 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -136,51 +136,37 @@ static int orangefs_inode_perms(struct ORANGEFS_sys_attr_s *attrs)
  * NOTE: in kernel land, we never use the sys_attr->link_target for
  * anything, so don't bother copying it into the sys_attr object here.
  */
-static inline int copy_attributes_from_inode(struct inode *inode,
-					     struct ORANGEFS_sys_attr_s *attrs,
-					     struct iattr *iattr)
+static inline void copy_attributes_from_inode(struct inode *inode,
+    struct ORANGEFS_sys_attr_s *attrs)
 {
-	umode_t tmp_mode;
-
-	if (!iattr || !inode || !attrs) {
-		gossip_err("NULL iattr (%p), inode (%p), attrs (%p) "
-			   "in copy_attributes_from_inode!\n",
-			   iattr,
-			   inode,
-			   attrs);
-		return -EINVAL;
-	}
-	/*
-	 * We need to be careful to only copy the attributes out of the
-	 * iattr object that we know are valid.
-	 */
+	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	attrs->mask = 0;
-	if (iattr->ia_valid & ATTR_UID) {
-		attrs->owner = from_kuid(&init_user_ns, iattr->ia_uid);
+	if (orangefs_inode->attr_valid & ATTR_UID) {
+		attrs->owner = from_kuid(&init_user_ns, inode->i_uid);
 		attrs->mask |= ORANGEFS_ATTR_SYS_UID;
 		gossip_debug(GOSSIP_UTILS_DEBUG, "(UID) %d\n", attrs->owner);
 	}
-	if (iattr->ia_valid & ATTR_GID) {
-		attrs->group = from_kgid(&init_user_ns, iattr->ia_gid);
+	if (orangefs_inode->attr_valid & ATTR_GID) {
+		attrs->group = from_kgid(&init_user_ns, inode->i_gid);
 		attrs->mask |= ORANGEFS_ATTR_SYS_GID;
 		gossip_debug(GOSSIP_UTILS_DEBUG, "(GID) %d\n", attrs->group);
 	}
 
-	if (iattr->ia_valid & ATTR_ATIME) {
+	if (orangefs_inode->attr_valid & ATTR_ATIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_ATIME;
-		if (iattr->ia_valid & ATTR_ATIME_SET) {
-			attrs->atime = (time64_t)iattr->ia_atime.tv_sec;
+		if (orangefs_inode->attr_valid & ATTR_ATIME_SET) {
+			attrs->atime = (time64_t)inode->i_atime.tv_sec;
 			attrs->mask |= ORANGEFS_ATTR_SYS_ATIME_SET;
 		}
 	}
-	if (iattr->ia_valid & ATTR_MTIME) {
+	if (orangefs_inode->attr_valid & ATTR_MTIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_MTIME;
-		if (iattr->ia_valid & ATTR_MTIME_SET) {
-			attrs->mtime = (time64_t)iattr->ia_mtime.tv_sec;
+		if (orangefs_inode->attr_valid & ATTR_MTIME_SET) {
+			attrs->mtime = (time64_t)inode->i_mtime.tv_sec;
 			attrs->mask |= ORANGEFS_ATTR_SYS_MTIME_SET;
 		}
 	}
-	if (iattr->ia_valid & ATTR_CTIME)
+	if (orangefs_inode->attr_valid & ATTR_CTIME)
 		attrs->mask |= ORANGEFS_ATTR_SYS_CTIME;
 
 	/*
@@ -189,36 +175,10 @@ static inline int copy_attributes_from_inode(struct inode *inode,
 	 * worry about ATTR_SIZE
 	 */
 
-	if (iattr->ia_valid & ATTR_MODE) {
-		tmp_mode = iattr->ia_mode;
-		if (tmp_mode & (S_ISVTX)) {
-			if (is_root_handle(inode)) {
-				/*
-				 * allow sticky bit to be set on root (since
-				 * it shows up that way by default anyhow),
-				 * but don't show it to the server
-				 */
-				tmp_mode -= S_ISVTX;
-			} else {
-				gossip_debug(GOSSIP_UTILS_DEBUG,
-					"%s: setting sticky bit not supported.\n",
-					__func__);
-				return -EINVAL;
-			}
-		}
-
-		if (tmp_mode & (S_ISUID)) {
-			gossip_debug(GOSSIP_UTILS_DEBUG,
-				"%s: setting setuid bit not supported.\n",
-				__func__);
-			return -EINVAL;
-		}
-
-		attrs->perms = ORANGEFS_util_translate_mode(tmp_mode);
+	if (orangefs_inode->attr_valid & ATTR_MODE) {
+		attrs->perms = ORANGEFS_util_translate_mode(inode->i_mode);
 		attrs->mask |= ORANGEFS_ATTR_SYS_PERM;
 	}
-
-	return 0;
 }
 
 static int orangefs_inode_type(enum orangefs_ds_type objtype)
@@ -283,10 +243,16 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	gossip_debug(GOSSIP_UTILS_DEBUG, "%s: called on inode %pU flags %d\n",
 	    __func__, get_khandle_from_ino(inode), flags);
 
+again:
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    inode->i_state & I_DIRTY) {
+	    orangefs_inode->attr_valid) {
+		if (orangefs_inode->attr_valid) {
+			spin_unlock(&inode->i_lock);
+			write_inode_now(inode, 1);
+			goto again;
+		}
 		spin_unlock(&inode->i_lock);
 		return 0;
 	}
@@ -311,10 +277,16 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	if (ret != 0)
 		goto out;
 
+again2:
 	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
 	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
-	    inode->i_state & I_DIRTY) {
+	    orangefs_inode->attr_valid) {
+		if (orangefs_inode->attr_valid) {
+			spin_unlock(&inode->i_lock);
+			write_inode_now(inode, 1);
+			goto again2;
+		}
 		gossip_debug(GOSSIP_UTILS_DEBUG, "%s: in cache or dirty\n",
 		    __func__);
 		ret = 0;
@@ -438,7 +410,7 @@ int orangefs_inode_check_changed(struct inode *inode)
  * issues a orangefs setattr request to make sure the new attribute values
  * take effect if successful.  returns 0 on success; -errno otherwise
  */
-int orangefs_inode_setattr(struct inode *inode, struct iattr *iattr)
+int orangefs_inode_setattr(struct inode *inode)
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op;
@@ -448,24 +420,26 @@ int orangefs_inode_setattr(struct inode *inode, struct iattr *iattr)
 	if (!new_op)
 		return -ENOMEM;
 
+	spin_lock(&inode->i_lock);
+	new_op->upcall.uid = from_kuid(&init_user_ns, orangefs_inode->attr_uid);
+	new_op->upcall.gid = from_kgid(&init_user_ns, orangefs_inode->attr_gid);
 	new_op->upcall.req.setattr.refn = orangefs_inode->refn;
-	ret = copy_attributes_from_inode(inode,
-		       &new_op->upcall.req.setattr.attributes,
-		       iattr);
-	if (ret >= 0) {
-		ret = service_operation(new_op, __func__,
-				get_interruptible_flag(inode));
+	copy_attributes_from_inode(inode,
+	    &new_op->upcall.req.setattr.attributes);
+	orangefs_inode->attr_valid = 0;
+	spin_unlock(&inode->i_lock);
 
-		gossip_debug(GOSSIP_UTILS_DEBUG,
-			     "orangefs_inode_setattr: returning %d\n",
-			     ret);
-	}
+	ret = service_operation(new_op, __func__,
+	    get_interruptible_flag(inode));
+	gossip_debug(GOSSIP_UTILS_DEBUG,
+	    "orangefs_inode_setattr: returning %d\n", ret);
+	if (ret)
+		orangefs_make_bad_inode(inode);
 
 	op_release(new_op);
 
 	if (ret == 0)
 		orangefs_inode->getattr_time = jiffies - 1;
-
 	return ret;
 }
 
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 788869c8233b..83abe5ec2d11 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -153,17 +153,8 @@ static void orangefs_destroy_inode(struct inode *inode)
 
 int orangefs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
-	struct iattr iattr;
 	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
-	iattr.ia_valid = ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_ATIME |
-	    ATTR_ATIME_SET | ATTR_MTIME | ATTR_MTIME_SET | ATTR_CTIME;
-	iattr.ia_mode = inode->i_mode;
-	iattr.ia_uid = inode->i_uid;
-	iattr.ia_gid = inode->i_gid;
-	iattr.ia_atime = inode->i_atime;
-	iattr.ia_mtime = inode->i_mtime;
-	iattr.ia_ctime = inode->i_ctime;
-	return orangefs_inode_setattr(inode, &iattr);
+	return orangefs_inode_setattr(inode);
 }
 
 /*
-- 
2.19.0

