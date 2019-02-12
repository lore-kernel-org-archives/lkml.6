Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A141221773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCWFps42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfBLJ2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:28:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34881 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:28:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2203736wmt.0;
        Tue, 12 Feb 2019 01:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LAebnQ7Geg5hsDLf4SnvcfVdYt31rDHKOHcsdy+ISZs=;
        b=BCWFps42AzwNJDIxQ+VC12PHYUBEsatqjUDRQtc8upapeF+HPQuc6rHRAyLTyIocmz
         8SCdBGbENCGiXzIwujnbcAn0lDtBw20zIuYY9iqbWA2Hpbp0WHf6HUEV+15ZnYiQefjJ
         cEebW4mDtrKGDR9ilfNQQ8GsdCOi7Z4IdR9sDh/hlC/bKPJens880klXgS1trk3nxKTd
         acXs6Tf5Hf6h1Il7v0Gslx+B6YJOEh7wU10zibfdBUOQcws5/aNMf7p/lCNZQdKYUnWb
         fqcjelRywkulQswkC64k0pZuhOwpLfhUVWvh3F81wzej8U8UaNMWaoCqrfUnse7KCDjc
         7NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LAebnQ7Geg5hsDLf4SnvcfVdYt31rDHKOHcsdy+ISZs=;
        b=SL7sxMSBUhdUPZuXuRtf0xZvBBVeAhi8f+RdJLYAN2l6rRIpfEv6TwKKKbVsNat2cu
         QFluzyk8OJNpwFrMcK8pUxVJ6rIbpFAsYnkqj+Q+U9hJl9NpqA7AfTnx4qFfVFeqNSFG
         EI8ExqBjOUtJn0ZdW125KSa2mc5eK82GorIUOpskEgqeaPphMkqQ/ryELQ/o8QYXclsu
         87y9kMl0Gr+ZmA7Tiv60kP9NwoepU65obRvbBq6wetHhJAzcXt1pFqQ2hjoPRfjE32Px
         cd3uYIy4lGAMhFODkVcTfqf2gAf1Dg8XUxylldn59FhM7hOwXLmPXjpcpsVUZ30zBceB
         d8AA==
X-Gm-Message-State: AHQUAuZbzpXangS/+HONpSYJxlpbunV5YwdVGSuixJWeDMbgPb0n/0XL
        +DcwakUELQI+YddZ8U/po6A=
X-Google-Smtp-Source: AHgI3IapMhBhSkBmLocUlR0TqtIXRA6KJUTepwRnxvAc8FGekH09EkePPeBAXVzXH23fTmjXHS1FQQ==
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr2174494wme.82.1549963711773;
        Tue, 12 Feb 2019 01:28:31 -0800 (PST)
Received: from ziggy.stardust ([93.176.159.17])
        by smtp.gmail.com with ESMTPSA id y185sm1253399wmg.34.2019.02.12.01.28.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:28:30 -0800 (PST)
Subject: Re: [PATCH] drm/mediatek: add mipi_tx driver for mt8183
To:     Jitao Shi <jitao.shi@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>
Cc:     Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
References: <20190212061901.116564-1-jitao.shi@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <151323a2-2b44-74b9-3a8d-b53b79a06aee@gmail.com>
Date:   Tue, 12 Feb 2019 10:28:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190212061901.116564-1-jitao.shi@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2019 07:19, Jitao Shi wrote:
> This patch adds mipi tx driver support for mt8183.
> 
> Mipi_tx of mt8183 is very different to mt8173.
> 1.Separate mipi tx setting to mtk_mt8173_mipi_tx.c for mt8173
> 2.Separate mipi tx setting to mtk_mt8183_mipi_tx.c for mt8183
> 3.To reuse the common code, make the common functions in mtk_mipi_tx.c
> 

I hadn't a look on the code, but this commit message already indicates, that you
should split this up in several patches.
Something like this:
1. patch: carve out common functions to mtk_mipi_tx.c at this point only used by
mt8173
2. patch: add support for mt8183

Regards,
Matthias

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
> 
