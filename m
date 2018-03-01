Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966951AbeCAJ24 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:28:56 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:38636 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966904AbeCAJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:28:53 -0500
X-Google-Smtp-Source: AG47ELv0Saz6sG/ZbVZgDzKDrIJp/6CgfF2mojNk3UbDmztQCVEgcpY1iVIbhCwB54xsX8xj9GreKAmBtGTU3mCDxic=
MIME-Version: 1.0
In-Reply-To: <20180228134822.2194009-1-arnd@arndb.de>
References: <20180228134822.2194009-1-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 10:28:52 +0100
Message-ID: <CACRpkdajRp6PKYzMyeV81tu4dZxhnEDv7cKBvSCsNOUdW24KpQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: raspberrypi-ext: fix firmware dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Baruch Siach <baruch@tkos.co.il>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 2:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When the firmware driver is a loadable module, the gpio driver cannot be
> built-in:
>
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_set':
> gpio-raspberrypi-exp.c:(.text+0xb4): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get':
> gpio-raspberrypi-exp.c:(.text+0x1ec): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_direction':
> gpio-raspberrypi-exp.c:(.text+0x360): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_get_polarity':
> gpio-raspberrypi-exp.c:(.text+0x4d4): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_out':
> gpio-raspberrypi-exp.c:(.text+0x670): undefined reference to `rpi_firmware_property'
> drivers/gpio/gpio-raspberrypi-exp.o:gpio-raspberrypi-exp.c:(.text+0x7fc): more undefined references to `rpi_firmware_property' follow
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_dir_in':
> drivers/gpio/gpio-raspberrypi-exp.o: In function `rpi_exp_gpio_probe':
> gpio-raspberrypi-exp.c:(.text+0x93c): undefined reference to `rpi_firmware_get'
>
> We already have a Kconfig dependency for it, but when compile-testing, it
> is disregarded.
>
> This changes the dependency so that compile-testing is only done when the
> firmware driver is completely disabled.
>
> Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Baruch, are you waiting for a fixed fix or should I apply this?

It's a bit unclear from the mail chain what action I should take...

Yours,
Linus Walleij
