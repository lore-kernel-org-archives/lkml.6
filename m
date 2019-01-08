Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4290C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0E12064C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZSxk+VOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAHRx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:53:26 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37309 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:53:26 -0500
Received: by mail-yb1-f194.google.com with SMTP id 2so1913956ybw.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6z8BsKNas3KvPXGBYRcHp3Rt1r6Qt9I2nK+LmSpb+Uw=;
        b=ZSxk+VOvustF1zIk3ms5sP160xZ34mpKVe6o8jl8hxHIuI7PhImVaKOMOmJnDNRVmg
         d1u1lSWm/QuW1ixKQ48ejzUhnBCwa3voW+QCO23cMHY8Nq0iOj5Y4mUMC26KpbI8YQfb
         pnr59OquhtC6P7BgnqYfNPog7/CvzqWCBoWYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6z8BsKNas3KvPXGBYRcHp3Rt1r6Qt9I2nK+LmSpb+Uw=;
        b=RJ+iPPA/w84bJOMz7V0yRiApQfGjlL94ZF/aQL97SEXRsSaumuncVNmyNSZ3ijsp1b
         Bss10L+a1N0xVd8TOzwV9BTbAf2lQ8iOOBSY7BI+DUw7185lBJRORzeNwB30onOb+fG1
         rHWsGq5KlAuaxoY6yrXyQ/0s+66C+vRAh04tzMljlH6IfNfVWrkqiS+wXV9jUydNN7ib
         /LNjn70eDE4XRWZKQzU70Iw2dXNB/VjMaaVKG2IMHpkqYbmgF1ScacXAKJneHaOi8JVQ
         CgW8HjaWmRCIMcC4IHwLBMdsRlgfIiaSgoG1HJZBNHHvQucV790iu5dS0c8/G6dh2Hjx
         a7ng==
X-Gm-Message-State: AJcUukcEkGGMB78BmpmU0M6ma5QZQsdb9bkO58oxH7VU52SnjmKGgEmk
        P20dmv6hisTkrSf/04zEnld0JQ==
X-Google-Smtp-Source: ALg8bN6/gUOsaW4GofQkFlHn4CzBzGvfjhb6tnMFJcGrDM/V/pqNOV933JAGPb1Z6bDGXh0Csz5+wg==
X-Received: by 2002:a25:a125:: with SMTP id z34mr2462857ybh.115.1546970004968;
        Tue, 08 Jan 2019 09:53:24 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g84sm28527066ywg.9.2019.01.08.09.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:53:24 -0800 (PST)
Subject: Re: [PATCH V2 2/2] phy: bcm-ns-usb2: support updated DT binding with
 the CRU syscon
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190107082545.5529-1-zajec5@gmail.com>
 <20190108123907.19816-1-zajec5@gmail.com>
 <20190108123907.19816-2-zajec5@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <25695d19-3eed-af2b-521d-d7ac97989f94@broadcom.com>
Date:   Tue, 8 Jan 2019 09:53:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108123907.19816-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2019 4:39 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This adds support for the "syscon-cru" DT property which simply requires
> using regmap to access CRU registers.
> 
> The old binding has been deprecated and stays as a fallback method.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add bcm_ns_usb2_(read|write) & use syscon_regmap_lookup_by_phandle
> ---
>  drivers/phy/broadcom/phy-bcm-ns-usb2.c | 50 +++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> index 58dff80e9386..b9d3ba6f9609 100644
> --- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> +++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> @@ -13,25 +13,50 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> +#define CRU_USB2_CONTROL			0x64
> +#define CRU_CLKSET_KEY				0x80
> +
> +#define DMU_CRU_OFFSET				0x100
> +
>  struct bcm_ns_usb2 {
>  	struct device *dev;
>  	struct clk *ref_clk;
>  	struct phy *phy;
> +	struct regmap *cru;
>  	void __iomem *dmu;
>  };
>  
> +static void bcm_ns_usb2_read(struct bcm_ns_usb2 *usb2, unsigned int reg,
> +			     unsigned int *val)
> +{
> +	if (usb2->cru)
> +		regmap_read(usb2->cru, reg, val);
> +	else
> +		*val = readl(usb2->dmu + DMU_CRU_OFFSET + reg);
> +}
> +
> +static void bcm_ns_usb2_write(struct bcm_ns_usb2 *usb2, unsigned int reg,
> +			      unsigned int val)
> +{
> +	if (usb2->cru)
> +		regmap_write(usb2->cru, reg, val);
> +	else
> +		writel(val, usb2->dmu + DMU_CRU_OFFSET + reg);
> +}
> +
>  static int bcm_ns_usb2_phy_init(struct phy *phy)
>  {
>  	struct bcm_ns_usb2 *usb2 = phy_get_drvdata(phy);
>  	struct device *dev = usb2->dev;
> -	void __iomem *dmu = usb2->dmu;
>  	u32 ref_clk_rate, usb2ctl, usb_pll_ndiv, usb_pll_pdiv;
>  	int err = 0;
>  
> @@ -48,7 +73,7 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>  		goto err_clk_off;
>  	}
>  
> -	usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);
> +	bcm_ns_usb2_read(usb2, CRU_USB2_CONTROL, &usb2ctl);
>  
>  	if (usb2ctl & BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_PDIV_MASK) {
>  		usb_pll_pdiv = usb2ctl;
> @@ -62,15 +87,15 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>  	usb_pll_ndiv = (1920000000 * usb_pll_pdiv) / ref_clk_rate;
>  
>  	/* Unlock DMU PLL settings with some magic value */
> -	writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
> +	bcm_ns_usb2_write(usb2, CRU_CLKSET_KEY, 0x0000ea68);
>  
>  	/* Write USB 2.0 PLL control setting */
>  	usb2ctl &= ~BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_MASK;
>  	usb2ctl |= usb_pll_ndiv << BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_SHIFT;
> -	writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
> +	bcm_ns_usb2_write(usb2, CRU_USB2_CONTROL, usb2ctl);
>  
>  	/* Lock DMU PLL settings */
> -	writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
> +	bcm_ns_usb2_write(usb2, CRU_CLKSET_KEY, 0x00000000);
>  
>  err_clk_off:
>  	clk_disable_unprepare(usb2->ref_clk);
> @@ -95,11 +120,16 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	usb2->dev = dev;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
> -	usb2->dmu = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(usb2->dmu)) {
> -		dev_err(dev, "Failed to map DMU regs\n");
> -		return PTR_ERR(usb2->dmu);
> +	usb2->cru = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon-cru");
> +	if (IS_ERR(usb2->cru)) {
> +		usb2->cru = NULL;
> +
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
> +		usb2->dmu = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(usb2->dmu)) {
> +			dev_err(dev, "Failed to map DMU regs\n");
> +			return PTR_ERR(usb2->dmu);
> +		}
>  	}
>  
>  	usb2->ref_clk = devm_clk_get(dev, "phy-ref-clk");
> 

Looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
