Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2985C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC3720831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCswJv9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC3720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeKTCsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbeKTCsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:48:31 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA4020831;
        Mon, 19 Nov 2018 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542644664;
        bh=mp3NNNwXLBStJAvbXqmW1PSCrkeaPhfzhqj88V80esc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCswJv9kZSwsyb4sGsYsQqZ2igdBpQtbRKuSlU0FzZ2gmu7386cJiRJRXBX3N4VxF
         dsxsnQwL2gTnGcYfOdOr0fczdu1Sfskhk6h+jd43ZcpWXWeJfeMN/FgwQQ3C8LCfad
         47KQt4m4SqzpRZJrJd/46KlH8P3PbCpYVl6h45Xk=
Received: by mail-qk1-f176.google.com with SMTP id n12so49478744qkh.11;
        Mon, 19 Nov 2018 08:24:24 -0800 (PST)
X-Gm-Message-State: AGRZ1gJoTqKgHjx8T4FcDUv5IajcVjS5smHde5OGTCdcIOCy8DYNstnW
        rCRl8TqodP6qipzdgIXgY+Dr6ZbiYWv/07X2GQ==
X-Google-Smtp-Source: AJdET5eRPNcWNPsl8R5Y6YY/w3F5x45ATrqSNyywNbBds53oOsZzOCxp0BAbi6XsFYvIGhsAYJXoCCnivvmLyxEDN/o=
X-Received: by 2002:ac8:2d35:: with SMTP id n50mr20814051qta.38.1542644663823;
 Mon, 19 Nov 2018 08:24:23 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com> <1542589274-13878-2-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1542589274-13878-2-git-send-email-sugaya.taichi@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Nov 2018 10:24:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJotYwwC490XmCtn_=-mrosxG3UUCy0P_SVO3d94yW6VA@mail.gmail.com>
Message-ID: <CAL_JsqJotYwwC490XmCtn_=-mrosxG3UUCy0P_SVO3d94yW6VA@mail.gmail.com>
Subject: Re: [PATCH 01/14] ARM: milbeaut: Add basic support for Milbeaut m10v SoC
To:     sugaya.taichi@socionext.com
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 7:00 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds the basic M10V SoC support under arch/arm.
> Since all cores are activated in the custom bootloader before booting
> linux, it is necessary to wait for sub-cores using the trampoline area.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  arch/arm/Kconfig                  |   2 +
>  arch/arm/Makefile                 |   1 +
>  arch/arm/mach-milbeaut/Kconfig    |  28 +++++++
>  arch/arm/mach-milbeaut/Makefile   |   3 +
>  arch/arm/mach-milbeaut/m10v_evb.c |  31 ++++++++
>  arch/arm/mach-milbeaut/platsmp.c  | 157 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 222 insertions(+)
>  create mode 100644 arch/arm/mach-milbeaut/Kconfig
>  create mode 100644 arch/arm/mach-milbeaut/Makefile
>  create mode 100644 arch/arm/mach-milbeaut/m10v_evb.c
>  create mode 100644 arch/arm/mach-milbeaut/platsmp.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 91be74d..0b8a1af 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -767,6 +767,8 @@ source "arch/arm/mach-mediatek/Kconfig"
>
>  source "arch/arm/mach-meson/Kconfig"
>
> +source "arch/arm/mach-milbeaut/Kconfig"
> +
>  source "arch/arm/mach-mmp/Kconfig"
>
>  source "arch/arm/mach-moxart/Kconfig"
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 05a91d8..627853c 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -190,6 +190,7 @@ machine-$(CONFIG_ARCH_MV78XX0)              += mv78xx0
>  machine-$(CONFIG_ARCH_MVEBU)           += mvebu
>  machine-$(CONFIG_ARCH_MXC)             += imx
>  machine-$(CONFIG_ARCH_MEDIATEK)                += mediatek
> +machine-$(CONFIG_ARCH_MILBEAUT)                += milbeaut
>  machine-$(CONFIG_ARCH_MXS)             += mxs
>  machine-$(CONFIG_ARCH_NETX)            += netx
>  machine-$(CONFIG_ARCH_NOMADIK)         += nomadik
> diff --git a/arch/arm/mach-milbeaut/Kconfig b/arch/arm/mach-milbeaut/Kconfig
> new file mode 100644
> index 0000000..63b6f69
> --- /dev/null
> +++ b/arch/arm/mach-milbeaut/Kconfig
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menuconfig ARCH_MILBEAUT
> +       bool "Socionext Milbeaut SoCs"
> +       depends on ARCH_MULTI_V7
> +       select ARM_GIC

