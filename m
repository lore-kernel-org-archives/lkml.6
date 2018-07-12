Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D69BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C6F20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="goFxdsqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C6F20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeGLJRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:17:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36470 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:17:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so5244400wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xG0U8ckRyLqfbYv2MgXyQKIKh4jRKYBsAQ5jUFAJgrY=;
        b=goFxdsqZ95K2sBmKB77/v8zGXAL1ulHqm5HsL9OjLVX2JUBoTqr1eBELGtasDFlEZp
         1DWXoex9w1G5eQLB/45TinNEU58d6tuCZvPsqUoLBj+adQRqxLicUiTIPZ7oMS5idjnU
         S31QMpCoeDG23S2qiyuIYMpcSYPFIpSQT1hJ9a7RJcJ8lg7ufJLYAof3mDdF0vpXU3pI
         7KEOBC2haCP2Are7Hcm4/adiOCJsdbrb84vLr5nhY6VS62tkVVPfS3dc7IeovK9wDelx
         qBH/P4GstUWMKYWOEiQBs42FKi12QthjwhawkzehFAnXqIhyVc4iayrK6Qrsc1uXzdSw
         vLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xG0U8ckRyLqfbYv2MgXyQKIKh4jRKYBsAQ5jUFAJgrY=;
        b=Xgm8lQFVh0377DmQr9QfiS3S7n2gs78u0B5mCAFky9F3Ktdm59IDiFf8M0JD9kzbMC
         x2VCrpxrQa11/zXTuNIxP0hdqdFELmHAMtPA1qWtmJHOoN25jdcDucAci5gJpJkFm8Hh
         k9alBaFzrYXW7mKPUUzf0h0iClFMD8czSDlCbusFHd+6l8N8gus8H8HSpMWaz8Wo7z2g
         4w40PnsCJxBjYRiu20GbtcLymrFnulqST2iXb+ZVnqnzfVWnHQk32ePvpWsN63py11U0
         YjwwtEjk7qfDM38qTnPIB/Q1Nm+Sv7e332TUlGsllMJPZe2UNEy4TAek8EW8GsP214ff
         8GRg==
X-Gm-Message-State: AOUpUlGc94zRjkA4RHoZ+VARkwCRBGgK89lR/9D9ti6D3kYgtYquL7AA
        Z6jTcIiO/9aPyCtahEHVQuwDnQ==
X-Google-Smtp-Source: AAOMgpfWclP1iaTAQtGRhpnS0W/9tDvL3umZ37juH/jlTpsJFaqMsgXlIRhjkE14BKFQL6wQMfI8sg==
X-Received: by 2002:a1c:9754:: with SMTP id z81-v6mr835331wmd.35.1531386552153;
        Thu, 12 Jul 2018 02:09:12 -0700 (PDT)
