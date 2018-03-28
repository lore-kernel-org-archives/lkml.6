Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1769925-1522222999-2-14898382522833038139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522222998; b=Z3TXr3HdY4gw+7w4HEVWIK+vDaA7bLloj4NDbzde6dq2uRq
    kaKt/Jjq0pzTiZqjUNAYMj9P/HOm6MPtp19LqSIteAzofYDXg9J8nbTfmkJ7YcqK
    0eIuXV5ZI8jRay/s5wc0Aj8Xd03wYMubl8mG4P1NWLaYzKTnaaU6Rg1y/3UEcla3
    nXINpg+VG6S/kae5mledDnxIvYOBqlSHTaOCEnMi/KC5D/voookmV5aNdSKpBgLm
    If8UAMgXubsWguk9GESIHrNApU4yDLOSR1Uk0rh0HfrNk9WKZIyl7zNNB3NieWyh
    7Bqvj2KvpA5RcXrRHsyAMheBipfGW5HK2vjeaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222998;
    bh=p1HJOkyOeQwlzEn3hlJu/MyaKWYPAu8UPncul/PW6Zw=; b=M6FQKoRBfkgp
    8P0x+5yMn6GSmijDqWp5Tuenk8UWhANmaARdmVADkqBclTz8+XgQ4FYd4vWrt3Hw
    KU9Q0SePltMThiA8ZQuStKXsFYdZ7Koa6EUp4RbUlFoGeIeOh+sFr4dojN4tXSHh
    /9ek7eHh7ABOUTQWZurVGZAdrDxAqLr6vTc0xb/YWCU6wiZutydyxFqNph8HVEpq
    323hD+EEV3iTa7w2pNIKXEPB3OKu5aD3q8DEZaeEbXEChrFulW2w5lRquKdPLprE
    VSm6wAjnLckJ8YiaH5qzyrYCC3sNCQ7e5N2lMCKZDhRrIMTCb/KQqz8oMhRoFG4Y
    YBLOEA9UMQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=UggmuAZT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=UggmuAZT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAZOoqssJJeF4dXpWa2n+BXAvc76b5h3oqH/SBCmytlgAjTWm3Kqy3bddzbGEL8Z0kO26VbHR+/xX3FpwAjP/aKeHFzJmHzsYYxhZuLY/R9PF2nUTEyb
    eBN7N75mhRP3HuCrpZYOaTC7oBHg30BAL3a1ijZqxXRBwOPKADCFrW+eRp3QMT+1HutW0blT3TBTXP/M39hXEzF4YBGjpQQHanWxzW4LCB7CO0gu9eHLNz8t
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=sdapQSm_P28a7qtZbq0A:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeC1H3o (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:29:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeC1H3k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:29:40 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/30] fs: cleanup do_pollfd
Date: Wed, 28 Mar 2018 09:28:58 +0200
Message-Id: <20180328072926.17131-3-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use straightline code with failure handling gotos instead of a lot
of nested conditionals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

