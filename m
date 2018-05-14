Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267071-2-6668285573250486912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267070; b=QloqacpMbd824Xh/+iza7AAM8jMoPSD6p1h9kI+ZVD9T6nG9/r
    lmWfvUn9gAJixKaO9gIX4wcDjJUA9mVWnfRPZrogTQNYBRbIvm2/tCmI0bAo/VLJ
    EEh5pQvlwH+OSsAZFnekXQ9hPHpXeJZm3sSw6AsKMUyKzc4c1+WcEOAVpgrXlivu
    QpNGTzFewIWcoUd0jhKRoj7Rakhazd5rrYKWVm+At/WxKGA8nk4rHEkoZsQSs43E
    GCtEEph/CH1UvCpUOgjCijo6e1MAYIsk78IDFHz9msypGvlXeZh4ZVN3h7g6ZF6I
    TzYue85rr9B38wZ6r0iYClSuctKwchbZ02yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526267070;
    bh=zH7ziyeNQN/Q5oFpsFATLu0F615i605LdBLEhtBmO4w=; b=P9mQu1Q4snTz
    o+i/iJYNxOz+nh40+U/GhE/0LK/T4eKMbABCKZTDAG5uq/RSWLRJ7KytT2Asldnl
    k83mQ4mNvu8IenoVR2V4EWiU+X4mOyFK8E3s/gcRWpeoRqr/PRX80rGrgA3CwZxY
    ZSRcConG3oE0AE1BxZRroMNjKrj2LigOyuPDjtB/HB3U2mTcAfxTj+r3gITw+Bd+
    fylsPFX9Ggi/VBN0wCiCF95DrwuuF5CrmWk4n2ygKvEP3Kb93HezfqLUxClCjIk2
    ttOc1reJKLN7s7WFGDXlELN1lgUPE+KWBJMCIORjgoezqKWq8z/pxYJfipI712Yl
    qiBLDsRhxg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFPZ7fxyNhOs9aKkObd0HUM+pI6Lmxsyb3vjZWhN+z72YLQBBPcG7Ye1BR9UccQwBZE85rTirOxOvfC+Y8gXyLv00CZqoW7oi/yt+XlQLndG+i3wsNC5
    hky4cwCgsdBm0c7ptIQtH+js7rUr+Z4zdtoKQVgpDfCkuujh6siZJVHnk0pHMFBJMQ95YTljbSLRS6GQGcaixN0JR5f13/EcNXVuToC00o8byuUa37bKnwFD
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=4rAZ-iTgIM6HmgTMbs0A:9 a=Vob3FjIUtsA8Qy9P:21
    a=72Mw7_ewpvtjyF0L:21 a=QEXdDO2ut3YA:10 a=-tElvS_Zar9K8zhlwiSp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeENDE2 (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:04:28 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:37992
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751953AbeENDE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 May 2018 23:04:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C+AwBP/Pha/+U/0XZSChwBAQEEAQEKA?=
 =?us-ascii?q?QGDGCuBKzEog3KIBIxsRQEBAQMGgQc0YhqTMhSBZB4YAYRAAoMJITQYAQIBAQE?=
 =?us-ascii?q?BAQECbCiFKQYaAQgEUhAYAQwCGA4CAkcQBhOFFwypfYFpMxoCiCCCJ4EJhxyBD?=
 =?us-ascii?q?IEHgQ8vgieEfRODGIJUAocXFwqEYGI+in4JiDuGFoE2hjUPhHWHSIpAHDiBUk0?=
 =?us-ascii?q?uCoJ+gh0DF3oBAo0nMjB6AQGNHSuCGQEB?=
X-IPAS-Result: =?us-ascii?q?A2C+AwBP/Pha/+U/0XZSChwBAQEEAQEKAQGDGCuBKzEog3K?=
 =?us-ascii?q?IBIxsRQEBAQMGgQc0YhqTMhSBZB4YAYRAAoMJITQYAQIBAQEBAQECbCiFKQYaA?=
 =?us-ascii?q?QgEUhAYAQwCGA4CAkcQBhOFFwypfYFpMxoCiCCCJ4EJhxyBDIEHgQ8vgieEfRO?=
 =?us-ascii?q?DGIJUAocXFwqEYGI+in4JiDuGFoE2hjUPhHWHSIpAHDiBUk0uCoJ+gh0DF3oBA?=
 =?us-ascii?q?o0nMjB6AQGNHSuCGQEB?=
X-IronPort-AV: E=Sophos;i="5.49,398,1520870400";
   d="scan'208";a="126179489"
Subject: [PATCH 02/10] autofs4 - use autofs instead of autofs4 everywhere
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 11:03:56 +0800
Message-ID: <152626703688.28589.8315406711135226803.stgit@pluto.themaw.net>
In-Reply-To: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Update naming within autofs source to be consistent by changing occurrences
of autofs4 to autofs.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/autofs_i.h  |   88 ++++++++--------
 fs/autofs4/dev-ioctl.c |   18 ++-
 fs/autofs4/expire.c    |  132 ++++++++++++-----------
 fs/autofs4/init.c      |   12 +-
 fs/autofs4/inode.c     |   48 ++++-----
 fs/autofs4/root.c      |  271 ++++++++++++++++++++++++------------------------
 fs/autofs4/symlink.c   |   16 +--
 fs/autofs4/waitq.c     |   53 +++++----
 8 files changed, 319 insertions(+), 319 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 01636f3945d5..9110b66c7ef1 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -122,44 +122,44 @@ struct autofs_sb_info {
 	struct rcu_head rcu;
 };
 
-static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
+static inline struct autofs_sb_info *autofs_sbi(struct super_block *sb)
 {
 	return (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
-static inline struct autofs_info *autofs4_dentry_ino(struct dentry *dentry)
+static inline struct autofs_info *autofs_dentry_ino(struct dentry *dentry)
 {
 	return (struct autofs_info *)(dentry->d_fsdata);
 }
 
-/* autofs4_oz_mode(): do we see the man behind the curtain?  (The
+/* autofs_oz_mode(): do we see the man behind the curtain?  (The
  * processes which do manipulations for us in user space sees the raw
  * filesystem without "magic".)
  */
-static inline int autofs4_oz_mode(struct autofs_sb_info *sbi)
+static inline int autofs_oz_mode(struct autofs_sb_info *sbi)
 {
 	return sbi->catatonic || task_pgrp(current) == sbi->oz_pgrp;
 }
 
-struct inode *autofs4_get_inode(struct super_block *, umode_t);
-void autofs4_free_ino(struct autofs_info *);
+struct inode *autofs_get_inode(struct super_block *, umode_t);
+void autofs_free_ino(struct autofs_info *);
 
 /* Expiration */
-int is_autofs4_dentry(struct dentry *);
-int autofs4_expire_wait(const struct path *path, int rcu_walk);
-int autofs4_expire_run(struct super_block *, struct vfsmount *,
-		       struct autofs_sb_info *,
-		       struct autofs_packet_expire __user *);
-int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
-			    struct autofs_sb_info *sbi, int when);
-int autofs4_expire_multi(struct super_block *, struct vfsmount *,
-			 struct autofs_sb_info *, int __user *);
-struct dentry *autofs4_expire_direct(struct super_block *sb,
-				     struct vfsmount *mnt,
-				     struct autofs_sb_info *sbi, int how);
-struct dentry *autofs4_expire_indirect(struct super_block *sb,
-				       struct vfsmount *mnt,
-				       struct autofs_sb_info *sbi, int how);
+int is_autofs_dentry(struct dentry *);
+int autofs_expire_wait(const struct path *path, int rcu_walk);
+int autofs_expire_run(struct super_block *, struct vfsmount *,
+		      struct autofs_sb_info *,
+		      struct autofs_packet_expire __user *);
+int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
+			   struct autofs_sb_info *sbi, int when);
+int autofs_expire_multi(struct super_block *, struct vfsmount *,
+			struct autofs_sb_info *, int __user *);
+struct dentry *autofs_expire_direct(struct super_block *sb,
+				    struct vfsmount *mnt,
+				    struct autofs_sb_info *sbi, int how);
+struct dentry *autofs_expire_indirect(struct super_block *sb,
+				      struct vfsmount *mnt,
+				      struct autofs_sb_info *sbi, int how);
 
 /* Device node initialization */
 
@@ -168,11 +168,11 @@ void autofs_dev_ioctl_exit(void);
 
 /* Operations structures */
 
-extern const struct inode_operations autofs4_symlink_inode_operations;
-extern const struct inode_operations autofs4_dir_inode_operations;
-extern const struct file_operations autofs4_dir_operations;
-extern const struct file_operations autofs4_root_operations;
-extern const struct dentry_operations autofs4_dentry_operations;
+extern const struct inode_operations autofs_symlink_inode_operations;
+extern const struct inode_operations autofs_dir_inode_operations;
+extern const struct file_operations autofs_dir_operations;
+extern const struct file_operations autofs_root_operations;
+extern const struct dentry_operations autofs_dentry_operations;
 
 /* VFS automount flags management functions */
 static inline void __managed_dentry_set_managed(struct dentry *dentry)
@@ -201,9 +201,9 @@ static inline void managed_dentry_clear_managed(struct dentry *dentry)
 
 /* Initializing function */
 
-int autofs4_fill_super(struct super_block *, void *, int);
-struct autofs_info *autofs4_new_ino(struct autofs_sb_info *);
-void autofs4_clean_ino(struct autofs_info *);
+int autofs_fill_super(struct super_block *, void *, int);
+struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
+void autofs_clean_ino(struct autofs_info *);
 
 static inline int autofs_prepare_pipe(struct file *pipe)
 {
@@ -218,25 +218,25 @@ static inline int autofs_prepare_pipe(struct file *pipe)
 
 /* Queue management functions */
 
-int autofs4_wait(struct autofs_sb_info *,
+int autofs_wait(struct autofs_sb_info *,
 		 const struct path *, enum autofs_notify);
-int autofs4_wait_release(struct autofs_sb_info *, autofs_wqt_t, int);
-void autofs4_catatonic_mode(struct autofs_sb_info *);
+int autofs_wait_release(struct autofs_sb_info *, autofs_wqt_t, int);
+void autofs_catatonic_mode(struct autofs_sb_info *);
 
-static inline u32 autofs4_get_dev(struct autofs_sb_info *sbi)
+static inline u32 autofs_get_dev(struct autofs_sb_info *sbi)
 {
 	return new_encode_dev(sbi->sb->s_dev);
 }
 
-static inline u64 autofs4_get_ino(struct autofs_sb_info *sbi)
+static inline u64 autofs_get_ino(struct autofs_sb_info *sbi)
 {
 	return d_inode(sbi->sb->s_root)->i_ino;
 }
 
-static inline void __autofs4_add_expiring(struct dentry *dentry)
+static inline void __autofs_add_expiring(struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 
 	if (ino) {
 		if (list_empty(&ino->expiring))
@@ -244,10 +244,10 @@ static inline void __autofs4_add_expiring(struct dentry *dentry)
 	}
 }
 
-static inline void autofs4_add_expiring(struct dentry *dentry)
+static inline void autofs_add_expiring(struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 
 	if (ino) {
 		spin_lock(&sbi->lookup_lock);
@@ -257,10 +257,10 @@ static inline void autofs4_add_expiring(struct dentry *dentry)
 	}
 }
 
-static inline void autofs4_del_expiring(struct dentry *dentry)
+static inline void autofs_del_expiring(struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 
 	if (ino) {
 		spin_lock(&sbi->lookup_lock);
@@ -270,4 +270,4 @@ static inline void autofs4_del_expiring(struct dentry *dentry)
 	}
 }
 
-void autofs4_kill_sb(struct super_block *);
+void autofs_kill_sb(struct super_block *);
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 26f6b4f41ce6..a2281ab2b957 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -166,7 +166,7 @@ static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
 
 	if (f) {
 		inode = file_inode(f);
-		sbi = autofs4_sbi(inode->i_sb);
+		sbi = autofs_sbi(inode->i_sb);
 	}
 	return sbi;
 }
@@ -236,7 +236,7 @@ static int test_by_dev(const struct path *path, void *p)
 
 static int test_by_type(const struct path *path, void *p)
 {
-	struct autofs_info *ino = autofs4_dentry_ino(path->dentry);
+	struct autofs_info *ino = autofs_dentry_ino(path->dentry);
 
 	return ino && ino->sbi->type & *(unsigned *)p;
 }
@@ -324,7 +324,7 @@ static int autofs_dev_ioctl_ready(struct file *fp,
 	autofs_wqt_t token;
 
 	token = (autofs_wqt_t) param->ready.token;
-	return autofs4_wait_release(sbi, token, 0);
+	return autofs_wait_release(sbi, token, 0);
 }
 
 /*
@@ -340,7 +340,7 @@ static int autofs_dev_ioctl_fail(struct file *fp,
 
 	token = (autofs_wqt_t) param->fail.token;
 	status = param->fail.status < 0 ? param->fail.status : -ENOENT;
-	return autofs4_wait_release(sbi, token, status);
+	return autofs_wait_release(sbi, token, status);
 }
 
 /*
@@ -412,7 +412,7 @@ static int autofs_dev_ioctl_catatonic(struct file *fp,
 				      struct autofs_sb_info *sbi,
 				      struct autofs_dev_ioctl *param)
 {
-	autofs4_catatonic_mode(sbi);
+	autofs_catatonic_mode(sbi);
 	return 0;
 }
 
@@ -459,10 +459,10 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	if (err)
 		goto out;
 
-	ino = autofs4_dentry_ino(path.dentry);
+	ino = autofs_dentry_ino(path.dentry);
 	if (ino) {
 		err = 0;
-		autofs4_expire_wait(&path, 0);
+		autofs_expire_wait(&path, 0);
 		spin_lock(&sbi->fs_lock);
 		param->requester.uid =
 			from_kuid_munged(current_user_ns(), ino->uid);
@@ -489,7 +489,7 @@ static int autofs_dev_ioctl_expire(struct file *fp,
 	how = param->expire.how;
 	mnt = fp->f_path.mnt;
 
-	return autofs4_do_expire_multi(sbi->sb, mnt, sbi, how);
+	return autofs_do_expire_multi(sbi->sb, mnt, sbi, how);
 }
 
 /* Check if autofs mount point is in use */
@@ -686,7 +686,7 @@ static int _autofs_dev_ioctl(unsigned int command,
 		 * Admin needs to be able to set the mount catatonic in
 		 * order to be able to perform the re-open.
 		 */
-		if (!autofs4_oz_mode(sbi) &&
+		if (!autofs_oz_mode(sbi) &&
 		    cmd != AUTOFS_DEV_IOCTL_CATATONIC_CMD) {
 			err = -EACCES;
 			fput(fp);
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 57725d4a8c59..36f16b67a3bf 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -13,10 +13,10 @@
 static unsigned long now;
 
 /* Check if a dentry can be expired */
-static inline int autofs4_can_expire(struct dentry *dentry,
-				     unsigned long timeout, int do_now)
+static inline int autofs_can_expire(struct dentry *dentry,
+				    unsigned long timeout, int do_now)
 {
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 
 	/* dentry in the process of being deleted */
 	if (ino == NULL)
@@ -31,7 +31,7 @@ static inline int autofs4_can_expire(struct dentry *dentry,
 }
 
 /* Check a mount point for busyness */
-static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
+static int autofs_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 {
 	struct dentry *top = dentry;
 	struct path path = {.mnt = mnt, .dentry = dentry};
@@ -44,8 +44,8 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 	if (!follow_down_one(&path))
 		goto done;
 
-	if (is_autofs4_dentry(path.dentry)) {
-		struct autofs_sb_info *sbi = autofs4_sbi(path.dentry->d_sb);
+	if (is_autofs_dentry(path.dentry)) {
+		struct autofs_sb_info *sbi = autofs_sbi(path.dentry->d_sb);
 
 		/* This is an autofs submount, we can't expire it */
 		if (autofs_type_indirect(sbi->type))
@@ -56,7 +56,7 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 	if (!may_umount_tree(path.mnt)) {
 		struct autofs_info *ino;
 
-		ino = autofs4_dentry_ino(top);
+		ino = autofs_dentry_ino(top);
 		ino->last_used = jiffies;
 		goto done;
 	}
@@ -74,7 +74,7 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 static struct dentry *get_next_positive_subdir(struct dentry *prev,
 					       struct dentry *root)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(root->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(root->d_sb);
 	struct list_head *next;
 	struct dentry *q;
 
@@ -121,7 +121,7 @@ static struct dentry *get_next_positive_subdir(struct dentry *prev,
 static struct dentry *get_next_positive_dentry(struct dentry *prev,
 					       struct dentry *root)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(root->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(root->d_sb);
 	struct list_head *next;
 	struct dentry *p, *ret;
 
@@ -184,10 +184,10 @@ static struct dentry *get_next_positive_dentry(struct dentry *prev,
  * The tree is not busy iff no mountpoints are busy and there are no
  * autofs submounts.
  */
-static int autofs4_direct_busy(struct vfsmount *mnt,
-			       struct dentry *top,
-			       unsigned long timeout,
-			       int do_now)
+static int autofs_direct_busy(struct vfsmount *mnt,
+			      struct dentry *top,
+			      unsigned long timeout,
+			      int do_now)
 {
 	pr_debug("top %p %pd\n", top, top);
 
@@ -195,14 +195,14 @@ static int autofs4_direct_busy(struct vfsmount *mnt,
 	if (!may_umount_tree(mnt)) {
 		struct autofs_info *ino;
 
-		ino = autofs4_dentry_ino(top);
+		ino = autofs_dentry_ino(top);
 		if (ino)
 			ino->last_used = jiffies;
 		return 1;
 	}
 
 	/* Timeout of a direct mount is determined by its top dentry */
-	if (!autofs4_can_expire(top, timeout, do_now))
+	if (!autofs_can_expire(top, timeout, do_now))
 		return 1;
 
 	return 0;
@@ -212,12 +212,12 @@ static int autofs4_direct_busy(struct vfsmount *mnt,
  * Check a directory tree of mount points for busyness
  * The tree is not busy iff no mountpoints are busy
  */
-static int autofs4_tree_busy(struct vfsmount *mnt,
-	       		     struct dentry *top,
-			     unsigned long timeout,
-			     int do_now)
+static int autofs_tree_busy(struct vfsmount *mnt,
+			    struct dentry *top,
+			    unsigned long timeout,
+			    int do_now)
 {
-	struct autofs_info *top_ino = autofs4_dentry_ino(top);
+	struct autofs_info *top_ino = autofs_dentry_ino(top);
 	struct dentry *p;
 
 	pr_debug("top %p %pd\n", top, top);
@@ -237,13 +237,13 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
 		 * If the fs is busy update the expiry counter.
 		 */
 		if (d_mountpoint(p)) {
-			if (autofs4_mount_busy(mnt, p)) {
+			if (autofs_mount_busy(mnt, p)) {
 				top_ino->last_used = jiffies;
 				dput(p);
 				return 1;
 			}
 		} else {
-			struct autofs_info *ino = autofs4_dentry_ino(p);
+			struct autofs_info *ino = autofs_dentry_ino(p);
 			unsigned int ino_count = atomic_read(&ino->count);
 
 			/* allow for dget above and top is already dgot */
@@ -261,16 +261,16 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
 	}
 
 	/* Timeout of a tree mount is ultimately determined by its top dentry */
-	if (!autofs4_can_expire(top, timeout, do_now))
+	if (!autofs_can_expire(top, timeout, do_now))
 		return 1;
 
 	return 0;
 }
 
-static struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
-					   struct dentry *parent,
-					   unsigned long timeout,
-					   int do_now)
+static struct dentry *autofs_check_leaves(struct vfsmount *mnt,
+					  struct dentry *parent,
+					  unsigned long timeout,
+					  int do_now)
 {
 	struct dentry *p;
 
@@ -282,11 +282,11 @@ static struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
 
 		if (d_mountpoint(p)) {
 			/* Can we umount this guy */
-			if (autofs4_mount_busy(mnt, p))
+			if (autofs_mount_busy(mnt, p))
 				continue;
 
 			/* Can we expire this guy */
-			if (autofs4_can_expire(p, timeout, do_now))
+			if (autofs_can_expire(p, timeout, do_now))
 				return p;
 		}
 	}
@@ -294,10 +294,10 @@ static struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
 }
 
 /* Check if we can expire a direct mount (possibly a tree) */
-struct dentry *autofs4_expire_direct(struct super_block *sb,
-				     struct vfsmount *mnt,
-				     struct autofs_sb_info *sbi,
-				     int how)
+struct dentry *autofs_expire_direct(struct super_block *sb,
+				    struct vfsmount *mnt,
+				    struct autofs_sb_info *sbi,
+				    int how)
 {
 	unsigned long timeout;
 	struct dentry *root = dget(sb->s_root);
@@ -310,9 +310,9 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
 	now = jiffies;
 	timeout = sbi->exp_timeout;
 
-	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
+	if (!autofs_direct_busy(mnt, root, timeout, do_now)) {
 		spin_lock(&sbi->fs_lock);
-		ino = autofs4_dentry_ino(root);
+		ino = autofs_dentry_ino(root);
 		/* No point expiring a pending mount */
 		if (ino->flags & AUTOFS_INF_PENDING) {
 			spin_unlock(&sbi->fs_lock);
@@ -321,7 +321,7 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
 		ino->flags |= AUTOFS_INF_WANT_EXPIRE;
 		spin_unlock(&sbi->fs_lock);
 		synchronize_rcu();
-		if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
+		if (!autofs_direct_busy(mnt, root, timeout, do_now)) {
 			spin_lock(&sbi->fs_lock);
 			ino->flags |= AUTOFS_INF_EXPIRING;
 			init_completion(&ino->expire_complete);
@@ -350,7 +350,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 {
 	int do_now = how & AUTOFS_EXP_IMMEDIATE;
 	int exp_leaves = how & AUTOFS_EXP_LEAVES;
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	unsigned int ino_count;
 
 	/* No point expiring a pending mount */
@@ -367,11 +367,11 @@ static struct dentry *should_expire(struct dentry *dentry,
 		pr_debug("checking mountpoint %p %pd\n", dentry, dentry);
 
 		/* Can we umount this guy */
-		if (autofs4_mount_busy(mnt, dentry))
+		if (autofs_mount_busy(mnt, dentry))
 			return NULL;
 
 		/* Can we expire this guy */
-		if (autofs4_can_expire(dentry, timeout, do_now))
+		if (autofs_can_expire(dentry, timeout, do_now))
 			return dentry;
 		return NULL;
 	}
@@ -382,7 +382,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 		 * A symlink can't be "busy" in the usual sense so
 		 * just check last used for expire timeout.
 		 */
-		if (autofs4_can_expire(dentry, timeout, do_now))
+		if (autofs_can_expire(dentry, timeout, do_now))
 			return dentry;
 		return NULL;
 	}
@@ -397,7 +397,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 		if (d_count(dentry) > ino_count)
 			return NULL;
 
-		if (!autofs4_tree_busy(mnt, dentry, timeout, do_now))
+		if (!autofs_tree_busy(mnt, dentry, timeout, do_now))
 			return dentry;
 	/*
 	 * Case 3: pseudo direct mount, expire individual leaves
@@ -411,7 +411,7 @@ static struct dentry *should_expire(struct dentry *dentry,
 		if (d_count(dentry) > ino_count)
 			return NULL;
 
-		expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
+		expired = autofs_check_leaves(mnt, dentry, timeout, do_now);
 		if (expired) {
 			if (expired == dentry)
 				dput(dentry);
@@ -427,10 +427,10 @@ static struct dentry *should_expire(struct dentry *dentry,
  *  - it is unused by any user process
  *  - it has been unused for exp_timeout time
  */
-struct dentry *autofs4_expire_indirect(struct super_block *sb,
-				       struct vfsmount *mnt,
-				       struct autofs_sb_info *sbi,
-				       int how)
+struct dentry *autofs_expire_indirect(struct super_block *sb,
+				      struct vfsmount *mnt,
+				      struct autofs_sb_info *sbi,
+				      int how)
 {
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;
@@ -450,7 +450,7 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 		int flags = how;
 
 		spin_lock(&sbi->fs_lock);
-		ino = autofs4_dentry_ino(dentry);
+		ino = autofs_dentry_ino(dentry);
 		if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
 			spin_unlock(&sbi->fs_lock);
 			continue;
@@ -462,7 +462,7 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 			continue;
 
 		spin_lock(&sbi->fs_lock);
-		ino = autofs4_dentry_ino(expired);
+		ino = autofs_dentry_ino(expired);
 		ino->flags |= AUTOFS_INF_WANT_EXPIRE;
 		spin_unlock(&sbi->fs_lock);
 		synchronize_rcu();
@@ -498,11 +498,11 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 	return expired;
 }
 
-int autofs4_expire_wait(const struct path *path, int rcu_walk)
+int autofs_expire_wait(const struct path *path, int rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	int status;
 	int state;
 
@@ -529,7 +529,7 @@ int autofs4_expire_wait(const struct path *path, int rcu_walk)
 
 		pr_debug("waiting for expire %p name=%pd\n", dentry, dentry);
 
-		status = autofs4_wait(sbi, path, NFY_NONE);
+		status = autofs_wait(sbi, path, NFY_NONE);
 		wait_for_completion(&ino->expire_complete);
 
 		pr_debug("expire done status=%d\n", status);
@@ -545,10 +545,10 @@ int autofs4_expire_wait(const struct path *path, int rcu_walk)
 }
 
 /* Perform an expiry operation */
-int autofs4_expire_run(struct super_block *sb,
-		       struct vfsmount *mnt,
-		       struct autofs_sb_info *sbi,
-		       struct autofs_packet_expire __user *pkt_p)
+int autofs_expire_run(struct super_block *sb,
+		      struct vfsmount *mnt,
+		      struct autofs_sb_info *sbi,
+		      struct autofs_packet_expire __user *pkt_p)
 {
 	struct autofs_packet_expire pkt;
 	struct autofs_info *ino;
@@ -560,7 +560,7 @@ int autofs4_expire_run(struct super_block *sb,
 	pkt.hdr.proto_version = sbi->version;
 	pkt.hdr.type = autofs_ptype_expire;
 
-	dentry = autofs4_expire_indirect(sb, mnt, sbi, 0);
+	dentry = autofs_expire_indirect(sb, mnt, sbi, 0);
 	if (!dentry)
 		return -EAGAIN;
 
@@ -573,7 +573,7 @@ int autofs4_expire_run(struct super_block *sb,
 		ret = -EFAULT;
 
 	spin_lock(&sbi->fs_lock);
-	ino = autofs4_dentry_ino(dentry);
+	ino = autofs_dentry_ino(dentry);
 	/* avoid rapid-fire expire attempts if expiry fails */
 	ino->last_used = now;
 	ino->flags &= ~(AUTOFS_INF_EXPIRING|AUTOFS_INF_WANT_EXPIRE);
@@ -583,25 +583,25 @@ int autofs4_expire_run(struct super_block *sb,
 	return ret;
 }
 
-int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
-			    struct autofs_sb_info *sbi, int when)
+int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
+			   struct autofs_sb_info *sbi, int when)
 {
 	struct dentry *dentry;
 	int ret = -EAGAIN;
 
 	if (autofs_type_trigger(sbi->type))
-		dentry = autofs4_expire_direct(sb, mnt, sbi, when);
+		dentry = autofs_expire_direct(sb, mnt, sbi, when);
 	else
-		dentry = autofs4_expire_indirect(sb, mnt, sbi, when);
+		dentry = autofs_expire_indirect(sb, mnt, sbi, when);
 
 	if (dentry) {
-		struct autofs_info *ino = autofs4_dentry_ino(dentry);
+		struct autofs_info *ino = autofs_dentry_ino(dentry);
 		const struct path path = { .mnt = mnt, .dentry = dentry };
 
 		/* This is synchronous because it makes the daemon a
 		 * little easier
 		 */
-		ret = autofs4_wait(sbi, &path, NFY_EXPIRE);
+		ret = autofs_wait(sbi, &path, NFY_EXPIRE);
 
 		spin_lock(&sbi->fs_lock);
 		/* avoid rapid-fire expire attempts if expiry fails */
@@ -619,7 +619,7 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
  * Call repeatedly until it returns -EAGAIN, meaning there's nothing
  * more to be done.
  */
-int autofs4_expire_multi(struct super_block *sb, struct vfsmount *mnt,
+int autofs_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 			struct autofs_sb_info *sbi, int __user *arg)
 {
 	int do_now = 0;
@@ -627,6 +627,6 @@ int autofs4_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 	if (arg && get_user(do_now, arg))
 		return -EFAULT;
 
-	return autofs4_do_expire_multi(sb, mnt, sbi, do_now);
+	return autofs_do_expire_multi(sb, mnt, sbi, do_now);
 }
 
diff --git a/fs/autofs4/init.c b/fs/autofs4/init.c
index 8cf0e63389ae..16fb61315843 100644
--- a/fs/autofs4/init.c
+++ b/fs/autofs4/init.c
@@ -13,18 +13,18 @@
 static struct dentry *autofs_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
-	return mount_nodev(fs_type, flags, data, autofs4_fill_super);
+	return mount_nodev(fs_type, flags, data, autofs_fill_super);
 }
 
 static struct file_system_type autofs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.mount		= autofs_mount,
-	.kill_sb	= autofs4_kill_sb,
+	.kill_sb	= autofs_kill_sb,
 };
 MODULE_ALIAS_FS("autofs");
 
-static int __init init_autofs4_fs(void)
+static int __init init_autofs_fs(void)
 {
 	int err;
 
@@ -37,12 +37,12 @@ static int __init init_autofs4_fs(void)
 	return err;
 }
 
-static void __exit exit_autofs4_fs(void)
+static void __exit exit_autofs_fs(void)
 {
 	autofs_dev_ioctl_exit();
 	unregister_filesystem(&autofs_fs_type);
 }
 
-module_init(init_autofs4_fs) 
-module_exit(exit_autofs4_fs)
+module_init(init_autofs_fs)
+module_exit(exit_autofs_fs)
 MODULE_LICENSE("GPL");
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 09e7d68dff02..6262819ede45 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -18,7 +18,7 @@
 #include "autofs_i.h"
 #include <linux/module.h>
 
-struct autofs_info *autofs4_new_ino(struct autofs_sb_info *sbi)
+struct autofs_info *autofs_new_ino(struct autofs_sb_info *sbi)
 {
 	struct autofs_info *ino;
 
@@ -32,21 +32,21 @@ struct autofs_info *autofs4_new_ino(struct autofs_sb_info *sbi)
 	return ino;
 }
 
-void autofs4_clean_ino(struct autofs_info *ino)
+void autofs_clean_ino(struct autofs_info *ino)
 {
 	ino->uid = GLOBAL_ROOT_UID;
 	ino->gid = GLOBAL_ROOT_GID;
 	ino->last_used = jiffies;
 }
 
-void autofs4_free_ino(struct autofs_info *ino)
+void autofs_free_ino(struct autofs_info *ino)
 {
 	kfree(ino);
 }
 
-void autofs4_kill_sb(struct super_block *sb)
+void autofs_kill_sb(struct super_block *sb)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(sb);
+	struct autofs_sb_info *sbi = autofs_sbi(sb);
 
 	/*
 	 * In the event of a failure in get_sb_nodev the superblock
@@ -56,7 +56,7 @@ void autofs4_kill_sb(struct super_block *sb)
 	 */
 	if (sbi) {
 		/* Free wait queues, close pipe */
-		autofs4_catatonic_mode(sbi);
+		autofs_catatonic_mode(sbi);
 		put_pid(sbi->oz_pgrp);
 	}
 
@@ -66,9 +66,9 @@ void autofs4_kill_sb(struct super_block *sb)
 		kfree_rcu(sbi, rcu);
 }
 
-static int autofs4_show_options(struct seq_file *m, struct dentry *root)
+static int autofs_show_options(struct seq_file *m, struct dentry *root)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(root->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(root->d_sb);
 	struct inode *root_inode = d_inode(root->d_sb->s_root);
 
 	if (!sbi)
@@ -101,16 +101,16 @@ static int autofs4_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void autofs4_evict_inode(struct inode *inode)
+static void autofs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
 	kfree(inode->i_private);
 }
 
-static const struct super_operations autofs4_sops = {
+static const struct super_operations autofs_sops = {
 	.statfs		= simple_statfs,
-	.show_options	= autofs4_show_options,
-	.evict_inode	= autofs4_evict_inode,
+	.show_options	= autofs_show_options,
+	.evict_inode	= autofs_evict_inode,
 };
 
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
@@ -206,7 +206,7 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 	return (*pipefd < 0);
 }
 
-int autofs4_fill_super(struct super_block *s, void *data, int silent)
+int autofs_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode *root_inode;
 	struct dentry *root;
@@ -246,19 +246,19 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
-	s->s_op = &autofs4_sops;
-	s->s_d_op = &autofs4_dentry_operations;
+	s->s_op = &autofs_sops;
+	s->s_d_op = &autofs_dentry_operations;
 	s->s_time_gran = 1;
 
 	/*
 	 * Get the root inode and dentry, but defer checking for errors.
 	 */
-	ino = autofs4_new_ino(sbi);
+	ino = autofs_new_ino(sbi);
 	if (!ino) {
 		ret = -ENOMEM;
 		goto fail_free;
 	}
-	root_inode = autofs4_get_inode(s, S_IFDIR | 0755);
+	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
 	root = d_make_root(root_inode);
 	if (!root)
 		goto fail_ino;
@@ -305,8 +305,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	if (autofs_type_trigger(sbi->type))
 		__managed_dentry_set_managed(root);
 
-	root_inode->i_fop = &autofs4_root_operations;
-	root_inode->i_op = &autofs4_dir_inode_operations;
+	root_inode->i_fop = &autofs_root_operations;
+	root_inode->i_op = &autofs_dir_inode_operations;
 
 	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
 	pipe = fget(pipefd);
@@ -340,14 +340,14 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	dput(root);
 	goto fail_free;
 fail_ino:
-	autofs4_free_ino(ino);
+	autofs_free_ino(ino);
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return ret;
 }
 
-struct inode *autofs4_get_inode(struct super_block *sb, umode_t mode)
+struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *inode = new_inode(sb);
 
@@ -364,10 +364,10 @@ struct inode *autofs4_get_inode(struct super_block *sb, umode_t mode)
 
 	if (S_ISDIR(mode)) {
 		set_nlink(inode, 2);
-		inode->i_op = &autofs4_dir_inode_operations;
-		inode->i_fop = &autofs4_dir_operations;
+		inode->i_op = &autofs_dir_inode_operations;
+		inode->i_fop = &autofs_dir_operations;
 	} else if (S_ISLNK(mode)) {
-		inode->i_op = &autofs4_symlink_inode_operations;
+		inode->i_op = &autofs_symlink_inode_operations;
 	} else
 		WARN_ON(1);
 
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index b12e37f27530..a4b36e44f73c 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -19,62 +19,62 @@
 
 #include "autofs_i.h"
 
-static int autofs4_dir_symlink(struct inode *, struct dentry *, const char *);
-static int autofs4_dir_unlink(struct inode *, struct dentry *);
-static int autofs4_dir_rmdir(struct inode *, struct dentry *);
-static int autofs4_dir_mkdir(struct inode *, struct dentry *, umode_t);
-static long autofs4_root_ioctl(struct file *, unsigned int, unsigned long);
+static int autofs_dir_symlink(struct inode *, struct dentry *, const char *);
+static int autofs_dir_unlink(struct inode *, struct dentry *);
+static int autofs_dir_rmdir(struct inode *, struct dentry *);
+static int autofs_dir_mkdir(struct inode *, struct dentry *, umode_t);
+static long autofs_root_ioctl(struct file *, unsigned int, unsigned long);
 #ifdef CONFIG_COMPAT
-static long autofs4_root_compat_ioctl(struct file *,
-				      unsigned int, unsigned long);
+static long autofs_root_compat_ioctl(struct file *,
+				     unsigned int, unsigned long);
 #endif
-static int autofs4_dir_open(struct inode *inode, struct file *file);
-static struct dentry *autofs4_lookup(struct inode *,
-				     struct dentry *, unsigned int);
-static struct vfsmount *autofs4_d_automount(struct path *);
-static int autofs4_d_manage(const struct path *, bool);
-static void autofs4_dentry_release(struct dentry *);
-
-const struct file_operations autofs4_root_operations = {
+static int autofs_dir_open(struct inode *inode, struct file *file);
+static struct dentry *autofs_lookup(struct inode *,
+				    struct dentry *, unsigned int);
+static struct vfsmount *autofs_d_automount(struct path *);
+static int autofs_d_manage(const struct path *, bool);
+static void autofs_dentry_release(struct dentry *);
+
+const struct file_operations autofs_root_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
 	.read		= generic_read_dir,
 	.iterate_shared	= dcache_readdir,
 	.llseek		= dcache_dir_lseek,
-	.unlocked_ioctl	= autofs4_root_ioctl,
+	.unlocked_ioctl	= autofs_root_ioctl,
 #ifdef CONFIG_COMPAT
-	.compat_ioctl	= autofs4_root_compat_ioctl,
+	.compat_ioctl	= autofs_root_compat_ioctl,
 #endif
 };
 
-const struct file_operations autofs4_dir_operations = {
-	.open		= autofs4_dir_open,
+const struct file_operations autofs_dir_operations = {
+	.open		= autofs_dir_open,
 	.release	= dcache_dir_close,
 	.read		= generic_read_dir,
 	.iterate_shared	= dcache_readdir,
 	.llseek		= dcache_dir_lseek,
 };
 
-const struct inode_operations autofs4_dir_inode_operations = {
-	.lookup		= autofs4_lookup,
-	.unlink		= autofs4_dir_unlink,
-	.symlink	= autofs4_dir_symlink,
-	.mkdir		= autofs4_dir_mkdir,
-	.rmdir		= autofs4_dir_rmdir,
+const struct inode_operations autofs_dir_inode_operations = {
+	.lookup		= autofs_lookup,
+	.unlink		= autofs_dir_unlink,
+	.symlink	= autofs_dir_symlink,
+	.mkdir		= autofs_dir_mkdir,
+	.rmdir		= autofs_dir_rmdir,
 };
 
-const struct dentry_operations autofs4_dentry_operations = {
-	.d_automount	= autofs4_d_automount,
-	.d_manage	= autofs4_d_manage,
-	.d_release	= autofs4_dentry_release,
+const struct dentry_operations autofs_dentry_operations = {
+	.d_automount	= autofs_d_automount,
+	.d_manage	= autofs_d_manage,
+	.d_release	= autofs_dentry_release,
 };
 
-static void autofs4_add_active(struct dentry *dentry)
+static void autofs_add_active(struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 	struct autofs_info *ino;
 
-	ino = autofs4_dentry_ino(dentry);
+	ino = autofs_dentry_ino(dentry);
 	if (ino) {
 		spin_lock(&sbi->lookup_lock);
 		if (!ino->active_count) {
@@ -86,12 +86,12 @@ static void autofs4_add_active(struct dentry *dentry)
 	}
 }
 
-static void autofs4_del_active(struct dentry *dentry)
+static void autofs_del_active(struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 	struct autofs_info *ino;
 
-	ino = autofs4_dentry_ino(dentry);
+	ino = autofs_dentry_ino(dentry);
 	if (ino) {
 		spin_lock(&sbi->lookup_lock);
 		ino->active_count--;
@@ -103,14 +103,14 @@ static void autofs4_del_active(struct dentry *dentry)
 	}
 }
 
-static int autofs4_dir_open(struct inode *inode, struct file *file)
+static int autofs_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry;
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 
 	pr_debug("file=%p dentry=%p %pd\n", file, dentry, dentry);
 
-	if (autofs4_oz_mode(sbi))
+	if (autofs_oz_mode(sbi))
 		goto out;
 
 	/*
@@ -133,10 +133,10 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	return dcache_dir_open(inode, file);
 }
 
-static void autofs4_dentry_release(struct dentry *de)
+static void autofs_dentry_release(struct dentry *de)
 {
-	struct autofs_info *ino = autofs4_dentry_ino(de);
-	struct autofs_sb_info *sbi = autofs4_sbi(de->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(de);
+	struct autofs_sb_info *sbi = autofs_sbi(de->d_sb);
 
 	pr_debug("releasing %p\n", de);
 
@@ -152,12 +152,12 @@ static void autofs4_dentry_release(struct dentry *de)
 		spin_unlock(&sbi->lookup_lock);
 	}
 
-	autofs4_free_ino(ino);
+	autofs_free_ino(ino);
 }
 
-static struct dentry *autofs4_lookup_active(struct dentry *dentry)
+static struct dentry *autofs_lookup_active(struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 	struct dentry *parent = dentry->d_parent;
 	const struct qstr *name = &dentry->d_name;
 	unsigned int len = name->len;
@@ -209,10 +209,10 @@ static struct dentry *autofs4_lookup_active(struct dentry *dentry)
 	return NULL;
 }
 
-static struct dentry *autofs4_lookup_expiring(struct dentry *dentry,
-					      bool rcu_walk)
+static struct dentry *autofs_lookup_expiring(struct dentry *dentry,
+					     bool rcu_walk)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 	struct dentry *parent = dentry->d_parent;
 	const struct qstr *name = &dentry->d_name;
 	unsigned int len = name->len;
@@ -269,17 +269,17 @@ static struct dentry *autofs4_lookup_expiring(struct dentry *dentry,
 	return NULL;
 }
 
-static int autofs4_mount_wait(const struct path *path, bool rcu_walk)
+static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(path->dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(path->dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(path->dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(path->dentry);
 	int status = 0;
 
 	if (ino->flags & AUTOFS_INF_PENDING) {
 		if (rcu_walk)
 			return -ECHILD;
 		pr_debug("waiting for mount name=%pd\n", path->dentry);
-		status = autofs4_wait(sbi, path, NFY_MOUNT);
+		status = autofs_wait(sbi, path, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
 	}
 	ino->last_used = jiffies;
@@ -291,11 +291,11 @@ static int do_expire_wait(const struct path *path, bool rcu_walk)
 	struct dentry *dentry = path->dentry;
 	struct dentry *expiring;
 
-	expiring = autofs4_lookup_expiring(dentry, rcu_walk);
+	expiring = autofs_lookup_expiring(dentry, rcu_walk);
 	if (IS_ERR(expiring))
 		return PTR_ERR(expiring);
 	if (!expiring)
-		return autofs4_expire_wait(path, rcu_walk);
+		return autofs_expire_wait(path, rcu_walk);
 	else {
 		const struct path this = { .mnt = path->mnt, .dentry = expiring };
 		/*
@@ -303,17 +303,17 @@ static int do_expire_wait(const struct path *path, bool rcu_walk)
 		 * be quite complete, but the directory has been removed
 		 * so it must have been successful, just wait for it.
 		 */
-		autofs4_expire_wait(&this, 0);
-		autofs4_del_expiring(expiring);
+		autofs_expire_wait(&this, 0);
+		autofs_del_expiring(expiring);
 		dput(expiring);
 	}
 	return 0;
 }
 
-static struct dentry *autofs4_mountpoint_changed(struct path *path)
+static struct dentry *autofs_mountpoint_changed(struct path *path)
 {
 	struct dentry *dentry = path->dentry;
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 
 	/*
 	 * If this is an indirect mount the dentry could have gone away
@@ -327,7 +327,7 @@ static struct dentry *autofs4_mountpoint_changed(struct path *path)
 		new = d_lookup(parent, &dentry->d_name);
 		if (!new)
 			return NULL;
-		ino = autofs4_dentry_ino(new);
+		ino = autofs_dentry_ino(new);
 		ino->last_used = jiffies;
 		dput(path->dentry);
 		path->dentry = new;
@@ -335,17 +335,17 @@ static struct dentry *autofs4_mountpoint_changed(struct path *path)
 	return path->dentry;
 }
 
-static struct vfsmount *autofs4_d_automount(struct path *path)
+static struct vfsmount *autofs_d_automount(struct path *path)
 {
 	struct dentry *dentry = path->dentry;
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	int status;
 
 	pr_debug("dentry=%p %pd\n", dentry, dentry);
 
 	/* The daemon never triggers a mount. */
-	if (autofs4_oz_mode(sbi))
+	if (autofs_oz_mode(sbi))
 		return NULL;
 
 	/*
@@ -364,7 +364,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 	spin_lock(&sbi->fs_lock);
 	if (ino->flags & AUTOFS_INF_PENDING) {
 		spin_unlock(&sbi->fs_lock);
-		status = autofs4_mount_wait(path, 0);
+		status = autofs_mount_wait(path, 0);
 		if (status)
 			return ERR_PTR(status);
 		goto done;
@@ -405,7 +405,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 		}
 		ino->flags |= AUTOFS_INF_PENDING;
 		spin_unlock(&sbi->fs_lock);
-		status = autofs4_mount_wait(path, 0);
+		status = autofs_mount_wait(path, 0);
 		spin_lock(&sbi->fs_lock);
 		ino->flags &= ~AUTOFS_INF_PENDING;
 		if (status) {
@@ -416,24 +416,24 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 	spin_unlock(&sbi->fs_lock);
 done:
 	/* Mount succeeded, check if we ended up with a new dentry */
-	dentry = autofs4_mountpoint_changed(path);
+	dentry = autofs_mountpoint_changed(path);
 	if (!dentry)
 		return ERR_PTR(-ENOENT);
 
 	return NULL;
 }
 
-static int autofs4_d_manage(const struct path *path, bool rcu_walk)
+static int autofs_d_manage(const struct path *path, bool rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	int status;
 
 	pr_debug("dentry=%p %pd\n", dentry, dentry);
 
 	/* The daemon never waits. */
-	if (autofs4_oz_mode(sbi)) {
+	if (autofs_oz_mode(sbi)) {
 		if (!path_is_mountpoint(path))
 			return -EISDIR;
 		return 0;
@@ -447,7 +447,7 @@ static int autofs4_d_manage(const struct path *path, bool rcu_walk)
 	 * This dentry may be under construction so wait on mount
 	 * completion.
 	 */
-	status = autofs4_mount_wait(path, rcu_walk);
+	status = autofs_mount_wait(path, rcu_walk);
 	if (status)
 		return status;
 
@@ -500,8 +500,8 @@ static int autofs4_d_manage(const struct path *path, bool rcu_walk)
 }
 
 /* Lookups in the root directory */
-static struct dentry *autofs4_lookup(struct inode *dir,
-				     struct dentry *dentry, unsigned int flags)
+static struct dentry *autofs_lookup(struct inode *dir,
+				    struct dentry *dentry, unsigned int flags)
 {
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
@@ -513,13 +513,13 @@ static struct dentry *autofs4_lookup(struct inode *dir,
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	sbi = autofs4_sbi(dir->i_sb);
+	sbi = autofs_sbi(dir->i_sb);
 
 	pr_debug("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
 		 current->pid, task_pgrp_nr(current), sbi->catatonic,
-		 autofs4_oz_mode(sbi));
+		 autofs_oz_mode(sbi));
 
-	active = autofs4_lookup_active(dentry);
+	active = autofs_lookup_active(dentry);
 	if (active)
 		return active;
 	else {
@@ -529,7 +529,7 @@ static struct dentry *autofs4_lookup(struct inode *dir,
 		 * can return fail immediately.  The daemon however does need
 		 * to create directories within the file system.
 		 */
-		if (!autofs4_oz_mode(sbi) && !IS_ROOT(dentry->d_parent))
+		if (!autofs_oz_mode(sbi) && !IS_ROOT(dentry->d_parent))
 			return ERR_PTR(-ENOENT);
 
 		/* Mark entries in the root as mount triggers */
@@ -537,24 +537,24 @@ static struct dentry *autofs4_lookup(struct inode *dir,
 		    autofs_type_indirect(sbi->type))
 			__managed_dentry_set_managed(dentry);
 
-		ino = autofs4_new_ino(sbi);
+		ino = autofs_new_ino(sbi);
 		if (!ino)
 			return ERR_PTR(-ENOMEM);
 
 		dentry->d_fsdata = ino;
 		ino->dentry = dentry;
 
-		autofs4_add_active(dentry);
+		autofs_add_active(dentry);
 	}
 	return NULL;
 }
 
-static int autofs4_dir_symlink(struct inode *dir, 
+static int autofs_dir_symlink(struct inode *dir,
 			       struct dentry *dentry,
 			       const char *symname)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	struct inode *inode;
 	size_t size = strlen(symname);
@@ -562,14 +562,14 @@ static int autofs4_dir_symlink(struct inode *dir,
 
 	pr_debug("%s <- %pd\n", symname, dentry);
 
-	if (!autofs4_oz_mode(sbi))
+	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
 	BUG_ON(!ino);
 
-	autofs4_clean_ino(ino);
+	autofs_clean_ino(ino);
 
-	autofs4_del_active(dentry);
+	autofs_del_active(dentry);
 
 	cp = kmalloc(size + 1, GFP_KERNEL);
 	if (!cp)
@@ -577,7 +577,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 
 	strcpy(cp, symname);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFLNK | 0555);
+	inode = autofs_get_inode(dir->i_sb, S_IFLNK | 0555);
 	if (!inode) {
 		kfree(cp);
 		return -ENOMEM;
@@ -588,7 +588,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 
 	dget(dentry);
 	atomic_inc(&ino->count);
-	p_ino = autofs4_dentry_ino(dentry->d_parent);
+	p_ino = autofs_dentry_ino(dentry->d_parent);
 	if (p_ino && !IS_ROOT(dentry))
 		atomic_inc(&p_ino->count);
 
@@ -610,20 +610,20 @@ static int autofs4_dir_symlink(struct inode *dir,
  * If a process is blocked on the dentry waiting for the expire to finish,
  * it will invalidate the dentry and try to mount with a new one.
  *
- * Also see autofs4_dir_rmdir()..
+ * Also see autofs_dir_rmdir()..
  */
-static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
+static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
 	/* This allows root to remove symlinks */
-	if (!autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
+	if (!autofs_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	if (atomic_dec_and_test(&ino->count)) {
-		p_ino = autofs4_dentry_ino(dentry->d_parent);
+		p_ino = autofs_dentry_ino(dentry->d_parent);
 		if (p_ino && !IS_ROOT(dentry))
 			atomic_dec(&p_ino->count);
 	}
@@ -635,7 +635,7 @@ static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 	dir->i_mtime = current_time(dir);
 
 	spin_lock(&sbi->lookup_lock);
-	__autofs4_add_expiring(dentry);
+	__autofs_add_expiring(dentry);
 	d_drop(dentry);
 	spin_unlock(&sbi->lookup_lock);
 
@@ -692,15 +692,15 @@ static void autofs_clear_leaf_automount_flags(struct dentry *dentry)
 		managed_dentry_set_managed(parent);
 }
 
-static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
+static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
 	pr_debug("dentry %p, removing %pd\n", dentry, dentry);
 
-	if (!autofs4_oz_mode(sbi))
+	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
 	spin_lock(&sbi->lookup_lock);
@@ -708,7 +708,7 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&sbi->lookup_lock);
 		return -ENOTEMPTY;
 	}
-	__autofs4_add_expiring(dentry);
+	__autofs_add_expiring(dentry);
 	d_drop(dentry);
 	spin_unlock(&sbi->lookup_lock);
 
@@ -716,7 +716,7 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 		autofs_clear_leaf_automount_flags(dentry);
 
 	if (atomic_dec_and_test(&ino->count)) {
-		p_ino = autofs4_dentry_ino(dentry->d_parent);
+		p_ino = autofs_dentry_ino(dentry->d_parent);
 		if (p_ino && dentry->d_parent != dentry)
 			atomic_dec(&p_ino->count);
 	}
@@ -730,26 +730,26 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	return 0;
 }
 
-static int autofs4_dir_mkdir(struct inode *dir,
-			     struct dentry *dentry, umode_t mode)
+static int autofs_dir_mkdir(struct inode *dir,
+			    struct dentry *dentry, umode_t mode)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
+	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	struct inode *inode;
 
-	if (!autofs4_oz_mode(sbi))
+	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
 	pr_debug("dentry %p, creating %pd\n", dentry, dentry);
 
 	BUG_ON(!ino);
 
-	autofs4_clean_ino(ino);
+	autofs_clean_ino(ino);
 
-	autofs4_del_active(dentry);
+	autofs_del_active(dentry);
 
-	inode = autofs4_get_inode(dir->i_sb, S_IFDIR | mode);
+	inode = autofs_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
 		return -ENOMEM;
 	d_add(dentry, inode);
@@ -759,7 +759,7 @@ static int autofs4_dir_mkdir(struct inode *dir,
 
 	dget(dentry);
 	atomic_inc(&ino->count);
-	p_ino = autofs4_dentry_ino(dentry->d_parent);
+	p_ino = autofs_dentry_ino(dentry->d_parent);
 	if (p_ino && !IS_ROOT(dentry))
 		atomic_inc(&p_ino->count);
 	inc_nlink(dir);
@@ -770,7 +770,7 @@ static int autofs4_dir_mkdir(struct inode *dir,
 
 /* Get/set timeout ioctl() operation */
 #ifdef CONFIG_COMPAT
-static inline int autofs4_compat_get_set_timeout(struct autofs_sb_info *sbi,
+static inline int autofs_compat_get_set_timeout(struct autofs_sb_info *sbi,
 						 compat_ulong_t __user *p)
 {
 	unsigned long ntimeout;
@@ -795,7 +795,7 @@ static inline int autofs4_compat_get_set_timeout(struct autofs_sb_info *sbi,
 }
 #endif
 
-static inline int autofs4_get_set_timeout(struct autofs_sb_info *sbi,
+static inline int autofs_get_set_timeout(struct autofs_sb_info *sbi,
 					  unsigned long __user *p)
 {
 	unsigned long ntimeout;
@@ -820,14 +820,14 @@ static inline int autofs4_get_set_timeout(struct autofs_sb_info *sbi,
 }
 
 /* Return protocol version */
-static inline int autofs4_get_protover(struct autofs_sb_info *sbi,
+static inline int autofs_get_protover(struct autofs_sb_info *sbi,
 				       int __user *p)
 {
 	return put_user(sbi->version, p);
 }
 
 /* Return protocol sub version */
-static inline int autofs4_get_protosubver(struct autofs_sb_info *sbi,
+static inline int autofs_get_protosubver(struct autofs_sb_info *sbi,
 					  int __user *p)
 {
 	return put_user(sbi->sub_version, p);
@@ -836,7 +836,7 @@ static inline int autofs4_get_protosubver(struct autofs_sb_info *sbi,
 /*
 * Tells the daemon whether it can umount the autofs mount.
 */
-static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
+static inline int autofs_ask_umount(struct vfsmount *mnt, int __user *p)
 {
 	int status = 0;
 
@@ -850,14 +850,14 @@ static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
 	return status;
 }
 
-/* Identify autofs4_dentries - this is so we can tell if there's
+/* Identify autofs_dentries - this is so we can tell if there's
  * an extra dentry refcount or not.  We only hold a refcount on the
  * dentry if its non-negative (ie, d_inode != NULL)
  */
-int is_autofs4_dentry(struct dentry *dentry)
+int is_autofs_dentry(struct dentry *dentry)
 {
 	return dentry && d_really_is_positive(dentry) &&
-		dentry->d_op == &autofs4_dentry_operations &&
+		dentry->d_op == &autofs_dentry_operations &&
 		dentry->d_fsdata != NULL;
 }
 
@@ -865,10 +865,10 @@ int is_autofs4_dentry(struct dentry *dentry)
  * ioctl()'s on the root directory is the chief method for the daemon to
  * generate kernel reactions
  */
-static int autofs4_root_ioctl_unlocked(struct inode *inode, struct file *filp,
+static int autofs_root_ioctl_unlocked(struct inode *inode, struct file *filp,
 				       unsigned int cmd, unsigned long arg)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
+	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
 	void __user *p = (void __user *)arg;
 
 	pr_debug("cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
@@ -878,64 +878,63 @@ static int autofs4_root_ioctl_unlocked(struct inode *inode, struct file *filp,
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT)
 		return -ENOTTY;
 
-	if (!autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
+	if (!autofs_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	switch (cmd) {
 	case AUTOFS_IOC_READY:	/* Wait queue: go ahead and retry */
-		return autofs4_wait_release(sbi, (autofs_wqt_t) arg, 0);
+		return autofs_wait_release(sbi, (autofs_wqt_t) arg, 0);
 	case AUTOFS_IOC_FAIL:	/* Wait queue: fail with ENOENT */
-		return autofs4_wait_release(sbi, (autofs_wqt_t) arg, -ENOENT);
+		return autofs_wait_release(sbi, (autofs_wqt_t) arg, -ENOENT);
 	case AUTOFS_IOC_CATATONIC: /* Enter catatonic mode (daemon shutdown) */
-		autofs4_catatonic_mode(sbi);
+		autofs_catatonic_mode(sbi);
 		return 0;
 	case AUTOFS_IOC_PROTOVER: /* Get protocol version */
-		return autofs4_get_protover(sbi, p);
+		return autofs_get_protover(sbi, p);
 	case AUTOFS_IOC_PROTOSUBVER: /* Get protocol sub version */
-		return autofs4_get_protosubver(sbi, p);
+		return autofs_get_protosubver(sbi, p);
 	case AUTOFS_IOC_SETTIMEOUT:
-		return autofs4_get_set_timeout(sbi, p);
+		return autofs_get_set_timeout(sbi, p);
 #ifdef CONFIG_COMPAT
 	case AUTOFS_IOC_SETTIMEOUT32:
-		return autofs4_compat_get_set_timeout(sbi, p);
+		return autofs_compat_get_set_timeout(sbi, p);
 #endif
 
 	case AUTOFS_IOC_ASKUMOUNT:
-		return autofs4_ask_umount(filp->f_path.mnt, p);
+		return autofs_ask_umount(filp->f_path.mnt, p);
 
 	/* return a single thing to expire */
 	case AUTOFS_IOC_EXPIRE:
-		return autofs4_expire_run(inode->i_sb,
-					  filp->f_path.mnt, sbi, p);
+		return autofs_expire_run(inode->i_sb, filp->f_path.mnt, sbi, p);
 	/* same as above, but can send multiple expires through pipe */
 	case AUTOFS_IOC_EXPIRE_MULTI:
-		return autofs4_expire_multi(inode->i_sb,
-					    filp->f_path.mnt, sbi, p);
+		return autofs_expire_multi(inode->i_sb,
+					   filp->f_path.mnt, sbi, p);
 
 	default:
 		return -EINVAL;
 	}
 }
 
-static long autofs4_root_ioctl(struct file *filp,
+static long autofs_root_ioctl(struct file *filp,
 			       unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
-	return autofs4_root_ioctl_unlocked(inode, filp, cmd, arg);
+	return autofs_root_ioctl_unlocked(inode, filp, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
-static long autofs4_root_compat_ioctl(struct file *filp,
+static long autofs_root_compat_ioctl(struct file *filp,
 				      unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
 	if (cmd == AUTOFS_IOC_READY || cmd == AUTOFS_IOC_FAIL)
-		ret = autofs4_root_ioctl_unlocked(inode, filp, cmd, arg);
+		ret = autofs_root_ioctl_unlocked(inode, filp, cmd, arg);
 	else
-		ret = autofs4_root_ioctl_unlocked(inode, filp, cmd,
+		ret = autofs_root_ioctl_unlocked(inode, filp, cmd,
 					      (unsigned long) compat_ptr(arg));
 
 	return ret;
diff --git a/fs/autofs4/symlink.c b/fs/autofs4/symlink.c
index ab0b4285a202..aad3902c0cc1 100644
--- a/fs/autofs4/symlink.c
+++ b/fs/autofs4/symlink.c
@@ -8,22 +8,22 @@
 
 #include "autofs_i.h"
 
-static const char *autofs4_get_link(struct dentry *dentry,
-				    struct inode *inode,
-				    struct delayed_call *done)
+static const char *autofs_get_link(struct dentry *dentry,
+				   struct inode *inode,
+				   struct delayed_call *done)
 {
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
-	sbi = autofs4_sbi(dentry->d_sb);
-	ino = autofs4_dentry_ino(dentry);
-	if (ino && !autofs4_oz_mode(sbi))
+	sbi = autofs_sbi(dentry->d_sb);
+	ino = autofs_dentry_ino(dentry);
+	if (ino && !autofs_oz_mode(sbi))
 		ino->last_used = jiffies;
 	return d_inode(dentry)->i_private;
 }
 
-const struct inode_operations autofs4_symlink_inode_operations = {
-	.get_link	= autofs4_get_link
+const struct inode_operations autofs_symlink_inode_operations = {
+	.get_link	= autofs_get_link
 };
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index be9c3dc048ab..8a566fa66afe 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -17,9 +17,9 @@
 /* We make this a static variable rather than a part of the superblock; it
  * is better if we don't reassign numbers easily even across filesystems
  */
-static autofs_wqt_t autofs4_next_wait_queue = 1;
+static autofs_wqt_t autofs_next_wait_queue = 1;
 
-void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
+void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 {
 	struct autofs_wait_queue *wq, *nwq;
 
@@ -49,8 +49,8 @@ void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
 	mutex_unlock(&sbi->wq_mutex);
 }
 
-static int autofs4_write(struct autofs_sb_info *sbi,
-			 struct file *file, const void *addr, int bytes)
+static int autofs_write(struct autofs_sb_info *sbi,
+			struct file *file, const void *addr, int bytes)
 {
 	unsigned long sigpipe, flags;
 	const char *data = (const char *)addr;
@@ -82,7 +82,7 @@ static int autofs4_write(struct autofs_sb_info *sbi,
 	return bytes == 0 ? 0 : wr < 0 ? wr : -EIO;
 }
 
-static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
+static void autofs_notify_daemon(struct autofs_sb_info *sbi,
 				 struct autofs_wait_queue *wq,
 				 int type)
 {
@@ -167,23 +167,23 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 
 	mutex_unlock(&sbi->wq_mutex);
 
-	switch (ret = autofs4_write(sbi, pipe, &pkt, pktsz)) {
+	switch (ret = autofs_write(sbi, pipe, &pkt, pktsz)) {
 	case 0:
 		break;
 	case -ENOMEM:
 	case -ERESTARTSYS:
 		/* Just fail this one */
-		autofs4_wait_release(sbi, wq->wait_queue_token, ret);
+		autofs_wait_release(sbi, wq->wait_queue_token, ret);
 		break;
 	default:
-		autofs4_catatonic_mode(sbi);
+		autofs_catatonic_mode(sbi);
 		break;
 	}
 	fput(pipe);
 }
 
-static int autofs4_getpath(struct autofs_sb_info *sbi,
-			   struct dentry *dentry, char **name)
+static int autofs_getpath(struct autofs_sb_info *sbi,
+			  struct dentry *dentry, char **name)
 {
 	struct dentry *root = sbi->sb->s_root;
 	struct dentry *tmp;
@@ -228,7 +228,7 @@ static int autofs4_getpath(struct autofs_sb_info *sbi,
 }
 
 static struct autofs_wait_queue *
-autofs4_find_wait(struct autofs_sb_info *sbi, const struct qstr *qstr)
+autofs_find_wait(struct autofs_sb_info *sbi, const struct qstr *qstr)
 {
 	struct autofs_wait_queue *wq;
 
@@ -263,7 +263,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 		return -ENOENT;
 
 	/* Wait in progress, continue; */
-	wq = autofs4_find_wait(sbi, qstr);
+	wq = autofs_find_wait(sbi, qstr);
 	if (wq) {
 		*wait = wq;
 		return 1;
@@ -272,7 +272,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 	*wait = NULL;
 
 	/* If we don't yet have any info this is a new request */
-	ino = autofs4_dentry_ino(dentry);
+	ino = autofs_dentry_ino(dentry);
 	if (!ino)
 		return 1;
 
@@ -297,7 +297,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 			if (sbi->catatonic)
 				return -ENOENT;
 
-			wq = autofs4_find_wait(sbi, qstr);
+			wq = autofs_find_wait(sbi, qstr);
 			if (wq) {
 				*wait = wq;
 				return 1;
@@ -351,7 +351,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 	return 1;
 }
 
-int autofs4_wait(struct autofs_sb_info *sbi,
+int autofs_wait(struct autofs_sb_info *sbi,
 		 const struct path *path, enum autofs_notify notify)
 {
 	struct dentry *dentry = path->dentry;
@@ -399,7 +399,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 	if (IS_ROOT(dentry) && autofs_type_trigger(sbi->type))
 		qstr.len = sprintf(name, "%p", dentry);
 	else {
-		qstr.len = autofs4_getpath(sbi, dentry, &name);
+		qstr.len = autofs_getpath(sbi, dentry, &name);
 		if (!qstr.len) {
 			kfree(name);
 			return -ENOENT;
@@ -430,15 +430,15 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 			return -ENOMEM;
 		}
 
-		wq->wait_queue_token = autofs4_next_wait_queue;
-		if (++autofs4_next_wait_queue == 0)
-			autofs4_next_wait_queue = 1;
+		wq->wait_queue_token = autofs_next_wait_queue;
+		if (++autofs_next_wait_queue == 0)
+			autofs_next_wait_queue = 1;
 		wq->next = sbi->queues;
 		sbi->queues = wq;
 		init_waitqueue_head(&wq->queue);
 		memcpy(&wq->name, &qstr, sizeof(struct qstr));
-		wq->dev = autofs4_get_dev(sbi);
-		wq->ino = autofs4_get_ino(sbi);
+		wq->dev = autofs_get_dev(sbi);
+		wq->ino = autofs_get_ino(sbi);
 		wq->uid = current_uid();
 		wq->gid = current_gid();
 		wq->pid = pid;
@@ -467,9 +467,9 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 			 wq->name.name, notify);
 
 		/*
-		 * autofs4_notify_daemon() may block; it will unlock ->wq_mutex
+		 * autofs_notify_daemon() may block; it will unlock ->wq_mutex
 		 */
-		autofs4_notify_daemon(sbi, wq, type);
+		autofs_notify_daemon(sbi, wq, type);
 	} else {
 		wq->wait_ctr++;
 		pr_debug("existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
@@ -500,12 +500,12 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 		struct dentry *de = NULL;
 
 		/* direct mount or browsable map */
-		ino = autofs4_dentry_ino(dentry);
+		ino = autofs_dentry_ino(dentry);
 		if (!ino) {
 			/* If not lookup actual dentry used */
 			de = d_lookup(dentry->d_parent, &dentry->d_name);
 			if (de)
-				ino = autofs4_dentry_ino(de);
+				ino = autofs_dentry_ino(de);
 		}
 
 		/* Set mount requester */
@@ -530,7 +530,8 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 }
 
 
-int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_token, int status)
+int autofs_wait_release(struct autofs_sb_info *sbi,
+			autofs_wqt_t wait_queue_token, int status)
 {
 	struct autofs_wait_queue *wq, **wql;
 
