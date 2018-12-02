Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDD2C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1DB208A3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY7n+1uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1DB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLBXEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:04:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43289 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBXEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:04:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so10237976wrs.10;
        Sun, 02 Dec 2018 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0HwScXmvDF2ynEOXT5oWGqUPrUDgfmcUR2MgA0s5FoM=;
        b=KY7n+1uwSsisgsEejtYzJtdb8T+gJmwmlFLD3HywHe3PGQd1s30rBHsaSjbmI6eKWc
         rMtKF/QjhyD+hcpwuqEqcOn70yh7T+lZe4PGcREHw5iD2vP6D5e7q0Vd+lReYqv5d4oU
         4k5DL547aqMi2Y8y847eSCabZ0cpA3N8cfM4xP/jMeBfaHl+k6nTo36VuZjRXVGg0xqt
         pAUa3Je2aYjwmX279XyOFjk2MuuDq7LOKUMbUJFK+JvCNX0egwfw+uoYMv4m//b5u7TI
         cDGo5zau0kc1KH81TTIMw2ofZu1MxePq3SpWmLs37XHkeUzDtTZXQiEJEBnVPkreOmH0
         P1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0HwScXmvDF2ynEOXT5oWGqUPrUDgfmcUR2MgA0s5FoM=;
        b=njhAIbT+5f5JzXERTKhl6PYybM2mK1Nov+5yB82CwzwlBuK86piLJTWIDfELBZceYM
         orUeL9faP8pQnnmcgvlNL82g5d2IuOLjFi7C0kXLXGVFwzAhahwIV/csa3BI8XuJ0S78
         cSIlNmylSoknFod4wlEnC43Xl4e4EKz618laOjiTESoXpDPl6EBdhyrtErbxA+58TyFh
         5tc67gJyATlXn6rQDXa4TO68eI36aWY/r2Nf8LtrM8pe9rXjUEg26SKbhBYfhidHOj5R
         8LZh/4e3qheucUIq4qahYbQGeSy1Tmje2thaFxue2eq/11QYhBGFmyhBVAtIM1dvuhSg
         BPhA==
X-Gm-Message-State: AA+aEWZUzJTzPARsAjNkCnWOqSGGwCMVxnZKxkmSxzckh+rxecRDqscz
        F/lvhCpY9bPV1H3J8UKmBiM=
X-Google-Smtp-Source: AFSGD/VJ1u93Dhwfy2zu313zgE/zuKDIeE/ihKpHgMcIhvKVduk0GE0xrACLVwX0pCNgHwlx3hvJnQ==
X-Received: by 2002:adf:f308:: with SMTP id i8mr11342779wro.219.1543791884976;
        Sun, 02 Dec 2018 15:04:44 -0800 (PST)
Received: from ziggy.stardust ([93.176.147.153])
        by smtp.gmail.com with ESMTPSA id o67sm4518853wmo.18.2018.12.02.15.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 15:04:44 -0800 (PST)
Subject: Re: [PATCH v3 13/15] memory: mtk-smi: Get rid of need_larbid
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
 <1542422142-30688-14-git-send-email-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <21767ceb-1db5-045f-06ac-29c57f1a74a5@gmail.com>
Date:   Mon, 3 Dec 2018 00:04:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542422142-30688-14-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2018 03:35, Yong Wu wrote:
> The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> It's no need to parse it again in SMI driver. Only clean some codes.
> This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> and mt8183.

I'm trying to understand why we need the mediatek,larb-id at all. From what I
understand as long as the mediatek larbs described in the iommu are ordered
(larb0, larb1, larb2, etc) we actually get the same value as defined by
mediatek,larb-id. At least this holds for all present implementations.

On the other hand I don't see where the mtk_iommu_v1 driver actually parses the
larb-id, can you please help to understand:

1) why we need the larb-id at all
2) how this will work if we do not parse the larb-id for v1 iommu at all

Thanks a lot,
Matthias

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e4daabb..e0265fe 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
>  };
>  
>  struct mtk_smi_larb_gen {
> -	bool need_larbid;
>  	int port_in_larb[MTK_LARB_NR_MAX + 1];
>  	void (*config_port)(struct device *);
>  	unsigned int larb_special_mask; /* The special larbs mask. */
> @@ -152,18 +151,9 @@ void mtk_smi_larb_put(struct device *larbdev)
>  	struct mtk_smi_iommu *smi_iommu = data;
>  	unsigned int         i;
>  
> -	if (larb->larb_gen->need_larbid) {
> -		larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> -		return 0;
> -	}
> -
> -	/*
> -	 * If there is no larbid property, Loop to find the corresponding
> -	 * iommu information.
> -	 */
> -	for (i = 0; i < smi_iommu->larb_nr; i++) {
> +	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
>  		if (dev == smi_iommu->larb_imu[i].dev) {
> -			/* The 'mmu' may be updated in iommu-attach/detach. */
> +			larb->larbid = i;
>  			larb->mmu = &smi_iommu->larb_imu[i].mmu;
>  			return 0;
>  		}
> @@ -242,7 +232,6 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
> -	.need_larbid = true,
>  	.port_in_larb = {
>  		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
>  		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
> @@ -251,13 +240,11 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> -	.need_larbid = true,
>  	.config_port = mtk_smi_larb_config_port_gen2_general,
>  	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> -	.need_larbid = true,
>  	.config_port = mtk_smi_larb_config_port_gen2_general,
>  	.larb_special_mask = BIT(2) | BIT(3) | BIT(7), /* IPU0 | IPU1 | CCU */
>  };
> @@ -289,7 +276,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *smi_node;
>  	struct platform_device *smi_pdev;
> -	int err;
>  
>  	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>  	if (!larb)
> @@ -316,15 +302,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  		return PTR_ERR(larb->smi.clk_gals0);
>  	larb->smi.dev = dev;
>  
> -	if (larb->larb_gen->need_larbid) {
> -		err = of_property_read_u32(dev->of_node, "mediatek,larb-id",
> -					   &larb->larbid);
> -		if (err) {
> -			dev_err(dev, "missing larbid property\n");
> -			return err;
> -		}
> -	}
> -
>  	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
>  	if (!smi_node)
>  		return -EINVAL;
> 
