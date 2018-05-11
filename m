Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037542-2-8492224610989239863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037542; b=jrS5xkpfhDwhKzSeg3jIPDUwMfie6zSpb1s5SRg2qNvIIu8Qmm
    ZSgWYIZS/Mfy89i1v4EgbAwuxAYbINAWH4/wfoNz/46pmKAHLAGpsBIN76/wGlGM
    DqjHH+pZm1c9S1wn79roo5wk5wdU7MELqsGFAiKquFZE6ntHQijqF5+I0LGiY1cH
    M4lDwgy71kip4G56FzRaaUkOF/FdQrdby4Ux7aucyWG1Czsi4NuBtRIT6nd86U9E
    E/INoHh4A66BFv8YlblpR6ipVYakkAdwMO45lbfrZZ79tx2/Lu4Dd+inL2G11MTu
    c0SGjoTAIexXpa7imEjFDEW3lnXYUY9cxvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037542; bh=
    jfnZN+BseuqQMorTOJe9KAqS775foKuvXGKRv8NtOcI=; b=GzjKQUuYSfw24o/3
    Who/hlvvYOf+iVlkPIMvDyEDyCyGipSROOf5NaXsv2419/tcZdJjKY5ejinm/YeS
    S4BMmhV7flziwxz+Jtp8jyEgjjLDEBC8OnEmrrpr3j//RBqfosLz2fGMSfzEszl4
    d4cFqp4sV9XtDWtp3RHTFAk83YtCsZR03ofyF2hbBLEpREwSBwZLPxnGjVuxiN2u
    dpTvHu55sHQqrrMPXe8E25OA1IBL2vMSyIChAJEJGKmNPYQwXWaKYfBuo5aeNc3N
    fPhxWbG0JtVCNMa3VRX+5cQZrxmwG0+NMxOB7K4ukMEu7/LgJospnwYZiThA4ELO
    OekgDA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=KmkU96pu
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=KmkU96pu
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
X-CM-Envelope: MS4wfIY96henKr9GxBAp6rNEFArCIHUeQVfJMQaurT6cx3jwcc6yVws6ypVFrDufu6a8ZbsXg8jCtXUKfrZMnuArRW94O1ZIU/hlX7T5SGXFKR0qqMJ3GQ4n
    XH4d03BcpQligIYPlVgWOgKi9hD3Vm3bVAFacxy5TIQ0JO69WcTxs1yLADxKoCjW1IPhQzAT4mCnYw1peF3JKqZW4jqlEDkNhehsDWbUGrMaPcYh4ZfvIBtE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=0xgVzqWtobIYM8LKUaMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeEKLSc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:18:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeEKLI4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:08:56 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/32] net/unix: convert to ->poll_mask
Date: Fri, 11 May 2018 13:07:46 +0200
Message-Id: <20180511110803.10910-16-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511110803.10910-1-hch@lst.de>
References: <20180511110803.10910-1-hch@lst.de>
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
index 68bb70a62afe..1a9cdad4ab82 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -638,9 +638,8 @@ static int unix_stream_connect(struct socket *, struct sockaddr *,
 static int unix_socketpair(struct socket *, struct socket *);
 static int unix_accept(struct socket *, struct socket *, int, bool);
 static int unix_getname(struct socket *, struct sockaddr *, int);
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
@@ -2630,13 +2629,10 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
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
@@ -2665,15 +2661,11 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
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
@@ -2699,7 +2691,7 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 	}
 
 	/* No write status requested, avoid expensive OUT tests. */
-	if (!(poll_requested_events(wait) & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
+	if (!(events & (EPOLLWRBAND|EPOLLWRNORM|EPOLLOUT)))
 		return mask;
 
 	writable = unix_writable(sk);
-- 
2.17.0

