Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDUXK7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 19:10:59 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46385 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbeDUXK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 19:10:57 -0400
X-Google-Smtp-Source: AB8JxZrEDWQRXSZJUUvmh4qZUjL7herKEQMyRzOaaaVQz3jgz1JAJBYrulRBs49f5G12gno5EOgWhg==
Subject: Re: [PATCH] Enable the clock before calling clk_get_rate().
To: Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc: ldv-project@linuxtesting.org, sil2review@lists.osadl.org
References: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
 w0j9Sw==
Message-ID: <dfb9c72c-6289-a2ea-c3d4-c59f5e3c799c@broadcom.com>
Date: Sat, 21 Apr 2018 16:10:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419130358.r7dva6owy2izyfus@agrajag.zerfleddert.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jonas,

On 04/19/2018 06:03 AM, Stefan Potyra wrote:
> Found by Linux Driver Verification project (linuxtesting.org).

Please use a commit subject which matches what was used before:

git log --no-merges --oneline drivers/spi/spi-bcm63xx-hsspi.c
378da4a65f3a spi/bcm63xx-hspi: fix error return code in
bcm63xx_hsspi_probe()
c3c25ea712c9 spi/bcm63xx-hspi: Fix checkpatch warnings
0b85a8421790 spi: bcm63xx-hsspi: Export OF device ID table as module aliases
7ab2463550e2 spi/bcm63xx-hsspi: allow for probing through devicetree
ff18e1ef04e2 spi/bcm63xx-hsspi: allow providing clock rate through a
second clock
f4d862237715 spi/bcm63xx-hsspi: add support for dual spi read/write
14ac00e033c5 spi: drop owner assignment from platform_drivers
e4745fef5595 spi: Remove unneeded include of linux/workqueue.h
1480916ebd6f spi: bcm63xx-hsspi: Use SIMPLE_DEV_PM_OPS macro
aa0fe82629f1 spi: Use reinit_completion at appropriate places
937ebf9cd34a spi/bcm63xx-hsspi: fix pm sleep support
7d255695804f spi/bcm63xx-hsspi: use devm_register_master()
dea5de1b37c0 spi/bcm63xx-hsspi: check result of clk_prepare_enable
b1bdd4f883e1 spi: bcm63xx-hsspi: Use devm_clk_get()
87917528cc92 spi: bcm63xx-hsspi: checking for ERR_PTR instead of NULL
142168eba9dc spi: bcm63xx-hsspi: add bcm63xx HSSPI driver

> 
> Fixes: 142168eba9dc spi: bcm63xx-hsspi: add bcm63xx HSSPI driver

Please include the commit title in ("<title>") as is indicated in the
SubmittingPatches document.

Thank you

> Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
> index cbcba614b253..46cd9b683d22 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -352,6 +352,10 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ret;
> +
>  	rate = clk_get_rate(clk);
>  	if (!rate) {
>  		struct clk *pll_clk = devm_clk_get(dev, "pll");
> @@ -364,10 +368,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  	}
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -
>  	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
>  	if (!master) {
>  		ret = -ENOMEM;
> 

-- 
Florian
