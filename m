Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000BFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C4920849
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KQWoBvM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C4920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGCS62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:58:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35888 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeGCS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:58:26 -0400
Received: by mail-oi0-f65.google.com with SMTP id r16-v6so5957139oie.3;
        Tue, 03 Jul 2018 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XRoCYYcSmqp4TAcZAwaZPjc5Pi8w+T7lLkbNBuLPkM=;
        b=KQWoBvM2XSh/S3KDZBCaMsPOrTzz8pEbmz/7MAqL2FQFZhHCk+aknapbaLcWniUrye
         pluaf/tcQKHWCZCWxQnKQidkGtz2rT55vKQEfhjqne9l2j5e6M9RzXpaxJnc7Mi+/ajE
         +XIEmmvuxQM7a4rGVzcXvLfSfdFKdDFtDP6jM+UG70JFEEuS2ySm0MmI6CXmCETnMLII
         1wKOCvb4yBihiAnBBPvEAT/YL8fae00kr2DVIOlpybHPAvHv/kRtCJ6vxTNT+u+89kGq
         /1wfKa+Q7/WEdMUmgykVxU7bD5a4SPF+S/pEnlUULYZOt7k9wG9O8Jy8PpLrcLqiOpSu
         4m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XRoCYYcSmqp4TAcZAwaZPjc5Pi8w+T7lLkbNBuLPkM=;
        b=AGum2eiQEd+OxP26w4cRyMAts6VByhJBYDoRu0YwzrlxRe+PrdaDU+/6+STuWnYeDi
         MTtiUw/LxbcEAYm5m9NZF4m1Ms2y8/8/jYfUMDbRRxR4jRFCSaewyLIfp89K3ej6Wdl0
         //XRgFl2rNPAKzvq1UkwlRIppZjaeXVMNE6e9w6ge/guy+C4H/4s5jvKKLEC/PhaQl+p
         tNGoKRn8t4hm8FnlTzF+cVcgYSJYHd+v4MA5oMtMGqzjngpyoB0hBGwBDKiz3ARCms0m
         Txayog7d6leosPEKOIScm/4MBfsKX2awptq1cnBEs8/ViF5J+1FHqJu90JjXZe44ZZgw
         /MTA==
X-Gm-Message-State: APt69E3blMPFtmmbuFHjq8hVjIoFHEcUnUWPpXGrO3wogYykj78EL1Ig
        hB3qOo3C6xf3LSX/+P8am0FG6LRw3p5GeGQ42lrMcRVa
X-Google-Smtp-Source: AAOMgpek1VkHvwPcl8uaiJyt2EGbMIaACOs8VzclyYNXNtlfPhOGNx8lif3tmjzvcfjyM7r27dMtXoX8jtftm8LcaO0=
X-Received: by 2002:aca:cd8f:: with SMTP id d137-v6mr23562195oig.350.1530644304686;
 Tue, 03 Jul 2018 11:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180703145716.31860-1-yixun.lan@amlogic.com> <20180703145716.31860-4-yixun.lan@amlogic.com>
In-Reply-To: <20180703145716.31860-4-yixun.lan@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Jul 2018 20:58:13 +0200
Message-ID: <CAFBinCCFQr+_k7bkda0a3wVQdyG8DzEyim6v_OBikUifCxyVXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: meson: add sub EMMC clock controller driver
To:     yixun.lan@amlogic.com
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, carlo@caione.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh@kernel.org, miquel.raynal@bootlin.com,
        boris.brezillon@bootlin.com, liang.yang@amlogic.com,
        qiufang.dai@amlogic.com, jian.hu@amlogic.com,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yixun,

apart from what Jerome found this looks good to me.
one small "issue" and a question are inline below

