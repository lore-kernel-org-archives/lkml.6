Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B1EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E18120869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GUvfApuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfBHNYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:24:06 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11467 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfBHNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:24:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5d82e10000>; Fri, 08 Feb 2019 05:23:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 05:24:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 08 Feb 2019 05:24:03 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 13:24:01 +0000
Subject: Re: [PATCH V6 2/7] clocksource: tegra: add Tegra210 timer support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201161654.18315-1-josephl@nvidia.com>
 <20190201161654.18315-3-josephl@nvidia.com>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <30d2a97c-c08f-f67c-706a-16288cf63dc8@nvidia.com>
Date:   Fri, 8 Feb 2019 21:23:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201161654.18315-3-josephl@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549632225; bh=KORBOLog4Y6nGh14WuilCHO9BegSxMv6lr9UapOZcRk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GUvfApuwKLt5Hs7ynmPK8svJN3gUgxhKIyNY8l/oqaoJwy0WEXqHsHo32TFX4a3Pd
         7MirifSZbh1KoVGinF5m6d+GI3c+8cyKK1D187j78LZw8wu65LHhtwCNr0KjADa2pW
         4Xwwf++TUhbu+vEZQD/v6mXmCnwUVSXZZJheS2hhee41zQdoDNBhvYayyfKkJHcoRm
         OLo4oBmWwsd5vgt/zkpJcPtFDmW4HKczQoXJH2YdijNcv6HFvXx+JlQ54qu8BJLHvj
         TekqfM6uJwf8MRTUF99j9u+g3SnMEIfCuv+bixp7weVccoX3gxOpXOaEDOWqDKsWLx
         2oYWEN1VRmJqw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel & Thomas,

Do we have the chance to get this patch merged for K5.1?

Thanks,
Joseph

