Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2273583-1527606771-2-6247726331530643084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527606771; b=O0do0s00P57oUKb3Ta1lDp0UMY0bpnjQVNV7D71tfT8q8XgURZ
    i0qGW9BnQOft1AXUiwxvaX1ndaa3GYWMsLcakbNBkdiCYeAXfxxAZw1PLZZIJzCj
    W3M1MslOk/7map6oYO/uccKhOjtxhWuZPDr7tBfi1T4rIwf08+2SHdum0LERp/01
    r1DaL4LElI7rTX7opFHla9LunN7RkxcT76y6iFO0N7wSmOttEBewzqNvQrM0jf/k
    7hExOVBh4wSSiwpyvMImIQDZLf+LSyVlhHSIf0uCSrjedXGpFgUGzIIOpxKHDwlF
    LHZbR3d4vJTIm5TbpHbkG0pUp4Z5mXN8GDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527606771; bh=
    SFE+MCC9wmIJeML2N/pwQ7qEKYtb4lIpa+qdxpSA0MA=; b=DnxnRfec+8XQqWiz
    1E1uQRNybUwS1UpG+XHX9WcVhTcYDoelKs7NpV9bUD3/MZiS9QOLT/d7I67Nq04N
    YY/rH4lZ8aw6vB+EUI8t0OiwAwlwGcpIjv7jONgriFOJYltXxcG/Xky5/9G8jBUu
    X5Bz7sy10kItK5ZH63B5w2bxa0eQu9MW0qUoAqP37XWaSUcFBXxjVYWCsXqb/PQ/
    4yfxYCOp7HVvq8aT8on45KiXFStwhtbsaN/SQe+oeBPM1VEcEKix40lLL/ME/J8m
    f48haHeh+V8KHzb48PIzarnaOIr0l3tQe60edGVBUSMzf98HYzD3RBXSDsWSt2sA
    BWE7yA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=DG11vZgk;
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
      header.i=@1e100.net header.b=DG11vZgk;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNwP3GFFRdmsp7YTU9ghJ2uOtEjMDwPavzNiFoJZkQfK802zkyS+cnfHAcEL6g6NnDGQuFehMKYjE2hmfxtnMtDma4NglK4JHi4YS0PgfvtUg2H11I7j
    /PyY/TMmgj2JTGz/iGtcCRcX8PJX7EcEJNOQkGnYROh26AY6FCqPen3aZwO4qLCtQzWw8B5XrKbq2uKvuqNAcEenpkJ8O4mjOPJ+D+6ph9gza5rVsf45FIQV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=QU7Ty-i3TS7PaGV_qxwA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935650AbeE2PMr (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:12:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54548 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935623AbeE2OoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:44:03 -0400
X-Google-Smtp-Source: ADUXVKIxLuhwtWky7gsRwNVDhen4cHTjxPIoebHYf3c6Hkfa42fRK6qlpVPmTtB0PBm/ub3W/mDgBA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/39] ovl: add ovl_fsync()
Date: Tue, 29 May 2018 16:43:18 +0200
Message-Id: <20180529144339.16538-19-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement stacked fsync().

Don't sync if lower (noticed by Amir Goldstein).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a7af56861aa5..7b47dce4b072 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -233,10 +233,33 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct fd real;
+	const struct cred *old_cred;
+	int ret;
+
+	ret = ovl_real_fdget(file, &real);
+	if (ret)
+		return ret;
+
+	/* Don't sync lower file for fear of receiving EROFS error */
+	if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
+		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		ret = vfs_fsync_range(real.file, start, end, datasync);
+		revert_creds(old_cred);
+	}
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
 	.read_iter	= ovl_read_iter,
 	.write_iter	= ovl_write_iter,
+	.fsync		= ovl_fsync,
 };
-- 
2.14.3
