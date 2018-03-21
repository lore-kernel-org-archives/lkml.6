Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3333851-1521617622-2-2591345764960405203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521617621; b=ucoBlv1NJWJaxyGNAp2DVfsx+DRXyKIe92tdUMqHQyJQ5+c
    4n0uSgxYc7+DYGV6hMC8zvTKxMgtqdKAloA4H2Vrleqs5cO2HQpEpsq4/6xqfRqw
    TaCxqbm98X6SEKWCkmb5dgTOcxghA34kYdGiso+bL2as7EQxinWFr9wZ1l+jLQLa
    IgBUlXL0k6FhzfLa3GSyaE5PgMdxv8gzs8cTpDKEeZ62YLOd6fdbsUe4DxiVkrn9
    97We/YRnMJZsb5CBItwbWBBDCw+nox/nb6M7UxqapaPmV1NBHbKMnLrMDyUlnHzv
    LGuKJAhiLi+2Mbd1aVoSVmCn7OK/M4Nsx9K8A/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521617621;
    bh=Kg+Hy36NtWjy1Av6TXTZg3S8v3wKqgMPuAYVu1ScJs4=; b=I1W7Mc84UaXV
    RJnrpbdga7Hbb6RivaY1EhoazkNHExv0gNNQKqtqwhcPtN7OZpt2ZzP9TGtMZQXm
    APHPuAqjqh+xh1iqBegClnFSoEbcCwtUW4c4So2BGRcwAJSlVi0Wha8GhE/BX/RF
    Wn/yyjkO18XdIttMck0IEL1BGA/0el3fGkxH635sGum1BI/3VPoLhfrEBH9nbkb4
    kgIyP8ts6yBm7+Yy9hcUMh9wLXCx1yrU1nP+924bfYOqEd3SuQhVE5xZwiwmCg9y
    H8RQXA3IqL06/ADs3dt2Z9rf8DQDJd980UGd6RVfS2AkSyuMsV0GWDQbcerSJVCW
    x5ixe+l6+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=uYK5iTLL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=uYK5iTLL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCUHdK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:33:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeCUHdF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:33:05 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] aio: add delayed cancel support
Date: Wed, 21 Mar 2018 08:32:30 +0100
Message-Id: <20180321073232.13366-8-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321073232.13366-1-hch@lst.de>
References: <20180321073232.13366-1-hch@lst.de>
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

