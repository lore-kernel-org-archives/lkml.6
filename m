Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842726-1526037665-2-11519038027753103948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037665; b=VC9SCXiAJq1ea4Y9JRe5x+8nBh6mYshvuivyql1VUagEa1N5IH
    134BgJeDWtgF7byM0FQi5BC1yDQVjFxXHU4eKpn9hwFVKeW71GtP1cGXD1VwLig9
    iPl4M7yEnkiinvMIYIY2tPrq8ggU7MAyhTtbF5DjRalmDXqeFLZLV2ymife99K+G
    evlUu7gvTWIewPophrsvnUBSjegb4REcNQd4KY5ZCRw7e3hlBTUHYdor3g0mCeBE
    6QQ/uemxm8nSx57S5KR5BIm6r9hQ4fT3HOEzCnMJeb72lrmeW8aeTrmYOS1Oo/c0
    6rNU0pCdpymXCjN3zVzjxdwwrf0SbLlDd1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037665; bh=
    Hqbs16KSEacUCu6pkD/3g3OC6ua0/pms/gKpLq7hhtQ=; b=IvyctCEHOiDNagUa
    oUVM5wwgmzQlHjBa52CAjy24M1VPEKpz5E4IydiwJgC7Wp2OSsM3AMqMGTuEdTl4
    wQ1xJdacSNtxkz/hRiRKGZ1RUWZNbA9EGXnujIb9Dltc6pFBskB52mr/c7IHCBRn
    9jWHA+oi9M2qTjAYFxYChntWfZ3vonHyhzT4T5xPXH5Sc+zPJBDo5j201Xcrr8Ge
    /rkK7kITT3q29h7qd+Ty4eV6Tx83ybc9ijwun2dSA15CJAWOMbUm2wNXjR7nSCJY
    2pJaCAZdsFhl8MdFabQ21XVBr1NakMe5OA6cYOgnJ/z/wv8frbPONTHN/su4yfGi
    yRKxfA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=tTadJdVN
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=tTadJdVN
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPsJEXW5T1wjPGbkdJTyOswDkPZpvRi4yrPsNdwrMMKMd7TUpNe9nW9w3AMye+DvIpk9dxhhYm+qNBPIGRohZhAqjaQGJLLkQ1kPkeV68aUd4b5kS5IQ
    83kA+c5D5OwLFEFZsAQ33IAuXHs7sL3xIJolPh3LaMmROwvFDzOSZKBcf73HtysZsYjZ8VkFtVL70YGLxPOUgkyMZKXZfLgZ9tyXUpBw9RdOipm9eEel0voW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=GZiGuu59xe6QNL0EksgA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeEKLIk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:08:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeEKLIh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:37 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/32] aio: add delayed cancel support
Date: Fri, 11 May 2018 13:07:40 +0200
Message-Id: <20180511110803.10910-10-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The upcoming aio poll support would like to be able to complete the iocb
inline from the cancellation context, but that would cause a double lock
of ctx_lock as-is.  Add a new delayed_cancel_reqs list of iocbs that
should be cancelled from outside the ctx_lock by calling the (re-)added
ki_cancel callback.

