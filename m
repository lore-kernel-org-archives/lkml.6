Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeEWGB1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:01:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35387 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753826AbeEWGBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:01:23 -0400
X-UUID: 2e36f803cada46e784c00468cbb84cdf-20180523
Message-ID: <1527055278.21354.3.camel@mtksdaap41>
Subject: Re: [PATCH v2 4/4] drm/mediatek: add connection from OD1 to RDMA1
From: CK Hu <ck.hu@mediatek.com>
To: Stu Hsieh <stu.hsieh@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date: Wed, 23 May 2018 14:01:18 +0800
In-Reply-To: <20180523022517.12103-5-stu.hsieh@mediatek.com>
References: <20180523022517.12103-1-stu.hsieh@mediatek.com>
         <20180523022517.12103-5-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Wed, 2018-05-23 at 10:25 +0800, Stu Hsieh wrote:
> This patch add the connection from OD1 to RDMA1 for ext path.
> 

I would like to apply this patch before the patch 'Add support for
mediatek SOC MT2712' because this patch is necessary for mt2712.

Regards,
CK

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 3c7bd453cf42..0450ecbbc356 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -193,6 +193,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_GAMMA && next == DDP_COMPONENT_RDMA1) {
>  		*addr = DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN;
>  		value = GAMMA_MOUT_EN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
> +		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> +		value = OD1_MOUT_EN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
>  		value = RDMA1_MOUT_DPI0;
