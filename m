Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720032-2-15617806233844317152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720032; b=ua1PhL/Pd/H+uEW7mW5LId7mBg36R5kKtpVYb1PEQsRm9Oo
    Bn2oQ9VdnAGSldrdKWBg8RkEl8r1lba2oGkkKae2ThFwgBwK6EopgnzEx/SUxsq5
    xqXSOWRrwlX2l5hMfXLmrDnRejWmxX2lz2ZzNkyjd0AauOgV8Awll82emCWP38wB
    7LVYMuQY8HJeZpQ9QfoiR58AlejbYu6xQS+db896ZuOIjMAs+x/ighOjfY276a8r
    R5TtBdzJ3xL3cdwuC29Eq5OqSPom4Xdr9psyYmx/EvZrNKi1/IvyH6kCK2VpXVLp
    wdlH/7Ff88vh0NBnX+g2UN4LALD7Bb/Qch75U0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720032; bh=WF+r7Mwj6dz4+/ow6MOnavPkl7
    uZOWV7ReU5lS4hIc8=; b=kV5B+24A8rJfEkGz5mA37K5hwOhmKJotUYdVFlecEq
    ae7GvNRJws7AqnvB8LGOybORYBrbpDuxnlsQ+4OZmE6e52JNJDlKCYo/+AsEgKtE
    niyOomSnE0QNJHPzLCW8Hr/CGNbpgrnJxAZuCR96d3vkzW3R6fFpJGQMaWVjBWfE
    Q0Iv1gTL8Wt7qFquCqPJT/15GxW8cefx3SknVCGaGVwB/WUWyUx91TvXK3pFqmWY
    TwI+081VsvkWbEmYnaOfGPTtX4aRKnNPT4TBeqDehsMe5TlXD2tiEXP9d2slpQT7
    Z6mmBS8dDEq5ckHqUbEIe6z+SSmj4oFfW19d50+kO+vQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162756AbeBOPXs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162736AbeBOPXq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 069/108] crypto: poly1305 - remove ->setkey() method
Date: Thu, 15 Feb 2018 16:17:06 +0100
Message-Id: <20180215151232.012311293@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit a16e772e664b9a261424107784804cffc8894977 upstream.

Since Poly1305 requires a nonce per invocation, the Linux kernel
implementations of Poly1305 don't use the crypto API's keying mechanism
and instead expect the key and nonce as the first 32 bytes of the data.
But ->setkey() is still defined as a stub returning an error code.  This
prevents Poly1305 from being used through AF_ALG and will also break it
completely once we start enforcing that all crypto API users (not just
AF_ALG) call ->setkey() if present.

Fix it by removing crypto_poly1305_setkey(), leaving ->setkey as NULL.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/poly1305_glue.c |    1 -
 crypto/poly1305_generic.c       |   17 +++++------------
 include/crypto/poly1305.h       |    2 --
 3 files changed, 5 insertions(+), 15 deletions(-)

--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -164,7 +164,6 @@ static struct shash_alg alg = {
 	.init		= poly1305_simd_init,
 	.update		= poly1305_simd_update,
 	.final		= crypto_poly1305_final,
-	.setkey		= crypto_poly1305_setkey,
 	.descsize	= sizeof(struct poly1305_simd_desc_ctx),
 	.base		= {
 		.cra_name		= "poly1305",
--- a/crypto/poly1305_generic.c
+++ b/crypto/poly1305_generic.c
@@ -51,17 +51,6 @@ int crypto_poly1305_init(struct shash_de
 }
 EXPORT_SYMBOL_GPL(crypto_poly1305_init);
 
-int crypto_poly1305_setkey(struct crypto_shash *tfm,
-			   const u8 *key, unsigned int keylen)
-{
-	/* Poly1305 requires a unique key for each tag, which implies that
-	 * we can't set it on the tfm that gets accessed by multiple users
-	 * simultaneously. Instead we expect the key as the first 32 bytes in
-	 * the update() call. */
-	return -ENOTSUPP;
-}
-EXPORT_SYMBOL_GPL(crypto_poly1305_setkey);
-
 static void poly1305_setrkey(struct poly1305_desc_ctx *dctx, const u8 *key)
 {
 	/* r &= 0xffffffc0ffffffc0ffffffc0fffffff */
@@ -80,6 +69,11 @@ static void poly1305_setskey(struct poly
 	dctx->s[3] = le32_to_cpuvp(key + 12);
 }
 
+/*
+ * Poly1305 requires a unique key for each tag, which implies that we can't set
+ * it on the tfm that gets accessed by multiple users simultaneously. Instead we
+ * expect the key as the first 32 bytes in the update() call.
+ */
 unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
 					const u8 *src, unsigned int srclen)
 {
@@ -285,7 +279,6 @@ static struct shash_alg poly1305_alg = {
 	.init		= crypto_poly1305_init,
 	.update		= crypto_poly1305_update,
 	.final		= crypto_poly1305_final,
-	.setkey		= crypto_poly1305_setkey,
 	.descsize	= sizeof(struct poly1305_desc_ctx),
 	.base		= {
 		.cra_name		= "poly1305",
--- a/include/crypto/poly1305.h
+++ b/include/crypto/poly1305.h
@@ -30,8 +30,6 @@ struct poly1305_desc_ctx {
 };
 
 int crypto_poly1305_init(struct shash_desc *desc);
-int crypto_poly1305_setkey(struct crypto_shash *tfm,
-			   const u8 *key, unsigned int keylen);
 unsigned int crypto_poly1305_setdesckey(struct poly1305_desc_ctx *dctx,
 					const u8 *src, unsigned int srclen);
 int crypto_poly1305_update(struct shash_desc *desc,
