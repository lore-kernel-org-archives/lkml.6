Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33534C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E2124CD3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cW10NuxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E2124CD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeGCIv2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:51:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51718 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932683AbeGCIvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:51:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1420752wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKzxpEhlfB/aJTHyUnVyRACu4hf+y9y9zB64IVNtKBs=;
        b=cW10NuxNPUNl0rThSqpCLe4zlp5ffFkYWa5H0KAX2oaBRGdrGb3ar0t2gESdFiPtp2
         R0+cB3LbkHoJorWEsB8Zb3LViY3+bWNlJsTbEfItbVkkAoyqXVdSCHRAJuBJOyvqhn2i
         juiDCz5bSDYHkxEa/To8+EtyNmdasqc2piquXj21V8kusgigZlkF/MW3rH6BeDoyujPl
         yZCpy6Zd3IUPi48mtJms+7FVZ1eotXrShRf/f+4w4YCgrMKsRt6Q1K7BzW8uaaU0RBf3
         PMI8wGOKRIpgRQ8Hb23RYNalFa9SxZNndfzWLEexthbU2O9anT9TMCN+HL9ZJOtYhCer
         c5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKzxpEhlfB/aJTHyUnVyRACu4hf+y9y9zB64IVNtKBs=;
        b=TSuA788MFb+eaM7/H2IR9JvDCuutzfGveKJhXvGnwFpJPQ6T5dxtaWnq2Mynu6x7hr
         xQChp7QwwBNFeQtrKW/rMsHwIdmD0Qp/2be2WKUdZlNIYsVO3VIA3p7YrmSnc66fROYB
         jVnKspdHj0nH8yNvJclpbBxXQlKW9v0dOyFzYlsfgO5IUUS5Y3HExAjTS6dAYohi0qmF
         0aEFfJL1ado2uOHak5EnicdHVUGBLZY74i2oOUToOJnie3T1dWMNpfvMfse7p+61JXwB
         +u8FPFxZA+wskFZjpJ1i90sicEzs2O9u2QU06d+S9FuQjq5tS5WRSiN2AVNjomAcXEcV
         xd8Q==
X-Gm-Message-State: APt69E3RO76SHphHFmksAYes8RsanBlZEyugfQ4P//ByqYPXqghhQ+Hr
        Tvkg+kTG0jDYk6AmSSSWEyekfA==
X-Google-Smtp-Source: AAOMgpdoNOcr55jA/az8THUUljNicj8OEbIfmr1I7ASX+bf0ObyktTDkajZiD5Qq05kQccEf5CkNdA==
X-Received: by 2002:a1c:5c93:: with SMTP id q141-v6mr10121336wmb.77.1530607883891;
        Tue, 03 Jul 2018 01:51:23 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v9-v6sm989669wrn.97.2018.07.03.01.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 01:51:23 -0700 (PDT)
Message-ID: <1530607882.2900.182.camel@baylibre.com>
Subject: Re: [PATCH 3/3] clk: meson: add sub EMMC clock controller driver
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
Date:   Tue, 03 Jul 2018 10:51:22 +0200
In-Reply-To: <20180703145716.31860-4-yixun.lan@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
         <20180703145716.31860-4-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 14:57 +0000, Yixun Lan wrote:
> This patch will add a EMMC clock controller driver support,
> It provide a mux and divider clock.
> 
> This clock driver can be protentially used by either EMMC and
> NAND driver.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig     |   9 +++
>  drivers/clk/meson/Makefile    |   1 +
>  drivers/clk/meson/emmc-clkc.c | 136 ++++++++++++++++++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 drivers/clk/meson/emmc-clkc.c
> 
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index efaa70f682b4..2f27ff08e4eb 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -15,6 +15,15 @@ config COMMON_CLK_MESON_AO
>  	select COMMON_CLK_REGMAP_MESON
>  	select RESET_CONTROLLER
>  
> +config COMMON_CLK_EMMC_MESON
> +	tristate "Meson EMMC Sub Clock Controller Driver"
> +	depends on COMMON_CLK_AMLOGIC
> +	select MFD_SYSCON
> +	select REGMAP
> +	help
> +	  Support for the EMMC sub clock controller on AmLogic Meson Platform,
I thought you were not writing amlogic this way anymore -^ ??  ^ 
 ... or be consistent about it.                                |
                                                               |
Drop the camel case please                        -------------|
> +	  Say Y if you want this clock enabled.
> +
>  config COMMON_CLK_REGMAP_MESON
>  	bool
>  	select REGMAP
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 72ec8c40d848..2f04f77ba4de 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
> +obj-$(CONFIG_COMMON_CLK_EMMC_MESON) 	+= emmc-clkc.o
>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
> diff --git a/drivers/clk/meson/emmc-clkc.c b/drivers/clk/meson/emmc-clkc.c
> new file mode 100644
> index 000000000000..cf5bb9f34327
> --- /dev/null
> +++ b/drivers/clk/meson/emmc-clkc.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson EMMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>

