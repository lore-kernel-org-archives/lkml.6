Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA2C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D59A208E9
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzqsJ0/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D59A208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeHZSQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 14:16:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37834 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeHZSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 14:16:12 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so7465229itf.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CCnZotdDQg27IKceQe7qutnNszXgPFvXAM41QX6OC8=;
        b=QzqsJ0/f3x/mCe6YHDWebts9cTfq9rRSYpN2b0pLNtX2yx01NFyXnn45KjW6SUI+Vg
         5vHSI0IHLby6b/5O+qVx3yS2WcelN/b3Ks3mDWPQswOMdSiwpYz2RX2oJXesxrW4xvTt
         l/ho5IGa2DtC4nFEcJp5BwLogl9M2zes5rgDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CCnZotdDQg27IKceQe7qutnNszXgPFvXAM41QX6OC8=;
        b=KLo1Q+vYhNZs8pk6jA27CBcqb3Lzilp5V1/0ExzjVbAF/Z1WT/umx+UWaJb7MSSprv
         jT9qK/cxFT4RJydbFx5zhTZTlmZd/T1ksDC+cHS3bpuUupETWpLyrU0wrAuqrGCF8hfy
         RFMcP8X1JTQHw9DQeUpsivXuE0T0bPe2AaPvvgrPWEYJJkg5UVtlKIYunFGb+mtRirHd
         OBveF8BZKUx6TzQLZQYwHzH7M4CmeUipcw2Yk9P7twYP5iKr0LwS5GNlE+QZKEuup0Q8
         EHD2CavtKciLNgIt0b2w+lomMTYx9IkHxsDYBcwbzCcfXzLqYkXNsLO+fdvhvyMLq0Hg
         TqhA==
X-Gm-Message-State: APzg51Atuix2IIeNzvqzgStffuASDg8lxa5ex2jnbwOsaV487V1RDcLl
        1UBNtsT+V+q+L2sA/3QEjns6jNatfHuaHN4AhOip1A==
X-Google-Smtp-Source: ANB0VdZs3GOuhvY6imtWR1g1sn2zG4wTdAYMNQV0ZI2YcWOw2J6VYWmurKVuAVHc29MVnlbIK/Z+3ehnKMQwx0fZXXs=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr4455138itc.16.1535294007798;
 Sun, 26 Aug 2018 07:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180817163849.30750-1-ilina@codeaurora.org> <20180817163849.30750-2-ilina@codeaurora.org>
In-Reply-To: <20180817163849.30750-2-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Aug 2018 16:33:15 +0200
Message-ID: <CACRpkdb+Opdn1eWZSRydS1Bafpqwcg83xEcT-YJC6D-kSSi1ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to GPIO
To:     ilina@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, evgreen@chromium.org,
        rplsssn@codeaurora.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 6:39 PM Lina Iyer <ilina@codeaurora.org> wrote:

> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
> domain can wakeup the SoC, when interrupts and GPIOs are routed to the
> its interrupt controller. Only select GPIOs that are deemed wakeup
> capable are routed to specific PDC pins. During low power state, the
> pinmux interrupt controller may be non-functional but the PDC would be.
> The PDC can detect the wakeup GPIO is triggered and bring the TLMM to an
> operational state.
>
> Interrupts that are level triggered will be detected at the TLMM when
> the controller becomes operational. Edge interrupts however need to be
> replayed again.
>
> Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
> but keep it disabled. During suspend, we can enable the PDC IRQ instead
> of the GPIO IRQ, which may or not be detected.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v1:
>         - Trigger GPIO in h/w from PDC IRQ handler
>         - Avoid big tables for GPIO-PDC map, pick from DT instead
>         - Use handler_data

Just for the record this is an impressive and much needed patch
set, no other SoC developer has yet taken on the task of making this
work so I very much appreciate that Qualcomm show the way.

> +static int msm_gpio_pdc_pin_request(struct irq_data *d)
> +static int msm_gpio_pdc_pin_release(struct irq_data *d)
> +static int msm_gpio_irq_reqres(struct irq_data *d)
> +{
(...)
> +       if (gpiochip_lock_as_irq(gc, irqd_to_hwirq(d))) {
(...)
> +static void msm_gpio_irq_relres(struct irq_data *d)
> +{
> +       gpiochip_unlock_as_irq(gc, irqd_to_hwirq(d));
> +}

FYI Hans Verkuil is working on a patch set that moves the
lock/unlock as IRQ call to the irqchip request() and release()
functions so we can switch a GPIO irqchip line from IRQ
mode to say output at runtime without too much trouble.
(CEC needs this.)

I suspect that will make your work easier?

Hans can you include Lina in the loop for your patches
so she can take that into accoun because I think we might
need that as a base for this.

Yours,
Linus Walleij
