Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3488533-1521618678-2-13249355107328257378
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
    t=1521618678; b=tGDFbTWqIjhQ8lCzyyyzk2kT4r71LR0LUtsc+uEnuFr5c/J
    aPEHx/UmdupNeggIh5ILEcT0sgKUWNocgtT892PGiHswtG9+i0aYn2S0v8ES1UcI
    qG71dNREfHFIc79aQm91JgNwXWLRDbak/LvV1+UiTSTlFrG77ie+EpOGr9n0Q9UI
    RM5/slNLqozYd7j+8rdj7zHO9z89Eo0yFdDY10P94ykwfFLGkUQV8jMa0PN8c/F+
    sAtrIFYHVq1nYvKbAYQUzZB1oJCiKjNMuCAUFFjC5X8ZvUwrE0MP6PpfF4xTry3d
    msYa34KljsZdcypuZ7kAIf5oktE0Y+u0JmYuzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618678;
    bh=nSm9LEebG2adM3KCzQOLaXIF1ofUdHW7hRMurlv3b9Q=; b=I5y8EQDQ+40d
    FYiLGdXHRL1nQQw40sLHJ9fxFDtD0Qtqj9GNioQ3PBzVQ/dZ8tk5EPFgvi38Uc8K
    JjTwubn9tnqGRcv51bojJX+9J4uRhu9kscInEW7RuVPkHVcTWFoHQnl2Tn0aTA6k
    93rV/eodO4Q6uPZeYec3xazTKCty5nH/v9cEgNatBxx2CjSK3klpgumuISIesRLp
    IWZOprRkhQS0o0LlzTjZIZBUejGIIqsZoLXELPuuyKvXAu2Z0Evc224IRhY/pnAM
    T9CHGMTZC+FUo5LA4TTHMFlapEpdLP+f9C/NpjR2NWiYHWAn28/QhE1XKRnt/SAS
    +4r+I5Urjg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=XsBQ5pA2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=XsBQ5pA2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeCUHku (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:40:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeCUHkp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:40:45 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/28] fs: cleanup do_pollfd
Date: Wed, 21 Mar 2018 08:40:06 +0100
Message-Id: <20180321074032.14211-3-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use straigline code with failure handling gotos instead of a lot
of nested conditionals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/select.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 686de7b3a1db..c6c504a814f9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -806,34 +806,32 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 				     bool *can_busy_poll,
 				     __poll_t busy_flag)
 {
-	__poll_t mask;
-	int fd;
-
-	mask = 0;
-	fd = pollfd->fd;
-	if (fd >= 0) {
-		struct fd f = fdget(fd);
-		mask = EPOLLNVAL;
-		if (f.file) {
-			/* userland u16 ->events contains POLL... bitmap */
-			__poll_t filter = demangle_poll(pollfd->events) |
-						EPOLLERR | EPOLLHUP;
-			mask = DEFAULT_POLLMASK;
-			if (f.file->f_op->poll) {
-				pwait->_key = filter;
-				pwait->_key |= busy_flag;
-				mask = f.file->f_op->poll(f.file, pwait);
-				if (mask & busy_flag)
-					*can_busy_poll = true;
-			}
-			/* Mask out unneeded events. */
-			mask &= filter;
-			fdput(f);
-		}
+	int fd = pollfd->fd;
+	__poll_t mask = 0, filter;
+	struct fd f;
+
+	if (fd < 0)
+		goto out;
+	mask = EPOLLNVAL;
+	f = fdget(fd);
+	if (!f.file)
+		goto out;
+
+	/* userland u16 ->events contains POLL... bitmap */
+	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
+	mask = DEFAULT_POLLMASK;
+	if (f.file->f_op->poll) {
+		pwait->_key = filter | busy_flag;
+		mask = f.file->f_op->poll(f.file, pwait);
+		if (mask & busy_flag)
+			*can_busy_poll = true;
 	}
+	mask &= filter;		/* Mask out unneeded events. */
+	fdput(f);
+
+out:
 	/* ... and so does ->revents */
 	pollfd->revents = mangle_poll(mask);
-
 	return mask;
 }
 
-- 
2.14.2

