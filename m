Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202FFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B705F2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jis1k8j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B705F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeIFCVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:21:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33044 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFCVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:21:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so7569604ljj.0;
        Wed, 05 Sep 2018 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hxCLv3C1oLbNegsgoZ12jQU9j+QmZm6/DKoXz9Sci8=;
        b=Jis1k8j6uTkZZy6HAK62tmAg/1SMvupz0uoqNanm4wXm+Bh4p5I8Zbdy+TtNys3VgL
         hCRaQHsX268EwkHlvGZ++i0X4/I7xpuE6Xwhm1vY+lPYlBvt9OEXyqbeVyWWn0wmeF9+
         Lj71BoSGKxpT5p5XTPJ1kH61i5Up12dtMlTxaGnf/Hk/oWz0d6+OR6tsv8cjfygv9pvb
         xIECq4G5+JH0Fsg4jnVK6Zz6RHxZFXy8IIeong51UT8v5TM6mP7jAihFh150BgbeJNkc
         cY0VPQXndmDXok5Ztld58ybIj2iHGD360JY4K5RcrzSUulxbyPAJbx7R2fYetQ4AZf5U
         75aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8hxCLv3C1oLbNegsgoZ12jQU9j+QmZm6/DKoXz9Sci8=;
        b=hbXmnUn3kJUAbba9pbVTCHsiFpeMmVz5N/j9TOEmSuYvn6FBAi/iucFE6xv2k91ps1
         ZuQqnUdxHSkioRubHSyrVelXipqFAHPQBJB91wkUBrsWgXeIv1L6XwOpmSHmto/ZQX98
         lwORPAd2Ee7mVQzCCMcVX9Lx5QDXW+eHjpK/tFfKximyJb1J/X/e9htekzFHttCVuYeq
         mh9vIxO6Pb+ab++VlP1P1tgd2ALmMI7V/aqCOxfOdQQz2f+oRIOOTrRGCDXt2etKAbWZ
         qRaSb6A/C7XlKuqeCjG/ATauA5kd1ZvUpiWlET42TzXOuShvF5k66cYTiM7I4Z/cwxb7
         60zA==
X-Gm-Message-State: APzg51B3HZ/JEDeJMg+9/LLilpUZFXNWeEc59FCFZ6Qu7Lbbfs62VvVG
        WYX1+deNj2TXDHDW6VbFnYY=
X-Google-Smtp-Source: ANB0VdYKzQWeox72vD01/a9lWeTkUiFMu+qjTnqm+aGOTmqR40ZoiasGo6uo534V1DrUzsgffK8Slw==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr24911017ljj.142.1536184149018;
        Wed, 05 Sep 2018 14:49:09 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id i2-v6sm491873lfa.78.2018.09.05.14.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 14:49:08 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/4] gpiolib: speed up GPIO array processing
Date:   Wed,  5 Sep 2018 23:50:04 +0200
Message-Id: <20180905215008.1649-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180902120144.6855-1-jmkrzyszt@gmail.com>
References: <20180902120144.6855-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The goal is to boost performance of get/set array functions while
processing GPIO arrays which represent pins of a signle chip in
hardware order.  If resulting performance is close to PIO, GPIO API
can be used for data I/O without much loss of speed.

Created and tested on a low end Amstrad Delta board with NAND driver
updated to use GPIO API for data I/O.  Performance degrade compared to
PIO is much better than before the optimization though not quite
satisfactory on my test hardware.


Janusz Krzysztofik (4):
      gpiolib: Pass bitmaps, not integer arrays, to get/set array
      gpiolib: Identify arrays matching GPIO hardware
      gpiolib: Pass array info to get/set array functions
      gpiolib: Implement fast processing path in get/set array


