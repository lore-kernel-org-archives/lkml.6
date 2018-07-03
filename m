Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BDE24CDF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BDE24CDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933695AbeGCJ4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:56:40 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:63028 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeGCJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:56:39 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 3 Jul 2018
 17:55:49 +0800
Subject: Re: [PATCH 3/3] clk: meson: add sub EMMC clock controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
 <20180703145716.31860-4-yixun.lan@amlogic.com>
 <1530607882.2900.182.camel@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <f4a75d5a-bda4-cf0e-3a55-a92331f74576@amlogic.com>
Date:   Tue, 3 Jul 2018 17:56:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1530607882.2900.182.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome:

see my comments

On 07/03/18 16:51, Jerome Brunet wrote:
> On Tue, 2018-07-03 at 14:57 +0000, Yixun Lan wrote:
>> This patch will add a EMMC clock controller driver support,
>> It provide a mux and divider clock.
>>
>> This clock driver can be protentially used by either EMMC and
>> NAND driver.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  drivers/clk/meson/Kconfig     |   9 +++
>>  drivers/clk/meson/Makefile    |   1 +
>>  drivers/clk/meson/emmc-clkc.c | 136 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 146 insertions(+)
>>  create mode 100644 drivers/clk/meson/emmc-clkc.c
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index efaa70f682b4..2f27ff08e4eb 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -15,6 +15,15 @@ config COMMON_CLK_MESON_AO
>>  	select COMMON_CLK_REGMAP_MESON
>>  	select RESET_CONTROLLER
>>  
>> +config COMMON_CLK_EMMC_MESON
>> +	tristate "Meson EMMC Sub Clock Controller Driver"
>> +	depends on COMMON_CLK_AMLOGIC
>> +	select MFD_SYSCON
>> +	select REGMAP
>> +	help
>> +	  Support for the EMMC sub clock controller on AmLogic Meson Platform,
> I thought you were not writing amlogic this way anymore -^ ??  ^ 
>  ... or be consistent about it.                                |
>                                                                |
> Drop the camel case please                        -------------|

oops, I'm not trying to find an excuse myself..
but this is copy & paste from COMMON_CLK_AXG_AUDIO section,
so it's also need an update.

I will fix in next version


>> +	  Say Y if you want this clock enabled.
>> +
>>  config COMMON_CLK_REGMAP_MESON
>>  	bool
>>  	select REGMAP
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 72ec8c40d848..2f04f77ba4de 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
>>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
>> +obj-$(CONFIG_COMMON_CLK_EMMC_MESON) 	+= emmc-clkc.o
>>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
>> diff --git a/drivers/clk/meson/emmc-clkc.c b/drivers/clk/meson/emmc-clkc.c
>> new file mode 100644
>> index 000000000000..cf5bb9f34327
>> --- /dev/null
>> +++ b/drivers/clk/meson/emmc-clkc.c
>> @@ -0,0 +1,136 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Amlogic Meson EMMC Sub Clock Controller Driver
>> + *
>> + * Copyright (c) 2018 Amlogic, inc.
>> + * Author: Yixun Lan <yixun.lan@amlogic.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/init.h>
> 
> replace with linux/module.h
> 
ok

>> +#include <linux/of_address.h>
> 
> Why do you need this ?
>
this can be removed, I will update

>> +#include <linux/of_device.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/emmc-clkc.h>
>> +
>> +#include "clkc.h"
>> +
>> +#define SD_EMMC_CLOCK		0
>> +#define MUX_CLK_NUM_PARENTS	2
>> +#define EMMC_MAX_CLKS		2
>> +#define CLK_NAME_LEN		48
>> +
>> +static struct clk_regmap_mux_data emmc_clkc_mux_data = {
>> +	.offset = SD_EMMC_CLOCK,
>> +	.mask = 0x3,
>> +	.shift = 6,
> 
> If you round the divider "closest", shouldn't you do the same for the mux ?
> 
>> +};
>> +
>> +static struct clk_regmap_div_data emmc_clkc_div_data = {
>> +	.offset = SD_EMMC_CLOCK,
>> +	.shift = 0,
>> +	.width = 6,
>> +	.flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
>> +};
>> +
>> +static const struct of_device_id clkc_match_table[] = {
>> +	{ .compatible = "amlogic,emmc-clkc" },
>> +	{}
>> +};
>> +
>> +static int emmc_clkc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct clk_regmap *mux, *div;
>> +	struct regmap *map;
>> +	struct clk *clk;
>> +	int i, ret;
>> +	const char *parent_names[MUX_CLK_NUM_PARENTS];
>> +	struct clk_init_data init;
>> +	char mux_name[CLK_NAME_LEN], div_name[CLK_NAME_LEN];
> 
> I'm not big fan, especially if you append the dev_name() to the clock name.
> 

