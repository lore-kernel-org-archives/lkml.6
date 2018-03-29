Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1684034-1522355934-2-12016743376797503672
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
    1522355933; b=WmmH8k03f1PtWEbF1pMO2sFdys9ivHTHDvw303+G0s4nC1RfWt
    kNIH0xSdD42uajxoj/WBWYYLS7g4pZ2bZd4c/Z9ZMZ875HsqOXWa5xEb2+v8eRW5
    Sae+JsLwPdregyOrrklF/sHQsfUhfk61xYM9azVgq9Yzk2LDEbNgga4teJAG++gE
    +xxVibktEEkEdjTUOG8VaiyXXAI13D6frRMG/2qWrAMZnFbR0ySecyWzNbe6WT9E
    6CKtB7GDrobHX9IG5D4/h7GZYGWFgHPK9vmCG9plULyZ7pQhNNuCt2lrGiE3zJfR
    ApgRSu6pqTQjEKvPykXEt8/bLYE+IQBH92tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522355933; bh=
    AWzjj26Df3fJmez+FE+BVtIPdTEkX+sNlAJZn623qQc=; b=t9XJKHHtcII16v9o
    FzDLeNbvSTpFF/1cCdYnOkND7XBHGOBrKyuZjSthjrzOMwY2y+eH8f8jXp0mrNlR
    UOm52k9CuaBKsfNgMCeG3924PfNodFU0GmqLRp40ts17ci2wWCf/WRyxIUfJ1t5O
    8ZbAYuSEY/n1yZnGp6oAM9SvbWoTKu7FMCjQ2rGRtAukBoPAusGj9QYd2CqKvpyq
    ixgjQpszsGNxjao1CJNZPmEK8+eZayc9gdVB1PoehGNqw6ilP49g0cm5O1B3LCC9
    X4ZNb6xhsQd7PW4jWrxbsra9w38gFhGCzvLPVlhLzw49wEjbqsPkppdeMjOKxpx6
    QrjESg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=i0NeQDR4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=i0NeQDR4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPkwzQJsRLYTDICO+Y0D5BoW11L46RSUtvbxxapaUgEG1X4jHjkqTgUEzngSUKyFnbXUOw2fyUpXNTHTNDSwSUJu+zcysxRYqxahHFT0kOlTqECywGzy
    HHFcDAK2P3bcZguqwcJJ7/2gURaHaMfBPfCu43PwyU41xl2NfjN6ACSYKGLYfadUfmDseimVu8KyyQJR6Vs7SjJRHy9V9/AMXM8m0pQ2aX86vKv+U51yDLGz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=JAGRcNAvqmLdBlwhYKUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeC2Uex (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 16:34:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeC2Uev (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:34:51 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/30] net/caif: convert to ->poll_mask
Date: Thu, 29 Mar 2018 22:33:19 +0200
Message-Id: <20180329203328.3248-22-hch@lst.de>
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

