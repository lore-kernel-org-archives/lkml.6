Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591736-2-10683577027566908632
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591735; b=vMUfF8/pzwW6OICaS/YHNP0v6aL8mcuJYVTjdt1U7V+bLx9
    6+SjsnSkUYkca+Ezy+/Stla2cyyZgAHMQsHOx3jfSAU/SFQhQTs2JL4BtpqmOQY4
    5Kty51e3YETBeJwicvJhxauMHNlADr+q0HHcrfxas8ck5/PEZ98NAN6kZqD8OsAJ
    h4WzDpFVXEVamwUReAyjD+kyVzPCN3wijp1IYOOrH44NLXCKZO51YV2OXgghKH9Z
    2naiZ9yEmmO/SsZ18oxxIRhW+BmMvujAq7cSDw3WGTaXzmEdyVcciDqkLRdVAOjm
    n2b+CuIesKZcy22txLkuReH0qlW2vO6c6oB3v/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591735; bh=THuDu26TewrfWo9saIPJHXVk5I
    NmD2CHHhPg46Hiejg=; b=DYzuAXZb7LfMjiL+3c8hoGlWNm2J86QfOXogw2LeXt
    8w7J+aIi60FcI/6Kpp5xaijNaXiVz/Fq7Ywft/eR2qM4Jso1+680eoXFKo9oimSm
    yE2eeltVoGktgzO/h8qIGNsj9Wly6OVB+UGk8IyAGfTuQOmdrfgJTn61GpvvWiP7
    0/4GvVwto9Bn5qdikyDPkGuP4UJWxZ5kIDGC/fbziLYJZZnO5KXFYCCmOSpIo893
    PaX11eW40MJUXdWULTPKNtwzzr7LcUIWDnQtYvheO5590ZGWp/Ijy8tPMXHciFCv
    uGGaXOrFbs1GHshLJGOG8pKWecXfuwY8SWrEgJGR/x3w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbeBBRPb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:15:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753732AbeBBRPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:15:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Lesokhin <ilyal@mellanox.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 09/55] crypto: aesni - add wrapper for generic gcm(aes)
Date: Fri,  2 Feb 2018 17:58:27 +0100
Message-Id: <20180202140826.836479426@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

commit fc8517bf627c9b834f80274a1bc9ecd39b27231b upstream.

When I added generic-gcm-aes I didn't add a wrapper like the one
provided for rfc4106(gcm(aes)). We need to add a cryptd wrapper to fall
back on in case the FPU is not available, otherwise we might corrupt the
FPU state.