On Tue, Jul 3, 2018 at 9:00 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>
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
>         select COMMON_CLK_REGMAP_MESON
>         select RESET_CONTROLLER
>
> +config COMMON_CLK_EMMC_MESON
> +       tristate "Meson EMMC Sub Clock Controller Driver"
> +       depends on COMMON_CLK_AMLOGIC
> +       select MFD_SYSCON
> +       select REGMAP
> +       help
> +         Support for the EMMC sub clock controller on AmLogic Meson Platform,
> +         Say Y if you want this clock enabled.
> +
>  config COMMON_CLK_REGMAP_MESON
>         bool
>         select REGMAP
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 72ec8c40d848..2f04f77ba4de 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)   += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
>  obj-$(CONFIG_COMMON_CLK_AXG)    += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)     += axg-audio.o
> +obj-$(CONFIG_COMMON_CLK_EMMC_MESON)    += emmc-clkc.o
>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)  += clk-regmap.o
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
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/emmc-clkc.h>
> +
> +#include "clkc.h"
> +
> +#define SD_EMMC_CLOCK          0
> +#define MUX_CLK_NUM_PARENTS    2
> +#define EMMC_MAX_CLKS          2
> +#define CLK_NAME_LEN           48
> +
> +static struct clk_regmap_mux_data emmc_clkc_mux_data = {
> +       .offset = SD_EMMC_CLOCK,
> +       .mask = 0x3,
> +       .shift = 6,
> +};
> +
> +static struct clk_regmap_div_data emmc_clkc_div_data = {
> +       .offset = SD_EMMC_CLOCK,
> +       .shift = 0,
> +       .width = 6,
> +       .flags = CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
> +};
> +
> +static const struct of_device_id clkc_match_table[] = {
> +       { .compatible = "amlogic,emmc-clkc" },
shouldn't this be "amlogic,meson-axg-emmc-clkc" (and optionally also
"amlogic,meson-gx-emmc-clkc")?

> +       {}
> +};
> +
> +static int emmc_clkc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct clk_regmap *mux, *div;
> +       struct regmap *map;
> +       struct clk *clk;
> +       int i, ret;
> +       const char *parent_names[MUX_CLK_NUM_PARENTS];
> +       struct clk_init_data init;
> +       char mux_name[CLK_NAME_LEN], div_name[CLK_NAME_LEN];
> +       struct clk_hw_onecell_data *onecell_data;
> +
> +       map = syscon_node_to_regmap(dev->of_node);
> +
> +       mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +       div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
> +
> +       onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
> +                                   sizeof(*onecell_data->hws) * EMMC_MAX_CLKS,
> +                                   GFP_KERNEL);
> +
> +       if (!mux || !div || !onecell_data)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
> +               char name[8];
> +
> +               snprintf(name, sizeof(name), "clkin%d", i);
> +               clk = devm_clk_get(dev, name);
> +               if (IS_ERR(clk)) {
> +                       if (clk != ERR_PTR(-EPROBE_DEFER))
> +                               dev_err(dev, "Missing clock %s\n", name);
> +                       return PTR_ERR(clk);
> +               }
> +
> +               parent_names[i] = __clk_get_name(clk);
> +       }
> +
> +       mux->map = map;
> +       mux->data = &emmc_clkc_mux_data;
> +
> +       snprintf(mux_name, CLK_NAME_LEN, "%s#emmc_mux", dev_name(dev));
> +
> +       init.name = mux_name;
> +       init.ops = &clk_regmap_mux_ops;
> +       init.flags = CLK_SET_RATE_PARENT;
> +       init.parent_names = parent_names;
> +       init.num_parents = MUX_CLK_NUM_PARENTS;
> +
> +       mux->hw.init = &init;
> +       ret = devm_clk_hw_register(dev, &mux->hw);
> +       if (ret) {
> +               dev_err(dev, "Mux clock registration failed\n");
> +               return ret;
> +       }
> +
> +       parent_names[0] = mux_name;
> +       div->map = map;
> +       div->data = &emmc_clkc_div_data;
> +
> +       snprintf(div_name, CLK_NAME_LEN, "%s#emmc_div", dev_name(dev));
> +
> +       init.name = div_name;
> +       init.ops = &clk_regmap_divider_ops;
> +       init.flags = CLK_SET_RATE_PARENT;
> +       init.parent_names = parent_names;
> +       init.num_parents = 1;
> +
> +       div->hw.init = &init;
> +       ret = devm_clk_hw_register(dev, &div->hw);
> +       if (ret) {
> +               dev_err(dev, "Div clock registration failed\n");
> +               return ret;
> +       }
> +
> +       onecell_data->hws[CLKID_EMMC_C_MUX] = &mux->hw,
> +       onecell_data->hws[CLKID_EMMC_C_DIV] = &div->hw,
> +       onecell_data->num = EMMC_MAX_CLKS;
you are describing the mux and the divider here
however, meson-gx-mmc.c has a few more clock related bits:
- CLK_CORE_PHASE_MASK
- CLK_TX_PHASE_MASK
- CLK_RX_PHASE_MASK
- CLK_V2_TX_DELAY_MASK / CLK_V3_TX_DELAY_MASK
- CLK_V2_RX_DELAY_MASK / CLK_V3_RX_DELAY_MASK
- CLK_V2_ALWAYS_ON / CLK_V3_ALWAYS_ON

are these used for the MMC clock or are some of these routed to the
NAND pins as well?


Regards
Martin
