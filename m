Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B639C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED54621722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOEkX2IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED54621722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbeHUDAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 23:00:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37453 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHUDAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 23:00:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so14315029wrr.4;
        Mon, 20 Aug 2018 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z232VfbLRmE5HjKCQ97d98g/77/batkRj+02M7hpQb0=;
        b=fOEkX2INJujA2IlBUu5MZTEZffmi7d6K1Yxwwp51JpLZah9ms7OYKk0ABRsYUFJwx6
         h0kX+58UwQC96+1ZjTi0/oEfOzLPYMisdD9XgIR0w27tUuMRlOcIDnYIjk+lGtah+c3Q
         LItffFPbembUcrAc6BjJclPiLSl1sTbWV4872gHif4UtBC3TkY8Y2aZyRsl4zT0QNyxV
         4SEk0d/w1tHx/JxU9O/P0EJI8LqkIQwCaf9dV7CgHK05trMlCZMBAc7kE/guJ7vkeqgL
         ZhYXz7+XMmPvj1nig4BhcmPkK+pD910r478C9bjawhSFMhtN1pw+pasa7d/OlS3/zB2/
         Xh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z232VfbLRmE5HjKCQ97d98g/77/batkRj+02M7hpQb0=;
        b=RQhtku1Vfp4Z70P5G8p4UYIMnI5SwSx+nN0LAI26Dq+2DLegjPxP6xJGWlicGdtq7N
         oPhjqb9wjRl+XX+FG6+Z/i5V9xF+VJ9i2Q3PvuM1b3xlRLmI/DaXGe6++F94GdicWJSX
         RGKKUlUGd8O2tvvvo5VSFvr1MC3I7JLEIuEnP0hymiEeElwRUrDWF14kpZvcibalS9sQ
         KCE1jZaoVcXgaL7R7ZicUg5UT+eropGB4ggbpGWUw4n1QOr0h6zjwXvcuZD72a8d9uJ8
         JYRPXaxPf2VgnlqEf3TuQBSA2s6vBeEBcuGPgQM3YsSv6jzcJI3ePHVle/sqLLon8WgZ
         BYaQ==
X-Gm-Message-State: APzg51Bgi5mPP0xpzbXmZgnbNwdqDkBEk0Y0qFz4heSomAd0lQnpKsPE
        ApX1ipNhKFo3xqNvrjMG484=
X-Google-Smtp-Source: ANB0VdbL19B0KRKludGiuST4eMe0NsLP0iedp1SZZT28AyxfQ9p/I3FTysrwIqS/wFzVmmeDPMK/Lg==
X-Received: by 2002:a5d:4fc3:: with SMTP id h3-v6mr1471369wrw.261.1534808570275;
        Mon, 20 Aug 2018 16:42:50 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1197634wmg.45.2018.08.20.16.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 16:42:49 -0700 (PDT)
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
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC RFT PATCH 0/4] gpiolib: speed up GPIO array processing
Date:   Tue, 21 Aug 2018 01:43:37 +0200
Message-Id: <20180820234341.5271-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series is a follow up of the former "mtd: rawnand: ams-delta: Use
gpio-omap accessors for data I/O" which already contained some changes
to gpiolib.  Those previous attempts were commented by Borris Brezillon
who suggested using GPIO API modified to accept bitmaps, and by Linus
Walleij who suggested still more great ideas for further immprovement
of the proposed API changes - thanks!

The goal is to boost performans of get/set array functions while
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


 Documentation/driver-api/gpio/board.rst     |   15 +
 Documentation/driver-api/gpio/consumer.rst  |   48 +++-
 drivers/auxdisplay/hd44780.c                |   64 +++---
 drivers/bus/ts-nbus.c                       |   25 --
 drivers/gpio/gpio-max3191x.c                |   23 +-
 drivers/gpio/gpiolib.c                      |  279 ++++++++++++++++++++++------
 drivers/gpio/gpiolib.h                      |   15 +
 drivers/i2c/muxes/i2c-mux-gpio.c            |    5 
 drivers/mmc/core/pwrseq_simple.c            |   15 -
 drivers/mux/gpio.c                          |    7 
 drivers/net/phy/mdio-mux-gpio.c             |    5 
 drivers/pcmcia/soc_common.c                 |   14 -
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   21 +-
 drivers/staging/iio/adc/ad7606.c            |   12 -
 drivers/tty/serial/serial_mctrl_gpio.c      |    9 
 include/linux/gpio/consumer.h               |   35 ++-
 16 files changed, 410 insertions(+), 182 deletions(-)

