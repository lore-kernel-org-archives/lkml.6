Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3815124-1522424555-2-10534169948364555132
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
    1522424554; b=XaP/DCQJ8lerGnP2EvThDikdtuSsXfs8pYw/1PuwHtC4xDIvIz
    KSkYmAC8QisgAXnvdNc5L3PYsc4G/ywm8PUoRxhNVjpXbMzum91atHqPh+bF41Q+
    +yp+zLlNwSZK3LkyEuABvWnP6wMQpOStY11KPOvtUTiRJqnWKDSMFnjx9zRBrtlT
    q+/SlS6B8Wnh3lbs67442N4Br5YHmJl2x64a3ejGWS/TCgtAKevWyC3bGYaTRkw0
    xPeVYez46CPrzIiySF9SebCrbvyvXWGmwLBtPYwE2nbq7VRc1EEVFPx8kUNB6S/a
    74oSnnCLm2YGaEPxvGYbwSlsCXnmKu6Pmh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522424554; bh=
    aKd5ZpTCDtU0moo+lYC5cAK3IDI8vm2kvmtKRS/Pgvo=; b=eUwX9Wo0nZ3fxEQW
    HtmDbm0F3hYljHEAFvVMLZze0hrd6H0gi3uaZo5YPfZgYtwXiYT3SfAZ9j/OTBc1
    jMrwbP/JRotVPCsyztapKtfgK36FMJ9mat8p8jRCRu96nZ6A4iLdk6ldNkiFTw7v
    KeeKAbY28VobGZMZ3Pa+N5kVbkW2fY8EY96RBzCvVyVttjPLbmB3oButmynmkfF7
    f9bT0muJTi2KJxd94YWirqWfmqfFcg3ACbul0DeT0Olnm0gAMm6uxscfU2dI0W5j
    G0hoH3i2c0TkB51t908c+KIv23pGcaARJywRMOAHvTe1wCq0Yg5L/jjuGp4Nx4p2
    xjK9Nw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=lq9E0igo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=lq9E0igo x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLx0lpGXNaER0idWYYWjM+dpO2CCLJ8E/ZP9BbQCAgT03sN9mQO4kN3K3vYA1JVy2yQxbHPWOa3Bj5rvTLNa6dwJr15/cot5wsLge1g6xibAbMuNxMB9
    ed5MdO1LSDWEKMnR8gM/i0YHsLaAUo3l46tNIhMs22Cp0asVz3NbyFGtJL7rKpiw0UGeOP6iZsq3McroLGUFsuh7eHel16M98c8oJa+IKC0TsvHGzoqbU0j8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=8Ql5ahqjzFPP2Dbx7CcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeC3PdB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 11:33:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbeC3Pc7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Mar 2018 11:32:59 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/32] net/sctp: convert to ->poll_mask
Date: Fri, 30 Mar 2018 17:07:58 +0200
Message-Id: <20180330150809.28094-22-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180330150809.28094-1-hch@lst.de>
References: <20180330150809.28094-1-hch@lst.de>
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

