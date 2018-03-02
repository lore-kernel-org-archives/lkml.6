Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423118AbeCBIr2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:47:28 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45212 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423104AbeCBIrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:47:25 -0500
X-Google-Smtp-Source: AG47ELuYOZK07l3Y4I2GrheFZYOT2Q4yq9RMCdkRlX5YYruv0tRrKdkySc7U4C5DIPna3D/eI9K7B4orNDy6iqdMMNc=
MIME-Version: 1.0
In-Reply-To: <20180228134822.2194009-1-arnd@arndb.de>
References: <20180228134822.2194009-1-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 09:47:25 +0100
Message-ID: <CACRpkdYFp3NJEa8efX6PC1t=9+fDmqmpMNcm2oL_uj-=vowNAg@mail.gmail.com>
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

Patch applied.

Yours,
Linus Walleij
