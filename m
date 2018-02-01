Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeBASHP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:07:15 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37083 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeBASHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:07:10 -0500
X-Google-Smtp-Source: AH8x225QW41D3ujBbn54BAEhVHcTbLKDMpAh7nNlOTEOBkt+IQnNynxb60c6g3WVvm7srhaysx6Asg==
Date: Thu, 1 Feb 2018 10:07:06 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.16-rc0
Message-ID: <20180201180706.hu42scirtu5mx6bo@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- evdev interface has been adjusted to extend the life of timestamps on
  32 bit systems to the year of 2108

- Synaptics RMI4 driver's PS/2 guest handling ha beed updated to improve
  chances of detecting trackpoints on the pass-through port

- mms114 touchcsreen controller driver has been updated to support
  generic device properties and work with mms152 cntrollers

- Goodix driver now supports generic touchscreen properties

- couple of drivers for AVR32 architecture are gone as the architecture
  support has been removed from the kernel

- gpio-tilt driver has been removed as there are no mainline users and
  the driver itself is using legacy APIs and relies on platform data

- MODULE_LINECSE/MODULE_VERSION cleanups

Changelog:
---------

Andi Shyti (6):
      Input: stmfts,s6sy671 - add SPDX identifier
      Input: ad7877 - use managed resource allocations
      Input: stmfts - set IRQ_NOAUTOEN to the irq flag
      Input: mms114 - replace mdelay with msleep
      Input: mms114 - use BIT() macro instead of explicit shifting
      Input: mms114 - fix typo in definition

Andy Shevchenko (1):
      Input: docs - use PROPERTY_ENTRY_U32() directly

Arnd Bergmann (1):
      Input: hp_sdc - convert to ktime_get()

Colin Ian King (1):
      Input: cyapa - remove redundant assignment to 'pwr_cmd'

Corentin Labbe (2):
      Input: remove at32psif
      Input: remove atmel-wm97xx touchscreen driver

Deepa Dinamani (2):
      Input: uinput - use monotonic times for timestamps
      Input: extend usable life of event timestamps to 2106 on 32 bit systems

Dmitry Torokhov (7):
      Input: psmouse - fix Synaptics detection when protocol is disabled
      Input: synaptics-rmi4 - do not delete interrupt memory too early
      Input: synaptics-rmi4 - unmask F03 interrupts when port is opened
      Input: synaptics-rmi4 - log when we create a guest serio port
      Input: edt-ft5x06 - fix error handling for factory mode on non-M06
      Input: mms114 - do not clobber interrupt trigger
      Input: mms114 - mark as direct input device

Greg Kroah-Hartman (7):
      Input: remove unneeded DRIVER_LICENSE #defines
      Input: synaptics_rmi4 - remove unneeded MODULE_VERSION() usage
      Input: pmic8xxx-keypad - remove unneeded MODULE_VERSION() usage
      Input: elan_i2c - remove unneeded MODULE_VERSION() usage
      Input: remove unneeded MODULE_VERSION() usage in touchscreen drivers
      Input: remove unneeded MODULE_VERSION() usage in misc input drivers
      Input: remove remaining unneeded MODULE_VERSION() usage

Hans de Goede (2):
      Input: silead - add support for capactive home button found on some x86 tablets
      Input: goodix - disable IRQs while suspended

Jean-François Têtu (1):
      Input: fix small typos in force feedback documentation

Jeffrey Lin (1):
      Input: raydium_i2c_ts - include hardware version in firmware name

Julia Lawall (1):
      Input: inline macros for MODULE_LICENSE, etc

Linus Walleij (1):
      Input: gpio_tilt - delete driver

Marcin Niestroj (1):
      Input: goodix - use generic touchscreen_properties

Marcus Folkesson (1):
      Input: da9052_tsi - remove unused mutex

Markus Elfring (2):
      Input: auo-pixcir-ts - remove custom log for a failed memory allocation
      Input: auo-pixcir-ts - delete an unnecessary return statement

Peter Hutterer (1):
      Input: synaptics - reset the ABS_X/Y fuzz after initializing MT axes

Pravin Shedge (1):
      Input: synaptic_rmi4 - remove duplicate include in F34

Rasmus Villemoes (1):
      Input: cyapa - remove duplicated macro definitions

Simon Shields (2):
      Input: mms114 - drop platform data and use generic APIs
      Input: mms114 - add support for mms152

WEN Pingbo (2):
      Input: hil_mlc - convert timeval to time64_t
      Input: hil_mlc - convert timeval to jiffies

Zhuohua Li (1):
      Input: tps65218-pwrbutton - fix a spelling mistake in Kconfig

