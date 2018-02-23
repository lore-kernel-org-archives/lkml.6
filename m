Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519416096-2-15345117051514808733
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519416095; b=aZOBnia91A98fxRa+U4VXK+kZH/YRPHs56UuYhBCftWJp9d
    xr/CVYVTpvl4xykHef9OF7ae+synFFgfjwYWW6U3CwqSjquDO3wjhvrWKZvknJzW
    tUz9omPjGbHdyRDtcYbbCxo8pJryLc1YdqGEz7ju1ZWwI1zJ+HdLuvouX94cW+R3
    0saN6ZHusfaGkDUK3IglEVCzs/7pbk1/5KDQFG0s2vM/RQRJgGLaLwsjD45Ylb6G
    E8b8QRqqWt4cFNBp3dhKJnZgtRLXbCiABCnMlyabouzCPVa8rDDbVT0L5wZ0ndw/
    nOOvyR4abEulmkzpK1QRmRqHZAhG5sHc6gJJkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416095; bh=MVMJXvx57OSagbNLLgESdvbS74
    3ndvBkEi47KVCI06o=; b=BfMLVKspu4F4nDp8jVWzaSpkoyC/tWOExOTEc1ocTd
    ZZnWM1STjX9M1I/e71owNmKdxj8Hjc3hAs1mkWIu9Et/iFLcT8htW5LlpStQ8aZ/
    eDwA7pUus2XBxFrRAn0Ykw29zyXTouFSXzkLIpsoJuR+hCNtclv84bC8g57fzeOk
    QCSf2u2ONMqEG7MCvPljWTq8dDks5q5E2Iu5lUBeeLQpCDp6019ndT6N+1Bc9fnS
    lJrej+4/hqt6lNFam53GJXVr/0Mg4SJAH1QLU3GE/D5z/a7boyrjbFNDgVO24Idg
    EG8WWbnCtrqk+rHEnF7S848tp566HRxy+r3xklozg+xA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933282AbeBWSnY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:43:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932961AbeBWSnX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 030/145] crypto: hash - annotate algorithms taking optional key
Date: Fri, 23 Feb 2018 19:25:36 +0100
Message-Id: <20180223170728.763018577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit a208fa8f33031b9e0aba44c7d1b7e68eb0cbd29e upstream.

We need to consistently enforce that keyed hashes cannot be used without
setting the key.  To do this we need a reliable way to determine whether
a given hash algorithm is keyed or not.  AF_ALG currently does this by
checking for the presence of a ->setkey() method.  However, this is
actually slightly broken because the CRC-32 algorithms implement
->setkey() but can also be used without a key.  (The CRC-32 "key" is not
actually a cryptographic key but rather represents the initial state.
If not overridden, then a default initial state is used.)

Prepare to fix this by introducing a flag CRYPTO_ALG_OPTIONAL_KEY which
indicates that the algorithm has a ->setkey() method, but it is not
required to be called.  Then set it on all the CRC-32 algorithms.

The same also applies to the Adler-32 implementation in Lustre.

Also, the cryptd and mcryptd templates have to pass through the flag
from their underlying algorithm.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/crypto/crc32-arm64.c                               |    2 ++
 arch/powerpc/crypto/crc32c-vpmsum_glue.c                      |    1 +
 arch/s390/crypto/crc32-vx.c                                   |    3 +++
 arch/sparc/crypto/crc32c_glue.c                               |    1 +
 arch/x86/crypto/crc32-pclmul_glue.c                           |    1 +
 arch/x86/crypto/crc32c-intel_glue.c                           |    1 +
 crypto/crc32_generic.c                                        |    1 +
 crypto/crc32c_generic.c                                       |    1 +
 crypto/cryptd.c                                               |    7 +++----
 crypto/mcryptd.c                                              |    7 +++----
 drivers/crypto/bfin_crc.c                                     |    3 ++-
 drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c |    1 +
 include/linux/crypto.h                                        |    6 ++++++
 13 files changed, 26 insertions(+), 9 deletions(-)

