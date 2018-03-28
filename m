Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763006-1522222636-2-17100607621441382292
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
    t=1522222636; b=tffUTr32npKeX7Wh1mFWX/NxplGe6jzilowlkSi9P1KfwyK
    jIqGLX5gbCjNT37D1ssR9FynG+ziFghgQW1SdJ5ISYooWy3oObAmza6oeRKkXm6z
    8nZINW0p4AzCVB+ffE3Y6MWk7WLZeXTfkUfVDvdQSPGcBl/tramnylj8R9Rc2Lpf
    24NqupeM5YIJT9uBsEq7j68m/J0Asty20lRaWELkkALHN2iM7OQlfLuwf0C+v79H
    j8xMUJOxehNxXPBkoJSBweZUPPVyXMu3QxLICm6RL/NdPddyrzEYpVOFHJOlYPn2
    p0K81xki4nmiTznbXiegqT9lklggnWcBzh55L6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222636;
    bh=XkVijAcT9KLTgZpk+g99zLyRrFz8FiwTMHnQPVpf5Wk=; b=iVy5n0HbZ3XH
    PLzAuQX2LYrZMbVwyy0K+Oko1JV06g5knuDVKrX8rLMhNPYfi5ptN9fQDpIN5rRL
    gdXHa/g2lw3FNcbNG1omKlLlVvphKKUizfVxJr9DKebXBD8xGkRWzqR/XARdKMg/
    9uLN6HMJ246NTEg7DG9vOKnHDsYLrAAq6oYHhB4K4rl7lKVVADkble4CTb3j5RiF
    R/p6Vw2+j5viYEPkyEENA51pOfrbVmLRLZawto81/fPOThKpulJh+nqgc4lRldrO
    hx5KEmkQhW4Z1+SSr5zjXG1dImqXEp8PcQ1tqqgr0i7xZ5GTUj9aw0DSdYdEdghi
    b6LnkcUNZQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sLANEcJr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=sLANEcJr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKEBOgEutUGl9+cj/QtpTi0wT1Z/X+mxc8mkfgRZjNV56viTtZNA2Sp7Vku7oUYHuME+1nBpoxSYUN24jBDYgHJ8fsCLGYP1zUx2xg/RVNjPeCJzyQx1
    Hq0aGOECOI/1nyz9SmcJIIVhejwPtxmflFEybPOwxeA0y9GqvM610jg9dVlCZCNaS6oLEoKFfddQ7qCbAc2CA1ief0uoGmSE/dGQLo9rAWggdpqopVgh/B+c
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=qBVkKzBwSuRwKVmLvv4A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeC1Ha3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:30:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeC1HaZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:25 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] net/dccp: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:11 +0200
Message-Id: <20180328072926.17131-16-hch@lst.de>
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

