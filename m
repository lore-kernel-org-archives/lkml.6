Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA59C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12582073D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYBKsO7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfBLJGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:06:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40883 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfBLJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:06:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so2081362wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OOsj5rP0qK8yaK+fW00SckoKIFsWt0RwbpvgFzFULGU=;
        b=SYBKsO7BU34O3kZ7oAJLjzl5oMZzPPuxg1U5aSrWvqxl/pHNcIBHdGS9wKMsEmNmWD
         8tCswthB8oAkMtB8qVBeVaI+Oxy0nGguEONZW3Kchvhu5ZGEIbUoI8Hqil/mL2HgHBpn
         gEHI2U2Wi/bf0qPVwYzp70AWDuFBnqQ31AmLMUkw23YK+YgNBH7HMGCqsiJ8KEYYGbsu
         T3SbHTcdm4CFLBWIpcKyCZkndmkSd2QyJMolKYTyOKUMGFg+/MRlU6tS6kZ+jvhvHad8
         8ii4uaQiQBd0ob7UlSr6iBnWINDyPxDk3xZidiWm2lWP5H+guH4CQnLSfan5UqzVxt3R
         cnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOsj5rP0qK8yaK+fW00SckoKIFsWt0RwbpvgFzFULGU=;
        b=CCac1W+yTZuN2K8SQSpRfuvC17smlhUse5FQZvdAuGqozHdJoozt1scOjOrMs65hU0
         busedv1zp0EG6AMJ+V7UtvQDIOHKkvFaAKUU/P/e1bSITIxN3nqVZaahkQLl5ubQtxmQ
         DjGpo+nSEjUcv+6Soi8GM93CrUUrr8YfQbMD6vdr/903+9wRUtE84/+g9cvc4jyCBHLE
         rmnRplpo6i7pGUsywqaQHlaRANy74koZrWQaCCqFjHM1rpUvQoCdOd701pOs0RCzoSHr
         +OrjSZEKpB2d4VFTpagr07mGSRLNykG/46uKtmiqPco7LgdHEzMZjA0e0eaH8BIeUXIH
         VGug==
X-Gm-Message-State: AHQUAuYyuux3nFfpZL1s5I15qQoRzX4b3FTANYp2oSG93OmujyZtwTlD
        63mpbkx7ULio8/5dPImI032SAg==
X-Google-Smtp-Source: AHgI3IYmD5CiC3t02W9DKCrH2RMMDy0EnshKKhY1JZEgIzi1s77ABZAVaHgtWlDapGQufpAqTnV5zw==
X-Received: by 2002:a1c:4683:: with SMTP id t125mr2099331wma.9.1549962376753;
        Tue, 12 Feb 2019 01:06:16 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id u17sm9195303wrg.71.2019.02.12.01.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:06:15 -0800 (PST)
Subject: Re: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
Date:   Tue, 12 Feb 2019 10:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2019 13:26, Sugaya Taichi wrote:
> Add timer driver for Milbeaut SoCs series.
> 
> The timer has two 32-bit width down counters, one of which is configured
> as a clockevent device and the other is configured as a clock source.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>

Do want me to take it through my tree?

