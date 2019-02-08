Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197EBC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CBF218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P+lAusm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfBHNYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:24:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33690 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfBHNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:24:34 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18DOH69020334;
        Fri, 8 Feb 2019 07:24:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549632257;
        bh=KN27eVrW9tG745rWB5gGx4GSDgsoCpJZfglRGskOQBI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P+lAusm9BLTzDk8nbFCw328u49Da5fae4BHImqSTMOGwKmWiqOwAevya63TqXCdE1
         QhItZkjpyZcJCF/dLp3Mpvn2kpa42i/OleBnbAEChph/Qsn8uVENU3SZRfx/f88l+7
         /Y2S6z0Ecs8RvGzMUj8I5tT1K8Yi5zOW7QJLEjEM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18DOHGM056066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 07:24:17 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 07:24:17 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 07:24:17 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18DODlT007996;
        Fri, 8 Feb 2019 07:24:14 -0600
Subject: Re: [PATCH v2 02/12] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-3-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <7243573a-884d-cce2-380b-1be73636fafb@ti.com>
Date:   Fri, 8 Feb 2019 18:54:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:

> +static unsigned int davinci_timer_read(struct davinci_timer_data *timer,
> +				       unsigned int reg)
> +{
> +	return __raw_readl(timer->base + reg);
> +}
> +
> +static void davinci_timer_write(struct davinci_timer_data *timer,
> +				unsigned int reg, unsigned int val)
> +{
> +	__raw_writel(val, timer->base + reg);
> +}

Since its a new driver, please use readl_relaxed() and writel_relaxed().

> +static void davinci_timer_init(void __iomem *base)
> +{
> +	/* Set clock to internal mode and disable it. */
> +	__raw_writel(0x0, base + DAVINCI_TIMER_REG_TCR);
> +	/*
> +	 * Reset both 32-bit timers, set no prescaler for timer 34, set the
> +	 * timer to dual 32-bit unchained mode, unreset both 32-bit timers.
> +	 */
> +	__raw_writel(DAVINCI_TIMER_TGCR_DEFAULT, base + DAVINCI_TIMER_REG_TGCR);
> +	/* Init both counters to zero. */
> +	__raw_writel(0x0, base + DAVINCI_TIMER_REG_TIM12);
> +	__raw_writel(0x0, base + DAVINCI_TIMER_REG_TIM34);

here too.

> +}
> +
> +int __init davinci_timer_register(struct clk *clk,
> +				  const struct davinci_timer_cfg *timer_cfg)
> +{

[...]

> +	clocksource = kzalloc(sizeof(*clocksource), GFP_KERNEL);
> +	if (!clocksource) {
> +		pr_err("%s: Error allocating memory for clocksource data\n",
> +		       __func__);
> +		return -ENOMEM;
> +	}
> +
> +	clocksource->dev.name = "tim34";
> +	clocksource->dev.rating = 300;
> +	clocksource->dev.read = davinci_timer_clksrc_read;
> +	clocksource->dev.mask = CLOCKSOURCE_MASK(DAVINCI_TIMER_CLKSRC_BITS);
> +	clocksource->dev.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> +	clocksource->timer.set_period = davinci_timer_set_period_std;
> +	clocksource->timer.mode = DAVINCI_TIMER_MODE_PERIODIC;
> +	clocksource->timer.base = base;
> +
> +	if (timer_cfg->cmp_off)
> +		clocksource->timer.regs = &davinci_timer_tim12_regs;
> +	else
> +		clocksource->timer.regs = &davinci_timer_tim34_regs;

We should set clocksource->dev.name based on cmp_off too, otherwise it
will be confusing to have a device called "tim34" using tim12 registers.

> +/**
> + * struct davinci_timer_cfg - davinci clocksource driver configuration struct
> + * @reg:        register range resource
> + * @irq:        clockevent and clocksource interrupt resources
> + * @cmp_off:    if set - it specifies the compare register used for clockevent
> + *
> + * Note: if the compare register is specified, the driver will use the bottom
> + * clock half for both clocksource and clockevent and the compare register
> + * to generate event irqs. The user must supply the correct compare register
> + * interrupt number.
> + *
> + * This is only used by da830 the DSP of which uses the top half. The timer
> + * driver still configures the top half to run in free-run mode.

This note helps. Thanks!

Regards,
Sekhar
