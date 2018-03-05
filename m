Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2624115-1520285553-2-18297694641075562139
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
    t=1520285553; b=B8VVb3Ed1E2R7ANIQHe0KMZ0gGcb5pBXknWxHN4kCul1CYe
    O7xJCXDlA4Ym7up023Get909z7zsffgKO09cpTAO/Jkl7/B5tHBQ0YJ0mzvhHeSb
    UQuLJCSaSQLIGTuNEQv8iQ8pVsLzccjDifm50IrmIlm8qSfULkc+nD8Io5L8z+1o
    BQIqvJp8iwGYTaDdDoTd9Syq8UeU2DuWAMnAdv2ZmEIHyr3DqMOzHdNIIa1JtVjc
    bPqmu25ivInz6T+KgtVkD+EcCwKt3pH9+aCxWIpeJFwA947LtG0YrryZYEI9APqW
    MP96ctfttWhNIPN1CqteYKdy5rVvZVGuIvPmM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285553;
    bh=AWzjj26Df3fJmez+FE+BVtIPdTEkX+sNlAJZn623qQc=; b=U19ILzvbsJtf
    zYgzuH2uk9AOQutrdlWqBwp5ALDuyS3+5PVlhiL3XiWj/kAnfN8BOqYfce3V+eGv
    2iYSjC0rIm1soLDpobeAKJtaV3vAaEu0+esGlP7NHc7jtYJjf1po0yfQOQRtpXkl
    g58vyv25iN9lXvjUg+9NIXeHHs4GwMwJhMHtpJIcdC1hA9pWZ9OuSvZftu2vENjH
    HDrWlN78D4BHgH3sgeXH4wx0BDcg3Vg+c7ZWbq9vDEWkuyzvnlFPiP9IwCye33vg
    8KRVI58RgmIpVtPBtTPb83MjWetyekkOJIQqgePbp3cjFM/dISZa11j9wOiI/Llp
    waMOcRYfkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=TosbtlrP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=TosbtlrP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeCEVcE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:32:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932427AbeCEV16 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:58 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/36] net/caif: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:34 -0800
Message-Id: <20180305212743.16664-28-hch@lst.de>
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
 net/caif/caif_socket.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index a6fb1b3bcad9..c7991867d622 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -934,15 +934,11 @@ static int caif_release(struct socket *sock)
 }
 
 /* Copied from af_unix.c:unix_poll(), added CAIF tx_flow handling */
-static __poll_t caif_poll(struct file *file,
-			      struct socket *sock, poll_table *wait)
+static __poll_t caif_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
-	__poll_t mask;
 	struct caifsock *cf_sk = container_of(sk, struct caifsock, sk);
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	/* exceptional events? */
 	if (sk->sk_err)
@@ -976,7 +972,7 @@ static const struct proto_ops caif_seqpacket_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = sock_no_getname,
-	.poll = caif_poll,
+	.poll_mask = caif_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
@@ -997,7 +993,7 @@ static const struct proto_ops caif_stream_ops = {
 	.socketpair = sock_no_socketpair,
 	.accept = sock_no_accept,
 	.getname = sock_no_getname,
-	.poll = caif_poll,
+	.poll_mask = caif_poll_mask,
 	.ioctl = sock_no_ioctl,
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
-- 
2.14.2

