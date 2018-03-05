Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684081-1520286271-2-2629385844059669179
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520286270; b=CKPDZL8V7wlj+aNzahEpiqfdvtbiU1MwsDMaC87qdD6psxY
    TW6GwPoFf2I2Gkg9QpEJaxFCs4hitSk3IpcEQwLUGNM9Zuka4da8FA5u50bfyqma
    u8PXj8w6VoVtjxNEYSb8+F6AcdPZ4K4FZQ8dLS3i0S1aAzmKiv+zmewHtEIJKBna
    xKuD6jSvShLOo3vADuj/1sOE06PQLmlBIUJdWsy2s3dFbFlZiNzXJLJLQzJj5/jS
    sEsG7cvFfys8khi5wjfBqcV/JXSZaGoUCo49sd4p+tgATIVsa6EWdEdbr74g49Xk
    WNJE8rEj7Oxv3WmxMOO+p0p1vWh1/hMoEAr6Mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520286270;
    bh=Kg+Hy36NtWjy1Av6TXTZg3S8v3wKqgMPuAYVu1ScJs4=; b=SqJhD7YANgOX
    6NPXch1lcSo2Iv3QMHXQstIqQK/lP6Zedsgw0uR8ue/p0ezPx4w87d+yUDj7TZbJ
    VLhgD71ROa0ER/X2RVmNtaoMJgrBEuGzPA4xFI5CiE/CvghyoqPxisze4a3elKIN
    4kHgk+fWCz93OM7JT0kZpOz0hsBIvcrAbkZA+9tlF7USwvHNPYVklnhwSk8LoAdu
    odaElqNZySOOw5rtkTQAP8wROLr11EmtLHsKrB/Fd3dt7erSx1ig+W9opgipQHBb
    9pM71V+iv+prnQ0VgYNkLOsh6B8RyvJs1GdFdyjw1FGiCkOwzcqzFWzfKtgjxNkC
    y/MiyWpNIA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SmykMrgV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=SmykMrgV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeCEVnn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:43:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCEV1t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:49 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/36] aio: add delayed cancel support
Date: Mon,  5 Mar 2018 13:27:14 -0800
Message-Id: <20180305212743.16664-8-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
---
 fs/aio.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 0b6394b4e528..9d7d6e4cde87 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -170,6 +170,10 @@ struct aio_kiocb {
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
 
+	unsigned int		flags;		/* protected by ctx->ctx_lock */
+#define AIO_IOCB_DELAYED_CANCEL	(1 << 0)
+#define AIO_IOCB_CANCELLED	(1 << 1)
+
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -536,9 +540,9 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
 #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
 
-void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
+static void __kiocb_set_cancel_fn(struct aio_kiocb *req,
+		kiocb_cancel_fn *cancel, unsigned int iocb_flags)
 {
-	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
@@ -548,8 +552,15 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	spin_lock_irqsave(&ctx->ctx_lock, flags);
 	list_add_tail(&req->ki_list, &ctx->active_reqs);
 	req->ki_cancel = cancel;
+	req->flags |= iocb_flags;
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
+
+void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
+{
+	return __kiocb_set_cancel_fn(container_of(iocb, struct aio_kiocb, rw),
+			cancel, 0);
+}
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
 
 /*
@@ -603,17 +614,27 @@ static void free_ioctx_users(struct percpu_ref *ref)
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
-	}
 
+		if (req->flags & AIO_IOCB_DELAYED_CANCEL) {
+			req->flags |= AIO_IOCB_CANCELLED;
+			list_move_tail(&req->ki_list, &list);
+		} else {
+			kiocb_cancel(req);
+		}
+	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
+	while (!list_empty(&list)) {
+		req = list_first_entry(&list, struct aio_kiocb, ki_list);
+		kiocb_cancel(req);
+	}
+
 	percpu_ref_kill(&ctx->reqs);
 	percpu_ref_put(&ctx->reqs);
 }
@@ -1785,15 +1806,22 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	if (unlikely(!ctx))
 		return -EINVAL;
 
-	spin_lock_irq(&ctx->ctx_lock);
+	ret = -EINVAL;
 
+	spin_lock_irq(&ctx->ctx_lock);
 	kiocb = lookup_kiocb(ctx, iocb, key);
+	if (kiocb) {
+		if (kiocb->flags & AIO_IOCB_DELAYED_CANCEL) {
+			kiocb->flags |= AIO_IOCB_CANCELLED;
+		} else {
+			ret = kiocb_cancel(kiocb);
+			kiocb = NULL;
+		}
+	}
+	spin_unlock_irq(&ctx->ctx_lock);
+
 	if (kiocb)
 		ret = kiocb_cancel(kiocb);
-	else
-		ret = -EINVAL;
-
-	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (!ret) {
 		/*
@@ -1805,7 +1833,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	}
 
 	percpu_ref_put(&ctx->users);
-
 	return ret;
 }
 
-- 
2.14.2

