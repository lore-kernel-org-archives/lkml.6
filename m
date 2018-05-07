Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525682857-2-5093723758588415086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682856; b=kOBa4Eo9g4v7ryWWPwcIJW+AJayF6QMZXbARmWsNaXMbYJPYec
    VKbdx5Fcv/P+i+aYoJAZW2G/9W70AYsjhFdbjX0iLwMG5ShZnIFicghsmuqnmQ9Z
    Xir+MRRGirLFAFdC7BWLZfzYccTmWIinqVJWVOPEcXEtzfhm35lc9vJrQOxoVD6F
    cgVmsuDbVNWYZEWBkb35zUG8oantw4Ed0nGZNpRRmTBqbrTB2nrHFXuKPUdls3WG
    3Nbr/wLVvRSlQGs2lPmI8OVIfZAIUeCBLaery34W9y2z7P372iSB3repE+V0QJov
    crnb6GGvQi3/SJwwByXjN/eCZlk/KyLWz4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682856; bh=
    nyDOuW1GfPZQ1GZQbmZzRzhKXJNNA2S5T6nZHJoQFag=; b=aOMaTcWC6hMCkVDn
    mVWnUXngv64rPwUbnq/S1Sf8/g67qf0OqNGAeZb/B1pdz8JvuKEuBe0fgdZhxnoR
    3vzL+q2R5KPZeNB0LpwDcVhhcGF37lCo7LuFWeZ9BPuQ3XSQX9i3tkd/Nzz1E5PI
    k7dmXIFk8mR6wCb0oBMdUj8cPdocKZd8a2FAmJ2UrvKY+6wTwAnPvS7xcDn4JSj5
    n3rIEAUHipSJbvUzMvypOPccfPQFD2caOr8aaGeUgEb0hZGudwnhWtUHZEXfmWgX
    kSz5BisirWOz+fdQBOohnbZRPHImwPK//cLRsCpjoLBUJY9cufbAo7lUqdaKvjJv
    /tI19w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=XLFlFvR1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
      header.i=@1e100.net header.b=XLFlFvR1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNtuiV82ctnLRpjSoytuGD/rCcxQR9NNqem9d6hEbonOcT4SpmN4JDW47xjt/FqexYEDoaH/CtLs0Nll3yhyR2/jOOcWjoK+Bh+cq2sKUDHn0kmASE4m
    GSmqthFfaCVgbuXWwDVD1jk2HKMmgYiznwqnLzrf76sURvnYuopNszsh1yHcUZrn39dVIeBpRp9wyTsryYpcpfQ2l8q2+BYQoalbKInlCPP4WQFwyONYcu7b
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=aXjWnk5xiyF4Ijyz-fwA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeEGIrd (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:47:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54681 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEGIi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:27 -0400
X-Google-Smtp-Source: AB8JxZp/dGd+H7MdCID0GFouLxSzRnk4liAmi36vCNiMyZ4HpJkI26tvMQEAdbdS355Ryy+8H9+HEQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/35] ovl: stack file ops
Date: Mon,  7 May 2018 10:37:43 +0200
Message-Id: <20180507083807.28792-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement file operations on a regular overlay file.  The underlying file
is opened separately and cached in ->private_data.

It might be worth making an exception for such files when accounting in
nr_file to confirm to userspace expectations.  We are only adding a small
overhead (248bytes for the struct file) since the real inode and dentry are
pinned by overlayfs anyway.

This patch doesn't have any effect, since the vfs will use d_real() to find
the real underlying file to open.  The patch at the end of the series will
actually enable this functionality.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/Makefile    |  4 +--
 fs/overlayfs/file.c      | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/inode.c     |  1 +
 fs/overlayfs/overlayfs.h |  3 ++
 4 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 fs/overlayfs/file.c

diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
index 30802347a020..46e1ff8ac056 100644
--- a/fs/overlayfs/Makefile
+++ b/fs/overlayfs/Makefile
@@ -4,5 +4,5 @@
 
 obj-$(CONFIG_OVERLAY_FS) += overlay.o
 
-overlay-objs := super.o namei.o util.o inode.o dir.o readdir.o copy_up.o \
-		export.o
+overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
+		copy_up.o export.o
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
new file mode 100644
index 000000000000..a0b606885c41
--- /dev/null
+++ b/fs/overlayfs/file.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/cred.h>
+#include <linux/file.h>
+#include <linux/xattr.h>
+#include "overlayfs.h"
+
+static struct file *ovl_open_realfile(const struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct inode *upperinode = ovl_inode_upper(inode);
+	struct inode *realinode = upperinode ?: ovl_inode_lower(inode);
+	struct file *realfile;
+	const struct cred *old_cred;
+
+	old_cred = ovl_override_creds(inode->i_sb);
+	realfile = path_open(&file->f_path, file->f_flags | O_NOATIME,
+			     realinode, current_cred(), false);
+	revert_creds(old_cred);
+
+	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
+		 file, file, upperinode ? 'u' : 'l', file->f_flags,
+		 realfile, IS_ERR(realfile) ? 0 : realfile->f_flags);
+
+	return realfile;
+}
+
+static int ovl_open(struct inode *inode, struct file *file)
+{
+	struct dentry *dentry = file_dentry(file);
+	struct file *realfile;
+	int err;
+
+	err = ovl_open_maybe_copy_up(dentry, file->f_flags);
+	if (err)
+		return err;
+
+	/* No longer need these flags, so don't pass them on to underlying fs */
+	file->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+
+	realfile = ovl_open_realfile(file);
+	if (IS_ERR(realfile))
+		return PTR_ERR(realfile);
+
+	file->private_data = realfile;
+
+	return 0;
+}
+
+static int ovl_release(struct inode *inode, struct file *file)
+{
+	fput(file->private_data);
+
+	return 0;
+}
+
+static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *realinode = ovl_inode_real(file_inode(file));
+
+	return generic_file_llseek_size(file, offset, whence,
+					realinode->i_sb->s_maxbytes,
+					i_size_read(realinode));
+}
+
+const struct file_operations ovl_file_operations = {
+	.open		= ovl_open,
+	.release	= ovl_release,
+	.llseek		= ovl_llseek,
+};
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ba3f832cc39a..a228eda66ad8 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -535,6 +535,7 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
 	switch (mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &ovl_file_inode_operations;
+		inode->i_fop = &ovl_file_operations;
 		break;
 
 	case S_IFDIR:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b9f7c632ab9c..edbf69c8f45d 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -374,6 +374,9 @@ int ovl_create_real(struct inode *dir, struct dentry *newdentry,
 		    struct dentry *hardlink, bool debug);
 int ovl_cleanup(struct inode *dir, struct dentry *dentry);
 
+/* file.c */
+extern const struct file_operations ovl_file_operations;
+
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
 int ovl_copy_up_flags(struct dentry *dentry, int flags);
-- 
2.14.3
