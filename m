Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2981C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AB62083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WpkaH1dg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oeCZk4Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AB62083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeFTPwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:52:42 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45281 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754485AbeFTPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:52:28 -0400
Received: by mail-vk0-f67.google.com with SMTP id l64-v6so10122vkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sZu0ml+H00giOw56WrKB6Op3EB96FhcG1xJBG6T/oHQ=;
        b=WpkaH1dgBwc6Kuw120mZd8BT2aCcfPCClCJubU+Q+/TixVn7KMR+upAemN5kuRCdaE
         cQFYxCWHT24f7XCu0LG3XWTwdOxAM/tqH1PDVZUbB3RvM3ej7LMac48FmTft9j4SLUz/
         xBeyUt2CLu0cdyH2ZGpljU255bFkAXSUe0pyplxSMdmo3VCjeYIaoX67Q/gs53K5WkH/
         KffSHz22NPa2SgvdF8IrCm57r8OeTbQED7lSDo0vaMoDdleV47S8+0VNunD1RpfHqyKU
         ENTw4/FwYafpG6+aiBaN9SnHH1TBG1rDI7XYl9Ivv4Vv5mifzU2hVfTACvk3cfZtRUZl
         66og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sZu0ml+H00giOw56WrKB6Op3EB96FhcG1xJBG6T/oHQ=;
        b=oeCZk4Ir0ZeXOQ5ijAnzdabVaYSfe2eOnkq0Lo2yGsBvMYJ4Ykx/YOIwFDcG/Ydl+w
         TTKl4R1D9D8VYIf27aeWGjs498UoN6gtXEprzZdnl9eS8UgVyDDCzT+j9uGWXX59VsYW
         Tm4PU7ZRjsl3eBFl4LLlUtI3iSR9OkGBUjxlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sZu0ml+H00giOw56WrKB6Op3EB96FhcG1xJBG6T/oHQ=;
        b=Rz9w6F1JfoFl/7oWfJzMdc/dsrnLPH9KVhWggMou53XLT+yPsZCI0ctXZ8e8ZJqE1a
         AsfgPRbYwcd78o14MV7MygrLzU3oOrZ8b9F+YNLmexx2c98ojSamsvrhRXScQQWTuSWI
         RxGTPM17MrR/h0NpATEV9suZIW1Hcflccnw1s/NY4bT8WWyU0gizfZI4C7yXjdVsT5yY
         lkaTZZc1PxRX6UzF+f/gJxQbru4TGmiKNQwDlN5/2xF2AS9W463pTV/VsXg1uvxNJdtL
         th7alliGWg/aufn27ra0LSF3pTObWZTKy2SZ71WRpUQ12oZ57W1Lxq0PAiN0nvjuPm2B
         kc+g==
X-Gm-Message-State: APt69E3aJ7MY513U609Xgg50yfSsaLkbP6w5stnHapV1LysHmUJgXa1g
        phy2e+mxf7miFWxuFhb6aR/oz6L3cWSVo02M1xRDyQ==
X-Google-Smtp-Source: ADUXVKLY3zVIIWTS4Ctjzsf0W5DQzC3us06bvHAOCoIVkqLx67lU1v8Jqi5L3jLJzeMo81uYFHqq0fFJbXu++n4VTro=
X-Received: by 2002:a1f:2758:: with SMTP id n85-v6mr12552759vkn.117.1529509946938;
 Wed, 20 Jun 2018 08:52:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 08:52:26
 -0700 (PDT)
In-Reply-To: <20180620064509.GL15126@tuxbook-pro>
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-2-swboyd@chromium.org>
 <20180620064509.GL15126@tuxbook-pro>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jun 2018 08:52:26 -0700
