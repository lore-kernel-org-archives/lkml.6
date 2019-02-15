Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DC621916
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbfBOIaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:30:02 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:27193 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727937AbfBOIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:30:01 -0500
X-UUID: 9ca868ff352c4fb7b96f7810f16f81bc-20190215
X-UUID: 9ca868ff352c4fb7b96f7810f16f81bc-20190215
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1065571313; Fri, 15 Feb 2019 16:29:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS33N1.mediatek.inc (172.27.4.75) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 16:29:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 16:29:21 +0800
Message-ID: <1550219361.15764.4.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: add mipi_tx driver for mt8183
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <linux-pwm@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        "Ajay Kumar" <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        "Rahul Sharma" <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Russell King" <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <stonea168@163.com>
Date:   Fri, 15 Feb 2019 16:29:21 +0800
In-Reply-To: <20190212061901.116564-1-jitao.shi@mediatek.com>
References: <20190212061901.116564-1-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

On Tue, 2019-02-12 at 14:19 +0800, Jitao Shi wrote:
> This patch adds mipi tx driver support for mt8183.
> 
> Mipi_tx of mt8183 is very different to mt8173.
> 1.Separate mipi tx setting to mtk_mt8173_mipi_tx.c for mt8173
> 2.Separate mipi tx setting to mtk_mt8183_mipi_tx.c for mt8183
> 3.To reuse the common code, make the common functions in mtk_mipi_tx.c
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/Makefile             |   2 +
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.c        | 352 ++----------------
>  drivers/gpu/drm/mediatek/mtk_mipi_tx.h        |  52 +++
>  drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c | 290 +++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c | 168 +++++++++
>  5 files changed, 549 insertions(+), 315 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mipi_tx.h
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> 
> diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> index 82ae49c64221..8067a4be8311 100644
> --- a/drivers/gpu/drm/mediatek/Makefile
> +++ b/drivers/gpu/drm/mediatek/Makefile
> @@ -12,6 +12,8 @@ mediatek-drm-y := mtk_disp_color.o \
>  		  mtk_drm_plane.o \
>  		  mtk_dsi.o \
>  		  mtk_mipi_tx.o \
> +		  mtk_mt8173_mipi_tx.o \
> +		  mtk_mt8183_mipi_tx.o \
>  		  mtk_dpi.o
>  
>  obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> index 90e913108950..7591a38ca565 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.c
> @@ -11,292 +11,45 @@
>   * GNU General Public License for more details.
>   */
>  
> -#include <linux/clk.h>
> -#include <linux/clk-provider.h>
> -#include <linux/delay.h>
> -#include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/of_device.h>
> -#include <linux/platform_device.h>
> -#include <linux/phy/phy.h>
> -
> -#define MIPITX_DSI_CON		0x00
> -#define RG_DSI_LDOCORE_EN		BIT(0)
> -#define RG_DSI_CKG_LDOOUT_EN		BIT(1)
> -#define RG_DSI_BCLK_SEL			(3 << 2)
> -#define RG_DSI_LD_IDX_SEL		(7 << 4)
> -#define RG_DSI_PHYCLK_SEL		(2 << 8)
> -#define RG_DSI_DSICLK_FREQ_SEL		BIT(10)
> -#define RG_DSI_LPTX_CLMP_EN		BIT(11)
> -
> -#define MIPITX_DSI_CLOCK_LANE	0x04
> -#define MIPITX_DSI_DATA_LANE0	0x08
> -#define MIPITX_DSI_DATA_LANE1	0x0c
> -#define MIPITX_DSI_DATA_LANE2	0x10
> -#define MIPITX_DSI_DATA_LANE3	0x14
> -#define RG_DSI_LNTx_LDOOUT_EN		BIT(0)
> -#define RG_DSI_LNTx_CKLANE_EN		BIT(1)
> -#define RG_DSI_LNTx_LPTX_IPLUS1		BIT(2)
> -#define RG_DSI_LNTx_LPTX_IPLUS2		BIT(3)
> -#define RG_DSI_LNTx_LPTX_IMINUS		BIT(4)
> -#define RG_DSI_LNTx_LPCD_IPLUS		BIT(5)
> -#define RG_DSI_LNTx_LPCD_IMINUS		BIT(6)
> -#define RG_DSI_LNTx_RT_CODE		(0xf << 8)
> -
> -#define MIPITX_DSI_TOP_CON	0x40
> -#define RG_DSI_LNT_INTR_EN		BIT(0)
> -#define RG_DSI_LNT_HS_BIAS_EN		BIT(1)
> -#define RG_DSI_LNT_IMP_CAL_EN		BIT(2)
> -#define RG_DSI_LNT_TESTMODE_EN		BIT(3)
> -#define RG_DSI_LNT_IMP_CAL_CODE		(0xf << 4)
> -#define RG_DSI_LNT_AIO_SEL		(7 << 8)
> -#define RG_DSI_PAD_TIE_LOW_EN		BIT(11)
> -#define RG_DSI_DEBUG_INPUT_EN		BIT(12)
> -#define RG_DSI_PRESERVE			(7 << 13)
> -
> -#define MIPITX_DSI_BG_CON	0x44
> -#define RG_DSI_BG_CORE_EN		BIT(0)
> -#define RG_DSI_BG_CKEN			BIT(1)
> -#define RG_DSI_BG_DIV			(0x3 << 2)
> -#define RG_DSI_BG_FAST_CHARGE		BIT(4)
> -#define RG_DSI_VOUT_MSK			(0x3ffff << 5)
> -#define RG_DSI_V12_SEL			(7 << 5)
> -#define RG_DSI_V10_SEL			(7 << 8)
> -#define RG_DSI_V072_SEL			(7 << 11)
> -#define RG_DSI_V04_SEL			(7 << 14)
> -#define RG_DSI_V032_SEL			(7 << 17)
> -#define RG_DSI_V02_SEL			(7 << 20)
> -#define RG_DSI_BG_R1_TRIM		(0xf << 24)
> -#define RG_DSI_BG_R2_TRIM		(0xf << 28)
> -
> -#define MIPITX_DSI_PLL_CON0	0x50
> -#define RG_DSI_MPPLL_PLL_EN		BIT(0)
> -#define RG_DSI_MPPLL_DIV_MSK		(0x1ff << 1)
> -#define RG_DSI_MPPLL_PREDIV		(3 << 1)
> -#define RG_DSI_MPPLL_TXDIV0		(3 << 3)
> -#define RG_DSI_MPPLL_TXDIV1		(3 << 5)
> -#define RG_DSI_MPPLL_POSDIV		(7 << 7)
> -#define RG_DSI_MPPLL_MONVC_EN		BIT(10)
> -#define RG_DSI_MPPLL_MONREF_EN		BIT(11)
> -#define RG_DSI_MPPLL_VOD_EN		BIT(12)
> -
> -#define MIPITX_DSI_PLL_CON1	0x54
> -#define RG_DSI_MPPLL_SDM_FRA_EN		BIT(0)
> -#define RG_DSI_MPPLL_SDM_SSC_PH_INIT	BIT(1)
> -#define RG_DSI_MPPLL_SDM_SSC_EN		BIT(2)
> -#define RG_DSI_MPPLL_SDM_SSC_PRD	(0xffff << 16)
> -
> -#define MIPITX_DSI_PLL_CON2	0x58
> -
> -#define MIPITX_DSI_PLL_TOP	0x64
> -#define RG_DSI_MPPLL_PRESERVE		(0xff << 8)
> -
> -#define MIPITX_DSI_PLL_PWR	0x68
> -#define RG_DSI_MPPLL_SDM_PWR_ON		BIT(0)
> -#define RG_DSI_MPPLL_SDM_ISO_EN		BIT(1)
> -#define RG_DSI_MPPLL_SDM_PWR_ACK	BIT(8)
> -
> -#define MIPITX_DSI_SW_CTRL	0x80
> -#define SW_CTRL_EN			BIT(0)
> -
> -#define MIPITX_DSI_SW_CTRL_CON0	0x84
> -#define SW_LNTC_LPTX_PRE_OE		BIT(0)
> -#define SW_LNTC_LPTX_OE			BIT(1)
> -#define SW_LNTC_LPTX_P			BIT(2)
> -#define SW_LNTC_LPTX_N			BIT(3)
> -#define SW_LNTC_HSTX_PRE_OE		BIT(4)
> -#define SW_LNTC_HSTX_OE			BIT(5)
> -#define SW_LNTC_HSTX_ZEROCLK		BIT(6)
> -#define SW_LNT0_LPTX_PRE_OE		BIT(7)
> -#define SW_LNT0_LPTX_OE			BIT(8)
> -#define SW_LNT0_LPTX_P			BIT(9)
> -#define SW_LNT0_LPTX_N			BIT(10)
> -#define SW_LNT0_HSTX_PRE_OE		BIT(11)
> -#define SW_LNT0_HSTX_OE			BIT(12)
> -#define SW_LNT0_LPRX_EN			BIT(13)
> -#define SW_LNT1_LPTX_PRE_OE		BIT(14)
> -#define SW_LNT1_LPTX_OE			BIT(15)
> -#define SW_LNT1_LPTX_P			BIT(16)
> -#define SW_LNT1_LPTX_N			BIT(17)
> -#define SW_LNT1_HSTX_PRE_OE		BIT(18)
> -#define SW_LNT1_HSTX_OE			BIT(19)
> -#define SW_LNT2_LPTX_PRE_OE		BIT(20)
> -#define SW_LNT2_LPTX_OE			BIT(21)
> -#define SW_LNT2_LPTX_P			BIT(22)
> -#define SW_LNT2_LPTX_N			BIT(23)
> -#define SW_LNT2_HSTX_PRE_OE		BIT(24)
> -#define SW_LNT2_HSTX_OE			BIT(25)
> -
> -struct mtk_mipitx_data {
> -	const u32 mppll_preserve;
> -};
> -
> -struct mtk_mipi_tx {
> -	struct device *dev;
> -	void __iomem *regs;
> -	u32 data_rate;
> -	const struct mtk_mipitx_data *driver_data;
> -	struct clk_hw pll_hw;
> -	struct clk *pll;
> -};
> +#include "mtk_mipi_tx.h"
>  
> -static inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw)
> +inline struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw)
>  {
>  	return container_of(hw, struct mtk_mipi_tx, pll_hw);
>  }
>  
> -static void mtk_mipi_tx_clear_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
> -				   u32 bits)
> +void mtk_mipi_tx_clear_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
> +			    u32 bits)
>  {
>  	u32 temp = readl(mipi_tx->regs + offset);
>  
>  	writel(temp & ~bits, mipi_tx->regs + offset);
>  }
>  
> -static void mtk_mipi_tx_set_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
> -				 u32 bits)
> +void mtk_mipi_tx_set_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
> +			  u32 bits)
>  {
>  	u32 temp = readl(mipi_tx->regs + offset);
>  
>  	writel(temp | bits, mipi_tx->regs + offset);
>  }
>  
> -static void mtk_mipi_tx_update_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
> -				    u32 mask, u32 data)
> +void mtk_mipi_tx_update_bits(struct mtk_mipi_tx *mipi_tx, u32 offset,
> +			     u32 mask, u32 data)
>  {
>  	u32 temp = readl(mipi_tx->regs + offset);
>  
>  	writel((temp & ~mask) | (data & mask), mipi_tx->regs + offset);
>  }
>  
> -static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> -{
> -	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> -	u8 txdiv, txdiv0, txdiv1;
> -	u64 pcw;
> -
> -	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
> -
> -	if (mipi_tx->data_rate >= 500000000) {
> -		txdiv = 1;
> -		txdiv0 = 0;
> -		txdiv1 = 0;
> -	} else if (mipi_tx->data_rate >= 250000000) {
> -		txdiv = 2;
> -		txdiv0 = 1;
> -		txdiv1 = 0;
> -	} else if (mipi_tx->data_rate >= 125000000) {
> -		txdiv = 4;
> -		txdiv0 = 2;
> -		txdiv1 = 0;
> -	} else if (mipi_tx->data_rate > 62000000) {
> -		txdiv = 8;
> -		txdiv0 = 2;
> -		txdiv1 = 1;
> -	} else if (mipi_tx->data_rate >= 50000000) {
> -		txdiv = 16;
> -		txdiv0 = 2;
> -		txdiv1 = 2;
> -	} else {
> -		return -EINVAL;
> -	}
> -
> -	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
> -				RG_DSI_VOUT_MSK |
> -				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
> -				(4 << 20) | (4 << 17) | (4 << 14) |
> -				(4 << 11) | (4 << 8) | (4 << 5) |
> -				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
> -
> -	usleep_range(30, 100);
> -
> -	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> -				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
> -				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
> -
> -	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_CON,
> -			     RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
> -
> -	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
> -				RG_DSI_MPPLL_SDM_PWR_ON |
> -				RG_DSI_MPPLL_SDM_ISO_EN,
> -				RG_DSI_MPPLL_SDM_PWR_ON);
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> -			       RG_DSI_MPPLL_PLL_EN);
> -
> -	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> -				RG_DSI_MPPLL_TXDIV0 | RG_DSI_MPPLL_TXDIV1 |
> -				RG_DSI_MPPLL_PREDIV,
> -				(txdiv0 << 3) | (txdiv1 << 5));
> -
> -	/*
> -	 * PLL PCW config
> -	 * PCW bit 24~30 = integer part of pcw
> -	 * PCW bit 0~23 = fractional part of pcw
> -	 * pcw = data_Rate*4*txdiv/(Ref_clk*2);
> -	 * Post DIV =4, so need data_Rate*4
> -	 * Ref_clk is 26MHz
> -	 */
> -	pcw = div_u64(((u64)mipi_tx->data_rate * 2 * txdiv) << 24,
> -		      26000000);
> -	writel(pcw, mipi_tx->regs + MIPITX_DSI_PLL_CON2);
> -
> -	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
> -			     RG_DSI_MPPLL_SDM_FRA_EN);
> -
> -	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_PLL_EN);
> -
> -	usleep_range(20, 100);
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
> -			       RG_DSI_MPPLL_SDM_SSC_EN);
> -
> -	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> -				RG_DSI_MPPLL_PRESERVE,
> -				mipi_tx->driver_data->mppll_preserve);
> -
> -	return 0;
> -}
> -
> -static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
> -{
> -	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> -
> -	dev_dbg(mipi_tx->dev, "unprepare\n");
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> -			       RG_DSI_MPPLL_PLL_EN);
> -
> -	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> -				RG_DSI_MPPLL_PRESERVE, 0);
> -
> -	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
> -				RG_DSI_MPPLL_SDM_ISO_EN |
> -				RG_DSI_MPPLL_SDM_PWR_ON,
> -				RG_DSI_MPPLL_SDM_ISO_EN);
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> -			       RG_DSI_LNT_HS_BIAS_EN);
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_CON,
> -			       RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_BG_CON,
> -			       RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> -			       RG_DSI_MPPLL_DIV_MSK);
> -}
> -
> -static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> -				       unsigned long *prate)
> +long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *prate)
>  {
>  	return clamp_val(rate, 50000000, 1250000000);
>  }
>  
> -static int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> -				    unsigned long parent_rate)
> +int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long parent_rate)
>  {
>  	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
>  
> @@ -307,37 +60,14 @@ static int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> -static unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
> -						 unsigned long parent_rate)
> +unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
>  {
>  	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
>  
>  	return mipi_tx->data_rate;
>  }
>  
> -static const struct clk_ops mtk_mipi_tx_pll_ops = {
> -	.prepare = mtk_mipi_tx_pll_prepare,
> -	.unprepare = mtk_mipi_tx_pll_unprepare,
> -	.round_rate = mtk_mipi_tx_pll_round_rate,
> -	.set_rate = mtk_mipi_tx_pll_set_rate,
> -	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
> -};
> -
> -static int mtk_mipi_tx_power_on_signal(struct phy *phy)
> -{
> -	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> -	u32 reg;
> -
> -	for (reg = MIPITX_DSI_CLOCK_LANE;
> -	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
> -		mtk_mipi_tx_set_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
> -
> -	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> -			       RG_DSI_PAD_TIE_LOW_EN);
> -
> -	return 0;
> -}
> -
>  static int mtk_mipi_tx_power_on(struct phy *phy)
>  {
>  	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> @@ -349,30 +79,16 @@ static int mtk_mipi_tx_power_on(struct phy *phy)
>  		return ret;
>  
>  	/* Enable DSI Lane LDO outputs, disable pad tie low */
> -	mtk_mipi_tx_power_on_signal(phy);
> -
> +	mipi_tx->driver_data->mipi_tx_enable_signal(phy);
>  	return 0;
>  }
>  
> -static void mtk_mipi_tx_power_off_signal(struct phy *phy)
> -{
> -	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> -	u32 reg;
> -
> -	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> -			     RG_DSI_PAD_TIE_LOW_EN);
> -
> -	for (reg = MIPITX_DSI_CLOCK_LANE;
> -	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
> -		mtk_mipi_tx_clear_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
> -}
> -
>  static int mtk_mipi_tx_power_off(struct phy *phy)
>  {
>  	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
>  
>  	/* Enable pad tie low, disable DSI Lane LDO outputs */
> -	mtk_mipi_tx_power_off_signal(phy);
> +	mipi_tx->driver_data->mipi_tx_disable_signal(phy);
>  
>  	/* Disable PLL and power down core */
>  	clk_disable_unprepare(mipi_tx->pll);
> @@ -386,15 +102,23 @@ static const struct phy_ops mtk_mipi_tx_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static void mtk_mipi_tx_clk_get_ops(struct mtk_mipi_tx *mipi_tx,
> +				    const struct clk_ops **ops)
> +{
> +	if (mipi_tx && mipi_tx->driver_data &&
> +	    mipi_tx->driver_data->mipi_tx_clk_ops)
> +		*ops = mipi_tx->driver_data->mipi_tx_clk_ops;
> +	else
> +		dev_err(mipi_tx->dev, "Failed to get clk ops of phy\n");
> +}
> +
>  static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct mtk_mipi_tx *mipi_tx;
>  	struct resource *mem;
> -	struct clk *ref_clk;
>  	const char *ref_clk_name;
>  	struct clk_init_data clk_init = {
> -		.ops = &mtk_mipi_tx_pll_ops,
>  		.num_parents = 1,
>  		.parent_names = (const char * const *)&ref_clk_name,
>  		.flags = CLK_SET_RATE_GATE,
> @@ -408,6 +132,7 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mipi_tx->driver_data = of_device_get_match_data(dev);
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mipi_tx->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(mipi_tx->regs)) {
> @@ -416,13 +141,14 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ref_clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(ref_clk)) {
> -		ret = PTR_ERR(ref_clk);
> +	mipi_tx->ref_clk = devm_clk_get(dev, "ref_clk");

I do not see "ref_clk" in binding document [1]. In mt8173.dtsi [2] , it
also has no this parameter. Does this patch work for MT8173?

Regards,
CK

[1]
https://www.kernel.org/doc/Documentation/devicetree/bindings/display/mediatek/mediatek%2Cdsi.txt
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/mediatek/mt8173.dtsi


> +	if (IS_ERR(mipi_tx->ref_clk)) {
> +		ret = PTR_ERR(mipi_tx->ref_clk);
>  		dev_err(dev, "Failed to get reference clock: %d\n", ret);
>  		return ret;
>  	}
> -	ref_clk_name = __clk_get_name(ref_clk);
> +
> +	ref_clk_name = __clk_get_name(mipi_tx->ref_clk);
>  
>  	ret = of_property_read_string(dev->of_node, "clock-output-names",
>  				      &clk_init.name);
> @@ -431,6 +157,8 @@ static int mtk_mipi_tx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	mtk_mipi_tx_clk_get_ops(mipi_tx, &clk_init.ops);
> +
>  	mipi_tx->pll_hw.init = &clk_init;
>  	mipi_tx->pll = devm_clk_register(dev, &mipi_tx->pll_hw);
>  	if (IS_ERR(mipi_tx->pll)) {
> @@ -465,20 +193,14 @@ static int mtk_mipi_tx_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct mtk_mipitx_data mt2701_mipitx_data = {
> -	.mppll_preserve = (3 << 8)
> -};
> -
> -static const struct mtk_mipitx_data mt8173_mipitx_data = {
> -	.mppll_preserve = (0 << 8)
> -};
> -
>  static const struct of_device_id mtk_mipi_tx_match[] = {
>  	{ .compatible = "mediatek,mt2701-mipi-tx",
>  	  .data = &mt2701_mipitx_data },
>  	{ .compatible = "mediatek,mt8173-mipi-tx",
>  	  .data = &mt8173_mipitx_data },
> -	{},
> +	{ .compatible = "mediatek,mt8183-mipi-tx",
> +	  .data = &mt8183_mipitx_data },
> +	{ },
>  };
>  
>  struct platform_driver mtk_mipi_tx_driver = {
> diff --git a/drivers/gpu/drm/mediatek/mtk_mipi_tx.h b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> new file mode 100644
> index 000000000000..af83023e81cf
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_mipi_tx.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Jitao Shi <jitao.shi@mediatek.com>
> + */
> +
> +#ifndef _MTK_MIPI_TX_H
> +#define _MTK_MIPI_TX_H
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +
> +struct mtk_mipitx_data {
> +	const u32 mppll_preserve;
> +	const struct clk_ops *mipi_tx_clk_ops;
> +	void (*mipi_tx_enable_signal)(struct phy *phy);
> +	void (*mipi_tx_disable_signal)(struct phy *phy);
> +};
> +
> +struct mtk_mipi_tx {
> +	struct device *dev;
> +	void __iomem *regs;
> +	u32 data_rate;
> +	struct clk *ref_clk;
> +	const struct mtk_mipitx_data *driver_data;
> +	struct clk_hw pll_hw;
> +	struct clk *pll;
> +};
> +
> +struct mtk_mipi_tx *mtk_mipi_tx_from_clk_hw(struct clk_hw *hw);
> +void mtk_mipi_tx_clear_bits(struct mtk_mipi_tx *mipi_tx, u32 offset, u32 bits);
> +void mtk_mipi_tx_set_bits(struct mtk_mipi_tx *mipi_tx, u32 offset, u32 bits);
> +void mtk_mipi_tx_update_bits(struct mtk_mipi_tx *mipi_tx, u32 offset, u32 mask,
> +			     u32 data);
> +long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *prate);
> +int mtk_mipi_tx_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long parent_rate);
> +unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate);
> +
> +extern const struct mtk_mipitx_data mt2701_mipitx_data;
> +extern const struct mtk_mipitx_data mt8173_mipitx_data;
> +extern const struct mtk_mipitx_data mt8183_mipitx_data;
> +
> +#endif
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
> new file mode 100644
> index 000000000000..8e57cdf85b06
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8173_mipi_tx.c
> @@ -0,0 +1,290 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "mtk_mipi_tx.h"
> +
> +#define MIPITX_DSI_CON		0x00
> +#define RG_DSI_LDOCORE_EN		BIT(0)
> +#define RG_DSI_CKG_LDOOUT_EN		BIT(1)
> +#define RG_DSI_BCLK_SEL			(3 << 2)
> +#define RG_DSI_LD_IDX_SEL		(7 << 4)
> +#define RG_DSI_PHYCLK_SEL		(2 << 8)
> +#define RG_DSI_DSICLK_FREQ_SEL		BIT(10)
> +#define RG_DSI_LPTX_CLMP_EN		BIT(11)
> +
> +#define MIPITX_DSI_CLOCK_LANE	0x04
> +#define MIPITX_DSI_DATA_LANE0	0x08
> +#define MIPITX_DSI_DATA_LANE1	0x0c
> +#define MIPITX_DSI_DATA_LANE2	0x10
> +#define MIPITX_DSI_DATA_LANE3	0x14
> +#define RG_DSI_LNTx_LDOOUT_EN		BIT(0)
> +#define RG_DSI_LNTx_CKLANE_EN		BIT(1)
> +#define RG_DSI_LNTx_LPTX_IPLUS1		BIT(2)
> +#define RG_DSI_LNTx_LPTX_IPLUS2		BIT(3)
> +#define RG_DSI_LNTx_LPTX_IMINUS		BIT(4)
> +#define RG_DSI_LNTx_LPCD_IPLUS		BIT(5)
> +#define RG_DSI_LNTx_LPCD_IMINUS		BIT(6)
> +#define RG_DSI_LNTx_RT_CODE		(0xf << 8)
> +
> +#define MIPITX_DSI_TOP_CON	0x40
> +#define RG_DSI_LNT_INTR_EN		BIT(0)
> +#define RG_DSI_LNT_HS_BIAS_EN		BIT(1)
> +#define RG_DSI_LNT_IMP_CAL_EN		BIT(2)
> +#define RG_DSI_LNT_TESTMODE_EN		BIT(3)
> +#define RG_DSI_LNT_IMP_CAL_CODE		(0xf << 4)
> +#define RG_DSI_LNT_AIO_SEL		(7 << 8)
> +#define RG_DSI_PAD_TIE_LOW_EN		BIT(11)
> +#define RG_DSI_DEBUG_INPUT_EN		BIT(12)
> +#define RG_DSI_PRESERVE			(7 << 13)
> +
> +#define MIPITX_DSI_BG_CON	0x44
> +#define RG_DSI_BG_CORE_EN		BIT(0)
> +#define RG_DSI_BG_CKEN			BIT(1)
> +#define RG_DSI_BG_DIV			(0x3 << 2)
> +#define RG_DSI_BG_FAST_CHARGE		BIT(4)
> +#define RG_DSI_VOUT_MSK			(0x3ffff << 5)
> +#define RG_DSI_V12_SEL			(7 << 5)
> +#define RG_DSI_V10_SEL			(7 << 8)
> +#define RG_DSI_V072_SEL			(7 << 11)
> +#define RG_DSI_V04_SEL			(7 << 14)
> +#define RG_DSI_V032_SEL			(7 << 17)
> +#define RG_DSI_V02_SEL			(7 << 20)
> +#define RG_DSI_BG_R1_TRIM		(0xf << 24)
> +#define RG_DSI_BG_R2_TRIM		(0xf << 28)
> +
> +#define MIPITX_DSI_PLL_CON0	0x50
> +#define RG_DSI_MPPLL_PLL_EN		BIT(0)
> +#define RG_DSI_MPPLL_DIV_MSK		(0x1ff << 1)
> +#define RG_DSI_MPPLL_PREDIV		(3 << 1)
> +#define RG_DSI_MPPLL_TXDIV0		(3 << 3)
> +#define RG_DSI_MPPLL_TXDIV1		(3 << 5)
> +#define RG_DSI_MPPLL_POSDIV		(7 << 7)
> +#define RG_DSI_MPPLL_MONVC_EN		BIT(10)
> +#define RG_DSI_MPPLL_MONREF_EN		BIT(11)
> +#define RG_DSI_MPPLL_VOD_EN		BIT(12)
> +
> +#define MIPITX_DSI_PLL_CON1	0x54
> +#define RG_DSI_MPPLL_SDM_FRA_EN		BIT(0)
> +#define RG_DSI_MPPLL_SDM_SSC_PH_INIT	BIT(1)
> +#define RG_DSI_MPPLL_SDM_SSC_EN		BIT(2)
> +#define RG_DSI_MPPLL_SDM_SSC_PRD	(0xffff << 16)
> +
> +#define MIPITX_DSI_PLL_CON2	0x58
> +
> +#define MIPITX_DSI_PLL_TOP	0x64
> +#define RG_DSI_MPPLL_PRESERVE		(0xff << 8)
> +
> +#define MIPITX_DSI_PLL_PWR	0x68
> +#define RG_DSI_MPPLL_SDM_PWR_ON		BIT(0)
> +#define RG_DSI_MPPLL_SDM_ISO_EN		BIT(1)
> +#define RG_DSI_MPPLL_SDM_PWR_ACK	BIT(8)
> +
> +#define MIPITX_DSI_SW_CTRL	0x80
> +#define SW_CTRL_EN			BIT(0)
> +
> +#define MIPITX_DSI_SW_CTRL_CON0	0x84
> +#define SW_LNTC_LPTX_PRE_OE		BIT(0)
> +#define SW_LNTC_LPTX_OE			BIT(1)
> +#define SW_LNTC_LPTX_P			BIT(2)
> +#define SW_LNTC_LPTX_N			BIT(3)
> +#define SW_LNTC_HSTX_PRE_OE		BIT(4)
> +#define SW_LNTC_HSTX_OE			BIT(5)
> +#define SW_LNTC_HSTX_ZEROCLK		BIT(6)
> +#define SW_LNT0_LPTX_PRE_OE		BIT(7)
> +#define SW_LNT0_LPTX_OE			BIT(8)
> +#define SW_LNT0_LPTX_P			BIT(9)
> +#define SW_LNT0_LPTX_N			BIT(10)
> +#define SW_LNT0_HSTX_PRE_OE		BIT(11)
> +#define SW_LNT0_HSTX_OE			BIT(12)
> +#define SW_LNT0_LPRX_EN			BIT(13)
> +#define SW_LNT1_LPTX_PRE_OE		BIT(14)
> +#define SW_LNT1_LPTX_OE			BIT(15)
> +#define SW_LNT1_LPTX_P			BIT(16)
> +#define SW_LNT1_LPTX_N			BIT(17)
> +#define SW_LNT1_HSTX_PRE_OE		BIT(18)
> +#define SW_LNT1_HSTX_OE			BIT(19)
> +#define SW_LNT2_LPTX_PRE_OE		BIT(20)
> +#define SW_LNT2_LPTX_OE			BIT(21)
> +#define SW_LNT2_LPTX_P			BIT(22)
> +#define SW_LNT2_LPTX_N			BIT(23)
> +#define SW_LNT2_HSTX_PRE_OE		BIT(24)
> +#define SW_LNT2_HSTX_OE			BIT(25)
> +
> +static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +	u8 txdiv, txdiv0, txdiv1;
> +	u64 pcw;
> +
> +	dev_dbg(mipi_tx->dev, "prepare: %u Hz\n", mipi_tx->data_rate);
> +
> +	if (mipi_tx->data_rate >= 500000000) {
> +		txdiv = 1;
> +		txdiv0 = 0;
> +		txdiv1 = 0;
> +	} else if (mipi_tx->data_rate >= 250000000) {
> +		txdiv = 2;
> +		txdiv0 = 1;
> +		txdiv1 = 0;
> +	} else if (mipi_tx->data_rate >= 125000000) {
> +		txdiv = 4;
> +		txdiv0 = 2;
> +		txdiv1 = 0;
> +	} else if (mipi_tx->data_rate > 62000000) {
> +		txdiv = 8;
> +		txdiv0 = 2;
> +		txdiv1 = 1;
> +	} else if (mipi_tx->data_rate >= 50000000) {
> +		txdiv = 16;
> +		txdiv0 = 2;
> +		txdiv1 = 2;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_BG_CON,
> +				RG_DSI_VOUT_MSK |
> +				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN,
> +				(4 << 20) | (4 << 17) | (4 << 14) |
> +				(4 << 11) | (4 << 8) | (4 << 5) |
> +				RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
> +
> +	usleep_range(30, 100);
> +
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> +				RG_DSI_LNT_IMP_CAL_CODE | RG_DSI_LNT_HS_BIAS_EN,
> +				(8 << 4) | RG_DSI_LNT_HS_BIAS_EN);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_CON,
> +			     RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
> +
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
> +				RG_DSI_MPPLL_SDM_PWR_ON |
> +				RG_DSI_MPPLL_SDM_ISO_EN,
> +				RG_DSI_MPPLL_SDM_PWR_ON);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> +			       RG_DSI_MPPLL_PLL_EN);
> +
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> +				RG_DSI_MPPLL_TXDIV0 | RG_DSI_MPPLL_TXDIV1 |
> +				RG_DSI_MPPLL_PREDIV,
> +				(txdiv0 << 3) | (txdiv1 << 5));
> +
> +	/*
> +	 * PLL PCW config
> +	 * PCW bit 24~30 = integer part of pcw
> +	 * PCW bit 0~23 = fractional part of pcw
> +	 * pcw = data_Rate*4*txdiv/(Ref_clk*2);
> +	 * Post DIV =4, so need data_Rate*4
> +	 * Ref_clk is 26MHz
> +	 */
> +	pcw = div_u64(((u64)mipi_tx->data_rate * 2 * txdiv) << 24,
> +		      26000000);
> +	writel(pcw, mipi_tx->regs + MIPITX_DSI_PLL_CON2);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
> +			     RG_DSI_MPPLL_SDM_FRA_EN);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_PLL_CON0, RG_DSI_MPPLL_PLL_EN);
> +
> +	usleep_range(20, 100);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON1,
> +			       RG_DSI_MPPLL_SDM_SSC_EN);
> +
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> +				RG_DSI_MPPLL_PRESERVE,
> +				mipi_tx->driver_data->mppll_preserve);
> +
> +	return 0;
> +}
> +
> +static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +
> +	dev_dbg(mipi_tx->dev, "unprepare\n");
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> +			       RG_DSI_MPPLL_PLL_EN);
> +
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_TOP,
> +				RG_DSI_MPPLL_PRESERVE, 0);
> +
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_DSI_PLL_PWR,
> +				RG_DSI_MPPLL_SDM_ISO_EN |
> +				RG_DSI_MPPLL_SDM_PWR_ON,
> +				RG_DSI_MPPLL_SDM_ISO_EN);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> +			       RG_DSI_LNT_HS_BIAS_EN);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_CON,
> +			       RG_DSI_CKG_LDOOUT_EN | RG_DSI_LDOCORE_EN);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_BG_CON,
> +			       RG_DSI_BG_CKEN | RG_DSI_BG_CORE_EN);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_PLL_CON0,
> +			       RG_DSI_MPPLL_DIV_MSK);
> +}
> +
> +static const struct clk_ops mtk_mipi_tx_pll_ops = {
> +	.prepare = mtk_mipi_tx_pll_prepare,
> +	.unprepare = mtk_mipi_tx_pll_unprepare,
> +	.round_rate = mtk_mipi_tx_pll_round_rate,
> +	.set_rate = mtk_mipi_tx_pll_set_rate,
> +	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
> +};
> +
> +static void mtk_mipi_tx_power_on_signal(struct phy *phy)
> +{
> +	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> +	u32 reg;
> +
> +	for (reg = MIPITX_DSI_CLOCK_LANE;
> +	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
> +		mtk_mipi_tx_set_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> +			       RG_DSI_PAD_TIE_LOW_EN);
> +}
> +
> +static void mtk_mipi_tx_power_off_signal(struct phy *phy)
> +{
> +	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> +	u32 reg;
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_DSI_TOP_CON,
> +			     RG_DSI_PAD_TIE_LOW_EN);
> +
> +	for (reg = MIPITX_DSI_CLOCK_LANE;
> +	     reg <= MIPITX_DSI_DATA_LANE3; reg += 4)
> +		mtk_mipi_tx_clear_bits(mipi_tx, reg, RG_DSI_LNTx_LDOOUT_EN);
> +}
> +
> +const struct mtk_mipitx_data mt2701_mipitx_data = {
> +	.mppll_preserve = (3 << 8),
> +	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
> +	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
> +	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
> +};
> +
> +const struct mtk_mipitx_data mt8173_mipitx_data = {
> +	.mppll_preserve = (0 << 8),
> +	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
> +	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
> +	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
> +};
> +
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> new file mode 100644
> index 000000000000..07f70a3cad13
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8183_mipi_tx.c
> @@ -0,0 +1,168 @@
> +/*
> + * Copyright (c) 2015 MediaTek Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "mtk_mipi_tx.h"
> +
> +#define MIPITX_LANE_CON		0x000c
> +#define RG_DSI_CPHY_T1DRV_EN	BIT(0)
> +#define RG_DSI_ANA_CK_SEL	BIT(1)
> +#define RG_DSI_PHY_CK_SEL	BIT(2)
> +#define RG_DSI_CPHY_EN	BIT(3)
> +#define RG_DSI_PHYCK_INV_EN	BIT(4)
> +#define RG_DSI_PWR04_EN	BIT(5)
> +#define RG_DSI_BG_LPF_EN	BIT(6)
> +#define RG_DSI_BG_CORE_EN	BIT(7)
> +#define RG_DSI_PAD_TIEL_SEL	BIT(8)
> +
> +#define MIPITX_PLL_PWR		0x0028
> +#define MIPITX_PLL_CON0		0x002c
> +#define MIPITX_PLL_CON1		0x0030
> +#define MIPITX_PLL_CON2		0x0034
> +#define MIPITX_PLL_CON3		0x0038
> +#define MIPITX_PLL_CON4		0x003c
> +#define RG_DSI_PLL_IBIAS	(3 << 10)
> +
> +#define MIPITX_D2_SW_CTL_EN	0x0144
> +#define MIPITX_D0_SW_CTL_EN	0x0244
> +#define MIPITX_CK_CKMODE_EN	0x0328
> +#define DSI_CK_CKMODE_EN	BIT(0)
> +#define MIPITX_CK_SW_CTL_EN	0x0344
> +#define MIPITX_D1_SW_CTL_EN	0x0444
> +#define MIPITX_D3_SW_CTL_EN	0x0544
> +#define DSI_SW_CTL_EN		BIT(0)
> +#define AD_DSI_PLL_SDM_PWR_ON	BIT(0)
> +#define AD_DSI_PLL_SDM_ISO_EN	BIT(1)
> +
> +#define RG_DSI_PLL_EN		BIT(4)
> +#define RG_DSI_PLL_POSDIV	(0x7 << 8)
> +
> +static int mtk_mipi_tx_pll_prepare(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +	unsigned int txdiv, txdiv0, txdiv1;
> +	u64 pcw;
> +	int ret;
> +
> +	dev_dbg(mipi_tx->dev, "prepare: %u bps\n", mipi_tx->data_rate);
> +
> +	if (mipi_tx->data_rate >= 2000000000) {
> +		txdiv = 1;
> +		txdiv0 = 0;
> +		txdiv1 = 0;
> +	} else if (mipi_tx->data_rate >= 1000000000) {
> +		txdiv = 2;
> +		txdiv0 = 1;
> +		txdiv1 = 0;
> +	} else if (mipi_tx->data_rate >= 500000000) {
> +		txdiv = 4;
> +		txdiv0 = 2;
> +		txdiv1 = 0;
> +	} else if (mipi_tx->data_rate > 250000000) {
> +		txdiv = 8;
> +		txdiv0 = 3;
> +		txdiv1 = 0;
> +	} else if (mipi_tx->data_rate >= 125000000) {
> +		txdiv = 16;
> +		txdiv0 = 4;
> +		txdiv1 = 0;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_prepare_enable(mipi_tx->ref_clk);
> +	if (ret < 0) {
> +		dev_err(mipi_tx->dev, "can't mipi_tx ref_clk %d\n", ret);
> +		return ret;
> +	}
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> +	usleep_range(30, 100);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> +	pcw = div_u64(((u64)mipi_tx->data_rate * txdiv) << 24, 26000000);
> +	writel(pcw, mipi_tx->regs + MIPITX_PLL_CON0);
> +	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV,
> +				txdiv0 << 8);
> +	usleep_range(1000, 2000);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +
> +	return 0;
> +}
> +
> +static void mtk_mipi_tx_pll_unprepare(struct clk_hw *hw)
> +{
> +	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
> +
> +	dev_dbg(mipi_tx->dev, "unprepare\n");
> +
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
> +	/* step 1: SDM_RWR_ON / SDM_ISO_EN */
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
> +	clk_disable_unprepare(mipi_tx->ref_clk);
> +}
> +
> +static const struct clk_ops mtk_mipi_tx_pll_ops = {
> +	.prepare = mtk_mipi_tx_pll_prepare,
> +	.unprepare = mtk_mipi_tx_pll_unprepare,
> +	.round_rate = mtk_mipi_tx_pll_round_rate,
> +	.set_rate = mtk_mipi_tx_pll_set_rate,
> +	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
> +};
> +
> +static void mtk_mipi_tx_power_on_signal(struct phy *phy)
> +{
> +	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> +
> +	/* BG_LPF_EN / BG_CORE_EN */
> +	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
> +	       mipi_tx->regs + MIPITX_LANE_CON);
> +	usleep_range(30, 100);
> +	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN,
> +	       mipi_tx->regs + MIPITX_LANE_CON);
> +
> +	/* Switch OFF each Lane */
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
> +
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
> +}
> +
> +static void mtk_mipi_tx_power_off_signal(struct phy *phy)
> +{
> +	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
> +
> +	/* Switch ON each Lane */
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
> +	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
> +
> +	/* step 2 */
> +	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
> +	       mipi_tx->regs + MIPITX_LANE_CON);
> +	writel(RG_DSI_PAD_TIEL_SEL, mipi_tx->regs + MIPITX_LANE_CON);
> +}
> +
> +const struct mtk_mipitx_data mt8183_mipitx_data = {
> +	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
> +	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
> +	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
> +};
> +


