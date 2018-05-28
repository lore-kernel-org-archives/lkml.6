Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbeE1HHu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:07:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55986 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753749AbeE1HHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:07:48 -0400
X-UUID: 17557f78f2934448bdb1bcba28d02821-20180528
Message-ID: <1527491263.24367.3.camel@mtksdaap41>
Subject: Re: [PATCH v4 4/9] drm/mediatek: add ddp component OD1
From: CK Hu <ck.hu@mediatek.com>
To: Stu Hsieh <stu.hsieh@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Mon, 28 May 2018 15:07:43 +0800
In-Reply-To: <1527489507-24453-5-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
         <1527489507-24453-5-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> This patch add the component OD1 and
> rename the OD to OD1

rename the OD to OD0

> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 4 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 7217665f4b5d..58e44349e315 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -114,7 +114,7 @@ static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
>  	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
>  	[DDP_COMPONENT_GAMMA] = MT8173_MUTEX_MOD_DISP_GAMMA,
> -	[DDP_COMPONENT_OD] = MT8173_MUTEX_MOD_DISP_OD,
> +	[DDP_COMPONENT_OD0] = MT8173_MUTEX_MOD_DISP_OD,
>  	[DDP_COMPONENT_OVL0] = MT8173_MUTEX_MOD_DISP_OVL0,
>  	[DDP_COMPONENT_OVL1] = MT8173_MUTEX_MOD_DISP_OVL1,
>  	[DDP_COMPONENT_PWM0] = MT8173_MUTEX_MOD_DISP_PWM0,
> @@ -139,7 +139,7 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
>  		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
>  		value = OVL_MOUT_EN_RDMA;
> -	} else if (cur == DDP_COMPONENT_OD && next == DDP_COMPONENT_RDMA0) {
> +	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
>  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>  		value = OD_MOUT_EN_RDMA0;
>  	} else if (cur == DDP_COMPONENT_UFOE && next == DDP_COMPONENT_DSI0) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 0919039805aa..87acf6be87f6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -227,7 +227,8 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
>  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
>  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> -	[DDP_COMPONENT_OD]	= { MTK_DISP_OD,	0, &ddp_od },
> +	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
> +	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
>  	[DDP_COMPONENT_OVL0]	= { MTK_DISP_OVL,	0, NULL },
>  	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
>  	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index eee3c0cc2632..9b19fc4423f1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -50,7 +50,8 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_DSI0,
>  	DDP_COMPONENT_DSI1,
>  	DDP_COMPONENT_GAMMA,
> -	DDP_COMPONENT_OD,
> +	DDP_COMPONENT_OD0,
> +	DDP_COMPONENT_OD1,
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_OVL1,
>  	DDP_COMPONENT_PWM0,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a415260f3d5f..08d5d0b47bfe 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -150,7 +150,7 @@ static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_COLOR0,
>  	DDP_COMPONENT_AAL0,
> -	DDP_COMPONENT_OD,
> +	DDP_COMPONENT_OD0,
>  	DDP_COMPONENT_RDMA0,
>  	DDP_COMPONENT_UFOE,
>  	DDP_COMPONENT_DSI0,
