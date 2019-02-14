Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C376C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684A2222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCSov9E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406165AbfBNIAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:00:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37311 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393767AbfBNIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:00:46 -0500
Received: by mail-lf1-f67.google.com with SMTP id n23so3844435lfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+L0uutjU0v77oZKF4hFog6fNq1jSpgLPOCZjedtCco=;
        b=iCSov9E2bQXkxP36zv4os/WDjwAfqs6XUhG75IYQU0p4p8NaPLou0+WJYlZ2aR50nI
         nVUaj5lAR4YBfPErtwvaLue5BIsbWWCri1Fv9kT244izFGVcZ8tzcUz8K2dgl2uhd7Pd
         8s5zWCCAP2PXD5Tj5di0Ee7Ds+Y64LL82bX5xRkYqcZePWpZwDLXf9GdnRdhk7GisuP8
         Pgg4d9Qk8Ssbb/Ok2g5Jx9TReTr48sUkuSYLq9yxzDd1WNzcy895XAfBgMMizho3tr4d
         2TvITrbH5oHKKDsWHL7tYgcCAg10/3qlXYL3Hu/NZSwoHS0rrrvLCD+2AlVgdqu51MCy
         b66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+L0uutjU0v77oZKF4hFog6fNq1jSpgLPOCZjedtCco=;
        b=U3wVo18Bd7hr00hPIRAFlXm1SkjjbLceoEgseTfF/pk5FXtYm8EfWB+TjtjU3IiHN6
         6viSYRoQgjsgjgw6QGlcmZXawbIyB+yL9BXTrtrmeO1ZI2iR3hSnn2yk7vM0TLo4uVPm
         A+KWh54ct+l2CsswMXXMN03zqc1u4W9MO165Z6nvIXoTYRF+UdSgFuNsUShizqRrT7CF
         +Cvt47x1zMC24rMN5tqYzYfJHmbtDqHF00RxpQKTNgkdPlXT7iPEz6XavOjUmv7DNUYG
         v/o2HdV/GPgOh2lqGNGaJmG79Up1VMRqA/lJ0QWctL1v80IvUprASJF3mkLifzuqUdnx
         0pKw==
X-Gm-Message-State: AHQUAuZPLrLoVx0vBL1NVGrNLP8o9EVrnyBbXtUIucnu71RqaSt9H2vB
        SkPMuR8WhF5g805AS2MdBVKJLXwsXYiQvUx6KaWUxg==
X-Google-Smtp-Source: AHgI3IapfV1/YDbAnxxptRM2o7gNF3qGLxevZNy2Vi8LGAnuaJACKbLArrBvLRuxMxzWdmXJTbCFerVaKnDwqQFj2tA=
X-Received: by 2002:a19:5209:: with SMTP id m9mr1375265lfb.51.1550131244554;
 Thu, 14 Feb 2019 00:00:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com> <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 09:00:33 +0100
Message-ID: <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] gpio: Initial support for ROHM bd70528 GPIO block
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        bogdan-petru.chircu-mare@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 2:34 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> controlled by GPIO framework.
>
> IRQs are handled by regmap-irq and GPIO driver is not
> aware of the irq usage.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

(...)

Just spotted this:

> +#include <linux/gpio/driver.h>
> +#include <linux/gpio.h>

A driver should only need <linux/gpio/driver.h>
the <linux/gpio.h> should not be used at all in new code,
it is a legacy header.

> +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> +                                  unsigned long config)
> +{
> +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> +
> +       switch (pinconf_to_config_param(config)) {
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +               return regmap_update_bits(bdgpio->chip.regmap,
> +                                         GPIO_OUT_REG(offset),
> +                                         BD70528_GPIO_DRIVE_MASK,
> +                                         BD70528_GPIO_OPEN_DRAIN);
> +               break;
> +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> +               return regmap_update_bits(bdgpio->chip.regmap,
> +                                         GPIO_OUT_REG(offset),
> +                                         BD70528_GPIO_DRIVE_MASK,
> +                                         BD70528_GPIO_PUSH_PULL);
> +               break;
> +       case PIN_CONFIG_INPUT_DEBOUNCE:
> +               return bd70528_set_debounce(bdgpio, offset,
> +                                           pinconf_to_config_argument(config));
> +               break;
> +       default:
> +               break;
> +       }
> +       return -ENOTSUPP;
> +}

BTW I just merged code from Thomas Petazzoni that make it possible to
also support pull-up and pull-down from GPIO here if you want to enable
it.

Yours,
Linus Walleij
