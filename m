Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3493C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E9E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWEcJRMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfANPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:45:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51091 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfANPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:45:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so33840wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y9Ys6ztZaa/zQtDTu4cVrMcJG5x87JRpeoPqtXdA45k=;
        b=XWEcJRMtxd3J1Xexh18Jg8bHaeLwNmCE2NucRwszl1Pf3cqYju3uhJShuybsRtq81w
         C77SALssoBiHxxJxHnpqhXxHqe3gU0o5YktOo0/vSku3CgUyr2zlHmZL2QRfczpIEHr2
         G8jJowrtd+l9vVwdicIYBFnaCCeR4HRMyTm1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9Ys6ztZaa/zQtDTu4cVrMcJG5x87JRpeoPqtXdA45k=;
        b=CUIPMCWG5YehVMs+L7vGCAZzfEnl42SJXgd/oQDZtHDvpHPZtp/JvO5mDGfqO9A7+y
         wJ8oPyj/zNU3ApJiwSnQHwQ8iTrgpnpU+IxyXyQwfcRjLHUHfgD3FdyIY2RpZWr7lLT9
         5qN3Lk/Qb6BL/LFcq6OMoDgvQywqRrX/70W5AnffjD2NzIBEcbLQ8o4RoMFr5z75cPyS
         SoNJxUd1h0xE+yu1JnpWkoqv3kExFl3McOT1JAnNje0nZ3bUpe+g6lyQOpUXmwSjmuS4
         rh8nOQMAaHnqbX9dMzKdVGUtQiz9TfocmD4wAHUNrbFgrJoIaZjz+uR69VE//C5ekqwX
         4Dfg==
X-Gm-Message-State: AJcUukcpFb9Bl4Gm7PcLxI78qNyFhfqw2AIBkjCVMHg0iMAVq75Lft49
        NhjnOYgBev9K4zKomuQwBQKa4SffUR4=
X-Google-Smtp-Source: ALg8bN7B5gZIrRmSvXKPb8xv8yUUocX62JTdTCEhv6Et1GS2A2HxoZnYFGMffRltQkRcIJQL+IxAsA==
X-Received: by 2002:a1c:bc82:: with SMTP id m124mr12062376wmf.77.1547480721567;
        Mon, 14 Jan 2019 07:45:21 -0800 (PST)
Received: from [192.168.0.41] (193.45.88.92.rev.sfr.net. [92.88.45.193])
        by smtp.googlemail.com with ESMTPSA id l14sm153210884wrp.55.2019.01.14.07.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:45:20 -0800 (PST)
Subject: Re: [PATCH v2 2/2] driver: clocksource: Add nxp system counter timer
 driver support
To:     Jacky Bai <ping.bai@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
 <1544592770-19996-2-git-send-email-ping.bai@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d38cda5d-b78b-10de-2c19-be5fd869243a@linaro.org>
Date:   Mon, 14 Jan 2019 16:45:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544592770-19996-2-git-send-email-ping.bai@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 06:28, Jacky Bai wrote:
> The system counter (sys_ctr) is a programmable system counter
> which provides a shared time base to the Cortex A15, A7, A53 etc cores.
> It is intended for use in applications where the counter is always
> powered on and supports multiple, unrelated clocks. The sys_ctr hardware
> supports:
>  - 56-bit counter width (roll-over time greater than 40 years)
>  - compare frame(64-bit compare value) contains programmable interrupt
>    generation
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
> change v1->v2:
>  - no change 
> ---
>  drivers/clocksource/Kconfig            |   8 ++
>  drivers/clocksource/Makefile           |   1 +
>  drivers/clocksource/timer-imx-sysctr.c | 204 +++++++++++++++++++++++++++++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 drivers/clocksource/timer-imx-sysctr.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c57b156..7e5f2de 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -579,6 +579,14 @@ config CLKSRC_IMX_TPM
>  	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
>  	  clocksource.
>  
> +config CLKSRC_IMX_SYS_CTR

As the driver is a timer, please replace the CLKSRC by TIMER

