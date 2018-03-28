Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1769925-1522222780-2-1496206620110373813
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvsk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522222779; b=JpcR+hMYqQB1nZ0VVzEabsiGMi5OepJyismuSCO0H0vlSHl
    xJN/8vgUWpvEc/bx/pUiJRC+8oLGGHko4QsG2pEFcGkBi0L3d66QwQTJ95igg+q7
    szQm/0pufpc5qUYfAz3k7K93/vchwBVaAYec6DYfv4vQZcU+S/MWq/bbC7GQTAvP
    tiwEgHblCPMzDgpJrJJStXyox0l2BAasLpE6kCs4st1/j/sG/5C/xmivvi8k6JeK
    T6Mkr8Ked+jT0ERgUW3TmdzlODaNep5WQPf/B9q0ICzViDaQFjkOzEulBqZWqZ9U
    PEJSeTggquuVJ23t12IR5arwsHD+qSaH4vDUFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222779;
    bh=rTfn2iSlPAvRyX7XbGaMsNayUW07yqL4zxp48lHDrzQ=; b=OdkpifOM0LO2
    3hdUwnxwv2fjI4glonTjQ7Cxcn87e5T5HrvkcknUATIwtNVZDGEL/CIQW2zXZwLC
    +Mo4sRBeYiE2V7gFtOUlcAYCaS8DhHPm98W3lv69VvRwvHMLysnAooznM+r9rVEA
    co/JAhVKeQ1X6BolyI37YXBkXqadiTlT20QKVoPSLjofabJnx3R7EjkmB75wBzij
    aR9fxm7bFyEuR3oaUmFGpHG9ahHz1tou9nYiwIMo7EKKNRCs1fRR8I8aitauFRaR
    NLeLPXjX9b+oJdQlpX1GissrPUmd5jfGg5BKxjI3dH3uUDKMSh8VAWQs2Pf7Oz1L
    iwuS/2HqTg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e2K2UBCr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e2K2UBCr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHIcxT+NIlxHjthKRtdlKs+hvCdmz5LMCQwry3x14ePu8K4uogDg59uHAxfb5iL7t6lZwth/9EKmCk2ws6hsIAX7Y6h4bGxiWj/7xjsFIhY5YXFZ5fkO
    HGh9F6wXFx3fK6eVPTB+DJQHh9Y19ln3m7Aaz97O1/FrZonBD29649+WMgozY/EMg1IXAC8swRBBzTT0sMPqc4pcvggtzQ8NI8a+WBfImAdVZoClWxcw0u3P
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=NF0aQ0-qhcIZ2yZ1B1MA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeC1Hi5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:38:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeC1HaK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:30:10 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/30] net: remove sock_no_poll
Date: Wed, 28 Mar 2018 09:29:07 +0200
Message-Id: <20180328072926.17131-12-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that sock_poll handles a NULL ->poll or ->poll_mask there is no need
for a stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/af_alg.c             | 1 -
 crypto/algif_hash.c         | 2 --
 crypto/algif_rng.c          | 1 -
 drivers/isdn/mISDN/socket.c | 1 -
 drivers/net/ppp/pptp.c      | 1 -
 include/net/sock.h          | 2 --
 net/bluetooth/bnep/sock.c   | 1 -
 net/bluetooth/cmtp/sock.c   | 1 -
 net/bluetooth/hidp/sock.c   | 1 -
 net/core/sock.c             | 6 ------
 10 files changed, 17 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index c49766b03165..50d75de539f5 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -347,7 +347,6 @@ static const struct proto_ops alg_proto_ops = {
 	.sendpage	=	sock_no_sendpage,
 	.sendmsg	=	sock_no_sendmsg,
 	.recvmsg	=	sock_no_recvmsg,
-	.poll		=	sock_no_poll,
 
 	.bind		=	alg_bind,
 	.release	=	af_alg_release,
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 6c9b1927a520..bfcf595fd8f9 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -288,7 +288,6 @@ static struct proto_ops algif_hash_ops = {
 	.mmap		=	sock_no_mmap,
 	.bind		=	sock_no_bind,
 	.setsockopt	=	sock_no_setsockopt,
-	.poll		=	sock_no_poll,
 
 	.release	=	af_alg_release,
 	.sendmsg	=	hash_sendmsg,
@@ -396,7 +395,6 @@ static struct proto_ops algif_hash_ops_nokey = {
 	.mmap		=	sock_no_mmap,
 	.bind		=	sock_no_bind,
 	.setsockopt	=	sock_no_setsockopt,
-	.poll		=	sock_no_poll,
 
 	.release	=	af_alg_release,
 	.sendmsg	=	hash_sendmsg_nokey,
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 150c2b6480ed..22df3799a17b 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -106,7 +106,6 @@ static struct proto_ops algif_rng_ops = {
 	.bind		=	sock_no_bind,
 	.accept		=	sock_no_accept,
 	.setsockopt	=	sock_no_setsockopt,
-	.poll		=	sock_no_poll,
 	.sendmsg	=	sock_no_sendmsg,
 	.sendpage	=	sock_no_sendpage,
 
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index c5603d1a07d6..c84270e16bdd 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -746,7 +746,6 @@ static const struct proto_ops base_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 6dde9a0cfe76..87f892f1d0fe 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -627,7 +627,6 @@ static const struct proto_ops pptp_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept     = sock_no_accept,
 	.getname    = pptp_getname,
-	.poll       = sock_no_poll,
 	.listen     = sock_no_listen,
 	.shutdown   = sock_no_shutdown,
 	.setsockopt = sock_no_setsockopt,
diff --git a/include/net/sock.h b/include/net/sock.h
index 169c92afcafa..d9249fe65859 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1585,8 +1585,6 @@ int sock_no_connect(struct socket *, struct sockaddr *, int, int);
 int sock_no_socketpair(struct socket *, struct socket *);
 int sock_no_accept(struct socket *, struct socket *, int, bool);
 int sock_no_getname(struct socket *, struct sockaddr *, int *, int);
-__poll_t sock_no_poll(struct file *, struct socket *,
-			  struct poll_table_struct *);
 int sock_no_ioctl(struct socket *, unsigned int, unsigned long);
 int sock_no_listen(struct socket *, int);
 int sock_no_shutdown(struct socket *, int);
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index b5116fa9835e..00deacdcb51c 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -175,7 +175,6 @@ static const struct proto_ops bnep_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index ce86a7bae844..e08f28fadd65 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -178,7 +178,6 @@ static const struct proto_ops cmtp_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 008ba439bd62..1eaac01f85de 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -208,7 +208,6 @@ static const struct proto_ops hidp_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/net/core/sock.c b/net/core/sock.c
index c501499a04fe..b72b6ad050e4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2503,12 +2503,6 @@ int sock_no_getname(struct socket *sock, struct sockaddr *saddr,
 }
 EXPORT_SYMBOL(sock_no_getname);
 
-__poll_t sock_no_poll(struct file *file, struct socket *sock, poll_table *pt)
-{
-	return 0;
-}
-EXPORT_SYMBOL(sock_no_poll);
-
 int sock_no_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	return -EOPNOTSUPP;
-- 
2.14.2

