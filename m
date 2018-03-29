Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522355665-2-4632492179906036824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522355664; b=UMQqKq0qtoeq5PTqyJXLsPdlyUmEHSvrILXXmTvHzd4fGGETIG
    YDcyYL8ywB2uLCnyxiNeeCdFQvVLkfeqVI89Hivr6vXNkNuWaAf0rd1mt8SSNuW4
    yLM1KVMpEkbb42Tg9i6Rj+zhhgaasnku61fggmDFNzzSO3n7da2iwhlHzSlvsNXE
    Z8eT34ITgoCz5kDnTPynd0XJOIKl2PrFc+CeDOjxRPrDP4Cgu1O6mvbNZSnAd12s
    +oUaX2ZZryRQ9CXcxthzHJMy2w1b7dyfpHWSw4h+weIG24dW/7POghLBDhDyHCB3
    a5XBHgkzSXQVJsciFDY6s68rRrAOl0Unf51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522355664; bh=
    ECZVXycrzuZfx9mX2KOU5/i/bofgvKPmcHTRcZqx6ps=; b=evteKmOeV1srn10H
    yG4PIV+g4R2pfzbYj9YvN8HxWVxCyCqfuHSaSEYYyg8baFumrH97pynExXw+12Po
    aonajCRPGEta9HxlB5EYeT3cLzcMtTHBeH3tbAVEG1w7Adwdsnf4hEBWgRkkJR2N
    i1TTbkwkRqRNGxnmt8bWf/BqGcY13tabakthpBkalGm8eEsIIh/UIedAutcOQKvV
    cqIs0n6sywUiVKmaD6NrUG1rYWgsWEk7872ukd4eTuoU3+rF6BJtNJCcJJld3Yyb
    jAOLXPYCmvXC8itP6vUa/+PqLAwcBkzihawcBkRtUcgoWK4JHuGb500M8vYtQ5OI
    f2pwiw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=nD3ocZRY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=nD3ocZRY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdnWRG4ISzIqx1koOPQOJrwQYEhfJDP9QM7J+36jIQvaiw43W8MxlbxVdMqoWjipKrmO78ZpJ8wEeH9eIqlgy8Cq9VTsAFWOzqwL7Wk/mp0qSeeO6e7
    9LW4qitvCO9O/lOxEPB8BjLymcbJBJS5j+CNLZ1LnV4uurPUCrI2RDyQap4/AZExtL5rY/2GcozY5kY4+RQvd02g4QshQlCpvrKgr2FL3W5kXpeUaWDIZXko
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=zC15u5H8aKBIYaXgerkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeC2UeW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:34:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeC2UeU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:34:20 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/30] net/unix: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:11 +0200
Message-Id: <20180329203328.3248-14-hch@lst.de>
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
 net/unix/af_unix.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2d465bdeccbc..619c6921dd46 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -638,9 +638,8 @@ static int unix_stream_connect(struct socket *, struct sockaddr *,
 static int unix_socketpair(struct socket *, struct socket *);
 static int unix_accept(struct socket *, struct socket *, int, bool);
 static int unix_getname(struct socket *, struct sockaddr *, int *, int);
-static __poll_t unix_poll(struct file *, struct socket *, poll_table *);
-static __poll_t unix_dgram_poll(struct file *, struct socket *,
-				    poll_table *);
+static __poll_t unix_poll_mask(struct socket *, __poll_t);
+static __poll_t unix_dgram_poll_mask(struct socket *, __poll_t);
 static int unix_ioctl(struct socket *, unsigned int, unsigned long);
 static int unix_shutdown(struct socket *, int);
 static int unix_stream_sendmsg(struct socket *, struct msghdr *, size_t);
@@ -681,7 +680,7 @@ static const struct proto_ops unix_stream_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
-	.poll =		unix_poll,
+	.poll_mask =	unix_poll_mask,
 	.ioctl =	unix_ioctl,
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
@@ -704,7 +703,7 @@ static const struct proto_ops unix_dgram_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	unix_getname,
-	.poll =		unix_dgram_poll,
+	.poll_mask =	unix_dgram_poll_mask,
 	.ioctl =	unix_ioctl,
 	.listen =	sock_no_listen,
 	.shutdown =	unix_shutdown,
@@ -726,7 +725,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 	.socketpair =	unix_socketpair,
 	.accept =	unix_accept,
 	.getname =	unix_getname,
-	.poll =		unix_dgram_poll,
+	.poll_mask =	unix_dgram_poll_mask,
 	.ioctl =	unix_ioctl,
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
@@ -2640,13 +2639,10 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wait)
+static __poll_t unix_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	/* exceptional events? */
 	if (sk->sk_err)
@@ -2675,15 +2671,11 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 	return mask;
 }
 
-static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
-				    poll_table *wait)
+static __poll_t unix_dgram_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk, *other;
-	unsigned int writable;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	int writable;
+	__poll_t mask = 0;
 
 	/* exceptional events? */
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
@@ -2709,7 +2701,7 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 	}
 
 	/* No write status requested, avoid expensive OUT tests. */
-	if (!(poll_requested_events(wait) & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
+	if (!(events & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
 		return mask;
 
 	writable = unix_writable(sk);
-- 
2.14.2

