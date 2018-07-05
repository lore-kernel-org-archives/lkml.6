Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC04C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D590D240CB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgztxfnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D590D240CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeGEANE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 20:13:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55112 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbeGEANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 20:13:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so8345950wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Lk7Ed1PdcoxxoUCrX6BqoRdbKqQ7TYzr1LJ75icx+4=;
        b=hgztxfnt1ZOUhyiTtHM2aNPn5ToyirxsQn/CcRi5kphuMscIYH8TQ5czl483biM+ck
         ELRSWPhZRIZex1LYnZk8CJssv43QBpA5SNiAiRA3ATbI9gdeMD/aKg5xLHbDLTiM1vkd
         FZ4uOgVTma+KX5eAtH4PXB7x2NvUHB/ga1iI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Lk7Ed1PdcoxxoUCrX6BqoRdbKqQ7TYzr1LJ75icx+4=;
        b=tJE9pgNfR36UyNg2N4O4I23X+hAO3Wd5aYnPF2p/NgUNqd+0yhXLVX9bcD8tcyXuC1
         zwfHjyXKButp/Bv4KZ4LWwXt1El25d9lCq/e9ZGNpuNMSuYWlEv4h86tg2l6F6E1/uz1
         n2z21jR+GzlVMswIYM9z8ua6XD1Qbs7VY6WHp3Aug8+N5O902Oy/YJodfBfcANaRRh4W
         PoItmcv9AkXOYrRsG8zmc8hRQNNy25d6tmZNkC2X9Kpfmrnr7aDWaLbc1mWGSQpKGL22
         8VA3WPpj3BfMYN8WAZPuQ0mphL335oPugOiMWM/p6udww6gXyhugkJv7Vhoc9ANEsQ2n
         1Xcw==
X-Gm-Message-State: APt69E1Y1vdTFJuwdbNMrU9dwFj9V9L0p7xAD5CQfJJWrrCdEHceyrGT
        QI5IYkBbDSLmqPEGRxqGi/+w1g==
X-Google-Smtp-Source: AAOMgpdT8ldxEgcIaLzV54hzTAbT0B1ucoiMageuZ53OtIHmLCgXDQCDmYrEWR7/asgvjI3WmKVmmQ==
X-Received: by 2002:a1c:78b:: with SMTP id 133-v6mr2871693wmh.59.1530749580902;
        Wed, 04 Jul 2018 17:13:00 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:84b1:bd51:47a2:fc02? ([2001:41d0:fe90:b800:84b1:bd51:47a2:fc02])
        by smtp.googlemail.com with ESMTPSA id d15-v6sm653765wmb.0.2018.07.04.17.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 17:12:59 -0700 (PDT)
Subject: Re: [PATCH v6 5/5] clocksource/drivers/timer-mediatek: Add support
 for system timer
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530715820-3406-1-git-send-email-stanley.chu@mediatek.com>
 <1530715820-3406-6-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2cb9177c-0586-4432-94a2-df46fe64cc3b@linaro.org>
Date:   Thu, 5 Jul 2018 02:13:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530715820-3406-6-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2018 16:50, Stanley Chu wrote:
> This patch adds a new "System Timer" on the Mediatek SoCs.
> 
> The System Timer is introduced as an always-on timer being
> clockevent device for tick-broadcasting.
> 
> For clock, it is driven by 13 MHz system clock.
> The implementation uses the system clock with no clock
> source divider.
> 
> For interrupt, the clock event timer can be used by all cores.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/clocksource/timer-mediatek.c |  110 +++++++++++++++++++++++++++++++++-
>  1 file changed, 109 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index e57c4d7..e98244a 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -58,6 +58,86 @@
>  
>  static void __iomem *gpt_sched_reg __read_mostly;
>  
> +/* system timer */
> +#define SYST_BASE               (0x40)
> +
> +#define SYST_CON                (SYST_BASE + 0x0)
> +#define SYST_VAL                (SYST_BASE + 0x4)
> +
> +#define SYST_CON_REG(to)        (timer_of_base(to) + SYST_CON)
> +#define SYST_VAL_REG(to)        (timer_of_base(to) + SYST_VAL)
> +
> +/*
> + * SYST_CON_EN: Clock enable. Shall be set to
> + *   - Start timer countdown.
> + *   - Allow timeout ticks being updated.
> + *   - Allow changing interrupt functions.
> + *
> + * SYST_CON_IRQ_EN: Set to allow interrupt.
> + *
> + * SYST_CON_IRQ_CLR: Set to clear interrupt.
> + */
> +#define SYST_CON_EN              BIT(0)
> +#define SYST_CON_IRQ_EN          BIT(1)
> +#define SYST_CON_IRQ_CLR         BIT(4)
> +
> +static void __iomem *gpt_sched_reg __read_mostly;

