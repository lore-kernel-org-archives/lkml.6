Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EA8C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF6826676
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdjRwkxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF6826676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934333AbeF0KBK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:01:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40014 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934289AbeF0KBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:01:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so4788551wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 03:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4F+vRqty9yOr4MR5geQ4CUWXZ3Le3vXUPgCr2R4pLpk=;
        b=TdjRwkxnLVY8L4dr5ZTwNRbc7d2Pgpg61zY09QaCSPiWnr7qlLPDxXNI5I8JJxXeRT
         d+9L2/1rz1Z4xxeozVxNB3IaAAIjUVzN+WvfUa8iapycN82tyzL8eN5rHrklBs/amw61
         8YdpfPBAIyoyzBbnXnvfLBwxIJjKLO8qytjUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4F+vRqty9yOr4MR5geQ4CUWXZ3Le3vXUPgCr2R4pLpk=;
        b=X3spWLVfFwnC4wS2ZVWUSXiCTQg+iIkdCmxigTznFLxlvsteTXi/vp8/iJ4sWERHs5
         uXsPEXOKBK6yujsJEsWVqoewqfqy6Q3piyYMjUrtXnlySZMCSDZCiYDAds0AwZiqKt7h
         fTXD+ZX8DSD8EKEgPTogyRZQP/BP44DKMRkUqWBIIia9Z6e/WQUTLR0JcI7Ht5Bw9li4
         3vxooY4p6QfXKw0gaPTl9UkFonjNkUzog1IUiXmwsMbIr+l0oKX4otADC2Rw4oVbgwTy
         Wn8Ymy5DWhE9Iqrqoh5m3easbTKFVZhJRFt1ky19MDgPZFr6a18iFDI7y2rvpeTfgGUB
         6/iA==
X-Gm-Message-State: APt69E3rC6McgWCSO0OdyEym3BK7f/VJsw0ZpTsEZB2tW/oc7BbRMy3r
        nJhMb5IpJO7RB1YVhEmIjzx7iQ==
X-Google-Smtp-Source: AAOMgpdCxlBf+g4deSJOlxdQr16jSkpPj19IgBSxKMXSvwkX530cfqSNrOn1oGi5fHpFJfeMyEMXMA==
X-Received: by 2002:a1c:58d1:: with SMTP id m200-v6mr4658761wmb.160.1530093666256;
        Wed, 27 Jun 2018 03:01:06 -0700 (PDT)
Received: from [192.168.8.101] ([37.170.252.174])
        by smtp.googlemail.com with ESMTPSA id j131-v6sm6194726wmg.24.2018.06.27.03.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 03:01:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clocksource/drivers/mtk_systimer: Add support for
 Mediatek SoCs
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
 <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8cff2306-ba78-a537-599e-14a4363ed71d@linaro.org>
Date:   Wed, 27 Jun 2018 12:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2018 09:53, Stanley Chu wrote:
> This patch adds a new clock event for the timer
> found on the Mediatek SoCs.
> 
> The Mediatek System Timer has several 32-bit timers.
> Only one timer is used by this driver as a clock event
> supporting oneshot events.
> 
> The System Timer can be run with two clocks. A 13 MHz system
> clock and the RTC clock running at 32 KHz. This implementation
> uses the system clock with no clock source divider.
> The interrupts are shared between the different timers.
> We just enable one interrupt for the clock event. The clock
> event timer is used by all cores.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/clocksource/Kconfig        |   13 +++-
>  drivers/clocksource/Makefile       |    1 +
>  drivers/clocksource/mtk_systimer.c |  132 ++++++++++++++++++++++++++++++++++++

Please merge mtk_systimer.c and mtk_timer.c into a single file:

timer-mediatek.c

Patch 1:

 git mv mtk_timer.c timer-mediatek.c
 Change the name in Makefile

Patch 2:

 Change function prefix name to _gpt_

Patch 2.1 [optional but recommended] :

 Move the gpt's init code to timer-of

Patch 3:

 Add code for syst in timer-mediatek.c



A couple of comments below.

