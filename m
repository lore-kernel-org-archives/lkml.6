Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZPpMDVP0GFtQNgAAmS7hNA
	; Thu, 07 Jun 2018 09:02:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 809F7607F7; Thu,  7 Jun 2018 09:02:12 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="q3qVMS0W"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E59AC602FC;
	Thu,  7 Jun 2018 09:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E59AC602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbeFGJCI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:02:08 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42844 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeFGJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:02:05 -0400
Received: by mail-ua0-f194.google.com with SMTP id x18-v6so5985077uaj.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JVS4lfq8kkUdydTnf2TjB3Tr6uqMScrl8ksFSy2rmw8=;
        b=q3qVMS0WhsnrdZ/tnHydZ4/BWm8xTBY4jwB9CPN4GZyS9fw9YYnOSSvnnPSqqqH5oQ
         /OQMTGJV/E1duh1qkINYI1hBmS7lMdZMy87gLiTJZvkrZda7YNH5FOvZnJnmzTCJ7/Pz
         dlMs3vI0MCiM090dlm/niuGFnriGVGukUZeSTZ4BgZVYE+3nMeYGa7SYlexREd1+Gx6q
         QEg/4CX5vdzecgEwcBB6tThlBrtZneicQ4mwNuAGD0LxUdTvTRaVOuE6tozqYghJJ4hx
         CrdobZezFRz+HPoDsSm1DS/lujJWsXHxv7Sk6aP5sr0V5qiyl0WXfud3zMVjueDZdoi2
         kO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JVS4lfq8kkUdydTnf2TjB3Tr6uqMScrl8ksFSy2rmw8=;
        b=PBtxl22L1ImHsRr44hhk3NqBphiDQFbiY9GFLWU8G75Ow0vfJFiyNjw2DzRGrj1Bbj
         hItIYYg1pe50c9sIG5uXDP/7STGfQgELwYJfusDwQyOXbT4qE07k+dl7dUQWcsORWqTt
         K6+BeYdv1cpNrwJj5aKQVBkAXzffrrC4MegrpHNa9YcHQ1pCJpNJiPNtpVaUK19HnmJW
         3m257iT75KnLs4lvmAVOcchXRHbwWzdOvtWCGqzwEJMW6104a13txu+Pbko/Vq4KhcWH
         9n5/ZLVuY0f4e5aRPA4acgTQWNGUNoDHVSevJhBZOLoFjw4z9GquD014nQL9OMaCeID0
         DrwA==
X-Gm-Message-State: APt69E35HucZz2sgTP895Ix14JQByPeX3z6Mqni5j8dpNXanYTpNFjcR
        Ah54rbQZYB9q2zVEWPc7J4/TlE+fpSmnlLw1gb5tvw==
X-Google-Smtp-Source: ADUXVKIxm17+lEVA3yNwyzIOzC78JeC7L+oCLnD0vcdfbb1IClo/bIH2Dfp7S5++gSqyg9O8uA9UTsKvkWJnr/wAX/Q=
X-Received: by 2002:ab0:30f6:: with SMTP id d22-v6mr664928uam.58.1528362124948;
 Thu, 07 Jun 2018 02:02:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3c4:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 02:02:04 -0700 (PDT)
X-Originating-IP: [217.140.96.140]
In-Reply-To: <1528361927-4172-1-git-send-email-gilad@benyossef.com>
References: <1528361927-4172-1-git-send-email-gilad@benyossef.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Thu, 7 Jun 2018 12:02:04 +0300
Message-ID: <CAOtvUMcJfJDjnMoithRQ4ife09VC+G-w+__jV-JLwh7M=s7JNQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: fix iv copying for small buffers
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, hadar.gat@arm.com
Cc: Ofir Drang <ofir.drang@arm.com>, stable@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 7, 2018 at 11:58 AM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> We are copying our last cipher block into the request for use as IV as
> required by the Crypto API but we failed to handle correctly the case the
> buffer we are working on is smaller than a block. Fix it by calculating
> how much we need to copy based on buffer size.
>

I'd be really happy to get a review on this patch - not so much what
it is doing but
rather the rational behind it - how is a tfm provider supposed to
handle copying the
last block of ciphertext into the request structure if the ciphertext
size is less than a
block?

I opted for simply copying whatever ciphertext was available and
zeroing the rest
but frankly I'm not sure this is the right thing.

Any feedback is apreciated.

Thanks!
Gilad


> CC: stable@vger.kernel.org
> Fixes: 63ee04c8b491 ("crypto: ccree - add skcipher support")
> Reported by: Hadar Gat <hadar.gat@arm.com>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
> index d2810c1..a07547f 100644
> --- a/drivers/crypto/ccree/cc_cipher.c
> +++ b/drivers/crypto/ccree/cc_cipher.c
> @@ -616,9 +616,18 @@ static void cc_cipher_complete(struct device *dev, void *cc_req, int err)
>                 memcpy(req->iv, req_ctx->backup_info, ivsize);
>                 kzfree(req_ctx->backup_info);
>         } else if (!err) {
> -               scatterwalk_map_and_copy(req->iv, req->dst,
> -                                        (req->cryptlen - ivsize),
> -                                        ivsize, 0);
> +               unsigned int len;
> +
> +               if (req->cryptlen > ivsize) {
> +                       len = req->cryptlen - ivsize;
> +               } else {
> +                       memset(req->iv, 0, ivsize);
> +                       len = 0;
> +                       ivsize = req->cryptlen;
> +
> +               }
> +
> +               scatterwalk_map_and_copy(req->iv, req->dst, len, ivsize, 0);
>         }
>
>         skcipher_request_complete(req, err);
> @@ -755,17 +764,26 @@ static int cc_cipher_decrypt(struct skcipher_request *req)
>         struct cipher_req_ctx *req_ctx = skcipher_request_ctx(req);
>         unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
>         gfp_t flags = cc_gfp_flags(&req->base);
> +       unsigned int len;
>
>         /*
>          * Allocate and save the last IV sized bytes of the source, which will
>          * be lost in case of in-place decryption and might be needed for CTS.
>          */
> -       req_ctx->backup_info = kmalloc(ivsize, flags);
> +       req_ctx->backup_info = kzalloc(ivsize, flags);
>         if (!req_ctx->backup_info)
>                 return -ENOMEM;
>
> -       scatterwalk_map_and_copy(req_ctx->backup_info, req->src,
> -                                (req->cryptlen - ivsize), ivsize, 0);
> +
> +       if (req->cryptlen > ivsize) {
> +               len = req->cryptlen - ivsize;
> +       } else {
> +               len = 0;
> +               ivsize = req->cryptlen;
> +       }
> +
> +       scatterwalk_map_and_copy(req_ctx->backup_info, req->src, len, ivsize,
> +                                0);
>         req_ctx->is_giv = false;
>
>         return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_DECRYPT);
> --
> 2.7.4
>



-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