Diffstat:
--------

 .../bindings/input/touchscreen/mms114.txt          |  35 +-
 .../bindings/input/touchscreen/silead_gsl1680.txt  |   2 +
 Documentation/gpio/drivers-on-gpio.txt             |   5 -
 Documentation/input/devices/gpio-tilt.rst          | 103 -----
 Documentation/input/devices/rotary-encoder.rst     |   6 +-
 Documentation/input/ff.rst                         |   6 +-
 drivers/input/evdev.c                              |  20 +-
 drivers/input/input-compat.c                       |   8 +-
 drivers/input/input-compat.h                       |   3 +-
 drivers/input/input-polldev.c                      |   1 -
 drivers/input/joystick/xpad.c                      |   7 +-
 drivers/input/keyboard/pmic8xxx-keypad.c           |   1 -
 drivers/input/misc/Kconfig                         |  16 +-
 drivers/input/misc/Makefile                        |   1 -
 drivers/input/misc/apanel.c                        |   2 -
 drivers/input/misc/ati_remote2.c                   |   2 -
 drivers/input/misc/gpio_tilt_polled.c              | 210 ----------
 drivers/input/misc/keyspan_remote.c                |  11 +-
 drivers/input/misc/uinput.c                        |   6 +-
 drivers/input/misc/yealink.c                       |   6 +-
 drivers/input/mouse/cyapa.c                        |   2 +-
 drivers/input/mouse/cyapa_gen3.c                   |  43 --
 drivers/input/mouse/elan_i2c_core.c                |   2 -
 drivers/input/mouse/psmouse-base.c                 |  34 +-
 drivers/input/mouse/synaptics.c                    |  10 +
 drivers/input/rmi4/rmi_bus.c                       |   1 -
 drivers/input/rmi4/rmi_driver.c                    |  14 +-
 drivers/input/rmi4/rmi_driver.h                    |   2 -
 drivers/input/rmi4/rmi_f03.c                       |  73 +++-
 drivers/input/rmi4/rmi_f34.c                       |   1 -
 drivers/input/rmi4/rmi_i2c.c                       |   1 -
 drivers/input/rmi4/rmi_spi.c                       |   1 -
 drivers/input/serio/Kconfig                        |  10 -
 drivers/input/serio/Makefile                       |   1 -
 drivers/input/serio/at32psif.c                     | 357 -----------------
 drivers/input/serio/hil_mlc.c                      |  26 +-
 drivers/input/serio/hp_sdc.c                       |  17 +-
 drivers/input/serio/hp_sdc_mlc.c                   |   5 +-
 drivers/input/sparse-keymap.c                      |   1 -
 drivers/input/tablet/acecad.c                      |  14 +-
 drivers/input/tablet/aiptek.c                      |  11 +-
 drivers/input/tablet/hanwang.c                     |  10 +-
 drivers/input/tablet/kbtab.c                       |  17 +-
 drivers/input/touchscreen/Kconfig                  |  15 -
 drivers/input/touchscreen/Makefile                 |   1 -
 drivers/input/touchscreen/ad7877.c                 |  67 ++--
 drivers/input/touchscreen/atmel-wm97xx.c           | 436 ---------------------
 drivers/input/touchscreen/auo-pixcir-ts.c          |   6 +-
 drivers/input/touchscreen/colibri-vf50-ts.c        |   2 -
 drivers/input/touchscreen/da9052_tsi.c             |   1 -
 drivers/input/touchscreen/edt-ft5x06.c             |  14 +-
 drivers/input/touchscreen/elants_i2c.c             |   2 -
 drivers/input/touchscreen/goodix.c                 | 149 +++----
 drivers/input/touchscreen/melfas_mip4.c            |   1 -
 drivers/input/touchscreen/mms114.c                 | 240 +++++++-----
 drivers/input/touchscreen/raydium_i2c_ts.c         |  14 +-
 drivers/input/touchscreen/silead.c                 |  46 ++-
 drivers/input/touchscreen/stmfts.c                 |  11 +-
 drivers/input/touchscreen/usbtouchscreen.c         |   9 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   2 -
 include/linux/hil_mlc.h                            |   6 +-
 include/linux/hp_sdc.h                             |   2 +-
 include/linux/input/gpio_tilt.h                    |  74 ----
 include/linux/platform_data/mms114.h               |  24 --
 include/uapi/linux/input.h                         |  11 +
 65 files changed, 491 insertions(+), 1746 deletions(-)
 delete mode 100644 Documentation/input/devices/gpio-tilt.rst
 delete mode 100644 drivers/input/misc/gpio_tilt_polled.c
 delete mode 100644 drivers/input/serio/at32psif.c
 delete mode 100644 drivers/input/touchscreen/atmel-wm97xx.c
 delete mode 100644 include/linux/input/gpio_tilt.h
 delete mode 100644 include/linux/platform_data/mms114.h

Thanks.


-- 
Dmitry
