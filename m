Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1769925-1522222895-2-14810669429813438006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522222894; b=p3EubCHAHnkO0Ag4tDHlaf4M1bRXXzgXAS46eRFTmOjwEOM
    a7nvyn5aGyxzKHeWC82aXTrNlL4K7rxhIURWbQ547mfXJmnGvCuVGEuYReAcLlzZ
    vp0iD5rRsWILrL1YkWJCEyWKzG7MwZh8dZStnyh+o1OebG8XA8b3VA42sn7RKzTX
    ZLY50E3xGSqGA/PZRiWsjQseMj3J/QvZo6dJ9Qn4eBLyfemnuiV3YL0kPWC5iFHQ
    MDa9q3gT2TI+36hedRCtkpuoOcxMHhh+UcOPddswMEMZEqnfYhOIEUnOc7CQFQ/D
    +Tu849YW/TaC2K/0jLAKeyuHyXK2C0XzhnpPUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222894;
    bh=/+NiLxOubkMuKCYOdw4IBHdu/h+mNZiNDFMz3VPkeD8=; b=ehCF2/CAq9Zy
    273A2U/v2J9LuP+4qTibt4/C0ubg/o+R1lzs0vROxqZQ+heX6tWaJQAhOExTLsx1
    AWcE74H09R/TZCwTqgGqglid9fNWNS2TqncJ3nEYhpIgjTYRhBXxfyh24qM+6G11
    3tLN68e2gm8UEfztHchNdOwxrZOVdlAwW8USxsEWJVyPUQk2hv2dZRknwJhp/3KC
    9rJKeZOFwKAcNCOAdFVNx7x38mS2FYSxRrjcr3oyMqwcM5yqj9Rxd8H95uflyd4J
    nPPRuNyVf/2q/WSnG5PB+GE4jeVdgyNSn2lHLbH9EsXBaQP3SvVUK26FmThGJwl7
    Kv5jygpUxA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=k8+0Canc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=k8+0Canc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD0ZcvWUEms/tgF3MeQ6QAj3UbJOJScfLBg+y7ESlxH2LvSIadDJCQOe7+qzFPgQLNEA9Rt/+aWEzP3sSEkWcjd0/hxnMGTUA/sjKgSJNBH6NaTR8Hgt
    2otmWTSyjJNUlNyLvABXU8i7bfvwRzzMapsKWSD45RrMRmmORh5/H8lfFDcZqzoFADExjDfJErtz5m5yulMYjaHyik/EQszGR84B7HBzSRo9Or39tsP9RZ5r
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=y7deh0K5X9wfqp93eXMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeC1Hkp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:40:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeC1H36 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:29:58 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] aio: add delayed cancel support
Date: Wed, 28 Mar 2018 09:29:03 +0200
Message-Id: <20180328072926.17131-8-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The upcoming aio poll support would like to be able to complete the
iocb inline from the cancellation context, but that would cause
a lock order reversal.  Add support for optionally moving the cancelation
outside the context lock to avoid this reversal.

To make this safe aio_complete needs to check if this call should complete
the iocb.  If it didn't the callers must not release any other resources.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 22 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index c36eec8b0879..232dd84fc897 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -177,6 +177,11 @@ struct aio_kiocb {
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
 
+	unsigned int		flags;		/* protected by ctx->ctx_lock */
+#define AIO_IOCB_CAN_CANCEL	(1 << 0)
+#define AIO_IOCB_DELAYED_CANCEL	(1 << 1)
+#define AIO_IOCB_CANCELLED	(1 << 2)
+
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -543,9 +548,9 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
 #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
 
-void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
+static void __kiocb_set_cancel_fn(struct aio_kiocb *req,
+		kiocb_cancel_fn *cancel, unsigned int iocb_flags)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
@@ -555,8 +560,15 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	list_add_tail(&req->ki_list, &ctx->active_reqs);
 	req->ki_cancel = cancel;
