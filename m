Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeBGJ5I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:57:08 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54231 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeBGJ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:57:07 -0500
X-Google-Smtp-Source: AH8x227X9tCjqzC9KRLK/zx2Rwmb8quaY43eE8V5gGZ/J+DWJNBF1mAABwEDImBPZNi7Xa2dq1lBRQ==
Date: Wed, 7 Feb 2018 10:56:59 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Artem Savkov <artem.savkov@gmail.com>, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sun4i_ss_prng: fix return value of
 sun4i_ss_prng_generate
Message-ID: <20180207095659.GA19249@Red>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
 <20180206212022.1309-2-artem.savkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206212022.1309-2-artem.savkov@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 10:20:21PM +0100, Artem Savkov wrote:
> According to crypto/rng.h generate function should return 0 on success
> and < 0 on error.
> 
> Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
> Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> index 0d01d1624252..5754e0b92fb0 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> @@ -52,5 +52,5 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
>  
>  	writel(0, ss->base + SS_CTL);
>  	spin_unlock(&ss->slock);
> -	return dlen;
> +	return 0;
>  }
> -- 
> 2.15.1
> 

According to Documentation/crypto/api-samples.rst ("Code Example For Random Number Generator Usage")
you must return the length of data generated.

So crypto_rng_generate/crypto_rng_get_bytes documentation in crypto/rng.h must be fixed.

Herbert could you confirm ?

Regards
