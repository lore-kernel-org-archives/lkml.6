Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521617666-2-12686172103510871544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521617666; b=lluEQwrCRp9wKHxwC3vfCfpITKc9yn/56qcAY5emZZ7qicz
    5Kq1o0dMS2KE9vmXn4HiSwQP9NABvOfNALpMqLwnPqVsbHCmpWcrnWZTZV7Ae1uq
    v8x6Ckre9TRP4uN5K5DzskhMorkupZV4hYgRtxCpNzqwi/2ZWEnXTw+V/0KtDhC2
    nNYPBBZcbV9HvtzYXKSJci/rrdHK+VSJ9gh3tDa7ydI7fOKOCkk6YPjSySjTbKXJ
    JyqDNYiw3pAJYmPIF7xtHV7lnXLWc4aqgjazdyQUIDKZGX+IS1jAApjM/Ug5R0LV
    i9LseIRoE0ATkhxTz8mJL1+hagCmRDRrs0mvrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521617666;
    bh=8tobXlXxyQZbJkdjl3yVb2Bh3VaOvmlK+hRnKh1paw0=; b=B2SNg7x7HLgV
    YOK0APjMTaroSnFySaABT2fCslJv9NBPMNcMrazGtpJf78XiWqgPk0IfRU1oKHLN
    8qp64daFeyGLl6VSXa0WItJMZ2xa8qf6MxHfNNAhcGUT7grPWVQkeboTMwuTi4Z8
    GEmO/UezHEWAKdu+9GKifbjU41L7OHZW4GvpytlKEdOCcdltWPvG0fwOI+KBiIlo
    f1g/+EDwK+geG6HADIiw9oSgk/QmKQLmRGT6LS//D29nVaROfT6yzZ3Pp2j8H725
    c7EmW+G1Q1EyGyMCeVJ77LxXWur/2VRJL9CIRzn98Q/PMAVR4MP2R1RLnU7gKSTr
    Muh3vUNdoQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=mAQV8jcl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=mAQV8jcl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbeCUHeK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:34:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbeCUHc4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:32:56 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] aio: simplify cancellation
Date: Wed, 21 Mar 2018 08:32:28 +0100
Message-Id: <20180321073232.13366-6-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321073232.13366-1-hch@lst.de>
References: <20180321073232.13366-1-hch@lst.de>
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

