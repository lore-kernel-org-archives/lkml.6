Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526989323-2-14987974784131241759
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
    1526989322; b=BqKbBC6gORDKyxkZ2I2pB21ZG4mTzUnoWxBT+xXet9XC+gcCNZ
    MV26kcoEA+ezRgzWfyosHaLM8teC27rrM8YD5WyBEPoyQoFAgLPuM4hlW1UeHwce
    7ZsMtDh8DEq+mUttghXD/+pqhQfcutrRNK0WrqYYz1SaongAlMBx8K9JSZq7Nh0v
    AxVBBTHUKDrwxjIs19/O+oiDftXofd0VTVDCYP7Z0xzuID45MAYBs4MM2P3Rg9e8
    TK736mCAPmDNpCtbA3rOHxtpEWgIyI5LNv08P0VSw/7TaeM42Hy4Rpvk3BON5Zmo
    ff2JnGwENWJ1BBBQTlC6xawregX8I0Vs1mjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526989322; bh=
    0ob2WQm2AgVNQ5XJyZo3Y2Wpfxx8gVO78HFzg6K7eSI=; b=YqfjcQRlpHoe8zLD
    z8cf/uOuRYSx4JN56uRnIM82tr/JF2eN4naxvyKyICRGTme21U79jjp1KDvhQIhX
    uBcqS7I+qW9SkkMTJmcUGBInSw+zD5Zcvbt+OcMlXA9MpUt1bSkvqR3sbAALWrXe
    6BXdmtV2+dI3qvhbWfdlcLv1dcmI9ZkVKkTufza6GPctkga4h3KPXb7EJkXYAYKV
    ZvKMpmuOpYJn0h93iz/0hvXNkXg9viYi06PulhsBDsbJafu0mC/e2NLzfnubw1/s
    Ln6JiZHz/TVISvLZ4SerS6DRiKY/EqjXOcpg8O2yOOZTRo+g++fMxFJ1Tvc/2k1n
    iVRERw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=F8koA7z0
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=F8koA7z0
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
X-CM-Envelope: MS4wfPNhU323U7bm8He91sXPYGcUQJLJ8zboWr9GHOgp4tK5EPJ3l9KexE5kTwaGecGMku1yqngwUn0Fs+LD3J0QWECmyD9UHV9z+erEysnp5ElqkNMEIt0/
    0TjrYnifAQEhy2TOW/sXdZbaCd0Dh/Wbqb52ZJwdvRkwqNVcdBqBvJs1hxrvIshXaNOaVbo9Yg0X519iKOGUt0NfgGOaJLeGQA83RGAyj/q3az6eNAoNEgXn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ngUzud9BF-H0qhY5OAkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeEVLlm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:41:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeEVLbs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 07:31:48 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/31] aio: simplify cancellation
Date: Tue, 22 May 2018 13:30:44 +0200
Message-Id: <20180522113108.25713-8-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522113108.25713-1-hch@lst.de>
References: <20180522113108.25713-1-hch@lst.de>
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

