Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFB020834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFB020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHaAbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:31:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45716 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeHaAbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:31:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so7465693eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPet5xR9oNt5ElCeNrQjZB2ZP88N/63XS3qgvoR8Fbo=;
        b=fsIY2SmVWICwWnQxBFOCtNSAKAHsh5pYdekzSRiJo5GbStaEFgBVhqYS8MKaln7w6p
         a9NT3UoF8Veo+AW29jaGPz8+eY2lOFDWJ/w7ouSxzhEW7sXwW8SeoWPuGuuSkVnwWAnT
         nU/q91T8gwgjEUDsIrAg7/ZyPE1ZShwSZsfMBmQadnLjbEMZM/QkxvUWjUnHRthyw3e7
         pOMEV6ExM9Wjxig94ezttc37uGBubUCwsCPObm3nwb2WiFKI+FaCaGPbAJy2Pdz6/ZDC
         5Rb2klOmKHZRZqrFxfUw6S5foprdJ1HlAyyuxhYfEd4WgVUfIJppqMQtu56zZrM+V8JQ
         YtMA==
X-Gm-Message-State: APzg51DaCtPvVC2psJXNnkFDKYY7sDctWI5Kr4HgtVCXE8B2rRK0HUm9
        pK7Vbjcck2dZe6sx4dyOtypywyD8ofQ=
X-Google-Smtp-Source: ANB0VdbTnaTt6p/u74//BYTDa3J2NkDa2IFPr4oL6ofpmb4zEvLRoiwD0LJ7PCBTDZZhY2fN4tjlOw==
X-Received: by 2002:a50:a623:: with SMTP id d32-v6mr14345256edc.8.1535660870995;
        Thu, 30 Aug 2018 13:27:50 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id u53-v6sm4491381edm.51.2018.08.30.13.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:27:50 -0700 (PDT)
Subject: Re: [PATCH v4 13/13 DONOTMERGE] ata: ahci_sunxi: remove PHY code
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, axboe@kernel.dk,
        kishon@ti.com, mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-14-clabbe.montjoie@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <33b1bd21-7bad-2ab9-0606-97d416789066@redhat.com>
Date:   Thu, 30 Aug 2018 22:27:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180830190120.722-14-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 30-08-18 21:01, Corentin Labbe wrote:
> Since PHY code is now handled by sun4i-a10-sata-phy, the code in
> ahci_sunxi is useless, remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>   drivers/ata/ahci_sunxi.c | 93 ------------------------------------------------
>   1 file changed, 93 deletions(-)
> 
> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
> index b8cf3a1be80b..af17f8ce65b2 100644
> --- a/drivers/ata/ahci_sunxi.c
> +++ b/drivers/ata/ahci_sunxi.c
> @@ -58,15 +58,6 @@ MODULE_PARM_DESC(enable_pmp,
>   #define AHCI_P0PHYCR	0x0178
>   #define AHCI_P0PHYSR	0x017c
>   
> -static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
> -{
> -	u32 reg_val;
> -
> -	reg_val = readl(reg);
> -	reg_val &= ~(clr_val);
> -	writel(reg_val, reg);
> -}
> -
>   static void sunxi_setbits(void __iomem *reg, u32 set_val)
>   {
>   	u32 reg_val;
> @@ -86,81 +77,6 @@ static void sunxi_clrsetbits(void __iomem *reg, u32 clr_val, u32 set_val)
>   	writel(reg_val, reg);
>   }
>   
> -static u32 sunxi_getbits(void __iomem *reg, u8 mask, u8 shift)
> -{
> -	return (readl(reg) >> shift) & mask;
> -}
> -
> -static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
> -{
> -	u32 reg_val;
> -	int timeout;
> -
> -	/*
> -	 * When using the new binding, the presence of a sata port node
> -	 * means that PHY is handled by the PHY driver.
> -	 * */
> -	if (of_get_child_count(dev->of_node)) {
> -		dev_info(dev, "Bypassing PHY init\n");
> -		return 0;
> -	}
> -
> -	/* This magic is from the original code */
> -	writel(0, reg_base + AHCI_RWCR);
> -	msleep(5);
> -
> -	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> -			 (0x7 << 24),
> -			 (0x5 << 24) | BIT(23) | BIT(18));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
> -			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
> -			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
> -	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
> -	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R,
> -			 (0x7 << 20), (0x3 << 20));
> -	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R,
> -			 (0x1f << 5), (0x19 << 5));
> -	msleep(5);
> -
> -	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
> -
> -	timeout = 250; /* Power up takes aprox 50 us */
> -	do {
> -		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
> -		if (reg_val == 0x02)
> -			break;
> -
> -		if (--timeout == 0) {
> -			dev_err(dev, "PHY power up failed.\n");
> -			return -EIO;
> -		}
> -		udelay(1);
> -	} while (1);
> -
> -	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
> -
> -	timeout = 100; /* Calibration takes aprox 10 us */
> -	do {
> -		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS2R, 0x1, 24);
> -		if (reg_val == 0x00)
> -			break;
> -
> -		if (--timeout == 0) {
> -			dev_err(dev, "PHY calibration failed.\n");
> -			return -EIO;
> -		}
> -		udelay(1);
> -	} while (1);
> -
> -	msleep(15);
> -
> -	writel(0x7, reg_base + AHCI_RWCR);
> -
> -	return 0;
> -}
> -
>   static void ahci_sunxi_start_engine(struct ata_port *ap)
>   {
>   	void __iomem *port_mmio = ahci_port_base(ap);
> @@ -186,7 +102,6 @@ static struct scsi_host_template ahci_platform_sht = {
>   
>   static int ahci_sunxi_probe(struct platform_device *pdev)
>   {
> -	struct device *dev = &pdev->dev;
>   	struct ahci_host_priv *hpriv;
>   	int rc;
>   
> @@ -200,10 +115,6 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
> -	if (rc)
> -		goto disable_resources;
> -
>   	hpriv->flags = AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
>   		       AHCI_HFLAG_YES_NCQ;
>   
> @@ -238,10 +149,6 @@ static int ahci_sunxi_resume(struct device *dev)
>   	if (rc)
>   		return rc;
>   
> -	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
> -	if (rc)
> -		goto disable_resources;
> -
>   	rc = ahci_platform_resume_host(dev);
>   	if (rc)
>   		goto disable_resources;
> 

After this change ahci_sunxi_resume() is the same as ahci_platform_resume,
so you can drop the entire function and directly refer to
ahci_platform_resume in ahci_sunxi_pm_ops.

Regards,

Hans
