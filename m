Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842726-1526037350-2-13134401269948774619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526037349; b=bDipz2drLg7j4I6biIAzdemzcIX9M7xstZ4ywlzK7rgl9RyKWp
    PhiLGNLsYNsRiHyFH1OHbj5hZPE3gTfXjT9pUSxHEBHm8oAXMWNEuqrarJXhiyYV
    xFIY1oeFcbv9hFMFqK5IKZZ/klN6lKxe2NXo+N0h0bY1lmWO1STrJnf/88DQB9D8
    lseuk9eccESfrVf+cpHKHxbPflGS3ZLsLY0cs7/KZGVz7A15Tm4bKm/VjCTzR+J1
    28/0hxIdd3YgwMPDJTldeNzdlTEwP6FCUpmzECy79cH78P/rvy38GmjaFaiWLENl
    9EMG1y84eDYUYfwB0ITUY0WxlOkRfujIw27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037349; bh=
    pmdstJe482NmQzkB/TsQwMF3e1oiKlHQ9UC3GaBbW5M=; b=BbFDX4gLys8CEJfx
    JjdU+anyr/PdYvwmFyAwrqodvF31ZqNXk+LkAN93H3FlEOkGYWh0Nl/mGb969WQA
    dKuCZEX21M2FptV9ix8XmkxSK6HTHQtMzzc4KX6awZiyqF2CheA7iVNaW5UX28Ue
    bRYQpcSufj6UKGhv7rCgQdCqeH7tf8NEQs9BjU4LB0VRM8971xlo0x8iz/wxFmBo
    nWB9ViqR06vz0KgFX/AOqFSVxm/dV7P0xzfGpom0er7N43hzfUPMxmZ+IINSCpAB
    fUMX5tT4APl1SuoT55xDRucpOQJWvns2RZVfj9Foa92za5MuSCr69yxJeuMXe1kT
    nBmE0A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=pQLLN4ht
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=pQLLN4ht
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
X-CM-Envelope: MS4wfNRbsHX27NElAUMu36YQsKiqeuLRrk2pasVrYhDRxM/yOu3JuKmGOVBifMkrTpxyT/F6S6PqvYLDDYNCXToyj9jhU+q9B96Rhvyicvngkm79qi5qA8xN
    wAK2F3+9E4R8JsnDL0vGnqSZF5zl2JttzCpDU4C71OvUFDSwY6vH90obswq+pj46dpVQkpyGYPGoKzx5gWdfL7H5+YbZ7K+Tk6l6shglYgHhFT8aT1Nh02iK
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=8Ql5ahqjzFPP2Dbx7CcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeEKLJP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:09:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeEKLJN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:09:13 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/32] net/sctp: convert to ->poll_mask
Date: Fri, 11 May 2018 13:07:52 +0200
Message-Id: <20180511110803.10910-22-hch@lst.de>
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
 include/net/sctp/sctp.h | 3 +--
 net/sctp/ipv6.c         | 2 +-
 net/sctp/protocol.c     | 2 +-
 net/sctp/socket.c       | 4 +---
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 28b996d63490..206100cc665b 100644
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
index 2e3f7b75a8ec..d52eaf1881af 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -1007,7 +1007,7 @@ static const struct proto_ops inet6_seqpacket_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = sctp_getname,
-	.poll		   = sctp_poll,
+	.poll_mask	   = sctp_poll_mask,
 	.ioctl		   = inet6_ioctl,
 	.listen		   = sctp_inet_listen,
 	.shutdown	   = inet_shutdown,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index d685f8456762..a1d2ea3ff4c9 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1016,7 +1016,7 @@ static const struct proto_ops inet_seqpacket_ops = {
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
 	.getname	   = inet_getname,	/* Semantics are different.  */
-	.poll		   = sctp_poll,
+	.poll_mask	   = sctp_poll_mask,
 	.ioctl		   = inet_ioctl,
 	.listen		   = sctp_inet_listen,
 	.shutdown	   = inet_shutdown,	/* Looks harmless.  */
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 80835ac26d2c..f6bb1b89525c 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7701,14 +7701,12 @@ int sctp_inet_listen(struct socket *sock, int backlog)
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
2.17.0

