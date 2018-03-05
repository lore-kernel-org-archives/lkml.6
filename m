Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2624115-1520285328-2-7431357758434813662
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
    t=1520285327; b=kKIfQ9+kvCSBnEKxL1tVasGV7h/0Fhssns7S/UU5nc12uIT
    OAIOyQttw2FwsCoMjIBseHAc0ioQCh5xxXlxCB4+e8EFNK8K7xLDK7GSrSsKdSRf
    99I0f1TTafQTE1d8PFeoWHi2+NVEkxIaw6Yi4Saq5na+R9o94/38JTeIBkNKex2O
    znrnjsklzWAe/R9b2P4bgT7kFiw32bwbmH3YOxQexaR5FlvrApNv6Qy/2WPBg/iv
    Z3WZZ0iQs1485av6RN+ptPEgXiXDUcteJpQfnAx3R2A+jkHKolqY1REolNhIhZqe
    etpyEq3PRbP3zCrrEPCDYMb10OPtO+A5RnUzQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285327;
    bh=aKd5ZpTCDtU0moo+lYC5cAK3IDI8vm2kvmtKRS/Pgvo=; b=n7IMH21OSiyW
    qx2K8U2L5vrgqf2yOjr/QU8e1KDUr0ffCGG4yoR5Mzzv2QOm0WDi/lLBv2w5T1tS
    4V49XxHCVZWPIGm1Tn2vgi2b4lsjjr5Kws41tNARfudItdATsTnxEPyp2Tuen+1R
    s/20XHw1cgeMCuccfE9Awaqkt/FF/kBtoGPlvSekB/RR3di01Xzka1FqlPXC3FBc
    6JjI7jsRiqukTq4WWkuytXARX+tRShH4b6uundI9TiAZ3uf6t2ppVRluXJvVFEek
    xtVVyFAg/pkJQAwLJyPOHJyn1T5Pnp5N9HARPRNTVu/ctAtdhkKCyV6ETwKxprNj
    aFOcQ0laag==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eiEhA5nW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eiEhA5nW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeCEV2B (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:28:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932555AbeCEV15 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:57 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/36] net/sctp: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:32 -0800
Message-Id: <20180305212743.16664-26-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/sctp/sctp.h | 3 +--
 net/sctp/ipv6.c         | 2 +-
 net/sctp/protocol.c     | 2 +-
 net/sctp/socket.c       | 4 +---
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index f7ae6b0a21d0..37abd5ba4a3f 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -107,8 +107,7 @@ int sctp_backlog_rcv(struct sock *sk, struct sk_buff *skb);
 int sctp_inet_listen(struct socket *sock, int backlog);
 void sctp_write_space(struct sock *sk);
 void sctp_data_ready(struct sock *sk);
-__poll_t sctp_poll(struct file *file, struct socket *sock,
-		poll_table *wait);
+__poll_t sctp_poll_mask(struct socket *sock, __poll_t events);
 void sctp_sock_rfree(struct sk_buff *skb);
 void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 		    struct sctp_association *asoc);
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index e35d4f73d2df..6b0b8fc5b75a 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -976,7 +976,7 @@ static const struct proto_ops inet6_seqpacket_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = sctp_getname,
-	.poll		   = sctp_poll,
+	.poll_mask	   = sctp_poll_mask,
 	.ioctl		   = inet6_ioctl,
 	.listen		   = sctp_inet_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 91813e686c67..20c544890e80 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1024,7 +1024,7 @@ static const struct proto_ops inet_seqpacket_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,	/* Semantics are different.  */
-	.poll		   = sctp_poll,
+	.poll_mask	   = sctp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	.listen		   = sctp_inet_listen,
 	.shutdown	   = inet_shutdown,	/* Looks harmless.  */
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index bf271f8c2dc9..097454740929 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7587,14 +7587,12 @@ int sctp_inet_listen(struct socket *sock, int backlog)
  * here, again, by modeling the current TCP/UDP code.  We don't have
  * a good way to test with it yet.
  */
-__poll_t sctp_poll(struct file *file, struct socket *sock, poll_table *wait)
+__poll_t sctp_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct sctp_sock *sp = sctp_sk(sk);
 	__poll_t mask;
 
-	poll_wait(file, sk_sleep(sk), wait);
-
 	sock_rps_record_flow(sk);
 
 	/* A TCP-style listening socket becomes readable when the accept queue
-- 
2.14.2

