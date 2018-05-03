Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525371725-2-14335568237020292925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525371724; b=dgUBUrMI2ZG9x9XpTI2rOP9y/aFmLPuNvv+D1NTwbn78CEumi/
    flLr8xtY5uU1OK5ZPAFBFZfFKNlDx/sAtXwekhRf2qiXlkoP74oxatt89pGkF5Q6
    QMa1tV7uieI+Z7dqFOhDa+Jkp0x5305mnIMbukMU7JFxg+ixx3MdKi+fJPTlqOal
    1SgH13KdqmfllS1SX7uQ/WGMauQabnNsmKqOX8UNFn8hi9rmhbwsAu+fwsjUgsBy
    0Vb9/PJB8LCws9ShGbDOOEqLPNgAQ0YKfh8pFq6nLhrsO8RS8n3pKi7DVEGSLqzk
    8HCq/Po4FyOvymA22PaCOsu/1vXoSUEI/tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525371724; bh=YCp6lI9ZsYqCSGX76x0HGA/dG3SH60
    UEgMy8ow/bH1k=; b=hMaeiWGmIufrJnXARsyXVMjY5jrJjtmdRF+HdU+x620tFs
    jRpvxfoUooMaOMNPfXLGsg0t1ZKmwQ8/e95ujiAuCiR47VACBnfFd4M/b1BqYHp1
    i1Rr46NrC4IkIrmYTR4z2HAgw80n1ZvBvSpl7iOmfOiyja5lmo7e7daN9Oms+Ql/
    +Z2zRkin2e8KW/hg9lLxKhCQ3hzkVFC6WO3NAj2J/5iQQ2eBZFUvdkKR1/WN1lfN
    w++oimPKnz4FhLZ5MEx0ErRkZy/KI239PqQQMi1tBwncoeNUo7FS9Wy0hcjoeXyF
    obt4eI2cAFYaJWaIVYyo+Fqtovefg7Xem49+Lcfg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=hPVaRU8u x-bits=2048
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=hPVaRU8u x-bits=2048
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
X-CM-Envelope: MS4wfNxM5yJq3PLJ0RYVcYAq/WYJOQEWEM1ixh7gJmQ26QxiLkZ/40f5hBWmE/aZXCu9iG9spTdqMPtlN71MUcmZhlChm4k5XDjrAJAlFLzxUEMno0lOJQfc
    j6GxyD511wHtsT69hyt8fxfKPIxb377zBala+lgJIMroYPFrhfKCmkE1lpGu1haOH0u+BpYEgxD99gxAvpPkQ+HOlHI1VT7zoa4aDQaF6S4/+UcRvx9xBLsn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=xumZNVgrbLJNRNgncCYA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeECSVt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:21:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64709 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeECSVs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 14:21:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,359,1520870400";
   d="scan'208";a="77399518"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v2] fs: Add aio iopriority support for block_dev
Date: Thu,  3 May 2018 11:21:14 -0700
Message-Id: <20180503182114.2797-1-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

This is the per-I/O equivalent of the ioprio_set system call.

When IOCB_FLAG_IOPRIO is set on the iocb aio_flags field, then we set the
newly added kiocb ki_ioprio field to the value in the iocb aio_reqprio field.

When a bio is created for an aio request by the block dev we set the priority
value of the bio to the user supplied value.

See the following link for performance implications on a SATA HDD:
https://lkml.org/lkml/2016/12/6/495

Given that WRR support for NVME devices has patches floating around and it was
discussed at LSFMM, we may soon have a lower latency storage device that can 
make use of iopriorities. A per command iopriority interface seems timely 
given these developments. 

If we want to avoid bloating struct kiocb, I suggest we turn the private field 
into a union of the private and ki_ioprio field. It seems like the users of 
the private field all use it at a point where we can yank the priority from 
the kiocb before the private field is used. Comments and suggestions welcome.

v2: merge patches
    use IOCB_FLAG_IOPRIO
    validate intended use with IOCB_IOPRIO
    add linux-api and linux-block to cc

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 fs/aio.c                     | 10 ++++++++++
 fs/block_dev.c               |  2 ++
 include/linux/fs.h           |  2 ++
 include/uapi/linux/aio_abi.h |  1 +
 4 files changed, 15 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 88d7927ffbc6..f36636d8ff2c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1597,6 +1597,16 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		req->common.ki_flags |= IOCB_EVENTFD;
 	}
 
+	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
+		/*
+		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
+		 * aio_reqprio is interpreted as an I/O scheduling
+		 * class and priority.
+		 */
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
index 760d8da1b6c7..ab63ce720305 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -292,6 +292,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_IOPRIO		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -300,6 +301,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	enum rw_hint		ki_hint;
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