> ---
>  drivers/clocksource/Kconfig          |   9 ++
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-milbeaut.c | 161 +++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/clocksource/timer-milbeaut.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6..9101b8f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -634,4 +634,13 @@ config GX6605S_TIMER
>  	help
>  	  This option enables support for gx6605s SOC's timer.
>  
> +config MILBEAUT_TIMER
> +	bool "Milbeaut timer driver" if COMPILE_TEST
> +	depends on OF
> +	depends on ARM
> +	select TIMER_OF
> +	select CLKSRC_MMIO
> +	help
> +	  Enables the support for Milbeaut timer driver.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index cdd210f..6f2543b 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
>  obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
>  obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
>  obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
> +obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
>  obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
>  obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
>  obj-$(CONFIG_RDA_TIMER)		+= timer-rda.o
> diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
> new file mode 100644
> index 0000000..f2019a8
> --- /dev/null
> +++ b/drivers/clocksource/timer-milbeaut.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Socionext Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/sched_clock.h>
> +#include "timer-of.h"
> +
> +#define MLB_TMR_TMCSR_OFS	0x0
> +#define MLB_TMR_TMR_OFS		0x4
> +#define MLB_TMR_TMRLR1_OFS	0x8
> +#define MLB_TMR_TMRLR2_OFS	0xc
> +#define MLB_TMR_REGSZPCH	0x10
> +
> +#define MLB_TMR_TMCSR_OUTL	BIT(5)
> +#define MLB_TMR_TMCSR_RELD	BIT(4)
> +#define MLB_TMR_TMCSR_INTE	BIT(3)
> +#define MLB_TMR_TMCSR_UF	BIT(2)
> +#define MLB_TMR_TMCSR_CNTE	BIT(1)
> +#define MLB_TMR_TMCSR_TRG	BIT(0)
> +
> +#define MLB_TMR_TMCSR_CSL_DIV2	0
> +#define MLB_TMR_DIV_CNT		2
> +
> +#define MLB_TMR_SRC_CH  (1)
> +#define MLB_TMR_EVT_CH  (0)
> +
> +#define MLB_TMR_SRC_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_SRC_CH)
> +#define MLB_TMR_EVT_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_EVT_CH)
> +
> +#define MLB_TMR_SRC_TMCSR_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMCSR_OFS)
> +#define MLB_TMR_SRC_TMR_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMR_OFS)
> +#define MLB_TMR_SRC_TMRLR1_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMRLR1_OFS)
> +#define MLB_TMR_SRC_TMRLR2_OFS	(MLB_TMR_SRC_CH_OFS + MLB_TMR_TMRLR2_OFS)
> +
> +#define MLB_TMR_EVT_TMCSR_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMCSR_OFS)
> +#define MLB_TMR_EVT_TMR_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMR_OFS)
> +#define MLB_TMR_EVT_TMRLR1_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR1_OFS)
> +#define MLB_TMR_EVT_TMRLR2_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR2_OFS)
> +
> +#define MLB_TIMER_RATING	500
> +
> +static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *clk = dev_id;
> +	struct timer_of *to = to_timer_of(clk);
> +	u32 val;
> +
> +	val = readl_relaxed(timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
> +	val &= ~MLB_TMR_TMCSR_UF;
> +	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
> +
> +	clk->event_handler(clk);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mlb_set_state_periodic(struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
> +
> +	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
> +
> +	writel_relaxed(to->of_clk.period, timer_of_base(to) +
> +				MLB_TMR_EVT_TMRLR1_OFS);
> +	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE |
> +		MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
> +	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int mlb_set_state_oneshot(struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
> +
> +	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int mlb_clkevt_next_event(unsigned long event,
> +				   struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +
> +	writel_relaxed(event, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
> +	writel_relaxed(MLB_TMR_TMCSR_CSL_DIV2 |
> +			MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_INTE |
> +			MLB_TMR_TMCSR_TRG, timer_of_base(to) +
> +			MLB_TMR_EVT_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int mlb_config_clock_source(struct timer_of *to)
> +{
> +	writel_relaxed(0, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
> +	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMR_OFS);
> +	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR1_OFS);
> +	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR2_OFS);
> +	writel_relaxed(BIT(4) | BIT(1) | BIT(0), timer_of_base(to) +
> +		MLB_TMR_SRC_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int mlb_config_clock_event(struct timer_of *to)
> +{
> +	writel_relaxed(0, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +
> +	.clkevt = {
> +		.name = "mlb-clkevt",
> +		.rating = MLB_TIMER_RATING,
> +		.cpumask = cpu_possible_mask,
> +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_oneshot = mlb_set_state_oneshot,
> +		.set_state_periodic = mlb_set_state_periodic,
> +		.set_next_event = mlb_clkevt_next_event,
> +	},
> +
> +	.of_irq = {
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +		.handler = mlb_timer_interrupt,
> +	},
> +};
> +
> +static u64 notrace mlb_timer_sched_read(void)
> +{
> +	return ~readl_relaxed(timer_of_base(&to) + MLB_TMR_SRC_TMR_OFS);
> +}
> +
> +static int __init mlb_timer_init(struct device_node *node)
> +{
> +	int ret;
> +	unsigned long rate;
> +
> +	ret = timer_of_init(node, &to);
> +	if (ret)
> +		return ret;
> +
> +	rate = timer_of_rate(&to) / MLB_TMR_DIV_CNT;
> +	mlb_config_clock_source(&to);
> +	clocksource_mmio_init(timer_of_base(&to) + MLB_TMR_SRC_TMR_OFS,
> +		node->name, rate, MLB_TIMER_RATING, 32,
> +		clocksource_mmio_readl_down);
> +	sched_clock_register(mlb_timer_sched_read, 32, rate);
> +	mlb_config_clock_event(&to);
> +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 15,
> +		0xffffffff);
> +	return 0;
> +}
> +TIMER_OF_DECLARE(mlb_peritimer, "socionext,milbeaut-timer",
> +		mlb_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

