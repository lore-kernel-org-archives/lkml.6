Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3454413-1521618441-2-1000412744248885226
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
    t=1521618440; b=aYv1aOLQPQUFs4XzqmfihrTVXl9uZ0g0vnlL+DjxdPPZmNn
    W3o19ZvMwBbnwrTFPVfTiYyCmsm26FpZH0MwW7AkASIqKXq4pasBXbNtYkyzQ/W5
    F49/Kp/gWRVNqM+tcvHbdDPETZ8sxf3pggGGkRocse2Gx0QHn0X0Zxau5uhl1uio
    gpxKNj26q41dVwp8ZEAuUVfwza3iaowuVD/VuXV1RhY1rE8gnqiureBBYMZusH/p
    dSJFxJtBt94RMp2DPGvgB+2h6Ir1sAOiepptGPwkWZrpn2gB/Ar21IwNWkug57K0
    uSx3g7Jg/1l7EhwiZyn5W0r4gCrdOIHM1ZuuHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521618440;
    bh=uFysI3k0igETfcS5k5b5Aks3Gi1IzNFrw0Gw+PDkNf0=; b=nboISOA6LKD1
    S8iXmJgB2jChxsd75MugI1I9FYL9I2B3IjMyBLeuuSwvGVHzx+ho4bSzsDWFMO+r
    sW9v9IM39ujxRU5OPOctmsBCNjWhnwmzxI1rnSbqeaD24nUdGmNfIcz9oT6A0R5W
    ZSuYtFTrkAXm6xbMJaH3tjhgH81WZ92y9bUS4Bp7sIIfsg4+iufxseC7bU5ribDR
    kMDbJWWR0pAzSJR0FkPuc9fQd5tX1dAKmSHSr8qDtWXjFzpiH7vmPkHdfmxgsZjR
    6y1qPXOXBLEugDamUr6ekEyuw9lj8fAvt73l5SYBLLQvlh0038ET8Hmx1MdPzFSK
    K9alqI2I/g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Tz9c3eHt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Tz9c3eHt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeCUHll (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 03:41:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeCUHlh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Mar 2018 03:41:37 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/28] net/vmw_vsock: convert to ->poll_mask
Date: Wed, 21 Mar 2018 08:40:19 +0100
Message-Id: <20180321074032.14211-16-hch@lst.de>
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
 net/vmw_vsock/af_vsock.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index e0fc84daed94..b9210329bda8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -850,18 +850,11 @@ static int vsock_shutdown(struct socket *sock, int mode)
 	return err;
 }
 
-static __poll_t vsock_poll(struct file *file, struct socket *sock,
-			       poll_table *wait)
+static __poll_t vsock_poll_mask(struct socket *sock, __poll_t events)
 {
-	struct sock *sk;
-	__poll_t mask;
-	struct vsock_sock *vsk;
-
-	sk = sock->sk;
-	vsk = vsock_sk(sk);
-
-	poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	struct sock *sk = sock->sk;
+	struct vsock_sock *vsk = vsock_sk(sk);
+	__poll_t mask = 0;
 
 	if (sk->sk_err)
 		/* Signify that there has been an error on this socket. */
@@ -1091,7 +1084,7 @@ static const struct proto_ops vsock_dgram_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = vsock_getname,
-	.poll = vsock_poll,
+	.poll_mask = vsock_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = sock_no_listen,
 	.shutdown = vsock_shutdown,
@@ -1849,7 +1842,7 @@ static const struct proto_ops vsock_stream_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = vsock_accept,
 	.getname = vsock_getname,
-	.poll = vsock_poll,
+	.poll_mask = vsock_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = vsock_listen,
 	.shutdown = vsock_shutdown,
-- 
2.14.2

