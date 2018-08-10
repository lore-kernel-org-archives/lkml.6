Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54FAC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FA1223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="um8QGU7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FA1223F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeHJPRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:17:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46914 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeHJPRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:17:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so8168597wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0up0PDc7SV3gxBfNhXR6Y2sfCGipUJS/fpAjhKN2ow=;
        b=um8QGU7dEaAxCkeDW7Q7HRb6ujrB31A4ObWXRxHLQQFODmnRDQi967riThVvfXxqtG
         VMqpo64SeBHbUaDc9IKnSoE/rcpatfci2EDl2WcxRKSu9VwswFP6T/8aIF76bxy59wXN
         wxv22a6z8gmH8XVkzwC8Wb4TQgHZ/6JpXX3Jav9g8+47fGNkSj0mPZxYMbc547fXtMzg
         F3s0h13fh6TrOMqoddP+NzKodVUgXi40ZjD4vg0XLYxEyXrytGcE333i1lpiOVwPk5Ev
         cxzWykGpW6E3oFkDbTW148vKW0uRdeBlSnPwMd0OQTa+1icEZTyDo1RtPHGyy8QB/ZQL
         bXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0up0PDc7SV3gxBfNhXR6Y2sfCGipUJS/fpAjhKN2ow=;
        b=f8NhwnsR9WGL9lutnFT+VP+nsa1KmF3NBhxbxqbenpfOPO5IzgivyyQTTanCifNl60
         2cyUfc+J5dqql+jtOKUQ6owPl3YFzCMGZu45Jmu/RarPrxzlOfEt6N7Ez6CYhXyEQw7j
         3lrI22xdHAxuE9mSfdvj3dg+UxCSlf3OsBVnNYeRN6xOAuhq5JV7/INAfDCFMPlyOH+8
         nFK9lENPGgtgufihrgxJsszgQNiFuLKmLNRqYBuFwlfmXVMTBoj8kV6bwaJqTfuvqxPm
         q9WCc7GGK10nxRGa/i5DqriWcFqTq6JI6/Nhi15+6Ug/IIlXhA+GembZ5Zv9LCm08quJ
         GI+Q==
X-Gm-Message-State: AOUpUlEsUa+W9UPjEsKWTWsn7/g7aIQ/eJhk7g8jO0AiebBqm3nIhzO2
        fPbQEQ5aC39vV5XYLHh4CBK9gA==
X-Google-Smtp-Source: AA+uWPz9uPQcX9XxYUoeKCiBZlXD0uRKmkxIDbtESso5/qC3b4Rl+2P+Wohkjvf8285w5IVBxx82TA==
X-Received: by 2002:adf:b642:: with SMTP id i2-v6mr3960400wre.54.1533905282478;
        Fri, 10 Aug 2018 05:48:02 -0700 (PDT)
