Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4016C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778A62075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dExpgIcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778A62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJIPfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeJIPfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:35:06 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 587E4214DA;
        Tue,  9 Oct 2018 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539073161;
        bh=+8TrLxl44qZpH7Njv/jvir5YcCoI141qyw/Tb+frXI0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dExpgIcCn/VaHlHmFJ9CJFhgVK4mtyKoLQ7FhBre7R4oPREubWqZuwqMzqPxYHIJE
         cLbtCs7Mcawycv1CDsNTY6U7Iy9QPxh1eNojptlLMIUjfA9aesXwAGS5Tgsmy+B0mA
         WMa8uEV2OxBLRYM1xQmpaDiWFuQ87w+3kNM3ZMkY=
Received: by mail-wm1-f51.google.com with SMTP id y11-v6so878797wma.3;
        Tue, 09 Oct 2018 01:19:21 -0700 (PDT)
X-Gm-Message-State: ABuFfogtg9pGQUIijF6+fTCjIEbZafan6NQEBndMFNDpytH0VbJfl2ax
        xsADyeYisnfIQKHCffQrOEj+SXdMnQ5Ppi1pvB8=
X-Google-Smtp-Source: ACcGV62wjPVqUFYRXSDQhPtRvfU5qYDtqbrNzSMScv7aaW8HMybno4JoFs/Bpo9ZZQLAiDdbGY6/zyMtGKeT5ZARekE=
X-Received: by 2002:a1c:ab54:: with SMTP id u81-v6mr1021067wme.45.1539073159645;
 Tue, 09 Oct 2018 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181008125047eucas1p23e520d778ad5f18aba57b21641d4cb4c@eucas1p2.samsung.com>
 <20181008125009.3721-1-m.szyprowski@samsung.com> <20181008125009.3721-3-m.szyprowski@samsung.com>
In-Reply-To: <20181008125009.3721-3-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 9 Oct 2018 10:19:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeAt_fwVCkCw-8iGprB8Y=Dxj=hx5UyJw1kjsbmMwh2pA@mail.gmail.com>
Message-ID: <CAJKOXPeAt_fwVCkCw-8iGprB8Y=Dxj=hx5UyJw1kjsbmMwh2pA@mail.gmail.com>
Subject: Re: [PATCH 2/7] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018 at 14:50, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks. This patch adds a mode of cooperation
> with arch_timer driver, so kernel can use CP15 based timer interface via
> arch_timer driver, which is mandatory on ARM64. In such mode driver only
> configures MCT registers and starts the timer but don't register any
> clocksource or events in the system. Those are left to be handled by
> arch_timer driver.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 43b335ff4a96..05b201ed8ef5 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -57,6 +57,7 @@
>  #define TICK_BASE_CNT  1
>
>  enum {
> +       MCT_INT_NONE = 0,
>         MCT_INT_SPI,
>         MCT_INT_PPI
>  };
> @@ -238,6 +239,9 @@ static int __init exynos4_clocksource_init(void)
>  {
>         exynos4_mct_frc_start();
>
> +       if (!mct_int_type)
> +               return 0;
> +
>  #if defined(CONFIG_ARM)
>         exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
>         exynos4_delay_timer.freq = clk_rate;
> @@ -343,6 +347,9 @@ static struct irqaction mct_comp_event_irq = {
>
>  static int exynos4_clockevent_init(void)
>  {
> +       if (!mct_int_type)
> +               return 0;
> +
>         mct_comp_device.cpumask = cpumask_of(0);
>         clockevents_config_and_register(&mct_comp_device, clk_rate,
>                                         0xf, 0xffffffff);
> @@ -476,12 +483,12 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>
>                 irq_force_affinity(evt->irq, cpumask_of(cpu));
>                 enable_irq(evt->irq);
> -       } else {
> +       } else if (mct_int_type == MCT_INT_PPI) {
>                 enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>         }
> -       clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
> -                                       0xf, 0x7fffffff);
> -
> +       if (mct_int_type)
> +               clockevents_config_and_register(evt,
> +                              clk_rate / (TICK_BASE_CNT + 1), 0xf, 0x7fffffff);
>         return 0;
>  }
>
> @@ -496,7 +503,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>                 if (evt->irq != -1)
>                         disable_irq_nosync(evt->irq);
>                 exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> -       } else {
> +       } else if (mct_int_type == MCT_INT_PPI) {
>                 disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
>         }
>         return 0;
> @@ -529,7 +536,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>                                          &percpu_mct_tick);
>                 WARN(err, "MCT: can't request IRQ %d (%d)\n",
>                      mct_irqs[MCT_L0_IRQ], err);
> -       } else {
> +       } else if (mct_int_type == MCT_INT_SPI) {
>                 for_each_possible_cpu(cpu) {
>                         int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
>                         struct mct_clock_event_device *pcpu_mevt =

The error path of cpuhp_setup_state() does not look correct because
request_percpu_irq() was not called. The error path looks suspicious
also for MCT_INT_SPI path - the IRQs were allocated with regular
request_irq but are freed with percpu version.

> @@ -573,6 +580,15 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>
>         mct_int_type = int_type;
>
> +       if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
> +               struct device_node *np = of_find_compatible_node(NULL, NULL,
> +                                                            "arm,armv8-timer");
> +               if (np) {
> +                       mct_int_type = MCT_INT_NONE;
> +                       of_node_put(np);

In this case, later the mct_irqs are being assigned but totally not
used. Are they needed?

Best regards,
Krzysztof

> +               }
> +       }
> +
>         /* This driver uses only one global timer interrupt */
>         mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
>
> --
> 2.17.1
>
