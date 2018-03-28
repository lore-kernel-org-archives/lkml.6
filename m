Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1661265-1522222378-2-13916943206922228790
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
    t=1522222377; b=ayoVfRVhJOrXgw4qacYqwChcG5E8qW9+2CZ6iIbNyTekhVD
    mHofP5oJDV1QNvEAQTbk9qoMw7eRbqd0S9bhp/jdZh9OXKL8/OyLe2MMCq3Naf9h
    n2e82J9C0frsKrkjjaUXvIJobrhHcMXO4T50SIqfAWLcD6VpkJWdOe0WgFgdr1JD
    6BrNygtrATzmpnBxkBv+v86X+99aGCc5OaSsNwwMwQBaTnZ+wK7OpU42iEmWK1Sw
    em2BsqF1cbgIjyZt8qlkd0cSHsU3eARWawxLRqCmnPzNeQCvuF1vGdtP7lSh+l33
    Vl/1qdzudI4pungyFhYY/4c/QYEnCvxfPMTArrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1522222377;
    bh=4dnPmNefiHvdfKN2SYWYNxS7OjcIzPROfuqRLYbzNw8=; b=NsSSUzqoR+8W
    D3CPLukUxgFC4TOUd2bg4Y6DTasYXQ8NxNqRS8c25JPsEVg1Pjfl8y71Id6PvLgJ
    Xs3AqJqJwsRaRysSUj5utvF4RbwtpWVU5gra0sjOfm2kq3zzo+VhgeEO6ycUfdNg
    ESIRwSIXNBmICEDZUOP4adgBHv3S7kN1zzf95RCVznZx9BlblBJAlKTgIF76Gwww
    VrKBWP3UlmuJVYj3TxL2RyKmHP1AhP4aXqBI3kJZDM2AczwN4HdM5ekYBhJZmSIF
    1g47tLIjsF6LK0Op8yzsthW0Q2E7U90l0y1zQS+PGruTuEmoH3pprEIRMVdcRFYl
    pJPcYiR/tg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rxWS/8PL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
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
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=rxWS/8PL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2fhIF8bhhKWbiosZuL4x4yl/kY75UA87Aper2S8QGz9URH1oOxWrxdZQuLzRDdDn6qHdv6WS2cIIjLE28trMh8N40bfQ8k6gTRWCLA09rTLK9qo/W5
    xSMfIDC16tuhV5D7tXzjkiOoYLXh+vdzFjde6FoRu3baqpQfU+OlAvdxH+91/TmyNJmUexLB9EaUnlHgtGH8OsovhbI8q9tHp+782o2oi4C+FkPryAefNA3u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=Bt-OzgS1u0sNeZ1bWukA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbeC1Hce (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 03:32:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeC1HbA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Mar 2018 03:31:00 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] crypto: af_alg: convert to ->poll_mask
Date: Wed, 28 Mar 2018 09:29:22 +0200
Message-Id: <20180328072926.17131-27-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180328072926.17131-1-hch@lst.de>
References: <20180328072926.17131-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 crypto/af_alg.c         | 13 +++----------
 crypto/algif_aead.c     |  4 ++--
 crypto/algif_skcipher.c |  4 ++--
 include/crypto/if_alg.h |  3 +--
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 50d75de539f5..330aef1cd08b 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1060,19 +1060,12 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 }
 EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
-/**
- * af_alg_poll - poll system call handler
- */
-__poll_t af_alg_poll(struct file *file, struct socket *sock,
-			 poll_table *wait)
+__poll_t af_alg_poll_mask(struct socket *sock, __poll_t events)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct af_alg_ctx *ctx = ask->private;
-	__poll_t mask;
-
-	sock_poll_wait(file, sk_sleep(sk), wait);
-	mask = 0;
+	__poll_t mask = 0;
 
 	if (!ctx->more || ctx->used)
 		mask |= EPOLLIN | EPOLLRDNORM;
@@ -1082,7 +1075,7 @@ __poll_t af_alg_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
-EXPORT_SYMBOL_GPL(af_alg_poll);
+EXPORT_SYMBOL_GPL(af_alg_poll_mask);
 
 /**
  * af_alg_alloc_areq - allocate struct af_alg_async_req
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index 4b07edd5a9ff..330cf9f2b767 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -375,7 +375,7 @@ static struct proto_ops algif_aead_ops = {
 	.sendmsg	=	aead_sendmsg,
 	.sendpage	=	af_alg_sendpage,
 	.recvmsg	=	aead_recvmsg,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static int aead_check_key(struct socket *sock)
@@ -471,7 +471,7 @@ static struct proto_ops algif_aead_ops_nokey = {
 	.sendmsg	=	aead_sendmsg_nokey,
 	.sendpage	=	aead_sendpage_nokey,
 	.recvmsg	=	aead_recvmsg_nokey,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static void *aead_bind(const char *name, u32 type, u32 mask)
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index c4e885df4564..15cf3c5222e0 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -205,7 +205,7 @@ static struct proto_ops algif_skcipher_ops = {
 	.sendmsg	=	skcipher_sendmsg,
 	.sendpage	=	af_alg_sendpage,
 	.recvmsg	=	skcipher_recvmsg,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static int skcipher_check_key(struct socket *sock)
@@ -301,7 +301,7 @@ static struct proto_ops algif_skcipher_ops_nokey = {
 	.sendmsg	=	skcipher_sendmsg_nokey,
 	.sendpage	=	skcipher_sendpage_nokey,
 	.recvmsg	=	skcipher_recvmsg_nokey,
-	.poll		=	af_alg_poll,
+	.poll_mask	=	af_alg_poll_mask,
 };
 
 static void *skcipher_bind(const char *name, u32 type, u32 mask)
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 482461d8931d..cc414db9da0a 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -245,8 +245,7 @@ ssize_t af_alg_sendpage(struct socket *sock, struct page *page,
 			int offset, size_t size, int flags);
 void af_alg_free_resources(struct af_alg_async_req *areq);
 void af_alg_async_cb(struct crypto_async_request *_req, int err);
-__poll_t af_alg_poll(struct file *file, struct socket *sock,
-			 poll_table *wait);
+__poll_t af_alg_poll_mask(struct socket *sock, __poll_t events);
 struct af_alg_async_req *af_alg_alloc_areq(struct sock *sk,
 					   unsigned int areqlen);
 int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
-- 
2.14.2

