Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C17A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYGtAIuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C17A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPSFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:05:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40165 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPSFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:05:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so6171310plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PhItFWs8gGCG4LXXW2c9n4Z2Q+kPYkAY2+pTgx2YwLI=;
        b=mYGtAIuk4NNxSYRFahOOWzqI9d7YxQLKQ3SJ256I98i5CFD67IqK3zwc2Isp5Wt6AL
         SvusYGXAKHpq0PmIFVNRGQL+Ef+7+MROciROJx1kYLkWI4CG7wyPk3N9H8Lu9razy7Rk
         okUpY8ep1tB1TJi0LsXEFYv9TsTRDQ0jGDBwwxSOOjYIkcf0YwjOP/zm1Frq1TxGqqNR
         kNFdlA8CtVJo0AQl0dqWsgJkJCiguNHMK3XMpZ2bsqgaSTpzXRPSduovrS+K9m8v2kz4
         fhpsMxTPem2Pt61K4hALjqYoOYF7xsA0ipdlvzJWWgJ2iQncvtTcsfBY+a6aSNB9UPPF
         vMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PhItFWs8gGCG4LXXW2c9n4Z2Q+kPYkAY2+pTgx2YwLI=;
        b=JbnNS5oxTgJsbFte/asKgZqvOQ8vOjLXduYCYL9RKHHx9N4tl74REWvFnv2Mk1MFnj
         q7mz9XlYsR7b9Ii8wqjyKsYX5CwmdtZ2kun/QBB4tP8GUNdBnJfTIKIPdf4kuIOPvzFE
         L+IB9Gcwd2OLgvudk2TYkv97SFnD0s5RRd1ErQPC0HTP8sS1L9P7inZvzp/6D/Hl1/FT
         vZcfSfhx97eaWCUC2v3/ZsspXiHf5xf4a72wmKY+g0fjpU4F6wbhjb5U3zo0Yd9V02V6
         p9frR+ajyrwgSH8XFILDBXtaVI+EPBkUxrZoVaBzOn9U0LOO6JwWtAD0dGR0QnTZP6QM
         dlFQ==
X-Gm-Message-State: AOUpUlGNXTsgfldIf7pp6r1fNXpZ/ELuLGEmenCmm7Hv9QkhDHKNtSpW
        s2QX3BCi71NC01x7DQBEVxlgHA==
X-Google-Smtp-Source: AAOMgpecaimRNSQCCA+Qv6at1EE+wjZEIlf84E2OaqkxYiGqDVNO+6lZUaBbTGQhzkWO540rBTCbmQ==
X-Received: by 2002:a17:902:784d:: with SMTP id e13-v6mr17178090pln.197.1531762594093;
        Mon, 16 Jul 2018 10:36:34 -0700 (PDT)
