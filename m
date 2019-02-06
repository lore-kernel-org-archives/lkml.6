Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA24DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4972186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjoUcfkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfBFNIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:08:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45858 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfBFNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:08:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so5241326lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO8ECOXVmpCQTguOMMVFY1LWo4CRrL0NRpfp3Fidfms=;
        b=MjoUcfkgn8mudz3phLrO/rIp+jp4dkicHRiOkSt2DNz0KFtCkWbagVfNdY5o2UxGUj
         JRAw9X/87TMZz3EB8RtOxA013fsRMt5VJPIJwsO23NJ5MTaL4JV71jHwGUJcecsUrTdS
         tvvxi/MMmdFEysObFZzMWCkc6AKHBfxF92Ameyml+rm1KvP2HqaSHdu8m5dQegX6F0Uv
         eYQJvlz4OdrEvUptVx8Pif41Y2GTXJx4+HzprzkWagEHkEXppa75XC1JW32GFqTTMYcj
         +uv9gx7P+iswc5rnMWkjyeOsytyDYfnpbOsQlq6r4NOvX7PGTMQ3S4x6PJ4gHSCc66SK
         sa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO8ECOXVmpCQTguOMMVFY1LWo4CRrL0NRpfp3Fidfms=;
        b=Z1zcWuAXKavM1GAjHIQRXRWrdCfUr/U+uTCvMsDkFGvbfgiUp1Wr2rftGm0iW5CJLE
         aPSwhAUmPYijWOZhimJ7IFkkXklVooJ3q61fTfyEGfsxdbqScQ0apvY7y0MWpbfmAlr8
         TE264Yjb5AUkiWvL6OZxQBSvOBnaUU2DUBqjBPbQv5CIhVoK7Cfrppb7z+HuExH+w7nK
         1Wfh1L2rJZF//qXF39suNtsEYbNS7KRQ0y/7QurWW1t7yhU1F1RtfUxaN2PKUeHKy9Za
         GOi8PO1qfvEyMrhhdD2iueNDonCKDi2Brt14H9kv2RMyegUxL3D6z1HfzlekY5zSiyDp
         YRoQ==
X-Gm-Message-State: AHQUAuY0uuj3ys82wuU+j4yhvYCSDZmdN+QlTmrZH9r98q4y8u1qPAO7
        g+HRn61KbWmrvIEa6711D2hfsBGPA8+EiT1+gWNhlA==
X-Google-Smtp-Source: AHgI3IYp+ia7omXyLV7gOqDz6m2ZL4eTD9/l6MOlma+iJwNlEM8ys3V51XmfyGEVNcN6zUfZo5ONSVlWqRhzPCcvkOY=
X-Received: by 2002:a19:f607:: with SMTP id x7mr6355892lfe.51.1549458484380;
 Wed, 06 Feb 2019 05:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20190125162302.14036-1-masneyb@onstation.org> <20190125162302.14036-4-masneyb@onstation.org>
In-Reply-To: <20190125162302.14036-4-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 14:07:52 +0100
Message-ID: <CACRpkdZMe+JEQOa1yBfOoAErrC41Q9rggwxNb=_uwq1m2QKWyw@mail.gmail.com>
Subject: Re: [PATCH 3/9] mfd: pm8xxx: convert to v2 irq interfaces to support
 hierarchical IRQ chips
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian!

I found one more bug in this patch, still not the last bug but I'm still
digging around:

On Fri, Jan 25, 2019 at 5:23 PM Brian Masney <masneyb@onstation.org> wrote:

> +struct pm_irq_data {
> +       int num_irqs;
> +       struct irq_chip *irq_chip;
> +       void (*irq_handler)(struct irq_desc *desc);
> +};
> +
>  struct pm_irq_chip {
>         struct regmap           *regmap;
>         spinlock_t              pm_irq_lock;
>         struct irq_domain       *irqdomain;
> -       unsigned int            num_irqs;
>         unsigned int            num_blocks;
>         unsigned int            num_masters;
>         u8                      config[0];
> -};
> -
> -struct pm_irq_data {
> -       int num_irqs;
> -       const struct irq_domain_ops  *irq_domain_ops;
> -       void (*irq_handler)(struct irq_desc *desc);
> +       const struct pm_irq_data *pm_irq_data;
>  };

This doesn't work: the config[0] must be the tail element
of the struct since we allocate dynamically the trailing
config[] bytes.

As it looks now, the *pm_irq_data gets overwritten by
the configs and it crashes.

Yours,
Linus Walleij
