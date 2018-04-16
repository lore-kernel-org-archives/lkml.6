Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeDPKqm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:46:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36230 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbeDPKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:46:40 -0400
X-Google-Smtp-Source: AIpwx49fubIieixdtzXUapegTQ2kbvZoFpWF2rG87O+3bk6oi1i3KKIuzU+vy2t2m1uM241P2KvM6A==
Date: Mon, 16 Apr 2018 11:46:36 +0100
From: Lee Jones <lee.jones@linaro.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v4.17
Message-ID: <20180416104636.5v7ry4cdpro2pvnu@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Enjoy!

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-4.17-1

for you to fetch changes up to b45bf45f1b827d05e8209e2adf35f777ada0c5d4:

  mfd: arizona: Update reset pin to use GPIOD (2018-03-28 12:06:34 +0100)

----------------------------------------------------------------
 - New Device Support
   - Add support for AXP813 ADC to AXP20x
   - Add support for AXP813 Battery Power Supply to AXP813
   - Add support for SC27XX SYSCON to SPARD SC27XX SPI

- New Functionality
   - Interrogate HW for firmware version; rave-sp

 - Fix-ups
   - Remove unused code; exynos{4,5}-pmu, cros_ec, cros_ec_acpi_gpe
   - Remove duplicate error messages (-ENOMEM, etc); htc-i2cpld, janz-cmodio,
		max8997, rc5t583, sm501, smsc-ece1099, abx500-core, si476x-i2c,
		ti_am335x_tscadc, tps65090, tps6586x, tps65910, tps80031,
		twl6030-irq, viperboard
   - Succinctly Use ptr to struct in sizeof(); rc5t583, abx500-core, sm501,
		smsc-ece1099
   - Simplify syntax for NULL ptr checking; abx500-core, sm501
   - No not unnecessarily initialise variables; tps65910, tps65910
   - Reorganise and simplify driver data; omap-usb-tll
   - Move to SPDX license statement; tps68470
   - Probe ADCs via DT; axp20x
   - Use new GPIOD API; arizona-core

- Bug Fixes
  - Reorder ordered (enum) device list; tps65218
  - Only accept valid data from the offset; rave-sp
  - Fix potential memory leaks; pcf50633-core

----------------------------------------------------------------
Andrey Smirnov (3):
      mfd: rave-sp: Add code to print firmware versions
      mfd: rave-sp: Convert print_hex_dump() to print_hex_dump_debug()
      mfd: rave-sp: Check received frame length before accepting next byte

Baolin Wang (1):
      mfd: sprd: Add one syscon cell to access PMIC global registers

Charles Keepax (1):
      mfd: arizona: Update reset pin to use GPIOD

Christophe JAILLET (1):
      mfd: pcf50633: Fix some memory leaks in the error handling path of 'pcf50633_probe()'

Dave Gerlach (1):
      mfd: tps65218: Reorder tps65218_regulator_id enum

David Lechner (1):
      mfd: syscon: Set regmap name to DT node name

Himanshu Jha (1):
      mfd: ab8500-debugfs: Use kasprintf

Jeffy Chen (1):
      mfd: syscon: Set name of regmap_config

Joel Stanley (1):
      dt-bindings: aspeed-lpc: Document LPC Host Interface Controller

Krzysztof Kozlowski (1):
      mfd: syscon: Remove unused Exynos PMU headers

Ladislav Michl (1):
      mfd: omap-usb-tll: Allocate driver data at once

