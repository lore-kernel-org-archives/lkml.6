Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDE8C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286382080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZxuTDV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286382080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbeLBX4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:56:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37071 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLBX4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:56:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so3913762wmd.2;
        Sun, 02 Dec 2018 15:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fEgPUVLJnDeRGZFITzLxOXTmCzjpgUWKPQeWh3b46FQ=;
        b=LZxuTDV6d+Rzz/sft+ttGll/smKGaq4apwQRQWb3qDxFa8BngVL8UMs8Te1qN6CqKa
         s8uTZX+mxPyx4+BaKjFRITssXZXyNL+1CnNmtRwvcq04IZQPCkxfqVANCrN+Dve6n2p4
         WFqewNmO56PajouU2PERhfrjsdQxjSO9hgNW9omfw9AZ2Vu2H8HgrzC90gNSm4ngPM3J
         J1qbjR31eo90uc5xC+KAU6gUmwW6WBkZWiecyoe6ePgM/b/vdFYCO582cqZspnONmSG6
         rFrw4cPqyoSB8BGqhvtHZRBchm0JqAXj3A54id4eiE20pwFWs7kr26NRziK3LOOEt9Ma
         VCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fEgPUVLJnDeRGZFITzLxOXTmCzjpgUWKPQeWh3b46FQ=;
        b=hDxsP5oDhSeBGMXxXJzerO2ojFpNj/y3r9LAv49qw4lyJ7YJxhTIExQgVi4xXPT2Uv
         NhXQ3+JWOq+pKMUM4PboRDZaN+4bYy8vfwVPM2nAtm4a7Ut+1N66affe2JhAyQafWTiP
         fYh42N0fZXmcykVme3e5Lum5FFvI47puds7yZDTKJ4Bl8epbysywi9tStqS97j0vsAHb
         4xevfrZPOF+/4dl6oCxetrCzqso0oY3IUxjfWQ6tWJ32gyB1jMe5oArvgCzrYHeIdwSv
         2KPQnqZUHJgVDTV92LSDT8V8Yr0yJb4k0gPVEGkvV/92DTpeag4o1f2jNWBsgT/Pge/A
         qjtQ==
X-Gm-Message-State: AA+aEWaRCEgA9gsu8vXiQT98pN4YJdieGiQZJCgdUOiEHVfiSs3Wp1xJ
        xG4F2BM0jdo6wX2M/DZK9oM=
X-Google-Smtp-Source: AFSGD/Uw7KXU/oHy17o0cxwnj0uYsRhVs/VSFop3tXBXJ0w32Jm1UHnCDrn1e+lD1Ftzuyo5NXKcKw==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr6261287wmd.15.1543794975693;
        Sun, 02 Dec 2018 15:56:15 -0800 (PST)
Received: from ziggy.stardust ([93.176.147.153])
        by smtp.gmail.com with ESMTPSA id w80sm5234991wme.38.2018.12.02.15.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 15:56:15 -0800 (PST)
Subject: Re: [PATCH v3 06/15] iommu/mediatek: Add mt8183 IOMMU support
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
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
 <1542422142-30688-7-git-send-email-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <f8528e80-e816-7901-a56a-581f88b29c83@gmail.com>
Date:   Mon, 3 Dec 2018 00:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542422142-30688-7-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2018 03:35, Yong Wu wrote:
> The M4U IP blocks in mt8183 is MediaTek's generation2 M4U which use
> the ARM Short-descriptor like mt8173, and most of the HW registers
> are the same.
> 
> Here list main changes in mt8183:
> 1) mt8183 has only one M4U HW like mt8173.

That's a change?

> 2) mt8183 don't have its "bclk" clock, the M4U use the EMI clock
> which has already been enabled before kernel.
> 3) mt8183 can support the dram over 4GB, but it don't call this "4GB
> mode".
> 4) mt8183 pgtable base register(0x0) extend bit[1:0] which represent
> the bit[33:32] in the physical address of the pgtable base, But the
> standard ttbr0[1] means the S bit which is enabled defaultly, Hence,
> we add a mask.
> 5) mt8183 HW has a GALS modules, the SMI should add "gals" clock
> support.
> 6) the larb-id in smi-common has been remapped. This means the
> larb-id reported in the mtk_iommu_isr is not the real larb-id, here
> is the remapping relationship of mt8183:

This whole list is an indicator that you will need several enhancements to the
existing code before you can add mt8183 support.
Please do so in independent patches (e.g. gals modules, remap logic)
Regarding making bclk optional, I think it would be better to set it to NULL for
mt8183 otherwise the driver will work with a broken device tree on systems that
actually need the bclk. Same holds for gals0 and gals1.

