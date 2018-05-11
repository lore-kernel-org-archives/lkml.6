Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845081-1526037378-2-12264243851163834838
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
    1526037378; b=NzP6yw+2n+lazUtahcrHx+7H+WrtsCevbyfaPLQ5lR1Tao3gkb
    TLpLWmLNQ/BgePCV3N94Opm9RipTvpBUZp3+fNR4vOBGpP8bYZLNlU8HPxM8Ki+r
    xRr97iNpwwNIoY8+Z0SRODYRTmCDc534XQXD7S5GeRyiQxZrx0jYn2aePNsZ5hL+
    EZvpsY5Uk75T44bW3AhXAWGVU64T7oBt3qGdoOti2v3nrqIknfnJFXLdEj8TskR3
    ZjiBhqXad/tsqXzWC89sSP6r+nQRXEWNQTl76w/4FrtkgZP12jCyZ1zV4zS7Q2uR
    39HlAQ89Ur10xEBnByLHtEDeqDCAF7qlFDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526037378; bh=
    AcxLiviIuqcd+DBjOfM/9veHo2td0gYer83zcL0Bpxo=; b=Aa91F5gVDPsXlKs4
    y9ak10sAIuLim4NTt2IOpBF1I/pgHawiDE0P2kD8HtykEhJaLe0gnAhA2Ciu6gv6
    OJWnJ8wWHaSnSydTIv7tMsvz6FAwNaS1CTg7S87/jFEKxT5ekqRGCHe7Uq/enbZz
    BaWm8tjVL7evsiDi/ud98nfvxYDbk1DObaEoh5WRaMEPA3jtWdgJYJJPr+dYhilo
    rASQjesHM61PT5XzqRzSfynYredBqJrN6LJ1OsHu3GyYzhRBO/Obvkut6CkLyy8H
    xBAZf3hGRBKO8RGr5K9VR3SCsspOBV/lLrpJL+KwXMkTiduq5wXbj8b6gK208hUr
    12tL5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Ra+POSvG
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
      header.d=infradead.org header.i=@infradead.org header.b=Ra+POSvG
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
X-CM-Envelope: MS4wfA0jn+jeI0L4hcR5KsYdk6004oboqo30peZmJB32QEI54PQ0rizYLqj+odT/vrYmqs+vMONazS3Y+kJIbDYAZEUrTeyVyrjY+vjuZJnilf2IDA5EM1lc
    LzZsSlm30Y2R755MT9mlVvJ42wB3iNAwP4AFfNEWzhV6ERYSBhvh9uQl2sBXkHgvTLDLxJ1tBKo//VN7H6FAZR7m9zYWDjBWm4DIWFz3RJIbpvOBd4H2Blv+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ad68_8OTSUJq81Ci_wQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeEKLPt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 07:15:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeEKLJL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 07:09:11 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/32] net/tipc: convert to ->poll_mask
Date: Fri, 11 May 2018 13:07:51 +0200
Message-Id: <20180511110803.10910-21-hch@lst.de>
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
 net/tipc/socket.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 252a52ae0893..58549338582a 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -692,10 +692,9 @@ static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
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
@@ -709,15 +708,12 @@ static int tipc_getname(struct socket *sock, struct sockaddr *uaddr,
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
@@ -3027,7 +3023,7 @@ static const struct proto_ops msg_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= sock_no_listen,
 	.shutdown	= tipc_shutdown,
@@ -3048,7 +3044,7 @@ static const struct proto_ops packet_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= tipc_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
@@ -3069,7 +3065,7 @@ static const struct proto_ops stream_ops = {
 	.socketpair	= tipc_socketpair,
 	.accept		= tipc_accept,
 	.getname	= tipc_getname,
-	.poll		= tipc_poll,
+	.poll_mask	= tipc_poll_mask,
 	.ioctl		= tipc_ioctl,
 	.listen		= tipc_listen,
 	.shutdown	= tipc_shutdown,
-- 
2.17.0

