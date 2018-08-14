Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2021C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D362172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BpPDvagV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D362172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeHNP1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:27:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43476 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731168AbeHNP1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:27:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so17066005wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oJF4cLEbMpbIATG25WTLwA5q0SvInzWfULEfxth1piM=;
        b=BpPDvagV7VT7KRByQTy7d/VqShQcbu1oy41TCn1ct4LJsIlTgr+UOHdn6MQVcLzxM5
         mrx2YBwHr1iZkaRaP69O3J70oskbClASnUwyqVTr1ifYx/ts9TXh8qv5ocrek7PSE+05
         DOoTfe2fK0Xwvdegpd8c9gQGWBVeOsokbkPaIF+Sg4RUIQUhgm7D4uh3tjValNtVMoWb
         DI+KIFQxSEkYDDtfY+cB2R8IqUZSylroCpxzk3baBHUA0Iqr8wagPB4YZZHUrzwig+he
         xZ3Y8CixY7QBKyGPM7fFiCh+s4NZW9sTZUKUa4cyWfBO1Kgtesk5Yw7DiJUZJjcmwUup
         SFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oJF4cLEbMpbIATG25WTLwA5q0SvInzWfULEfxth1piM=;
        b=A+qVs8sCC92Etar91qleUFKkztHnMbeLT+iZOozD+F2kTaq8tctmxu7cvSajOAmEdb
         t5/rE68bNxfAwKyqzIVYGm5qypR/6W3BWXeu7xmsP+CBdoKfXs2wokP8j17YS3EdbNUP
         B/qLro0u9jSoErafzUZflSHyn1jIiVlAeUz4y4WHkeiPLUlB4omatiQo229ygaePW8Yf
         r4uYJusWCD1i0TRTGu+cPUx6pljJb1GzNVt6wuY779ILQkQgy5SOW8zJnXvvBlLwOhuR
         xH/8r4h6QD54bJ8/8tV0tRqHOOE8sSGLJSdgvY2qbPrSQYi5a3G4RQe3h0m5cbz9mbR5
         5ymg==
X-Gm-Message-State: AOUpUlHyxHZHw6cBK9AnbGtRaUzmGQJS9T0rDT0C90iEPoA5WSGYDBH9
        q5z52CX3jRCWYYlpfQuM2BuW6g==
X-Google-Smtp-Source: AA+uWPwkHaViW/jzba4f4At3f6xdtWXQHHU44Ty8irgEfjXMuy2rJ1F6y6frAn8ATZiqbgKDrjAmjw==
X-Received: by 2002:adf:9c93:: with SMTP id d19-v6mr13023055wre.11.1534250433003;
        Tue, 14 Aug 2018 05:40:33 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q188-v6sm24001920wmd.36.2018.08.14.05.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 05:40:32 -0700 (PDT)
Message-ID: <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson-g12a: Add AO Clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 14 Aug 2018 14:40:31 +0200
In-Reply-To: <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
         <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 17:54 +0800, Jian Hu wrote:
> Add a Clock driver for the ALways-On part
> of the Amlogic Meson-G12A SoC.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  drivers/clk/meson/Makefile     |   2 +-
>  drivers/clk/meson/g12a-aoclk.c | 170 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/g12a-aoclk.h |  36 +++++++++
>  3 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/g12a-aoclk.c
>  create mode 100644 drivers/clk/meson/g12a-aoclk.h
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 2b1a562..d5c2dcd 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -9,5 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
> -obj-$(CONFIG_COMMON_CLK_G12A)	 += g12a.o
> +obj-$(CONFIG_COMMON_CLK_G12A)	 += g12a.o g12a-aoclk.c
>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
> diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
> new file mode 100644
> index 0000000..a5cd95c
> --- /dev/null
> +++ b/drivers/clk/meson/g12a-aoclk.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson-G12A Clock Controller Driver
> + *
> + * Copyright (c) 2016 Baylibre SAS.
> + * Author: Michael Turquette <mturquette@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Jian Hu <jian.hu@amlogic.com>
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/init.h>
> +#include "clkc.h"
> +#include "g12a-aoclk.h"
> +
> +#define G12A_AO_GATE0(_name, _bit)					\
> +static struct clk_regmap _name##_ao = {					\
> +	.data = &(struct clk_regmap_gate_data) {			\
> +		.offset = (AO_CLK_GATE0),			\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name "_ao",					\
> +		.ops = &clk_regmap_gate_ops,				\
> +		.parent_names = (const char *[]){ "clk81" },		\
> +		.num_parents = 1,					\
> +	},								\
> +}
> +
> +G12A_AO_GATE0(ahb_bus,		0);
> +G12A_AO_GATE0(remote,		1);
> +G12A_AO_GATE0(i2c_master,	2);
> +G12A_AO_GATE0(i2c_slave,	3);
> +G12A_AO_GATE0(uart1,		4);
> +G12A_AO_GATE0(prod_i2c,		5);
> +G12A_AO_GATE0(uart2,		6);
> +G12A_AO_GATE0(ir_blaster,	7);
> +G12A_AO_GATE0(saradc,		8);
> +
> +static struct clk_regmap ao_clk81 = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = AO_RTI_PWR_CNTL_REG0,
> +		.mask = 0x1,
> +		.shift = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ao_clk81",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_names = (const char *[]){ "clk81", "ao_alt_xtal"},

I think it is time we stop taking clock input from nowhere.
With the addition of the axg audio clock controller, there is now an example of
how do so.

This clock controller apparently has 3 inputs:
* xtal
* ao_xtal
* clk_81

I'd like to see that appear this DT bindings and the probe function

Same goes for the EE controller which should only take the xtal.

> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_regmap g12a_saradc_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = AO_SAR_CLK,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "g12a_saradc_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = (const char *[]){ "xtal", "ao_clk81" },
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_regmap g12a_saradc_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = AO_SAR_CLK,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "g12a_saradc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "g12a_saradc_mux" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_saradc_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = AO_SAR_CLK,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "g12a_saradc_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "g12a_saradc_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static unsigned int g12a_aoclk_reset[] = {
> +	[RESET_AO_REMOTE] =	16,
> +	[RESET_AO_UART1] =	17,
> +	[RESET_AO_I2C_MASTER] = 18,
> +	[RESET_AO_I2C_SLAVE] =	19,
> +	[RESET_AO_SARADC] =	20,
> +	[RESET_AO_UART2] =	22,
> +	[RESET_AO_IR_BLASTER] = 23,
> +};
> +
> +static struct clk_regmap *g12a_aoclk_regmap[] = {
> +	[CLKID_AO_AHB_BUS]	= &ahb_bus_ao,
> +	[CLKID_AO_REMOTE]	= &remote_ao,
> +	[CLKID_AO_I2C_MASTER]	= &i2c_master_ao,
> +	[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao,
> +	[CLKID_AO_UART1]	= &uart1_ao,
> +	[CLKID_AO_PROD_I2C]	= &prod_i2c_ao,
> +	[CLKID_AO_UART2]	= &uart2_ao,
> +	[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao,
> +	[CLKID_AO_SAR_ADC]	= &saradc_ao,
> +	[CLKID_AO_CLK81]	= &ao_clk81,
> +	[CLKID_AO_SAR_ADC_SEL]	= &g12a_saradc_mux,
> +	[CLKID_AO_SAR_ADC_DIV]	= &g12a_saradc_div,
> +	[CLKID_AO_SAR_ADC_CLK]	= &g12a_saradc_gate,

Please be consistent while naming the clock, either prefix all with g12a, or
none.

> +};
> +
> +static struct clk_hw_onecell_data g12a_aoclk_onecell_data = {
> +	.hws = {
> +		[CLKID_AO_AHB_BUS]	= &ahb_bus_ao.hw,
> +		[CLKID_AO_REMOTE]	= &remote_ao.hw,
> +		[CLKID_AO_I2C_MASTER]	= &i2c_master_ao.hw,
> +		[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao.hw,
> +		[CLKID_AO_UART1]	= &uart1_ao.hw,
> +		[CLKID_AO_PROD_I2C]	= &prod_i2c_ao.hw,
> +		[CLKID_AO_UART2]	= &uart2_ao.hw,
> +		[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao.hw,
> +		[CLKID_AO_SAR_ADC]	= &saradc_ao.hw,
> +		[CLKID_AO_CLK81]	= &ao_clk81.hw,
> +		[CLKID_AO_SAR_ADC_SEL]	= &g12a_saradc_mux.hw,
> +		[CLKID_AO_SAR_ADC_DIV]	= &g12a_saradc_div.hw,
> +		[CLKID_AO_SAR_ADC_CLK]	= &g12a_saradc_gate.hw,
> +	},
> +	.num = NR_CLKS,
> +};
> +
> +static struct meson_aoclk_data g12a_aoclkc_data = {
> +	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
> +	.num_reset	= ARRAY_SIZE(g12a_aoclk_reset),
> +	.reset		= g12a_aoclk_reset,
> +	.num_clks	= ARRAY_SIZE(g12a_aoclk_regmap),
> +	.clks		= g12a_aoclk_regmap,
> +	.hw_data	= &g12a_aoclk_onecell_data,
> +};
> +
> +static const struct of_device_id g12a_aoclkc_match_table[] = {
> +	{
> +		.compatible	= "amlogic,g12a-aoclkc",
> +		.data		= &g12a_aoclkc_data,
> +	},
> +	{ }
> +};
> +
> +static struct platform_driver g12a_aoclkc_driver = {
> +	.probe		= meson_aoclkc_probe,
> +	.driver		= {
> +		.name	= "g12a-aoclkc",
> +		.of_match_table = g12a_aoclkc_match_table,
> +	},
> +};
> +
> +builtin_platform_driver(g12a_aoclkc_driver);
> diff --git a/drivers/clk/meson/g12a-aoclk.h b/drivers/clk/meson/g12a-aoclk.h
> new file mode 100644
> index 0000000..007183e
> --- /dev/null
> +++ b/drivers/clk/meson/g12a-aoclk.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Jian Hu <Jian.Hu@amlogic.com>
> + */
> +
> +#ifndef __G12A_AOCLKC_H
> +#define __G12A_AOCLKC_H
> +
> +//#include "meson-aoclk.h"

??? Do you need this or not ?

> +
> +#define NR_CLKS				14
> +
> +/* AO Configuration Clock registers offsets
> + * Register offsets from the data sheet must be multiplied by 4.
> + */
> +#define AO_RTI_PWR_CNTL_REG0		0x10
> +#define AO_RTI_GEN_CNTL_REG0		0x40
> +#define AO_OSCIN_CNTL			0x58
> +#define AO_CRT_CLK_CNTL1		0x68
> +#define AO_SAR_CLK			0x90
> +#define AO_RTC_ALT_CLK_CNTL0		0x94
> +#define AO_RTC_ALT_CLK_CNTL1		0x98
> +
> +/*
> + *AO CLK81 gate clocks
> + */
> +#define AO_CLK_GATE0			0x4c
> +
> +#include <dt-bindings/clock/g12a-aoclkc.h>
> +#include <dt-bindings/reset/g12a-aoclkc.h>
> +
> +#endif /* __G12A_AOCLKC_H */


