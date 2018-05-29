Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2266183-1527607003-2-858659171954545629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527607003; b=A5TmDjUXjGEAEd4yUfae7Gh1cklYqqbI77cXGhk6II//BCdDN0
    0Pq9wHh0LxGQDs41dskCQZ1CYzsYkH4KxLheN78hc/Z3mR3fHpL197OlYWRNrrz5
    BvJoWKApD1ajQeC3G1SwGeF5fuxE7cGwRbkclAXwr0GeZrh0LwoEbdE1AgyOTE+8
    rz1+tB/IbM+BtQ1VnRksGxVtz1+4WXfWRXI6gNg99pXwBCSC3PEO6aTyzLF2tLzp
    UBjsI57rFQyQK2fKKwlhdwZvXXobsHDslFullX8e3KIGb0FMrzmpS+jEGNGQmjEu
    4zylncvEhkw7Cfi3tpKLkPqYRg4GKsyZT6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527607003; bh=
    AbzXEJ2DJkU2de4G05wtLhU0a2oEI4FZQ0U4xdmiYpk=; b=dy1RR3Nh7gYRor25
    b1QFWb2zq8e4i+GBlkA/fNwcvUTgdqE1J8D1YocOx7S0RCYuugxhigU2LfwN3jF+
    CRKAD9OkoW4CffZRKkMJN2p4tLqr4HnnxCEqrQteIRe8ge75bBvvEzyw0FoDBLSL
    yEwMMaTFyf6cgdLe8y0JBOvU1x8jKRqlKvbMPr51pqTAaTMmrHRLqsi8vAW02fTP
    juM0K+JBn6+XuuiHMSGcsYOx9pQ0nsKnknEMoOjvbb6DEO73HiRFxf/zbUo0a8/C
    ZtK95i8ntzWLVyMyFuTnkvr3ei+eOqc4gqRAMQFkCVrfI1JQ/P5d3dz2S8OrIdGz
    T8m/WA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Xc2iMEEU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Xc2iMEEU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNQFnesnRpdMGxMtpC6UIJm6e9U9cGI8651PwSWPEemhUJXp8qgD+I2gXTgGIh4TCoJnZRN77Pr1TVf8GHwpksNRZBfI9/FX6kIPQ5KiFL6GZp5Uzc8X
    bjmZ9P4CltfBQME6MPVFT9zQC7dFI3Izh+h1N7nrR/iXR5pu6EZFlXc4SudMjbUruSd/OT0B9g3B9OUPoyljLGY0XKIT37Qro9/78iszJOMphfuExrzNNamD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=jODR8vyYUQY6K4GUbjgA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935561AbeE2PQc (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:16:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39454 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935521AbeE2Onq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:46 -0400
X-Google-Smtp-Source: AB8JxZpifNHhpXYS8pKAfF98RIuaQIHE+nPJYUyd19cit16jvpXhhpODLKSP7domxZM/qhRfDw1G/w==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/39] vfs: add path_open()
Date: Tue, 29 May 2018 16:43:04 +0200
Message-Id: <20180529144339.16538-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently opening an overlay file results in:

 - the real file on the underlying layer being opened
 - f_path being set to the overlay {mount, dentry} pair

This patch adds a new helper that allows the above to be explicitly
performed.  I.e. it's the same as dentry_open(), except the underlying
inode to open is given as a separate argument.

This is in preparation for stacking I/O operations on overlay files.

Later, when implicit opening is removed, dentry_open() can be implemented
by just calling path_open().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/open.c          | 31 +++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index c5ee7cd60424..d0bf7f061a1a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -906,6 +906,37 @@ int vfs_open(const struct path *path, struct file *file,
 	return do_dentry_open(file, d_backing_inode(dentry), NULL, cred);
 }
 
+/**
+ * path_open() - Open an inode by a particular name.
+ * @path: The name of the file.
+ * @flags: The O_ flags used to open this file.
+ * @inode: The inode to open.
+ * @cred: The task's credentials used when opening this file.
+ *
+ * Context: Process context.
+ * Return: A pointer to a struct file or an IS_ERR pointer.  Cannot return NULL.
+ */
+struct file *path_open(const struct path *path, int flags, struct inode *inode,
+		       const struct cred *cred)
+{
+	struct file *file;
+	int retval;
+
+	file = get_empty_filp();
+	if (IS_ERR(file))
+		return file;
+
+	file->f_flags = flags;
+	file->f_path = *path;
+	retval = do_dentry_open(file, inode, NULL, cred);
+	if (retval) {
+		put_filp(file);
+		return ERR_PTR(retval);
+	}
+	return file;
+}
+EXPORT_SYMBOL(path_open);
+
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *cred)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b0f290944220..9473e68280d0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2401,6 +2401,8 @@ extern struct file *filp_open(const char *, int, umode_t);
 extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 				   const char *, int, umode_t);
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
+extern struct file *path_open(const struct path *, int, struct inode *,
+			      const struct cred *);
 extern int filp_close(struct file *, fl_owner_t id);
 
 extern struct filename *getname_flags(const char __user *, int, int *);
-- 
2.14.3