duplicate 'gpt_sched_reg' variable.


> +static void mtk_syst_ack_irq(struct timer_of *to)
> +{
> +	/* Clear and disable interrupt */
> +	writel(SYST_CON_IRQ_CLR | SYST_CON_EN, SYST_CON_REG(to));
> +}
> +
> +static irqreturn_t mtk_syst_handler(int irq, void *dev_id)
> +{
> +	struct clock_event_device *clkevt = dev_id;
> +	struct timer_of *to = to_timer_of(clkevt);
> +
> +	mtk_syst_ack_irq(to);
> +	clkevt->event_handler(clkevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_syst_clkevt_next_event(unsigned long ticks,
> +				      struct clock_event_device *clkevt)
> +{
> +	struct timer_of *to = to_timer_of(clkevt);
> +
> +	/* Enable clock to allow timeout tick update later */
> +	writel(SYST_CON_EN, SYST_CON_REG(to));
> +
> +	/*
> +	 * Write new timeout ticks. Timer shall start countdown
> +	 * after timeout ticks are updated.
> +	 */
> +	writel(ticks, SYST_VAL_REG(to));
> +
> +	/* Enable interrupt */
> +	writel(SYST_CON_EN | SYST_CON_IRQ_EN, SYST_CON_REG(to));
> +
> +	return 0;
> +}
> +
> +static int mtk_syst_clkevt_shutdown(struct clock_event_device *clkevt)
> +{
> +	/* Disable timer */
> +	writel(0, SYST_CON_REG(to_timer_of(clkevt)));
> +
> +	return 0;
> +}
> +
> +static int mtk_syst_clkevt_resume(struct clock_event_device *clkevt)
> +{
> +	return mtk_syst_clkevt_shutdown(clkevt);
> +}
> +
> +static int mtk_syst_clkevt_oneshot(struct clock_event_device *clkevt)
> +{
> +	return 0;
> +}
> +
>  static u64 notrace mtk_gpt_read_sched_clock(void)
>  {
>  	return readl_relaxed(gpt_sched_reg);
> @@ -186,6 +266,34 @@ static void mtk_gpt_enable_irq(struct timer_of *to, u8 timer)
>  	},
>  };
>  
> +static int __init mtk_syst_init(struct device_node *node)
> +{
> +	int ret;
> +
> +	to.clkevt.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT;
> +	to.clkevt.set_state_shutdown = mtk_syst_clkevt_shutdown;
> +	to.clkevt.set_state_oneshot = mtk_syst_clkevt_oneshot;
> +	to.clkevt.tick_resume = mtk_syst_clkevt_resume;
> +	to.clkevt.set_next_event = mtk_syst_clkevt_next_event;
> +	to.of_irq.handler = mtk_syst_handler;
> +
> +	ret = timer_of_init(node, &to);
> +	if (ret)
> +		goto err;
> +
> +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> +					TIMER_SYNC_TICKS, 0xffffffff);
> +
> +	pr_info("irq=%d, rate=%lu, max_ns: %llu, min_ns: %llu\n",
> +		timer_of_irq(&to), timer_of_rate(&to),
> +		to.clkevt.max_delta_ns, to.clkevt.min_delta_ns);

Please remove this trace. Most of this information is already available
in /proc/timer_list.

However, if you think it is worth to add this trace, do a proposition in
the time framework directly so all drivers can benefit this change.

> +	return 0;
> +err:
> +	timer_of_cleanup(&to);
> +	return ret;
> +}
> +
>  static int __init mtk_gpt_init(struct device_node *node)
>  {
>  	int ret;
> @@ -218,9 +326,9 @@ static int __init mtk_gpt_init(struct device_node *node)
>  	mtk_gpt_enable_irq(&to, TIMER_CLK_EVT);
>  
>  	return 0;
> -
>  err:
>  	timer_of_cleanup(&to);
>  	return ret;
>  }
>  TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
> +TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

