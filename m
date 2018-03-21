Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3333851-1521617717-2-8991697731821759345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521617716; b=vTPqsYLDg9m5OXM0Of7LVenlRpXfbB1EtRNaFPNI6r2zwYz
    yjU8sYjFM7ryMZMVgubzpSq5MmDAKxlQhzUgzt6V84fMyEPrzNu9+q4HkbhITlCR
    or/kIlfLtvOntqERsgXuWl850OVngx06lSa/pZ4Y8VKFOnbuUQplL096YKVOmLHD
    chBEb5LV/oTC1qr+HBxd9dhyC8oS1r4az5J2LyotYBAj48KMO+gHWhb15g7/4LIu
    Wts9ImrRbl1rq+BQvw60B6sRAu9Zc2RH2foYTRFyA1WfyOIrUzXA9tSOwJKpX9lV
    kOQJOC65tQXn6OUFT8imE0paLVUyzf7wbW0jIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521617716;
    bh=Q7LGuDOrYj7UGY+UOtIZY37o/WQr8RL3pm+tpF7NnYE=; b=vgMkRAkHQcSV
    35WCYJFMnwbiKQDsZvKDs6HHvKTGyDGzLRFGwzDmB5EfXuOwlyzC4qW5WjThVDp0
    GD+bQQJWR6hxGxKsICWvajuJVCFQYeKXJfYgPhLkaKcbLl5effELDIkCOe78jCJi
    56FDiV4sCwyDZPupcCnWCmGWIHpwGwbRc2vQ6vY9Q8t3sKkK7Wmo2C3iC+vuCmIQ
    1lO3bWibv6MhY4CtGjXXpKDycKKEcDGdVEYKTm0OPQS2s5E13Gziv2sauF5EB9Uq
    yWXVDAJQGECq2Fw9JNrjulR+LBKgDcimf4pQKo1qjiZgUjej02p0vaROZNQgqCZc
    yX8ppgKmiQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=aQ64T1h+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=aQ64T1h+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeCUHea (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:34:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeCUHcx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:32:53 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] aio: sanitize ki_list handling
Date: Wed, 21 Mar 2018 08:32:27 +0100
Message-Id: <20180321073232.13366-5-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321073232.13366-1-hch@lst.de>
References: <20180321073232.13366-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
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

