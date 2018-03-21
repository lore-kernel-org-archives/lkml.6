Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521618309-2-7807099297833509992
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
    t=1521618309; b=RI8zkYpvNs8JLGl4g4OQUdIFfKZm5HqqLFXAJWqeUNsZln8
    UDDJC2ddj8fQb7+wEZF4B/hjG12Sdo1kSuN+xCTboaXbz0rVNCJ0ijFChC8QI3wZ
    j1YSuHRc4Gw1OL+2eTZYXsJu9y4UVH/kdbwajZg6yw+XvmBJ4ILV/cOCDeYYRE9/
    nQgqx5PazQWfvv6OElDwOrWZL+M9BkhDY8dpHWDmepBLm24W2FkBc5aJVDzTAG6H
    VNoHwGAqIzLRzkEDdobZSa1hxO23N2huZLaR4dZ7iF4rz0kngenrVrIHjTdVo6aK
    su+ejaEyj9Pg0fHT2VeWvMsrjCLMyMvTHLqVQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618309;
    bh=Pk3+G53masUqCvGg+9ZJVQANHedsSP2rQmUlAw9sCrA=; b=cX0vWsLagpmv
    OygTEgWPF66kFwXvGY5zaI7jFcVL5P70V4EH+H7j76q1oOw9ihCVMHef//i7kLGI
    9qT+ysgweUr/EZoBtscSC24V5tWV8PyjpdrtOKAp2tMXfV/Rh0ibQhGFFqQ7R2zv
    hIQm5xiGOY0bJQ4C+4PlLc4a+DRLZwaEPd+4ME8TpJ4FGNEAoHx96GboY5rdweqh
    Y39yq0LQE3AAbLE0/n1BxnlR3wm6DtNdKzMQxCtJy1Y7+QQOliRINlyvRl8jqciP
    HKeD6DzE6S8y3CV1ouVKqkjfKY64BsuuEv8VfG6khj3GhBkFsSZTN6pW/d6GtIvc
    Tdp3ydejOg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YI0yIE+K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=YI0yIE+K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeCUHot (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:44:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeCUHmA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:42:00 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/28] net/phonet: convert to ->poll_mask
Date: Wed, 21 Mar 2018 08:40:25 +0100
Message-Id: <20180321074032.14211-22-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180321074032.14211-1-hch@lst.de>
References: <20180321074032.14211-1-hch@lst.de>
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

