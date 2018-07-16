Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6944AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A32089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXlkVtvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4A32089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeGPRsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:48:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45315 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:48:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id z14-v6so1477591pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vnACoDNnNygQvcyj6ioYnCfcBtKnNbDb0QgZcL3FLnU=;
        b=RXlkVtvBHJNM2PtI9Y2jfUw6l8nCJmgMXzNMwRymSbZHRX32Pfb/XVG/69U09CuJrY
         689UzKQ25vobM9TI4+mczsNMX3elLqzWH3GLwfmdkwJ60X0TAC3VwMYcc5vlmNwkAMJD
         8DuMjVfJdyvnBq4QmM961frkxRuOEvkUbv4jPtfWfmm5d3OZA8gveHynCCFK684qMiC8
         2TqBgCErLR/eQYGKAoAv2kAwyfckFdsd9bangZdO/FdN7TxU14kyZ0CeXEKKZyh7esA2
         IcT5zY4rIe9mRjuI07B9c1QbigpT8TuhAXiuXEn9DIxLkvCEEAPgDIrYNBjebXLi3Z6y
         ZK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnACoDNnNygQvcyj6ioYnCfcBtKnNbDb0QgZcL3FLnU=;
        b=PT2fU0AdHq/LuIkTDsD9bOSB8bpzRwxuiOCMTEJVrxFIsBnS28L106DmBSS6wLva1I
         r5YdduBl23MPMJejalxvO+AxIYumfb3E4+9JqVq504aCPdSrocKAxq5msLPbbBd8qgJz
         egxyiCdhzWad419BANXXSX9q+/tJvfoUFe1N46vbSkMDCwJauXk0tusdwXv14XEsskQC
         fq/1v2gX4S9OyLWKBEfYlu0Qsa3z9pDmiMkSOo0mNe/lgzTKZlraHd9eJmGtcbK/WfQu
         9alrBaCfweM9++ajmbYHugLDZK8J888eXROHyTdwWFu+2JxQw9Im1IjkXY2VSKuLilTZ
         F3rw==
X-Gm-Message-State: AOUpUlFSR3c/miNiEzNUoceoqc5/gPZBS5RexICdQXvcGrPTn8Ddnv3W
        vvTh5FXgpCRoRgV1x042byz7ew==
X-Google-Smtp-Source: AAOMgpfA1kcNSykN4KxrXMM4ApM+N4vuRuooGxbQF5OfLgVWXu+6nQdfQRTyFJVNhgB/As6srNyEmA==
X-Received: by 2002:a62:c8c2:: with SMTP id i63-v6mr19033313pfk.73.1531761584824;
        Mon, 16 Jul 2018 10:19:44 -0700 (PDT)
Received: from google.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id g25-v6sm50599189pge.52.2018.07.16.10.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:19:44 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:19:42 -0700
From:   Eric Biggers <ebiggers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm crypt: Convert essiv from ahash to shash
Message-ID: <20180716171942.GA77258@google.com>
References: <20180716035912.GA32261@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716035912.GA32261@beast>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 08:59:12PM -0700, Kees Cook wrote:
> In preparing to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
> to direct shash. The stack allocation will be made a fixed size in a
> later patch to the crypto subsystem.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Eric Biggers <ebiggers@google.com>

