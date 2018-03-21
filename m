Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521618091-2-10168228469870917477
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
    t=1521618091; b=HfuYcoJ4vUrd9yuSAcfQ9GVKhjlX9BVGyF88cyKfrMeOrUB
    uj1Huret+70vHFwU5PSXr4Z2Zl7mDkm9MB4tTppTdWvDu/i+6A/pd2Tqu9xTJc8Q
    CHpVZf5VrKykofNkHQ1U1NiK4/DaP0K4PlqKhLjQAerTV5P1q404W1i0iAk2hpGF
    FbrFvpW0ZFaQI6MshfqS9iHVlz8M27LgT8lrjet+cQiKqxT/YzK4w8QVlFBbY2Cg
    WlSivuPXVD4hzwrLV6xDong6YKqKSjvIJ2IVseMJ0pfEqlLl6CBzJaqrfH3/asuE
    d+pJwNldlWRrL5RWL5Lv2Dvm6uFb5bHZU4yryvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618091;
    bh=RnI9TunZRwaInxM1h3S7Ojnyp7igoVfatdeZ3krk3j0=; b=QYlw2ROv9GIm
    pILUyIaE8FSlb/TGuHUocYYXrCO3Hk81wq0wPB+PYdBqgfQ/TxMjKscWG3nVYmRK
    G7X68ZPECQ9gOAQAdRQR86LccWLwmx0pR5/V3Zp0kRJPhm44oq8pbQ/gn+/J2zs3
    24+5KJaK/vXbEKHrY6zm3tv+luKECzDs35Kf7YJ07LGZ1DwJExYYrqvOcmpkhjsi
    6MeqWCRxjJx577nBmxyrjUcUy9N/cAv4fH+UoHM51yPiDoD6fH1ETj0NbHZp4jb+
    44LpI6YiyOPhNUDMaCfJ8+gIy7G7tn417kxeq4uM/MfeMznI5SNLHVdrPGE0UxkR
    m9DIyiKJDw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ISVcWjCN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=ISVcWjCN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeCUHl2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:41:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeCUHlT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:41:19 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/28] net/tcp: convert to ->poll_mask
Date: Wed, 21 Mar 2018 08:40:14 +0100
Message-Id: <20180321074032.14211-11-hch@lst.de>
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

