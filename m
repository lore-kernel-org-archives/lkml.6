Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525682780-2-14656550280635507628
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525682780; b=FCmacjcT7YxKO5itocvicuNMVhd1J/xDhFyQdWUzCUqk/FOKK5
    1QIUw9Rehm2R2FH5AkQzNud9RX+DET73WUzI6dhyBWTh3lNfR5UxIjg68LWkqX0m
    tMRh2l4dqTwwEPp1u8T3sbyuCmEQDvo72/jV1jLySFjb+8p0AGRZFrsestmrBMxz
    MbmtHkY4jwRpRI7wQuQUIewPLbvhsrbFu864zEjZ4O1r5vCwdMJSWei+RfVYaNn4
    vxpyGaF1z/j9nG/zERv6AhZhIpZ33Mrc3qVzMNraYDgoPXf2uNTIGk3/A3imexS+
    TYWEBFbKPMLEVhpfmCyAUIT+cKs9QMvV9Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525682780; bh=
    uPogWDndRlHg3v0yCiWwIa3gQHTiykSy4jqYiVlNqIw=; b=DOPLqzQcb12Aa/bz
    hJBCqv91rteMhxHXHLsn41BI4B3ZaNIiim6hc7H+TQS7hQCprNLeo8DITeMRzK2S
    i9FvRHPCTZdgSfP1c/ZenMOK9btZ9VTGGi7eUVk8UjZpffvp6Q7baANYLFF3V3jI
    sd6Wd1mFRs+YC93whiNmqm2v3hJZk8exUu+VtZ/n0RFAVG7DnrxuH1s+EGJvUCAH
    5ZtROh2hHAb3JLiEkNm+svqrFAajQMC6hPT0dqBANzHv283O2t/23o2opqC2poUK
    mBw4KK14WtiSoeTK5C0irsDJDFBdkrX8NHzKXzKDSO8jROGlVDvnxBVK7UFCaUh3
    RDHynQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=swEDo36k;
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
      header.i=@1e100.net header.b=swEDo36k;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPZqdkJoPXUiDW0jK3rTmBDDqoagpCC7HcGrYTNsEBZPluqdR70lCW1tYrtfBlvqAFsrgFNHDD8PftFy7xILVqpU8NG+RpTRky09dIjQk2VzvMZBegyk
    2M929x2E1FlhLPvRI8IE647u4HId2yCpyONvsgPjyzJYrV8y46uOt/yN4zPU675rSEPIo4W4tGrmbwP8I+dJ6hazx+buP7k/Q3OjABSM6AAL+Auqt5y2gAvX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=piVAeblzDhsfHZeUUicA:9 a=qzgJG8r8dzAA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeEGIqQ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:46:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42167 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeEGIid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:33 -0400
X-Google-Smtp-Source: AB8JxZqjesSFAE79ZzsxLX5i0yQyAd08nzuUmizSBUXwlsDZsiCXHq3eu6rw5SLs6Ffkcz/Xtb784A==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/35] ovl: add ovl_fallocate()
Date: Mon,  7 May 2018 10:37:49 +0200
Message-Id: <20180507083807.28792-18-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement stacked fallocate.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index b75ee0a3655e..3a85bbfa266a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -279,6 +279,29 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
+static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+{
+	struct inode *inode = file_inode(file);
+	struct fd real;
+	const struct cred *old_cred;
+	int ret;
+
+	ret = ovl_real_fdget(file, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = vfs_fallocate(real.file, mode, offset, len);
+	revert_creds(old_cred);
+
+	/* Update size */
+	ovl_copyattr(ovl_inode_real(inode), inode);
+
+	fdput(real);
+
+	return ret;
+}
+
 const struct file_operations ovl_file_operations = {
 	.open		= ovl_open,
 	.release	= ovl_release,
@@ -287,4 +310,5 @@ const struct file_operations ovl_file_operations = {
 	.write_iter	= ovl_write_iter,
 	.fsync		= ovl_fsync,
 	.mmap		= ovl_mmap,
+	.fallocate	= ovl_fallocate,
 };
-- 
2.14.3