Received: from boomer (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id l10-v6sm43665584wrv.23.2018.07.12.02.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 02:09:11 -0700 (PDT)
Message-ID: <1531386550.2708.171.camel@baylibre.com>
Subject: Re: [PATCH v2 3/3] clk: meson: add sub MMC clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Jul 2018 11:09:10 +0200
In-Reply-To: <20180710163658.6175-4-yixun.lan@amlogic.com>
References: <20180710163658.6175-1-yixun.lan@amlogic.com>
         <20180710163658.6175-4-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 16:36 +0000, Yixun Lan wrote:
> The patch will add a MMC clock controller driver which used by MMC or NAND,
> It provide a mux and divider clock, and three phase clocks - core, tx, tx.
> 
> Two clocks are provided as the parent of MMC clock controller from
> upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.
> 
> To specify which clock the MMC or NAND driver may consume,
> the preprocessor macros in the dt-bindings/clock/emmc-clkc.h header
> can be used in the device tree sources.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig    |   9 +
>  drivers/clk/meson/Makefile   |   1 +
>  drivers/clk/meson/mmc-clkc.c | 419 +++++++++++++++++++++++++++++++++++
>  3 files changed, 429 insertions(+)
>  create mode 100644 drivers/clk/meson/mmc-clkc.c
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index efaa70f682b4..edc18e65c89b 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -15,6 +15,15 @@ config COMMON_CLK_MESON_AO
>  	select COMMON_CLK_REGMAP_MESON
>  	select RESET_CONTROLLER
>  
> +config COMMON_CLK_MMC_MESON
> +	tristate "Meson MMC Sub Clock Controller Driver"
> +	depends on COMMON_CLK_AMLOGIC
> +	select MFD_SYSCON
> +	select REGMAP
> +	help
> +	  Support for the MMC sub clock controller on Amlogic Meson Platform,
> +	  Say Y if you want this clock enabled.
> +
>  config COMMON_CLK_REGMAP_MESON
>  	bool
>  	select REGMAP
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 72ec8c40d848..4b3817f80ba1 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
> +obj-$(CONFIG_COMMON_CLK_MMC_MESON) 	+= mmc-clkc.o
>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> new file mode 100644
> index 000000000000..43b7a376746d
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,419 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver

 * Copyright (c) 2017 Baylibre SAS.
 * Author: Jerome Brunet <jbrunet@baylibre.com>

Considering that a fair share of the code below has been copied from the clock
portion of the eMMC driver, which I wrote last year.

> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/amlogic,meson-mmc-clkc.h>
> +
> +#include "clkc.h"
> +
> +/* clock ID used by internal driver */
> +#define CLKID_MMC_MUX				0
> +#define CLKID_MMC_PHASE_CORE			2
> +
> +#define SD_EMMC_CLOCK		0
> +#define   CLK_DIV_MASK GENMASK(5, 0)
> +#define   CLK_SRC_MASK GENMASK(7, 6)
> +#define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
> +#define   CLK_TX_PHASE_MASK GENMASK(11, 10)
> +#define   CLK_RX_PHASE_MASK GENMASK(13, 12)
> +#define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
> +#define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
> +#define   CLK_V2_ALWAYS_ON BIT(24)
> +
> +#define   CLK_V3_TX_DELAY_MASK GENMASK(21, 16)
> +#define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
> +#define   CLK_V3_ALWAYS_ON BIT(28)
> +
> +#define   CLK_DELAY_STEP_PS 200
> +#define   CLK_PHASE_STEP 30
> +#define   CLK_PHASE_POINT_NUM (360 / CLK_PHASE_STEP)
> +
> +#define MUX_CLK_NUM_PARENTS	2
> +#define MMC_MAX_CLKS		5

Some defines are aligned, some aren't. please be consistent about it.
I personally prefer when things are aligned but it is just a preference.  

> +
> +struct clk_regmap_phase_data {

Considering the recent addition of clk_phase in clk/meson, it is not the best
name to choose.

clk_phase_delay_data ?

> +	unsigned long			phase_mask;
> +	unsigned long			delay_mask;
> +	unsigned int			delay_step_ps;
> +};
> +
> +struct mmc_clkc_data {
> +	struct clk_regmap_phase_data	tx;
> +	struct clk_regmap_phase_data	rx;
> +};



> +
> +struct mmc_clkc_info {
> +	struct device			*dev;

I don't think you need keep dev here, considering this is the device data.

> +	struct regmap			*map;
> +	struct mmc_clkc_data		*data;
> +};

Overall, I don't think you need this structure

> +
> +static inline struct clk_regmap_phase_data *
> +clk_get_regmap_phase_data(struct clk_regmap *clk)

Update name as well

> +{
> +	return (struct clk_regmap_phase_data *)clk->data;
> +}
> +
> +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
> +	.offset = SD_EMMC_CLOCK,
> +	.mask = 0x3,
> +	.shift = 6,
> +	.flags = CLK_DIVIDER_ROUND_CLOSEST,
> +};
> +
> +static struct clk_regmap_div_data mmc_clkc_div_data = {
> +	.offset = SD_EMMC_CLOCK,
> +	.shift = 0,
> +	.width = 6,
> +	.flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
> +};