On 2/2/19 12:16 AM, Joseph Lo wrote:
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
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> v6:
>   * refine the timer defines
>   * add ack tag from Jon.
> v5:
>   * add ack tag from Thierry
> v4:
>   * merge timer-tegra210.c in previous version into timer-tegra20.c
> v3:
>   * use timer-of API
> v2:
>   * add error clean-up code
> ---
>   drivers/clocksource/Kconfig         |   2 +-
>   drivers/clocksource/timer-tegra20.c | 371 ++++++++++++++++++++--------
>   include/linux/cpuhotplug.h          |   1 +
>   3 files changed, 270 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..6af78534a285 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -131,7 +131,7 @@ config SUN5I_HSTIMER
>   config TEGRA_TIMER
>   	bool "Tegra timer driver" if COMPILE_TEST
>   	select CLKSRC_MMIO
> -	depends on ARM
> +	select TIMER_OF
>   	help
>   	  Enables support for the Tegra driver.
>   
> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
> index 4293943f4e2b..f66edd63d7f4 100644
> --- a/drivers/clocksource/timer-tegra20.c
> +++ b/drivers/clocksource/timer-tegra20.c
> @@ -15,21 +15,24 @@
>    *
>    */
>   
> -#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
>   #include <linux/err.h>
> -#include <linux/time.h>
>   #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/clockchips.h>
> -#include <linux/clocksource.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
> -#include <linux/sched_clock.h>
> -#include <linux/delay.h>
> +#include <linux/percpu.h>
> +#include <linux/syscore_ops.h>
> +#include <linux/time.h>
> +
> +#include "timer-of.h"
>   
> +#ifdef CONFIG_ARM
>   #include <asm/mach/time.h>
> +#endif
>   
>   #define RTC_SECONDS            0x08
>   #define RTC_SHADOW_SECONDS     0x0c
> @@ -39,74 +42,145 @@
>   #define TIMERUS_USEC_CFG 0x14
>   #define TIMERUS_CNTR_FREEZE 0x4c
>   
> -#define TIMER1_BASE 0x0
> -#define TIMER2_BASE 0x8
> -#define TIMER3_BASE 0x50
> -#define TIMER4_BASE 0x58
> -
> -#define TIMER_PTV 0x0
> -#define TIMER_PCR 0x4
> -
> +#define TIMER_PTV		0x0
> +#define TIMER_PTV_EN		BIT(31)
> +#define TIMER_PTV_PER		BIT(30)
> +#define TIMER_PCR		0x4
> +#define TIMER_PCR_INTR_CLR	BIT(30)
> +
> +#ifdef CONFIG_ARM
> +#define TIMER_CPU0		0x50 /* TIMER3 */
> +#else
> +#define TIMER_CPU0		0x90 /* TIMER10 */
> +#define TIMER10_IRQ_IDX		10
> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
> +#endif
> +#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
> +
> +static u32 usec_config;
>   static void __iomem *timer_reg_base;
> +#ifdef CONFIG_ARM
>   static void __iomem *rtc_base;
> -
>   static struct timespec64 persistent_ts;
>   static u64 persistent_ms, last_persistent_ms;
> -
>   static struct delay_timer tegra_delay_timer;
> -
> -#define timer_writel(value, reg) \
> -	writel_relaxed(value, timer_reg_base + (reg))
> -#define timer_readl(reg) \
> -	readl_relaxed(timer_reg_base + (reg))
> +#endif
>   
>   static int tegra_timer_set_next_event(unsigned long cycles,
>   					 struct clock_event_device *evt)
>   {
> -	u32 reg;
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>   
> -	reg = 0x80000000 | ((cycles > 1) ? (cycles-1) : 0);
> -	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
> +	writel(TIMER_PTV_EN |
> +	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
> +	       reg_base + TIMER_PTV);
>   
>   	return 0;
>   }
>   
> -static inline void timer_shutdown(struct clock_event_device *evt)
> +static int tegra_timer_shutdown(struct clock_event_device *evt)
>   {
> -	timer_writel(0, TIMER3_BASE + TIMER_PTV);
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(0, reg_base + TIMER_PTV);
> +
> +	return 0;
>   }
>   
> -static int tegra_timer_shutdown(struct clock_event_device *evt)
> +static int tegra_timer_set_periodic(struct clock_event_device *evt)
>   {
> -	timer_shutdown(evt);
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(TIMER_PTV_EN | TIMER_PTV_PER |
> +	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
> +	       reg_base + TIMER_PTV);
> +
>   	return 0;
>   }
>   
> -static int tegra_timer_set_periodic(struct clock_event_device *evt)
> +static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
>   {
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
>   	return 0;
>   }
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
>   };
>   
>   static u64 notrace tegra_read_sched_clock(void)
>   {
> -	return timer_readl(TIMERUS_CNTR_1US);
> +	return readl(timer_reg_base + TIMERUS_CNTR_1US);
> +}
> +
> +static unsigned long tegra_delay_timer_read_counter_long(void)
> +{
> +	return readl(timer_reg_base + TIMERUS_CNTR_1US);
>   }
>   
>   /*
> @@ -143,98 +217,188 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
>   	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
>   	*ts = persistent_ts;
>   }
> +#endif
>   
> -static unsigned long tegra_delay_timer_read_counter_long(void)
> +static int tegra_timer_suspend(void)
>   {
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
>   }
>   
> -static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
> +static void tegra_timer_resume(void)
>   {
> -	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> -	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
> -	evt->event_handler(evt);
> -	return IRQ_HANDLED;
> +	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
>   }
>   
> -static struct irqaction tegra_timer_irq = {
> -	.name		= "timer0",
> -	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
> -	.handler	= tegra_timer_interrupt,
> -	.dev_id		= &tegra_clockevent,
> +static struct syscore_ops tegra_timer_syscore_ops = {
> +	.suspend = tegra_timer_suspend,
> +	.resume = tegra_timer_resume,
>   };
>   
> -static int __init tegra20_init_timer(struct device_node *np)
> +static int tegra_timer_init(struct device_node *np, struct timer_of *to)
>   {
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
>   	case 12000000:
> -		timer_writel(0x000b, TIMERUS_USEC_CFG);
> +		usec_config = 0x000b; /* (11+1)/(0+1) */
> +		break;
> +	case 12800000:
> +		usec_config = 0x043f; /* (63+1)/(4+1) */
>   		break;
>   	case 13000000:
> -		timer_writel(0x000c, TIMERUS_USEC_CFG);
> +		usec_config = 0x000c; /* (12+1)/(0+1) */
> +		break;
> +	case 16800000:
> +		usec_config = 0x0453; /* (83+1)/(4+1) */
>   		break;
>   	case 19200000:
> -		timer_writel(0x045f, TIMERUS_USEC_CFG);
> +		usec_config = 0x045f; /* (95+1)/(4+1) */
>   		break;
>   	case 26000000:
> -		timer_writel(0x0019, TIMERUS_USEC_CFG);
> +		usec_config = 0x0019; /* (25+1)/(0+1) */
> +		break;
> +	case 38400000:
> +		usec_config = 0x04bf; /* (191+1)/(4+1) */
> +		break;
> +	case 48000000:
> +		usec_config = 0x002f; /* (47+1)/(0+1) */
>   		break;
>   	default:
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
> +		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
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
>   	}
> +out:
> +	timer_of_cleanup(to);
> +	return ret;
> +}
> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra210_timer_init);
> +#else /* CONFIG_ARM */
> +static int __init tegra20_init_timer(struct device_node *np)
> +{
> +	int ret = 0;
> +
> +	ret = tegra_timer_init(np, &tegra_to);
> +	if (ret < 0)
> +		goto out;
>   
> -	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
> +	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
> +	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
>   
> +	sched_clock_register(tegra_read_sched_clock, 32,
> +			     timer_of_rate(&tegra_to));
>   	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
> -				    "timer_us", 1000000, 300, 32,
> -				    clocksource_mmio_readl_up);
> +				    "timer_us", timer_of_rate(&tegra_to),
> +				    300, 32, clocksource_mmio_readl_up);
>   	if (ret) {
>   		pr_err("Failed to register clocksource\n");
> -		return ret;
> +		goto out;
>   	}
>   
>   	tegra_delay_timer.read_current_timer =
>   			tegra_delay_timer_read_counter_long;
> -	tegra_delay_timer.freq = 1000000;
> +	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
>   	register_current_timer_delay(&tegra_delay_timer);
>   
> -	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
> -	if (ret) {
> -		pr_err("Failed to register timer IRQ: %d\n", ret);
> -		return ret;
> -	}
> +	clockevents_config_and_register(&tegra_to.clkevt,
> +					timer_of_rate(&tegra_to),
> +					0x1,
> +					0x1fffffff);
>   
> -	tegra_clockevent.cpumask = cpu_possible_mask;
> -	tegra_clockevent.irq = tegra_timer_irq.irq;
> -	clockevents_config_and_register(&tegra_clockevent, 1000000,
> -					0x1, 0x1fffffff);
> +	return ret;
> +out:
> +	timer_of_cleanup(&tegra_to);
>   
> -	return 0;
> +	return ret;
>   }
>   TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
>   
> @@ -261,3 +425,4 @@ static int __init tegra20_init_rtc(struct device_node *np)
>   	return register_persistent_clock(tegra_read_persistent_clock64);
>   }
>   TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
> +#endif
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index fd586d0301e7..e78281d07b70 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -121,6 +121,7 @@ enum cpuhp_state {
>   	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>   	CPUHP_AP_ARM_TWD_STARTING,
>   	CPUHP_AP_QCOM_TIMER_STARTING,
> +	CPUHP_AP_TEGRA_TIMER_STARTING,
>   	CPUHP_AP_ARMADA_TIMER_STARTING,
>   	CPUHP_AP_MARCO_TIMER_STARTING,
>   	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
> 
