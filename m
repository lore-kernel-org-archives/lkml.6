Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96872C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0A220877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0A220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeGJM7i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:59:38 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:25742 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeGJM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:59:36 -0400
Received: from [192.168.90.65] (61.173.0.103) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 10 Jul
 2018 20:58:50 +0800
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <jian.hu@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
 <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
 <1531216472.2708.71.camel@baylibre.com>
CC:     <yixun.lan@amlogic.com>, Neil Armstrong <narmstrong@baylibre.com>,
        <qianggui.song@amlogic.com>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <bo.yang@amlogic.com>,
        <qiufang.dai@amlogic.com>, <linux-arm-kernel@lists.infradead.org>,
        <carlo@caione.org>, <linux-amlogic@lists.infradead.org>,
        <sunny.luo@amlogic.com>, <linux-clk@vger.kernel.org>,
        <xingyu.chen@amlogic.com>, Rob Herring <robh@kernel.org>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <cb832db4-ad2c-09c1-86ae-e7f9c05cd872@amlogic.com>
Date:   Tue, 10 Jul 2018 20:59:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1531216472.2708.71.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.173.0.103]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome:

just one comment

On 07/10/2018 05:54 PM, Jerome Brunet wrote:
> On Tue, 2018-07-10 at 09:21 +0800, Yixun Lan wrote:
>> HI Martin
>>
>>
>> On 07/10/18 05:53, Martin Blumenstingl wrote:
>>> On Mon, Jul 9, 2018 at 1:14 PM Jian Hu <jian.hu@amlogic.com> wrote:
>>>>
>>>> Add a Clock driver for the Everyting-Else part
>>>> of the Amlogic Meson-G12A SoC.
>>>>
>>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> 
> This patch does not apply against git@github.com:BayLibre/clk-meson.git
> 
> Please rebase on top of the "next/drivers" branch.
> Also please review the Kconfig part as changes have happened there.
> 
>>>> ---
>>>>  drivers/clk/meson/Kconfig  |  10 +
>>>>  drivers/clk/meson/Makefile |   1 +
>>>>  drivers/clk/meson/g12a.c   | 992 +++++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/clk/meson/g12a.h   | 123 ++++++
>>>>  4 files changed, 1126 insertions(+)
>>>>  create mode 100644 drivers/clk/meson/g12a.c
>>>>  create mode 100644 drivers/clk/meson/g12a.h
>>>>
>>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>>> index d5cbec5..94a82f73 100644
>>>> --- a/drivers/clk/meson/Kconfig
>>>> +++ b/drivers/clk/meson/Kconfig
>>>> @@ -36,3 +36,13 @@ config COMMON_CLK_AXG
>>>>         help
>>>>           Support for the clock controller on AmLogic A113D devices, aka axg.
>>>>           Say Y if you want peripherals and CPU frequency scaling to work.
>>>> +
>>>> +config COMMON_CLK_G12A
>>>> +       bool
>>>> +       depends on COMMON_CLK_AMLOGIC
>>>> +       select RESET_CONTROLLER
>>>> +       select COMMON_CLK_REGMAP_MESON
>>>> +       select MFD_SYSCON
>>>> +       help
>>>> +         Support for the clock controller on AmLogic U400 devices, aka g12a.
> 
> I suppose U400 is the designation of the ref design board, not the SoC, right ?
> If this is case, please provide the SoC reference instead.
> 
>>>> +         Say Y if you want peripherals and CPU frequency scaling to work.
>>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>>> index fa6d1e3..45d107c 100644
>>>> --- a/drivers/clk/meson/Makefile
>>>> +++ b/drivers/clk/meson/Makefile
>>>> @@ -6,4 +6,5 @@ obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
>>>>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>>>>  obj-$(CONFIG_COMMON_CLK_GXBB)   += gxbb.o meson-aoclk.o gxbb-aoclk.o gxbb-aoclk-32k.o
>>>>  obj-$(CONFIG_COMMON_CLK_AXG)    += axg.o meson-aoclk.o axg-aoclk.o
>>>> +obj-$(CONFIG_COMMON_CLK_G12A)   += g12a.o
>>>>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)  += clk-regmap.o
>>>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>>>> new file mode 100644
>>>> index 0000000..3675697
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/g12a.c
>>>> @@ -0,0 +1,992 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * AmLogic Meson-G12A Clock Controller Driver
> 
> I thought you guys stopped writing amlogic with this camel case.
> Please be consistent about it
> 
>>>> + *
>>>> + * Copyright (c) 2016 Baylibre SAS.
>>>> + * Author: Michael Turquette <mturquette@baylibre.com>
>>>> + *
>>>> + * Copyright (c) 2018 Amlogic, inc.
>>>> + * Author: Jian Hu <jian.hu@amlogic.com>
>>>> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
>>>> + */
>>>> +
>>>> +#include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/mfd/syscon.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +#include "clkc.h"
>>>> +#include "g12a.h"
>>>> +
>>>> +static DEFINE_SPINLOCK(meson_clk_lock);
>>>> +
>>>> +static struct clk_regmap g12a_fixed_pll = {
>>>> +       .data = &(struct meson_clk_pll_data){
>>>> +               .m = {
>>>> +                       .reg_off = HHI_FIX_PLL_CNTL0,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 8,
>>>> +               },
>>>> +               .n = {
>>>> +                       .reg_off = HHI_FIX_PLL_CNTL0,
>>>> +                       .shift   = 10,
>>>> +                       .width   = 5,
>>>> +               },
>>>> +               .od = {
>>>> +                       .reg_off = HHI_FIX_PLL_CNTL0,
>>>> +                       .shift   = 16,
>>>> +                       .width   = 2,
>>>> +               },
>>>> +               .frac = {
>>>> +                       .reg_off = HHI_FIX_PLL_CNTL1,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 19,
>>>> +               },
>>>> +               .l = {
>>>> +                       .reg_off = HHI_FIX_PLL_CNTL0,
>>>> +                       .shift   = 31,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .rst = {
>>>> +                       .reg_off = HHI_FIX_PLL_CNTL0,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "fixed_pll",
>>>> +               .ops = &meson_clk_pll_ro_ops,
>>>> +               .parent_names = (const char *[]){ "xtal" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static const struct reg_sequence g12a_sys_init_regs[] = {
>>>> +       { .reg = HHI_SYS_PLL_CNTL1,     .def = 0x00000000 },
>>>> +       { .reg = HHI_SYS_PLL_CNTL2,     .def = 0x00000000 },
>>>> +       { .reg = HHI_SYS_PLL_CNTL3,     .def = 0x48681c00 },
>>>> +       { .reg = HHI_SYS_PLL_CNTL4,     .def = 0x88770290 },
>>>> +       { .reg = HHI_SYS_PLL_CNTL5,     .def = 0x39272000 },
>>>> +       { .reg = HHI_SYS_PLL_CNTL6,     .def = 0x56540000 },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_sys_pll = {
>>>> +       .data = &(struct meson_clk_pll_data){
>>>> +               .m = {
>>>> +                       .reg_off = HHI_SYS_PLL_CNTL0,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 8,
>>>> +               },
>>>> +               .n = {
>>>> +                       .reg_off = HHI_SYS_PLL_CNTL0,
>>>> +                       .shift   = 10,
>>>> +                       .width   = 5,
>>>> +               },
>>>> +               .od = {
>>>> +                       .reg_off = HHI_SYS_PLL_CNTL0,
>>>> +                       .shift   = 16,
>>>> +                       .width   = 3,
>>>> +               },
>>>> +               .l = {
>>>> +                       .reg_off = HHI_SYS_PLL_CNTL0,
>>>> +                       .shift   = 31,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .rst = {
>>>> +                       .reg_off = HHI_SYS_PLL_CNTL0,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .init_regs = g12a_sys_init_regs,
>>>> +               .init_count = ARRAY_SIZE(g12a_sys_init_regs),
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "sys_pll",
>>>> +               .ops = &meson_clk_pll_ro_ops,
>>>> +               .parent_names = (const char *[]){ "xtal" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_GET_RATE_NOCACHE,
>>>> +       },
>>>> +};
>>>> +
>>>> +static const struct pll_rate_table g12a_gp0_pll_rate_table[] = {
>>>> +       PLL_RATE(24000000,  128, 1, 7),
>>>> +       PLL_RATE(48000000,  128, 1, 6),
>>>> +       PLL_RATE(96000000,  128, 1, 5),
>>>> +       PLL_RATE(192000000,  128, 1, 4),
>>>> +       PLL_RATE(312000000,  208, 1, 4),
>>>> +       PLL_RATE(408000000,  136, 1, 3),
>>>> +       PLL_RATE(600000000,  200, 1, 3),
>>>> +       PLL_RATE(696000000,  232, 1, 3),
>>>> +       PLL_RATE(792000000,  132, 1, 2),
>>>> +       PLL_RATE(846000000,  141, 1, 2),
>>>> +       PLL_RATE(912000000,  152, 1, 2),
>>>> +       PLL_RATE(1008000000, 168, 1, 2),
>>>> +       PLL_RATE(1104000000, 184, 1, 2),
>>>> +       PLL_RATE(1200000000, 200, 1, 2),
>>>> +       PLL_RATE(1296000000, 216, 1, 2),
>>>> +       PLL_RATE(1398000000, 233, 1, 2),
>>>> +       PLL_RATE(1494000000, 249, 1, 2),
>>>> +       PLL_RATE(1512000000, 126, 1, 1),
>>>> +       PLL_RATE(1608000000, 134, 1, 1),
>>>> +       PLL_RATE(1704000000, 142, 1, 1),
>>>> +       PLL_RATE(1800000000, 150, 1, 1),
>>>> +       PLL_RATE(1896000000, 158, 1, 1),
>>>> +       PLL_RATE(1908000000, 159, 1, 1),
>>>> +       PLL_RATE(1920000000, 160, 1, 1),
>>>> +       PLL_RATE(2016000000, 168, 1, 1),
>>>> +       PLL_RATE(2100000000, 175, 1, 1),
>>>> +       PLL_RATE(2196000000, 183, 1, 1),
>>>> +       PLL_RATE(2292000000, 191, 1, 1),
>>>> +       PLL_RATE(2400000000, 200, 1, 1),
>>>> +       PLL_RATE(2496000000, 208, 1, 1),
>>>> +       PLL_RATE(2592000000, 216, 1, 1),
>>>> +       PLL_RATE(2700000000, 225, 1, 1),
>>>> +       PLL_RATE(2796000000, 233, 1, 1),
>>>> +       PLL_RATE(2892000000, 241, 1, 1),
>>>> +       PLL_RATE(3000000000, 125, 1, 0),
>>>> +       PLL_RATE(3096000000, 129, 1, 0),
>>>> +       PLL_RATE(3192000000, 133, 1, 0),
>>>> +       PLL_RATE(3288000000, 137, 1, 0),
>>>> +       PLL_RATE(3408000000, 142, 1, 0),
>>>> +       PLL_RATE(3504000000, 146, 1, 0),
>>>> +       PLL_RATE(3600000000, 150, 1, 0),
>>>> +       PLL_RATE(3696000000, 154, 1, 0),
>>>> +       PLL_RATE(3792000000, 158, 1, 0),
>>>> +       PLL_RATE(3888000000, 162, 1, 0),
>>>> +       PLL_RATE(4008000000, 167, 1, 0),
>>>> +       PLL_RATE(4104000000, 171, 1, 0),
>>>> +       PLL_RATE(4200000000, 175, 1, 0),
>>>> +       PLL_RATE(4296000000, 179, 1, 0),
>>>> +       PLL_RATE(4392000000, 183, 1, 0),
>>>> +       PLL_RATE(4488000000, 187, 1, 0),
>>>> +       PLL_RATE(4608000000, 192, 1, 0),
>>>> +       PLL_RATE(4704000000, 196, 1, 0),
>>>> +       PLL_RATE(4800000000, 200, 1, 0),
>>>> +       PLL_RATE(4896000000, 204, 1, 0),
>>>> +       PLL_RATE(4992000000, 208, 1, 0),
>>>> +       PLL_RATE(5088000000, 212, 1, 0),
>>>> +       PLL_RATE(5208000000, 217, 1, 0),
>>>> +       PLL_RATE(5304000000, 221, 1, 0),
>>>> +       PLL_RATE(5400000000, 225, 1, 0),
>>>> +       PLL_RATE(5496000000, 229, 1, 0),
>>>> +       PLL_RATE(5592000000, 233, 1, 0),
>>>> +       PLL_RATE(5688000000, 237, 1, 0),
>>>> +       PLL_RATE(5808000000, 242, 1, 0),
>>>> +       PLL_RATE(5904000000, 246, 1, 0),
>>>> +       PLL_RATE(6000000000, 250, 1, 0),
>>>> +       { /* sentinel */ },
>>>> +};
>>>> +
>>>> +static const struct reg_sequence g12a_gp0_init_regs[] = {
>>>> +       { .reg = HHI_GP0_PLL_CNTL1,     .def = 0x00000000 },
>>>> +       { .reg = HHI_GP0_PLL_CNTL2,     .def = 0x00000000 },
>>>> +       { .reg = HHI_GP0_PLL_CNTL3,     .def = 0x48681c00 },
>>>> +       { .reg = HHI_GP0_PLL_CNTL4,     .def = 0x33771290 },
>>>> +       { .reg = HHI_GP0_PLL_CNTL5,     .def = 0x39272000 },
>>>> +       { .reg = HHI_GP0_PLL_CNTL6,     .def = 0x56540000 },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_gp0_pll = {
>>>> +       .data = &(struct meson_clk_pll_data){
>>>> +               .m = {
>>>> +                       .reg_off = HHI_GP0_PLL_CNTL0,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 8,
>>>> +               },
>>>> +               .n = {
>>>> +                       .reg_off = HHI_GP0_PLL_CNTL0,
>>>> +                       .shift   = 10,
>>>> +                       .width   = 5,
>>>> +               },
>>>> +               .od = {
>>>> +                       .reg_off = HHI_GP0_PLL_CNTL0,
>>>> +                       .shift   = 16,
>>>> +                       .width   = 3,
>>>> +               },
>>>> +               .frac = {
>>>> +                       .reg_off = HHI_GP0_PLL_CNTL1,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 19,
>>>> +               },
>>>> +               .l = {
>>>> +                       .reg_off = HHI_GP0_PLL_CNTL0,
>>>> +                       .shift   = 31,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .rst = {
>>>> +                       .reg_off = HHI_GP0_PLL_CNTL0,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .table = g12a_gp0_pll_rate_table,
>>>> +               .init_regs = g12a_gp0_init_regs,
>>>> +               .init_count = ARRAY_SIZE(g12a_gp0_init_regs),
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "gp0_pll",
>>>> +               .ops = &meson_clk_pll_ops,
>>>> +               .parent_names = (const char *[]){ "xtal" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static const struct reg_sequence g12a_hifi_init_regs[] = {
>>>> +       { .reg = HHI_HIFI_PLL_CNTL1,    .def = 0x00000000 },
>>>> +       { .reg = HHI_HIFI_PLL_CNTL2,    .def = 0x00000000 },
>>>> +       { .reg = HHI_HIFI_PLL_CNTL3,    .def = 0x6a285c00 },
>>>> +       { .reg = HHI_HIFI_PLL_CNTL4,    .def = 0x65771290 },
>>>> +       { .reg = HHI_HIFI_PLL_CNTL5,    .def = 0x39272000 },
>>>> +       { .reg = HHI_HIFI_PLL_CNTL6,    .def = 0x56540000 },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_hifi_pll = {
>>>> +       .data = &(struct meson_clk_pll_data){
>>>> +               .m = {
>>>> +                       .reg_off = HHI_HIFI_PLL_CNTL0,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 8,
>>>> +               },
>>>> +               .n = {
>>>> +                       .reg_off = HHI_HIFI_PLL_CNTL0,
>>>> +                       .shift   = 10,
>>>> +                       .width   = 5,
>>>> +               },
>>>> +               .od = {
>>>> +                       .reg_off = HHI_HIFI_PLL_CNTL0,
>>>> +                       .shift   = 16,
>>>> +                       .width   = 2,
>>>> +               },
>>>> +               .frac = {
>>>> +                       .reg_off = HHI_HIFI_PLL_CNTL1,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 19,
>>>> +               },
>>>> +               .l = {
>>>> +                       .reg_off = HHI_HIFI_PLL_CNTL0,
>>>> +                       .shift   = 31,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .rst = {
>>>> +                       .reg_off = HHI_HIFI_PLL_CNTL0,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .table = g12a_gp0_pll_rate_table,
>>>> +               .init_regs = g12a_hifi_init_regs,
>>>> +               .init_count = ARRAY_SIZE(g12a_hifi_init_regs),
>>>> +               .flags = CLK_MESON_PLL_ROUND_CLOSEST,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "hifi_pll",
>>>> +               .ops = &meson_clk_pll_ops,
>>>> +               .parent_names = (const char *[]){ "xtal" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor g12a_fclk_div2 = {
>>>> +       .mult = 1,
>>>> +       .div = 2,
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "fclk_div2",
>>>> +               .ops = &clk_fixed_factor_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
> 
> All the other SoC have gates in front of these fdivX clock.
> It this SoC really different ?
> 
>>>> +
>>>> +static struct clk_fixed_factor g12a_fclk_div3 = {
>>>> +       .mult = 1,
>>>> +       .div = 3,
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "fclk_div3",
>>>> +               .ops = &clk_fixed_factor_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor g12a_fclk_div4 = {
>>>> +       .mult = 1,
>>>> +       .div = 4,
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "fclk_div4",
>>>> +               .ops = &clk_fixed_factor_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor g12a_fclk_div5 = {
>>>> +       .mult = 1,
>>>> +       .div = 5,
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "fclk_div5",
>>>> +               .ops = &clk_fixed_factor_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_fixed_factor g12a_fclk_div7 = {
>>>> +       .mult = 1,
>>>> +       .div = 7,
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "fclk_div7",
>>>> +               .ops = &clk_fixed_factor_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpll0_div = {
>>>> +       .data = &(struct meson_clk_mpll_data){
>>>> +               .sdm = {
>>>> +                       .reg_off = HHI_MPLL_CNTL1,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 14,
>>>> +               },
>>>> +               .sdm_en = {
>>>> +                       .reg_off = HHI_MPLL_CNTL1,
>>>> +                       .shift   = 30,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .n2 = {
>>>> +                       .reg_off = HHI_MPLL_CNTL1,
>>>> +                       .shift   = 20,
>>>> +                       .width   = 9,
>>>> +               },
>>>> +               .ssen = {
>>>> +                       .reg_off = HHI_MPLL_CNTL1,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .lock = &meson_clk_lock,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll0_div",
>>>> +               .ops = &meson_clk_mpll_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpll0 = {
>>>> +       .data = &(struct clk_regmap_gate_data){
>>>> +               .offset = HHI_MPLL_CNTL1,
>>>> +               .bit_idx = 31,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll0",
>>>> +               .ops = &clk_regmap_gate_ops,
>>>> +               .parent_names = (const char *[]){ "mpll0_div" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
> 
> The previous had a predivider (1 or 2) in front of these mpll. Even if the
> predivider is usually set to be a passthrough, it is better to model the tree
> correctly.
> 
> Is this SoC any different ?
> 
>>>> +
>>>> +static struct clk_regmap g12a_mpll1_div = {
>>>> +       .data = &(struct meson_clk_mpll_data){
>>>> +               .sdm = {
>>>> +                       .reg_off = HHI_MPLL_CNTL3,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 14,
>>>> +               },
>>>> +               .sdm_en = {
>>>> +                       .reg_off = HHI_MPLL_CNTL3,
>>>> +                       .shift   = 30,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .n2 = {
>>>> +                       .reg_off = HHI_MPLL_CNTL3,
>>>> +                       .shift   = 20,
>>>> +                       .width   = 9,
>>>> +               },
>>>> +               .ssen = {
>>>> +                       .reg_off = HHI_MPLL_CNTL3,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .lock = &meson_clk_lock,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll1_div",
>>>> +               .ops = &meson_clk_mpll_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpll1 = {
>>>> +       .data = &(struct clk_regmap_gate_data){
>>>> +               .offset = HHI_MPLL_CNTL3,
>>>> +               .bit_idx = 31,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll1",
>>>> +               .ops = &clk_regmap_gate_ops,
>>>> +               .parent_names = (const char *[]){ "mpll1_div" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpll2_div = {
>>>> +       .data = &(struct meson_clk_mpll_data){
>>>> +               .sdm = {
>>>> +                       .reg_off = HHI_MPLL_CNTL5,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 14,
>>>> +               },
>>>> +               .sdm_en = {
>>>> +                       .reg_off = HHI_MPLL_CNTL5,
>>>> +                       .shift   = 30,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .n2 = {
>>>> +                       .reg_off = HHI_MPLL_CNTL5,
>>>> +                       .shift   = 20,
>>>> +                       .width   = 9,
>>>> +               },
>>>> +               .ssen = {
>>>> +                       .reg_off = HHI_MPLL_CNTL5,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .lock = &meson_clk_lock,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll2_div",
>>>> +               .ops = &meson_clk_mpll_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpll2 = {
>>>> +       .data = &(struct clk_regmap_gate_data){
>>>> +               .offset = HHI_MPLL_CNTL5,
>>>> +               .bit_idx = 31,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll2",
>>>> +               .ops = &clk_regmap_gate_ops,
>>>> +               .parent_names = (const char *[]){ "mpll2_div" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpll3_div = {
>>>> +       .data = &(struct meson_clk_mpll_data){
>>>> +               .sdm = {
>>>> +                       .reg_off = HHI_MPLL_CNTL7,
>>>> +                       .shift   = 0,
>>>> +                       .width   = 14,
>>>> +               },
>>>> +               .sdm_en = {
>>>> +                       .reg_off = HHI_MPLL_CNTL7,
>>>> +                       .shift   = 30,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .n2 = {
>>>> +                       .reg_off = HHI_MPLL_CNTL7,
>>>> +                       .shift   = 20,
>>>> +                       .width   = 9,
>>>> +               },
>>>> +               .ssen = {
>>>> +                       .reg_off = HHI_MPLL_CNTL7,
>>>> +                       .shift   = 29,
>>>> +                       .width   = 1,
>>>> +               },
>>>> +               .lock = &meson_clk_lock,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll3_div",
>>>> +               .ops = &meson_clk_mpll_ops,
>>>> +               .parent_names = (const char *[]){ "fixed_pll" },
>>>> +               .num_parents = 1,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpll3 = {
>>>> +       .data = &(struct clk_regmap_gate_data){
>>>> +               .offset = HHI_MPLL_CNTL7,
>>>> +               .bit_idx = 31,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpll3",
>>>> +               .ops = &clk_regmap_gate_ops,
>>>> +               .parent_names = (const char *[]){ "mpll3_div" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static u32 mux_table_clk81[]   = { 0, 2, 3, 4, 5, 6, 7 };
>>>> +static const char * const clk81_parent_names[] = {
>>>> +       "xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
>>>> +       "fclk_div3", "fclk_div5"
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpeg_clk_sel = {
>>>> +       .data = &(struct clk_regmap_mux_data){
>>>> +               .offset = HHI_MPEG_CLK_CNTL,
>>>> +               .mask = 0x7,
>>>> +               .shift = 12,
>>>> +               .table = mux_table_clk81,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpeg_clk_sel",
>>>> +               .ops = &clk_regmap_mux_ro_ops,
>>>> +               .parent_names = clk81_parent_names,
>>>> +               .num_parents = ARRAY_SIZE(clk81_parent_names),
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_mpeg_clk_div = {
>>>> +       .data = &(struct clk_regmap_div_data){
>>>> +               .offset = HHI_MPEG_CLK_CNTL,
>>>> +               .shift = 0,
>>>> +               .width = 7,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "mpeg_clk_div",
>>>> +               .ops = &clk_regmap_divider_ops,
>>>> +               .parent_names = (const char *[]){ "mpeg_clk_sel" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_clk81 = {
>>>> +       .data = &(struct clk_regmap_gate_data){
>>>> +               .offset = HHI_MPEG_CLK_CNTL,
>>>> +               .bit_idx = 7,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "clk81",
>>>> +               .ops = &clk_regmap_gate_ops,
>>>> +               .parent_names = (const char *[]){ "mpeg_clk_div" },
>>>> +               .num_parents = 1,
>>>> +               .flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
>>>> +       },
>>>> +};
>>>> +
>>>> +static const char * const g12a_sd_emmc_clk0_parent_names[] = {
>>>> +       "xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
>>>> +
>>>> +       /*
>>>> +        * Following these parent clocks, we should also have had mpll2, mpll3
>>>> +        * and gp0_pll but these clocks are too precious to be used here. All
>>>> +        * the necessary rates for MMC and NAND operation can be acheived using
>>>> +        * xtal or fclk_div clocks
>>>> +        */
>>>> +};
>>>> +
>>>> +/* SDcard clock */
>>>> +static struct clk_regmap g12a_sd_emmc_b_clk0_sel = {
>>>> +       .data = &(struct clk_regmap_mux_data){
>>>> +               .offset = HHI_SD_EMMC_CLK_CNTL,
>>>> +               .mask = 0x7,
>>>> +               .shift = 25,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data) {
>>>> +               .name = "sd_emmc_b_clk0_sel",
>>>> +               .ops = &clk_regmap_mux_ops,
>>>> +               .parent_names = g12a_sd_emmc_clk0_parent_names,
>>>> +               .num_parents = ARRAY_SIZE(g12a_sd_emmc_clk0_parent_names),
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_sd_emmc_b_clk0_div = {
>>>> +       .data = &(struct clk_regmap_div_data){
>>>> +               .offset = HHI_SD_EMMC_CLK_CNTL,
>>>> +               .shift = 16,
>>>> +               .width = 7,
>>>> +               .flags = CLK_DIVIDER_ROUND_CLOSEST,
> 
> If we really want to "round closest", maybe we should throw
> CLK_MUX_ROUND_CLOSEST to the parent mux as well.
> 
> I suppose this something we should fix in other SoC drivers as well.
> What do you think about it Jian ?
> 
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data) {
>>>> +               .name = "sd_emmc_b_clk0_div",
>>>> +               .ops = &clk_regmap_divider_ops,
>>>> +               .parent_names = (const char *[]){ "sd_emmc_b_clk0_sel" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_sd_emmc_b_clk0 = {
>>>> +       .data = &(struct clk_regmap_gate_data){
>>>> +               .offset = HHI_SD_EMMC_CLK_CNTL,
>>>> +               .bit_idx = 23,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "sd_emmc_b_clk0",
>>>> +               .ops = &clk_regmap_gate_ops,
>>>> +               .parent_names = (const char *[]){ "sd_emmc_b_clk0_div" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +/* EMMC/NAND clock */
>>>> +static struct clk_regmap g12a_sd_emmc_c_clk0_sel = {
>>>> +       .data = &(struct clk_regmap_mux_data){
>>>> +               .offset = HHI_NAND_CLK_CNTL,
>>>> +               .mask = 0x7,
>>>> +               .shift = 9,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data) {
>>>> +               .name = "sd_emmc_c_clk0_sel",
>>>> +               .ops = &clk_regmap_mux_ops,
>>>> +               .parent_names = g12a_sd_emmc_clk0_parent_names,
>>>> +               .num_parents = ARRAY_SIZE(g12a_sd_emmc_clk0_parent_names),
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_sd_emmc_c_clk0_div = {
>>>> +       .data = &(struct clk_regmap_div_data){
>>>> +               .offset = HHI_NAND_CLK_CNTL,
>>>> +               .shift = 0,
>>>> +               .width = 7,
>>>> +               .flags = CLK_DIVIDER_ROUND_CLOSEST,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data) {
>>>> +               .name = "sd_emmc_c_clk0_div",
>>>> +               .ops = &clk_regmap_divider_ops,
>>>> +               .parent_names = (const char *[]){ "sd_emmc_c_clk0_sel" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +static struct clk_regmap g12a_sd_emmc_c_clk0 = {
>>>> +       .data = &(struct clk_regmap_gate_data){
>>>> +               .offset = HHI_NAND_CLK_CNTL,
>>>> +               .bit_idx = 7,
>>>> +       },
>>>> +       .hw.init = &(struct clk_init_data){
>>>> +               .name = "sd_emmc_c_clk0",
>>>> +               .ops = &clk_regmap_gate_ops,
>>>> +               .parent_names = (const char *[]){ "sd_emmc_c_clk0_div" },
>>>> +               .num_parents = 1,
>>>> +               .flags = CLK_SET_RATE_PARENT,
>>>> +       },
>>>> +};
>>>> +
>>>> +/* Everything Else (EE) domain gates */
>>>> +static MESON_GATE(g12a_ddr, HHI_GCLK_MPEG0, 0);
>>>> +static MESON_GATE(g12a_dos, HHI_GCLK_MPEG0, 1);
>>>> +static MESON_GATE(g12a_audio_locker, HHI_GCLK_MPEG0, 2);
>>>> +static MESON_GATE(g12a_mipi_dsi_host, HHI_GCLK_MPEG0, 3);
>>>> +static MESON_GATE(g12a_eth_phy, HHI_GCLK_MPEG0, 4);
>>>> +static MESON_GATE(g12a_isa, HHI_GCLK_MPEG0, 5);
>>>> +static MESON_GATE(g12a_pl301, HHI_GCLK_MPEG0, 6);
>>>> +static MESON_GATE(g12a_periphs, HHI_GCLK_MPEG0, 7);
>>>> +static MESON_GATE(g12a_spicc_0, HHI_GCLK_MPEG0, 8);
>>>> +static MESON_GATE(g12a_i2c, HHI_GCLK_MPEG0, 9);
>>>> +static MESON_GATE(g12a_sana, HHI_GCLK_MPEG0, 10);
>>>> +static MESON_GATE(g12a_sd, HHI_GCLK_MPEG0, 11);
>>>> +static MESON_GATE(g12a_rng0, HHI_GCLK_MPEG0, 12);
>>>> +static MESON_GATE(g12a_uart0, HHI_GCLK_MPEG0, 13);
>>>> +static MESON_GATE(g12a_spicc_1, HHI_GCLK_MPEG0, 14);
>>>> +static MESON_GATE(g12a_hiu_reg, HHI_GCLK_MPEG0, 19);
>>>> +static MESON_GATE(g12a_mipi_dsi_phy, HHI_GCLK_MPEG0, 20);
>>>> +static MESON_GATE(g12a_assist_misc, HHI_GCLK_MPEG0, 23);
>>>> +static MESON_GATE(g12a_emmc_a, HHI_GCLK_MPEG0, 24);
>>>> +static MESON_GATE(g12a_emmc_b, HHI_GCLK_MPEG0, 25);
>>>> +static MESON_GATE(g12a_emmc_c, HHI_GCLK_MPEG0, 26);
>>>> +static MESON_GATE(g12a_audio_codec, HHI_GCLK_MPEG0, 28);
>>>> +
>>>> +static MESON_GATE(g12a_audio, HHI_GCLK_MPEG1, 0);
>>>> +static MESON_GATE(g12a_eth_core, HHI_GCLK_MPEG1, 3);
>>>> +static MESON_GATE(g12a_demux, HHI_GCLK_MPEG1, 4);
>>>> +static MESON_GATE(g12a_audio_ififo, HHI_GCLK_MPEG1, 11);
>>>> +static MESON_GATE(g12a_adc, HHI_GCLK_MPEG1, 13);
>>>> +static MESON_GATE(g12a_uart1, HHI_GCLK_MPEG1, 16);
>>>> +static MESON_GATE(g12a_g2d, HHI_GCLK_MPEG1, 20);
>>>> +static MESON_GATE(g12a_reset, HHI_GCLK_MPEG1, 23);
>>>> +static MESON_GATE(g12a_pcie_comb, HHI_GCLK_MPEG1, 24);
>>>> +static MESON_GATE(g12a_parser, HHI_GCLK_MPEG1, 25);
>>>> +static MESON_GATE(g12a_usb_general, HHI_GCLK_MPEG1, 26);
>>>> +static MESON_GATE(g12a_pcie_phy, HHI_GCLK_MPEG1, 27);
>>>> +static MESON_GATE(g12a_ahb_arb0, HHI_GCLK_MPEG1, 29);
>>>> +
>>>> +static MESON_GATE(g12a_ahb_data_bus, HHI_GCLK_MPEG2, 1);
>>>> +static MESON_GATE(g12a_ahb_ctrl_bus, HHI_GCLK_MPEG2, 2);
>>>> +static MESON_GATE(g12a_htx_hdcp22, HHI_GCLK_MPEG2, 3);
>>>> +static MESON_GATE(g12a_htx_pclk, HHI_GCLK_MPEG2, 4);
>>>> +static MESON_GATE(g12a_bt656, HHI_GCLK_MPEG2, 6);
>>>> +static MESON_GATE(g12a_usb1_to_ddr, HHI_GCLK_MPEG2, 8);
>>>> +static MESON_GATE(g12a_mmc_pclk, HHI_GCLK_MPEG2, 11);
>>>> +static MESON_GATE(g12a_uart2, HHI_GCLK_MPEG2, 15);
>>>> +static MESON_GATE(g12a_vpu_intr, HHI_GCLK_MPEG2, 25);
>>>> +static MESON_GATE(g12a_gic, HHI_GCLK_MPEG2, 30);
>>>> +
>>>> +static MESON_GATE(g12a_vclk2_venci0, HHI_GCLK_OTHER, 1);
>>>> +static MESON_GATE(g12a_vclk2_venci1, HHI_GCLK_OTHER, 2);
>>>> +static MESON_GATE(g12a_vclk2_vencp0, HHI_GCLK_OTHER, 3);
>>>> +static MESON_GATE(g12a_vclk2_vencp1, HHI_GCLK_OTHER, 4);
>>>> +static MESON_GATE(g12a_vclk2_venct0, HHI_GCLK_OTHER, 5);
>>>> +static MESON_GATE(g12a_vclk2_venct1, HHI_GCLK_OTHER, 6);
>>>> +static MESON_GATE(g12a_vclk2_other, HHI_GCLK_OTHER, 7);
>>>> +static MESON_GATE(g12a_vclk2_enci, HHI_GCLK_OTHER, 8);
>>>> +static MESON_GATE(g12a_vclk2_encp, HHI_GCLK_OTHER, 9);
>>>> +static MESON_GATE(g12a_dac_clk, HHI_GCLK_OTHER, 10);
>>>> +static MESON_GATE(g12a_aoclk_gate, HHI_GCLK_OTHER, 14);
>>>> +static MESON_GATE(g12a_iec958_gate, HHI_GCLK_OTHER, 16);
>>>> +static MESON_GATE(g12a_enc480p, HHI_GCLK_OTHER, 20);
>>>> +static MESON_GATE(g12a_rng1, HHI_GCLK_OTHER, 21);
>>>> +static MESON_GATE(g12a_vclk2_enct, HHI_GCLK_OTHER, 22);
>>>> +static MESON_GATE(g12a_vclk2_encl, HHI_GCLK_OTHER, 23);
>>>> +static MESON_GATE(g12a_vclk2_venclmmc, HHI_GCLK_OTHER, 24);
>>>> +static MESON_GATE(g12a_vclk2_vencl, HHI_GCLK_OTHER, 25);
>>>> +static MESON_GATE(g12a_vclk2_other1, HHI_GCLK_OTHER, 26);
>>>> +
>>>> +/* Array of all clocks provided by this provider */
>>>> +
>>>> +static struct clk_hw_onecell_data g12a_hw_onecell_data = {
>>>> +       .hws = {
>>>> +               [CLKID_SYS_PLL]                 = &g12a_sys_pll.hw,
>>>> +               [CLKID_FIXED_PLL]               = &g12a_fixed_pll.hw,
>>>> +               [CLKID_FCLK_DIV2]               = &g12a_fclk_div2.hw,
>>>> +               [CLKID_FCLK_DIV3]               = &g12a_fclk_div3.hw,
>>>> +               [CLKID_FCLK_DIV4]               = &g12a_fclk_div4.hw,
>>>> +               [CLKID_FCLK_DIV5]               = &g12a_fclk_div5.hw,
>>>> +               [CLKID_FCLK_DIV7]               = &g12a_fclk_div7.hw,
>>>> +               [CLKID_GP0_PLL]                 = &g12a_gp0_pll.hw,
>>>> +               [CLKID_MPEG_SEL]                = &g12a_mpeg_clk_sel.hw,
>>>> +               [CLKID_MPEG_DIV]                = &g12a_mpeg_clk_div.hw,
>>>> +               [CLKID_CLK81]                   = &g12a_clk81.hw,
>>>> +               [CLKID_MPLL0]                   = &g12a_mpll0.hw,
>>>> +               [CLKID_MPLL1]                   = &g12a_mpll1.hw,
>>>> +               [CLKID_MPLL2]                   = &g12a_mpll2.hw,
>>>> +               [CLKID_MPLL3]                   = &g12a_mpll3.hw,
>>>> +               [CLKID_DDR]                     = &g12a_ddr.hw,
>>>> +               [CLKID_DOS]                     = &g12a_dos.hw,
>>>> +               [CLKID_AUDIO_LOCKER]            = &g12a_audio_locker.hw,
>>>> +               [CLKID_MIPI_DSI_HOST]           = &g12a_mipi_dsi_host.hw,
>>>> +               [CLKID_ETH_PHY]                 = &g12a_eth_phy.hw,
>>>> +               [CLKID_ISA]                     = &g12a_isa.hw,
>>>> +               [CLKID_PL301]                   = &g12a_pl301.hw,
>>>> +               [CLKID_PERIPHS]                 = &g12a_periphs.hw,
>>>> +               [CLKID_SPICC0]                  = &g12a_spicc_0.hw,
>>>> +               [CLKID_I2C]                     = &g12a_i2c.hw,
>>>> +               [CLKID_SANA]                    = &g12a_sana.hw,
>>>> +               [CLKID_SD]                      = &g12a_sd.hw,
>>>> +               [CLKID_RNG0]                    = &g12a_rng0.hw,
>>>> +               [CLKID_UART0]                   = &g12a_uart0.hw,
>>>> +               [CLKID_SPICC1]                  = &g12a_spicc_1.hw,
>>>> +               [CLKID_HIU_IFACE]               = &g12a_hiu_reg.hw,
>>>> +               [CLKID_MIPI_DSI_PHY]            = &g12a_mipi_dsi_phy.hw,
>>>> +               [CLKID_ASSIST_MISC]             = &g12a_assist_misc.hw,
>>>> +               [CLKID_SD_EMMC_A]               = &g12a_emmc_a.hw,
>>>> +               [CLKID_SD_EMMC_B]               = &g12a_emmc_b.hw,
>>>> +               [CLKID_SD_EMMC_C]               = &g12a_emmc_c.hw,
>>>> +               [CLKID_AUDIO_CODEC]             = &g12a_audio_codec.hw,
>>>> +               [CLKID_AUDIO]                   = &g12a_audio.hw,
>>>> +               [CLKID_ETH]                     = &g12a_eth_core.hw,
>>>> +               [CLKID_DEMUX]                   = &g12a_demux.hw,
>>>> +               [CLKID_AUDIO_IFIFO]             = &g12a_audio_ififo.hw,
>>>> +               [CLKID_ADC]                     = &g12a_adc.hw,
>>>> +               [CLKID_UART1]                   = &g12a_uart1.hw,
>>>> +               [CLKID_G2D]                     = &g12a_g2d.hw,
>>>> +               [CLKID_RESET]                   = &g12a_reset.hw,
>>>> +               [CLKID_PCIE_COMB]               = &g12a_pcie_comb.hw,
>>>> +               [CLKID_PARSER]                  = &g12a_parser.hw,
>>>> +               [CLKID_USB]                     = &g12a_usb_general.hw,
>>>> +               [CLKID_PCIE_PHY]                = &g12a_pcie_phy.hw,
>>>> +               [CLKID_AHB_ARB0]                = &g12a_ahb_arb0.hw,
>>>> +               [CLKID_AHB_DATA_BUS]            = &g12a_ahb_data_bus.hw,
>>>> +               [CLKID_AHB_CTRL_BUS]            = &g12a_ahb_ctrl_bus.hw,
>>>> +               [CLKID_HTX_HDCP22]              = &g12a_htx_hdcp22.hw,
>>>> +               [CLKID_HTX_PCLK]                = &g12a_htx_pclk.hw,
>>>> +               [CLKID_BT656]                   = &g12a_bt656.hw,
>>>> +               [CLKID_USB1_DDR_BRIDGE]         = &g12a_usb1_to_ddr.hw,
>>>> +               [CLKID_MMC_PCLK]                = &g12a_mmc_pclk.hw,
>>>> +               [CLKID_UART2]                   = &g12a_uart2.hw,
>>>> +               [CLKID_VPU_INTR]                = &g12a_vpu_intr.hw,
>>>> +               [CLKID_GIC]                     = &g12a_gic.hw,
>>>> +               [CLKID_SD_EMMC_B_CLK0_SEL]      = &g12a_sd_emmc_b_clk0_sel.hw,
>>>> +               [CLKID_SD_EMMC_B_CLK0_DIV]      = &g12a_sd_emmc_b_clk0_div.hw,
>>>> +               [CLKID_SD_EMMC_B_CLK0]          = &g12a_sd_emmc_b_clk0.hw,
>>>> +               [CLKID_SD_EMMC_C_CLK0_SEL]      = &g12a_sd_emmc_c_clk0_sel.hw,
>>>> +               [CLKID_SD_EMMC_C_CLK0_DIV]      = &g12a_sd_emmc_c_clk0_div.hw,
>>>> +               [CLKID_SD_EMMC_C_CLK0]          = &g12a_sd_emmc_c_clk0.hw,
>>>> +               [CLKID_MPLL0_DIV]               = &g12a_mpll0_div.hw,
>>>> +               [CLKID_MPLL1_DIV]               = &g12a_mpll1_div.hw,
>>>> +               [CLKID_MPLL2_DIV]               = &g12a_mpll2_div.hw,
>>>> +               [CLKID_MPLL3_DIV]               = &g12a_mpll3_div.hw,
>>>> +               [CLKID_HIFI_PLL]                = &g12a_hifi_pll.hw,
>>>> +               [CLKID_VCLK2_VENCI0]            = &g12a_vclk2_venci0.hw,
>>>> +               [CLKID_VCLK2_VENCI1]            = &g12a_vclk2_venci1.hw,
>>>> +               [CLKID_VCLK2_VENCP0]            = &g12a_vclk2_vencp0.hw,
>>>> +               [CLKID_VCLK2_VENCP1]            = &g12a_vclk2_vencp1.hw,
>>>> +               [CLKID_VCLK2_VENCT0]            = &g12a_vclk2_venct0.hw,
>>>> +               [CLKID_VCLK2_VENCT1]            = &g12a_vclk2_venct1.hw,
>>>> +               [CLKID_VCLK2_OTHER]             = &g12a_vclk2_other.hw,
>>>> +               [CLKID_VCLK2_ENCI]              = &g12a_vclk2_enci.hw,
>>>> +               [CLKID_VCLK2_ENCP]              = &g12a_vclk2_encp.hw,
>>>> +               [CLKID_DAC_CLK]                 = &g12a_dac_clk.hw,
>>>> +               [CLKID_AOCLK]                   = &g12a_aoclk_gate.hw,
>>>> +               [CLKID_IEC958]                  = &g12a_iec958_gate.hw,
>>>> +               [CLKID_ENC480P]                 = &g12a_enc480p.hw,
>>>> +               [CLKID_RNG1]                    = &g12a_rng1.hw,
>>>> +               [CLKID_VCLK2_ENCT]              = &g12a_vclk2_enct.hw,
>>>> +               [CLKID_VCLK2_ENCL]              = &g12a_vclk2_encl.hw,
>>>> +               [CLKID_VCLK2_VENCLMMC]          = &g12a_vclk2_venclmmc.hw,
>>>> +               [CLKID_VCLK2_VENCL]             = &g12a_vclk2_vencl.hw,
>>>> +               [CLKID_VCLK2_OTHER1]            = &g12a_vclk2_other1.hw,
>>>> +               [NR_CLKS]                       = NULL,
>>>> +       },
>>>> +       .num = NR_CLKS,
>>>> +};
>>>> +
>>>> +/* Convenience table to populate regmap in .probe */
>>>> +static struct clk_regmap *const g12a_clk_regmaps[] = {
>>>> +       &g12a_clk81,
>>>> +       &g12a_dos,
>>>> +       &g12a_ddr,
>>>> +       &g12a_audio_locker,
>>>> +       &g12a_mipi_dsi_host,
>>>> +       &g12a_eth_phy,
>>>> +       &g12a_isa,
>>>> +       &g12a_pl301,
>>>> +       &g12a_periphs,
>>>> +       &g12a_spicc_0,
>>>> +       &g12a_i2c,
>>>> +       &g12a_sana,
>>>> +       &g12a_sd,
>>>> +       &g12a_rng0,
>>>> +       &g12a_uart0,
>>>> +       &g12a_spicc_1,
>>>> +       &g12a_hiu_reg,
>>>> +       &g12a_mipi_dsi_phy,
>>>> +       &g12a_assist_misc,
>>>> +       &g12a_emmc_a,
>>>> +       &g12a_emmc_b,
>>>> +       &g12a_emmc_c,
>>>> +       &g12a_audio_codec,
>>>> +       &g12a_audio,
>>>> +       &g12a_eth_core,
>>>> +       &g12a_demux,
>>>> +       &g12a_audio_ififo,
>>>> +       &g12a_adc,
>>>> +       &g12a_uart1,
>>>> +       &g12a_g2d,
>>>> +       &g12a_reset,
>>>> +       &g12a_pcie_comb,
>>>> +       &g12a_parser,
>>>> +       &g12a_usb_general,
>>>> +       &g12a_pcie_phy,
>>>> +       &g12a_ahb_arb0,
>>>> +       &g12a_ahb_data_bus,
>>>> +       &g12a_ahb_ctrl_bus,
>>>> +       &g12a_htx_hdcp22,
>>>> +       &g12a_htx_pclk,
>>>> +       &g12a_bt656,
>>>> +       &g12a_usb1_to_ddr,
>>>> +       &g12a_mmc_pclk,
>>>> +       &g12a_vpu_intr,
>>>> +       &g12a_gic,
>>>> +       &g12a_sd_emmc_b_clk0,
>>>> +       &g12a_sd_emmc_c_clk0,
>>>> +       &g12a_mpeg_clk_div,
>>>> +       &g12a_sd_emmc_b_clk0_div,
>>>> +       &g12a_sd_emmc_c_clk0_div,
>>>> +       &g12a_mpeg_clk_sel,
>>>> +       &g12a_sd_emmc_b_clk0_sel,
>>>> +       &g12a_sd_emmc_c_clk0_sel,
>>>> +       &g12a_mpll0,
>>>> +       &g12a_mpll1,
>>>> +       &g12a_mpll2,
>>>> +       &g12a_mpll3,
>>>> +       &g12a_mpll0_div,
>>>> +       &g12a_mpll1_div,
>>>> +       &g12a_mpll2_div,
>>>> +       &g12a_mpll3_div,
>>>> +       &g12a_fixed_pll,
>>>> +       &g12a_sys_pll,
>>>> +       &g12a_gp0_pll,
>>>> +       &g12a_hifi_pll,
>>>> +       &g12a_vclk2_venci0,
>>>> +       &g12a_vclk2_venci1,
>>>> +       &g12a_vclk2_vencp0,
>>>> +       &g12a_vclk2_vencp1,
>>>> +       &g12a_vclk2_venct0,
>>>> +       &g12a_vclk2_venct1,
>>>> +       &g12a_vclk2_other,
>>>> +       &g12a_vclk2_enci,
>>>> +       &g12a_vclk2_encp,
>>>> +       &g12a_dac_clk,
>>>> +       &g12a_aoclk_gate,
>>>> +       &g12a_iec958_gate,
>>>> +       &g12a_enc480p,
>>>> +       &g12a_rng1,
>>>> +       &g12a_vclk2_enct,
>>>> +       &g12a_vclk2_encl,
>>>> +       &g12a_vclk2_venclmmc,
>>>> +       &g12a_vclk2_vencl,
>>>> +       &g12a_vclk2_other1,
>>>> +};
>>>> +
>>>> +static const struct of_device_id clkc_match_table[] = {
>>>> +       { .compatible = "amlogic,g12a-clkc" },
>>>
>>> I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
>>> and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
>>> correct - I'll CC Rob Herring on the dt-bindings patch)
>>>
>>
>> we're fine with either way, since the g12a is recently new added SoC.
>>
>> but I guess those old compatibles which already exist won't be changed,
>> as it will break the DT
> 
> Yes, I doubt we are going to change the compatibles. With or without the meson
> prefix, I suppose it going to stay that way.
> 
> It is worth thinking about it for new drivers though.
> We already have the "amlogic,", so do we really to prefix even more with "meson-
> "
> 
> Also, if we were really strict about that scheme, should meson8b compatible be
> 
> "amlogic,meson-meson8b-foo-bar" ... the SoC is meson8b, not just 8b after all ?
> 
> For the particular case of the clock controller, I don't care very much, as long
> as the compatible is coherent with documentation.
> 
> I might have a preference for the current compatible ... just for consistency
> with the other clock controllers.
> 
do you imply that we should just stick to 'amlogic,g12a-clkc'?

it sound good to me, at least it's shorter than 'amlogic,meson-g12a-clkc'..

>>
>>>> +       {}
>>>> +};
>>>> +
>>>> +static const struct regmap_config clkc_regmap_config = {
>>>> +       .reg_bits       = 32,
>>>> +       .val_bits       = 32,
>>>> +       .reg_stride     = 4,
>>>> +};
>>>> +
>>>> +static int g12a_clkc_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct device *dev = &pdev->dev;
>>>> +       struct regmap *map;
>>>> +       int ret, i;
>>>> +
>>>> +       /* Get the hhi system controller node if available */
>>>> +       map = syscon_node_to_regmap(of_get_parent(dev->of_node));
>>>> +       if (IS_ERR(map)) {
>>>> +               dev_err(dev,
>>>> +                       "failed to get HHI regmap - Trying obsolete regs\n");
>>>
>>> this message doesn't seem right - there's no code for the "obsolete
>>> regs" (which shouldn't be used by a new driver anyways)
>>>
>>
>> oh, this is definitely need to be fixed (guess it's a copy & paste issue)
>> thanks for catching this, martin!
> 
> Yes, copy/paste for sure !
> 
>>
>>>> +               return PTR_ERR(map);
>>>> +       }
>>>> +
>>>> +       /* Populate regmap for the regmap backed clocks */
>>>> +       for (i = 0; i < ARRAY_SIZE(g12a_clk_regmaps); i++)
>>>> +               g12a_clk_regmaps[i]->map = map;
>>>> +
>>>> +       for (i = 0; i < g12a_hw_onecell_data.num; i++) {
>>>> +               /* array might be sparse */
>>>> +               if (!g12a_hw_onecell_data.hws[i])
>>>> +                       continue;
>>>> +
>>>> +               ret = devm_clk_hw_register(dev, g12a_hw_onecell_data.hws[i]);
>>>> +               if (ret) {
>>>> +                       dev_err(dev, "Clock registration failed\n");
>>>> +                       return ret;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>>>> +                                          &g12a_hw_onecell_data);
>>>> +}
>>>> +
>>>> +static struct platform_driver g12a_driver = {
>>>> +       .probe          = g12a_clkc_probe,
>>>> +       .driver         = {
>>>> +               .name   = "g12a-clkc",
>>>> +               .of_match_table = clkc_match_table,
>>>> +       },
>>>> +};
>>>> +
>>>> +builtin_platform_driver(g12a_driver);
>>>> diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
>>>> new file mode 100644
>>>> index 0000000..98cb93c
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/g12a.h
>>>> @@ -0,0 +1,123 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>>> +/*
>>>> + * Copyright (c) 2016 AmLogic, Inc.
>>>> + * Author: Michael Turquette <mturquette@baylibre.com>
>>>> + *
>>>> + * Copyright (c) 2018 Amlogic, inc.
>>>> + * Author: Jian Hu <jian.hu@amlogic.com>
>>>> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
>>>> + *
>>>> + */
>>>> +#ifndef __G12A_H
>>>> +#define __G12A_H
>>>> +
>>>> +/*
>>>> + * Clock controller register offsets
>>>> + *
>>>> + * Register offsets from the data sheet must be multiplied by 4 before
>>>> + * adding them to the base address to get the right value.
>>>> + */
>>>> +#define HHI_MIPI_CNTL0                 0x000
>>>> +#define HHI_MIPI_CNTL1                 0x004
>>>> +#define HHI_MIPI_CNTL2                 0x008
>>>> +#define HHI_MIPI_STS                   0x00C
>>>> +#define HHI_GP0_PLL_CNTL0              0x040
>>>> +#define HHI_GP0_PLL_CNTL1              0x044
>>>> +#define HHI_GP0_PLL_CNTL2              0x048
>>>> +#define HHI_GP0_PLL_CNTL3              0x04C
>>>> +#define HHI_GP0_PLL_CNTL4              0x050
>>>> +#define HHI_GP0_PLL_CNTL5              0x054
>>>> +#define HHI_GP0_PLL_CNTL6              0x058
>>>> +#define HHI_GP0_PLL_STS                        0x05C
>>>> +#define HHI_PCIE_PLL_CNTL0             0x098
>>>> +#define HHI_PCIE_PLL_CNTL1             0x09C
>>>> +#define HHI_PCIE_PLL_CNTL2             0x0A0
>>>> +#define HHI_PCIE_PLL_CNTL3             0x0A4
>>>> +#define HHI_PCIE_PLL_CNTL4             0x0A8
>>>> +#define HHI_PCIE_PLL_CNTL5             0x0AC
>>>> +#define HHI_PCIE_PLL_STS               0x0B8
>>>> +#define HHI_HIFI_PLL_CNTL0             0x0D8
>>>> +#define HHI_HIFI_PLL_CNTL1             0x0DC
>>>> +#define HHI_HIFI_PLL_CNTL2             0x0E0
>>>> +#define HHI_HIFI_PLL_CNTL3             0x0E4
>>>> +#define HHI_HIFI_PLL_CNTL4             0x0E8
>>>> +#define HHI_HIFI_PLL_CNTL5             0x0EC
>>>> +#define HHI_HIFI_PLL_CNTL6             0x0F0
>>>> +#define HHI_GCLK_MPEG0                 0x140
>>>> +#define HHI_GCLK_MPEG1                 0x144
>>>> +#define HHI_GCLK_MPEG2                 0x148
>>>> +#define HHI_GCLK_OTHER                 0x150
>>>> +#define HHI_MPEG_CLK_CNTL              0x174
>>>> +#define HHI_AUD_CLK_CNTL               0x178
>>>> +#define HHI_VID_CLK_CNTL               0x17c
>>>> +#define HHI_TS_CLK_CNTL                        0x190
>>>> +#define HHI_VID_CLK_CNTL2              0x194
>>>> +#define HHI_SYS_CPU_CLK_CNTL0  0x19c
>>>> +#define HHI_MALI_CLK_CNTL              0x1b0
>>>> +#define HHI_VPU_CLKC_CNTL              0x1b4
>>>> +#define HHI_VPU_CLK_CNTL               0x1bC
>>>> +#define HHI_HDMI_CLK_CNTL              0x1CC
>>>> +#define HHI_VDEC_CLK_CNTL              0x1E0
>>>> +#define HHI_VDEC2_CLK_CNTL             0x1E4
>>>> +#define HHI_VDEC3_CLK_CNTL             0x1E8
>>>> +#define HHI_VDEC4_CLK_CNTL             0x1EC
>>>> +#define HHI_HDCP22_CLK_CNTL            0x1F0
>>>> +#define HHI_VAPBCLK_CNTL               0x1F4
>>>> +#define HHI_VPU_CLKB_CNTL              0x20C
>>>> +#define HHI_GEN_CLK_CNTL               0x228
>>>> +#define HHI_VDIN_MEAS_CLK_CNTL 0x250
>>>> +#define HHI_MIPIDSI_PHY_CLK_CNTL       0x254
>>>> +#define HHI_NAND_CLK_CNTL              0x25C
>>>> +#define HHI_SD_EMMC_CLK_CNTL   0x264
>>>> +#define HHI_MPLL_CNTL0                 0x278
>>>> +#define HHI_MPLL_CNTL1                 0x27C
>>>> +#define HHI_MPLL_CNTL2                 0x280
>>>> +#define HHI_MPLL_CNTL3                 0x284
>>>> +#define HHI_MPLL_CNTL4                 0x288
>>>> +#define HHI_MPLL_CNTL5                 0x28c
>>>> +#define HHI_MPLL_CNTL6                 0x290
>>>> +#define HHI_MPLL_CNTL7                 0x294
>>>> +#define HHI_MPLL_CNTL8                 0x298
>>>> +#define HHI_FIX_PLL_CNTL0              0x2A0
>>>> +#define HHI_FIX_PLL_CNTL1              0x2A4
>>>> +#define HHI_SYS_PLL_CNTL0              0x2f4
>>>> +#define HHI_SYS_PLL_CNTL1              0x2f8
>>>> +#define HHI_SYS_PLL_CNTL2              0x2fc
>>>> +#define HHI_SYS_PLL_CNTL3              0x300
>>>> +#define HHI_SYS_PLL_CNTL4              0x304
>>>> +#define HHI_SYS_PLL_CNTL5              0x308
>>>> +#define HHI_SYS_PLL_CNTL6              0x30c
>>>> +#define HHI_SPICC_CLK_CNTL             0x3dc
>>>> +
>>>> +/*
>>>> + * CLKID index values
>>>> + *
>>>> + * These indices are entirely contrived and do not map onto the hardware.
>>>> + * It has now been decided to expose everything by default in the DT header:
>>>> + * include/dt-bindings/clock/g12a-clkc.h. Only the clocks ids we don't want
>>>> + * to expose, such as the internal muxes and dividers of composite clocks,
>>>> + * will remain defined here.
>>>> + */
>>>> +#define CLKID_MPEG_SEL                         8
>>>> +#define CLKID_MPEG_DIV                         9
>>>> +#define CLKID_SD_EMMC_B_CLK0_SEL       62
>>>> +#define CLKID_SD_EMMC_B_CLK0_DIV       63
>>>> +#define CLKID_SD_EMMC_C_CLK0_SEL       64
>>>> +#define CLKID_SD_EMMC_C_CLK0_DIV       65
>>>> +#define CLKID_MPLL0_DIV                                66
>>>> +#define CLKID_MPLL1_DIV                                67
>>>> +#define CLKID_MPLL2_DIV                                68
>>>> +#define CLKID_MPLL3_DIV                                69
>>>> +#define CLKID_MPLL_PREDIV                      70
>>>> +#define CLKID_FCLK_DIV2_DIV                    72
>>>> +#define CLKID_FCLK_DIV3_DIV                    73
>>>> +#define CLKID_FCLK_DIV4_DIV                    74
>>>> +#define CLKID_FCLK_DIV5_DIV                    75
>>>> +#define CLKID_FCLK_DIV7_DIV                    76
> 
> Please fix the alignement
> 
>>>> +
>>>> +#define NR_CLKS                                                96
>>>> +
>>>> +/* include the CLKIDs that have been made part of the DT binding */
>>>> +#include <dt-bindings/clock/g12a-clkc.h>
>>>> +
>>>> +#endif /* __G12A_H */
>>>> --
>>>> 1.9.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-amlogic mailing list
>>>> linux-amlogic@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>>
>>> .
>>>
>>
>>
> 
> .
> 

