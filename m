Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522355887-2-16006232483762058109
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
    1522355887; b=vmBnnr2bLApFNknRqMiy9i2SHMlHO/JYtP9dlUu4G8nVzn5G/6
    MQy/2j+6Iz4fMRV/b4Ud9+251URf9JYTFT2wJV4sQrgt3q2eTeUFpObPcaL+wdeU
    rVwS1BcMmwkXZIqL/BGLfjANp5xVlzett5K1Z0Vvs33bljnvuYLTLfoRQ5MQh1Bm
    BgvoKaIGy4DAGFJ8AZLzJ8q4E420B/t1NEXh473vWTyLtGAISuLdy9hPauyVuebR
    CMgjdLtcfYNrX+XVA8r/DFDD+TgA0MtGaxZ2QkDZgWPBw67dTHPi7nGoS6SLliLE
    /eg/pEvobwg6kJYcnNvUTFexQILhQLLBkEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522355887; bh=
    Hfx+8aI36lVu4Io7aKeEu2LlZk/ejeeSXKDzkd59fx0=; b=HpLUhbIMM/nWjuvX
    nXdd7BrABZ+Kh0BlWIyLnvRPQCHZlS8DGYMzGJNpIXzoZREJQCkxRflVxsOVYb3d
    q4Pe88VcdlfSFbxX6sSMl+3Yx+2l2weqqrjowLNcMU24Gztb/yOjl3JTqgJPhBBa
    7qBV1cmignr2XrMtDWFAMf93DItdWJu0l2lymsRLKxsvbpzTYv+4nXE104z0OfKi
    pKS3J2a34caKZdOEMgdqBOxTMTp8HOwc8X6s0ggm5zCErgkwcXKks0qONkXgZ+1J
    reJ2tzO5LOPfkXm9aRUf+iJYpLjOemH9Yh6NSErISzGmMCSEbjmrD6Y0MPglyHTk
    53PI9g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NHt3P9Qx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=NHt3P9Qx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDAuxMQn8uvvt4SgAy11MelZ0B8acGT63O/UTf0s7EGCDrwJTwoj+KII0xL1EkNLK8CaOT30dkfcBGINTOJO5wAvJq4FGDCwEOHGmEsc+m/lYialJGXy
    HuYfs9egYEVpIWQttx2iyoKB5XsHd4YAJ1kYlU6N+GhCbZmQWZWFibYDMtuV3zoWEIfqzJ5zBw3TugEAZJ6DFaHb0uWOHHc/FOPO68nePJvHtDUpeZajOUDm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=Ic12xEm8Y5kTsGoQNkIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeC2Ue5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:34:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeC2Uey (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:34:54 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/30] net/nfc: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:20 +0200
Message-Id: <20180329203328.3248-23-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180329203328.3248-1-hch@lst.de>
References: <20180329203328.3248-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/nfc/llcp_sock.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 376040092142..b6010750e634 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -549,16 +549,13 @@ static inline __poll_t llcp_accept_poll(struct sock *parent)
 	return 0;
 }
 
-static __poll_t llcp_sock_poll(struct file *file, struct socket *sock,
-				   poll_table *wait)
+static __poll_t llcp_sock_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask = 0;
 
 	pr_debug("%p\n", sk);
 
-	sock_poll_wait(file, sk_sleep(sk), wait);
-
 	if (sk->sk_state == LLCP_LISTEN)
 		return llcp_accept_poll(sk);
 
@@ -900,7 +897,7 @@ static const struct proto_ops llcp_sock_ops = {
 	.socketpair     = sock_no_socketpair,
 	.accept         = llcp_sock_accept,
 	.getname        = llcp_sock_getname,
-	.poll           = llcp_sock_poll,
+	.poll_mask      = llcp_sock_poll_mask,
 	.ioctl          = sock_no_ioctl,
 	.listen         = llcp_sock_listen,
 	.shutdown       = sock_no_shutdown,
@@ -920,7 +917,7 @@ static const struct proto_ops llcp_rawsock_ops = {
 	.socketpair     = sock_no_socketpair,
 	.accept         = sock_no_accept,
 	.getname        = llcp_sock_getname,
-	.poll           = llcp_sock_poll,
+	.poll_mask      = llcp_sock_poll_mask,
 	.ioctl          = sock_no_ioctl,
 	.listen         = sock_no_listen,
 	.shutdown       = sock_no_shutdown,
-- 
2.14.2

