Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE6EC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979820874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBOfMP60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7979820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeFTXq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:46:28 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41935 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeFTXq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:46:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so517359pgl.8;
        Wed, 20 Jun 2018 16:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zV6LWz+iWOUTtp4Rbm+IZ6FXkTvO+aq6ljNKIufeUFU=;
        b=IBOfMP60t5q2WIymX01V+ts9xOHTT5fPUijOWDk866qRAj/FKfi09SFqhfO41yFDFc
         dO6P9o4pKYvwZGL7b2gAJHGxWY7RWxWhvM7ZRF2e4jUV9vg6KHZByl4Lb9nr7i8FZhiI
         xEDpgUOodutzTKncrjz1wIXm2Lf3G8l92nMD+WvBKEcu5nc57X0mJBjXnv7Wa9xXGZ3H
         4ND7sT+4iS+Qkc9Mt8p72NjdjMDCaXvs5PxdSav4bYTPNqT2KjbMuqgdAtqQmDpRWUCl
         C4Amj6/2s5BKmgX9Nlp3FUrQvkdnSYOPcDVCvPXl3Awm00jl9enga3qnH4G3ydYW7UA4
         thVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zV6LWz+iWOUTtp4Rbm+IZ6FXkTvO+aq6ljNKIufeUFU=;
        b=eYd1ViNLAMBBekcM79p8G0s4RM9yyFI5abdCRcCGBZk11RNg06V90HJFeiixzIlH0d
         35V+BrzH1jAFgB/qAhRFanJhz3UeOnpfIwqGgMSRDm3oHb1bfcf0CHpcSiXrx+iDSUWW
         YDLtuBuELbwdmnFXmYkYtBbkVgnU1LMN60D4xUusao8ohP6zerB7n1KMiwmJbu3VA2wp
         2twNc1+xctepWnBjPliesuDR/F34AcVTlnFLHF7Sh4D9oBgByjRDatr0DgJlDzJnRquV
         bdUJSKpn5BKc4b3f9SdNxbxF4oXPNOaKW+a/p/ZrjEPgdwmNDlNxbbWm8nJ0a0mZ79Mp
         jy4A==
X-Gm-Message-State: APt69E0vmqTmQAVU6fjEiztZLogM6aMOopb5oEXZshds0g5biqs22X1f
        NlhPVCULdgYgHSY5W3uvq7g=
X-Google-Smtp-Source: ADUXVKLd8t1blXLRzhrhFwDThieMG1kQuu024OHtWKNpBSRriMr0iqe4HNk0UrhjSYx4l2c1wx1Ozg==
X-Received: by 2002:a65:51c9:: with SMTP id i9-v6mr20737116pgq.202.1529538385815;
        Wed, 20 Jun 2018 16:46:25 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id x72-v6sm7168313pff.176.2018.06.20.16.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:46:25 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:46:23 -0700
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
Subject: Re: [dm-devel] [PATCH 07/11] crypto: xcbc: Remove VLA usage
Message-ID: <20180620234623.GE111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-8-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620190408.45104-8-keescook@chromium.org>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:04:04PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this uses
> the maximum blocksize and adds a sanity check.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/xcbc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/xcbc.c b/crypto/xcbc.c
> index 25c75af50d3f..016481b1f3ba 100644
> --- a/crypto/xcbc.c
> +++ b/crypto/xcbc.c
> @@ -65,7 +65,10 @@ static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
>  	int bs = crypto_shash_blocksize(parent);
>  	u8 *consts = PTR_ALIGN(&ctx->ctx[0], alignmask + 1);
>  	int err = 0;
> -	u8 key1[bs];
> +	u8 key1[CRYPTO_ALG_MAX_BLOCKSIZE];
> +
> +	if (WARN_ON(bs > sizeof(key1)))
> +		return -EINVAL;

Similarly, why not MAX_CIPHER_BLOCKSIZE?

Also, xcbc_create() only allows a 16-byte block size, and you made the API
enforce the maximum for algorithms anyway.  So I think the extra check here
isn't very worthwhile.

- Eric
