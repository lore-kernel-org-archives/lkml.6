Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123EC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E810217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfBFJfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:35:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45383 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfBFJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:35:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so5368039ljd.12;
        Wed, 06 Feb 2019 01:35:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uwHFuHLu7arQiUdnygTtwrq3ChmI0bvhNhddc7+/Czs=;
        b=EVjmT0zo0RzvYc6fYrg1/qHdtuBR48kWCU+vuS6KoEzmOe2pzgeTzG/23+nLmjFaFx
         cYyaO/kRkXqXxdY8ZY9mYyz01hyJewpwCxhBYEAALXOW+qBDZGlJ9VA8BjkalXCT6ESW
         U/CvgG2OHtno0HT/SyWSW//e0qOp19sxa1s+csRQngtEA8+JHwYq2tpYsretRMiPYNpR
         oRlhLYStQvLZ/AkDQEj5cq++uKeDqhelx4kJlL/n8asXx+UK1/JyKp7W8jAOMQJalLc8
         B8AEseHhVtpZr/E/n3OW4G11yc4rV3TwD8hoD5Bp5K2vkQlmLZfIOfh+7mmU822YUUPl
         WB7Q==
X-Gm-Message-State: AHQUAuZUuZgx+hBFXwDFp8BqO1FSMsx+ODD1+sIcVDMLZi0p+ho9MddJ
        +2tbTe8UCvCxMzN+CC+GAr4=
X-Google-Smtp-Source: AHgI3IbS1Mh4bHiNoLzNtLwX6tB2hNTUhTJR31wSIf3x9iaLgURrXNeG7XMMWt6fxTJ3WukXkmnH5g==
X-Received: by 2002:a2e:89cb:: with SMTP id c11-v6mr1987774ljk.105.1549445749671;
        Wed, 06 Feb 2019 01:35:49 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p14sm624237lfk.16.2019.02.06.01.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 01:35:49 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:35:36 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v7 00/10] support ROHM BD70528 PMIC
Message-ID: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
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
Knowing the bd718x7 driver is already in upstream, it might be good
if this change went through single tree, right?

ROHM BD70528 is a programmable Power Management IC for battery
powered 'ultra low power' systems like the pre-announced NXP
i.MX7 ULP. This patch series introduces support for the PMIC. Please
note that this driver only supports HW setup where PMIC is connected
to I2C on A7 core. The other scenario is to use M4 as a power manager
and connect pmic to M4. On such setups the A7 can only access pmic
via M4 core using RPMSG virtio. Such setup depends on RPMSG
implementation on M4 core and is currently not supported by this
patch series.

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

The power-supply patch included in series is only poorly tested as I
lack of hardware with real battery connected. Reset and ADC are not
supported by this series.

Changelog v7:
Only patch 2 changed.
- Avoid out-of-array-bounds access at regulator probe if unsupported
  chip type is passed to bd718x7 regulator driver.

Changelog v6:
Only patch 10 changed.
- styling fixes pointed by Gunter Roeck
- dropped RFC tag

Changelog v5 (RFC):
Only patch 7 changed.
- Explained why lock is not needed at GPIO value getting
- removed ampersands from function pointer assignments.

Changelog v4 (RFC):
patches 1,2,3,4,5,10 are unchanged from v3
DT-binding fixes suggested by Rob Herring:
- drop interrupt-parent
- drop clock-frequency
- change pmic node name to a generic one
RTC:
- enable RTC block's irqs before registering rtc
GPIO fixes after initial testing:
- fix getting GPIO value when direction is output
POWER:
- Add ASCII art intended to clarify the charger HW state machine

Changelog v3 (RFC):
patches 1,2,3,4,5,6,7,8 and 10 are unchanged from v2
RTC fixups suggested by Guenter Roeck:
- create bd70528_set_time_locked function in order to simplify
  error handling and to make mutex lock/unlock path more obvious
- don't ignore errors on bd70528_set_time_locked
- simplify bd70528_read_alarm enabled condition setting
- add __packed to structs where members are mapped to HW registers
- remove unnecessary brackets from enable condition in set_wake
RTC: fixups suggested by Alessandro Belloni
- don't use deprecated devm_rtc_device_register
- add alarm_irq_enable callback
- add range_min and range_max
WDT:
- add regmap and mutex pointers to WDT data so that they can be accessed
  without dereferencing the parent data
- remove parent data pointer from WDT data
- embed struct watchdog_device into WDT data in order to avoid double
  allocation.
GPIO:
- remove unused header as pointed by Linus Walleij
POWER:
- do not copy the whole MFD data (especially the mutex to avoid
  all possibilities of accidentally using the copy of a mutex)

Changelog v2 (RFC): Mainly feedback from Guenter Roeck:
- patches 1, 2, 3, 4, 5, 9 are unchanged.
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

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  25 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd70528.c                        | 232 +++++++
 drivers/mfd/Kconfig                                |  17 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rohm-bd70528.c                         | 410 ++++++++++++
 drivers/mfd/rohm-bd718x7.c                         |  23 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bd70528-charger.c             | 738 +++++++++++++++++++++
 drivers/regulator/bd718x7-regulator.c              |  24 +-
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 500 ++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bd70528_wdt.c                     | 190 ++++++
 include/linux/mfd/rohm-bd70528.h                   | 392 +++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |  22 +-
 include/linux/mfd/rohm-generic.h                   |  20 +
 23 files changed, 2700 insertions(+), 46 deletions(-)
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
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