> ---
>  drivers/md/dm-crypt.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index b61b069c33af..c4c922990090 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -99,7 +99,7 @@ struct crypt_iv_operations {
>  };
>  
>  struct iv_essiv_private {
> -	struct crypto_ahash *hash_tfm;
> +	struct crypto_shash *hash_tfm;
>  	u8 *salt;
>  };
>  
> @@ -327,25 +327,22 @@ static int crypt_iv_plain64be_gen(struct crypt_config *cc, u8 *iv,
>  static int crypt_iv_essiv_init(struct crypt_config *cc)
>  {
>  	struct iv_essiv_private *essiv = &cc->iv_gen_private.essiv;
> -	AHASH_REQUEST_ON_STACK(req, essiv->hash_tfm);
> -	struct scatterlist sg;
> +	SHASH_DESC_ON_STACK(desc, essiv->hash_tfm);
>  	struct crypto_cipher *essiv_tfm;
>  	int err;
>  
> -	sg_init_one(&sg, cc->key, cc->key_size);
> -	ahash_request_set_tfm(req, essiv->hash_tfm);
> -	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
> -	ahash_request_set_crypt(req, &sg, essiv->salt, cc->key_size);
> +	desc->tfm = essiv->hash_tfm;
> +	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
>  
> -	err = crypto_ahash_digest(req);
> -	ahash_request_zero(req);
> +	err = crypto_shash_digest(desc, cc->key, cc->key_size, essiv->salt);
> +	shash_desc_zero(desc);
>  	if (err)
>  		return err;
>  
>  	essiv_tfm = cc->iv_private;
>  
>  	err = crypto_cipher_setkey(essiv_tfm, essiv->salt,
> -			    crypto_ahash_digestsize(essiv->hash_tfm));
> +			    crypto_shash_digestsize(essiv->hash_tfm));
>  	if (err)
>  		return err;
>  
> @@ -356,7 +353,7 @@ static int crypt_iv_essiv_init(struct crypt_config *cc)
>  static int crypt_iv_essiv_wipe(struct crypt_config *cc)
>  {
>  	struct iv_essiv_private *essiv = &cc->iv_gen_private.essiv;
> -	unsigned salt_size = crypto_ahash_digestsize(essiv->hash_tfm);
> +	unsigned salt_size = crypto_shash_digestsize(essiv->hash_tfm);
>  	struct crypto_cipher *essiv_tfm;
>  	int r, err = 0;
>  
> @@ -408,7 +405,7 @@ static void crypt_iv_essiv_dtr(struct crypt_config *cc)
>  	struct crypto_cipher *essiv_tfm;
>  	struct iv_essiv_private *essiv = &cc->iv_gen_private.essiv;
>  
> -	crypto_free_ahash(essiv->hash_tfm);
> +	crypto_free_shash(essiv->hash_tfm);
>  	essiv->hash_tfm = NULL;
>  
>  	kzfree(essiv->salt);
> @@ -426,7 +423,7 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
>  			      const char *opts)
>  {
>  	struct crypto_cipher *essiv_tfm = NULL;
> -	struct crypto_ahash *hash_tfm = NULL;
> +	struct crypto_shash *hash_tfm = NULL;
>  	u8 *salt = NULL;
>  	int err;
>  
> @@ -436,14 +433,14 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
>  	}
>  
>  	/* Allocate hash algorithm */
> -	hash_tfm = crypto_alloc_ahash(opts, 0, CRYPTO_ALG_ASYNC);
> +	hash_tfm = crypto_alloc_shash(opts, 0, 0);
>  	if (IS_ERR(hash_tfm)) {
>  		ti->error = "Error initializing ESSIV hash";
>  		err = PTR_ERR(hash_tfm);
>  		goto bad;
>  	}
>  
> -	salt = kzalloc(crypto_ahash_digestsize(hash_tfm), GFP_KERNEL);
> +	salt = kzalloc(crypto_shash_digestsize(hash_tfm), GFP_KERNEL);
>  	if (!salt) {
>  		ti->error = "Error kmallocing salt storage in ESSIV";
>  		err = -ENOMEM;
> @@ -454,7 +451,7 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
>  	cc->iv_gen_private.essiv.hash_tfm = hash_tfm;
>  
>  	essiv_tfm = alloc_essiv_cipher(cc, ti, salt,
> -				       crypto_ahash_digestsize(hash_tfm));
> +				       crypto_shash_digestsize(hash_tfm));
>  	if (IS_ERR(essiv_tfm)) {
>  		crypt_iv_essiv_dtr(cc);
>  		return PTR_ERR(essiv_tfm);
> @@ -465,7 +462,7 @@ static int crypt_iv_essiv_ctr(struct crypt_config *cc, struct dm_target *ti,
>  
>  bad:
>  	if (hash_tfm && !IS_ERR(hash_tfm))
> -		crypto_free_ahash(hash_tfm);
> +		crypto_free_shash(hash_tfm);
>  	kfree(salt);
>  	return err;
>  }
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security
