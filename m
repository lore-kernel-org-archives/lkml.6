Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3181716-1525801421-2-2296297695558197040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525801420; b=QQ7YlZggmap2cOcUcSHUnTjfG5SvOjD+s9oejZ3YCO81bariE/
    K35B3UZlKGZ3TLT891CyYc1B9Lv+Wi++UL7B7LUBgaYOeBY0cVuyUtuabuTSH8G0
    nHdxTVTQudux+Su8igpGDQUoGN/zQiSic8puharxMdzTJ+MZwfGMqC9uCkWMnHmC
    atCV4LZ4BxYYcBJXKpuus8s5yP98b3IRGVm4aBrjERhez1+IU1x0jsKg2Gfjj3n3
    Vop5bmom/ojstsoYVenWgNg+U8mqXHXS8WePFlJnJKJ9tFFC4AjbVw9i7JL4yo0V
    Lc4jJSpxfkTaz0l0Q0g/HWn1xmd5hnfs682A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525801420; bh=
    JniH2hYyqR3TtYsbHeFon+Dg8yO0+wo+r27qFK/UgKU=; b=TnSd1Kv2b0hjruEq
    r1laI4dQkHuKM+P5lGxog5xTOG6c6Ll75dBSvdzSJJ3I00GNolV7X5QYw0Xt2vCD
    P06G/8Aix2ft9ifIDJMurhXs2m7TXZlItX/cuAJGG7Twcancq4E2hDBtGtAtUz/U
    juA9dYXaL8LEeuEvPkuSrZkC1MOnHcxOcmMlnxfIL+oL0lKcs6HnTlHv8Kq1MHZC
    ipYuGo5/sInAffV+32+3eo8RPYbpuO2LYL27+jneoJhZh5iipIYfnIM0JrJm7OJR
    DMbVN4tLDFu0r22ZGCSH5NVXuQbEtQ3T9TsxWtToiqz50pvtgZl2WEg2MjP2ANkI
    gmXkgw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=fG14AAYI x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=fG14AAYI x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLz934ZOEiqcCG+s2EjBlMB/wt0D9iQ/HHSlyq5qnqHpcZ1hic9jMuvs52DIBfL9BWn6NKl/fNLC5431uCAfuf+2zMlYtXBeeeepsjcwt9p39L+eTx3O
    hTQZKd45DVpwMFcFuSFZAtGKKA7R0Ao+tp9k4pbOcnonhnbOXZDxBRwglyc55HVoE7Jf/MyAzSaohNUb7zAD/1B8DlJVxQSCZZNIXPnxw09LilGqZ593F60b
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=xumZNVgrbLJNRNgncCYA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbeEHRnE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 13:43:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49183 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754687AbeEHRmh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 May 2018 13:42:37 -0400
X-IronPort-AV: E=Sophos;i="5.49,379,1520870400";
   d="scan'208";a="180732635"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v3 3/3] fs: Add aio iopriority support for block_dev
Date: Tue,  8 May 2018 10:42:02 -0700
Message-Id: <20180508174202.2537-4-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508174202.2537-1-adam.manzanares@wdc.com>
References: <20180508174202.2537-1-adam.manzanares@wdc.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

When IOCB_FLAG_IOPRIO is set on the iocb aio_flags field, then we set the
newly added kiocb ki_ioprio field to the value in the iocb aio_reqprio field.

When a bio is created for an aio request by the block dev we set the priority
value of the bio to the user supplied value.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 fs/aio.c                     | 16 ++++++++++++++++
 fs/block_dev.c               |  2 ++
 include/linux/fs.h           |  2 ++
 include/uapi/linux/aio_abi.h |  1 +
 4 files changed, 21 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 88d7927ffbc6..f43d1d3a2e39 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1597,6 +1597,22 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		req->common.ki_flags |= IOCB_EVENTFD;
 	}
 
+	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
+		/*
+		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
+		 * aio_reqprio is interpreted as an I/O scheduling
+		 * class and priority.
+		 */
+		ret = ioprio_check_cap(iocb->aio_reqprio);
+		if (ret) {
+			pr_debug("aio ioprio check cap error\n");
+			goto out_put_req;
+		}
+
+		req->common.ki_ioprio = iocb->aio_reqprio;
+		req->common.ki_flags |= IOCB_IOPRIO;
+	}
+
 	ret = kiocb_set_rw_flags(&req->common, iocb->aio_rw_flags);
 	if (unlikely(ret)) {
 		pr_debug("EINVAL: aio_rw_flags\n");
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e27065..970bef79caa6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -355,6 +355,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
+		if (iocb->ki_flags & IOCB_IOPRIO)
+			bio->bi_ioprio = iocb->ki_ioprio;
 
 		ret = bio_iov_iter_get_pages(bio, iter);
 		if (unlikely(ret)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7a90ce387e00..3415e83f6350 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -294,6 +294,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_IOPRIO		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -302,6 +303,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	u16			ki_hint;
+	u16			ki_ioprio; /* See linux/ioprio.h */
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index a04adbc70ddf..d4593a6062ef 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -54,6 +54,7 @@ enum {
  *                   is valid.
  */
 #define IOCB_FLAG_RESFD		(1 << 0)
+#define IOCB_FLAG_IOPRIO	(1 << 1)
 
 /* read() from /dev/aio returns these structures. */
 struct io_event {
-- 
2.15.1

