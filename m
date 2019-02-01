Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14753C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB613218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y89YoBna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfBANGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:06:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35412 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfBANGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:06:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so2939538pgs.2;
        Fri, 01 Feb 2019 05:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytL90GhxLiVSFr3aLPAzoEJT75qeoIR43P1lQ5wSvO8=;
        b=Y89YoBnabmDcl8RUD7S9nQvRsu+otaUdqUJprRZyj2dgaOh7PDQQm9ki42QjJ0fCwz
         7/un3q0k78H6ecWu5tDra9i3QhmxVHYj5//LKHoYyvK0lFTzVpeoBMEECusDdAhlPOJj
         BYuK83OCQAexApVZCtAOCLXol9mmlbRTfdWxLf5XOhN/K4xp0KlPfhIvCKTWv0uUgFVj
         1mFPFZP/Yeyybaalhg/jsMYVZ3VsBga8CpVltYc1tMc/bWYL0ne2b9icqEQjgw01fTC9
         cFMidKgqBZmVDZdyRONN3bdLoJNb0kMHh+HNKeIrtqlNJNjblI770pVAXmkAh2rSzzbz
         yIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytL90GhxLiVSFr3aLPAzoEJT75qeoIR43P1lQ5wSvO8=;
        b=TokNhTgSO2Cdlju1BD5ozRkEp51mmItUif0nbr10uk+S3CglQfZ+IL3vi3y+wi3jRH
         Jzz+dNwA7n5azu+fGCQa+/yQCwBr6RzbYXoRtNgObjUtGBZPTL8JkmcYs6TjhEKoffAR
         A/CVy0KT2DVYGuN61laiIjx4ppEMnb3vRTL4S6EOMlGltZHuNTPBBQYrwa24j7xBAS4y
         nSwItCafNxmvoYsMiIky34QAF0J1cjSWATGQrlMaLfis9u2lSvzGthootpraEEcZTK5b
         3tVe9y4uW+4gfruHljxdrqg0pzQaU1w0p/VV35Ms34GnNQTH4ZNF42RoxhIHeBuEsCL8
         1KWw==
X-Gm-Message-State: AHQUAuaOJIVUv7G4N/gnP4Hc2gctGXNXn7WArKTVMn4GraYBW6eNLTte
        o+ZyAwoKZeQTLKHboaRsZhE=