Fixes: cce2ea8d90fe ("crypto: aesni - add generic gcm(aes)")
Reported-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |   66 ++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 12 deletions(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -690,8 +690,8 @@ static int common_rfc4106_set_key(struct
 	       rfc4106_set_hash_subkey(ctx->hash_subkey, key, key_len);
 }
 
-static int rfc4106_set_key(struct crypto_aead *parent, const u8 *key,
-			   unsigned int key_len)
+static int gcmaes_wrapper_set_key(struct crypto_aead *parent, const u8 *key,
+				  unsigned int key_len)
 {
 	struct cryptd_aead **ctx = crypto_aead_ctx(parent);
 	struct cryptd_aead *cryptd_tfm = *ctx;
@@ -716,8 +716,8 @@ static int common_rfc4106_set_authsize(s
 
 /* This is the Integrity Check Value (aka the authentication tag length and can
  * be 8, 12 or 16 bytes long. */
-static int rfc4106_set_authsize(struct crypto_aead *parent,
-				unsigned int authsize)
+static int gcmaes_wrapper_set_authsize(struct crypto_aead *parent,
+				       unsigned int authsize)
 {
 	struct cryptd_aead **ctx = crypto_aead_ctx(parent);
 	struct cryptd_aead *cryptd_tfm = *ctx;
@@ -929,7 +929,7 @@ static int helper_rfc4106_decrypt(struct
 			      aes_ctx);
 }
 
-static int rfc4106_encrypt(struct aead_request *req)
+static int gcmaes_wrapper_encrypt(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cryptd_aead **ctx = crypto_aead_ctx(tfm);
@@ -945,7 +945,7 @@ static int rfc4106_encrypt(struct aead_r
 	return crypto_aead_encrypt(req);
 }
 
-static int rfc4106_decrypt(struct aead_request *req)
+static int gcmaes_wrapper_decrypt(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cryptd_aead **ctx = crypto_aead_ctx(tfm);
@@ -1128,6 +1128,30 @@ static int generic_gcmaes_decrypt(struct
 			      aes_ctx);
 }
 
+static int generic_gcmaes_init(struct crypto_aead *aead)
+{
+	struct cryptd_aead *cryptd_tfm;
+	struct cryptd_aead **ctx = crypto_aead_ctx(aead);
+
+	cryptd_tfm = cryptd_alloc_aead("__driver-generic-gcm-aes-aesni",
+				       CRYPTO_ALG_INTERNAL,
+				       CRYPTO_ALG_INTERNAL);
+	if (IS_ERR(cryptd_tfm))
+		return PTR_ERR(cryptd_tfm);
+
+	*ctx = cryptd_tfm;
+	crypto_aead_set_reqsize(aead, crypto_aead_reqsize(&cryptd_tfm->base));
+
+	return 0;
+}
+
+static void generic_gcmaes_exit(struct crypto_aead *aead)
+{
+	struct cryptd_aead **ctx = crypto_aead_ctx(aead);
+
+	cryptd_free_aead(*ctx);
+}
+
 static struct aead_alg aesni_aead_algs[] = { {
 	.setkey			= common_rfc4106_set_key,
 	.setauthsize		= common_rfc4106_set_authsize,
@@ -1147,10 +1171,10 @@ static struct aead_alg aesni_aead_algs[]
 }, {
 	.init			= rfc4106_init,
 	.exit			= rfc4106_exit,
-	.setkey			= rfc4106_set_key,
-	.setauthsize		= rfc4106_set_authsize,
-	.encrypt		= rfc4106_encrypt,
-	.decrypt		= rfc4106_decrypt,
+	.setkey			= gcmaes_wrapper_set_key,
+	.setauthsize		= gcmaes_wrapper_set_authsize,
+	.encrypt		= gcmaes_wrapper_encrypt,
+	.decrypt		= gcmaes_wrapper_decrypt,
 	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
@@ -1170,13 +1194,31 @@ static struct aead_alg aesni_aead_algs[]
 	.ivsize			= GCM_AES_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
+		.cra_name		= "__generic-gcm-aes-aesni",
+		.cra_driver_name	= "__driver-generic-gcm-aes-aesni",
+		.cra_priority		= 0,
+		.cra_flags		= CRYPTO_ALG_INTERNAL,
+		.cra_blocksize		= 1,
+		.cra_ctxsize		= sizeof(struct generic_gcmaes_ctx),
+		.cra_alignmask		= AESNI_ALIGN - 1,
+		.cra_module		= THIS_MODULE,
+	},
+}, {
+	.init			= generic_gcmaes_init,
+	.exit			= generic_gcmaes_exit,
+	.setkey			= gcmaes_wrapper_set_key,
+	.setauthsize		= gcmaes_wrapper_set_authsize,
+	.encrypt		= gcmaes_wrapper_encrypt,
+	.decrypt		= gcmaes_wrapper_decrypt,
+	.ivsize			= GCM_AES_IV_SIZE,
+	.maxauthsize		= 16,
+	.base = {
 		.cra_name		= "gcm(aes)",
 		.cra_driver_name	= "generic-gcm-aesni",
 		.cra_priority		= 400,
 		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_blocksize		= 1,
-		.cra_ctxsize		= sizeof(struct generic_gcmaes_ctx),
-		.cra_alignmask		= AESNI_ALIGN - 1,
+		.cra_ctxsize		= sizeof(struct cryptd_aead *),
 		.cra_module		= THIS_MODULE,
 	},
 } };
