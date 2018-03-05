Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684081-1520286156-2-5401446996738894751
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
    t=1520286156; b=HJaUexyqN31rSRE2ykHOoPRaQv8Q97rxzHEo745hX4WTdeb
    SkNboGV1XECltGDi7x6D3ZNU5cOOjsi+6cDZ3VCLb8Mpa5EZC71hCldpI2KCu53o
    YOVCXsEso9WbRQp2BalZSh8UIr7o6Coz1Zl71cOMWduDF3ZqH+ggWhK38B3LVzuO
    rsPeCo2dw18bERlt4qXJW0RSHie/Mpkt7hN+kpOgRLd7MboCxoBVUzOhUUFTcp+K
    93Gi+2I62EnL77hmuZOAv9VNAce/jk5MTHSnoNwLtXyypHS7QtLp0vecZ7aHKmGt
    73X64cG8ThhvhQHbjUP9PhXXJAjwUJtly5veXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520286156;
    bh=8tobXlXxyQZbJkdjl3yVb2Bh3VaOvmlK+hRnKh1paw0=; b=K46q9YjNHIlR
    Zh3/Uy45oyV7TAKir+YnyeiXcCRDquDCrfE7Xivm2U26jycr/OvRVdrB9JMVndbI
    gCYfAUdqCAjBQdEZr2uV7IMp/hf4AtSiBWQBV/t/1/ANgwvkeV/fpEfeg7ovi2Bl
    l32GGFea7+7/AedzOLSBEayWgST5eLm5S0UJzSswHSChYiN4ImDCiRv49aXsa5I5
    aPNy4UsorTmxaTfmfNB4XIEajsAcNHEQhPhNyQx8atxVH3jPweYqDfojfNLyvN25
    Us2wVa6GgHy89rYJBcHVkCM4Kp1EBAioTOSQIIqJ/Sil/1CaG0vCwkbM9ynI+aSU
    DpmJXp0XWA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=pvsDE482 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=pvsDE482 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeCEVkE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:40:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932314AbeCEV1u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:50 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/36] aio: simplify cancellation
Date: Mon,  5 Mar 2018 13:27:12 -0800
Message-Id: <20180305212743.16664-6-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
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
is no need for magic cmpxchg loops either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Moyer <jmoyer@redhat.com>
---
 fs/aio.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index c32c315f05b5..2d40cf5dd4ec 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -156,19 +156,6 @@ struct kioctx {
 	unsigned		id;
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
@@ -565,24 +552,18 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 }
 EXPORT_SYMBOL(kiocb_set_cancel_fn);
 
+/*
+ * Only cancel if there ws a ki_cancel function to start with, and we
+ * are the one how managed to clear it (to protect against simulatinious
+ * cancel calls).
+ */
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
+	kiocb_cancel_fn *cancel = kiocb->ki_cancel;
 
+	if (!cancel)
+		return -EINVAL;
+	kiocb->ki_cancel = NULL;
 	return cancel(&kiocb->rw);
 }
 
-- 
2.14.2

