Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DED216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeEXJ2YR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DED216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeI1NeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:34:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46988 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeI1NeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:34:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id q12-v6so3201114qkl.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbsWzxjn8YN7UoqimGhYote4Mv6wIAFnYdM/m/T7Q08=;
        b=GeEXJ2YRDEJe7nVdX7dD8JNFRzJD2LlrYKA3wqZgcJ/CCvldTOdEigEic/fim8aKqt
         Y5VfGGJObZmOS67jols8sy7wRfCmhGE2OOruXGEyVPC7QoyPCl+gn4w8rN5CvoUeyJoP
         WK5fpE3GaJ79aIcWlRgTlVGrvW6flKiLNTV6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbsWzxjn8YN7UoqimGhYote4Mv6wIAFnYdM/m/T7Q08=;
        b=XjqYm9yPyCASC4nToa+0xN/M4BNG1WKCpz+i48y8rjmXRGKxNci5tfh1eFV4iL5rRJ
         +G+HozEmRVGcKAgXNshaQrsrS9NOuUmKSfqNlPKvLk8z9NLyShrFjs9y34eg0oZgKlHt
         7pM5XhZctChLcv9GFhaf2mCBlxXdO+X7h7PtMh7P7UCNzia/Nm+Rcw/soWx8oA8gG3yN
         UF8cXUblKSqeJpSEgHW9+8wEEA3Gx8rXMdTBfl/j06ZzxoImkV57h34fDkGQMvKLEwae
         mSHf/dxkLwj56SyZvcRDA8MWyVZ1suAHiQoAzJR37ZOutUedr4I1OlyAQba587AJayGx
         Ok3w==
X-Gm-Message-State: ABuFfogoTQoLapXDeKymU/VmEbWKn583KvcA06jukjeGg5hvFC0oFChx
        jxdJy/ENu9oiRxXqKiU22b+sovEW422ZzW9228f+wA==
X-Google-Smtp-Source: ACcGV63557F/2a8kcKUZaxiaaZvy7pVJTrJIlsfTKZxz+SvBZZIxeUDkzVzPmhNUjepYDdAvowNUIyiBREzBjeBlWS4=
X-Received: by 2002:a37:d9c1:: with SMTP id q62-v6mr10917710qkl.117.1538118722065;
 Fri, 28 Sep 2018 00:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180924221748.21584-1-bjorn.andersson@linaro.org>
 <20180924221748.21584-2-bjorn.andersson@linaro.org> <CACRpkdaWboGvKVaSjv4C1CCz5DJXbB+ZWV6vGeyX93vb4zo1sw@mail.gmail.com>
In-Reply-To: <CACRpkdaWboGvKVaSjv4C1CCz5DJXbB+ZWV6vGeyX93vb4zo1sw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 09:11:50 +0200
Message-ID: <CACRpkdaxXz8=An-tQwhjnn2e3QwMbs=b6mE8BfL0HA8aeBjxKQ@mail.gmail.com>
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

On Fri, Sep 28, 2018 at 9:10 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> This clashes with Stephen Boyds fix:
> "pinctrl: msm: Really mask level interrupts to prevent latching"
>
> I've resolved it like this:

Also this:
static void msm_gpio_irq_unmask(struct irq_data *d)
{
    struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
    struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
    const struct msm_pingroup *g;
    unsigned long flags;
    u32 val;

    g = &pctrl->soc->groups[d->hwirq];

    raw_spin_lock_irqsave(&pctrl->lock, flags);

    val = msm_readl_intr_cfg(pctrl, g);
    val |= BIT(g->intr_raw_status_bit);
    val |= BIT(g->intr_enable_bit);
    msm_writel_intr_cfg(val, pctrl, g);

    set_bit(d->hwirq, pctrl->enabled_irqs);

    raw_spin_unlock_irqrestore(&pctrl->lock, flags);
}

Yours,
Linus Walleij