the main idea of appending dev_name() is :
 I want to make this driver work with SD_EMMC_A, SD_EMMC_B clock
controller, not just SD_EMMC_C

so basically we can have one driver, then populate three EMMC clock
instance, and can distinguish from the dev_name()

or if you have better suggestion, do speak up

for this, I'm not sure if we really have plan to convert the EMMC driver
to use this sub emmc clock driver. if the answer is NO, then I could
even use static clock data to make this driver much simple (avoid using
various devm_kzalloc..)

>> +	struct clk_hw_onecell_data *onecell_data;
>> +
>> +	map = syscon_node_to_regmap(dev->of_node);
>> +
>> +	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
>> +	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
>> +
>> +	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
>> +				    sizeof(*onecell_data->hws) * EMMC_MAX_CLKS,
>> +				    GFP_KERNEL);
>> +
>> +	if (!mux || !div || !onecell_data)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
>> +		char name[8];
>> +
>> +		snprintf(name, sizeof(name), "clkin%d", i);
>> +		clk = devm_clk_get(dev, name);
>> +		if (IS_ERR(clk)) {
>> +			if (clk != ERR_PTR(-EPROBE_DEFER))
>> +				dev_err(dev, "Missing clock %s\n", name);
>> +			return PTR_ERR(clk);
>> +		}
>> +
>> +		parent_names[i] = __clk_get_name(clk);
>> +	}
>> +
>> +	mux->map = map;
>> +	mux->data = &emmc_clkc_mux_data;
>> +
>> +	snprintf(mux_name, CLK_NAME_LEN, "%s#emmc_mux", dev_name(dev));
> 
> I'd prefer if you used kasprintf() and free the name after the name after
> registration.
> 
Ok, I can do this

>> +
>> +	init.name = mux_name;
>> +	init.ops = &clk_regmap_mux_ops;
>> +	init.flags = CLK_SET_RATE_PARENT;
> 
> If you really intend to have manual control over the mux, as commented in patch
> 2, you need CLK_SET_RATE_NOREPARENT here, otherwise whatever you set may be
> overwritten by the next clk_set_rate() call. Please choose.
> 

ok, thanks for pointing this
>> +	init.parent_names = parent_names;
>> +	init.num_parents = MUX_CLK_NUM_PARENTS;
>> +
>> +	mux->hw.init = &init;
>> +	ret = devm_clk_hw_register(dev, &mux->hw);
>> +	if (ret) {
>> +		dev_err(dev, "Mux clock registration failed\n");
>> +		return ret;
>> +	}
>> +
>> +	parent_names[0] = mux_name;
>> +	div->map = map;
>> +	div->data = &emmc_clkc_div_data;
>> +
>> +	snprintf(div_name, CLK_NAME_LEN, "%s#emmc_div", dev_name(dev));
>> +
>> +	init.name = div_name;
>> +	init.ops = &clk_regmap_divider_ops;
>> +	init.flags = CLK_SET_RATE_PARENT;
>> +	init.parent_names = parent_names;
>> +	init.num_parents = 1;
>> +
>> +	div->hw.init = &init;
>> +	ret = devm_clk_hw_register(dev, &div->hw);
>> +	if (ret) {
>> +		dev_err(dev, "Div clock registration failed\n");
> 
> s/Div/Divider
> 
ok

>> +		return ret;
>> +	}
>> +
>> +	onecell_data->hws[CLKID_EMMC_C_MUX] = &mux->hw,
>> +	onecell_data->hws[CLKID_EMMC_C_DIV] = &div->hw,
>> +	onecell_data->num = EMMC_MAX_CLKS;
>> +
>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +					   onecell_data);
> 
> This is a long function with a lot of locals. please break that up.
> (for example, one function to register each clock, helper to allocate the clk_hw
> and names ...)
> 
ok
>> +}
>> +
>> +static struct platform_driver emmc_clkc_driver = {
>> +	.probe		= emmc_clkc_probe,
>> +	.driver		= {
>> +		.name	= "emmc-clkc",
>> +		.of_match_table = clkc_match_table,
>> +	},
>> +};
>> +
> 
> It should be a module, not a builtin - especially when the configuration is a
> tristate
>  
>> +builtin_platform_driver(emmc_clkc_driver);
Ok, I will fix this
> 
> .
> 