> +       select CLKDEV_LOOKUP
> +       select GENERIC_CLOCKEVENTS
> +       select CLKSRC_MMIO

The clock and timer drivers' kconfig entries should select these.

> +       select ZONE_DMA

Why is this needed?

> +       help
> +               This enables support for Socionext Milbeaut SoCs
> +
> +if ARCH_MILBEAUT
> +
> +config ARCH_MILBEAUT_M10V
> +       bool "Milbeaut SC2000/M10V platform"
> +       select ARM_ARCH_TIMER
> +       select M10V_TIMER
> +       select PINCTRL
> +       select PINCTRL_M10V
> +       help
> +         Support for Socionext's MILBEAUT M10V based systems
> +
> +config MACH_M10V_EVB
> +       bool "Support for Milbeaut Evaluation boards"

You shouldn't need a kconfig entry for each board.

> +       default y
> +
> +endif
> diff --git a/arch/arm/mach-milbeaut/Makefile b/arch/arm/mach-milbeaut/Makefile
> new file mode 100644
> index 0000000..64f6f52
> --- /dev/null
> +++ b/arch/arm/mach-milbeaut/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_SMP) += platsmp.o
> +obj-$(CONFIG_MACH_M10V_EVB) += m10v_evb.o
> +
> diff --git a/arch/arm/mach-milbeaut/m10v_evb.c b/arch/arm/mach-milbeaut/m10v_evb.c
> new file mode 100644
> index 0000000..a1fa7c3
> --- /dev/null
> +++ b/arch/arm/mach-milbeaut/m10v_evb.c

This all looks SoC specific, not board specific.

> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Socionext Inc.
> + * Copyright:   (C) 2015 Linaro Ltd.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/platform_device.h>

Not needed.

> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +static struct map_desc m10v_io_desc[] __initdata = {
> +};
> +
> +void __init m10v_map_io(void)
> +{
> +       debug_ll_io_init();

If you use earlycon instead, then this isn't needed.

> +       iotable_init(m10v_io_desc, ARRAY_SIZE(m10v_io_desc));

This isn't needed.

> +}
> +
> +static const char * const m10v_compat[] = {
> +       "socionext,milbeaut-m10v-evb",
> +       NULL,
> +};
> +
> +DT_MACHINE_START(M10V_REB, "Socionext Milbeaut")
> +       .dt_compat      = m10v_compat,
> +       .l2c_aux_mask   = 0xffffffff,
> +       .map_io         = m10v_map_io,

It looks like you can remove this entire file and use the default machine desc.

> +MACHINE_END
> diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
> new file mode 100644
> index 0000000..b706851
> --- /dev/null
> +++ b/arch/arm/mach-milbeaut/platsmp.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Socionext Inc.
> + * Copyright:  (C) 2015 Linaro Ltd.
> + */
> +
> +#include <linux/cpu_pm.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include <linux/of_device.h>

Not needed.

> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>

Not needed.

