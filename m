Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbeE3V1z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:27:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35468 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeE3V1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:27:52 -0400
X-Google-Smtp-Source: ADUXVKJpsMHhkwl2KRTpctxKnZK/2BzpJyaQNG1Sn6pHQqJAGbUIxvro3dhXtE2gYjegOFmGahy731f2F/4YOeYtnUU=
MIME-Version: 1.0
In-Reply-To: <20180514080640.12515-2-linus.walleij@linaro.org>
References: <20180514080640.12515-1-linus.walleij@linaro.org> <20180514080640.12515-2-linus.walleij@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 May 2018 23:27:50 +0200
X-Google-Sender-Auth: MpHrOI5Ge3nDceRZL8rkxEdv3Jg
Message-ID: <CAK8P3a2M_xzDcZUUXwzJgDGhfBUoPj0mJ5QiZpJhZ2JEM+YnMQ@mail.gmail.com>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO descriptor only
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:06 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:


> @@ -892,6 +902,7 @@ static void __init e680_init(void)
>
>         pxa_set_keypad_info(&e680_keypad_platform_data);
>
> +       gpiod_add_lookup_table(&camera_supply_gpiod_table);
>         pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
>         platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
>         platform_add_devices(ARRAY_AND_SIZE(e680_devices));
> @@ -1098,7 +1109,7 @@ static struct i2c_board_info __initdata a910_i2c_board_info[] = {
>
>  static struct platform_device *a910_devices[] __initdata = {
>         &a910_gpio_keys,
> -       &camera_supply_dummy_device,
> +       &camera_supply_regulator_device,
>  };
>

This part is wrong and triggered a build warning: camera_supply_gpiod_table
should have been in a910_init(), not e680_init(). I sent a fixup with subject
"ARM: pxa, regulator: fix building ezx e680".

        Arnd
