Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BD2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90721214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeL0E0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 23:26:39 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:64249 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728877AbeL0E0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 23:26:39 -0500
X-UUID: 2ba5b45eb5224a44a7c1ae143cbddafe-20181227
X-UUID: 2ba5b45eb5224a44a7c1ae143cbddafe-20181227
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 544729285; Thu, 27 Dec 2018 12:26:29 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Dec 2018 12:26:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 12:26:22 +0800
Message-ID: <1545884782.31506.4.camel@mtksdaap41>
Subject: Re: [PATCH 13/18] drm/mediatek: add ddp write register common api
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 27 Dec 2018 12:26:22 +0800
In-Reply-To: <1545638931-24938-14-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-14-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Mon, 2018-12-24 at 16:08 +0800, Yongqiang Niu wrote:
> This patch add ddp write register common api
> 

I could not see anywhere you use these function. If the function is
useless, drop this patch.

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  9 +++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index a97e27b..1c0f9cc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -84,6 +84,30 @@
>  #define DITHER_ADD_LSHIFT_G(x)			(((x) & 0x7) << 4)
>  #define DITHER_ADD_RSHIFT_G(x)			(((x) & 0x7) << 0)
>  
> +void mtk_ddp_write(unsigned int value, struct mtk_ddp_comp *comp,
> +		   unsigned int offset)
> +{
> +	writel(value, comp->regs + offset);
> +}
> +
> +void mtk_ddp_write_relaxed(unsigned int value,
> +			   struct mtk_ddp_comp *comp,
> +			   unsigned int offset)
> +{
> +	writel_relaxed(value, comp->regs + offset);
> +}
> +
> +void mtk_ddp_write_mask(unsigned int value,
> +			struct mtk_ddp_comp *comp,
> +			unsigned int offset,
> +			unsigned int mask)
> +{
> +	unsigned int tmp = readl(comp->regs + offset);
> +
> +	tmp = (tmp & ~mask) | (value & mask);
> +	writel(tmp, comp->regs + offset);
> +}
> +
>  void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
>  		    unsigned int CFG)
>  {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index f2ab0b3..b908172 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -189,5 +189,14 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
>  void mtk_ddp_comp_unregister(struct drm_device *drm, struct mtk_ddp_comp *comp);
>  void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
>  		    unsigned int CFG);
> +void mtk_ddp_write(unsigned int value, struct mtk_ddp_comp *comp,
> +		   unsigned int offset);
> +void mtk_ddp_write_relaxed(unsigned int value,
> +			   struct mtk_ddp_comp *comp,
> +			   unsigned int offset);
> +void mtk_ddp_write_mask(unsigned int value,
> +			struct mtk_ddp_comp *comp,
> +			unsigned int offset,
> +			unsigned int mask);
>  
>  #endif /* MTK_DRM_DDP_COMP_H */