> +	bool "Clocksource using i.MX system counter" if COMPILE_TEST
> +	depends on (ARM || ARM64) && CLKDEV_LOOKUP

CLKDEV_LOOKUP is not needed, it is selected with COMMON_CLK

> +	select CLKSRC_MMIO
> +	help
> +	  Enable this option to use IMX system counter timer as
> +	  clocksource.
> +
>  config CLKSRC_ST_LPC
>  	bool "Low power clocksource found in the LPC" if COMPILE_TEST
>  	select TIMER_OF if OF
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dd91381..372bf4e 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
>  obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
>  obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
>  obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
> +obj-$(CONFIG_CLKSRC_IMX_SYS_CTR)	+= timer-imx-sysctr.o
>  obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
>  obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
>  obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
> diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
> new file mode 100644
> index 0000000..ad3c27f
> --- /dev/null
> +++ b/drivers/clocksource/timer-imx-sysctr.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright 2017-2018 NXP
> +
> +#include <linux/interrupt.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/delay.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/sched_clock.h>
> +
> +#define CNTCV_LO	0x8
> +#define CNTCV_HI	0xc
> +#define CMPCV_LO	0x20
> +#define CMPCV_HI	0x24
> +#define CMPCR		0x2c
> +
> +#define SYS_CTR_EN		0x1
> +#define SYS_CTR_IRQ_MASK	0x2
> +
> +static void __iomem *sys_ctr_rd_base;
> +static void __iomem *sys_ctr_cmp_base;
> +static struct clock_event_device clockevent_sysctr;
> +
> +static inline void sysctr_timer_enable(bool enable)

Remove 'inline' tag

> +{
> +	u32 val;
> +
> +	val = readl(sys_ctr_cmp_base + CMPCR);
> +	val &= ~SYS_CTR_EN;
> +	if (enable)
> +		val |= SYS_CTR_EN;
> +
> +	writel(val, sys_ctr_cmp_base + CMPCR);
> +}
> +
> +static void sysctr_irq_acknowledge(void)
> +{
> +	u32 val;
> +
> +	/* clear th enable bit(EN=0) to clear the ISTAT */

What is the ISTAT?

Thanks for adding comments, however the format is:

/*
 *
 */

> +	val = readl(sys_ctr_cmp_base + CMPCR);
> +	val &= ~SYS_CTR_EN;
> +	writel(val, sys_ctr_cmp_base + CMPCR);

This is duplicate with the sysctr_timer_enable() function, call it
instead of duplicating code.

> +}
> +
> +static inline u64 sysctr_read_counter(void)
> +{
> +	u32 cnt_hi, tmp_hi, cnt_lo;
> +
> +	do {
> +		cnt_hi = readl_relaxed(sys_ctr_rd_base + CNTCV_HI);
> +		cnt_lo = readl_relaxed(sys_ctr_rd_base + CNTCV_LO);
> +		tmp_hi = readl_relaxed(sys_ctr_rd_base + CNTCV_HI);
> +	} while (tmp_hi != cnt_hi);
> +
> +	return  ((u64) cnt_hi << 32) | cnt_lo;
> +}

It has been showed a 64bit counter usage adds a non negligible overhead,
especially on 32bits. Are you really sure you want this ?

