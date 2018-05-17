Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691500-1526589561-2-11683833028593904254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526589560; b=nm4YtMLHOLy4p0fv5SSm/Rm5nX49H/aafbmQYqW09bl3TpnQdn
    Z8nkvZx7WNd78a6SxP+cVEvqBNsZdy1SyOL4d89ZNYzYXK2lUdaykeSMPFikB8sa
    QSaFnhFmr8sOn6tH5NdHk9wmbztWcUdyXW3RxUkpfcxAUgN60w92OPgqd8uqjhWn
    VjlM8+g6knNFcF5nUj4L8et4Z++EZjo3a8kdu8KbCqDRPdIX9ERuUKEgy6crVVMP
    CClsqfD9xwqT60Nijl6y+3Zfc6Tei+ML5Y3q81a+ivQ+MzYMVO4KpIy9J47Ilr2W
    3j788zDhYV3KzuhwPKBsXk+BjApfUZ22yuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526589560; bh=
    Uf/leYFdP61DG3L8RwUrCcQ98JdJUnfwQC0NA1mAduw=; b=AEMssptfKKtwSmxl
    VDvZSwSWD6G3vebyTd2WAfzk0bRxG1DkuEAahCrUkb/6+snZMASAm6MZqOq5Hec1
    EjTa1sJ4eEjAlaC7+W/DZg0Wp0i2rAW1r9DrdJnst0Aa7gCr7ynbznKDgwpyejZK
    kukeak0Z+IEmKni/Jepi1otYSGmlb3OXOAaUX2duku0cbm1txtwmvS4yDT6qkUF/
    dxv+cHFtwLUWfDjZlKzlf95dnhFnrfIqefrocyCyhm5erO16Z/Rxx1rSaSWLJY5u
    0K1a9QY5SVM6nZPQNHtbbRFTCcpNQrttOT6VQmEq0bKPCU+eQtixz7a3GM/rKG/e
    r6JBNw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=QU6vWg+p x-bits=2048
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=QU6vWg+p x-bits=2048
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
X-CM-Envelope: MS4wfK3lcHku1AoTLJ7OMI16bqrf+4d74QlIjil/Sx5wGfkkBTHrbPr/WuuUri8UmsmJdAqG0zQ7L2r5y2/vABzhgnWWxSMhpMyUZL6uUizovqrWWpmzxKg7
    iCIfzJb90U10iUcWPzn5/N62Gr8aVMn4/fzw/G5IDAtrR461YBDAv6GkWHgC7JGGURWU7ODsSljeE4MLMy+R1qLgNfznfgvLvbh3KNZjqVmdz0L213n+K/V/
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=VwQbUJbxAAAA:8 a=xumZNVgrbLJNRNgncCYA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeEQUjL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 16:39:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51934 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeEQUi0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 16:38:26 -0400
X-IronPort-AV: E=Sophos;i="5.49,412,1520870400";
   d="scan'208";a="78199749"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: mingo@kernel.org, peterz@infradead.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Date: Thu, 17 May 2018 13:38:03 -0700
Message-Id: <20180517203803.2664-4-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180517203803.2664-1-adam.manzanares@wdc.com>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
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

This patch depends on block: add ioprio_check_cap function

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 fs/aio.c                     | 16 ++++++++++++++++
 fs/block_dev.c               |  2 ++
 include/linux/fs.h           |  2 ++
 include/uapi/linux/aio_abi.h |  1 +
 4 files changed, 21 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index f3eae5d5771b..ff3107aa82d5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1451,6 +1451,22 @@ static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	req->ki_hint = file_write_hint(req->ki_filp);
+	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
+		/*
+		 * If the IOCB_FLAG_IOPRIO flag of aio_flags is set, then
+		 * aio_reqprio is interpreted as an I/O scheduling
+		 * class and priority.
+		 */
+		ret = ioprio_check_cap(iocb->aio_reqprio);
+		if (ret) {
+			pr_debug("aio ioprio check cap error\n");
+			return -EINVAL;
+		}
+
+		req->ki_ioprio = iocb->aio_reqprio;
+		req->ki_flags |= IOCB_IOPRIO;
+	}
+
 	ret = kiocb_set_rw_flags(req, iocb->aio_rw_flags);
 	if (unlikely(ret))
 		fput(req->ki_filp);
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
index 2c0a3415beee..d4e768d55d14 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -55,6 +55,7 @@ enum {
  *                   is valid.
  */
 #define IOCB_FLAG_RESFD		(1 << 0)
+#define IOCB_FLAG_IOPRIO	(1 << 1)
 
 /* read() from /dev/aio returns these structures. */
 struct io_event {
-- 
2.15.1

