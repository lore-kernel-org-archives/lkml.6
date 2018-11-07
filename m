Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE3C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357032081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PZH5zIPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357032081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeKHFGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:06:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54805 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeKHFGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:06:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so15275940wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZfLxDfzKBQQkZT9NNt5WaCOgbU4iDEm4eraw377ahG0=;
        b=PZH5zIPwKQPXTfgHGcTo9EppmymEcbBaeprtXzeZuDxI/B2NOo5fxmmVHZp6WTbKdf
         SwFCXRNiIdqEnjawHbRtuAtOOtN5FXikDtjquKbOzqS6vF2RPLGoVFO+Y9HPjk0agBWa
         WJF8P8o0UL8tCS/12cbgEMC+FIaphPta4o24iySIAfm5fRNkFQYt3lna2IJgE1cJMBD/
         eQXwPDFPjhXcX4vU09k0gpPdZ1Claoxw+mY7o/cgPrABPSftttjKWPPoICjmYAkS1Ehk
         4CBdu/dT14o3XdlTgbOZodcf6gaydRaFK6rNDIdOp803Obic/3kJgWu5RgU2h1PYoQT3
         fqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfLxDfzKBQQkZT9NNt5WaCOgbU4iDEm4eraw377ahG0=;
        b=Q5eL6KaWqfRLPyBjvvoqd8GLlmi1i2iectTpd9A1GX5cWX/VqRuOEgKSQZ19pqIgwK
         Eipy+1cfWDrd7pJHYqY0nsomK48Q2V+sJ94Vlgv0z3fzT9OoJGVRKwq9At8myXgpPkIo
         pRkcNiqaQ51wksF+Z1vxh/vjTY0JTnlvygAxfzz6ac3XSePrHvx8/ZfQaf0a/9/UUcpu
         IY8L4e17XQSHCfWYo5eTrU1MwQxw3fWBhoLVDcKpC0YxFYhSeebijUi9hLz7iady+vqB
         KYKqEP6cxSQGcS5NGVWkcOCajVtPxEIQBKqeLwOUaJvMpQyvqHVUZ399X6oSz6mTEMPO
         ysTg==
X-Gm-Message-State: AGRZ1gKFY++ZyzpthlNQgX389XvxViKE2QPzqsEimH96FVOLsZn+/W5t
        +LZ54sVXIRbBC7/RP4rEThci0w==
X-Google-Smtp-Source: AJdET5eQ89fJuUz7rScIS0nXeMImoB2BsuS/oZMoC/8A+ertROkxEU1fXvFSoONF2CyVuv2kwocYHA==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr1292881wmf.143.1541619271835;
        Wed, 07 Nov 2018 11:34:31 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g1-v6sm2589465wmg.2.2018.11.07.11.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:34:31 -0800 (PST)
Date:   Wed, 7 Nov 2018 20:34:28 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] crypto: crypto_user_stat: fix use_after_free of
 struct xxx_request
Message-ID: <20181107193428.GE5133@Red>
References: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
 <1541422274-40060-6-git-send-email-clabbe@baylibre.com>
 <20181106014905.GF28490@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106014905.GF28490@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:49:06PM -0800, Eric Biggers wrote:
