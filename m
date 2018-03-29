Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1668128-1522356038-2-7905756183155159021
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
    1522356037; b=keXWnuyXyZfA3J7hcGMtw7GoTFJsLRGtxwxw1l3oqBSxRXl3ZI
    f/p+FIl1HEgzqbxR2RQxsiRqpBL9IRCnyPG88iDjE2yG7BNYPK0GEdSked2ziTNi
    mplCQ4WLltJq+Ol552MzactTR/TVVXVMk/6onxNWKmcOsj0wwRIetmYcbcDW1CHa
    t4TqsiCLyNVmHFRZh25tGJd1QZmJgZD7kkehbE0Ab/xR/m2BiHK1i0QM0vxppZHU
    cssHArspJ2hQEf4QDNQKeEYE+19YvUbwVGsd1EdaWQoBzghLWjnF4N6/O7HKUfOg
    cYTvqo/6yympxPTD7JSJWL8ciVEemtGNne2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522356037; bh=
    tXXWwUgvt8m/hsW+Ddpc/N8+m5uaSHiLI5/Z0xFHTBs=; b=aKNKKbWD0H2RYBN8
    kyJtPVdYdtWLI/rVuqiq5lkM8d0rz/+Yshn+Q1sbcYGbzhB26z6+FukVK9YCb+6M
    eSwRZY/IYhxc7me0JBbc+2iCp65sEiFxc832PYyz/SJNtTi1SIGpJ9UnOCUJ+xX1
    os1YSDiZScQ3+NUyBP+/b9B1jGStt5ghegZFxIGgFTZd8OFhMdVRJxCBub8KzEKn
    YbWXi8uEF99bpLoonl3MdlrrneXoUVGgG4Z4uMlA1VF7RX3491+XZ69H1dbPZ5tF
    end5oFoq18Izbn1/p4fh/JyYzJn2jbBhCWnqTPOikIZWLv3qatiAylQfiLPWy1+2
    3qf84Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=W3EPrDbs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=W3EPrDbs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD0lDtcAgvb/XnyW5x1KwskQtU6kw/qOPyeJsBsT5MRHbZ3gTeMmkwQVxO6PhSgrMzmflC3boQhAv6Og/W5Q0eux8FtMC5OXxE2EJ6Sl+Y68Yy60DxFq
    h7+6qzQnwPE5wHezuxG6Y6LtPH/NZ4lUQwLh3qBgws3VgrZFSqj/Vw31+77x6Nq7+4CO2Mc+Me6WFj/qu+KPDWtQszoMKNtApMDYGYmbSMcFhwrVly/UrJmh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=ad68_8OTSUJq81Ci_wQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeC2UkQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:40:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbeC2Uej (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:34:39 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/30] net/tipc: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:16 +0200
Message-Id: <20180329203328.3248-19-hch@lst.de>
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
 net/tipc/socket.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 7dfa9fc99ec3..e9c6f185db74 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -695,10 +695,9 @@ static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
 }
 
 /**
- * tipc_poll - read and possibly block on pollmask
+ * tipc_poll - read pollmask
  * @file: file structure associated with the socket
  * @sock: socket for which to calculate the poll bits
- * @wait: ???
  *
  * Returns pollmask value
  *
@@ -712,15 +711,12 @@ static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
  * imply that the operation will succeed, merely that it should be performed
  * and will not block.
  */
-static __poll_t tipc_poll(struct file *file, struct socket *sock,
-			      poll_table *wait)
+static __poll_t tipc_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct tipc_sock *tsk = tipc_sk(sk);
 	__poll_t revents = 0;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		revents |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
 	if (sk->sk_shutdown == SHUTDOWN_MASK)
@@ -3020,7 +3016,7 @@ static const struct proto_ops msg_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= sock_no_listen,
 	.shutdown	= tipc_shutdown,
@@ -3041,7 +3037,7 @@ static const struct proto_ops packet_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= tipc_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
@@ -3062,7 +3058,7 @@ static const struct proto_ops stream_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= tipc_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
-- 
2.14.2