> +#include <linux/suspend.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/cp15.h>
> +#include <asm/idmap.h>
> +#include <asm/smp_plat.h>
> +#include <asm/suspend.h>
> +
> +#define M10V_MAX_CPU   4
> +
> +#define KERNEL_UNBOOT_FLAG     0x12345678
> +#define CPU_FINISH_SUSPEND_FLAG 0x56784321
> +
> +static void __iomem *trampoline;
> +
> +static int m10v_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
> +{
> +       unsigned int mpidr, cpu, cluster;
> +
> +       mpidr = cpu_logical_map(l_cpu);
> +       cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +       cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +       if (cpu >= M10V_MAX_CPU)
> +               return -EINVAL;
> +
> +       pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> +
> +       writel(virt_to_phys(secondary_startup), trampoline + cpu * 4);
> +       arch_send_wakeup_ipi_mask(cpumask_of(l_cpu));
> +
> +       return 0;
> +}
> +
> +static void m10v_cpu_die(unsigned int l_cpu)
> +{
> +       gic_cpu_if_down(0);
> +
> +       v7_exit_coherency_flush(louis);
> +
> +       /* Now we are prepared for power-down, do it: */
> +       wfi();
> +}
> +
> +static int m10v_cpu_kill(unsigned int l_cpu)
> +{
> +       unsigned int mpidr, cpu;
> +
> +       mpidr = cpu_logical_map(l_cpu);
> +       cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +
> +       writel(KERNEL_UNBOOT_FLAG, trampoline + cpu * 4);
> +
> +       return 1;
> +}
> +
> +static struct smp_operations m10v_smp_ops __initdata = {
> +       .smp_boot_secondary     = m10v_boot_secondary,
> +       .cpu_die                = m10v_cpu_die,
> +       .cpu_kill               = m10v_cpu_kill,
> +};
> +
> +static int __init m10v_smp_init(void)
> +{
> +       unsigned int mpidr, cpu, cluster;
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "socionext,milbeaut-m10v-evb");
> +       if (!np || !of_device_is_available(np))

Just use of_machine_is_compatible() here.

> +               return -ENODEV;
> +       of_node_put(np);
> +
> +       np = of_find_compatible_node(NULL, NULL, "socionext,smp-trampoline");
> +       if (!np)
> +               return -ENODEV;
> +
> +       trampoline = of_iomap(np, 0);
> +       if (!trampoline)
> +               return -ENODEV;
> +       of_node_put(np);
> +
> +       mpidr = read_cpuid_mpidr();
> +       cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +       cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +       pr_info("MCPM boot on cpu_%u cluster_%u\n", cpu, cluster);
> +
> +       for (cpu = 0; cpu < M10V_MAX_CPU; cpu++)
> +               writel(KERNEL_UNBOOT_FLAG, trampoline + cpu * 4);
> +
> +       smp_set_ops(&m10v_smp_ops);
> +
> +       return 0;
> +}
> +early_initcall(m10v_smp_init);
> +
> +static int m10v_pm_valid(suspend_state_t state)
> +{
> +       return (state == PM_SUSPEND_STANDBY) || (state == PM_SUSPEND_MEM);
> +}
> +
> +typedef void (*phys_reset_t)(unsigned long);
> +static phys_reset_t phys_reset;
> +
> +static int m10v_die(unsigned long arg)
> +{
> +       setup_mm_for_reboot();
> +       asm("wfi");
> +       /* Boot just like a secondary */
> +       phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
> +       phys_reset(virt_to_phys(cpu_resume));
> +
> +       return 0;
> +}
> +
> +static int m10v_pm_enter(suspend_state_t state)
> +{
> +       switch (state) {
> +       case PM_SUSPEND_STANDBY:
> +               pr_err("STANDBY\n");
> +               asm("wfi");
> +               break;
> +       case PM_SUSPEND_MEM:
> +               pr_err("SUSPEND\n");
> +               cpu_pm_enter();
> +               cpu_suspend(0, m10v_die);
> +               cpu_pm_exit();
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static const struct platform_suspend_ops m10v_pm_ops = {
> +       .valid          = m10v_pm_valid,
> +       .enter          = m10v_pm_enter,
> +};
> +
> +struct clk *m10v_clclk_register(struct device *cpu_dev);
> +
> +static int __init m10v_pm_init(void)
> +{
> +       suspend_set_ops(&m10v_pm_ops);
> +
> +       return 0;
> +}
> +late_initcall(m10v_pm_init);
> --
> 1.9.1
>
