Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeBVNi1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:38:27 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:56800 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932491AbeBVNiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:38:25 -0500
Date: Thu, 22 Feb 2018 21:38:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Joel Fernandes <joelf@ti.com>, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: omap: Improve a size determination in three
 functions
Message-ID: <20180222133813.GB28447@gondor.apana.org.au>
References: <28780631-d093-a581-8690-3868f8fa327e@users.sourceforge.net>
 <0a45e47f-5ed0-5dd6-7545-adc8df2d7972@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a45e47f-5ed0-5dd6-7545-adc8df2d7972@users.sourceforge.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 04:26:36PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Feb 2018 16:12:05 +0100
> 
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/crypto/omap-aes.c  | 3 +--
>  drivers/crypto/omap-des.c  | 3 +--
>  drivers/crypto/omap-sham.c | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
> index a2bac3b869b6..82282a5e9b3f 100644
> --- a/drivers/crypto/omap-aes.c
> +++ b/drivers/crypto/omap-aes.c
> @@ -1032,14 +1032,13 @@ static int omap_aes_get_res_pdev(struct omap_aes_dev *dd,
>  static int omap_aes_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct omap_aes_dev *dd;
>  	struct crypto_alg *algp;
>  	struct aead_alg *aalg;
>  	struct resource res;
>  	int err = -ENOMEM, i, j, irq = -1;
>  	u32 reg;
> +	struct omap_aes_dev *dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
>  
> -	dd = devm_kzalloc(dev, sizeof(struct omap_aes_dev), GFP_KERNEL);

I'm fine with sizeof(*dd) but please don't combine the allocation
with the declaration.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
