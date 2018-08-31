Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370EAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66D720842
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdsw4efq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66D720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIADFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:05:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35601 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeIADFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:05:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id q13-v6so11159574lfc.2;
        Fri, 31 Aug 2018 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xZQjF2wUZU1Wu5F/h+ur4D4/urcXADQiqQlR+w8e6QA=;
        b=Sdsw4efq5usJ7S64Sh+zhugjlc9XLh5d2obJMr8HGYpByiCxWh8dN6Jow32PBFrucT
         5PGulZe6gXrA5lLFyvJ2P949AY853CNfezS9P9i6vKf8ijjWv+dELdoUsGinua9G59JF
         s03wpkiP2OyiHfBxcPuIR8slvJsRH6p8wxK51Pl+XDR4svFuPn4J9mgDPhCltD2n3cp7
         9ST2oNwuMmJ4mK2rsI7zKX9L5LrGszMLdOhNOmtv3zRu9fgOPwPhVt2bNka/qUpjMOwQ
         EYrdyOGpgOXQX1O7yKYEAfUzre5tH//rrDeY/UTg5FdEWkrPk/qEM7Uyo3Xcr8yK1JU+
         sIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xZQjF2wUZU1Wu5F/h+ur4D4/urcXADQiqQlR+w8e6QA=;
        b=hZO7hTFOGvRYCiwjOvGsOrSUWVGRKb1gOerqTFNYPutwmJS3yJoYV3YqGfKn5dGdSm
         nQVW8nWof3rNSfkfKfi4MR6I9wMrQrHB2cc4YvbhEy0YKh9pMKd+uBFewcsQEyn9JIxx
         PO9O+r0xbuQL0ssgxzT2lC8CnPRfJYhCxVg7gQn8sjNEpHyGWnuVflXMNfMVnxPzVI/r
         Vku+cNCjACzYBeTqZ5sT7/iI7opDFUAsrpFNeIK6CSRNxF0R+Z4Vf5MLsnOAn9nk4ZF0
         KQ/YA9/shGzYOwwm31V/kZOWS6Dqfq1QSBr855sQn3fxXhUEk+H0lyYo9iVdNUbSEIbx
         ni/w==
X-Gm-Message-State: APzg51AVEIN+Qw66Iwjhesb1G8RSl+Z0i/zpG0jaf3K+eIKsJom2bN9v
        xArsCEf4V8wX+DYGIJeUXmg=
X-Google-Smtp-Source: ANB0VdY57FJ42BfVYAaeM+/vwZwB+6sD2j1EKR5m32Qf7HWDZYmjkBUg5SEdaL1Ts4h4BvwmezMvVw==
X-Received: by 2002:a19:f802:: with SMTP id a2-v6mr11328129lff.33.1535756121275;
        Fri, 31 Aug 2018 15:55:21 -0700 (PDT)
Received: from localhost.localdomain (apn-37-248-212-140.dynamic.gprs.plus.pl. [37.248.212.140])
        by smtp.gmail.com with ESMTPSA id v20-v6sm1969187ljc.94.2018.08.31.15.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 15:55:20 -0700 (PDT)
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
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATH v6 0/4] gpiolib: speed up GPIO array processing
Date:   Sat,  1 Sep 2018 00:56:12 +0200
Message-Id: <20180831225616.29221-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180829204900.19390-1-jmkrzyszt@gmail.com>
References: <20180829204900.19390-1-jmkrzyszt@gmail.com>
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
PIO is much better than before the optimization but still not quite
satisfactory.

Janusz Krzysztofik (4):
      gpiolib: Pass bitmaps, not integer arrays, to get/set array
      gpiolib: Identify arrays matching GPIO hardware
      gpiolib: Pass array info to get/set array functions
      gpiolib: Implement fast processing path in get/set array

Changelog:
v6:
[PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set
- use DECLARE_BITMAP() macro for declaring value_bitmap - great idea by
  David Laight, thanks!
drivers/auxdisplay/hd44780.c:
- simplify the code and adjust comments as recommended by Geert
  Uytterhoeven - thanks!,
drivers/i2c/muxes/i2c-mux-gpio.c:
- drop .values member of struct gpiomux - details prvided by Peter
  Rosin, thanks!, 
drivers/mux/gpio.c:
- drop .val member of struct mux_gpio - details prvided by Peter
  Rosin, thanks!,
drivers/net/phy/mdio-mux-gpio.c:
- drop .values member of struct mdio_mux_gpio_state and is processsing.

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
 drivers/auxdisplay/hd44780.c                |   74 +++----
 drivers/bus/ts-nbus.c                       |   27 +-
 drivers/gpio/gpio-max3191x.c                |   23 +-
 drivers/gpio/gpiolib.c                      |  279 ++++++++++++++++++++++------
 drivers/gpio/gpiolib.h                      |   15 +
 drivers/i2c/muxes/i2c-mux-gpio.c            |   16 -
 drivers/mmc/core/pwrseq_simple.c            |   15 -
 drivers/mux/gpio.c                          |   18 -
 drivers/net/phy/mdio-mux-gpio.c             |   13 -
 drivers/pcmcia/soc_common.c                 |   14 -
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   21 +-
 drivers/staging/iio/adc/ad7606.c            |   12 -
 drivers/tty/serial/serial_mctrl_gpio.c      |    9 
 include/linux/gpio/consumer.h               |   35 ++-
 16 files changed, 417 insertions(+), 217 deletions(-)

