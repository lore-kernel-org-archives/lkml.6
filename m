Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2273583-1527606808-2-500880716495050187
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527606808; b=SX1DUxP+UmCJqtu1DKfdM/HA/yz4ibsmR5e20y1lv1CUbb8gBk
    Ds6Yiz53XKv5NatoitbUSrTb2GnQlxY1S0A2kqKT7bJDkvUNU1a/iEt8Wmi5HmK5
    4EUBFgt4TQFhvxXuw8CYBWSZFKNJd4DumVmX0TffC0ktAY0KPFqePgpFj7+KwF04
    ablzBe0GYSG+QmFN4xE6EQhurRxsKPh7BdWZcHUoHCmZYdHJgga9Ur9LeoIaIap+
    jVsA4dq5kIWR9dyzaH3nm0NWd1wcwRGzevOceOEsjhmHYoaWy5oqMkf1Z6fosA1c
    OpZNUc6MJIEuxBWPyk8TJCagBeMaWaktz2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527606808; bh=
    w3ISRALrxiZb0tBpzTga2UiXWAM05XSQu1T1cGI0SkM=; b=cp1swR2Z4MWaMXE8
    gPz2STJ4MFjfgBET45185E1AAqp4+4z+/g1vO+50CPefFJRMNUIH3HN5r6bvK38n
    8/rXVtJ//Lq5lqu1s8Yc2KI1LPvuU3gmbNZ3xg0ZeM1IPLZHdZaDBp3b+Cl/RvMz
    lFeuht5PwwVN0mBRHUE4rWPL8F8Q2f610+SPucJxI8HrcPZlrvcPU79tQguWG3qz
    sXxUjzxLY1XVI8Z4L23Riqymr5sIrehYjrQvGSvOK3+xJOPdRAJ9HLoJ4VDes/NJ
    j2hp1KA0/dK63NJR4b+q/yIrOTL5tDCjk91MiJV/smDg/HVnAJOe07PQkD9rgr5+
    RM2/Iw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=c+qCZD6Y;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=c+qCZD6Y;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwqUU0sdMgG11J3YfsjMNMC8fWaN0L2097/GAtPNOwchp6pziqnu+OAYMiyyFcTEVjFGL7r9EGGPS2vDKG1LiIWE3c9SV+SYIeuq7to4Kg6Lgwa2KXl
    L1kbt+ef4ebr5bDqYEz7MWKn+AFnc32AX1uIt7VxjxYmRtsFNEm7uTnEI3tEjuUG48bVzOPrwntDtQjKv/IOGQo8+se+tCOd5T2SQifyKF8tEjgs5z5Ak2Iy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=UxoLmwnZMme9cPmnS2oA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935484AbeE2PNW (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:13:22 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36357 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935613AbeE2OoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:01 -0400
X-Google-Smtp-Source: AB8JxZpztarJ97LBHhFcTBRZAyLVQA+p0viPoa8N/+bu8y3PIkce/ZozeN11D1zB+fUDHUooRDObRw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/39] ovl: add ovl_read_iter()
Date: Tue, 29 May 2018 16:43:16 +0200
Message-Id: <20180529144339.16538-17-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
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
