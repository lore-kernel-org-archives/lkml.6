Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1661265-1522222393-2-10744640789361127601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522222392; b=BJqHZOuH90aSCakL2yha7T46S/wCRhCt87E41YoMkuuVmKJ
    t8MX5/9pCg/tSwbPOMd4Oj667d14yhNSsKstpMAynrx3teWn5g0OKzibEfv41AFh
    uMdJm1/1g4Bj+O1O+2WOQJ/uOfJfr/wOTKidrQvqmYoXtI70rfza4S299V2QF/ke
    S/YX2atfVYNFyyBy4Pk88gJMg8gFlZp+x7vY8HWpWO8QVpfcKopSjc0agTmxI5Oe
    PaB5rBeBStz44Hz5bf9yEUKuGu9WVrGRTAHLAb/MYVAGSHjDTMK1itahUdtOzwEF
    wGXwXEhHaLeycLhrjUeg9xEzzfZ2D6WX3scPqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222392;
    bh=8s3l2WEdAfY3Zli7acWKC0c1lZwgW0FRQMiQDnOq7Qw=; b=Xt55jep5lcPr
    +GQwVaiT7wObucPeQa9LX5Obreb8CVAPPkpdADm2ljaJjETBvyx+5Ol1OuoEM07q
    SyCFdeX/D95rbXJTE9KOtIQp7iuWEP8sm22qMDD7KLXIiISEoPdwDGm6d+nTzWv9
    7YAoSnosexTIXbeDukQvhmCWlCil0k9SUSUxbE/aNsYJrlDB8FTNA3NvbkTF7hMc
    cTVYCYBYpIu5sdVc2VHrNJpTeCL9QbGKXm95wkSAglgMbiyd9fwYuu17Yf2p9jD9
    8dRMXtBpe99pSmAgIHiq+z24F/0r9B0z3nUU1q8cP3w3Rb7iXln84H0YZEAygz/y
    D6BKgBqmlw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=RtDPTkPk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=RtDPTkPk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNr4H4cgxgW5yNNq5xbCqeIllf/nRrH3ePQVvWccj+rwRRqfjGuP4cpHuUBs6N8X9u/MGxfS1BjYpmLECL+YVk6iNp+Yc42MP1u658yMHGsFKx2ZwhfZ
    fsomSs/c0FnW6i+jEqfP2KPbVr2NYyAOMPDG6ZFuofxH++UFlDvl5NK7Jr+5mpvf9V2eHz+zZh5WS4eMj/BXMQTA09RSDonjDgAJIvxfutoHpvy436cKuOsb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=F55Z69aUwsZ0p8WbI6QA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeC1HbA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:31:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbeC1Ha6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:58 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] net/rxrpc: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:21 +0200
Message-Id: <20180328072926.17131-26-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/rxrpc/af_rxrpc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 0c9c18aa7c77..d2440d5c3ce8 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -729,15 +729,11 @@ static int rxrpc_getsockopt(struct socket *sock, int level, int optname,
 /*
  * permit an RxRPC socket to be polled
  */
-static __poll_t rxrpc_poll(struct file *file, struct socket *sock,
-			       poll_table *wait)
+static __poll_t rxrpc_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct rxrpc_sock *rx = rxrpc_sk(sk);
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	/* the socket is readable if there are any messages waiting on the Rx
 	 * queue */
@@ -940,7 +936,7 @@ static const struct proto_ops rxrpc_rpc_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= sock_no_getname,
-	.poll		= rxrpc_poll,
+	.poll_mask	= rxrpc_poll_mask,
 	.ioctl		= sock_no_ioctl,
 	.listen		= rxrpc_listen,
 	.shutdown	= rxrpc_shutdown,
-- 
2.14.2

