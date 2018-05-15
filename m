Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526414231-2-13801833888904015839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-asciisv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526414231; b=ORDsdwcNBhlPJvUYx4D5nI/DneXD8qo/X6sA4akbfo0TblGiTu
    ZorKUHAai7TDGigyC/z7wN/CXQEVHKbYOSmF17CpaeW1hrTfmDy1dIDM8svPcAR9
    GBGlqAMtGuuLZBCSIU7TYNGwp6rBpTmo1j/FEtDBWdG+C8zvp4Zcq6MKSncQ22DX
    bDGqFIWqYG3D9/NKTizvGzAG+reggBzK5vqVPLI6N23h7dmFet0OyX9po40zmZt2
    H5eQ62JjRevi/AiJd5fJp55oymCgtfC9aVr6b8of/Us7NAOivNjD8PMVR+e08kfS
    hbjyhDj9ZQk5+YiPtqDBH2DtIFnXZE+QpDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526414231; bh=
    5hfTYf2QG4q/g3jhOp1ASHYWU7WXTTAaYQUcbLSf+aw=; b=C6qkX4glby4R7vbM
    RG1r3DAc+rcVQ58U1K+1WL4bjsWmCsTFXX0XbZqc5g/ascFIJRwrTJydpbuBrvJS
    VRp1jVqwsmftL/zpQYAYPmg4zynGICIFMjP6+NZYGmhL0T6lt9UriBs+gxL2frR/
    LMbunEUbSsoEWlg+SCjxVYctKFYg/nISKdCak4lI83mcv9Dp1/dGz0O4+2T6oziY
    nWgKFS6oB+KsnKs2jWYp0MRyGjhK2HFBbM3TKrJyp/6KoGDInnfcFgJVN+bVx3xQ
    Jh4L9fDLhqC5NFx1MZr1kvjIOrCQrkjGvhkLUxAomUvGch5TrHTjlUzT0Di6/SZ/
    //biWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=KVmrNvnR
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
      header.d=infradead.org header.i=@infradead.org header.b=KVmrNvnR
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
X-CM-Envelope: MS4wfIA3j2DrwAXF1jf1wB8haZXY2e9TaB/TsQ0s6/0AHHBJBXObK5d2xVDN4q2W2RMxf8O/1j43wMh2E52Jy7O5FVLApZDpMf8/mIArhVH9BG/71iz8RXdp
    KBDz6k1birlBTn9AD2gqWY3fPpUjMcEi2YkKb3ZjYOT58ljUSWeses6Qi/Krb1tlBWCUuxwWFVBqJM4fJ6PPujl0ZcKuS+rgLpqb11VJZFr+te8JRAYj/AXQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=NF0aQ0-qhcIZ2yZ1B1MA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeEOTtd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:49:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeEOTtc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 May 2018 15:49:32 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/32] net: remove sock_no_poll
Date: Tue, 15 May 2018 21:48:14 +0200
Message-Id: <20180515194833.6906-14-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180515194833.6906-1-hch@lst.de>
References: <20180515194833.6906-1-hch@lst.de>
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
index 7846c0c20cfe..80838c1cef94 100644
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
index 1f8f489b4167..18c0a1281914 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -745,7 +745,6 @@ static const struct proto_ops base_sock_ops = {
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index c4267ecefd85..157b67c1bf8e 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -624,7 +624,6 @@ static const struct proto_ops pptp_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept     = sock_no_accept,
 	.getname    = pptp_getname,
-	.poll       = sock_no_poll,
 	.listen     = sock_no_listen,
 	.shutdown   = sock_no_shutdown,
 	.setsockopt = sock_no_setsockopt,
diff --git a/include/net/sock.h b/include/net/sock.h
index 74d725fdbe0f..4d2e8ad98985 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1591,8 +1591,6 @@ int sock_no_connect(struct socket *, struct sockaddr *, int, int);
 int sock_no_socketpair(struct socket *, struct socket *);
 int sock_no_accept(struct socket *, struct socket *, int, bool);
 int sock_no_getname(struct socket *, struct sockaddr *, int);
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
index 6444525f610c..d471aa524b62 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2567,12 +2567,6 @@ int sock_no_getname(struct socket *sock, struct sockaddr *saddr,
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
2.17.0

