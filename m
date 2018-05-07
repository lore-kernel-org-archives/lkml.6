Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525682802-2-9530227725862688876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682801; b=JeuvbmHohN5ocVvzcJ9k72ryunaPwVl+2NfhjiqmwZIMSJ8mPd
    DroALsq/ePBo39wAQTA7I9eYDdpWd2iSJ3W6mUJXh1AiEqEsqnsTgXRIE4L4kEfb
    Ed6ae77DQIctp8DVXBRyhFtB0mTrd1NQhXv5AsdogCidzkjFzhycFP6sBC1upD7b
    fIe7P3fG83bT6CiHfoj2VqOU4mpq87c1qcVG3nC7rXF/D3ZUrPB4sDpBH0X8Cg0a
    LkEwLTLjRzpIhDRk10bY5ImCsffUd61dD1LfWaQGi5f2BUQCx3dR0l4g4i0fojgu
    U12zhEjntAqNHk7kjmVHi409ED893eOE3/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682801; bh=
    pwB4toT5HgzNWNcEeKnojJdrKVF7+wE9DkBhcJnRoFU=; b=Xg0GUYUH4FJlH+L3
    ScwLNkfqlhhMVKbaAk5u8YT/vVyZWOqrE0SjAaLPRZtqbQbShF9i2Y/tYByTOA8H
    l9N5FkccjKT7pDJeD/m4beBsSQOCOeXKvoG/15nvbEWM33d4DGksLURWaG1R9cuU
    o9/VpcYzCvaqGnkWFVlMLaIc76b56vg7w9tnoBNF1Yt4h2JnPulSoY79d9B5N2O6
    qzH9wYHxuf2xE/JOP+ImTs5JpQghJVk4R98logeREzvSd1XnfqDJgHz7tIi8O6E/
    Z0dgqPyLv/d6B2atsZqSciNRdnE6Or6K3ehOadXPUz8V+0D2jsCmBrGkXKLr7uz+
    zeWukg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=IanIHmpi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
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
      header.i=@1e100.net header.b=IanIHmpi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM3egqkBsHSUz5xrL2kcHCKbgr9LNgIXKKA3T3S3bN6gWyLHSf53//Cn8mUbxy67HJCNOZ6kR8iyiozR8KnehjGYQKQkgUfr1XUTeurKzbRgTLirzbA+
    0iB0jIVj9tPWRqfk3/0NotzhxUu1O5om9lSdh7Yd7Ko+XtHmE6uVt4P9stT3qsQ7224r0Xkog1WlHhg0tGjyE9vLR25bkSx7cE8PVwiK9d2apwJlICem7qp/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=bC9mE0PDHCYVYfUv-OEA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeEGIqT (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:46:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54694 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeEGIic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:32 -0400
X-Google-Smtp-Source: AB8JxZr/MhZkc7DZCv3xFL6ZT1qLboJl11JBEvlEEEtStiHGaQsstcCetHQv4a58AOhAXP4kA7of7w==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/35] ovl: add ovl_mmap()
Date: Mon,  7 May 2018 10:37:48 +0200
Message-Id: <20180507083807.28792-17-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement stacked mmap.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 419aa3f9967b..b75ee0a3655e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -252,6 +252,33 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return ret;
 }
 
+static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct fd real;
+	const struct cred *old_cred;
+	int ret;
+
+	ret = ovl_real_fdget(file, &real);
+	if (ret)
+		return ret;
+
+	/* transfer ref: */
+	fput(vma->vm_file);
+	vma->vm_file = get_file(real.file);
+	fdput(real);
+
+	if (!vma->vm_file->f_op->mmap)
+		return -ENODEV;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = call_mmap(vma->vm_file, vma);
+	revert_creds(old_cred);
+
+	ovl_file_accessed(file);
+
+	return ret;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -259,4 +286,5 @@ const struct file_operations ovl_file_operations = {
 	.read_iter	= ovl_read_iter,
 	.write_iter	= ovl_write_iter,
 	.fsync		= ovl_fsync,
+	.mmap		= ovl_mmap,
 };
-- 
2.14.3