>                        M4U
>                         |
> ---------------------------------------------
> |               SMI common                  |
> -0-----7-----5-----6-----1-----2------3-----4- <- Id remapped
>  |     |     |     |     |     |      |     |
> larb0 larb1 IPU0  IPU1 larb4 larb5  larb6  CCU
> disp  vdec  img   cam   venc  img    cam
> As above, larb0 connects with the id 0 in smi-common.
>           larb1 connects with the id 7 in smi-common.
>           ...
> Take a example, if the larb-id reported in the mtk_iommu_isr is 7,
> actually it is larb1(vdec).
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++++++----------
>  drivers/iommu/mtk_iommu.h |  5 +++++
>  drivers/memory/mtk-smi.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 10 deletions(-)
> 

[...]

> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index a243047..e5fd8ee 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,11 +39,16 @@ enum mtk_iommu_plat {
>  	M4U_MT2701,
>  	M4U_MT2712,
>  	M4U_MT8173,
> +	M4U_MT8183,
>  };
>  
>  struct mtk_iommu_plat_data {
>  	enum mtk_iommu_plat m4u_plat;
>  	bool has_4gb_mode;
> +
> +	/* The larb-id may be remapped in the smi-common. */
> +	bool larbid_remap_enable;
> +	unsigned int larbid_remapped[MTK_LARB_NR_MAX];

Please add new features to the driver as single patches. Don't add this kind of
things in the patch where you enable a new SoC.

>  };
>  
>  struct mtk_iommu_domain;
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e37e54b..979153b 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -59,6 +59,7 @@ struct mtk_smi_larb_gen {
>  struct mtk_smi {
>  	struct device			*dev;
>  	struct clk			*clk_apb, *clk_smi;
> +	struct clk			*clk_gals0, *clk_gals1;
>  	struct clk			*clk_async; /*only needed by mt2701*/
>  	void __iomem			*smi_ao_base;
>  };
> @@ -93,8 +94,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  	if (ret)
>  		goto err_disable_apb;
>  
> +	ret = clk_prepare_enable(smi->clk_gals0);
> +	if (ret)
> +		goto err_disable_smi;
> +
> +	ret = clk_prepare_enable(smi->clk_gals1);
> +	if (ret)
> +		goto err_disable_gals0;
> +>  	return 0;
>  
> +err_disable_gals0:
> +	clk_disable_unprepare(smi->clk_gals0);
> +err_disable_smi:
> +	clk_disable_unprepare(smi->clk_smi);
>  err_disable_apb:
>  	clk_disable_unprepare(smi->clk_apb);
>  err_put_pm:
> @@ -104,6 +117,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>  
>  static void mtk_smi_disable(const struct mtk_smi *smi)
>  {
> +	clk_disable_unprepare(smi->clk_gals1);
> +	clk_disable_unprepare(smi->clk_gals0);
>  	clk_disable_unprepare(smi->clk_smi);
>  	clk_disable_unprepare(smi->clk_apb);
>  	pm_runtime_put_sync(smi->dev);
> @@ -262,6 +277,12 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
>  };
>  
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> +	.need_larbid = true,
> +	.config_port = mtk_smi_larb_config_port_gen2_general,
> +	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{
>  		.compatible = "mediatek,mt8173-smi-larb",
> @@ -275,6 +296,10 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
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
> @@ -304,6 +329,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	larb->smi.clk_smi = devm_clk_get(dev, "smi");
>  	if (IS_ERR(larb->smi.clk_smi))
>  		return PTR_ERR(larb->smi.clk_smi);
> +
> +	larb->smi.clk_gals0 = devm_clk_get(dev, "gals");> +	if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
> +		larb->smi.clk_gals0 = NULL;
> +	else if (IS_ERR(larb->smi.clk_gals0))
> +		return PTR_ERR(larb->smi.clk_gals0);
>  	larb->smi.dev = dev;
>  
>  	if (larb->larb_gen->need_larbid) {
> @@ -364,6 +395,10 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>  		.compatible = "mediatek,mt2712-smi-common",
>  		.data = (void *)MTK_SMI_GEN2
>  	},
> +	{
> +		.compatible = "mediatek,mt8183-smi-common",
> +		.data = (void *)MTK_SMI_GEN2
> +	},
>  	{}
>  };
>  
> @@ -388,6 +423,18 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	if (IS_ERR(common->clk_smi))
>  		return PTR_ERR(common->clk_smi);
>  
> +	common->clk_gals0 = devm_clk_get(dev, "gals0");
> +	if (PTR_ERR(common->clk_gals0) == -ENOENT)
> +		common->clk_gals0 = NULL;
> +	else if (IS_ERR(common->clk_gals0))
> +		return PTR_ERR(common->clk_gals0);
> +
> +	common->clk_gals1 = devm_clk_get(dev, "gals1");
> +	if (PTR_ERR(common->clk_gals1) == -ENOENT)
> +		common->clk_gals1 = NULL;
> +	else if (IS_ERR(common->clk_gals1))
> +		return PTR_ERR(common->clk_gals1);
> +

I'd prefer to check for clk_gals[01] for SoCs that need this clocks instead of
making them optional.

Regards,
Matthias
