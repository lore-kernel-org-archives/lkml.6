Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522356399-2-13118172490479028853
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522356398; b=Y9Tn6E5KJhJ/E1Eppg4KD8DqDvD6mi1iR6vB8/NRtODd11R+kO
    aiJ6RLv/ME/UYrctMgv1kgKRUgpfuhoKFcuUURTZx06fJwFg1vjqAmOD3lSR+NIS
    zrQCb6mv6G9XuMZKBM4T158GVk7cJs0X6aNVOn3iXlsvetZRtbzjSPwZXWmwt1T0
    oboM6+q90jBvxD6G6Ccf0wgrOXwFUHEfcpnCGsmO6/qr8rsTxyaNG1LTNy4ktpG7
    reXJ7CLpzco5rVnHj67PKvYQ5mQn8hKemMpjBmp9otrXCULHeVVa4OtHGLUBYTrg
    ofE1tJos8rteBUstINbzxvg1ot8vEQVfRNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522356398; bh=
    PXxUhs/pwV3FpQW4DPuAvl0nmpgnYGPllB8Y+URxdZY=; b=HlTRNXzxMcJlS8ox
    5i4roJN9LR8RD6Fni6/1s0BDStjq55b5VpLhhC+3zlxBcyujvw+3+vXB7/dFD241
    luV3UsV8+QsjesRocWxbBsVrb5HNTDZjO9oooSNccxnCBS5cs8/RxZ38U8A+UrDw
    BzNabs0m0nd9+dKlFk2wa1V24QTO/jjGwAa6/AQ83eSAdnJj3urZ4505QNQBHecu
    XvbD/gFnHzL9LvpxU8MQZpaq/bEs4vv7aBL7EZNyFV1XJNnUhRy9DrW1+7J5x8bO
    NONAacN5ehK1TynEba2gPXq3XrMOmGxplHpL6ZXGfC/EvfgO+kHt5HVpzTN/WIB4
    EsyyjA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=cZwam5vQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=cZwam5vQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfExjnyFNFA7N0AJVaZ0A3OK4vPNXEMaEocJefzrsl0HtrtIOE/YltvjF9g1Z5m7tOvZ/UNwwsjbSOl8vTYGmOf/KJBEX9KgO4wT30z2dYrRh+3FXmwvt
    wbPG8Wsrk7IljJsGzZwAMk/siIgcGv4if9kHaSnho5HOoOjhzUId9JY0CFUJetexfg/63nTDC0Ch76/kprL9avQHRLdIedjdEpDKhkxo5ypkb4PZd6nCwpEm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=y7deh0K5X9wfqp93eXMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeC2UqB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:46:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeC2Ud7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:33:59 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] aio: add delayed cancel support
Date: Thu, 29 Mar 2018 22:33:05 +0200
Message-Id: <20180329203328.3248-8-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The upcoming aio poll support would like to be able to complete the
iocb inline from the cancellation context, but that would cause a
double lock of ctx_lock with the current locking scheme.  Move the
cancelation outside the context lock to avoid this reversal, which
suits the existing usb gadgets users just fine as well (in fact
both unconditionally disable irqs and thus seem broken without
this change).

To make this safe aio_complete needs to check if this call should
complete the iocb.  If it didn't the callers must not release any
other resources.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 60 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index c724f1429176..2406644e1ecc 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -177,6 +177,9 @@ struct aio_kiocb {
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
 
+	unsigned int		flags;		/* protected by ctx->ctx_lock */
+#define AIO_IOCB_CANCELLED	(1 << 0)
+
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -543,9 +546,9 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
 #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
 
-void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
+static void __kiocb_set_cancel_fn(struct aio_kiocb *req,
+		kiocb_cancel_fn *cancel)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
@@ -557,6 +560,12 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	req->ki_cancel = cancel;
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
+
+void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
+{
+	return __kiocb_set_cancel_fn(container_of(iocb, struct aio_kiocb, rw),
+			cancel);
+}
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
 
 static void free_ioctx(struct work_struct *work)
@@ -593,18 +602,23 @@ static void free_ioctx_users(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 	struct aio_kiocb *req;
+	LIST_HEAD(list);
 
 	spin_lock_irq(&ctx->ctx_lock);
-
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
+		req->flags |= AIO_IOCB_CANCELLED;
+		list_move_tail(&req->ki_list, &list);
+	}
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	while (!list_empty(&list)) {
+		req = list_first_entry(&list, struct aio_kiocb, ki_list);
 		list_del_init(&req->ki_list);
 		req->ki_cancel(&req->rw);
 	}
 
-	spin_unlock_irq(&ctx->ctx_lock);
-
 	percpu_ref_kill(&ctx->reqs);
 	percpu_ref_put(&ctx->reqs);
 }
@@ -1040,22 +1054,30 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
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
 
+	if (iocb->ki_cancel) {
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
 
@@ -1131,6 +1153,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 		wake_up(&ctx->wait);
 
 	percpu_ref_put(&ctx->reqs);
+	return true;
 }
 
 /* aio_read_events_ring
@@ -1379,6 +1402,7 @@ SYSCALL_DEFINE1(io_destroy, aio_context_t, ctx)
 static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct aio_kiocb *iocb = container_of(kiocb, struct aio_kiocb, rw);
+	struct file *file = kiocb->ki_filp;
 
 	if (kiocb->ki_flags & IOCB_WRITE) {
 		struct inode *inode = file_inode(kiocb->ki_filp);
@@ -1392,8 +1416,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	fput(kiocb->ki_filp);
-	aio_complete(iocb, res, res2);
+	if (aio_complete(iocb, res, res2, 0))
+		fput(file);
 }
 
 static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
@@ -1536,11 +1560,13 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
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
@@ -1816,11 +1842,13 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	spin_lock_irq(&ctx->ctx_lock);
 	kiocb = lookup_kiocb(ctx, iocb, key);
 	if (kiocb) {
+		kiocb->flags |= AIO_IOCB_CANCELLED;
 		list_del_init(&kiocb->ki_list);
-		ret = kiocb->ki_cancel(&kiocb->rw);
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
+	if (kiocb)
+		ret = kiocb->ki_cancel(&kiocb->rw);
 	if (!ret) {
 		/*
 		 * The result argument is no longer used - the io_event is
-- 
2.14.2

