Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604614-1527103943-2-1777055821397211227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527103942; b=fuxhLh8og7uPO5eI32gFendL6Fm93Ah8d3tI/J+i6Y8vq9RkS0
    2HoZQeAnA2nGBSoaQupTo74bN+feHE6wD62kyQBFYQOsL7vjIDDgK5iYNZdjeLik
    Q2Q/rWQdQsHs8YqVKzYAXbFRvsxf/d1sO+bFdPLppS8uuuems1l9yLGrrcfub1N5
    1rLgAu7qXRzLp790YjP+76jbk2FnWlLF7BFxK1d3mlrcn/Bd+AXeBv7XeHN0jIhm
    bu46QcVsASY21PMhOX7Zf11tBklpGBv/sEGH8Jdol3zeB6iTxaTOXnK4qS0fdgLc
    iQsDalyJANlKBBvgDWzJoTBURxvpVkVlINtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527103942; bh=
    xI46qGU26MaJxXo5Ad9EGoYM8RJzYjtVPHndIptCvXE=; b=Hm8/z+HccXsfxxwQ
    CYlCPmxr6xJiFE4GSlJK9Zt11NbaM8AKiZS5OIhNTugsMKO/E+egltwFHwwHL33C
    OKYkbHWYu68mBe+2QyTLDTUKhaMJwUrAyswouIi7j2ao0Iql0amgT6CsyCopA8lm
    1RRakpHL65e/VcvlU2G8tucAEsLIuymndk7EfGwFCL0FvhWagJa6AMUsWPpT9gnU
    mzbArUFEzWORh2hIVEtrRFg6k1eS0g2578tKHsgqbHzWC7z/vThig0nKnCNQouYO
    O18V7lI/yYY9g02Y7YY4Zoa4Yt9N/3UAIx0UV75gRrpoAFO7gvN3YpQNYKfxcLaY
    z3OfDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=TIMTPWRQ
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=TIMTPWRQ
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
X-CM-Envelope: MS4wfF8KSewv/vxwJ8923dktsJTgH/UfSCF1q2hCIDWv3lPEIRRcGw1WEPPy2tuYrKlL0T9uYLjp9eos28DnyLLvc7McJU2v7thLk/TpVA0BAXRd3ZgpnVDd
    WC08axN0PcG+540cfkgcppDZ/Rdwv8quq24n9aR9P6hDUhGBy8g8Of9JW607xTVJcWC6L7GrKARdUPAcX0Li7488OLko013qqjwXzPLugN1kf8yQZmFqaEp8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ngUzud9BF-H0qhY5OAkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934586AbeEWTbo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:31:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934288AbeEWTUw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 May 2018 15:20:52 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/33] aio: simplify cancellation
Date: Wed, 23 May 2018 21:19:58 +0200
Message-Id: <20180523192022.1703-10-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
References: <20180523192022.1703-1-hch@lst.de>
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
active list after calling ->ki_cancel (but with ctx_lock still held), we
can also rely on the invariant thay anything found on the list has a
->ki_cancel callback and can be cancelled, further simplifing the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 48 ++++++------------------------------------------
 1 file changed, 6 insertions(+), 42 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 50a90e5581ed..0633cf3b325c 100644
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
@@ -641,7 +607,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-		kiocb_cancel(req);
+		req->ki_cancel(&req->rw);
 		list_del_init(&req->ki_list);
 	}
 
@@ -1842,8 +1808,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 {
 	struct kioctx *ctx;
 	struct aio_kiocb *kiocb;
+	int ret = -EINVAL;
 	u32 key;
-	int ret;
 
 	if (unlikely(get_user(key, &iocb->aio_key)))
 		return -EFAULT;
@@ -1855,13 +1821,11 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
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
+		ret = kiocb->ki_cancel(&kiocb->rw);
+		list_del_init(&kiocb->ki_list);
+	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	if (!ret) {
-- 
2.17.0

