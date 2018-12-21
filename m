Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11810C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A575121934
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Wk5Bnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391390AbeLUSb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:31:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34313 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeLUSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:31:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so6258304wrw.1;
        Fri, 21 Dec 2018 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=frQNHU2Xiu7/zXR5ZsdjmA4jhAS53i1SL+cm6vQhypQ=;
        b=a6Wk5BnfPAcc2ZPHhaYzlu9SFoJqNzRBRwIIPQ1vwRInMbeB+CGbuHu5X2P0iVp4eF
         4tAlOegeFgmnCfoGZYBE+8lmgtBtpUCLJpkBs2luyoACfftNO/tE4qBynAz/n8Rdf+mi
         3x5jMz/9Bosfi2uDTCZuMKzwK2IcHzEdplP8VWh7mAIYoJqVXZweJ3UCP+WQG5VM3Am7
         BNUDLYbnWawyLXmfx62r8Ko/OH7isYcW3F6TCaxCgbO3/XxSihK2HLueCJuOdjFR8RkG
         E0LjUNqj7pc7hGgYVpSfbvMc8wX8CiV0lGJx6cAN1PFDDVyZzp7QK73EH8EIrz9OGiCA
         DTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=frQNHU2Xiu7/zXR5ZsdjmA4jhAS53i1SL+cm6vQhypQ=;
        b=qiueJbpbrzBt0DZ7R8L/D0g9SKAEtG8QbA9mW54Zo92Vli9XJFqhWf8VU19ZeDS8iK
         xpPDhyqYe8ANUDbT9L05FyHIOYS5wl9ZOiV1jG2Vhd9JZ4T9gJpSeYOYoPWFbShMt5JZ
         86NPsFCPRUuJ+OPNvKxxDUPNW2hrBz8oUEf8bJna3Zj4szbrtBBe1Ve+8W41kcogA0vc
         OGJ1tf4HkboQoRTe1WkPKsva/au+yntGe+UTxLuTeA6jS0PFN4lihxy9hHLdGOUSm0Qu
         m0r6e0qqqrqdL+0kLmaqdS+aKhWBT0XDr7vi8ON+y69uhad49SbwEPMEUiH2dE1PEGDB
         I4yg==
X-Gm-Message-State: AJcUukfOg9pY9Xe66uOmk93zKGRvPkmngwYepv4sABGa4l1LlIlM00OA
        Pes5Sw/aPFMPJbujfmzFHMU=
X-Google-Smtp-Source: ALg8bN6qQsw15delPyM0Wrc+LMXbfRktqfUbl8jSrNnPvMUExeb4j1dePmVvl7b79Li5Zsp79jMFIQ==
X-Received: by 2002:adf:bc02:: with SMTP id s2mr3588373wrg.255.1545417112283;
        Fri, 21 Dec 2018 10:31:52 -0800 (PST)
Received: from ziggy.stardust ([93.176.153.35])
        by smtp.gmail.com with ESMTPSA id m132sm13188604wmd.15.2018.12.21.10.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:31:51 -0800 (PST)
Subject: Re: [PATCH v4 10/18] iommu/mediatek: Add mt8183 IOMMU support
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, arnd@arndb.de,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
 <1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <07f6276d-e7b5-ef82-9c38-1fa0af0cd9f3@gmail.com>
