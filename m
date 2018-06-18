Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B5C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADB620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AX+QQuWt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U0t55x1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADB620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936988AbeFRWnK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:43:10 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:32845 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936942AbeFRWnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:43:08 -0400
Received: by mail-ua0-f193.google.com with SMTP id m21-v6so11811725uan.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gi8PPYAeLM6dXpOaAixW4ja//m3cJj2ryIdQjuBTLNA=;
        b=AX+QQuWtKICxCHRSQrUGJNvqNpMT/ueQn7uhr0mfv9ygW2Xcj6JArynl3ZPGcd4nCL
         JXVGLK65L0/iJkNMLEE1T4QvVv4HYmdOrmz5CHtp6Cft4NPcCP3QEFvzR5mamofzciAt
         3FKAIvl9g8GQIWOngMye0rWcZlKhg0TluPnIRxFQ6GwB3AN7MfO5Day7nvjPeIRv2ySj
         osvhEV2HEplSG66LfP5sLls6f7KEgkJagL9JKyfp+Zj/45X/k1acOSzS7ofFh6kRPvt1
         srkqf/3/fLeEjkXzowvhsO4HlCtc+2S2IBl/l9pvK2F9qT7KHIH4sZACoAlSze3B/2WJ
         MoVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gi8PPYAeLM6dXpOaAixW4ja//m3cJj2ryIdQjuBTLNA=;
        b=U0t55x1Qaj/Ej8RJRxteZBjmoEAoRV8GfpAK3ScMrbbwI47lTkU+2rHdviuoKRoWdT
         mLeQd8OD7XwLAV3en/3BLkjKZhcX9QHdbXZDANyoHewjxzA+wcRnmegOfzyCro6WgpWP
         ZbDMNSwEsxveg9R74wGoCV+bl+HkPvkkTlt30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gi8PPYAeLM6dXpOaAixW4ja//m3cJj2ryIdQjuBTLNA=;
        b=bOMZVMqUHiyZNJT6xP2f2fAtGrcp99BkJDJr47ZwTxMjmwgFpQbZLcjgzt1xGblu2M
         4FkKVpim/d9j+68Q6UzNqU5Z0iEizVIwbiKD3uPhYUVUF+lnUEtyk16RIcP8ByUtivn1
         gRT5dAlPKA9XrptjIygCb7m0CcXv4wjcdCV/VNuEXxY6WIQtlRD/7jWkFQns6QzzVAqT
         zcn6eY42YQA3/u3WcyNqZUAb9Tn5I5Vvncm0YZPYV65RGf9F0g/kVJ+9B4zcwKhvaRu6
         GVrmTS7AhBjodjyEkc5bTPBwYE5UsWdP0GDntgkpYvocqzmGya07lXnawyOA2tDJ0YLr
         eQuA==
X-Gm-Message-State: APt69E1rU8ckk7NbouyH4tQ57kLPiFTPaeuJ6ZhOiE8MGElkQ56Xd/95
        1g5aCmDZLyAdOtqz2Gg/eAtd3lv9xqCwDrmUoct78Q==
X-Google-Smtp-Source: ADUXVKLnyGjvWEUCr/Z2GJkm5mmRlbN3w8Gtsm8QEEp+Mx50A1ai21LNWVLnKT1le5ilf3U7UlfO1uVHIRiFzOaTLrw=
X-Received: by 2002:a9f:3d21:: with SMTP id l33-v6mr8844571uai.135.1529361786929;
 Mon, 18 Jun 2018 15:43:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 15:43:06
 -0700 (PDT)
