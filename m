Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeE1JMx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:12:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58734 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754090AbeE1JMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:12:50 -0400
X-UUID: f45285dd0e594d9facfb43d9899fb34d-20180528
Message-ID: <1527498762.14913.6.camel@mtksdaap41>
Subject: Re: [PATCH v1 6/7] drm/mediatek: add a error return value when
 clock driver has been prepared
From: CK Hu <ck.hu@mediatek.com>
To: Bibby Hsieh <bibby.hsieh@mediatek.com>
CC: David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>
Date: Mon, 28 May 2018 17:12:42 +0800
In-Reply-To: <20180514075243.5442-7-bibby.hsieh@mediatek.com>
References: <20180514075243.5442-1-bibby.hsieh@mediatek.com>
         <20180514075243.5442-7-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Mon, 2018-05-14 at 15:52 +0800, Bibby Hsieh wrote:
> DRM driver get the comp->clk by of_clk_get(), we only
> assign NULL to comp->clk when error happened, but do
> not return the error number.
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 4672317e3ad1..d38a5303f8fc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -283,7 +283,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  	comp->irq = of_irq_get(node, 0);
>  	comp->clk = of_clk_get(node, 0);
>  	if (IS_ERR(comp->clk))
> -		comp->clk = NULL;
> +		return PTR_ERR(comp->clk);
>  
>  	/* Only DMA capable components need the LARB property */
>  	comp->larb_dev = NULL;
