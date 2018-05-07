Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525683070-2-14873307388212769864
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525683070; b=nQGs3UxpxvzI4UkOEStBNdrrtW8vt1VPe5iEnIFgka7lGRIAYY
    2IXam4gvei54D4k6UzKzhYbK79jjo/sH1o1Ud+TY6qg9wt4xRuBkCvuHdq67aOio
    WYkCtuGFYBKMUYK9n/aNg5ng/f+An4fXski4pmXgBMxLVGSShsgn9k6FZ3ukA5S9
    QzdMeIu7TgfLndFlfUjR6+BSGkUmIG41eEi/ZMYmu9mSlANWOMcoTdyDhqa+atFm
    9nnNXlfaDjZkWSewHY2AN1mEq+l/XGIOW6T2rmgDv4iPzP54B4+vrRcw6cFneEgT
    mKvqdniFWrWbg2YUnXf2aWztYS99u1fevCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525683070; bh=
    +RDJddIFjdNcSUOK41IyhB9NRT1ehVcS+vZRXo3j+5k=; b=Bl+U1akvzFbX2hCq
    XR4bDt69+BxXgWuOj839s/RSi3MwU9xPxpsL7JIE059uCmY8+vHKEmfPeuEVH65X
    +l3VMW4d9ChBfb4tGZ0AXW+bcqsk7B/r/h18/aun3JAAy4QYFVQYHet+xrbKQlaa
    P5ndwOYv6Tp4pa1sKxVvVYVMwDtS32xY/O2TAqLS/M/gMEh5IdBTgR+bL9WLtmn7
    VOnPfuSvIutK1X62sHafkeyy5cLMl9DMesEH5wHVGjnKEvxbrkQwqRiSOKZY2Qmi
    KGin3pzl76IFRHjdy4bsG+YUOn9Y+oBZrXwWn6eeFA8B6WeGHWSYSrmURyFdyBJU
    FBCm8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=d5DBIj18;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=d5DBIj18;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNC+0rIKFEs1A0jq8OcrbMxEjO0Y6mUHEINopcrUFHwuK6RGW/cqi+VI4URS9zXeFKYek4MJahzesUHa0yRUyeiF3WIkQXgyi7awoi8vldzhRc1l8VR3
    D6CTrVgnXc+x7SlvaSUljAS1+WKmOOcJ/c4KfNZlPe0KPm34nlPz3lI+5rR2JAe+HQiL92RyilNI5bGjTHw8Ud8BrU+mHd0lANZPvlZgQHBhJVM+VWS442P0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=jODR8vyYUQY6K4GUbjgA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeEGIiQ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:38:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38533 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeEGIiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:14 -0400
X-Google-Smtp-Source: AB8JxZrOy4G7KLYlg3pbIpWNsgoc1rEVwdxOKz9S5NL+x5K+ESrnTPvK5zNQ28ZTEGAfv/IrBrcJQg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 01/35] vfs: add path_open()
Date: Mon,  7 May 2018 10:37:33 +0200
Message-Id: <20180507083807.28792-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
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
index 8007a31c4d3c..d97a661342c8 100644
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
