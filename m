Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988F9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D0E2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D0E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbeIUP6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:58:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57271 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725898AbeIUP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:58:47 -0400
X-UUID: d6c39821f17f477194da91285e5ea235-20180921
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1222922817; Fri, 21 Sep 2018 18:10:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 18:10:31 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 18:10:31 +0800
Message-ID: <1537524631.20660.13.camel@mtksdaap41>
Subject: Re: [PATCH v3 09/12] drm/mediatek: add hdmi driver for MT2701 and
 MT7623
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Date:   Fri, 21 Sep 2018 18:10:31 +0800
In-Reply-To: <20180921032822.30771-10-bibby.hsieh@mediatek.com>
References: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
         <20180921032822.30771-10-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Fri, 2018-09-21 at 11:28 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> This patch adds hdmi dirver suppot for both MT2701 and MT7623.
> And also support other (existing or future) chips that use
> the same binding and driver.
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile              |   3 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi.c            |   9 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        |   3 +
>  drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |   2 +
>  drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c | 234 +++++++++++++++++++++++++
>  5 files changed, 248 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index 61cf0d2ab28a..82ae49c64221 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -19,7 +19,8 @@ obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
>  mediatek-drm-hdmi-objs := mtk_cec.o \
>  			  mtk_hdmi.o \
>  			  mtk_hdmi_ddc.o \
> +                          mtk_mt2701_hdmi_phy.o \
>  			  mtk_mt8173_hdmi_phy.o \
>  			  mtk_hdmi_phy.o
>  
> -obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
> \ No newline at end of file
> +obj-$(CONFIG_DRM_MEDIATEK_HDMI) += mediatek-drm-hdmi.o
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index d62e685cec73..11e3644da79a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -241,8 +241,13 @@ static void mtk_hdmi_hw_make_reg_writable(struct mtk_hdmi *hdmi, bool enable)
>  	 * The ARM trusted firmware provides an API for the HDMI driver to set
>  	 * this control bit to enable HDMI output in supervisor mode.
>  	 */
> -	arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904, 0x80000000,
> -		      0, 0, 0, 0, 0, &res);
> +	if (hdmi_phy->conf && hdmi_phy->conf->tz_disabled)
> +		regmap_update_bits(hdmi->sys_regmap,
> +				   hdmi->sys_offset + HDMI_SYS_CFG20,
> +				   0x80008005, enable ? 0x80000005 : 0x8000);
> +	else
> +		arm_smccc_smc(MTK_SIP_SET_AUTHORIZED_SECURE_REG, 0x14000904,
> +			      0x80000000, 0, 0, 0, 0, 0, &res);
>  
>  	regmap_update_bits(hdmi->sys_regmap, hdmi->sys_offset + HDMI_SYS_CFG20,
>  			   HDMI_PCLK_FREE_RUN, enable ? HDMI_PCLK_FREE_RUN : 0);
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> index d2dc50db1feb..52d314deacdc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
> @@ -192,6 +192,9 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id mtk_hdmi_phy_match[] = {
> +	{ .compatible = "mediatek,mt2701-hdmi-phy",
> +	  .data = &mtk_hdmi_phy_2701_conf,
> +	},
>  	{ .compatible = "mediatek,mt8173-hdmi-phy",
>  	  .data = &mtk_hdmi_phy_8173_conf,
>  	},
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> index e346fe319621..a6577c8fdf83 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
> @@ -20,6 +20,7 @@
>  struct mtk_hdmi_phy;
>  
>  struct mtk_hdmi_phy_conf {
> +	bool tz_disabled;
>  	const struct clk_ops *hdmi_phy_clk_ops;
>  	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
>  	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
> @@ -50,5 +51,6 @@ struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
>  
>  extern struct platform_driver mtk_hdmi_phy_driver;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
> +extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
>  
>  #endif /* _MTK_HDMI_PHY_H */
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> new file mode 100644
> index 000000000000..41f5dcc24c4e
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Chunhui Dai <chunhui.dai@mediatek.com>
> + */
> +
> +#include "mtk_hdmi_phy.h"
> +
> +#define HDMI_CON0	0x00
> +#define RG_HDMITX_DRV_IBIAS		0
> +#define RG_HDMITX_DRV_IBIAS_MASK	(0x3f << 0)
> +#define RG_HDMITX_EN_SER		12
> +#define RG_HDMITX_EN_SER_MASK		(0x0f << 12)
> +#define RG_HDMITX_EN_SLDO		16
> +#define RG_HDMITX_EN_SLDO_MASK		(0x0f << 16)
> +#define RG_HDMITX_EN_PRED		20
> +#define RG_HDMITX_EN_PRED_MASK		(0x0f << 20)
> +#define RG_HDMITX_EN_IMP		24
> +#define RG_HDMITX_EN_IMP_MASK		(0x0f << 24)
> +#define RG_HDMITX_EN_DRV		28
> +#define RG_HDMITX_EN_DRV_MASK		(0x0f << 28)
> +
> +#define HDMI_CON1	0x04
> +#define RG_HDMITX_PRED_IBIAS		18
> +#define RG_HDMITX_PRED_IBIAS_MASK	(0x0f << 18)
> +#define RG_HDMITX_PRED_IMP		(0x01 << 22)
> +#define RG_HDMITX_DRV_IMP		26
> +#define RG_HDMITX_DRV_IMP_MASK		(0x3f << 26)
> +
> +#define HDMI_CON2	0x08
> +#define RG_HDMITX_EN_TX_CKLDO		(0x01 << 0)
> +#define RG_HDMITX_EN_TX_POSDIV		(0x01 << 1)
> +#define RG_HDMITX_TX_POSDIV		3
> +#define RG_HDMITX_TX_POSDIV_MASK	(0x03 << 3)
> +#define RG_HDMITX_EN_MBIAS		(0x01 << 6)
> +#define RG_HDMITX_MBIAS_LPF_EN		(0x01 << 7)
> +
> +#define HDMI_CON4	0x10
> +#define RG_HDMITX_RESERVE_MASK		(0xffffffff << 0)
> +
> +#define HDMI_CON6	0x18
> +#define RG_HTPLL_BR			0
> +#define RG_HTPLL_BR_MASK		(0x03 << 0)
> +#define RG_HTPLL_BC			2
> +#define RG_HTPLL_BC_MASK		(0x03 << 2)
> +#define RG_HTPLL_BP			4
> +#define RG_HTPLL_BP_MASK		(0x0f << 4)
> +#define RG_HTPLL_IR			8
> +#define RG_HTPLL_IR_MASK		(0x0f << 8)
> +#define RG_HTPLL_IC			12
> +#define RG_HTPLL_IC_MASK		(0x0f << 12)
> +#define RG_HTPLL_POSDIV			16
> +#define RG_HTPLL_POSDIV_MASK		(0x03 << 16)
> +#define RG_HTPLL_PREDIV			18
> +#define RG_HTPLL_PREDIV_MASK		(0x03 << 18)
> +#define RG_HTPLL_FBKSEL			20
> +#define RG_HTPLL_FBKSEL_MASK		(0x03 << 20)
> +#define RG_HTPLL_RLH_EN			(0x01 << 22)
> +#define RG_HTPLL_FBKDIV			24
> +#define RG_HTPLL_FBKDIV_MASK		(0x7f << 24)
> +#define RG_HTPLL_EN			(0x01 << 31)
> +
> +#define HDMI_CON7	0x1c
> +#define RG_HTPLL_AUTOK_EN		(0x01 << 23)
> +#define RG_HTPLL_DIVEN			28
> +#define RG_HTPLL_DIVEN_MASK		(0x07 << 28)
> +
> +static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
> +	usleep_range(80, 100);
> +	return 0;
> +}
> +
> +static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
> +	usleep_range(80, 100);
> +}
> +
> +static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	u32 pos_div;
> +
> +	if (rate <= 64000000)
> +		pos_div = 3;
> +	else if (rate <= 12800000)
> +		pos_div = 1;
> +	else
> +		pos_div = 1;
> +
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_PREDIV_MASK);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IC),
> +			  RG_HTPLL_IC_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_IR),
> +			  RG_HTPLL_IR_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON2, (pos_div << RG_HDMITX_TX_POSDIV),
> +			  RG_HDMITX_TX_POSDIV_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (1 << RG_HTPLL_FBKSEL),
> +			  RG_HTPLL_FBKSEL_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (19 << RG_HTPLL_FBKDIV),
> +			  RG_HTPLL_FBKDIV_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON7, (0x2 << RG_HTPLL_DIVEN),
> +			  RG_HTPLL_DIVEN_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0xc << RG_HTPLL_BP),
> +			  RG_HTPLL_BP_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x2 << RG_HTPLL_BC),
> +			  RG_HTPLL_BC_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON6, (0x1 << RG_HTPLL_BR),
> +			  RG_HTPLL_BR_MASK);
> +
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON1, RG_HDMITX_PRED_IMP);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON1, (0x3 << RG_HDMITX_PRED_IBIAS),
> +			  RG_HDMITX_PRED_IBIAS_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_IMP_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON1, (0x28 << RG_HDMITX_DRV_IMP),
> +			  RG_HDMITX_DRV_IMP_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON4, 0x28, RG_HDMITX_RESERVE_MASK);
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_CON0, (0xa << RG_HDMITX_DRV_IBIAS),
> +			  RG_HDMITX_DRV_IBIAS_MASK);
> +	return 0;
> +}
> +
> +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long *parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	hdmi_phy->pll_rate = rate;
> +	if (rate <= 74250000)
> +		*parent_rate = rate;
> +	else
> +		*parent_rate = rate / 2;
> +
> +	return rate;
> +}

