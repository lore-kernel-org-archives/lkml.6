Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522223021-2-10139967221484578537
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522223020; b=vwrDB2OrBv48/cLiHCl9ntd6p0nhE3ToqQASeRrXGVbgyhV
    gpQhVoLHLqmYsHN+/CC6ziLnljNE0Xj3YGrtCuUtQbVuBc8N3vUltDNloUC2dIP7
    hPz0EmTA/awlQWFiRg3GlFG8ya+Uhr1NmnLDanQGmKmuMp5X5vS+TahMRAZ/aqQp
    /mMEoY0ZCoixM/eOkLp2XX8vJDsblTQEenvCrxRrr6iIqJ95xxGveQ4os7b8jylT
    TIYhd4WO/rWxJYU1qyRfb+UgHaKN2zcV2U8jFE1w/+W2afBihUHOVepgSefN8FfL
    Wxe7eOQhcqQqJIh1jcuQDjYm2NWXfTgbW52mwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522223020;
    bh=eJoS1uIfMVWL9n0ZMOgjj7GNMJt/GSlDi8XUbblUtqQ=; b=mgUf8jsFrGKi
    vX+bBfSOU88OKhjyEWpVy1CyYvpgVPzGVtQG8Mii+ojUaSN7XObUqIt4CgqSQ//q
    MXOSKeAuU7taA1IXBK9yQ7zTKc3+jI4tFQbLbUC/as8jsSRvLgXufmnttdnAjWT7
    3Hq8DXObTEMM1C0bmhiEBlXqC1j4Y05Q61eXHdpAZ734mnnOPxCfxi4qWOvUBMRu
    sif3XqE6sIVwwKNrbHHzunLucRRHBqjafOdl7M8yWcIW6Ni3cMmy6InBTzBKwCqT
    f7YF66qcXditMsbhj3bnQh9x2tfV6B2gcWPhIIRe15AZP4Fg+u0JtPFrmhsq9rWw
    PmYPyBG9Qw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=o0DpQvR5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=o0DpQvR5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCkR0jTULWwfNOrAR8+y1UIVCag/0G6Bmd1Ti9t8QfOg082oaJ+uNWErMzsfsNgkAcRnaamQzhNl/mm5XBjhNRSOQac3d3ZZ3oyAo22wepGsumOl7HMQ
    A6fk76nd+quV2qHqt6nugyOMgEjLjF+UcJsljnmXVBB6O+QqAMoDYbMx/BF+uvxag3Bzop0eY4kUIJYsrRZ4TqGhsQNGTKiWj99kU+CEvOOGo8rKz756cWTz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=mIIJaJi10dZjUBAxGVcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeC1H35 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:29:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbeC1H3z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:29:55 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] aio: simplify cancellation
Date: Wed, 28 Mar 2018 09:29:02 +0200
Message-Id: <20180328072926.17131-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
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
 fs/aio.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 0df07d399a05..c36eec8b0879 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -162,19 +162,6 @@ struct fsync_iocb {
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
@@ -574,23 +561,8 @@ EXPORT_SYMBOL(kiocb_set_cancel_fn);
 
 static int kiocb_cancel(struct aio_kiocb *kiocb)
 {
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
+	list_del_init(&kiocb->ki_list);
+	return kiocb->ki_cancel(&kiocb->rw);
 }
 
 static void free_ioctx(struct work_struct *work)
@@ -633,8 +605,6 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req = list_first_entry(&ctx->active_reqs,
 				       struct aio_kiocb, ki_list);
-
-		list_del_init(&req->ki_list);
 		kiocb_cancel(req);
 	}
 
-- 
2.14.2