--- a/arch/arm64/crypto/crc32-arm64.c
+++ b/arch/arm64/crypto/crc32-arm64.c
@@ -232,6 +232,7 @@ static struct shash_alg crc32_alg = {
 		.cra_name		=	"crc32",
 		.cra_driver_name	=	"crc32-arm64-hw",
 		.cra_priority		=	300,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_alignmask		=	0,
 		.cra_ctxsize		=	sizeof(struct chksum_ctx),
@@ -253,6 +254,7 @@ static struct shash_alg crc32c_alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-arm64-hw",
 		.cra_priority		=	300,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_alignmask		=	0,
 		.cra_ctxsize		=	sizeof(struct chksum_ctx),
--- a/arch/powerpc/crypto/crc32c-vpmsum_glue.c
+++ b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
@@ -141,6 +141,7 @@ static struct shash_alg alg = {
 		.cra_name		= "crc32c",
 		.cra_driver_name	= "crc32c-vpmsum",
 		.cra_priority		= 200,
+		.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(u32),
 		.cra_module		= THIS_MODULE,
--- a/arch/s390/crypto/crc32-vx.c
+++ b/arch/s390/crypto/crc32-vx.c
@@ -238,6 +238,7 @@ static struct shash_alg crc32_vx_algs[]
 			.cra_name	 = "crc32",
 			.cra_driver_name = "crc32-vx",
 			.cra_priority	 = 200,
+			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize	 = CRC32_BLOCK_SIZE,
 			.cra_ctxsize	 = sizeof(struct crc_ctx),
 			.cra_module	 = THIS_MODULE,
@@ -258,6 +259,7 @@ static struct shash_alg crc32_vx_algs[]
 			.cra_name	 = "crc32be",
 			.cra_driver_name = "crc32be-vx",
 			.cra_priority	 = 200,
+			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize	 = CRC32_BLOCK_SIZE,
 			.cra_ctxsize	 = sizeof(struct crc_ctx),
 			.cra_module	 = THIS_MODULE,
@@ -278,6 +280,7 @@ static struct shash_alg crc32_vx_algs[]
 			.cra_name	 = "crc32c",
 			.cra_driver_name = "crc32c-vx",
 			.cra_priority	 = 200,
+			.cra_flags	 = CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize	 = CRC32_BLOCK_SIZE,
 			.cra_ctxsize	 = sizeof(struct crc_ctx),
 			.cra_module	 = THIS_MODULE,
--- a/arch/sparc/crypto/crc32c_glue.c
+++ b/arch/sparc/crypto/crc32c_glue.c
@@ -133,6 +133,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-sparc64",
 		.cra_priority		=	SPARC_CR_OPCODE_PRIORITY,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		=	sizeof(u32),
 		.cra_alignmask		=	7,
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -162,6 +162,7 @@ static struct shash_alg alg = {
 			.cra_name		= "crc32",
 			.cra_driver_name	= "crc32-pclmul",
 			.cra_priority		= 200,
+			.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 			.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 			.cra_ctxsize		= sizeof(u32),
 			.cra_module		= THIS_MODULE,
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -239,6 +239,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-intel",
 		.cra_priority		=	200,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		=	sizeof(u32),
 		.cra_module		=	THIS_MODULE,
--- a/crypto/crc32_generic.c
+++ b/crypto/crc32_generic.c
@@ -133,6 +133,7 @@ static struct shash_alg alg = {
 		.cra_name		= "crc32",
 		.cra_driver_name	= "crc32-generic",
 		.cra_priority		= 100,
+		.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(u32),
 		.cra_module		= THIS_MODULE,
--- a/crypto/crc32c_generic.c
+++ b/crypto/crc32c_generic.c
@@ -146,6 +146,7 @@ static struct shash_alg alg = {
 		.cra_name		=	"crc32c",
 		.cra_driver_name	=	"crc32c-generic",
 		.cra_priority		=	100,
+		.cra_flags		=	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=	CHKSUM_BLOCK_SIZE,
 		.cra_alignmask		=	3,
 		.cra_ctxsize		=	sizeof(struct chksum_ctx),
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -673,10 +673,9 @@ static int cryptd_create_hash(struct cry
 	if (err)
 		goto out_free_inst;
 
-	type = CRYPTO_ALG_ASYNC;
-	if (alg->cra_flags & CRYPTO_ALG_INTERNAL)
-		type |= CRYPTO_ALG_INTERNAL;
-	inst->alg.halg.base.cra_flags = type;
+	inst->alg.halg.base.cra_flags = CRYPTO_ALG_ASYNC |
+		(alg->cra_flags & (CRYPTO_ALG_INTERNAL |
+				   CRYPTO_ALG_OPTIONAL_KEY));
 
 	inst->alg.halg.digestsize = salg->digestsize;
 	inst->alg.halg.statesize = salg->statesize;
--- a/crypto/mcryptd.c
+++ b/crypto/mcryptd.c
@@ -516,10 +516,9 @@ static int mcryptd_create_hash(struct cr
 	if (err)
 		goto out_free_inst;
 
-	type = CRYPTO_ALG_ASYNC;
-	if (alg->cra_flags & CRYPTO_ALG_INTERNAL)
-		type |= CRYPTO_ALG_INTERNAL;
-	inst->alg.halg.base.cra_flags = type;
+	inst->alg.halg.base.cra_flags = CRYPTO_ALG_ASYNC |
+		(alg->cra_flags & (CRYPTO_ALG_INTERNAL |
+				   CRYPTO_ALG_OPTIONAL_KEY));
 
 	inst->alg.halg.digestsize = halg->digestsize;
 	inst->alg.halg.statesize = halg->statesize;
--- a/drivers/crypto/bfin_crc.c
+++ b/drivers/crypto/bfin_crc.c
@@ -494,7 +494,8 @@ static struct ahash_alg algs = {
 		.cra_driver_name	= DRIVER_NAME,
 		.cra_priority		= 100,
 		.cra_flags		= CRYPTO_ALG_TYPE_AHASH |
-						CRYPTO_ALG_ASYNC,
+						CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(struct bfin_crypto_crc_ctx),
 		.cra_alignmask		= 3,
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c
@@ -119,6 +119,7 @@ static struct shash_alg alg = {
 		.cra_name		= "adler32",
 		.cra_driver_name	= "adler32-zlib",
 		.cra_priority		= 100,
+		.cra_flags		= CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		= CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		= sizeof(u32),
 		.cra_module		= THIS_MODULE,
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -103,6 +103,12 @@
 #define CRYPTO_ALG_INTERNAL		0x00002000
 
 /*
+ * Set if the algorithm has a ->setkey() method but can be used without
+ * calling it first, i.e. there is a default key.
+ */
+#define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
+
+/*
  * Transform masks and values (for crt_flags).
  */
 #define CRYPTO_TFM_REQ_MASK		0x000fff00
