Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B26C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB62921717
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB62921717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeHCHCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 03:02:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22942 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726679AbeHCHCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 03:02:53 -0400
X-UUID: 80fc7dc2ce9c48729e0917e3fe643da1-20180803
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 735136145; Fri, 03 Aug 2018 13:08:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 13:08:14 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 13:08:14 +0800
Message-ID: <1533272894.31144.4.camel@mtksdaap41>
Subject: Re: [PATCH v2 10/15] drm/mediatek: add function to get layer number
 for component
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Fri, 3 Aug 2018 13:08:14 +0800
In-Reply-To: <1533265868-28110-11-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
         <1533265868-28110-11-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Fri, 2018-08-03 at 11:11 +0800, Stu Hsieh wrote:
> This patch add function to get layer number for component
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index a1988ce15141..8377e4f9ce3d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -78,6 +78,7 @@ struct mtk_ddp_comp_funcs {
>  	void (*stop)(struct mtk_ddp_comp *comp);
>  	void (*enable_vblank)(struct mtk_ddp_comp *comp, struct drm_crtc *crtc);
>  	void (*disable_vblank)(struct mtk_ddp_comp *comp);
> +	unsigned int (*layer_nr)(struct mtk_ddp_comp *comp);
>  	void (*layer_on)(struct mtk_ddp_comp *comp, unsigned int idx);
>  	void (*layer_off)(struct mtk_ddp_comp *comp, unsigned int idx);
>  	void (*layer_config)(struct mtk_ddp_comp *comp, unsigned int idx,
> @@ -129,6 +130,12 @@ static inline void mtk_ddp_comp_disable_vblank(struct mtk_ddp_comp *comp)
>  		comp->funcs->disable_vblank(comp);
>  }
>  
> +static inline unsigned int mtk_ddp_comp_layer_nr(struct mtk_ddp_comp *comp)
> +{
> +	if (comp->funcs && comp->funcs->layer_nr)
> +		return comp->funcs->layer_nr(comp);
> +}
> +
>  static inline void mtk_ddp_comp_layer_on(struct mtk_ddp_comp *comp,
>  					 unsigned int idx)
>  {