In-Reply-To: <20180618205255.246104-2-swboyd@chromium.org>
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jun 2018 15:43:06 -0700
X-Google-Sender-Auth: BjF8wPWAE3BlmWK3LffLMtv6qEc
Message-ID: <CAD=FV=WvsY_=Ko2QXvzmHOuy4O5Rh6+sRWZZOuSXyGC829ANag@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to prevent latching
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> The interrupt controller hardware in this pin controller has two status
> enable bits. The first "normal" status enable bit enables or disables
> the summary interrupt line being raised when a gpio interrupt triggers
> and the "raw" status enable bit allows or prevents the hardware from
> latching an interrupt into the status register for a gpio interrupt.
> Currently we just toggle the "normal" status enable bit in the mask and
> unmask ops so that the summary irq interrupt going to the CPU's
> interrupt controller doesn't trigger for the masked gpio interrupt.
>
> For a level triggered interrupt, the flow would be as follows: the pin
> controller sees the interrupt, latches the status into the status
> register, raises the summary irq to the CPU, summary irq handler runs
> and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
> interrupt, the interrupt handler runs, and finally unmask the interrupt.
> When the interrupt handler completes, we expect that the interrupt line
> level will go back to the deasserted state so the genirq code can unmask
> the interrupt without it triggering again.
>
> If we only mask the interrupt by clearing the "normal" status enable bit
> then we'll ack the interrupt but it will continue to show up as pending
> in the status register because the raw status bit is enabled, the
> hardware hasn't deasserted the line, and thus the asserted state latches
> into the status register again. When the hardware deasserts the
> interrupt the pin controller still thinks there is a pending unserviced
> level interrupt because it latched it earlier. This behavior causes
> software to see an extra interrupt for level type interrupts each time
> the interrupt is handled.
>
> Let's fix this by clearing the raw status enable bit for level type
> interrupts so that the hardware stops latching the status of the
> interrupt after we ack it. We don't do this for edge type interrupts
> because it seems that toggling the raw status enable bit for edge type
> interrupts causes spurious edge interrupts.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 0e22f52b2a19..3563c4394837 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -626,6 +626,19 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>         raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->intr_cfg_reg);
> +       /*
> +        * Leaving the RAW_STATUS_EN bit enabled causes level interrupts that
> +        * are still asserted to re-latch after we ack them. Clear the raw

As I understand it acking a level-triggered interrupt is not totally
sensible anyway. IMO the fundamental "brokenness" of the MSM pin
controller is that it's latching level-triggered interrupts in the
first place when it shouldn't be. Instead of latching level triggered
interrupts (and requiring an Ack), the controller should simply stop
asserting its interrupt when the level goes away (if you want, you can
think of this in your mind as the controller auto-acking its own
interrupt when the level goes away).

The reason things aren't more broken than they are is that the Linux
interrupt core still Acks level-triggered interrupts (it just does it
at the beginning instead of the end).  IMO this is not fundamentally
something that the Linux interrupt core needs to do, but it does it
anyway (maybe there are a bunch of interrupt controllers that still
need this even though it's strange?)

Of course, maybe someone can tell me that I'm wrong and everyone else
expects that level-triggered interrupts are fundamentally supposed to
be Acked but that they are only supposed to re-latch if they
transition away from their current level and then back again?


> +        * status enable bit too so the interrupt can't even latch into the
> +        * hardware while it's masked, but only do this for level interrupts
> +        * because edge interrupts have a problem with the raw status bit
> +        * toggling and causing spurious interrupts.

Even if there was no spurious interrupt it would be wrong to use
RAW_STATUS_EN for edge-triggered interrupts.  For edge-triggered
interrupts it's important to continue to latch assertions even when
masked.



> +        */
> +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> +               val &= ~BIT(g->intr_raw_status_bit);
> +               writel(val, pctrl->regs + g->intr_cfg_reg);

Do you know if it's important to do a 2nd write here, or could this be
combined with the next writel()?

> +       }
> +
>         val &= ~BIT(g->intr_enable_bit);
>         writel(val, pctrl->regs + g->intr_cfg_reg);
>
> @@ -647,6 +660,10 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
>         raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->intr_cfg_reg);
> +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> +               val |= BIT(g->intr_raw_status_bit);
> +               writel(val, pctrl->regs + g->intr_cfg_reg);

Same question about whether this could be combined with the next
writel().  ...although I could imagine that the answer might be
different for mask and unmask.

...if it can be combined, you can totally get rid of the "if" test and
always "OR" in the bit, right?


Despite the above comments, I'm in favor of this patch.  I'd be
curious about whether we can remove the two writel() calls, but I'd
only suggest the comments be changed if someone else agrees with me
about the fundamental nature of level-triggered interrupts with
regards to Acking.  :-P

-Doug
