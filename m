Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B6F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B6F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeKSQRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 11:17:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbeKSQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 11:17:40 -0500
X-UUID: c26780bbb2854b68950f70329f14fc6e-20181119
X-UUID: c26780bbb2854b68950f70329f14fc6e-20181119
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1250103200; Mon, 19 Nov 2018 13:55:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Nov 2018 13:54:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Nov 2018 13:54:59 +0800
Message-ID: <1542606899.32082.15.camel@mtksdaap41>
Subject: Re: [PATCH v5 04/12] drm/mediatek: Add support for mmsys through a
 pdev
From:   CK Hu <ck.hu@mediatek.com>
To:     <matthias.bgg@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <ulrich.hecht+renesas@gmail.com>,
        <laurent.pinchart@ideasonboard.com>, <matthias.bgg@gmail.com>,
        <sean.wang@mediatek.com>, <sean.wang@kernel.org>,
        <rdunlap@infradead.org>, <wens@csie.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Matthias Brugger <mbrugger@suse.com>
Date:   Mon, 19 Nov 2018 13:54:59 +0800
In-Reply-To: <20181116125449.23581-5-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
         <20181116125449.23581-5-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 95030AFA72897D3AD0014CE6ABCAA5791A1325FE45B1838E7C5D4DA0196640542000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

On Fri, 2018-11-16 at 13:54 +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The MMSYS subsystem includes clocks and drm components.
> This patch adds an initailization path through a platform device
> for the clock part, so that both drivers get probed from the same
> device tree compatible.

Looks good to me except one coding style preference.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 99dd612a6683..18fc761ba94f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -199,6 +199,7 @@ static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>  	.ext_path = mt2701_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
>  	.shadow_register = true,
> +	.clk_drv_name = "clk-mt2701-mm",
>  };
>  
>  static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
> @@ -215,6 +216,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>  	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
>  	.ext_path = mt8173_mtk_ddp_ext,
>  	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
> +	.clk_drv_name = "clk-mt8173-mm",
>  };
>  
>  static int mtk_drm_kms_init(struct drm_device *drm)
> @@ -473,6 +475,24 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	if (IS_ERR(private->config_regs))
>  		return PTR_ERR(private->config_regs);
>  
> +	/*
> +	 * For legacy reasons we need to probe the clock driver via
> +	 * a platfomr device. This is outdated and should not be used
> +	 * in newer SoCs.
> +	 */
> +	if (private->data->clk_drv_name) {
> +		private->clk_dev = platform_device_register_data(dev,
> +						private->data->clk_drv_name, -1,
> +						NULL, 0);
> +
> +		if (IS_ERR(private->clk_dev)) {
> +			pr_err("failed to register %s platform device\n",
> +						private->data->clk_drv_name);

I would like to align to the right of '('.

Regards,
CK

> +
> +			return PTR_ERR(private->clk_dev);
> +		}
> +	}
> +
>  	/* Iterate over sibling DISP function blocks */
>  	for_each_child_of_node(dev->of_node->parent, node) {
>  		const struct of_device_id *of_id;
> @@ -577,6 +597,9 @@ static int mtk_drm_remove(struct platform_device *pdev)
>  	for (i = 0; i < DDP_COMPONENT_ID_MAX; i++)
>  		of_node_put(private->comp_node[i]);
>  
> +	if (private->clk_dev)
> +		platform_device_unregister(private->clk_dev);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index ab0adbd7d4ee..515ac4cae922 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -37,11 +37,13 @@ struct mtk_mmsys_driver_data {
>  	unsigned int third_len;
>  
>  	bool shadow_register;
> +	const char *clk_drv_name;
>  };
>  
>  struct mtk_drm_private {
>  	struct drm_device *drm;
>  	struct device *dma_dev;
> +	struct platform_device *clk_dev;
>  
>  	unsigned int num_pipes;
>  


