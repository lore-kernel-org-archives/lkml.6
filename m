Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE602C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6906120837
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6U88aTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6906120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeFTX50 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:57:26 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42249 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeFTX5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:57:24 -0400
Received: by mail-pl0-f67.google.com with SMTP id w17-v6so614692pll.9;
        Wed, 20 Jun 2018 16:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YqVKDtVCRXmpHkv7QpkrLqqjW5PYt59ThNmzt4bKaT0=;
        b=H6U88aTM+h8ea5tYZLyxVKGvfUU6uTRrVxcaIcPAANtquSROv3KJTv30A3EcN+nWi8
         8joQ9yp//pNMlUIraHZBzzGpOkvFDw5wjv04hgx2V6GarMvVj1vRYb6r1yD85vobi+Pl
         uD2i+xiXO8nfZywbYiJZOzv/WnRaiISIjKQEnFCtLQpIjt08U3/r24nAbGaBPueLtLkB
         IlIx6I0IhaF+ykv5uFZTBQIMvqfcHVFX5Nc3QErFRWcP8n0dwIyoUP2Dqp6WZgz29CV3
         SHI71WuxwtkfMYtzSDn36JSKCD+Bz611f5Cuqao/ckPnzlIEd+yPLWeo5srWJ0kVRgFg
         zPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YqVKDtVCRXmpHkv7QpkrLqqjW5PYt59ThNmzt4bKaT0=;
        b=IlGeViMSH4hodOMLst2EhtaDSIpN/coRDCm2XvjBssMtGuKBSZyBOvTLNQ6V1KL2KV
         t8sB7ncgC6u2wjPzNueyJZfJStLoyO+INAoUc5lcMKw2NfOgoUUKomt0DmBnne0RwBOh
         A/I1zatgGDcDK8RA6SXAh0QDAyUjcmwVfzKlmIRIV+g8bTFknYi0DeovomI9Pznm+cBE
         uV14Uw4sStLezEqwWgOm1DeZY5v7fRqR5LTKxXkReRUBH6oWlP/2WJDYrpeKm6LyvtrN
         DZ0P12T8P+wgvwqu/Lg4qL7PUTT6p/xF+g9SCAqkM12wqO1eg3KNszxrJP+BKwGCk4Yl
         3VqQ==
X-Gm-Message-State: APt69E27q3+30bzHJ+OYxxe3qWUG2ZRNLTCvL0Hkr6KMV+KJyFjcNgls
        mHVb4GZjdJ6rCIkXdSgQyYg=
X-Google-Smtp-Source: ADUXVKLdGCCu4u+39JJrc8fwTpOYICkZjRANIYieI5w6n0B9gsWQt8Bkx9dJ2tvvSI/h6eXNQSiCfA==
X-Received: by 2002:a17:902:654c:: with SMTP id d12-v6mr25721865pln.8.1529539043503;
        Wed, 20 Jun 2018 16:57:23 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id f16-v6sm8478146pff.57.2018.06.20.16.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:57:22 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:57:21 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-crypto@vger.kernel.org,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Subject: Re: [PATCH 09/11] crypto: shash: Remove VLA usage in unaligned
 hashing
Message-ID: <20180620235721.GF111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620190408.45104-10-keescook@chromium.org>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:04:06PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this uses
> the newly defined max alignment to perform unaligned hashing to avoid
> VLAs, and drops the helper function while adding sanity checks on the
> resulting buffer sizes.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/shash.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/crypto/shash.c b/crypto/shash.c
> index ab6902c6dae7..1bb58209330a 100644
> --- a/crypto/shash.c
> +++ b/crypto/shash.c
> @@ -73,13 +73,6 @@ int crypto_shash_setkey(struct crypto_shash *tfm, const u8 *key,
>  }
>  EXPORT_SYMBOL_GPL(crypto_shash_setkey);
>  
> -static inline unsigned int shash_align_buffer_size(unsigned len,
> -						   unsigned long mask)
> -{
> -	typedef u8 __aligned_largest u8_aligned;
> -	return len + (mask & ~(__alignof__(u8_aligned) - 1));
> -}
> -
>  static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>  				  unsigned int len)
>  {
> @@ -88,11 +81,14 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>  	unsigned long alignmask = crypto_shash_alignmask(tfm);
>  	unsigned int unaligned_len = alignmask + 1 -
>  				     ((unsigned long)data & alignmask);
> -	u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
> -		__aligned_largest;
> +	u8 ubuf[CRYPTO_ALG_MAX_ALIGNMASK]
> +		__aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
>  	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
>  	int err;

Are you sure that __attribute__((aligned(64))) works correctly on stack
variables on all architectures?

And if it is expected to work, then why is the buffer still aligned by hand on
the very next line?

>  
> +	if (WARN_ON(buf + unaligned_len > ubuf + sizeof(ubuf)))
> +		return -EINVAL;
> +
>  	if (unaligned_len > len)
>  		unaligned_len = len;
>  
> @@ -124,11 +120,14 @@ static int shash_final_unaligned(struct shash_desc *desc, u8 *out)
>  	unsigned long alignmask = crypto_shash_alignmask(tfm);
>  	struct shash_alg *shash = crypto_shash_alg(tfm);
>  	unsigned int ds = crypto_shash_digestsize(tfm);
> -	u8 ubuf[shash_align_buffer_size(ds, alignmask)]
> -		__aligned_largest;
> +	u8 ubuf[SHASH_MAX_DIGESTSIZE]
> +		__aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
>  	u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
>  	int err;

Same questions here.

>  
> +	if (WARN_ON(buf + ds > ubuf + sizeof(ubuf)))
> +		return -EINVAL;
> +
>  	err = shash->final(desc, buf);
>  	if (err)
>  		goto out;
> -- 

- Eric
