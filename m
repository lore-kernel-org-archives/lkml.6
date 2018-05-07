Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525682364-2-3219816404146431888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682364; b=KA033VbfAe1EQwHJyCS5uHHec35u3WVkNDr5FnXoX72zuXcQfK
    XeMKOSVHRnafdfiJA0gEpUEA7d/fiGGoLVbuTk8t9Fo+9+HYo/KHMD3Nsw2p1iMk
    NmPa/9PYu9h/Y0/ianUyRHz51hEjeB1yQ9jETfpb16MLp+PWe1oN1bnMQ78s946q
    2+/F0eK/iru5tvDSawuqijIES3MLOlWejZL9ziToDHR5XoXjdO1l8lwtX/ay9zSO
    kLW2ovUc3j4KpJvrSQrJk4m8Mk5IXFHdbieHQDsw6nF3OEAphBf1wsm3kHTyKNiq
    bbg3NOgIULH5SgDUfYt60oHCeC6DhfhMG1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682364; bh=
    EBEyBbqX9UbP7p8udqxnyX4KQqFGOzlOw0RZmVtI6C4=; b=YbRlfJCJQlSGFMQ5
    eENLftnDyBQLB9/0lWxEroFi7D/0Ja+7uVazlPz17FcbIbrTuvLSaRjUDVCHBFaK
    HyUaQ/0pKzY63oI0h29pVqGnb1bykhoWMi32tYta2W3gBcI5vw5zG591VU2mJVsZ
    ADvMRXbKFv731i8A98NUSqys7YIsW646zi0I0Pz4x6lC2gD6BM9/2ny6NwTBYAyr
    cDi3Vrszv9XFJq3ER+RkfTtj9bs/fEhmeym0WEamddvECWST8yoGId+caafEGu0d
    Js94pAUDz7hZIeuqQ4vVRo2hvy13jDXGkoofUTicEih5p7wkrkNIsjmTdRMS2Z09
    6rUbXQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Qer7c3qa;
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
      header.i=@1e100.net header.b=Qer7c3qa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCN72F2isWNzox/Qg+gxb+sJ7iv65hkpaeFS18inGWc0UNquz209S99gJ8FnCR72ssRyfXF1RaOhsYyEtfKL/vobZ5V6Y9kwuokmxKBaH4ZuCBfX3CKe
    r4z8dbvVwO6Mzd2yXZ31tNhp1bJldCaSzwY9yTDfh52/sol77hQG08mvOZaejol6IqvggzSXU17EEXwQ5TBB6yyOEeQ3OH8Zy3AHy8GAVVVVtxF6q3FQ20we
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pBhbV5qpCsFxkKD1F8MA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeEGIjU (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:39:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35649 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeEGIis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:48 -0400
X-Google-Smtp-Source: AB8JxZptShi+Wi2R7XjstQpKDaDqceqHkWtLvB+NDiDy//+KwgPY/PID26xNr47Ce5f5dRNy947lSw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 30/35] Revert "vfs: add flags to d_real()"
Date: Mon,  7 May 2018 10:38:02 +0200
Message-Id: <20180507083807.28792-31-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 495e642939114478a5237a7d91661ba93b76f15a.

No user of "flags" argument of d_real() remain.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/Locking |  2 +-
 Documentation/filesystems/vfs.txt |  2 +-
 fs/open.c                         |  2 +-
 fs/overlayfs/super.c              |  4 ++--
 include/linux/dcache.h            | 11 +++++------
 include/linux/fs.h                |  2 +-
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 60e76060baff..a4afe96f0112 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -22,7 +22,7 @@ prototypes:
 	struct vfsmount *(*d_automount)(struct path *path);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
-				 unsigned int, unsigned int);
+				 unsigned int);
 
 locking rules:
 		rename_lock	->d_lock	may block	rcu-walk
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 2bc77ea8aef4..af54d3651ff8 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -991,7 +991,7 @@ struct dentry_operations {
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
-				 unsigned int, unsigned int);
+				 unsigned int);
 };
 
   d_revalidate: called when the VFS needs to revalidate a dentry. This
diff --git a/fs/open.c b/fs/open.c
index 2db39216c393..127b49819afb 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -96,7 +96,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	 * write access on the upper inode, not on the overlay inode.  For
 	 * non-overlay filesystems d_real() is an identity function.
 	 */
-	upperdentry = d_real(path->dentry, NULL, O_WRONLY, 0);
+	upperdentry = d_real(path->dentry, NULL, O_WRONLY);
 	error = PTR_ERR(upperdentry);
 	if (IS_ERR(upperdentry))
 		goto mnt_drop_write_and_out;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 006dc70d7425..7779fc610767 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -98,7 +98,7 @@ static int ovl_check_append_only(struct inode *inode, int flag)
 
 static struct dentry *ovl_d_real(struct dentry *dentry,
 				 const struct inode *inode,
-				 unsigned int open_flags, unsigned int flags)
+				 unsigned int open_flags)
 {
 	struct dentry *real;
 	int err;
@@ -134,7 +134,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 		goto bug;
 
 	/* Handle recursion */
-	real = d_real(real, inode, open_flags, 0);
+	real = d_real(real, inode, open_flags);
 
 	if (!inode || inode == d_inode(real))
 		return real;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index b2b829bcb7c0..58fcc66ddccd 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -146,7 +146,7 @@ struct dentry_operations {
 	struct vfsmount *(*d_automount)(struct path *);
 	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
-				 unsigned int, unsigned int);
+				 unsigned int);
 } ____cacheline_aligned;
 
 /*
@@ -567,8 +567,7 @@ static inline struct dentry *d_backing_dentry(struct dentry *upper)
  * d_real - Return the real dentry
  * @dentry: the dentry to query
  * @inode: inode to select the dentry from multiple layers (can be NULL)
- * @open_flags: open flags to control copy-up behavior
- * @flags: flags to control what is returned by this function
+ * @flags: open flags to control copy-up behavior
  *
  * If dentry is on a union/overlay, then return the underlying, real dentry.
  * Otherwise return the dentry itself.
@@ -577,10 +576,10 @@ static inline struct dentry *d_backing_dentry(struct dentry *upper)
  */
 static inline struct dentry *d_real(struct dentry *dentry,
 				    const struct inode *inode,
-				    unsigned int open_flags, unsigned int flags)
+				    unsigned int flags)
 {
 	if (unlikely(dentry->d_flags & DCACHE_OP_REAL))
-		return dentry->d_op->d_real(dentry, inode, open_flags, flags);
+		return dentry->d_op->d_real(dentry, inode, flags);
 	else
 		return dentry;
 }
@@ -595,7 +594,7 @@ static inline struct dentry *d_real(struct dentry *dentry,
 static inline struct inode *d_real_inode(const struct dentry *dentry)
 {
 	/* This usage of d_real() results in const dentry */
-	return d_backing_inode(d_real((struct dentry *) dentry, NULL, 0, 0));
+	return d_backing_inode(d_real((struct dentry *) dentry, NULL, 0));
 }
 
 struct name_snapshot {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ebe311541873..ba3078693d4a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1244,7 +1244,7 @@ static inline struct inode *file_inode(const struct file *f)
 
 static inline struct dentry *file_dentry(const struct file *file)
 {
-	return d_real(file->f_path.dentry, file_inode(file), 0, 0);
+	return d_real(file->f_path.dentry, file_inode(file), 0);
 }
 
 static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
-- 
2.14.3
