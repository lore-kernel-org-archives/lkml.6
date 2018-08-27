Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87AF2152E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrtOu6Iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87AF2152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeH0Gq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:46:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39397 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeH0Gq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:46:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so3472750plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vn/sueEXlDG6TAs/DSlJ4uHiMKebwBJrqHfStchyCO8=;
        b=KrtOu6IvEsR5t5j7/cAGC7Wuz5FMqGbKfKkx0uRRuD5g5i+0GMhswvcznIBq/N1CKf
         H9AtfWmlx+3QmyjXllGuwQim40rVdDNwcuAtZXDTeFMMhA7G3X99fGwvRLzlINqTWnWS
         PANVbmx0tSk+CEcXarcv/xdVs4gm8oBinVvVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vn/sueEXlDG6TAs/DSlJ4uHiMKebwBJrqHfStchyCO8=;
        b=aWh1ab4sTu4Z/Eo53UeJhputOdNbntrf3ftTjH2S+6Gz6Z4YfS1Hu0PWdQaBOH7qrz
         AbbBPXgqsAy5o48KN9cFRHAgaYD1KxlOjzQ8FWGDeUmPP8FxKhe2ebN6Xfqm+hbXlazu
         8FN/uFzt5mN6S3ogDiCjQz8SvAYc32mH6of7jlszb+XXbotyEu2DrDKT8ESh/ERknYp2
         aoNaPShdVFfCcEhYS6ngw7w+dC3H3tw9iYL3RUtDj4ekzpwXX2is4HSw31bP976R4Eeo
         AsjnkQW8ajSXP4HOKaXHH0DI/lpLsiQcbhJq2nzcTMTyrWxDLRLtcTNf+We4PzcleYic
         NthA==
X-Gm-Message-State: APzg51AvfIpqQONFD+8tpX+Fedom3agV74tpNMi2/sqU4hSmdtmR3B8J
        mx0Kb1V5QqZ0aJQAlJjNErn4eA==
X-Google-Smtp-Source: ANB0VdZ+VHmaCF+HTpA13Wy42rUZLDtZBS1P1WXpzBXUGlqcGlwCvUM5vzCTlaQ+1qneYt3ujt1xPA==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr11126659plf.320.1535338908822;
        Sun, 26 Aug 2018 20:01:48 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z11-v6sm19681362pff.162.2018.08.26.20.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 20:01:48 -0700 (PDT)
Date:   Sun, 26 Aug 2018 20:05:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/3] pinctrl: msm: Really mask level interrupts to
 prevent latching
Message-ID: <20180827030526.GH3048@tuxbook-pro>
References: <20180816200648.90458-1-swboyd@chromium.org>
 <20180816200648.90458-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816200648.90458-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Aug 13:06 PDT 2018, Stephen Boyd wrote:

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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 2155a30c282b..5d72ffad32c2 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -634,6 +634,29 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = readl(pctrl->regs + g->intr_cfg_reg);
> +	/*
> +	 * There are two bits that control interrupt forwarding to the CPU. The
> +	 * RAW_STATUS_EN bit causes the level or edge sensed on the line to be
> +	 * latched into the interrupt status register when the hardware detects
> +	 * an irq that it's configured for (either edge for edge type or level
> +	 * for level type irq). The 'non-raw' status enable bit causes the
> +	 * hardware to assert the summary interrupt to the CPU if the latched
> +	 * status bit is set. There's a bug though, the edge detection logic
> +	 * seems to have a problem where toggling the RAW_STATUS_EN bit may
> +	 * cause the status bit to latch spuriously when there isn't any edge
> +	 * so we can't touch that bit for edge type irqs and we have to keep
> +	 * the bit set anyway so that edges are latched while the line is masked.
> +	 *
> +	 * To make matters more complicated, leaving the RAW_STATUS_EN bit
> +	 * enabled all the time causes level interrupts to re-latch into the
> +	 * status register because the level is still present on the line after
> +	 * we ack it. We clear the raw status enable bit during mask here and
> +	 * set the bit on unmask so the interrupt can't latch into the hardware
> +	 * while it's masked.
> +	 */
> +	if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
> +		val &= ~BIT(g->intr_raw_status_bit);
> +
>  	val &= ~BIT(g->intr_enable_bit);
>  	writel(val, pctrl->regs + g->intr_cfg_reg);
>  
> @@ -655,6 +678,7 @@ static void msm_gpio_irq_unmask(struct irq_data *d)
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = readl(pctrl->regs + g->intr_cfg_reg);
> +	val |= BIT(g->intr_raw_status_bit);
>  	val |= BIT(g->intr_enable_bit);
>  	writel(val, pctrl->regs + g->intr_cfg_reg);
>  
> -- 
> Sent by a computer through tubes
> 