X-Google-Sender-Auth: Ts-m094OSOeTnPEw0BAwuJrbWrw
Message-ID: <CAD=FV=U1bqg60f00-X72HUQ1DyuPaTX1Utw8QsV6Ucyf_Qy49w@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to prevent latching
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 19, 2018 at 11:45 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
>
>> The interrupt controller hardware in this pin controller has two status
>> enable bits. The first "normal" status enable bit enables or disables
>> the summary interrupt line being raised when a gpio interrupt triggers
>> and the "raw" status enable bit allows or prevents the hardware from
>> latching an interrupt into the status register for a gpio interrupt.
>> Currently we just toggle the "normal" status enable bit in the mask and
>> unmask ops so that the summary irq interrupt going to the CPU's
>> interrupt controller doesn't trigger for the masked gpio interrupt.
>>
>> For a level triggered interrupt, the flow would be as follows: the pin
>> controller sees the interrupt, latches the status into the status
>> register, raises the summary irq to the CPU, summary irq handler runs
>> and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
>> interrupt, the interrupt handler runs, and finally unmask the interrupt.
>> When the interrupt handler completes, we expect that the interrupt line
>> level will go back to the deasserted state so the genirq code can unmask
>> the interrupt without it triggering again.
>>
>> If we only mask the interrupt by clearing the "normal" status enable bit
>> then we'll ack the interrupt but it will continue to show up as pending
>> in the status register because the raw status bit is enabled, the
>> hardware hasn't deasserted the line, and thus the asserted state latches
>> into the status register again. When the hardware deasserts the
>> interrupt the pin controller still thinks there is a pending unserviced
>> level interrupt because it latched it earlier. This behavior causes
>> software to see an extra interrupt for level type interrupts each time
>> the interrupt is handled.
>>
>> Let's fix this by clearing the raw status enable bit for level type
>> interrupts so that the hardware stops latching the status of the
>> interrupt after we ack it. We don't do this for edge type interrupts
>> because it seems that toggling the raw status enable bit for edge type
>> interrupts causes spurious edge interrupts.
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-msm.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 0e22f52b2a19..3563c4394837 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -626,6 +626,19 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>>       raw_spin_lock_irqsave(&pctrl->lock, flags);
>>
>>       val = readl(pctrl->regs + g->intr_cfg_reg);
>> +     /*
>> +      * Leaving the RAW_STATUS_EN bit enabled causes level interrupts that
>> +      * are still asserted to re-latch after we ack them. Clear the raw
>> +      * status enable bit too so the interrupt can't even latch into the
>> +      * hardware while it's masked, but only do this for level interrupts
>> +      * because edge interrupts have a problem with the raw status bit
>> +      * toggling and causing spurious interrupts.
>> +      */
>> +     if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
>> +             val &= ~BIT(g->intr_raw_status_bit);
>> +             writel(val, pctrl->regs + g->intr_cfg_reg);
>> +     }
>> +
>>       val &= ~BIT(g->intr_enable_bit);
>>       writel(val, pctrl->regs + g->intr_cfg_reg);
>>
>> @@ -647,6 +660,10 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
>>       raw_spin_lock_irqsave(&pctrl->lock, flags);
>>
>>       val = readl(pctrl->regs + g->intr_cfg_reg);
>> +     if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
>> +             val |= BIT(g->intr_raw_status_bit);
>> +             writel(val, pctrl->regs + g->intr_cfg_reg);
>> +     }
>>       val |= BIT(g->intr_enable_bit);
>>       writel(val, pctrl->regs + g->intr_cfg_reg);
>
> I looked at the TLMM documentation, which states that the status bit
> should be cleared after handling the interrupt and this driver used to
> do this.
>
> But Timur managed to hit the race where we lost edge triggered
> interrupts with this behavior, so we changed it in the following commit:
>
> a6566710adaa ("pinctrl: qcom: Don't clear status bit on irq_unmask")
>
>
> But the reason that I had this in the driver originally is that msm-3.10
> does this (clear status bit in unmask), so perhaps the appropriate way
> to solve is to follow the documentation and the downstream driver and
> ack the interrupt in unmask - but do so only for level triggered
> interrupts?

LOL.  Stephen and I had an offline discussion about this and acking in
the unmask was my preferred solution too.  It matches what I did to
solve the same problem on a different controller back in 2013.  See
commit 5a68e7a748c0 ("pinctrl: exynos: ack level-triggered interrupts
before unmasking").  Stephen was of the opinion that it was cleaner to
fully disable the interrupt and that the "ack on unmask" was a bit of
a hack.  I figured that both worked OK and so I didn't insist.

Anyway, either is fine with me w/ a slight personal preference to
acking in unmask.

-Doug
