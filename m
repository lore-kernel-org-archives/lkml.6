Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02196C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E1621735
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E1621735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbeHNM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:29:24 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37326 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbeHNM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:29:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id j205-v6so32463997oib.4;
        Tue, 14 Aug 2018 02:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpiL4JBHlXCdHQAVuFQ7NZPTdP+xH9SeHmCUtcPHV9g=;
        b=hw+evJRgqLO33piRFzJ4keVK5wODL8Y4kviL+t/huIxAIlcLo0i5fhdeUFm6hgVGk7
         seqlZhPR1vYU3pXV/L/Ltm9ieYIjcbQFaourBkOS5CvNPysRGdevEIoc30ulsxs/ZsuN
         9k76h34mJlqquc4FHvcL0Wx4BpJqcOvWC/UQ8QqS68MnAfastSFGFyJI0wYAuOIx35es
         3tTQ1HM10StCp4/URCC/fY1zYxbMkDcmiTjjLKQ1bsvSgaHipqD23YmoBrU3mLw52jCR
         YiUTIPje35m0zzskzDbVLhXwVmI1XiD3aZJq9spAjRDE6NXgXdzdtIRESPyDwYmGEBqi
         hvrg==
X-Gm-Message-State: AOUpUlHjSLAebzpCvW9OJN9IwI7RpjMkpY+KHwoHTD/rZ7g77KwfWxG3
        NkNfcm3H+AsNDN82QZo/EqljIXyyLxedk9/kNXs=
X-Google-Smtp-Source: AA+uWPy/7IQCwd2mHrNLiM1n/LD61YdpYkNAuz6ffBRJ6iP16PiU5ffScn0GZDSye+bLPxWvefcmkzx6W5M+r6Nnx6w=
X-Received: by 2002:aca:45c3:: with SMTP id s186-v6mr20522189oia.289.1534239778373;
 Tue, 14 Aug 2018 02:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180809214414.20905-1-paul@crapouillou.net> <20180809214414.20905-7-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-7-paul@crapouillou.net>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 14 Aug 2018 11:42:47 +0200
Message-ID: <CA+7wUsxKtiJZD35dvT7UrmWYXcDdpmRq3NVM25=dX=4qQ_ewuw@mail.gmail.com>
Subject: Re: [PATCH v6 06/24] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, thierry.reding@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 11:44 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> From: Maarten ter Huurne <maarten@treewalker.org>
>
> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>
> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
> JZ4780 have a 64-bit OST.
>
> This driver will register both a clocksource and a sched_clock to the
> system.

With CONFIG_DEBUG_SECTION_MISMATCH=y here is what I see:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.data+0x26600): Section mismatch in reference from
the variable ingenic_ost_driver to the function
.init.text:ingenic_ost_probe()
The variable ingenic_ost_driver references
the function __init ingenic_ost_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: vmlinux.o(.data+0x26660): Section mismatch in reference from
the variable ingenic_tcu_driver to the function
.init.text:ingenic_tcu_probe()
The variable ingenic_tcu_driver references
the function __init ingenic_tcu_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Thanks

> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/clocksource/Kconfig       |   8 ++
>  drivers/clocksource/Makefile      |   1 +
>  drivers/clocksource/ingenic-ost.c | 208 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-ost.c
>
>  v5: New patch
>
>  v6: - Get rid of SoC IDs; pass pointer to ingenic_ost_soc_info as
>        devicetree match data instead.
>      - Use device_get_match_data() instead of the of_* variant
>      - Handle error of dev_get_regmap() properly
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 98f708208a8d..e855938c69f1 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -619,4 +619,12 @@ config INGENIC_TIMER
>         help
>           Support for the timer/counter unit of the Ingenic JZ SoCs.
>
> +config INGENIC_OST
> +       bool "Ingenic JZ47xx Operating System Timer"
> +       depends on MIPS || COMPILE_TEST
> +       depends on COMMON_CLK
> +       select INGENIC_TIMER
> +       help
> +         Support for the OS Timer of the Ingenic JZ4770 or similar SoC.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 26877505d400..56ce37252944 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_ASM9260_TIMER)           += asm9260_timer.o
>  obj-$(CONFIG_H8300_TMR8)               += h8300_timer8.o
>  obj-$(CONFIG_H8300_TMR16)              += h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)                        += h8300_tpu.o
> +obj-$(CONFIG_INGENIC_OST)              += ingenic-ost.o
>  obj-$(CONFIG_INGENIC_TIMER)            += ingenic-timer.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)            += clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)             += numachip.o
> diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
> new file mode 100644
> index 000000000000..400d30656790
> --- /dev/null
> +++ b/drivers/clocksource/ingenic-ost.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ47xx SoCs TCU Operating System Timer driver
> + *
> + * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
> + * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clocksource.h>
> +#include <linux/mfd/ingenic-tcu.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +
> +#include "ingenic-timer.h"
> +
> +#define TCU_OST_TCSR_MASK      0xc0
> +#define TCU_OST_TCSR_CNT_MD    BIT(15)
> +
> +#define TCU_OST_CHANNEL                15
> +
> +struct ingenic_ost_soc_info {
> +       bool is64bit;
> +};
> +
> +struct ingenic_ost {
> +       struct regmap *map;
> +       struct clk *clk;
> +
> +       struct clocksource cs;
> +};
> +
> +static u64 notrace ingenic_ost_read_cntl(void)
> +{
> +       /* Bypass the regmap here as we must return as soon as possible */
> +       return readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
> +}
> +
> +static u64 notrace ingenic_ost_read_cnth(void)
> +{
> +       /* Bypass the regmap here as we must return as soon as possible */
> +       return readl(ingenic_tcu_base + TCU_REG_OST_CNTH);
> +}
> +
> +static u64 notrace ingenic_ost_clocksource_read(struct clocksource *cs)
> +{
> +       u32 val1, val2;
> +       u64 count, recount;
> +       s64 diff;
> +
> +       /*
> +        * The buffering of the upper 32 bits of the timer prevents wrong
> +        * results from the bottom 32 bits overflowing due to the timer ticking
> +        * along. However, it does not prevent wrong results from simultaneous
> +        * reads of the timer, which could reset the buffer mid-read.
> +        * Since this kind of wrong read can happen only when the bottom bits
> +        * overflow, there will be minutes between wrong reads, so if we read
> +        * twice in succession, at least one of the reads will be correct.
> +        */
> +
> +       /* Bypass the regmap here as we must return as soon as possible */
> +       val1 = readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
> +       val2 = readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
> +       count = (u64)val1 | (u64)val2 << 32;
> +
> +       val1 = readl(ingenic_tcu_base + TCU_REG_OST_CNTL);
> +       val2 = readl(ingenic_tcu_base + TCU_REG_OST_CNTHBUF);
> +       recount = (u64)val1 | (u64)val2 << 32;
> +
> +       /*
> +        * A wrong read will produce a result that is 1<<32 too high: the bottom
> +        * part from before overflow and the upper part from after overflow.
> +        * Therefore, the lower value of the two reads is the correct value.
> +        */
> +
> +       diff = (s64)(recount - count);
> +       if (unlikely(diff < 0))
> +               count = recount;
> +
> +       return count;
> +}
> +
> +static int __init ingenic_ost_probe(struct platform_device *pdev)
> +{
> +       const struct ingenic_ost_soc_info *soc_info;
> +       struct device *dev = &pdev->dev;
> +       struct ingenic_ost *ost;
> +       struct clocksource *cs;
> +       unsigned long rate, flags;
> +       int err;
> +
> +       soc_info = device_get_match_data(dev);
> +       if (!soc_info)
> +               return -EINVAL;
> +
> +       ost = devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
> +       if (!ost)
> +               return -ENOMEM;
> +
> +       ost->map = dev_get_regmap(dev->parent, NULL);
> +       if (!ost->map) {
> +               dev_err(dev, "regmap not found\n");
> +               return -EINVAL;
> +       }
> +
> +       ost->clk = devm_clk_get(dev, "ost");
> +       if (IS_ERR(ost->clk))
> +               return PTR_ERR(ost->clk);
> +
> +       err = clk_prepare_enable(ost->clk);
> +       if (err)
> +               return err;
> +
> +       /* Clear counter high/low registers */
> +       if (soc_info->is64bit)
> +               regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
> +       regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
> +
> +       /* Don't reset counter at compare value. */
> +       regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
> +                          TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
> +
> +       rate = clk_get_rate(ost->clk);
> +
> +       /* Enable OST TCU channel */
> +       regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
> +
> +       cs = &ost->cs;
> +       cs->name        = "ingenic-ost";
> +       cs->rating      = 320;
> +       cs->flags       = CLOCK_SOURCE_IS_CONTINUOUS;
> +
> +       if (soc_info->is64bit) {
> +               cs->mask = CLOCKSOURCE_MASK(64);
> +               cs->read = ingenic_ost_clocksource_read;
> +       } else {
> +               cs->mask = CLOCKSOURCE_MASK(32);
> +               cs->read = (u64 (*)(struct clocksource *))ingenic_ost_read_cnth;
> +       }
> +
> +       err = clocksource_register_hz(cs, rate);
> +       if (err) {
> +               dev_err(dev, "clocksource registration failed: %d\n", err);
> +               clk_disable_unprepare(ost->clk);
> +               return err;
> +       }
> +
> +       /* Cannot register a sched_clock with interrupts on */
> +       local_irq_save(flags);
> +       if (soc_info->is64bit)
> +               sched_clock_register(ingenic_ost_read_cntl, 32, rate);
> +       else
> +               sched_clock_register(ingenic_ost_read_cnth, 32, rate);
> +       local_irq_restore(flags);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ingenic_ost_suspend(struct device *dev)
> +{
> +       struct ingenic_ost *ost = dev_get_drvdata(dev);
> +
> +       clk_disable(ost->clk);
> +       return 0;
> +}
> +
> +static int ingenic_ost_resume(struct device *dev)
> +{
> +       struct ingenic_ost *ost = dev_get_drvdata(dev);
> +
> +       return clk_enable(ost->clk);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ingenic_ost_pm_ops, ingenic_ost_suspend,
> +                        ingenic_ost_resume);
> +#define INGENIC_OST_PM_OPS (&ingenic_ost_pm_ops)
> +#else
> +#define INGENIC_OST_PM_OPS NULL
> +#endif /* CONFIG_PM_SUSPEND */
> +
> +static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
> +       .is64bit = false,
> +};
> +
> +static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
> +       .is64bit = true,
> +};
> +
> +static const struct of_device_id ingenic_ost_of_match[] = {
> +       { .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
> +       { .compatible = "ingenic,jz4770-ost",  .data = &jz4770_ost_soc_info,  },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_ost_of_match);
> +
> +static struct platform_driver ingenic_ost_driver = {
> +       .probe = ingenic_ost_probe,
> +       .driver = {
> +               .name   = "ingenic-ost",
> +               .pm     = INGENIC_OST_PM_OPS,
> +               .of_match_table = ingenic_ost_of_match,
> +       },
> +};
> +module_platform_driver(ingenic_ost_driver);
> --
> 2.11.0
>