replace with linux/module.h

> +#include <linux/of_address.h>

Why do you need this ?

> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/emmc-clkc.h>
> +
> +#include "clkc.h"
> +
> +#define SD_EMMC_CLOCK		0
> +#define MUX_CLK_NUM_PARENTS	2
> +#define EMMC_MAX_CLKS		2
> +#define CLK_NAME_LEN		48
> +
> +static struct clk_regmap_mux_data emmc_clkc_mux_data = {
> +	.offset = SD_EMMC_CLOCK,
> +	.mask = 0x3,
> +	.shift = 6,

If you round the divider "closest", shouldn't you do the same for the mux ?

> +};
> +
> +static struct clk_regmap_div_data emmc_clkc_div_data = {
> +	.offset = SD_EMMC_CLOCK,
> +	.shift = 0,
> +	.width = 6,
> +	.flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
> +};
> +
> +static const struct of_device_id clkc_match_table[] = {
> +	{ .compatible = "amlogic,emmc-clkc" },
> +	{}
> +};
> +
> +static int emmc_clkc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk_regmap *mux, *div;
> +	struct regmap *map;
> +	struct clk *clk;
> +	int i, ret;
> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
> +	struct clk_init_data init;
> +	char mux_name[CLK_NAME_LEN], div_name[CLK_NAME_LEN];

I'm not big fan, especially if you append the dev_name() to the clock name.

> +	struct clk_hw_onecell_data *onecell_data;
> +
> +	map = syscon_node_to_regmap(dev->of_node);
> +
> +	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +
> +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> +				    sizeof(*onecell_data->hws) * EMMC_MAX_CLKS,
> +				    GFP_KERNEL);
> +
> +	if (!mux || !div || !onecell_data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> +		char name[8];
> +
> +		snprintf(name, sizeof(name), "clkin%d", i);
> +		clk = devm_clk_get(dev, name);
> +		if (IS_ERR(clk)) {
> +			if (clk != ERR_PTR(-EPROBE_DEFER))
> +				dev_err(dev, "Missing clock %s\n", name);
> +			return PTR_ERR(clk);
> +		}
> +
> +		parent_names[i] = __clk_get_name(clk);
> +	}
> +
> +	mux->map = map;
> +	mux->data = &emmc_clkc_mux_data;
> +
> +	snprintf(mux_name, CLK_NAME_LEN, "%s#emmc_mux", dev_name(dev));

I'd prefer if you used kasprintf() and free the name after the name after
registration.

> +
> +	init.name = mux_name;
> +	init.ops = &clk_regmap_mux_ops;
> +	init.flags = CLK_SET_RATE_PARENT;

If you really intend to have manual control over the mux, as commented in patch
2, you need CLK_SET_RATE_NOREPARENT here, otherwise whatever you set may be
overwritten by the next clk_set_rate() call. Please choose.

> +	init.parent_names = parent_names;
> +	init.num_parents = MUX_CLK_NUM_PARENTS;
> +
> +	mux->hw.init = &init;
> +	ret = devm_clk_hw_register(dev, &mux->hw);
> +	if (ret) {
> +		dev_err(dev, "Mux clock registration failed\n");
> +		return ret;
> +	}
> +
> +	parent_names[0] = mux_name;
> +	div->map = map;
> +	div->data = &emmc_clkc_div_data;
> +
> +	snprintf(div_name, CLK_NAME_LEN, "%s#emmc_div", dev_name(dev));
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
> +		dev_err(dev, "Div clock registration failed\n");

s/Div/Divider

> +		return ret;
> +	}
> +
> +	onecell_data->hws[CLKID_EMMC_C_MUX] = &mux->hw,
> +	onecell_data->hws[CLKID_EMMC_C_DIV] = &div->hw,
> +	onecell_data->num = EMMC_MAX_CLKS;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   onecell_data);

This is a long function with a lot of locals. please break that up.
(for example, one function to register each clock, helper to allocate the clk_hw
and names ...)

> +}
> +
> +static struct platform_driver emmc_clkc_driver = {
> +	.probe		= emmc_clkc_probe,
> +	.driver		= {
> +		.name	= "emmc-clkc",
> +		.of_match_table = clkc_match_table,
> +	},
> +};
> +

It should be a module, not a builtin - especially when the configuration is a
tristate
 
> +builtin_platform_driver(emmc_clkc_driver);

