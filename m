Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17367C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F9F2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TEDLNr3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfAGSrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:47:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33254 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:47:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so608992pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5AHn/0hxjpijqUSmdBQ7Flq9kGZWKXli6ohPOfLg+xY=;
        b=TEDLNr3vK4Ox6kDnZf3Tfi5+o/l9Ff8kZDfj6HDdREWgMvtszwSN5yKSqHnONRNuE4
         /2BneyFPD7naJi/kvx+REibUkvGWoYeTlC9g+ZXwItN8DC79DspCVFbbwqUVnHxO0BTp
         pu8BvDljmWdjXLSp6oNM+YP7hjfY02BlD2bl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5AHn/0hxjpijqUSmdBQ7Flq9kGZWKXli6ohPOfLg+xY=;
        b=GDNk3LdEOk/dAR9yEBDOZZ9NAsFbonQGJXYMXbtC2uVbSRCXlFJ3WhXLkDPjMyPVIm
         lc376Pq0cfAgAMm4Tb9R64bsm/6lBo6/FHorA1TMLn1TGzARBUEFOhHytWVF2AReGDY9
         TQhiO9XBqhpORZGGop8seM5WoWN/pfd49nWlbLPYoLtJ4wiNcwHsNpyu8ACAyNgTmt5j
         SWonvXeQX4j8sSX29YdXpM2HCnYAtlHhgIhQMGdhFaRUJz7I66poiiZa7krT0MXWdxPg
         hsOfS1vzJkIFdPjziBDarnxJpBXlMe84qH/7hKkyYLfI4ZEUV/CQTQnoHZNmTvQFh2r/
         7vbQ==
X-Gm-Message-State: AJcUukdzxmtMajwcCyKTjc5J7FBpKWoPEJnu26r8FpWEnoV2pMPG9GQ8
        pg3CDL0m7L1G5DEcDLrcpyS86A==
X-Google-Smtp-Source: ALg8bN4X0HO/Cgf/+QgsiiK8EHDv+kz4QNSYA/uZGgOEMg4ERJMlrtkDTm1X8nTayEfSZIsm9t70ew==
X-Received: by 2002:a63:4101:: with SMTP id o1mr11800552pga.447.1546886860065;
        Mon, 07 Jan 2019 10:47:40 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o8sm129494061pfa.42.2019.01.07.10.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:47:39 -0800 (PST)
Subject: Re: [PATCH 2/2] phy: bcm-ns-usb2: support updated DT binding with the
 CRU syscon
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190107082545.5529-1-zajec5@gmail.com>
 <20190107082545.5529-2-zajec5@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <1e1d2151-87b1-668a-f63d-162054a67a90@broadcom.com>
Date:   Mon, 7 Jan 2019 10:47:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107082545.5529-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2019 12:25 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This adds support for the "syscon-cru" DT property which simply requires
> using regmap to access CRU registers.
> 
> The old binding has been deprecated and stays as a fallback method.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/phy/broadcom/phy-bcm-ns-usb2.c | 44 +++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> index 58dff80e9386..8dc6835b941c 100644
> --- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> +++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> @@ -13,17 +13,23 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/regmap.h>

alphabetical order, so after platform_device.h

>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +#define CRU_USB2_CONTROL			0x64
> +#define CRU_CLKSET_KEY				0x80
> +
>  struct bcm_ns_usb2 {
>  	struct device *dev;
>  	struct clk *ref_clk;
>  	struct phy *phy;
> +	struct regmap *cru;
>  	void __iomem *dmu;
>  };
>  
> @@ -31,6 +37,7 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>  {
>  	struct bcm_ns_usb2 *usb2 = phy_get_drvdata(phy);
>  	struct device *dev = usb2->dev;
> +	struct regmap *cru = usb2->cru;
>  	void __iomem *dmu = usb2->dmu;
>  	u32 ref_clk_rate, usb2ctl, usb_pll_ndiv, usb_pll_pdiv;
>  	int err = 0;
> @@ -48,7 +55,10 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>  		goto err_clk_off;
>  	}
>  
> -	usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);
> +	if (cru)
> +		regmap_read(cru, CRU_USB2_CONTROL, &usb2ctl);
> +	else
> +		usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);

Do you think it's cleaner to use a read/write wrapper to handle both the
syscon based case and the plain readl/writel? I thought that would make
the code much more readable.

>  
>  	if (usb2ctl & BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_PDIV_MASK) {
>  		usb_pll_pdiv = usb2ctl;
> @@ -62,15 +72,24 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>  	usb_pll_ndiv = (1920000000 * usb_pll_pdiv) / ref_clk_rate;
>  
>  	/* Unlock DMU PLL settings with some magic value */
> -	writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
> +	if (cru)
> +		regmap_write(cru, CRU_CLKSET_KEY, 0x0000ea68);
> +	else
> +		writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
>  
>  	/* Write USB 2.0 PLL control setting */
>  	usb2ctl &= ~BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_MASK;
>  	usb2ctl |= usb_pll_ndiv << BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_SHIFT;
> -	writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
> +	if (cru)
> +		regmap_write(cru, CRU_USB2_CONTROL, usb2ctl);
> +	else
> +		writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
>  
>  	/* Lock DMU PLL settings */
> -	writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
> +	if (cru)
> +		regmap_write(cru, CRU_CLKSET_KEY, 0x00000000);
> +	else
> +		writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
>  
>  err_clk_off:
>  	clk_disable_unprepare(usb2->ref_clk);
> @@ -86,6 +105,7 @@ static const struct phy_ops ops = {
>  static int bcm_ns_usb2_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct device_node *cru_np;
>  	struct bcm_ns_usb2 *usb2;
>  	struct resource *res;
>  	struct phy_provider *phy_provider;
> @@ -95,11 +115,17 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	usb2->dev = dev;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
> -	usb2->dmu = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(usb2->dmu)) {
> -		dev_err(dev, "Failed to map DMU regs\n");
> -		return PTR_ERR(usb2->dmu);
> +	cru_np = of_parse_phandle(dev->of_node, "syscon-cru", 0);
> +	usb2->cru = syscon_node_to_regmap(cru_np);

just use 'syscon_regmap_lookup_by_phandle'

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
