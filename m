Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D233F20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+3mblKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D233F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeFTGmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:42:54 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39999 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeFTGmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:42:51 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so1203208plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=46ha/2igrSnOqifWy8vCbL2YDY5vlGEcMXELa4bd2Rs=;
        b=T+3mblKNg50tSgAi+PEdnWctMT9Lue1S2DBb1w5XZ5geB6FQeS3aD+PDpfHu8qHAzP
         aG+1SlA/LIf5ALaU+zL5EUqb1AG6v4EuGkQ/cgu7xcopJbzGvU3FMXGlXHMoqDzenfl3
         qboY5BX3pFLQuAkLiPqfTJZoLZAE3ZpNvwAVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46ha/2igrSnOqifWy8vCbL2YDY5vlGEcMXELa4bd2Rs=;
        b=jOpPEn4cTYIrps4eYsyxSt1KrscrPK3KSm6uOEYVerjxM3GjJ1xD9y5YUBOsmhMUSX
         EvHN/eSd84lx/XI3WjjFSgb3bZo1LOYcanhn/3HAf0EZl3r9WLYYfn9qUQv7+7iDwLYj
         WXl7vauP+vBM2T2k9T0JTxsGLnqvKN1sr8JTefVTgACVzdsbr0mfiN6SB9/rEwWnErYi
         a7XNev0hMrq0cpxjcYkSG3S53EQHpyKfo3ZdiHKHZhrcu74JenOuqpdrVYPTSGki5q/S
         Z5dvBTj2/A42dooYqbOnTBalrXPDv2BZgrLxAdprf7DqEkGhQTIoyIrPjbPpbbCKbb+V
         TEXg==
X-Gm-Message-State: APt69E2dXbvoibfSB0U75e1A+F5JnEW0Y/cQOpl9SrjalSlxqrfePk9y
        rWNiyl9m1w2Kek+N7LNCPl+jpg==
X-Google-Smtp-Source: ADUXVKJ4TYMLJEBb4RMCQy6Mw+7Q8znkSu8ELbCcNCuSGeK7c6rzsz0XUiXwXN1z67iPcWQy4OL3aQ==
X-Received: by 2002:a17:902:6bca:: with SMTP id m10-v6mr22394512plt.6.1529476971159;
        Tue, 19 Jun 2018 23:42:51 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m21-v6sm1621805pgv.27.2018.06.19.23.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 23:42:50 -0700 (PDT)
Date:   Tue, 19 Jun 2018 23:45:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to
 prevent latching
Message-ID: <20180620064509.GL15126@tuxbook-pro>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618205255.246104-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:

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
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = readl(pctrl->regs + g->intr_cfg_reg);
> +	/*
> +	 * Leaving the RAW_STATUS_EN bit enabled causes level interrupts that
> +	 * are still asserted to re-latch after we ack them. Clear the raw
> +	 * status enable bit too so the interrupt can't even latch into the
> +	 * hardware while it's masked, but only do this for level interrupts
> +	 * because edge interrupts have a problem with the raw status bit
> +	 * toggling and causing spurious interrupts.
> +	 */
> +	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> +		val &= ~BIT(g->intr_raw_status_bit);
> +		writel(val, pctrl->regs + g->intr_cfg_reg);
> +	}
> +
>  	val &= ~BIT(g->intr_enable_bit);
>  	writel(val, pctrl->regs + g->intr_cfg_reg);
>  
> @@ -647,6 +660,10 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = readl(pctrl->regs + g->intr_cfg_reg);
> +	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> +		val |= BIT(g->intr_raw_status_bit);
> +		writel(val, pctrl->regs + g->intr_cfg_reg);
> +	}
>  	val |= BIT(g->intr_enable_bit);
>  	writel(val, pctrl->regs + g->intr_cfg_reg);

I looked at the TLMM documentation, which states that the status bit
should be cleared after handling the interrupt and this driver used to
do this.

But Timur managed to hit the race where we lost edge triggered
interrupts with this behavior, so we changed it in the following commit:

a6566710adaa ("pinctrl: qcom: Don't clear status bit on irq_unmask")


But the reason that I had this in the driver originally is that msm-3.10
does this (clear status bit in unmask), so perhaps the appropriate way
to solve is to follow the documentation and the downstream driver and
ack the interrupt in unmask - but do so only for level triggered
interrupts?

Regards,
Bjorn