This function is identical to the one in mtk_mt8173_hdmi_phy.c, so try
to merge these two identical function into one.

> +
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	return hdmi_phy->pll_rate;
> +}

Ditto.

Regards,
CK

> +
> +static const struct clk_ops mtk_hdmi_phy_pll_ops = {
> +	.prepare = mtk_hdmi_pll_prepare,
> +	.unprepare = mtk_hdmi_pll_unprepare,
> +	.set_rate = mtk_hdmi_pll_set_rate,
> +	.round_rate = mtk_hdmi_pll_round_rate,
> +	.recalc_rate = mtk_hdmi_pll_recalc_rate,
> +};
> +
> +static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
> +{
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
> +	mtk_hdmi_phy_set_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
> +	usleep_range(80, 100);
> +}
> +
> +static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
> +{
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_DRV_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_PRED_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SER_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON0, RG_HDMITX_EN_SLDO_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_EN);
> +	usleep_range(80, 100);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON2, RG_HDMITX_EN_MBIAS);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_POSDIV_MASK);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON6, RG_HTPLL_RLH_EN);
> +	mtk_hdmi_phy_clear_bits(hdmi_phy, HDMI_CON7, RG_HTPLL_AUTOK_EN);
> +	usleep_range(80, 100);
> +}
> +
> +struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
> +	.tz_disabled = true,
> +	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
> +	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
> +	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
> +};
> +
> +MODULE_AUTHOR("Chunhui Dai <chunhui.dai@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek HDMI PHY Driver");
> +MODULE_LICENSE("GPL v2");


