Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684081-1520285469-2-6320591836101371355
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
    t=1520285469; b=nlvBp0j39cCJ+wvVvQPoDXg8h/Vn76F2iq86Ep5OBvNuN4k
    gtOP6/54E3bFlJhIV+hOKt063Q5FluFjLy1jNmWCJkU11qoAFj/AdxW/tDLKFIWM
    MLQPmz2MEiImbT9oqCAvon/ENTVIRixTwkNbC6h7jQjFvE6KqylFiIcbsiclVgVo
    JUnG7+tY3rrAapWhnnlsmkzpfWZt2yqiyjt5m5El8LUNPK6jdy31+Cac4i9j/VrL
    snDLhAwHk62mszqP0K/7VshFGmNbFt7KlDaAhW1v9hd8tSP3hlr6xXXWMss8kOd9
    Keipqocc6VAm0/BahKN8abl25oQ314Nu8tvI/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520285469;
    bh=4dnPmNefiHvdfKN2SYWYNxS7OjcIzPROfuqRLYbzNw8=; b=tZmRKohNP1lO
    EFAsVSs297QAH5qyBVmnuoRln5EatsZ1G7BJMTMw9Xtjqrhiu78wPC6JUF6cmZ6E
    ZyJWPg12tnxMYqv7OEjEk9XKBcpTMKZDd1gpQcVxF2IbfDhalIp+m9RAWbfqJMAw
    EoqeEr/+xzKA4udmBSqaEX/fIgUFycc/3wEdo3rBArbZlGczjQJcNvYWOG2hPyAx
    hdVavu/rL+VBrDfz5xZdsQDO2GSGEpqYzbIvbYmGdZYr1p7o2zENdiWwphysFpUr
    7Awj1SHCAC+WNIcT3TeWObih4BIXMr3ovGzgBwt5HyBwTlrBIGOuUkUGcRqplT04
    jcGGGDFlYQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=qgqTpdNG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=qgqTpdNG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbeCEV3p (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:29:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeCEV2A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:28:00 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/36] crypto: af_alg: convert to ->poll_mask
Date: Mon,  5 Mar 2018 13:27:39 -0800
Message-Id: <20180305212743.16664-33-hch@lst.de>
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

