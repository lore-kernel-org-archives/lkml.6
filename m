Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684081-1520286177-2-8578182530264785157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520286177; b=IjTHeyeOqk4Wjd3vsy76h5NQJj6ktRlfeEOzdG8aIive+eF
    QkW8tZ4LMjZdhjPweYDZRqSrLhiZAOgZI/jy9/FiKldddlDD+SRWwAZU35AeZusM
    SEbR1wmYgyd81yfedu6fYqlDnpd/2z9muW/RTpl3Q/dvAuwJLrLDTsFDghouRI1y
    Fb2vGSXlDZ95+FSKZNn0zlzsrUGXZWbKcfebHojkmChYTHVAEUZ7Dy7s8/++Wt6A
    UxzqZTMvUTfomcwe0yjFsjYWqrJuWsEhQQZcIj9O42CLBozegHZfdX9EHAHPJbna
    Rj7LOOAyk0+sk0V9gstGiDt1j2Zhv6ulehVm95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520286177;
    bh=d0m+AKIKiFglhLqjWHeYqQ2HEgwi+KebFzgyQf51WD0=; b=PSijtWxn+U9j
    FkYfh69rAK4Db3wT0SgoR8Lrm3rk52f8OypoeIXAlFdn+WKo4DivjEJTIhT/NdRP
    t4Ue3tbJE0B+LUJgAX9bK6QixOBM13sAaVtfP33lpqEL0aoywbQBBKXaVwkxVqG7
    w1v6EyqLDcabVWL9PciXfHFVE67+N4zTRd5CT3ruR1ohw5Blb73aySCbvAjli1fp
    tziCf/VxaMy9mOjSoZcBiGGDKwdbkrHUS7fYtaAxp8mZpN/ctV3VG8a8d0Yp3Eha
    Xxa2lVTDdYEei7qKdW1QZSX7tV8qbmQymGhvLw0kzc3f7GRiMbfizZ56ipDRs0KA
    I7KI5H1yGw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=fyNSlUfh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=fyNSlUfh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeCEVkC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:40:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbeCEV1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:50 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/36] aio: sanitize ki_list handling
Date: Mon,  5 Mar 2018 13:27:11 -0800
Message-Id: <20180305212743.16664-5-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Instead of handcoded non-null checks always initialize ki_list to an
empty list and use list_empty / list_empty_careful on it.  While we're
at it also error out on a double call to kiocb_set_cancel_fn instead
of ignoring it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
---
 fs/aio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 6295fc00f104..c32c315f05b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -555,13 +555,12 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ctx->ctx_lock, flags);
-
-	if (!req->ki_list.next)
-		list_add(&req->ki_list, &ctx->active_reqs);
+	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
+		return;
 
+	spin_lock_irqsave(&ctx->ctx_lock, flags);
+	list_add_tail(&req->ki_list, &ctx->active_reqs);
 	req->ki_cancel = cancel;
-
 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
 }
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
@@ -1034,7 +1033,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 		goto out_put;
 
 	percpu_ref_get(&ctx->reqs);
-
+	INIT_LIST_HEAD(&req->ki_list);
 	req->ki_ctx = ctx;
 	return req;
 out_put:
@@ -1080,7 +1079,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	unsigned tail, pos, head;
 	unsigned long	flags;
 
-	if (iocb->ki_list.next) {
+	if (!list_empty_careful(iocb->ki_list.next)) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&ctx->ctx_lock, flags);
-- 
2.14.2

