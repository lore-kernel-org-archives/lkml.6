Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525682854-2-17517030971050404687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682853; b=kwgStmCHSrEWpblJyFvMlBChGsgQTERIA4w7czFaK3aJsf2Udl
    pHXx5afSH6uhVCWKpwNCw+x7K916q6TNslToLc1JjPkPSTqBc6qbNShGPyNuQA+j
    z/QJoItsloZP6OOfK/CrXFwiAkkjHQdMxUrl+/9GGCYVpv4gDLDnhIuQ4oQqJTLC
    ZBjp0v5IIWi7ZlvF8bCMhZnowLoC4Rqdx3uvNuITlQPv2UDbVZmYeCmjs51SRL1T
    jBReN2P0HWr+lt+iQPkI0EanOnd3jnTM8wdCxU4C+ebTgDf6iohA02pO0IzeBe88
    b8ndZHH8ZaeNi4MN0QyaGi4SlY7xcOYhfmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682853; bh=
    w3ISRALrxiZb0tBpzTga2UiXWAM05XSQu1T1cGI0SkM=; b=Nvpq8bmMWhh+cs+4
    6D+WOhyXryLyGkbecQdw9JbRkf4IwkkvprgXq1hi7qrcu50L2WS6Ij5bs0s811IC
    erRbJ6HJd+LZAfANiVf4NFvA/rcZOllSe882V2/IkrcEMjaRaw4ZOoEndtrErGtU
    HglZxwRfUjWTyKzOFc07ymqS01cp4cNX1HuVB5MUmkfF01I2YM0e9VOQroEe/npr
    jvX0c9Bug2VV2gcw7AbMd8hKc0koh7nPFY3rGcRonn7gHIPpohFPH2z5oJz6fKWQ
    SGbciJl0vzThIUrsqZC9QfaBWpyfRWzKhAeOZ+co5WZ/WU2Fdyb+TfUO8tNPkFuC
    sXpWCg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=alASHuP4;
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
      header.i=@1e100.net header.b=alASHuP4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB1ysoUHDls+vH4A6p3mOmclHhoC6F1Yg9pCXOgKLQi7Aplen6immXOumvWT50yCH5qjChDQ/lmckChbvaTZcDlV7x7AEMW3b4SHeUOqYbret4R5gfkN
    BsnPzIdS5M+xoOd4PwG0WpHvHSTpGhQ0ABfDUZG3VJH1v70j8J9lYJ4zT7CVA6Zcs8WRc+NJX8BbElbXxp/bYrm+2YVwbj9RWTEMcc5UDSrZFLtTpNno2F1m
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=UxoLmwnZMme9cPmnS2oA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeEGIr3 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:47:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52114 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeEGIi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:29 -0400
X-Google-Smtp-Source: AB8JxZpJOuj9KlLFID6hXT8iK8qf7F6LGf3fUYHVn95LwmgmagIsnl+YlyUKK7EsSQysQoXIHVuyaw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/35] ovl: add ovl_read_iter()
Date: Mon,  7 May 2018 10:37:45 +0200
Message-Id: <20180507083807.28792-14-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement stacked reading.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index db8778e7c37a..bbc40a14acf8 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -9,6 +9,7 @@
 #include <linux/cred.h>
 #include <linux/file.h>
 #include <linux/xattr.h>
+#include <linux/uio.h>
 #include "overlayfs.h"
 
 static struct file *ovl_open_realfile(const struct file *file)
@@ -129,8 +130,74 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
 					i_size_read(realinode));
 }
 
+static void ovl_file_accessed(struct file *file)
+{
+	struct inode *inode, *upperinode;
+
+	if (file->f_flags & O_NOATIME)
+		return;
+
+	inode = file_inode(file);
+	upperinode = ovl_inode_upper(inode);
+
+	if (!upperinode)
+		return;
+
+	if ((!timespec_equal(&inode->i_mtime, &upperinode->i_mtime) ||
+	     !timespec_equal(&inode->i_ctime, &upperinode->i_ctime))) {
+		inode->i_mtime = upperinode->i_mtime;
+		inode->i_ctime = upperinode->i_ctime;
+	}
+
+	touch_atime(&file->f_path);
+}
+
+static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
+{
+	int ifl = iocb->ki_flags;
+	rwf_t flags = 0;
+
+	if (ifl & IOCB_NOWAIT)
+		flags |= RWF_NOWAIT;
+	if (ifl & IOCB_HIPRI)
+		flags |= RWF_HIPRI;
+	if (ifl & IOCB_DSYNC)
+		flags |= RWF_DSYNC;
+	if (ifl & IOCB_SYNC)
+		flags |= RWF_SYNC;
+
+	return flags;
+}
+
+static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct fd real;
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	ret = ovl_real_fdget(file, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
+			    ovl_iocb_to_rwf(iocb));
+	revert_creds(old_cred);
+
+	ovl_file_accessed(file);
+
+	fdput(real);
+
+	return ret;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
 	.llseek		= ovl_llseek,
+	.read_iter	= ovl_read_iter,
 };
-- 
2.14.3
