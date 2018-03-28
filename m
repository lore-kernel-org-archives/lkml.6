Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1769925-1522222716-3-15972840548903364571
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
    t=1522222715; b=tHzVknu4koIsWEqt4EKS1nv1X44G80ri1DFw7JIj6zhnCSI
    LcYmDT8um5WvmD/tgpfldBsxNoPppsZYPp593PnoxXm/MGkVI44SBmmAXYU31LjZ
    osv65YUxExxri7+9dmT6Zg7RehkOlHHzB+CkSzcU+x1S+Nsc3QQke4gT0b4sI9E2
    jZyPQwTx3SD/EXzcbxo7w0OYQp9tBy6RkDdUM1t6K18XXAE1PoKOiZDvhmXRbYZX
    1JIwYiOuAucNponqjP+0I6CgRlomierB3PBMP8/3YcdHo0dS7c9PkfNaZQttDc0T
    UzzWGdf7ZrIUsEOhK0ynhFVj3iNb6DBfgkiEtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222715;
    bh=RnI9TunZRwaInxM1h3S7Ojnyp7igoVfatdeZ3krk3j0=; b=F8ciUDEjzb1B
    6np2ZlPoHKVpI/dRXtUkUlPsDO6jzWRnQoaH77/ObwV+Za1TPxVZomrDPLMz5Veh
    vexqO2JP+SWvvCFrc6UaThpHwgZepvQiCC9qGZkFdtajRf5YiHDTA+WpcIpvdUNd
    FdMZz8J1oEKLHYRax70haskIhoOnYpMObAAFToCeWYQSkzGlpX1OqHbOU9a/lO7t
    MQswvYIljf94OtRf3Pn8UTuLinmGUufwXBTJWOgCJpQjir/3ZC38acHBEq/+peIU
    lLOR3gQw55I30xDkpWhew++K+LmjZaOuUr7mlKYo5HQBG0C4k4UJJFHKakMVAsZU
    rjBc01ut+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=IvW4CSCN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=IvW4CSCN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBUZnxfmnuWe6hb+yLKHQvcAH6MRmAYM7J2G6Q4p7ZbPP30W/XsR33gPe9ZhK3sGB9akDbwUGMkekojJyQjh+Gg7ls2qhT9mXD6Y5iONh0ztbMAndFCG
    MedB6w0RgpO38XGsOLq6ABCSjYWrxKMaRTZoAf0yRHjn/Nm7MWlxAbQscGDuJGoj5LUP+5VQ5V7gqM7uN/64DmvNIhWSy/fFobW/uCGWOTNQUkDXgrgK95Op
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=yLH1FfHMVGKJ3JcWR_oA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeC1HaQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:30:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbeC1HaO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:14 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/30] net/tcp: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:08 +0200
Message-Id: <20180328072926.17131-13-hch@lst.de>
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
 include/net/tcp.h   |  4 ++--
 net/ipv4/af_inet.c  |  3 ++-
 net/ipv4/tcp.c      | 31 ++++++++++++++-----------------
 net/ipv6/af_inet6.c |  3 ++-
 4 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e3fc667f9ac2..fb52f93d556c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -387,8 +387,8 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
 void tcp_close(struct sock *sk, long timeout);
 void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op);
-__poll_t tcp_poll(struct file *file, struct socket *sock,
-		      struct poll_table_struct *wait);
+struct wait_queue_head *tcp_get_poll_head(struct socket *sock, __poll_t events);
+__poll_t tcp_poll_mask(struct socket *sock, __poll_t events);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 int tcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index e4329e161943..ec32cc263b18 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -952,7 +952,8 @@ const struct proto_ops inet_stream_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,
-	.poll		   = tcp_poll,
+	.get_poll_head	   = tcp_get_poll_head,
+	.poll_mask	   = tcp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	.listen		   = inet_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 48636aee23c3..ad8e281066a0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -484,33 +484,30 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
 	}
 }
 
+struct wait_queue_head *tcp_get_poll_head(struct socket *sock, __poll_t events)
+{
+	sock_poll_busy_loop(sock, events);
+	sock_rps_record_flow(sock->sk);
+	return sk_sleep(sock->sk);
+}
+EXPORT_SYMBOL(tcp_get_poll_head);
+
 /*
- *	Wait for a TCP event.
- *
- *	Note that we don't need to lock the socket, as the upper poll layers
- *	take care of normal races (between the test and the event) and we don't
- *	go look at any of the socket buffers directly.
+ * Socket is not locked. We are protected from async events by poll logic and
+ * correct handling of state changes made by other threads is impossible in
+ * any case.
  */
-__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
+__poll_t tcp_poll_mask(struct socket *sock, __poll_t events)
 {
-	__poll_t mask;
 	struct sock *sk = sock->sk;
 	const struct tcp_sock *tp = tcp_sk(sk);
+	__poll_t mask = 0;
 	int state;
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	state = inet_sk_state_load(sk);
 	if (state == TCP_LISTEN)
 		return inet_csk_listen_poll(sk);
 
-	/* Socket is not locked. We are protected from async events
-	 * by poll logic and correct handling of state changes
-	 * made by other threads is impossible in any case.
-	 */
-
-	mask = 0;
-
 	/*
 	 * EPOLLHUP is certainly not done right. But poll() doesn't
 	 * have a notion of HUP in just one direction, and for a
@@ -591,7 +588,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 
 	return mask;
 }
-EXPORT_SYMBOL(tcp_poll);
+EXPORT_SYMBOL(tcp_poll_mask);
 
 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
 {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 416917719a6f..c470549d6ef9 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -547,7 +547,8 @@ const struct proto_ops inet6_stream_ops = {
 	.socketpair	   = sock_no_socketpair,	/* a do nothing	*/
 	.accept		   = inet_accept,		/* ok		*/
 	.getname	   = inet6_getname,
-	.poll		   = tcp_poll,			/* ok		*/
+	.get_poll_head	   = tcp_get_poll_head,
+	.poll_mask	   = tcp_poll_mask,		/* ok		*/
 	.ioctl		   = inet6_ioctl,		/* must change  */
 	.listen		   = inet_listen,		/* ok		*/
 	.shutdown	   = inet_shutdown,		/* ok		*/
-- 
2.14.2