Received: from boomer (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id i205-v6sm1962138wmf.30.2018.08.10.05.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 05:48:01 -0700 (PDT)
Message-ID: <bc425f1926ddc1b426be5902bf3595ff556670d3.camel@baylibre.com>
Subject: Re: [PATCH v4 3/3] clk: meson: add sub MMC clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Aug 2018 14:47:59 +0200
In-Reply-To: <20180809070724.11935-4-yixun.lan@amlogic.com>
References: <20180809070724.11935-1-yixun.lan@amlogic.com>
         <20180809070724.11935-4-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 15:07 +0800, Yixun Lan wrote:
> The patch will add a MMC clock controller driver which used by MMC or NAND,
> It provide a mux and divider clock, and three phase clocks - core, tx, tx.
> 
> Two clocks are provided as the parent of MMC clock controller from
> upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.
> 
> To specify which clock the MMC or NAND driver may consume,
> the preprocessor macros in the dt-bindings/clock/amlogic,mmc-clkc.h header
> can be used in the device tree sources.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig    |  10 ++
>  drivers/clk/meson/Makefile   |   1 +
>  drivers/clk/meson/mmc-clkc.c | 275 +++++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>  create mode 100644 drivers/clk/meson/mmc-clkc.c
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index efaa70f682b4..8b8ccbcfed1d 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -15,6 +15,16 @@ config COMMON_CLK_MESON_AO
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
> +	  which include S905 (GXBB, GXL), A113D/X (AXG) devices.
> +	  Say Y if you want this clock enabled.
> +
>  config COMMON_CLK_REGMAP_MESON
>  	bool
>  	select REGMAP
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 39ce5661b654..31c16d524a4b 100644
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
> index 000000000000..6aa055f7e62c
> --- /dev/null
> +++ b/drivers/clk/meson/mmc-clkc.c
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/amlogic,mmc-clkc.h>
> +
> +#include "clkc.h"
> +
> +/* clock ID used by internal driver */
> +#define CLKID_MMC_MUX			0
> +
> +#define SD_EMMC_CLOCK			0
> +#define   CLK_DIV_MASK			GENMASK(5, 0)
> +#define   CLK_SRC_MASK			GENMASK(7, 6)
> +#define   CLK_CORE_PHASE_MASK		GENMASK(9, 8)
> +#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
> +#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
> +#define   CLK_V2_TX_DELAY_MASK		GENMASK(19, 16)
> +#define   CLK_V2_RX_DELAY_MASK		GENMASK(23, 20)
> +#define   CLK_V2_ALWAYS_ON		BIT(24)
> +
> +#define   CLK_V3_TX_DELAY_MASK		GENMASK(21, 16)
> +#define   CLK_V3_RX_DELAY_MASK		GENMASK(27, 22)
> +#define   CLK_V3_ALWAYS_ON		BIT(28)
> +
> +#define   CLK_DELAY_STEP_PS		200
> +#define   CLK_PHASE_STEP		30
> +#define   CLK_PHASE_POINT_NUM		(360 / CLK_PHASE_STEP)
> +
> +#define MUX_CLK_NUM_PARENTS		2
> +#define MMC_MAX_CLKS			5
> +
> +struct mmc_clkc_data {
> +	struct meson_clk_phase_delay_data	tx;
> +	struct meson_clk_phase_delay_data	rx;
> +};
> +
> +static struct clk_regmap_mux_data mmc_clkc_mux_data = {
> +	.offset		= SD_EMMC_CLOCK,
> +	.mask		= 0x3,
> +	.shift		= 6,
> +	.flags		= CLK_DIVIDER_ROUND_CLOSEST,
> +};
> +
> +static struct clk_regmap_div_data mmc_clkc_div_data = {
> +	.offset		= SD_EMMC_CLOCK,
> +	.shift		= 0,
> +	.width		= 6,
> +	.flags		= CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
> +};
> +
> +static struct meson_clk_phase_delay_data mmc_clkc_core_phase_delay = {
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
> +		.compatible	= "amlogic,gx-mmc-clkc",
> +		.data		= &mmc_clkc_gx_data
> +	},
> +	{
> +		.compatible	= "amlogic,axg-mmc-clkc",
> +		.data		= &mmc_clkc_axg_data
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
> +
> +static struct clk_regmap *
> +mmc_clkc_register_clk(struct device *dev, struct regmap *map,
> +		      struct clk_init_data *init,
> +		      const char *suffix, void *data)
> +{
> +	struct clk_regmap *clk;
> +	char *name;
> +	int ret;
> +
> +	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
> +	if (!clk)
> +		return ERR_PTR(-ENOMEM);
> +
> +	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init->name = name;
> +
> +	clk->map = map;
> +	clk->data = data;
> +	clk->hw.init = init;
> +
> +	ret = devm_clk_hw_register(dev, &clk->hw);
> +	if (ret)
> +		clk = ERR_PTR(ret);
> +
> +	kfree(name);
> +	return clk;
> +}
> +
> +static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
> +						struct regmap *map)
> +{
> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> +	struct clk_init_data init;
> +	struct clk_regmap *mux;
> +	struct clk *clk;
> +	int i;
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
> +	init.ops = &clk_regmap_mux_ops;
> +	init.flags = CLK_SET_RATE_PARENT;
> +	init.parent_names = parent_names;
> +	init.num_parents = MUX_CLK_NUM_PARENTS;
> +
> +	mux = mmc_clkc_register_clk(dev, map, &init, "mux", &mmc_clkc_mux_data);
> +	if (IS_ERR(mux))
> +		dev_err(dev, "Mux clock registration failed\n");
> +
> +	return mux;
> +}
> +
> +static struct clk_regmap *
> +mmc_clkc_register_other_clk(struct device *dev, struct regmap *map,

This is a poor name. It does not help understand what the function does.
mmc_clkc_register_clk_with_parent or whatever helps understand what's going on

> +			    char *suffix, char *parent_suffix,

You should not have to rebuild the parent name once again.
Pass the clk_hw* of the parent and get the name from it.

> +			    unsigned long flags,
> +			    const struct clk_ops *ops, void *data)
> +{
> +	struct clk_init_data init;
> +	struct clk_regmap *clk;
> +	char *parent;
> +
> +	parent = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), parent_suffix);
> +	if (!parent)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.ops = ops;
> +	init.flags = flags;
> +	init.parent_names = (const char* const []){ parent, };
> +	init.num_parents = 1;
> +
> +	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
> +	if (IS_ERR(clk))
> +		dev_err(dev, "Core %s clock registration failed\n", suffix);
> +
> +	kfree(parent);
> +	return clk;
> +}
> +
> +static int mmc_clkc_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *onecell_data;
> +	struct device *dev = &pdev->dev;
> +	struct mmc_clkc_data *data;
> +	struct regmap *map;
> +	struct clk_regmap *mux, *div, *core, *rx, *tx;

Do you really need all this ? or could store them in your onecell_data->hws
table as you go ?

> +
> +	data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	map = syscon_node_to_regmap(dev->of_node);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "could not find mmc clock controller\n");
> +		return PTR_ERR(map);
> +	}
> +
> +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> +				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
> +				    GFP_KERNEL);
> +	if (!onecell_data)
> +		return -ENOMEM;
> +
> +	mux = mmc_clkc_register_mux(dev, map);
> +	if (IS_ERR(mux))
> +		return PTR_ERR(mux);
> +
> +	div = mmc_clkc_register_other_clk(dev, map, "div", "mux",
> +					  CLK_SET_RATE_PARENT,
> +					  &clk_regmap_divider_ops,
> +					  &mmc_clkc_div_data);
> +	if (IS_ERR(div))
> +		return PTR_ERR(div);
> +
> +	core = mmc_clkc_register_other_clk(dev, map, "core", "div",
> +					   CLK_SET_RATE_PARENT,
> +					   &meson_clk_phase_delay_ops,
> +					   &mmc_clkc_core_phase_delay);
> +	if (IS_ERR(core))
> +		return PTR_ERR(core);
> +
> +	rx = mmc_clkc_register_other_clk(dev, map, "rx", "core", 0,
> +					 &meson_clk_phase_delay_ops,
> +					 &data->rx);
> +	if (IS_ERR(rx))
> +		return PTR_ERR(rx);
> +
> +	tx = mmc_clkc_register_other_clk(dev, map, "tx", "core", 0,
> +					 &meson_clk_phase_delay_ops,
> +					 &data->tx);
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


