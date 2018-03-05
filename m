Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684081-1520285567-2-5892657250833669557
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
    t=1520285567; b=emZQtHWqBwQHgDpOi/+Q996fTKUsmxv7K01OgejQDHoCReV
    elguLY9bKKoD2Tetxtn0Lvg5Egdk0Hkir/uB0gt4Y46Jq4JoZO34Df2muoA6lKvq
    X4iJLludQGEnFizfsdJz7gqsB20AdQa2dgrdJvDkZws26HiaiIwzzmd8kJTb4kha
    qz+0+u5aORR7hiQHE/7nLDOb4PfdhcX7UsGtAmDTFm3IJYldDbqxBUzHt4pDiiQD
    J5tdN7QRxkG1GZU/nXm92DfB1ysai0z+SLpPponZyIbv7CCZnIDmUSWsCH9jM/vs
    lstv/0IKUroUI9LWikZZvj+PjDEEJSdqFJEybNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285567;
    bh=Hfx+8aI36lVu4Io7aKeEu2LlZk/ejeeSXKDzkd59fx0=; b=lRtHcXTl83A9
    FMEGUk5cnIln//+M8imVnYgVAb24YT02hcVOq+rCM5GQkSC97++UInun0GgQ4USg
    jVX6C7mUti0U4ngQhu8ZDZfc4dhc6TXxAGSRSliyRR+8rsAJyzXcSX7ebFhJECKR
    Il7zU4o6PQan5HZ06QyfCcDt/FQ6W8yzeiHwtktqjjceKww0n/fSudMjeUi0O+Zx
    fyxvQBDTr1zfEmlxMrbXgJM+aANnyWe+1yrr8/oB6FOp/BFjjsne3TWs2WTg4o1l
    xTfLraggxv6f/Y1SyGs6dXCi3Zsa1eYo4zc7Y45ineLQU/4vbdqAVB/ScoqBsdvM
    Kvt522p4ag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=LIPCZ4Cz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=LIPCZ4Cz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbeCEVcC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:32:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932590AbeCEV16 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:58 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/36] net/nfc: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:35 -0800
Message-Id: <20180305212743.16664-29-hch@lst.de>
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