>  3 files changed, 144 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clocksource/mtk_systimer.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index dec0dd8..362c110 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -442,12 +442,21 @@ config SYS_SUPPORTS_SH_CMT
>          bool
>  
>  config MTK_TIMER
> -	bool "Mediatek timer driver" if COMPILE_TEST
> +	bool "Mediatek general purpose timer driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
>  	select TIMER_OF
>  	select CLKSRC_MMIO
>  	help
> -	  Support for Mediatek timer driver.
> +	  Support for Mediatek General Purpose Timer (GPT) driver.
> +
> +config MTK_TIMER_SYSTIMER
> +	bool "Mediatek system timer driver" if COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select TIMER_OF
> +	select CLKSRC_MMIO
> +	help
> +	  Support for Mediatek System Timer (sys_timer) driver used as
> +	  a clock event supporting oneshot events.
>  
>  config SPRD_TIMER
>  	bool "Spreadtrum timer driver" if EXPERT
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 00caf37..cdd34b2 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_FSL_FTM_TIMER)	+= fsl_ftm_timer.o
>  obj-$(CONFIG_VF_PIT_TIMER)	+= vf_pit_timer.o
>  obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
>  obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o
> +obj-$(CONFIG_MTK_TIMER_SYSTIMER)	+= mtk_systimer.o
>  obj-$(CONFIG_CLKSRC_PISTACHIO)	+= time-pistachio.o
>  obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
>  obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
> diff --git a/drivers/clocksource/mtk_systimer.c b/drivers/clocksource/mtk_systimer.c
> new file mode 100644
> index 0000000..77161bb
> --- /dev/null
> +++ b/drivers/clocksource/mtk_systimer.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +//  Copyright (C) 2018 MediaTek Inc.
> +
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/io.h>
> +#include "timer-of.h"
> +
> +/* registers */
> +#define STMR_CON                  (0x0)
> +#define STMR_VAL                  (0x4)
> +
> +#define TIMER_REG_CON(to)         (timer_of_base(to) + STMR_CON)
> +#define TIMER_REG_VAL(to)         (timer_of_base(to) + STMR_VAL)
> +
> +/* STMR_CON */
> +#define STMR_CON_EN               BIT(0)
> +#define STMR_CON_IRQ_EN           BIT(1)
> +#define STMR_CON_IRQ_CLR          BIT(4)
> +
> +#define TIMER_SYNC_TICKS          3
> +
> +static void mtk_stmr_reset(struct timer_of *to)
> +{
> +	/* Clear IRQ */
> +	writel(STMR_CON_IRQ_CLR | STMR_CON_EN, TIMER_REG_CON(to));
> +
> +	/* Reset counter */
> +	writel(0, TIMER_REG_VAL(to));
> +
> +	/* Disable timer */
> +	writel(0, TIMER_REG_CON(to));

Wouldn't make sense to clear the interrupt after disabling the timer ?

> +}
> +
> +static void mtk_stmr_ack_irq(struct timer_of *to)
> +{
> +	mtk_stmr_reset(to);
> +}
> +
> +static irqreturn_t mtk_stmr_handler(int irq, void *dev_id)
> +{
> +	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
> +	struct timer_of *to = to_timer_of(clkevt);
> +
> +	mtk_stmr_ack_irq(to);
> +	clkevt->event_handler(clkevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_stmr_clkevt_next_event(unsigned long ticks,
> +				      struct clock_event_device *clkevt)
> +{
> +	struct timer_of *to = to_timer_of(clkevt);
> +
> +	/*
> +	 * reset timer first because we do not expect interrupt is triggered
> +	 * by old compare value.
> +	 */
> +	mtk_stmr_reset(to);
> +
> +	writel(STMR_CON_EN, TIMER_REG_CON(to));
> +
> +	writel(ticks, TIMER_REG_VAL(to));
> +
> +	writel(STMR_CON_EN | STMR_CON_IRQ_EN, TIMER_REG_CON(to));
> +
> +	return 0;
> +}
> +
> +static int mtk_stmr_clkevt_shutdown(struct clock_event_device *clkevt)
> +{
> +	mtk_stmr_reset(to_timer_of(clkevt));
> +
> +	return 0;
> +}
> +
> +static int mtk_stmr_clkevt_resume(struct clock_event_device *clkevt)
> +{
> +	return mtk_stmr_clkevt_shutdown(clkevt);
> +}
> +
> +static int mtk_stmr_clkevt_oneshot(struct clock_event_device *clkevt)
> +{
> +	return 0;
> +}
> +
> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +
> +	.clkevt = {
> +		.name = "mtk-clkevt",
> +		.rating = 300,
> +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
> +		.set_state_shutdown = mtk_stmr_clkevt_shutdown,
> +		.set_state_oneshot = mtk_stmr_clkevt_oneshot,
> +		.tick_resume = mtk_stmr_clkevt_resume,
> +		.set_next_event = mtk_stmr_clkevt_next_event,
> +		.cpumask = cpu_possible_mask,
> +	},
> +
> +	.of_irq = {
> +		.handler = mtk_stmr_handler,
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL | IRQF_TRIGGER_HIGH |

Why do you need IRQF_TRIGGER_HIGH ?

> +			 IRQF_PERCPU,

Why IRQF_PERCPU ?

> +	},
> +};
> +
> +static int __init mtk_stmr_init(struct device_node *node)
> +{
> +	int ret;
> +
> +	ret = timer_of_init(node, &to);
> +	if (ret)
> +		return ret;
> +
> +	mtk_stmr_reset(&to);
> +
> +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +
> +	pr_info("mtk_stmr: irq=%d, rate=%lu, max_ns: %llu, min_ns: %llu\n",
> +		timer_of_irq(&to), timer_of_rate(&to),
> +		to.clkevt.max_delta_ns, to.clkevt.min_delta_ns);
> +
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(mtk_systimer, "mediatek,sys_timer", mtk_stmr_init);

No "mediatek,sys_timer" but eg. "mediatek,mt6765", so it is consistent
with the DT binding.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