Received: from google.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id h12-v6sm46451657pfi.114.2018.07.16.10.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:36:33 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:36:32 -0700
From:   Eric Biggers <ebiggers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: mppe: Remove VLA usage
Message-ID: <20180716173632.GD77258@google.com>
References: <20180716040516.GA32783@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716040516.GA32783@beast>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 09:05:16PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> removes the discouraged use of AHASH_REQUEST_ON_STACK (and associated
> VLA) by switching to shash directly and keeping the associated descriptor
> allocated with the regular state on the heap.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ppp/ppp_mppe.c | 57 +++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_mppe.c b/drivers/net/ppp/ppp_mppe.c
> index 6c7fd98cb00a..5b4b81027a75 100644
> --- a/drivers/net/ppp/ppp_mppe.c
> +++ b/drivers/net/ppp/ppp_mppe.c
> @@ -96,7 +96,7 @@ static inline void sha_pad_init(struct sha_pad *shapad)
>   */
>  struct ppp_mppe_state {
>  	struct crypto_skcipher *arc4;
> -	struct crypto_ahash *sha1;
> +	struct shash_desc *sha1;
>  	unsigned char *sha1_digest;
>  	unsigned char master_key[MPPE_MAX_KEY_LEN];
>  	unsigned char session_key[MPPE_MAX_KEY_LEN];
> @@ -136,25 +136,16 @@ struct ppp_mppe_state {
>   */
>  static void get_new_key_from_sha(struct ppp_mppe_state * state)
>  {
> -	AHASH_REQUEST_ON_STACK(req, state->sha1);
> -	struct scatterlist sg[4];
> -	unsigned int nbytes;
> -
> -	sg_init_table(sg, 4);
> -
> -	nbytes = setup_sg(&sg[0], state->master_key, state->keylen);
> -	nbytes += setup_sg(&sg[1], sha_pad->sha_pad1,
> -			   sizeof(sha_pad->sha_pad1));
> -	nbytes += setup_sg(&sg[2], state->session_key, state->keylen);
> -	nbytes += setup_sg(&sg[3], sha_pad->sha_pad2,
> -			   sizeof(sha_pad->sha_pad2));
> -
> -	ahash_request_set_tfm(req, state->sha1);
> -	ahash_request_set_callback(req, 0, NULL, NULL);
> -	ahash_request_set_crypt(req, sg, state->sha1_digest, nbytes);
> -
> -	crypto_ahash_digest(req);
> -	ahash_request_zero(req);
> +	crypto_shash_init(state->sha1);
> +	crypto_shash_update(state->sha1, state->master_key,
> +			    state->keylen);
> +	crypto_shash_update(state->sha1, sha_pad->sha_pad1,
> +			    sizeof(sha_pad->sha_pad1));
> +	crypto_shash_update(state->sha1, state->session_key,
> +			    state->keylen);
> +	crypto_shash_update(state->sha1, sha_pad->sha_pad2,
> +			    sizeof(sha_pad->sha_pad2));
> +	crypto_shash_final(state->sha1, state->sha1_digest);
>  }
>  
>  /*
> @@ -200,6 +191,7 @@ static void mppe_rekey(struct ppp_mppe_state * state, int initial_key)
>  static void *mppe_alloc(unsigned char *options, int optlen)
>  {
>  	struct ppp_mppe_state *state;
> +	struct crypto_shash *shash;
>  	unsigned int digestsize;
>  
>  	if (optlen != CILEN_MPPE + sizeof(state->master_key) ||
> @@ -217,13 +209,21 @@ static void *mppe_alloc(unsigned char *options, int optlen)
>  		goto out_free;
>  	}
>  
> -	state->sha1 = crypto_alloc_ahash("sha1", 0, CRYPTO_ALG_ASYNC);
> -	if (IS_ERR(state->sha1)) {
> -		state->sha1 = NULL;
> +	shash = crypto_alloc_shash("sha1", 0, 0);
> +	if (IS_ERR(shash))
> +		goto out_free;
> +
> +	state->sha1 = kmalloc(sizeof(*state->sha1) +
> +				     crypto_shash_descsize(shash),
> +			      GFP_KERNEL);
> +	if (!state->sha1) {
> +		crypto_free_shash(shash);
>  		goto out_free;
>  	}
> +	state->sha1->tfm = shash;
> +	state->sha1->flags = 0;
>  
> -	digestsize = crypto_ahash_digestsize(state->sha1);
> +	digestsize = crypto_shash_digestsize(shash);
>  	if (digestsize < MPPE_MAX_KEY_LEN)
>  		goto out_free;
>  
> @@ -246,7 +246,11 @@ static void *mppe_alloc(unsigned char *options, int optlen)
>  
>  out_free:
>  	kfree(state->sha1_digest);
> -	crypto_free_ahash(state->sha1);
> +	if (state->sha1) {
> +		if (state->sha1->tfm)
> +			crypto_free_shash(state->sha1->tfm);

It's not necessary to check for NULL before calling crypto_free_shash().
Otherwise this looks good, though I dislike how the error codes aren't checked
in get_new_key_from_sha() (of course, they weren't before this patch either).

> +		kzfree(state->sha1);
> +	}
>  	crypto_free_skcipher(state->arc4);
>  	kfree(state);
>  out:
> @@ -261,7 +265,8 @@ static void mppe_free(void *arg)
>  	struct ppp_mppe_state *state = (struct ppp_mppe_state *) arg;
>  	if (state) {
>  		kfree(state->sha1_digest);
> -		crypto_free_ahash(state->sha1);
> +		crypto_free_shash(state->sha1->tfm);
> +		kzfree(state->sha1);
>  		crypto_free_skcipher(state->arc4);
>  		kfree(state);
>  	}
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security
