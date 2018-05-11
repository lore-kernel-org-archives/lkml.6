Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037699-2-16420118252036938184
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037698; b=Lcj+946qlQedX2Rd63TD3dbpIYp3UvPhBY5QCU4fDRccYXPZ6h
    OpGoQDCIsxHBn46wt/ubA2yAEKNUVK30fS1f+qHOMTAfyavydK28uqtnvB2OoGvz
    1gFq89QDcM/qxntPApNDps/519DPDDgh3n1JExvI9bbjojUf2K+rhy7/xLd+cfTn
    FHyo/SOngMBwcqqfm87AT01RXKQnkEZ9kXvX2ocUSW1OLCkkCSv/yEkprh80wpum
    jJWFJt4HFuZWAM0dJkZWQY3I+LZDvUN2+dtn48QQC8V2ssgbI2AJrj79RW6wHV2h
    jY/3L5IQa1VstgtJJDRnpRRjbACBQSJ8hx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037698; bh=
    0ob2WQm2AgVNQ5XJyZo3Y2Wpfxx8gVO78HFzg6K7eSI=; b=CcUghvP7b5jVYJiP
    HfNwcUj4NVF09fLO/XUJQQdxr1/sBlcgLkPUIZnWdm6vtgt5sRkAJQPWWbsUcc22
    IZXhQ05Q/qgFkmyqZaJnbNDXj7VGgklFa2Nii4TBa6ZziPO3/qV2mvBzr4E+N/ee
    BdqBh3/SYcWqR15V8anSkLIRC1KL/TAFuM2OrdSFln0XLNzd54hoDKmgFt7QGUox
    jdol4sW9au7g0IlmeNhwliLt042so2TudHskI/+FhNibzH4xKqVZ9MJeKsWGWd8a
    0bSHRlJ/A9DzXJRA5/dMvr/BS6YiwFZs9FycaU1zoEPj74bSy0MlzOdd7ZxpShw/
    j6uP5g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=qrkm6ozn
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=qrkm6ozn
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
X-CM-Envelope: MS4wfO+JPVtQ578qkiBbW8nDYBaiN7ZZ39nAFhdA98MSK7Vl6jal5KM8a8UAflUXUkmRhefRraBi4u0iHDK1Q9+BEg25+jGcWlIDKCNSWsL0iKYkhxhSZ8i8
    KatqdnB+lX/LWMDhJf0udnH6rf6KVrbago8NGuXdJ/3g83rqh+eiUTWtJ8CxKcdPrFvbXvHHWceLjZKMMrkn283TvtoXiR2ic0hecUZ1ZsnKbL+lwdgzq6qX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ngUzud9BF-H0qhY5OAkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeEKLIe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:08:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752998AbeEKLIb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:31 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/32] aio: simplify cancellation
Date: Fri, 11 May 2018 13:07:38 +0200
Message-Id: <20180511110803.10910-8-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the current aio code there is no need for the magic KIOCB_CANCELLED
value, as a cancelation just kicks the driver to queue the completion
ASAP, with all actual completion handling done in another thread. Given
that both the completion path and cancelation take the context lock there
is no need for magic cmpxchg loops either.  If we remove iocbs from the
active list before calling ->ki_cancel we can also rely on the invariant
thay anything found on the list has a ->ki_cancel callback and can be
cancelled, further simplifing the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 49 ++++++-------------------------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2e0bc04f7920..8991baa38d5d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -164,19 +164,6 @@ struct fsync_iocb {
 	bool			datasync;
 };
 
-/*
- * We use ki_cancel == KIOCB_CANCELLED to indicate that a kiocb has been either
- * cancelled or completed (this makes a certain amount of sense because
- * successful cancellation - io_cancel() - does deliver the completion to
- * userspace).
- *
- * And since most things don't implement kiocb cancellation and we'd really like
- * kiocb completion to be lockless when possible, we use ki_cancel to
- * synchronize cancellation and completion - we only set it to KIOCB_CANCELLED
- * with xchg() or cmpxchg(), see batch_complete_aio() and kiocb_cancel().
- */
-#define KIOCB_CANCELLED		((void *) (~0ULL))
-
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
@@ -574,27 +561,6 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 }
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
 
-static int kiocb_cancel(struct aio_kiocb *kiocb)
-{
-	kiocb_cancel_fn *old, *cancel;
-
-	/*
-	 * Don't want to set kiocb->ki_cancel = KIOCB_CANCELLED unless it
-	 * actually has a cancel function, hence the cmpxchg()
-	 */
-
-	cancel = READ_ONCE(kiocb->ki_cancel);
-	do {
-		if (!cancel || cancel == KIOCB_CANCELLED)
-			return -EINVAL;
-
-		old = cancel;
-		cancel = cmpxchg(&kiocb->ki_cancel, old, KIOCB_CANCELLED);
-	} while (cancel != old);
-
-	return cancel(&kiocb->rw);
-}
-
 /*
  * free_ioctx() should be RCU delayed to synchronize against the RCU
  * protected lookup_ioctx() and also needs process context to call
@@ -641,9 +607,8 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-
 		list_del_init(&req->ki_list);
-		kiocb_cancel(req);
+		req->ki_cancel(&req->rw);
 	}
 
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1843,8 +1808,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 {
 	struct kioctx *ctx;
 	struct aio_kiocb *kiocb;
+	int ret = -EINVAL;
 	u32 key;
-	int ret;
 
 	if (unlikely(get_user(key, &iocb->aio_key)))
 		return -EFAULT;
@@ -1856,13 +1821,11 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-
 	kiocb = lookup_kiocb(ctx, iocb);
-	if (kiocb)
-		ret = kiocb_cancel(kiocb);
-	else
-		ret = -EINVAL;
-
+	if (kiocb) {
+		list_del_init(&kiocb->ki_list);
+		ret = kiocb->ki_cancel(&kiocb->rw);
+	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (!ret) {
-- 
2.17.0

