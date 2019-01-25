Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3911BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D362184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfAYLB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:01:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45507 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:01:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so6605185lfa.12;
        Fri, 25 Jan 2019 03:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vDcc9rE4hmCM95tpj5K+bYvYQu10NrgI2SfNzGflwvQ=;
        b=YOS12tBBowAc3/MS8GqvE+A2pWfdSCKKv6G6x6Q2AyUUJ+HaDbOjcF6y7/072cq+A2
         2QvBLQhWGhFAMZ9JwXdmxGwOnsmJ18DezdFSGR9YEm7RuXFJx67QPs6xyTWJZH3sRpn5
         aInfrR7DWMb2A4n4mdKVWd/0+QLNTi1BywiVRCgkHyLZk3D7r8shSJdZRZEIGly0im4M
         hRtVw+w2H1sx4KEx27/wf2CIOQDPvkimGhUhJ050a7rGkT0IXT0bmiKu8sc4r2qRGiq8
         AqqQSbQZwG6FVKFpNai0PGBpeY3Huw3uLExKWLf2fcbNfyOp2CJFFU8DX0fiHqYtow69
         kxvg==
X-Gm-Message-State: AJcUukcVtrXs04nc1dqeYteFOgJMUtyfR7FIxbFgqTu3eDCT3mNM6HGl
        ebANxaR/xxlFw8w9nEdg8Sd5MnLFwmg=
X-Google-Smtp-Source: ALg8bN4V/HDQX4p8O9VT5ztZdyt0JqFV5DrqLDEY3hGu6hJt5NeDiJgHDoRx6AyzMQirCIKt8Qpfjg==
X-Received: by 2002:a19:d486:: with SMTP id l128mr8272405lfg.114.1548414083905;
        Fri, 25 Jan 2019 03:01:23 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y23-v6sm1456337ljk.95.2019.01.25.03.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:01:23 -0800 (PST)
Date:   Fri, 25 Jan 2019 13:01:10 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v2 00/10] support ROHM BD70528 PMIC
Message-ID: <20190125110110.GA29171@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series introducing support for ROHM BD70528 PMIC

Please note that patch 1 breaks compilation without patches 2 and 3

ROHM BD70528 is a programmable Power Management IC for battery
powered 'ultra low power' systems like the pre-announced NXP
i.MX7 ULP. This patch series introduces support for the PMIC.

I send this a RFC now as I would like to receive comments from
Lee, Mark and Stephen regarding splitting the existing
include/linux/mfd/bd718x7.h into ROHM generic and chip specific
portions. Benefit is that for example the clk sub-driver does
not need to be aware of chip specific structure(s) (struct
bd718x7 and struct bd70528) as it only needs to derefernce the
generic struct rohm_regmap_dev. Thus same clk subdriver can
support both the bd718x7 and bd70528 as long as MFD driver
data has this generic structure in the beginning of allocated
data. But knowing the bd718x7 driver is already in upstream,
it might be good if this change went through single tree, right?

RTC block of the bd70528 can support 'wake' irq which wakes PMIC
from standby state. Wake irq's can be armed to wake up system up
to 24 hours from arming. bd70528 can also generate alarm interrupts
which can be armed to occur years after triggering. The RTC driver
does always arm both the waker and alarm irqs and does not utilize
longer period of alarm interrupts. All the RTC timers are limited
to occur within the next 24 hours. Any suggestions on more elegant
timer support are welcome =)

GPIO portion of bd70528 driver adds I/O support for driving GPIO
pins or reading the state. The interrupt functionality is provided
by regmap-irq. Current GPIO driver is not aware of whether the pin(s)
are used for I/O or interrupts and it is up-to driver user to
ensure there is no misconfiguration or "double use".

Currently only MFD core, clk, RTC and regulator portions are
somehow tested. The RFC series also include initial gpio, power-supply
and watchdog patches in order to provide better overview on chip
and to collect initial feedback. Reset and ADC are not supported by
this series.

Changelog v2: Mainly feedback from Guenter Roeck:
- patches 1, 2, 3, 5, 7, 9 are unchanged.
- mfd: own mutex for each bd70528 instance - embed in struct bd70528
- watchdog: do not copy parent device data
- watchdog: fix deadlock caused by double locked mutex
- watchdog: set initial timeouts and WDT parent information
- watchdog: remove unnecessary ping function from ops
- watchdog: and the comment regarding it
- watchdog: allocate watchdog struct in order to allow multiple WDG
  instances
- rtc: bd70528 fix the order of mutex unlock and re-enabling RTC based
  timers
- rtc: fix the irq mask register address
- power: fix the irq mask register address
- regulator/regmap-irq: Drop the patches 1, 8 and 9 from original series
  as those were already applied by Mark 

Patch 1:
	split the bd718x7.h to generic and chip specific portions.
	(breaks compilation without patch 2 and 3)
Patch 2:
	adapt bd718x7.h changes to bd718x7 regulator driver
Patch 3:
	adapt bd718x7.h changes to bd718x7 clk driver
Patch 4:
	add MFD core support for bd70528
Patch 5:
	support bd70528 clk using bd718x7 clk driver
Patch 6:
	document DT bindings for BD70528
Patch 7:
	support BD70528 GPIO block
Patch 8:
	support BD70528 RTC
Patch 9:
	support BD70528 battery charger
Patch 10:
	support BD70528 watchdog

This patch series is based on Mark's regulator/for-next branch

---

Matti Vaittinen (10):
  mfd: bd718x7.h split to ROHM common and bd718x7 specific parts
  regulator: bd718x7 use chip specific and generic data structs
  clk: bd718x7: use chip specific and generic data structs
  mfd: bd70528: Support ROHM bd70528 PMIC - core
  clk: bd718x7: Support ROHM BD70528 clk block
  devicetree: bindings: Document first ROHM BD70528 bindings
  gpio: Initial support for ROHM bd70528 GPIO block
  rtc: bd70528: Initial support for ROHM bd70528 RTC
  power: supply: Initial support for ROHM BD70528 PMIC charger block
  watchdog: bd70528: Initial support for ROHM BD70528 watchdog block

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 ++++
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  25 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd70528.c                        | 192 ++++++
 drivers/mfd/Kconfig                                |  17 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rohm-bd70528.c                         | 410 +++++++++++++
 drivers/mfd/rohm-bd718x7.c                         |  23 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bd70528-charger.c             | 670 +++++++++++++++++++++
 drivers/regulator/bd718x7-regulator.c              |  22 +-
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 451 ++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bd70528_wdt.c                     | 183 ++++++
 include/linux/mfd/rohm-bd70528.h                   | 392 ++++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |  22 +-
 include/linux/mfd/rohm-generic.h                   |  20 +
 23 files changed, 2537 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/rtc/rtc-bd70528.c
 create mode 100644 drivers/watchdog/bd70528_wdt.c
 create mode 100644 include/linux/mfd/rohm-bd70528.h
 create mode 100644 include/linux/mfd/rohm-generic.h

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