> Hi Corentin,
> 
> On Mon, Nov 05, 2018 at 12:51:14PM +0000, Corentin Labbe wrote:
> > All crypto_stats functions use the struct xxx_request for feeding stats,
> > but in some case this structure could already be freed.
> > 
> > For fixing this, the needed parameters (len and alg) will be stored
> > before the request being executed.
> > Fixes: cac5818c25d0 ("crypto: user - Implement a generic crypto statistics")
> > Reported-by: syzbot <syzbot+6939a606a5305e9e9799@syzkaller.appspotmail.com>
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  crypto/ahash.c             | 14 ++++++++--
> >  include/crypto/acompress.h | 30 ++++++++++----------
> >  include/crypto/aead.h      | 30 ++++++++++----------
> >  include/crypto/akcipher.h  | 56 ++++++++++++++++++--------------------
> >  include/crypto/hash.h      | 25 +++++++++--------
> >  include/crypto/kpp.h       | 22 +++++++--------
> >  include/crypto/skcipher.h  | 16 +++++++----
> >  include/linux/crypto.h     | 34 +++++++++++------------
> >  8 files changed, 118 insertions(+), 109 deletions(-)
> > 
> > diff --git a/crypto/ahash.c b/crypto/ahash.c
> > index 3a348fbcf8f9..3f4c44c1e80f 100644
> > --- a/crypto/ahash.c
> > +++ b/crypto/ahash.c
> > @@ -364,20 +364,26 @@ static int crypto_ahash_op(struct ahash_request *req,
> >  
> >  int crypto_ahash_final(struct ahash_request *req)
> >  {
> > +	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
> > +	struct crypto_alg *alg = tfm->base.__crt_alg;
> > +	unsigned int nbytes = req->nbytes;
> >  	int ret;
> >  
> >  	ret = crypto_ahash_op(req, crypto_ahash_reqtfm(req)->final);
> > -	crypto_stat_ahash_final(req, ret);
> > +	crypto_stat_ahash_final(nbytes, ret, alg);
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(crypto_ahash_final);
> 
> I'm not confident this is enough.  If the request is being processed
> asynchronously, the completion callback could be used to signal another thread
> to go ahead and free the resources, including not only the request but also the
> 'tfm', which could even result in the last reference to the 'alg' being dropped
> and therefore the 'alg' being freed.  If I'm wrong, then please explain why :-)
> 
> Note: I'd also prefer a solution that is more obviously zero-overhead in the
> !CONFIG_CRYPTO_STATS case.
> 
> - Eric
> 

I think the best solution is to grab a crypto_alg refcnt before the operation and release it after.
So for example this will lead to:
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -486,7 +486,7 @@ static inline struct crypto_sync_skcipher *crypto_sync_skcipher_reqtfm(
 	return container_of(tfm, struct crypto_sync_skcipher, base);
 }
 
-static inline void crypto_stat_skcipher_encrypt(struct skcipher_request *req,
+static inline void crypto_stat_skcipher_encrypt(unsigned int cryptlen,
 						int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
@@ -494,12 +494,13 @@ static inline void crypto_stat_skcipher_encrypt(struct skcipher_request *req,
 		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
 		atomic64_inc(&alg->encrypt_cnt);
-		atomic64_add(req->cryptlen, &alg->encrypt_tlen);
+		atomic64_add(cryptlen, &alg->encrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
-static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
+static inline void crypto_stat_skcipher_decrypt(unsigned int cryptlen,
 						int ret, struct crypto_alg *alg)
 {
 #ifdef CONFIG_CRYPTO_STATS
@@ -507,8 +508,9 @@ static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
 		atomic64_inc(&alg->cipher_err_cnt);
 	} else {
 		atomic64_inc(&alg->decrypt_cnt);
-		atomic64_add(req->cryptlen, &alg->decrypt_tlen);
+		atomic64_add(cryptlen, &alg->decrypt_tlen);
 	}
+	crypto_alg_put(alg);
 #endif
 }
 
@@ -526,13 +528,18 @@ static inline void crypto_stat_skcipher_decrypt(struct skcipher_request *req,
 static inline int crypto_skcipher_encrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else
 		ret = tfm->encrypt(req);
-	crypto_stat_skcipher_encrypt(req, ret, tfm->base.__crt_alg);
+	crypto_stat_skcipher_encrypt(cryptlen, ret, alg);
 	return ret;
 }
 
@@ -550,13 +557,18 @@ static inline int crypto_skcipher_encrypt(struct skcipher_request *req)
 static inline int crypto_skcipher_decrypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct crypto_alg *alg = tfm->base.__crt_alg;
+	unsigned int cryptlen = req->cryptlen;
 	int ret;
 
+#ifdef CONFIG_CRYPTO_STATS
+	crypto_alg_get(alg);
+#endif
 	if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		ret = -ENOKEY;
 	else
 		ret = tfm->decrypt(req);
-	crypto_stat_skcipher_decrypt(req, ret, tfm->base.__crt_alg);
+	crypto_stat_skcipher_decrypt(cryptlen, ret, alg);
 	return ret;
 }

This should not have any overhead with !CONFIG_CRYPTO_STATS
The only drawback is that crypto_alg_get/crypto_alg_put need to be moved out of crypto/internal.h to include/linux/crypto.h

Herbert what do you think about that ?

Regards