X-Google-Smtp-Source: AHgI3Ibl4WCW0bHIx2edlas5TZ0LpWj2gCxT3hXt2ffZvKziGEvDqekuIO4FrvMyHZjtz5oR6fFMRA==
X-Received: by 2002:a63:304:: with SMTP id 4mr2035144pgd.99.1549026388701;
        Fri, 01 Feb 2019 05:06:28 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id u68sm9376891pfj.180.2019.02.01.05.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 05:06:27 -0800 (PST)
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To:     Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9370a0e4-2c76-6e9e-9219-121f92cdb14a@gmail.com>
Date:   Fri, 1 Feb 2019 16:06:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201033621.16814-3-josephl@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 6:36, Joseph Lo пишет:
> Add support for the Tegra210 timer that runs at oscillator clock
> (TMR10-TMR13). We need these timers to work as clock event device and to
> replace the ARMv8 architected timer due to it can't survive across the
> power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
> source when CPU suspends in power down state.
> 
> Also convert the original driver to use timer-of API.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> v5:
>  * add ack tag from Thierry
> v4:
>  * merge timer-tegra210.c in previous version into timer-tegra20.c
> v3:
>  * use timer-of API
> v2:
>  * add error clean-up code
> ---
>  drivers/clocksource/Kconfig         |   2 +-
>  drivers/clocksource/timer-tegra20.c | 369 ++++++++++++++++++++--------
>  include/linux/cpuhotplug.h          |   1 +
>  3 files changed, 272 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..6af78534a285 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -131,7 +131,7 @@ config SUN5I_HSTIMER
>  config TEGRA_TIMER
>  	bool "Tegra timer driver" if COMPILE_TEST
>  	select CLKSRC_MMIO
> -	depends on ARM
> +	select TIMER_OF
>  	help
>  	  Enables support for the Tegra driver.
>  
> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
> index 4293943f4e2b..96a809341c9b 100644
> --- a/drivers/clocksource/timer-tegra20.c
> +++ b/drivers/clocksource/timer-tegra20.c
> @@ -15,21 +15,24 @@
>   *
>   */
>  
> -#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/time.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/clockchips.h>
> -#include <linux/clocksource.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/sched_clock.h>
> -#include <linux/delay.h>
> +#include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
> +#include <linux/time.h>
> +
> +#include "timer-of.h"
>  
> +#ifdef CONFIG_ARM
>  #include <asm/mach/time.h>
> +#endif
>  
>  #define RTC_SECONDS            0x08
>  #define RTC_SHADOW_SECONDS     0x0c
> @@ -43,70 +46,147 @@
>  #define TIMER2_BASE 0x8
>  #define TIMER3_BASE 0x50
>  #define TIMER4_BASE 0x58
> -
> -#define TIMER_PTV 0x0
> -#define TIMER_PCR 0x4
> -
> +#define TIMER10_BASE 0x90
> +
> +#define TIMER_PTV		0x0
> +#define TIMER_PTV_EN		BIT(31)
> +#define TIMER_PTV_PER		BIT(30)
> +#define TIMER_PCR		0x4
> +#define TIMER_PCR_INTR_CLR	BIT(30)
> +
> +#ifdef CONFIG_ARM
> +#define TIMER_BASE TIMER3_BASE
> +#else
> +#define TIMER_BASE TIMER10_BASE
> +#endif
> +#define TIMER10_IRQ_IDX		10
> +#define TIMER_FOR_CPU(cpu) (TIMER_BASE + (cpu) * 8)
> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
> +
> +static u32 usec_config;
>  static void __iomem *timer_reg_base;
> +#ifdef CONFIG_ARM
>  static void __iomem *rtc_base;
> -
>  static struct timespec64 persistent_ts;
>  static u64 persistent_ms, last_persistent_ms;
> -
>  static struct delay_timer tegra_delay_timer;
> -
> -#define timer_writel(value, reg) \
> -	writel_relaxed(value, timer_reg_base + (reg))
> -#define timer_readl(reg) \
> -	readl_relaxed(timer_reg_base + (reg))
> +#endif
>  
>  static int tegra_timer_set_next_event(unsigned long cycles,
>  					 struct clock_event_device *evt)
>  {
> -	u32 reg;
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>  
> -	reg = 0x80000000 | ((cycles > 1) ? (cycles-1) : 0);
> -	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
> +	writel(TIMER_PTV_EN |
> +	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
> +	       reg_base + TIMER_PTV);
>  
>  	return 0;
>  }
>  
> -static inline void timer_shutdown(struct clock_event_device *evt)
> +static int tegra_timer_shutdown(struct clock_event_device *evt)
>  {
> -	timer_writel(0, TIMER3_BASE + TIMER_PTV);
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(0, reg_base + TIMER_PTV);
> +
> +	return 0;
>  }
>  
> -static int tegra_timer_shutdown(struct clock_event_device *evt)
> +static int tegra_timer_set_periodic(struct clock_event_device *evt)
>  {
> -	timer_shutdown(evt);
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(TIMER_PTV_EN | TIMER_PTV_PER |
> +	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
> +	       reg_base + TIMER_PTV);
> +
>  	return 0;
>  }
>  
> -static int tegra_timer_set_periodic(struct clock_event_device *evt)
> +static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
>  {
> -	u32 reg = 0xC0000000 | ((1000000 / HZ) - 1);
> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_ARM64
> +static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
> +	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
> +
> +	.clkevt = {
> +		.name = "tegra_timer",
> +		.rating = 460,
> +		.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +		.set_next_event = tegra_timer_set_next_event,
> +		.set_state_shutdown = tegra_timer_shutdown,
> +		.set_state_periodic = tegra_timer_set_periodic,
> +		.set_state_oneshot = tegra_timer_shutdown,
> +		.tick_resume = tegra_timer_shutdown,
> +	},
> +};
> +
> +static int tegra_timer_setup(unsigned int cpu)
> +{
> +	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
> +
> +	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
> +	enable_irq(to->clkevt.irq);
> +
> +	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
> +					1, /* min */
> +					0x1fffffff); /* 29 bits */
>  
> -	timer_shutdown(evt);
> -	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
>  	return 0;
>  }
>  
> -static struct clock_event_device tegra_clockevent = {
> -	.name			= "timer0",
> -	.rating			= 300,
> -	.features		= CLOCK_EVT_FEAT_ONESHOT |
> -				  CLOCK_EVT_FEAT_PERIODIC |
> -				  CLOCK_EVT_FEAT_DYNIRQ,
> -	.set_next_event		= tegra_timer_set_next_event,
> -	.set_state_shutdown	= tegra_timer_shutdown,
> -	.set_state_periodic	= tegra_timer_set_periodic,
> -	.set_state_oneshot	= tegra_timer_shutdown,
> -	.tick_resume		= tegra_timer_shutdown,
> +static int tegra_timer_stop(unsigned int cpu)
> +{
> +	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
> +
> +	to->clkevt.set_state_shutdown(&to->clkevt);
> +	disable_irq_nosync(to->clkevt.irq);
> +
> +	return 0;
> +}
> +#else /* CONFIG_ARM */
> +static struct timer_of tegra_to = {
> +	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_OF_IRQ,
> +
> +	.clkevt = {
> +		.name = "tegra_timer",
> +		.rating	= 300,
> +		.features = CLOCK_EVT_FEAT_ONESHOT |
> +			    CLOCK_EVT_FEAT_PERIODIC |
> +			    CLOCK_EVT_FEAT_DYNIRQ,
> +		.set_next_event	= tegra_timer_set_next_event,
> +		.set_state_shutdown = tegra_timer_shutdown,
> +		.set_state_periodic = tegra_timer_set_periodic,
> +		.set_state_oneshot = tegra_timer_shutdown,
> +		.tick_resume = tegra_timer_shutdown,
> +		.cpumask = cpu_possible_mask,
> +	},
> +
> +	.of_irq = {
> +		.index = 2,
> +		.flags = IRQF_TIMER | IRQF_TRIGGER_HIGH,
> +		.handler = tegra_timer_isr,
> +	},
>  };
>  
>  static u64 notrace tegra_read_sched_clock(void)
>  {
> -	return timer_readl(TIMERUS_CNTR_1US);
> +	return readl(timer_reg_base + TIMERUS_CNTR_1US);
> +}
> +
> +static unsigned long tegra_delay_timer_read_counter_long(void)
> +{
> +	return readl(timer_reg_base + TIMERUS_CNTR_1US);
>  }
>  
>  /*
> @@ -143,98 +223,188 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
>  	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
>  	*ts = persistent_ts;
>  }
> +#endif
>  
> -static unsigned long tegra_delay_timer_read_counter_long(void)
> +static int tegra_timer_suspend(void)
>  {
> -	return readl(timer_reg_base + TIMERUS_CNTR_1US);
> +#ifdef CONFIG_ARM64
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
> +		void __iomem *reg_base = timer_of_base(to);
> +
> +		writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
> +	}
> +#else
> +	void __iomem *reg_base = timer_of_base(&tegra_to);
> +
> +	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
> +#endif
> +
> +	return 0;
>  }
>  
> -static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
> +static void tegra_timer_resume(void)
>  {
> -	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> -	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
> -	evt->event_handler(evt);
> -	return IRQ_HANDLED;
> +	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
>  }
>  
> -static struct irqaction tegra_timer_irq = {
> -	.name		= "timer0",
> -	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
> -	.handler	= tegra_timer_interrupt,
> -	.dev_id		= &tegra_clockevent,
> +static struct syscore_ops tegra_timer_syscore_ops = {
> +	.suspend = tegra_timer_suspend,
> +	.resume = tegra_timer_resume,
>  };
>  
> -static int __init tegra20_init_timer(struct device_node *np)
> +static int tegra_timer_init(struct device_node *np, struct timer_of *to)
>  {
> -	struct clk *clk;
> -	unsigned long rate;
> -	int ret;
> +	int ret = 0;
>  
> -	timer_reg_base = of_iomap(np, 0);
> -	if (!timer_reg_base) {
> -		pr_err("Can't map timer registers\n");
> -		return -ENXIO;
> -	}
> +	ret = timer_of_init(np, to);
> +	if (ret < 0)
> +		goto out;
>  
> -	tegra_timer_irq.irq = irq_of_parse_and_map(np, 2);
> -	if (tegra_timer_irq.irq <= 0) {
> -		pr_err("Failed to map timer IRQ\n");
> -		return -EINVAL;
> -	}
> +	timer_reg_base = timer_of_base(to);
>  
> -	clk = of_clk_get(np, 0);
> -	if (IS_ERR(clk)) {
> -		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
> -		rate = 12000000;
> -	} else {
> -		clk_prepare_enable(clk);
> -		rate = clk_get_rate(clk);
> -	}
> -
> -	switch (rate) {
> +	/*
> +	 * Configure microsecond timers to have 1MHz clock
> +	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
> +	 * Uses n+1 scheme
> +	 */
> +	switch (timer_of_rate(to)) {
>  	case 12000000:
> -		timer_writel(0x000b, TIMERUS_USEC_CFG);
> +		usec_config = 0x000b; /* (11+1)/(0+1) */
> +		break;
> +	case 12800000:
> +		usec_config = 0x043f; /* (63+1)/(4+1) */
>  		break;
>  	case 13000000:
> -		timer_writel(0x000c, TIMERUS_USEC_CFG);
> +		usec_config = 0x000c; /* (12+1)/(0+1) */
> +		break;
> +	case 16800000:
> +		usec_config = 0x0453; /* (83+1)/(4+1) */
>  		break;
>  	case 19200000:
> -		timer_writel(0x045f, TIMERUS_USEC_CFG);
> +		usec_config = 0x045f; /* (95+1)/(4+1) */
>  		break;
>  	case 26000000:
> -		timer_writel(0x0019, TIMERUS_USEC_CFG);
> +		usec_config = 0x0019; /* (25+1)/(0+1) */
> +		break;
> +	case 38400000:
> +		usec_config = 0x04bf; /* (191+1)/(4+1) */
> +		break;
> +	case 48000000:
> +		usec_config = 0x002f; /* (47+1)/(0+1) */
>  		break;
>  	default:
> -		WARN(1, "Unknown clock rate");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
> +
> +	register_syscore_ops(&tegra_timer_syscore_ops);
> +out:
> +	return ret;
> +}
> +
> +#ifdef CONFIG_ARM64
> +static int __init tegra210_timer_init(struct device_node *np)
> +{
> +	int cpu, ret = 0;
> +	struct timer_of *to;
> +
> +	to = this_cpu_ptr(&tegra_to);
> +	ret = tegra_timer_init(np, to);
> +	if (ret < 0)
> +		goto out;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct timer_of *cpu_to;
> +
> +		cpu_to = per_cpu_ptr(&tegra_to, cpu);
> +		cpu_to->of_base.base = timer_reg_base + TIMER_FOR_CPU(cpu);
> +		cpu_to->of_clk.rate = timer_of_rate(to);
> +		cpu_to->clkevt.cpumask = cpumask_of(cpu);
> +
> +		cpu_to->clkevt.irq =
> +			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
> +		if (!cpu_to->clkevt.irq) {
> +			pr_err("%s: can't map IRQ for CPU%d\n",
> +			       __func__, cpu);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
> +		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
> +				  IRQF_TIMER | IRQF_NOBALANCING,
> +				  cpu_to->clkevt.name, &cpu_to->clkevt);
> +		if (ret) {
> +			pr_err("%s: cannot setup irq %d for CPU%d\n",
> +				__func__, cpu_to->clkevt.irq, cpu);
> +			ret = -EINVAL;
> +			goto out_irq;
> +		}
> +	}
> +
> +	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
> +			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
> +			  tegra_timer_stop);
> +
> +	return ret;
> +
> +out_irq:
> +	for_each_possible_cpu(cpu) {
> +		struct timer_of *cpu_to;
> +
> +		cpu_to = per_cpu_ptr(&tegra_to, cpu);
> +		if (cpu_to->clkevt.irq) {
> +			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
> +			irq_dispose_mapping(cpu_to->clkevt.irq);
> +		}
>  	}
> +out:
> +	timer_of_cleanup(to);
> +	return ret;
> +}
> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_timer_init);
> +#else /* CONFIG_ARM */
> +static int __init tegra20_init_timer(struct device_node *np)
> +{
What about T132? Isn't it ARM64 which uses tegra20-timer IP? At least T132 DT suggests so and seems this change will break it.

[snip]
