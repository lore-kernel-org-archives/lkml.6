Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1668128-1522355673-2-15268144248593069970
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
    1522355673; b=ipBpKWVoFvouhpUN2JMqpOOBv2K+IwQwCBzB5ga2xgl/AWqBnl
    k/F4bjp9K6dbWmmILb0V4qwQLBpvU+kKJWORRDd/58x0Meg8NMzuZsOdRwD8ZNXZ
    g6W70p8cimluVB6kIEtAxoR9UCzeBDMsUuHSk6ZFxJE8yYS7dgINgwaGU8v3BJbb
    o3MHQsZjdWBaRDdUhA3r0tQf2fN1gQRFdxLHBNmW/Pf9WMcT3mAOZmDEO/Wg3mFr
    tPNmcUZ7Y1weROlS4VvBweEI5SIlZsRHa3FSEWA80VYFdtodx7rS5WIP88UY6U5a
    WdOb0XehiAdawZ3nl2MmK8hWLyfruXyaz15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522355673; bh=
    XkVijAcT9KLTgZpk+g99zLyRrFz8FiwTMHnQPVpf5Wk=; b=FsiNGmAOugAQn+tM
    0+01DpCo45Eu5eytaphbX/LGKiYG99eMtU4qTPhiEgIPD3tvqXV5FR6JBDVzt1BQ
    Vcu6eHIKesWI12RVflklPKslOSM+a6pf7LyZdxoNKyDqbNmo4YnuhISkfP0kg4sS
    G6Fn6iPm3O2Gc3XFlqab6uyiEB4u+bXkbbQyoNp5ul7w+PpBa1qjfC9MJOENgQKA
    vByrwnC83mQcBOPSjYSViKLmv/90ZtDhFMaSgrOPoOrzXU1o6cs4Art9Hi+ZdDw6
    HsKN6MEwoxFVrPd4wuQEW3O07eoQyD6W1sPnyUzwWPAT0Os7NGsegbrIXp8WQNIv
    vL/VHw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=bsBQPtBD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=bsBQPtBD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF4lGAYcCcDSgCclNgTuckJfL0ROTkom043UxCe6SSxmY1UeYgtR9dwZH7ltBiFlReSg0PhNZxrgcSSxflLBk0MSW+2wDF1FqFXC8Qc2HRLnHYKBbyAF
    +GpA8TQlIvVI2bcIDvFM9oalEG6iJReJX9A03EcNUmlRwPb7S7/kxkVe7osU+KIAUDbK+8hYsUVinKHnz08+SAHfF1uNYM+vTccj0atCgx8DuRP73EPnUQlg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=qBVkKzBwSuRwKVmLvv4A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeC2Uea (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:34:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeC2Ue2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:34:28 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] net/dccp: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:13 +0200
Message-Id: <20180329203328.3248-16-hch@lst.de>
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
 net/dccp/dccp.h  |  3 +--
 net/dccp/ipv4.c  |  2 +-
 net/dccp/ipv6.c  |  2 +-
 net/dccp/proto.c | 13 ++-----------
 4 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/net/dccp/dccp.h b/net/dccp/dccp.h
index f91e3816806b..0ea2ee56ac1b 100644
--- a/net/dccp/dccp.h
+++ b/net/dccp/dccp.h
@@ -316,8 +316,7 @@ int dccp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 		 int flags, int *addr_len);
 void dccp_shutdown(struct sock *sk, int how);
 int inet_dccp_listen(struct socket *sock, int backlog);
-__poll_t dccp_poll(struct file *file, struct socket *sock,
-		       poll_table *wait);
+__poll_t dccp_poll_mask(struct socket *sock, __poll_t events);
 int dccp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 void dccp_req_err(struct sock *sk, u64 seq);
 
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index e65fcb45c3f6..e8476f319efd 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -983,7 +983,7 @@ static const struct proto_ops inet_dccp_ops = {
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,
 	/* FIXME: work on tcp_poll to rename it to inet_csk_poll */
-	.poll		   = dccp_poll,
+	.poll_mask	   = dccp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	/* FIXME: work on inet_listen to rename it to sock_common_listen */
 	.listen		   = inet_dccp_listen,
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 5df7857fc0f3..f0aac8e4b888 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -1069,7 +1069,7 @@ static const struct proto_ops inet6_dccp_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet6_getname,
-	.poll		   = dccp_poll,
+	.poll_mask	   = dccp_poll_mask,
 	.ioctl		   = inet6_ioctl,
 	.listen		   = inet_dccp_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 15bdc002d90c..26816032a7c2 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -314,20 +314,11 @@ int dccp_disconnect(struct sock *sk, int flags)
 
 EXPORT_SYMBOL_GPL(dccp_disconnect);
 
-/*
- *	Wait for a DCCP event.
- *
- *	Note that we don't need to lock the socket, as the upper poll layers
- *	take care of normal races (between the test and the event) and we don't
- *	go look at any of the socket buffers directly.
- */
-__poll_t dccp_poll(struct file *file, struct socket *sock,
-		       poll_table *wait)
+__poll_t dccp_poll_mask(struct socket *sock, __poll_t events)
 {
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
 	if (sk->sk_state == DCCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
@@ -369,7 +360,7 @@ __poll_t dccp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-EXPORT_SYMBOL_GPL(dccp_poll);
+EXPORT_SYMBOL_GPL(dccp_poll_mask);
 
 int dccp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
-- 
2.14.2

