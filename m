Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1EEC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C7F213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFI+7rly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C7F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJINtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:49:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54290 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeJINtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:49:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so581745wma.4;
        Mon, 08 Oct 2018 23:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2Hw+kRVc7h4aPm4XNxXTXYYQHPQcFTfCROAnfJL5CA=;
        b=mFI+7rlyCPW63rGjNVAy3xE4jd69CJROhWDVFHFOgtQlcdkXHe+Umj81t1GiXlR7JT
         tgSwiWg3CRGoKThMi9kQfW6XO4/ELiEVlB7WdIjiOsZQ8pMQB4g8MnZA8jOWSw7PsqFM
         u6TOEUKbK7Isf1w9zCPo4Tjn+KVkix72LEiyYMNBWnDDEbB4KwsZj4iP8sh04Y1JfjS7
         ey5stjyNqJ+dh+3yl3edJww75C6nf+yAZHncrjAeeEJEzmaGoRIIYTjB3nNsDcyjdkm+
         zms1lwFFfVXSwRBZy0UvoFweb81FDFQGRDQn0LrvKoESO5iQLtZfFtlPwSoR3Jfi68fk
         k2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2Hw+kRVc7h4aPm4XNxXTXYYQHPQcFTfCROAnfJL5CA=;
        b=Af6seAvu27aAfKf0ZX0K5P3TgjCafu7CywH7S1eKBTEwWGzwtYGsNlr8s+u538KDzN
         yrwyTCeYyjGi3iMC1/vgdFBi5Q+rN2GdfP3F6crO/osw6W9WU5jRX48K/X2XCl9aRvfl
         t2mnEenSe2Gh6aibLwaYY0O9hcn7YV533xLoqPNHefyTko3sSClXaSWJijustNCwS+mk
         DgB+9LS3vW8Jp36822YQQJBo7nqzYxhW6h/3rqM7g0CxSNRwaU+iwAk/N+Y4tldcYC9x
         U/n/8GllleBsAPXq5PnW19HZq11MLVA2bA0zU0Zz+o2hQIIqoUEmZgsFh4h2oWwZP6Zf
         K2mg==
X-Gm-Message-State: ABuFfoiTTPDz/+Hj1oyVzUMyuA18srZmY195KIUPREC+EKPzvJSABg3F
        uLWwXxaRg16UqgkD2OXWw3w=
X-Google-Smtp-Source: ACcGV63gr90YKMgzPCWqKH5n1RkcJmrvIlcXTyoc3ee7WnoVEbNT12CrG5ZwEQnWh9+7m+TDFFGXeg==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr800925wmd.100.1539066821092;
        Mon, 08 Oct 2018 23:33:41 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u76-v6sm25328508wmd.10.2018.10.08.23.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:33:40 -0700 (PDT)
Date:   Mon, 8 Oct 2018 23:33:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts
 to prevent latching
Message-ID: <20181009063338.GA22218@flashbox>
References: <20181008175530.864641368@linuxfoundation.org>
 <20181008175536.405502473@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008175536.405502473@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:31:34PM +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Stephen Boyd <swboyd@chromium.org>
> 
> [ Upstream commit b55326dc969ea2d704a008d9a97583b128f54f4f ]
> 
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
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -577,6 +577,29 @@ static void msm_gpio_irq_mask(struct irq
>  	spin_lock_irqsave(&pctrl->lock, flags);
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
> @@ -598,6 +621,7 @@ static void msm_gpio_irq_unmask(struct i
>  	spin_lock_irqsave(&pctrl->lock, flags);
>  
>  	val = readl(pctrl->regs + g->intr_cfg_reg);
> +	val |= BIT(g->intr_raw_status_bit);
>  	val |= BIT(g->intr_enable_bit);
>  	writel(val, pctrl->regs + g->intr_cfg_reg);
>  
> 
> 

Sigh, sorry, I caught this after I sent my initial all good email but
this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
apps that want to use it ask to enable it). I can't say why, I'm more
than happy to debug but I'm assuming it's some voodoo that Qualcomm has
done out of tree. I'll leave it up to you how to proceed given that I
can't run mainline :(

Nathan