+	req->flags |= (AIO_IOCB_CAN_CANCEL | iocb_flags);
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
+
+void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
+{
+	return __kiocb_set_cancel_fn(container_of(iocb, struct aio_kiocb, rw),
+			cancel, 0);
+}
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
 
 static int kiocb_cancel(struct aio_kiocb *kiocb)
@@ -599,17 +611,26 @@ static void free_ioctx_users(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 	struct aio_kiocb *req;
+	LIST_HEAD(list);
 
 	spin_lock_irq(&ctx->ctx_lock);
-
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-		kiocb_cancel(req);
+		if (req->flags & AIO_IOCB_DELAYED_CANCEL) {
+			req->flags |= AIO_IOCB_CANCELLED;
+			list_move_tail(&req->ki_list, &list);
+		} else {
+			kiocb_cancel(req);
+		}
 	}
-
 	spin_unlock_irq(&ctx->ctx_lock);
 
+	while (!list_empty(&list)) {
+		req = list_first_entry(&list, struct aio_kiocb, ki_list);
+		kiocb_cancel(req);
+	}
+
 	percpu_ref_kill(&ctx->reqs);
 	percpu_ref_put(&ctx->reqs);
 }
@@ -1045,22 +1066,30 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	return ret;
 }
 
+#define AIO_COMPLETE_CANCEL	(1 << 0)
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
-static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+static bool aio_complete(struct aio_kiocb *iocb, long res, long res2,
+		unsigned complete_flags)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
 	unsigned tail, pos, head;
-	unsigned long	flags;
-
-	if (!list_empty_careful(&iocb->ki_list)) {
-		unsigned long flags;
+	unsigned long flags;
 
+	if (iocb->flags & AIO_IOCB_CAN_CANCEL) {
 		spin_lock_irqsave(&ctx->ctx_lock, flags);
-		list_del(&iocb->ki_list);
+		if (!(complete_flags & AIO_COMPLETE_CANCEL) &&
+		    (iocb->flags & AIO_IOCB_CANCELLED)) {
+			spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+			return false;
+		}
+
+		if (!list_empty(&iocb->ki_list))
+			list_del(&iocb->ki_list);
 		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	}
 
@@ -1136,6 +1165,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 		wake_up(&ctx->wait);
 
 	percpu_ref_put(&ctx->reqs);
+	return true;
 }
 
 /* aio_read_events_ring
@@ -1384,6 +1414,7 @@ SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
+	struct file *file = kiocb->ki_filp;
 
 	if (kiocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(kiocb->ki_filp);
@@ -1397,8 +1428,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	fput(kiocb->ki_filp);
-	aio_complete(iocb, res, res2);
+	if (aio_complete(iocb, res, res2, 0))
+		fput(file);
 }
 
 static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
@@ -1541,11 +1572,13 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, fsync);
+	struct file *file = req->file;
 	int ret;
 
 	ret = vfs_fsync(req->file, req->datasync);
-	fput(req->file);
-	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
+	if (aio_complete(iocb, ret, 0, 0))
+		fput(file);
 }
 
 static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
@@ -1807,8 +1840,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 {
 	struct kioctx *ctx;
 	struct aio_kiocb *kiocb;
+	int ret = -EINVAL;
 	u32 key;
-	int ret;
 
 	ret = get_user(key, &iocb->aio_key);
 	if (unlikely(ret))
@@ -1819,15 +1852,19 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-
 	kiocb = lookup_kiocb(ctx, iocb, key);
-	if (kiocb)
-		ret = kiocb_cancel(kiocb);
-	else
-		ret = -EINVAL;
-
+	if (kiocb) {
+		if (kiocb->flags & AIO_IOCB_DELAYED_CANCEL) {
+			kiocb->flags |= AIO_IOCB_CANCELLED;
+		} else {
+			ret = kiocb_cancel(kiocb);
+			kiocb = NULL;
+		}
+	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
+	if (kiocb)
+		ret = kiocb_cancel(kiocb);
 	if (!ret) {
 		/*
 		 * The result argument is no longer used - the io_event is
-- 
2.14.2