Same comment on alignement. Some structure you've aligned, and some you haven't
Consistency ...

> +
> +static struct clk_regmap_phase_data mmc_clkc_core_phase = {
> +	.phase_mask	= CLK_CORE_PHASE_MASK,
> +};
> +
> +static const struct mmc_clkc_data mmc_clkc_gx_data = {
> +	{
> +		.phase_mask	= CLK_TX_PHASE_MASK,
> +		.delay_mask	= CLK_V2_TX_DELAY_MASK,
> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> +	},
> +	{
> +		.phase_mask	= CLK_RX_PHASE_MASK,
> +		.delay_mask	= CLK_V2_RX_DELAY_MASK,
> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> +	},
> +};
> +
> +static const struct mmc_clkc_data mmc_clkc_axg_data = {
> +	{
> +		.phase_mask	= CLK_TX_PHASE_MASK,
> +		.delay_mask	= CLK_V3_TX_DELAY_MASK,
> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> +	},
> +	{
> +		.phase_mask	= CLK_RX_PHASE_MASK,
> +		.delay_mask	= CLK_V3_RX_DELAY_MASK,
> +		.delay_step_ps	= CLK_DELAY_STEP_PS,
> +	},
> +};
> +
> +static const struct of_device_id mmc_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,meson-gx-mmc-clkc",
> +		.data = &mmc_clkc_gx_data
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-mmc-clkc",
> +		.data = &mmc_clkc_axg_data
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
> +
> +static struct clk_regmap *mmc_clkc_register_mux(struct mmc_clkc_info *clkc)
> +{
> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> +	struct device *dev = clkc->dev;
> +	struct clk_init_data init;
> +	struct clk_regmap *mux;
> +	struct clk *clk;
> +	char *mux_name;
> +	int i, ret;
> +
> +	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> +		char name[8];
> +
> +		snprintf(name, sizeof(name), "clkin%d", i);
> +		clk = devm_clk_get(dev, name);
> +		if (IS_ERR(clk)) {
> +			if (clk != ERR_PTR(-EPROBE_DEFER))
> +				dev_err(dev, "Missing clock %s\n", name);
> +			return ERR_PTR((long)clk);
> +		}
> +
> +		parent_names[i] = __clk_get_name(clk);
> +	}
> +
> +	mux_name = kasprintf(GFP_KERNEL, "%s#mux", dev_name(dev));
> +	if (!mux_name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mux->map = clkc->map;
> +	mux->data = &mmc_clkc_mux_data;
> +
> +	init.name = mux_name;
> +	init.ops = &clk_regmap_mux_ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_names = parent_names;
> +	init.num_parents = MUX_CLK_NUM_PARENTS;
> +
> +	mux->hw.init = &init;
> +	ret = devm_clk_hw_register(dev, &mux->hw);
> +	if (ret) {
> +		dev_err(dev, "Mux clock registration failed\n");
> +		mux = ERR_PTR(ret);
> +	}
> +
> +	kfree(mux_name);
> +	return mux;
> +}
> +
> +static struct clk_regmap *mmc_clkc_register_div(struct mmc_clkc_info *clkc)
> +{
> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> +	struct device *dev = clkc->dev;
> +	struct clk_init_data init;
> +	struct clk_regmap *div;
> +	char *mux_name, *div_name;
> +	int ret;
> +
> +	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +	if (!div)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mux_name = kasprintf(GFP_KERNEL, "%s#mux", dev_name(dev));
> +	div_name = kasprintf(GFP_KERNEL, "%s#div", dev_name(dev));
> +	if (!mux_name || !div_name) {
> +		div = ERR_PTR(-ENOMEM);
> +		goto err;
> +	}
> +
> +	parent_names[0] = mux_name;
> +	div->map = clkc->map;
> +	div->data = &mmc_clkc_div_data;
> +
> +	init.name = div_name;
> +	init.ops = &clk_regmap_divider_ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_names = parent_names;
> +	init.num_parents = 1;
> +
> +	div->hw.init = &init;
> +	ret = devm_clk_hw_register(dev, &div->hw);
> +	if (ret) {
> +		dev_err(dev, "Divider clock registration failed\n");
> +		div = ERR_PTR(ret);
> +	}
> +
> +err:
> +	kfree(mux_name);
> +	kfree(div_name);
> +	return div;
> +}
> +
> +static int clk_regmap_get_phase(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_phase_data *ph = clk_get_regmap_phase_data(clk);
> +	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
> +	unsigned long period_ps, p, d;
> +	int degrees;
> +	u32 val;
> +
> +	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
> +	p = (val & ph->phase_mask) >> __ffs(ph->phase_mask);
> +	degrees = p * 360 / phase_num;
> +
> +	if (ph->delay_mask) {
> +		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> +					 clk_get_rate(hw->clk));
> +		d = (val & ph->delay_mask) >> __ffs(ph->delay_mask);
> +		degrees += d * ph->delay_step_ps * 360 / period_ps;
> +		degrees %= 360;
> +	}
> +
> +	return degrees;
> +}
> +
> +static void clk_regmap_apply_phase_delay(struct clk_regmap *clk,
> +					 unsigned int phase,
> +					 unsigned int delay)
> +{
> +	struct clk_regmap_phase_data *ph = clk->data;
> +	u32 val;
> +
> +	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
> +
> +	val &= ~ph->phase_mask;
> +	val |= phase << __ffs(ph->phase_mask);
> +
> +	if (ph->delay_mask) {
> +		val &= ~ph->delay_mask;
> +		val |= delay << __ffs(ph->delay_mask);
> +	}
> +
> +	regmap_write(clk->map, SD_EMMC_CLOCK, val);
> +}
> +
> +static int clk_regmap_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_phase_data *ph = clk_get_regmap_phase_data(clk);
> +	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
> +	unsigned long period_ps, d = 0, r;
> +	u64 p;
> +
> +	p = degrees % 360;
> +
> +	if (!ph->delay_mask) {
> +		p = DIV_ROUND_CLOSEST_ULL(p, 360 / phase_num);
> +	} else {
> +		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
> +					 clk_get_rate(hw->clk));
> +
> +		/* First compute the phase index (p), the remainder (r) is the
> +		 * part we'll try to acheive using the delays (d).
> +		 */
> +		r = do_div(p, 360 / phase_num);
> +		d = DIV_ROUND_CLOSEST(r * period_ps,
> +				      360 * ph->delay_step_ps);
> +		d = min(d, ph->delay_mask >> __ffs(ph->delay_mask));
> +	}
> +
> +	clk_regmap_apply_phase_delay(clk, p, d);
> +	return 0;
> +}
> +
> +static const struct clk_ops clk_regmap_phase_ops = {
> +	.get_phase = clk_regmap_get_phase,
> +	.set_phase = clk_regmap_set_phase,
> +};
> +
> +static struct clk_regmap *
> +mmc_clkc_register_phase_clk(struct mmc_clkc_info *clkc,
> +			    char *name, char *parent_name, unsigned long flags,
> +			    struct clk_regmap_phase_data *phase_data)
> +
> +{
> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> +	struct device *dev = clkc->dev;
> +	struct clk_init_data init;
> +	struct clk_regmap *x;

x is not a very good name, 'clk' is just 2 more letters ...

> +	char *clk_name, *core_name;
> +	int ret;
> +
> +	/* create the mmc rx clock */
> +	x = devm_kzalloc(dev, sizeof(*x), GFP_KERNEL);
> +	if (!x)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clk_name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), name);
> +	core_name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), parent_name);
> +
> +	if (!clk_name || !core_name) {
> +		x = ERR_PTR(-ENOMEM);
> +		goto err;
> +	}
> +	parent_names[0] = core_name;
> +
> +	init.name = clk_name;
> +	init.ops = &clk_regmap_phase_ops;
> +	init.flags = flags;
> +	init.parent_names = parent_names;
> +	init.num_parents = 1;
> +
> +	x->map = clkc->map;
> +	x->data = phase_data;
> +	x->hw.init = &init;
> +
> +	ret = devm_clk_hw_register(dev, &x->hw);
> +	if (ret) {
> +		dev_err(dev, "Core %s clock registration failed\n", name);
> +		x = ERR_PTR(ret);
> +	}
> +err:
> +	kfree(clk_name);
> +	kfree(core_name);
> +	return x;
> +}

