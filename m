Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9A3C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E1420779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 05:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fbOmR4uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E1420779
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeICJ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:59:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36922 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeICJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:59:02 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w835eRNC015057;
        Mon, 3 Sep 2018 00:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535953227;
        bh=g4xGaqKMpXcbeL5xP/9xBCamdKbR+W8OmCTcFKxmJ6I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fbOmR4uUDlPO+QhPNPkE48npS1KtwZ3hEVcsCgiDBgweYMyS0cwYFTwtF2gf+jw/k
         bJXbE15wNE5sQbGLorlzgCGp5iR5K+yT01TAzySh/cYvn13+4bhrO4Dc5F1CuPb0DG
         IT+yVlmy/UeRi9gPFhZ90iP3wVY0+KkUFhykUHN8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w835eREH011016;
        Mon, 3 Sep 2018 00:40:27 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 3 Sep
 2018 00:40:26 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 3 Sep 2018 00:40:26 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w835eOQZ008441;
        Mon, 3 Sep 2018 00:40:25 -0500
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     "Andrew F. Davis" <afd@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-2-afd@ti.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <2a02c241-ac91-1bac-380d-122858bb03c3@ti.com>
Date:   Mon, 3 Sep 2018 11:10:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180831191326.25106-2-afd@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 01 September 2018 12:43 AM, Andrew F. Davis wrote:
> Use dev_name to get a unique label and use -1 for a base to get our
> selection automatically. We pull in all GPIOs per chip now so this
> does not have the effect of out of order labels like before.
> 
> We do these both together so we can drop all the static data in one
> patch. This also lets us normalize the return paths as we don't need
> any cleanup after this change.

echo 28 > /sys/class/gpio/export
/ # echo 28 > /sys/class/gpi[   12.839205] export_store: invalid GPIO 28
o/export
echo 2 > /sys/class/gp[   22.165728] export_store: invalid GPIO 2
io/export
/ # echo 1 > /sys/class/gp[   25.961392] export_store: invalid GPIO 1
io/export
/ # echo 3 > /sys/class/gp[   29.981918] export_store: invalid GPIO 3
io/export

Export fails with this patch. I am testing this on keystone-k2g-evm.


> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/gpio/gpio-davinci.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index a5ece8ea79bc..14d1729927d3 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -41,7 +41,6 @@ struct davinci_gpio_regs {
>  typedef struct irq_chip *(*gpio_get_irq_chip_cb_t)(unsigned int irq);
>  
>  #define BINTEN	0x8 /* GPIO Interrupt Per-Bank Enable Register */
> -#define MAX_LABEL_SIZE 20
>  
>  static void __iomem *gpio_base;
>  static unsigned int offset_array[5] = {0x10, 0x38, 0x60, 0x88, 0xb0};
> @@ -166,14 +165,12 @@ davinci_gpio_get_pdata(struct platform_device *pdev)
>  
>  static int davinci_gpio_probe(struct platform_device *pdev)
>  {
> -	static int ctrl_num, bank_base;
>  	int gpio, bank, i, ret = 0;
>  	unsigned int ngpio, nbank, nirq;
>  	struct davinci_gpio_controller *chips;
>  	struct davinci_gpio_platform_data *pdata;
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> -	char label[MAX_LABEL_SIZE];
>  
>  	pdata = davinci_gpio_get_pdata(pdev);
>  	if (!pdata) {
> @@ -228,10 +225,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	snprintf(label, MAX_LABEL_SIZE, "davinci_gpio.%d", ctrl_num++);
> -	chips->chip.label = devm_kstrdup(dev, label, GFP_KERNEL);
> -		if (!chips->chip.label)
> -			return -ENOMEM;
> +	chips->chip.label = dev_name(dev);
>  
>  	chips->chip.direction_input = davinci_direction_in;
>  	chips->chip.get = davinci_gpio_get;
> @@ -239,7 +233,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  	chips->chip.set = davinci_gpio_set;
>  
>  	chips->chip.ngpio = ngpio;
> -	chips->chip.base = bank_base;
> +	chips->chip.base = -1;
>  
>  #ifdef CONFIG_OF_GPIO
>  	chips->chip.of_gpio_n_cells = 2;
> @@ -252,28 +246,20 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  	}
>  #endif
>  	spin_lock_init(&chips->lock);
> -	bank_base += ngpio;
>  
>  	for (gpio = 0, bank = 0; gpio < ngpio; gpio += 32, bank++)
>  		chips->regs[bank] = gpio_base + offset_array[bank];
>  
>  	ret = devm_gpiochip_add_data(dev, &chips->chip, chips);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	platform_set_drvdata(pdev, chips);
>  	ret = davinci_gpio_irq_setup(pdev);
>  	if (ret)
> -		goto err;
> +		return ret;
>  
>  	return 0;
> -
> -err:
> -	/* Revert the static variable increments */
> -	ctrl_num--;
> -	bank_base -= ngpio;
> -
> -	return ret;
>  }
>  
>  /*--------------------------------------------------------------------------*/
> 