Markus Elfring (25):
      mfd: htc-i2cpld: Delete error message for a failed memory allocation
      mfd: janz-cmodio: Delete error message for a failed memory allocation
      mfd: jz4740-adc: Delete error message for a failed memory allocation
      mfd: max8997: Delete error message for a failed memory allocation
      mfd: rc5t583: Delete error message for a failed memory allocation
      mfd: rc5t583: Improve a size determination
      mfd: sm501: Delete error message for a failed memory allocation in two places
      mfd: smsc-ece1099: Delete an error message for a failed memory allocation
      mfd: abx500-core: Delete an error message for a failed memory allocation in abx500_register_ops()
      mfd: abx500-core: Improve two size determinations in abx500_register_ops()
      mfd: abx500-core: Adjust 14 checks for null pointers
      mfd: si476x-i2c: Delete an error message for a failed memory allocation in si476x_core_probe()
      mfd: sm501: Improve a size determination in two functions
      mfd: sm501: Adjust 12 checks for null pointers
      mfd: smsc-ece1099: Improve a size determination in smsc_i2c_probe()
      mfd: ti_am335x_tscadc: Delete an error message for a failed memory allocation in ti_tscadc_probe()
      mfd: tps65090: Delete an error message for a failed memory allocation in tps65090_i2c_probe()
      mfd: tps6586x: Delete an error message for a failed memory allocation in tps6586x_parse_dt()
      mfd: tps65910: Delete an error message for a failed memory allocation in tps65910_parse_dt()
      mfd: tps65910: Delete an unnecessary variable initialisation in four functions
      mfd: tps65910: Delete an unnecessary variable initialisation in tps65910_sleepinit()
      mfd: tps65910: Move an assignment in tps65910_sleepinit()
      mfd: tps80031: Delete an error message for a failed memory allocation in tps80031_probe()
      mfd: twl6030-irq: Delete an error message for a failed memory allocation in twl6030_init_irq()
      mfd: viperboard: Delete an error message for a failed memory allocation in vprbrd_probe()

Quentin Schulz (3):
      mfd: axp20x: Make AXP209/22x cells probe their ADC via DT
      mfd: axp20x: Probe axp20x_adc driver for AXP813
      mfd: axp20x: Add battery power supply cell for AXP813

Rajmohan Mani (1):
      mfd: Update to SPDX license identifier

Wenkai Du (1):
      Revert "mfd: cros_ec: Add ACPI GPE handler for LID0 devices"

 .../devicetree/bindings/mfd/aspeed-lpc.txt         |  41 ++++++++
 drivers/mfd/Makefile                               |   1 -
 drivers/mfd/ab8500-debugfs.c                       |   3 +-
 drivers/mfd/abx500-core.c                          |  25 +++--
 drivers/mfd/arizona-core.c                         |  53 ++++++----
 drivers/mfd/axp20x.c                               |  13 ++-
 drivers/mfd/cros_ec.c                              |  15 +--
 drivers/mfd/cros_ec_acpi_gpe.c                     | 103 --------------------
 drivers/mfd/htc-i2cpld.c                           |   4 +-
 drivers/mfd/janz-cmodio.c                          |   4 +-
 drivers/mfd/jz4740-adc.c                           |   4 +-
 drivers/mfd/max8997.c                              |   4 +-
 drivers/mfd/omap-usb-tll.c                         |  60 +++++-------
 drivers/mfd/pcf50633-core.c                        |   7 +-
 drivers/mfd/rave-sp.c                              | 107 +++++++++++++++++++--
 drivers/mfd/rc5t583.c                              |   6 +-
 drivers/mfd/si476x-i2c.c                           |   6 +-
 drivers/mfd/sm501.c                                |  32 +++---
 drivers/mfd/smsc-ece1099.c                         |   7 +-
 drivers/mfd/sprd-sc27xx-spi.c                      |   3 +
 drivers/mfd/syscon.c                               |   2 +
 drivers/mfd/ti_am335x_tscadc.c                     |   5 +-
 drivers/mfd/tps65090.c                             |   4 +-
 drivers/mfd/tps6586x.c                             |   4 +-
 drivers/mfd/tps65910.c                             |  18 ++--
 drivers/mfd/tps68470.c                             |  10 +-
 drivers/mfd/tps80031.c                             |   4 +-
 drivers/mfd/twl6030-irq.c                          |   4 +-
 drivers/mfd/viperboard.c                           |   4 +-
 include/linux/mfd/arizona/pdata.h                  |   3 +-
 include/linux/mfd/cros_ec.h                        |  18 ----
 include/linux/mfd/syscon/exynos4-pmu.h             |  21 ----
 include/linux/mfd/syscon/exynos5-pmu.h             |  19 ----
 include/linux/mfd/tps65218.h                       |   4 +-
 include/linux/mfd/tps68470.h                       |  17 +---
 35 files changed, 284 insertions(+), 351 deletions(-)
 delete mode 100644 drivers/mfd/cros_ec_acpi_gpe.c
 delete mode 100644 include/linux/mfd/syscon/exynos4-pmu.h
 delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