Date:   Fri, 21 Dec 2018 19:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544258371-4600-11-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/12/2018 09:39, Yong Wu wrote:
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
> 
> Here list main differences between mt8183 and mt8173/mt2712:
> 1) mt8183 has only one M4U HW like mt8173 while mt2712 has two.
> 2) mt8183 don't have the "bclk" clock, it use the EMI clock instead.
> 3) mt8183 can support the dram over 4GB, but it doesn't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, SMI should enable "has_gals" support.
> 6) the larb-id in smi-common is remapped. M4U should enable
> larbid_remapped support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 31 ++++++++++++++++++++++---------
>  drivers/iommu/mtk_iommu.h |  1 +
>  drivers/memory/mtk-smi.c  | 19 +++++++++++++++++++
>  3 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8ab3b69..d91a554 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -36,6 +36,7 @@
>  #include "mtk_iommu.h"
>  
>  #define REG_MMU_PT_BASE_ADDR			0x000
> +#define MMU_PT_ADDR_MASK			GENMASK(31, 7)
>  
>  #define REG_MMU_INVALIDATE			0x020
>  #define F_ALL_INVLD				0x2
> @@ -54,7 +55,7 @@
>  #define REG_MMU_CTRL_REG			0x110
>  #define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
>  #define F_MMU_TF_PROTECT_SEL_SHIFT(data) \
> -	((data)->plat_data->m4u_plat == M4U_MT2712 ? 4 : 5)
> +	((data)->plat_data->m4u_plat == M4U_MT8173 ? 5 : 4)
>  /* It's named by F_MMU_TF_PROT_SEL in mt2712. */
>  #define F_MMU_TF_PROTECT_SEL(prot, data) \
>  	(((prot) & 0x3) << F_MMU_TF_PROTECT_SEL_SHIFT(data))
> @@ -347,7 +348,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  	/* Update the pgtable base address register of the M4U HW */
>  	if (!data->m4u_dom) {
>  		data->m4u_dom = dom;
> -		writel(dom->cfg.arm_v7s_cfg.ttbr[0],
> +		writel(dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
>  		       data->base + REG_MMU_PT_BASE_ADDR);
>  	}
>  
> @@ -510,6 +511,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  
>  static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  {
> +	enum mtk_iommu_plat m4u_plat = data->plat_data->m4u_plat;
>  	u32 regval;
>  	int ret;
>  
> @@ -520,7 +522,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	}
>  
>  	regval = F_MMU_TF_PROTECT_SEL(2, data);
> -	if (data->plat_data->m4u_plat == M4U_MT8173)
> +	if (m4u_plat == M4U_MT8173)
>  		regval |= F_MMU_PREFETCH_RT_REPLACE_MOD;
>  	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
>  
> @@ -541,14 +543,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
>  	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
>  
> -	if (data->plat_data->m4u_plat == M4U_MT8173)
> +	if (m4u_plat == M4U_MT8173)
>  		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
>  	else
>  		regval = lower_32_bits(data->protect_base) |
>  			 upper_32_bits(data->protect_base);
>  	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>  
> -	if (data->enable_4GB && data->plat_data->m4u_plat != M4U_MT8173) {
> +	if (data->enable_4GB && m4u_plat == M4U_MT2712) {
>  		/*
>  		 * If 4GB mode is enabled, the validate PA range is from
>  		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -558,8 +560,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	}
>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>  
> -	/* It's MISC control register whose default value is ok except mt8173.*/
> -	if (data->plat_data->m4u_plat == M4U_MT8173)
> +	/*
> +	 * It's MISC control register whose default value is ok
> +	 * except mt8173 and mt8183.
> +	 */
> +	if (m4u_plat == M4U_MT8173 || m4u_plat == M4U_MT8183)
>  		writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
>  
>  	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> @@ -713,6 +718,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  {
>  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> +	struct mtk_iommu_domain *m4u_dom = data->m4u_dom;
>  	void __iomem *base = data->base;
>  	int ret;
>  
> @@ -728,8 +734,8 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
>  	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
>  	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
> -	if (data->m4u_dom)
> -		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
> +	if (m4u_dom)
> +		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr[0] & MMU_PT_ADDR_MASK,
>  		       base + REG_MMU_PT_BASE_ADDR);
>  	return 0;
>  }
> @@ -750,9 +756,16 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  	.has_bclk     = true,
>  };
>  
> +static const struct mtk_iommu_plat_data mt8183_data = {
> +	.m4u_plat            = M4U_MT8183,
> +	.larbid_remap_enable = true,
> +	.larbid_remapped     = {0, 4, 5, 6, 7, 2, 3, 1},

Aren't we reinventing the wheel here?
Why can't we use larb-id to get the correct id insteaf of providing another data
structure for the remapping?

Regards,
Matthias

> +};
> +
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
> +	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>  	{}
>  };
>  
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 3877050..6385dec 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,6 +39,7 @@ enum mtk_iommu_plat {
>  	M4U_MT2701,
>  	M4U_MT2712,
>  	M4U_MT8173,
> +	M4U_MT8183,
>  };
>  
>  struct mtk_iommu_plat_data {
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 3720c77..bced778 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -285,6 +285,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  	.larb_special_mask = BIT(8) | BIT(9),          /* bdpsys */
>  };
>  
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> +	.has_gals          = true,
> +	.config_port       = mtk_smi_larb_config_port_gen2_general,
> +	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{
>  		.compatible = "mediatek,mt8173-smi-larb",
> @@ -298,6 +304,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  		.compatible = "mediatek,mt2712-smi-larb",
>  		.data = &mtk_smi_larb_mt2712
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-larb",
> +		.data = &mtk_smi_larb_mt8183
> +	},
>  	{}
>  };
>  
> @@ -391,6 +401,11 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  	.gen = MTK_SMI_GEN2,
>  };
>  
> +static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> +	.gen      = MTK_SMI_GEN2,
> +	.has_gals = true,
> +};
> +
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
>  	{
>  		.compatible = "mediatek,mt8173-smi-common",
> @@ -404,6 +419,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  		.compatible = "mediatek,mt2712-smi-common",
>  		.data = &mtk_smi_common_gen2,
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-common",
> +		.data = &mtk_smi_common_mt8183,
> +	},
>  	{}
>  };
>  
> 
