Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522355874-2-6684895726130108958
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522355874; b=ZK/NujyUAuP9zPKgUKkXY2J1SGz8/odhkt9WUHZrMWtg1tgk6h
    juGYycwnlcUyZhIS9aHplsIdjPiMuN/VA5J64Vro5F4/MFxzp4fEg+nmc6kjOJPZ
    WnxEvz0Ph23/dBlQGihGwil0QMoOOkCpNZ0juHd0i73LxHJNk+3un3Emef6cdOMq
    GzjFA5YBAEmkymSkKDoiFVg7zUvazn6/6i1mrSeBdyuCdxJpgqRPKTNVM7VcYzrO
    i5XaRL0Ccegm0Fafd/4J/jgQNmXSNHRhVWvx85JrXh+1VEY1+CRmH7kBADZ9Mxjm
    AKxZLPt4QsiTffWFLOAnvnFrpGyhCHKHGvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522355874; bh=
    Pk3+G53masUqCvGg+9ZJVQANHedsSP2rQmUlAw9sCrA=; b=cdP3Ib6N/+W0hptr
    U7wgqFU5QC7hUnp8Tg5MXJisFSUmpZ992EH7tkA50QmArN0EeItiwclRFwjPIxmm
    aL9LsbWABtrFMaHHTZYeYySTDhLFP6UFNejziZeofvY/ygO5s0aebHgeB4toI61A
    YxaFSqduEpOYUYeUoaAhJuJT0A7rPHLrkl9m2KrikWbKXeOwLZhj3Q3tjcT4oHOb
    wk/xVvKC5qswn6RCQSCRllBplW/1qXNXTJgLywT2hmNMdV3wc9UKxFb4U1xQEQAD
    sx/nzhkWF0GVhW2KmC/3aEKLKV/ZzYbSs5W9wOklbLIar3snj1aCVvgfYQgRiP+G
    +Lkbxg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ouq+BhZq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ouq+BhZq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOqxXNxwj214Gxu8SlBv+Pv+vX86oa8Rv8enBNSzamofNwocWyAkNGa1UGAB2ldv5e0hfM0xT09KUlRj/rytiSPWWxOc/H+ioe8KH9Er9gxIxH3yn1bC
    BledCREY+4cjqF7eXOUdiCDpxoyCygJOCVD2Zrp1Ap4pmwXJP4qJ5OotIF9R2tiXX1rSXe+3HP3WgJOyZut+W92M2Y6yVi1D1jNR4nzmlRDjautamoQdAHAI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=GvLFIiL7OleGfqNn4fMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeC2Ue7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:34:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeC2Ue5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:34:57 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] net/phonet: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:21 +0200
Message-Id: <20180329203328.3248-24-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/phonet/socket.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 28d981512f5f..70ac4539d5b7 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -341,15 +341,12 @@ static int pn_socket_getname(struct socket *sock, struct sockaddr *addr,
 	return 0;
 }
 
-static __poll_t pn_socket_poll(struct file *file, struct socket *sock,
-					poll_table *wait)
+static __poll_t pn_socket_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct pep_sock *pn = pep_sk(sk);
 	__poll_t mask = 0;
 
-	poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == TCP_CLOSE)
 		return EPOLLERR;
 	if (!skb_queue_empty(&sk->sk_receive_queue))
@@ -474,7 +471,7 @@ const struct proto_ops phonet_stream_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= pn_socket_accept,
 	.getname	= pn_socket_getname,
-	.poll		= pn_socket_poll,
+	.poll_mask	= pn_socket_poll_mask,
 	.ioctl		= pn_socket_ioctl,
 	.listen		= pn_socket_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.14.2