To make this safe aio_complete needs to check if this call should complete
the iocb, and to make that safe without much reordering a struct file
argument to put is padded to aio_complete.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 80 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 29 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index be10dde20c8e..3afca506c7f0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -138,7 +138,8 @@ struct kioctx {
 
 	struct {
 		spinlock_t	ctx_lock;
-		struct list_head active_reqs;	/* used for cancellation */
+		struct list_head cancel_reqs;
+		struct list_head delayed_cancel_reqs;
 	} ____cacheline_aligned_in_smp;
 
 	struct {
@@ -171,6 +172,7 @@ struct aio_kiocb {
 	};
 
 	struct kioctx		*ki_ctx;
+	int			(*ki_cancel)(struct aio_kiocb *iocb);
 
 	struct iocb __user	*ki_user_iocb;	/* user's aiocb */
 	__u64			ki_user_data;	/* user's data for completion */
@@ -178,6 +180,9 @@ struct aio_kiocb {
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
 
+	unsigned int		flags;		/* protected by ctx->ctx_lock */
+#define AIO_IOCB_CANCELLED	(1 << 1)
+
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -584,18 +589,23 @@ static void free_ioctx_users(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, users);
 	struct aio_kiocb *req;
+	LIST_HEAD(list);
 
 	spin_lock_irq(&ctx->ctx_lock);
-
-	while (!list_empty(&ctx->active_reqs)) {
-		req = list_first_entry(&ctx->active_reqs,
+	while (!list_empty(&ctx->cancel_reqs)) {
+		req = list_first_entry(&ctx->cancel_reqs,
 				       struct aio_kiocb, ki_list);
 		list_del_init(&req->ki_list);
 		req->rw.ki_filp->f_op->cancel_kiocb(&req->rw);
 	}
-
+	list_splice_init(&ctx->delayed_cancel_reqs, &list);
 	spin_unlock_irq(&ctx->ctx_lock);
 
+	while (!list_empty(&list)) {
+		req = list_first_entry(&list, struct aio_kiocb, ki_list);
+		req->ki_cancel(req);
+	}
+
 	percpu_ref_kill(&ctx->reqs);
 	percpu_ref_put(&ctx->reqs);
 }
@@ -715,7 +725,8 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	mutex_lock(&ctx->ring_lock);
 	init_waitqueue_head(&ctx->wait);
 
-	INIT_LIST_HEAD(&ctx->active_reqs);
+	INIT_LIST_HEAD(&ctx->cancel_reqs);
+	INIT_LIST_HEAD(&ctx->delayed_cancel_reqs);
 
 	if (percpu_ref_init(&ctx->users, free_ioctx_users, 0, GFP_KERNEL))
 		goto err;
@@ -1032,25 +1043,34 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	return ret;
 }
 
+#define AIO_COMPLETE_CANCEL	(1 << 0)
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
-static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+static void aio_complete(struct aio_kiocb *iocb, struct file *file, long res,
+		long res2, unsigned complete_flags)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
 	unsigned tail, pos, head;
-	unsigned long	flags;
+	unsigned long flags;
 
 	if (!list_empty_careful(&iocb->ki_list)) {
-		unsigned long flags;
-
 		spin_lock_irqsave(&ctx->ctx_lock, flags);
+		if (!(complete_flags & AIO_COMPLETE_CANCEL) &&
+		    (iocb->flags & AIO_IOCB_CANCELLED)) {
+			spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+			return;
+		}
+
 		list_del(&iocb->ki_list);
 		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 	}
 
+	fput(file);
+
 	/*
 	 * Add a completion event to the ring buffer. Must be done holding
 	 * ctx->completion_lock to prevent other code from messing with the tail
@@ -1384,8 +1404,7 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	fput(kiocb->ki_filp);
-	aio_complete(iocb, res, res2);
+	aio_complete(iocb, kiocb->ki_filp, res, res2, 0);
 }
 
 static int aio_prep_rw(struct kiocb *req, struct iocb *iocb)
@@ -1437,7 +1456,7 @@ static inline ssize_t aio_rw_ret(struct kiocb *req, ssize_t ret)
 			unsigned long flags;
 
 			spin_lock_irqsave(&ctx->ctx_lock, flags);
-			list_add_tail(&iocb->ki_list, &ctx->active_reqs);
+			list_add_tail(&iocb->ki_list, &ctx->cancel_reqs);
 			spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 		}
 		return ret;
@@ -1539,11 +1558,10 @@ static ssize_t aio_write(struct kiocb *req, struct iocb *iocb, bool vectored,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
-	int ret;
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, fsync);
+	struct file *file = req->file;
 
-	ret = vfs_fsync(req->file, req->datasync);
-	fput(req->file);
-	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
+	aio_complete(iocb, file, vfs_fsync(file, req->datasync), 0, 0);
 }
 
 static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
@@ -1768,18 +1786,12 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 }
 #endif
 
-/* lookup_kiocb
- *	Finds a given iocb for cancellation.
- */
 static struct aio_kiocb *
-lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb)
+lookup_kiocb(struct list_head *list, struct iocb __user *iocb)
 {
 	struct aio_kiocb *kiocb;
 
-	assert_spin_locked(&ctx->ctx_lock);
-
-	/* TODO: use a hash or array, this sucks. */
-	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
+	list_for_each_entry(kiocb, list, ki_list) {
 		if (kiocb->ki_user_iocb == iocb)
 			return kiocb;
 	}
@@ -1801,6 +1813,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 {
 	struct kioctx *ctx;
 	struct aio_kiocb *kiocb;
+	LIST_HEAD(dummy);
 	int ret = -EINVAL;
 	u32 key;
 
@@ -1814,12 +1827,21 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	kiocb = lookup_kiocb(ctx, iocb);
+	kiocb = lookup_kiocb(&ctx->delayed_cancel_reqs, iocb);
 	if (kiocb) {
-		list_del_init(&kiocb->ki_list);
-		ret = kiocb->rw.ki_filp->f_op->cancel_kiocb(&kiocb->rw);
+		kiocb->flags |= AIO_IOCB_CANCELLED;
+		list_move_tail(&kiocb->ki_list, &dummy);
+		spin_unlock_irq(&ctx->ctx_lock);
+
+		ret = kiocb->ki_cancel(kiocb);
+	} else {
+		kiocb = lookup_kiocb(&ctx->cancel_reqs, iocb);
+		if (kiocb) {
+			list_del_init(&kiocb->ki_list);
+			ret = kiocb->rw.ki_filp->f_op->cancel_kiocb(&kiocb->rw);
+		}
+		spin_unlock_irq(&ctx->ctx_lock);
 	}
-	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (!ret) {
 		/*
-- 
2.17.0

