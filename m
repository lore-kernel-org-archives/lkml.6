Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B1086C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C76E208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhrRyjZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C76E208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeFNIqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:46:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39192 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeFNIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:45:59 -0400
Received: by mail-it0-f66.google.com with SMTP id p185-v6so7606126itp.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ICIgJhCgp6638ARAjh/M+gfA32sf5yYiUytOtitAcck=;
        b=XhrRyjZGiPWcFQAO7ZSUm1r0mUk3nxjTXjHlqHemsoMDEjn8deRDwtFcOA64sQ/nWg
         cqL/MqZf0TGS6lNMkEJcput9ttZe/SXHagAsYaKoW1oLO7Wow9ozuV2SCA1ddoKNB5z1
         p6qvqbifG5kLY85y8KeJCzu9+Wq3sgtSqFFKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ICIgJhCgp6638ARAjh/M+gfA32sf5yYiUytOtitAcck=;
        b=HFddmBWSqCzFWOEVwx/yfHIUBQ7TVh0Byi4ekOI1GM6QkVsru4zU/fC5kx0fpcLm8Q
         ZHKiaNtWjAx2Ya6y2tzUS4f5pIo7i/YO/ycCt7VpG+ZBBvvLtC/FRpEx24zogkewSL5r
         GItoOPtYSn0m1pate0DdtVZtYBCclETc/AyiWDJ7k48l9uHNlM2vYeIKpYTVnY9qfJ2t
         NaC/MrCwF29M4f6qR53FwgG8SO3/o1wPXKStTuB+9YgdMHedSGG+pRIt+Y1ia7/1d8pm
         yREdr2QSMXFXYVB8VyRxxV5MCk0uAI9UFY+hIeWqEbpkpxiyIjCpvJSajGErkQ19zQI9
         oO4A==
X-Gm-Message-State: APt69E1260n5x4Clju76M27j/BZ0sVwg21FBE05H3ctyiodI920wwuhn
        YATwYOAQL0ZQV2I50xJxueb1jJ63d8J8tE41dM0WEDNC
X-Google-Smtp-Source: ADUXVKKQUid4aQRnr60qr/iiRa1L718sML3emgWyQ3R1k4EylSN6CkwpHGoIObCwZI0XSEUfmR1LogQ5udafuK0MvEA=
X-Received: by 2002:a24:690f:: with SMTP id e15-v6mr1405061itc.70.1528965958760;
 Thu, 14 Jun 2018 01:45:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 01:45:57
 -0700 (PDT)
In-Reply-To: <20180609140224.32606-6-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com> <20180609140224.32606-6-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jun 2018 10:45:57 +0200
Message-ID: <CACRpkdZj0c+pY7u63SDcUK_i7pPQDkgCgsm2cc37H2uHjZjDFw@mail.gmail.com>
Subject: Re: [PATCH 06/10] ARM: OMAP1: ams-delta FIQ: don't use static GPIO numbers
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 4:02 PM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> With introduction of GPIO lookup tables to Amstrad Delta board init
> file, semantics of symbols representing OMAP GPIO pins defined in
> <mach/board-ams-delta.h> changed from statically assigned global GPIO
> numbers to hardware pin numbers local to OMAP "gpio-0-15" chip.
>
> This patch modifies deferred FIQ interrupt handler so it no longer uses
> static GPIO numbers in favour of IRQ data descriptors obtained at FIQ
> initialization time from descriptor of the GPIO chip with use of its
> hardware pin numbers.  The chip descriptor is passed from the board
> init file.
>
> As a benefit, the deferred FIQ handler should work faster.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Making the kernel a better place, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> +/*
> + * Some drivers may not use GPIO lookup tables but need to be provided
> + * with GPIO numbers.  The same applies to GPIO based IRQ lines - some
> + * drivers may even not use GPIO layer but expect just IRQ numbers.
> + * We could either define GPIO lookup tables then use them on behalf
> + * of those devices, or we can use GPIO driver level methods for
> + * identification of GPIO and IRQ numbers. For the purpose of the latter,
> + * defina a helper function which identifies GPIO chips by their labels.
> + */
> +static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
> +{
> +       char *label = data;
> +
> +       return !strcmp(label, chip->label);
> +}
> +
> +/*
> + * The purpose of this function is to take care of proper initialization of
> + * devices and data structures which depend on GPIO lines provided by OMAP GPIO
> + * banks but their drivers don't use GPIO lookup tables or GPIO layer at all.
> + * The function may be called as soon as OMAP GPIO devices are probed.
> + * Since that happens at postcore_initcall, it can be called successfully
> + * from init_machine or later.
> + * Dependent devices may be registered from within this function or later.
> + */
> +static void __init omap_gpio_deps_init(void)
> +{
> +       struct gpio_chip *chip;
> +
> +       chip = gpiochip_find(OMAP_GPIO_LABEL, gpiochip_match_by_label);
> +       if (!chip) {
> +               pr_err("%s: OMAP GPIO chip not found\n", __func__);
> +               return;
> +       }
> +
> +       ams_delta_init_fiq(chip);
> +}

This is some real stunt work isn't it.

We should really think about ways to get gpiolib more helpful for board
setups like this, but it seems complex.

Yours,
Linus Walleij