In all your mmc_clkc_register_xxx_() you should a pattern repeating itself. It
is something I pointed out in the previous version of your patchset

1. allocate a clk_regmap
2. allocate a clock name using dev name and a suffix.
3. register clk_hw
4. free clock name
5. return clk_regmap

You should be able to make an helper function out of this
Prototype will probably look like this:

static struct clk_regmap *
mmc_clkc_register_clk(struct device *dev, struct regmap *map,
		      struct clk_init_data *init, const char* suffix)

> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mmc_clkc_info *clkc;
> +	struct clk_regmap *mux, *div, *core, *rx, *tx;
> +	struct clk_hw_onecell_data *onecell_data;
> +
> +	clkc = devm_kzalloc(dev, sizeof(*clkc), GFP_KERNEL);
> +	if (!clkc)
> +		return -ENOMEM;
> +
> +	clkc->data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> +	if (!clkc->data)
> +		return -EINVAL;

Prefer ENODEV for this

> +
> +	clkc->dev = dev;
> +	clkc->map = syscon_node_to_regmap(dev->of_node);
> +
> +	if (IS_ERR(clkc->map)) {
> +		dev_err(dev, "could not find mmc clock controller\n");
> +		return PTR_ERR(clkc->map);
> +	}
> +
> +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> +				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> +				    GFP_KERNEL);
> +	if (!onecell_data)
> +		return -ENOMEM;
> +
> +	mux = mmc_clkc_register_mux(clkc);
> +	if (IS_ERR(mux))
> +		return PTR_ERR(mux);
> +
> +	div = mmc_clkc_register_div(clkc);
> +	if (IS_ERR(div))
> +		return PTR_ERR(div);
> +
> +	core = mmc_clkc_register_phase_clk(clkc, "core", "div",
> +					   CLK_SET_RATE_PARENT,
> +					   &mmc_clkc_core_phase);
> +	if (IS_ERR(core))
> +		return PTR_ERR(core);
> +
> +	rx = mmc_clkc_register_phase_clk(clkc, "rx", "core", 0,
> +					 &clkc->data->rx);
> +	if (IS_ERR(rx))
> +		return PTR_ERR(rx);
> +
> +	tx = mmc_clkc_register_phase_clk(clkc, "tx", "core", 0,
> +					 &clkc->data->tx);
> +	if (IS_ERR(tx))
> +		return PTR_ERR(tx);
> +
> +	onecell_data->hws[CLKID_MMC_MUX]		= &mux->hw,
> +	onecell_data->hws[CLKID_MMC_DIV]		= &div->hw,
> +	onecell_data->hws[CLKID_MMC_PHASE_CORE]		= &core->hw,
> +	onecell_data->hws[CLKID_MMC_PHASE_RX]		= &rx->hw,
> +	onecell_data->hws[CLKID_MMC_PHASE_TX]		= &tx->hw,
> +	onecell_data->num				= MMC_MAX_CLKS;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   onecell_data);
> +}
> +
> +static struct platform_driver mmc_clkc_driver = {
> +	.probe		= mmc_clkc_probe,
> +	.driver		= {
> +		.name	= "meson-mmc-clkc",
> +		.of_match_table = of_match_ptr(mmc_clkc_match_table),
> +	},
> +};
> +
> +module_platform_driver(mmc_clkc_driver);

