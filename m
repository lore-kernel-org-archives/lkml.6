Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A89C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47586216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRKv1eOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47586216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeI1NdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:33:08 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32814 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbeI1NdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:33:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id i10-v6so5621789qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugMDAi+++0a8OErs+jed8PkSuNvgHRBUmVtruH4QyIU=;
        b=MRKv1eOKVriHs7Bp9kPCrbRqAVBD7oIrznJNWUYXSiQa3v9Z80LpVxfTnn8t5MiDTq
         9p8YN3HzUx6U5DFy5aUBuR2xA9o9ykcHh2ZxYkVLvigQGRFqW99YFx0RxivBfRWrurql
         4RL4F03b+LA7oJgOx1Lkz1c8YYoaGUwJC9fwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugMDAi+++0a8OErs+jed8PkSuNvgHRBUmVtruH4QyIU=;
        b=B6lZc2P9VQ29vROMvjCeuZ4e9qq9nsYoZqX+CzIL3XZbx13/DJSsbgut2iyui29Z/R
         3ZgoooB1qkgC4loR3LpvzI4E9XSHebxnN0mI5Qbuwhmn/qHh4olAEKl4tBoNOqDfB5Cz
         d9XL+YfQFXXqrQpR+Bx2HLObDlu6a7rBtLXyKjcRtTsfkmACBYX6BPXGD7mWCtR6Tl1f
         twya/qUTOau8BeiTWHT/Osk7BCDjJhiE6isx2IwH7o+dq2jxtTCu6iWC1fW00Nc8VDcz
         W9fg8yzBa8jlgZamPeS79FiBwOcoYZ/NBKR/fqoe8dDe1jX0mLAjHKRaChEbPdSWB/Hv
         i8uQ==
X-Gm-Message-State: ABuFfohtw/kNJFAyg/QsQtOS8tfB2HQjL6JlJmHPTpnHj9lCoL8iwBrX
        Ok7/BDqJu/8jtFxNZgcyvs+OdLph1ObpC/my6VzcvQ==
X-Google-Smtp-Source: ACcGV63hlIOyFT9cuTSLHvIswlT81vDWMuRZq66gXDaVxvxoIC7jecO/AsQ5Z5ZEEZrq3lmI/HkALRM5KIIv+8cLsz0=
X-Received: by 2002:ac8:1793:: with SMTP id o19-v6mr11356439qtj.98.1538118647676;
 Fri, 28 Sep 2018 00:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180924221748.21584-1-bjorn.andersson@linaro.org> <20180924221748.21584-2-bjorn.andersson@linaro.org>
In-Reply-To: <20180924221748.21584-2-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 09:10:35 +0200
Message-ID: <CACRpkdaWboGvKVaSjv4C1CCz5DJXbB+ZWV6vGeyX93vb4zo1sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pinctrl: qcom: Introduce readl/writel accessors
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> In preparation for the support for dispersed tiles move all readl and
> writel calls to helper functions. This will allow us to isolate the
> added complexity of another indirection.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This clashes with Stephen Boyds fix:
"pinctrl: msm: Really mask level interrupts to prevent latching"

I've resolved it like this:

static void msm_gpio_irq_mask(struct irq_data *d)
{
    struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
    struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
    const struct msm_pingroup *g;
    unsigned long flags;
    u32 val;

    g = &pctrl->soc->groups[d->hwirq];

    raw_spin_lock_irqsave(&pctrl->lock, flags);

    val = msm_readl_intr_cfg(pctrl, g);
    /*
     * There are two bits that control interrupt forwarding to the CPU. The
     * RAW_STATUS_EN bit causes the level or edge sensed on the line to be
     * latched into the interrupt status register when the hardware detects
     * an irq that it's configured for (either edge for edge type or level
     * for level type irq). The 'non-raw' status enable bit causes the
     * hardware to assert the summary interrupt to the CPU if the latched
     * status bit is set. There's a bug though, the edge detection logic
     * seems to have a problem where toggling the RAW_STATUS_EN bit may
     * cause the status bit to latch spuriously when there isn't any edge
     * so we can't touch that bit for edge type irqs and we have to keep
     * the bit set anyway so that edges are latched while the line is masked.
     *
     * To make matters more complicated, leaving the RAW_STATUS_EN bit
     * enabled all the time causes level interrupts to re-latch into the
     * status register because the level is still present on the line after
     * we ack it. We clear the raw status enable bit during mask here and
     * set the bit on unmask so the interrupt can't latch into the hardware
     * while it's masked.
     */
    if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK)
        val &= ~BIT(g->intr_raw_status_bit);

    val &= ~BIT(g->intr_enable_bit);
    msm_writel_intr_cfg(val, pctrl, g);

    clear_bit(d->hwirq, pctrl->enabled_irqs);

    raw_spin_unlock_irqrestore(&pctrl->lock, flags);
}


Please check.

Yours,
Linus Walleij
