Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B43C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864B920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfAVJmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:42:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35532 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfAVJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:42:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so20026120ljb.2;
        Tue, 22 Jan 2019 01:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DDtFklFYG/ucGG4/0fj0M8lNOllj0tgEOi+Jyo81gsw=;
        b=DFpToFI7M1QpdLOiYys+yaCWzVWnNKg+7ZoEK6b/PfgklkhxO6x91G20yW0q1Ch+yi
         cTqpIDLcIgU9TqMwkOSYzCbozqVwccmJA8kYMVSyQ5xCCB34RFgawBe6KJQEe5j1nFws
         cNQxgvPoSBeuV13/S6ht8YpmMgGPoWkJPs1qHkPP5MS0Rw49uuWs/LAJAWI8M1umdnmN
         gOn3J1WN8YNt74GF5ciO+tcRK5NldcQcbvKTcr3m8GHXkYUOhNfQDt42YpQbIjgFhALR
         mHj0V8RINiChumd4K1on/g9ybOqHuuxx7MdQq+wMkPBTlUOr1VAkY3Fsfivp8IYVxKpx
         BX+Q==
X-Gm-Message-State: AJcUukcwFxVEhIcT1QJO7HTd6drjDmCzVxzMPYLBVlrHuIDCIPXr/fTg
        b3RjDZLE6W1xEo+aPkdcyrErgVIu
X-Google-Smtp-Source: ALg8bN4Iq81GfF8ijl7WbioEzJ2Q06IeBbuckLX7lN7FNdQlY4rLZVkAxWTikNHSdSt1q98sdN+Vpw==
X-Received: by 2002:a2e:8855:: with SMTP id z21-v6mr31509ljj.191.1548150128534;
        Tue, 22 Jan 2019 01:42:08 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h21sm2792721lfk.41.2019.01.22.01.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:42:07 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:41:53 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [RFC PATCH v1 00/13] support ROHM BD70528 PMIC
Message-ID: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series introducing support for ROHM BD70528 PMIC

Please note that patch 2 breaks compilation without patches 3 and 4

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

Another 'RFC' item is 'main register support' for regmap-irq.
This has been initially discussed with Mark in these mail threads

Option 1
https://lore.kernel.org/lkml/20181217185014.GH27909@sirena.org.uk/

Option 2
https://lore.kernel.org/lkml/20181218085803.GD2477@localhost.localdomain/

But I think it is Ok to show it to wider audience with this real
usage example.

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

Patch 1:
	regmap-irq, 'main status register support'. See discussion
	https://lore.kernel.org/lkml/20181217185014.GH27909@sirena.org.uk/
Patch 2:
	split the bd718x7.h to generic and chip specific portions.
	(breaks compilation without patch 3 and 4)
Patch 3:
	adapt bd718x7.h changes to bd718x7 regulator driver
Patch 4:
	adapt bd718x7.h changes to bd718x7 clk driver
Patch 5:
	add MFD core support for bd70528
Patch 6:
	support bd70528 clk using bd718x7 clk driver
Patch 7:
	document DT bindings for BD70528
Patch 8:
	support bd70528 regulators
Patch 9:
	document regulator DT bindings for BD70528
Patch 10:
	support BD70528 GPIO block
Patch 11:
	support BD70528 RTC
Patch 12:
	support BD70528 battery charger
Patch 13:
	support BD70528 watchdog

This patch series is based on Mark's regulator/for-next branch

---

Matti Vaittinen (13):
  regmap: regmap-irq: Add main status register support
  mfd: bd718x7.h split to ROHM common and bd718x7 specific parts
  regulator: bd718x7 use chip specific and generic data structs
  clk: bd718x7: use chip specific and generic data structs
  mfd: bd70528: Support ROHM bd70528 PMIC - core
  clk: bd718x7: Support ROHM BD70528 clk block
  devicetree: bindings: Document first ROHM BD70528 bindings
  regulator: bd70528: Support ROHM BD70528 regulator block
  devicetree: bindings: ROHM bd70528 regulator bindings
  gpio: Initial support for ROHM bd70528 GPIO block
  rtc: bd70528: Initial support for ROHM bd70528 RTC
  power: supply: Initial support for ROHM BD70528 PMIC charger block
  watchdog: bd70528: Initial support for ROHM BD70528 watchdog block

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 104 ++++
 .../bindings/regulator/rohm,bd70528-regulator.txt  |  68 +++
 drivers/base/regmap/regmap-irq.c                   |  99 ++-
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  25 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd70528.c                        | 192 ++++++
 drivers/mfd/Kconfig                                |  17 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rohm-bd70528.c                         | 409 +++++++++++++
 drivers/mfd/rohm-bd718x7.c                         |  23 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bd70528-charger.c             | 670 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bd70528-regulator.c              | 290 +++++++++
 drivers/regulator/bd718x7-regulator.c              |  22 +-
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 439 ++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bd70528_wdt.c                     | 161 +++++
 include/linux/mfd/rohm-bd70528.h                   | 392 ++++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |  22 +-
 include/linux/mfd/rohm-generic.h                   |  20 +
 include/linux/regmap.h                             |  31 +
 29 files changed, 2998 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/regulator/bd70528-regulator.c
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