Changelog:
v8:
[PATCH v8 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set array:
- replace *values with values[0] where applicable - suggessted by Geert
  Uytterhoeven, thanks,
- drop !! from 3rd argument of __assign_bit() where applicable - suggested
  by Lukas Wunner, thanks,
drivers/gpio/gpiolib.c:
- s/bitnap/bitmap/ - catched by Lukas Wunner, thanks,
drivers/phy/motorola/phy-mapphone-mdm6600.c:
- assign ddata->status directly from bitmap, not an intermediate 'val'
  variable, now used only for debugging purposes,
include/linux/gpio/consumer.h:
- also update API of inline function replacements used if CONFIG_GPIOLIB
  is not defined - catched by kbuild test robot,
[PATCH v8 3/4] gpiolib: Pass array info to get/set array functions:
commit message:
- s/bulids/builds/ - catched by Geert Uytterhoeven, thanks,
drivers/gpio/gpiolib.c:
- add information on array_info arguments to array function descriptions -
  catched by kbuild test robot,
include/linux/gpio/consumer.h:
- also update API of inline function replacements used if CONFIG_GPIOLIB
  is not defined - catched by kbuild test robot.

v7:
- add more people to Cc: - authors and/or those who contributed most to
  the drivers in scope of the change,
[PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set:
- avoid VLAs, use data source type bit number as bitmap size if not
  constant - great recommendation by Peter Rosin, thanks,
- revert names of local variables declared with DECLARE_BITMAP() from
  'value_bitmap' to original names of value arrays they replace (but not
  'value_array') - inspired by Peter Rosin suggestion - thanks!
drivers/gpio/gpio-max3191x.c:
- use bitmap_alloc() to be more consistent with DECLARE_BITMAP() pattern
  used by other consumers,
drivers/phy/motorola/phy-mapphone-mdm6600.c:
- no need to mask unused bits of val before its assignment to bitmap,
  passing PHY_MDM6600_NR_CMD_LINES to gpiod_set_array_value() as array/
  bitmap size provides sufficient protection.

v6:
[PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set
- use DECLARE_BITMAP() macro for declaring value_bitmap - great idea by
  David Laight, thanks!
drivers/auxdisplay/hd44780.c:
- simplify the code and adjust comments as recommended by Geert
  Uytterhoeven - thanks!,
drivers/i2c/muxes/i2c-mux-gpio.c:
- drop .values member of struct gpiomux - details provided by Peter
  Rosin, thanks!, 
drivers/mux/gpio.c:
- drop .val member of struct mux_gpio - details provided by Peter
  Rosin, thanks!,
drivers/net/phy/mdio-mux-gpio.c:
- drop .values member of struct mdio_mux_gpio_state and its processsing.

v5:
[PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set
- drivers/i2c/muxes/i2c-mux-gpio.c:
  - drop assigment of values to struct gpiomux.values, as recommended
    by Peter Rosin - thanks!,
  - mark the .values member of the structure as obsolete,
- drivers/mux/gpio.c:
  - drop assigment of values to struct mux_gpio.val, also recommended
    by Peter Rosin - thanks!,
  - merk the .val member of the structure as obsolete,
- drivers/auxdisplay/hd44780.c:
  - fix incorrect bitmap size,
  - use >>= operator to simplify notation,
  both catched by Miguel Ojeda - thanks!,
- add Cc: clauses as well as Acked-by: collected so far.
[PATCH v5 2/4] gpiolib: Identify arrays matching GPIO hardware
- add Cc: clause.
[PATCH v5 3/4] gpiolib: Pass array info to get/set array functions
- add Cc: clauses as well as Acked-by: collected so far.
[PATCH v5 4/4] gpiolib: Implement fast processing path in get/set
- add Cc: clause.

v4:
That series was a follow up of the former "mtd: rawnand: ams-delta: Use
gpio-omap accessors for data I/O" which already contained some changes
to gpiolib.  Those previous attempts were commented by Borris Brezillon
who suggested using GPIO API modified to accept bitmaps, and by Linus
Walleij who suggested still more great ideas for further immprovement
of the proposed API changes - thanks!


diffstat:
 Documentation/driver-api/gpio/board.rst     |   15 +
 Documentation/driver-api/gpio/consumer.rst  |   48 +++-
 drivers/auxdisplay/hd44780.c                |   67 ++----
 drivers/bus/ts-nbus.c                       |   20 -
 drivers/gpio/gpio-max3191x.c                |   16 -
 drivers/gpio/gpiolib.c                      |  281 ++++++++++++++++++++++------
 drivers/gpio/gpiolib.h                      |   15 +
 drivers/i2c/muxes/i2c-mux-gpio.c            |   16 -
 drivers/mmc/core/pwrseq_simple.c            |   15 -
 drivers/mux/gpio.c                          |   16 -
 drivers/net/phy/mdio-mux-gpio.c             |   13 -
 drivers/pcmcia/soc_common.c                 |    9 
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   19 -
 drivers/staging/iio/adc/ad7606.c            |   12 -
 drivers/tty/serial/serial_mctrl_gpio.c      |    9 
 include/linux/gpio/consumer.h               |   59 ++++-
 16 files changed, 420 insertions(+), 210 deletions(-)