> +static u64 notrace sysctr_read_sched_clock(void)
> +{
> +	return sysctr_read_counter();
> +}
> +
> +static u64 sysctr_clocksource_read(struct clocksource *cs)
> +{
> +	return sysctr_read_counter();
> +}
> +
> +static int __init sysctr_clocksource_init(unsigned int rate)
> +{
> +	sched_clock_register(sysctr_read_sched_clock, 56, rate);
> +	return clocksource_mmio_init(sys_ctr_rd_base, "i.MX sys_ctr",
> +				     rate, 200, 56, sysctr_clocksource_read);
> +}
> +
> +static int sysctr_set_next_event(unsigned long delta,
> +				 struct clock_event_device *evt)
> +{
> +	u32 cmp_hi, cmp_lo;
> +	u64 next;
> +
> +	sysctr_timer_enable(false);
> +
> +	next = sysctr_read_counter();
> +
> +	next += delta;
> +
> +	cmp_hi = (next >> 32) & 0x00fffff;
> +	cmp_lo = next & 0xffffffff;
> +
> +	writel_relaxed(cmp_hi, sys_ctr_cmp_base + CMPCV_HI);
> +	writel_relaxed(cmp_lo, sys_ctr_cmp_base + CMPCV_LO);
> +
> +	sysctr_timer_enable(true);
> +
> +	return 0;
> +}
> +
> +static int sysctr_set_state_oneshot(struct clock_event_device *evt)
> +{
> +	/* enable timer */

The function name is explicit enough, no need to add this comment

> +	sysctr_timer_enable(true);
> +
> +	return 0;
> +}
> +
> +static int sysctr_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	/* disable the timer */

Ditto

> +	sysctr_timer_enable(false);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = &clockevent_sysctr;
> +
> +	sysctr_irq_acknowledge();
> +
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct clock_event_device clockevent_sysctr = {
> +	.name			= "i.MX system counter timer",
> +	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
> +	.set_state_oneshot	= sysctr_set_state_oneshot,
> +	.set_next_event		= sysctr_set_next_event,
> +	.set_state_shutdown	= sysctr_set_state_shutdown,
> +	.rating			= 200,
> +};
> +
> +static int __init sysctr_clockevent_init(unsigned long rate, int irq)
> +{
> +	int ret;
> +
> +	ret = request_irq(irq, sysctr_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
> +		    "i.MX system counter timer", &clockevent_sysctr);
> +	if (ret) {
> +		pr_err("Failed to request i.MX sysctr timer irq\n");
> +		return ret;
> +	}
> +
> +	clockevent_sysctr.cpumask = cpumask_of(0);
> +	clockevent_sysctr.irq = irq;
> +	clockevents_config_and_register(&clockevent_sysctr,
> +			rate, 0xff, 0x7fffffff);
> +	return 0;
> +}
> +
> +static int __init sysctr_timer_init(struct device_node *np)
> +{
> +	u32 rate;
> +	int irq, ret = 0;
> +
> +	/* map the system counter's CNTreadbase */

Comment not useful, remove it

> +	sys_ctr_rd_base = of_iomap(np, 0);
> +	if (!sys_ctr_rd_base) {
> +		pr_err("Failed to map sys_ctr rd base%pOF\n", np);

nit: space missing after 'base'

> +		return -ENXIO;
> +	}
> +
> +	/* map the system counter's CNTcomparebase */

Remove comment

> +	sys_ctr_cmp_base = of_iomap(np, 1);
> +	if (!sys_ctr_cmp_base) {
> +		pr_err("Failed to map sys_ctr compare base%pOF\n", np);
> +		ret = -ENXIO;
> +		goto out_free2;
> +	}
> +
> +	/*
> +	 * the purpose of this driver is to provide a global timer,
> +	 * So only use one compare frame, request frame0's irq only.
> +	 */
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (!irq) {
> +		pr_err("Failed to map interrupt for %pOF\n", np);
> +		ret = -EINVAL;
> +		goto out_free1;
> +	}
> +
> +	if (of_property_read_u32(np, "clock-frequency", &rate)) {
> +		pr_err("Failed to get clock frequency %pOF\n", np);
> +		ret = -EINVAL;
> +		goto out_free1;
> +	}

Please replace it with a 'fixed-clock' in the DT and use the clk API.

In addition you can use the timer-of API (cf timer-of.h)

> +
> +	sysctr_clocksource_init(rate);
> +	sysctr_clockevent_init(rate, irq);
> +
> +	return 0;
> +
> +out_free1:

label names are inadequate, use out_iounmap_cmp: for example

> +	iounmap(sys_ctr_cmp_base);
> +out_free2:
> +	iounmap(sys_ctr_rd_base);
> +	return ret;
> +}
> +TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

