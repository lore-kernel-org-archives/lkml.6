Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8XtFCeFsHltHTAAAmS7hNA
	; Mon, 11 Jun 2018 12:36:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 082F9607A4; Mon, 11 Jun 2018 12:36:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kj1lOT4/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D511960351;
	Mon, 11 Jun 2018 12:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D511960351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933127AbeFKMgp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:36:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45664 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933045AbeFKMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:36:44 -0400
Received: by mail-wr0-f195.google.com with SMTP id o12-v6so20207749wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=FZVX6DJnAdbfyT4tedAXCBlsGHiCIW8olzFINwC6WkE=;
        b=kj1lOT4/rzHxTBPGO9Oheq3KfD1DhNZM3LYST44FzUexx2nDKB8wLk+Cmk8fMv1wAS
         MG70tkWcSnPdezJvUT9xDOJxbCOzHj59L0dRX6dqAhmEhO68HzVwRFAi2+qep49wdmKT
         J5Q/yZCVWunxTjMhub3WXO8eVPziIuxGjPkVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=FZVX6DJnAdbfyT4tedAXCBlsGHiCIW8olzFINwC6WkE=;
        b=UFb2/d/OAr21CkDC/0S7CF3r6nxaomcI2qTI1jbZcqoXwWRiD98aOKj2Czz8KdiV+I
         uAkSHTOUXSNHi2rqMi4mP/V68ycYlJD1fEpjqDDp7Tms8DsT8iUvyY/GsrJYPGgT8R9d
         gidXyYEQfSUUui7F15bVwtb2C9DediJi/Hog7uVq3ADZn1P+XGPhKIOw9FmJGY3bzyvl
         PKa/lgNT7m3/3D+q/EB9rNuIwk/8tf28PJAKUmSD6riFrQvSq0bkyYqR5fhPSfKC1UKZ
         LJtK3frDrhjZINsOAfOJHqsJuGvgl15QxZNDl6OKT0PSlfmj2CETr8g1tOSaJpuY9LzE
         Gg2g==
X-Gm-Message-State: APt69E0NwcZjxpX0xlf50E4+DGsR7bDdOkLlVKNUK5jB8DkPcnachOAn
        DQOMiyvAbVNfglyfT6Eu8IlonQ==
X-Google-Smtp-Source: ADUXVKIdbgWqzYIawX8lfZT+ue4BWbURmoGsfkucMJNmvmNJV6P8lkV2Jru73TMVX2H7kBtQp1aIUQ==
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr13690299wrm.2.1528720602818;
        Mon, 11 Jun 2018 05:36:42 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id y6-v6sm8530406wmy.39.2018.06.11.05.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 05:36:41 -0700 (PDT)
Date: Mon, 11 Jun 2018 13:36:40 +0100
From: Lee Jones <lee.jones@linaro.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v4.18
Message-ID: <20180611123639.GE5278@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

As promised.  Enjoy!

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-4.18

for you to fetch changes up to 556c242045f0c1613aac2e64dc5b2ff0e4bc89e1:

  mfd: cros_ec: Remove unused __remove function (2018-06-11 09:11:12 +0100)

----------------------------------------------------------------
 - New Device Support
   - Add support for AXP813 ADC to AXP20x
   - Add support for PM8005, PM8998 and PMI8998

 - New Functionality
   - Add support for Battery Power Supply to AXP813
   - Add support for SYSCON to SPARD SC27XX SPI
   - Add support for RTC to ChromeOS Embedded-Controller

 - Fix-ups
   - Remove unused code; exynos{4,5}-pmu, cros_ec, cros_ec_acpi_gpe
   - Remove duplicate error messages (-ENOMEM, etc); htc-i2cpld, janz-cmodio,
		max8997, rc5t583, sm501, smsc-ece1099, abx500-core, si476x-i2c,
		ti_am335x_tscadc, tps65090, tps6586x, tps65910, tps80031,
		twl6030-irq, viperboard
   - Succinctly use ptr to struct in sizeof(); rc5t583, abx500-core, sm501,
		smsc-ece1099
   - Simplify syntax for NULL ptr checking; abx500-core, sm501
   - No not unnecessarily initialise variables; tps65910, tps65910
   - Reorganise and simplify driver data; omap-usb-tll
   - Move to SPDX license statement; tps68470
   - Probe ADCs via DT; axp20x
   - Use new GPIOD API; arizona-core
   - Constify things; axp20x
   - Reduce code-size (use MACROS, etc); axp20x, omap-usb-host
   - Add DT support/docs; motorola-cpcap
   - Remove VLAs; rave-sp
   - Use devm_* managed resources; cros_ec
   - Interrogate HW for firmware version; rave-sp
   - Provide ACPI support for ChromeOS Embedded-Controller

 - Bug Fixes
   - Reorder ordered (enum) device list; tps65218
   - Only accept valid data from the offset; rave-sp
   - Refrain from copying junk from failed SPI read; cros_ec_dev
   - Fix potential memory leaks; pcf50633-core
   - Fix clock initialisation; twl-core
   - Fix build-issue; tps65911
   - Fix off-by-one error; tps65911
   - Fix code ordering issues; intel-lpss
   - Fix COMPILE_TEST related issues; pwm-stm32
   - Fix broken MMC card detection; asic3
   - Fix clocking related issues; intel-lpss-pci

----------------------------------------------------------------
Andrey Gusakov (1):
      hwmon: MC13783: Add uid and die temperature sensor inputs

Andrey Smirnov (3):
      mfd: rave-sp: Add code to print firmware versions
      mfd: rave-sp: Convert print_hex_dump() to print_hex_dump_debug()
      mfd: rave-sp: Check received frame length before accepting next byte

Andy Shevchenko (2):
      mfd: intel-lpss: Program REMAP register in PIO mode
      mfd: intel-lpss: Correct names of RESETS register bits

Arnd Bergmann (1):
      mfd: cros_ec: Remove unused __remove function

Baolin Wang (1):
      mfd: sprd: Add one syscon cell to access PMIC global registers

Charles Keepax (2):
      mfd: arizona: Update reset pin to use GPIOD
      mfd: arizona: Update DT doc to support more standard Reset binding

Chen Zhong (5):
      mfd: mt6397: Create irq mappings in mfd core driver
      dt-bindings: input: Add document bindings for mtk-pmic-keys
      dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
      input: Add MediaTek PMIC keys support
      mfd: mt6397: Add PMIC keys support to MT6397 driver

Chen-Yu Tsai (3):
      mfd: axp20x: Constify struct mfd_cell and struct resource
      mfd: axp20x: Use DEFINE_RES_IRQ to declare resources for mfd_cells
      mfd: axp20x: Correct AXP806 POK interrupt prefix

Christophe JAILLET (1):
      mfd: pcf50633: Fix some memory leaks in the error handling path of 'pcf50633_probe()'

Colin Ian King (1):
      mfd: timberdale: Fix spelling mistake "Uknown" -> "Unknown"

Dan Carpenter (1):
      mfd: tps65911-comparator: Fix a build error

Daniel Hung-yu Wu (1):
      mfd: cros_ec_dev: Register shutdown function for debugfs

Dave Gerlach (1):
      mfd: tps65218: Reorder tps65218_regulator_id enum

David Lechner (1):
      mfd: syscon: Set regmap name to DT node name

Douglas Anderson (1):
      mfd: cros_ec: Don't try to grab log when suspended

Enric Balletbo i Serra (1):
      mfd: cros_ec_dev: Register cros-ec-rtc driver as a subdevice

Fabrice Gasnier (7):
      mfd: stm32-timers: Add support for DMAs
      pwm: stm32: Add capture support
      pwm: stm32: Improve capture by tuning counter prescaler
      pwm: stm32: Use input prescaler to improve period capture
      MAINTAINERS: Add entry for STM32 timer and lptimer drivers
      pwm: stm32: Initialize raw local variables
      mfd: stm32-timers: Fix pwm-stm32 linker issue with COMPILE_TEST

Gwendal Grignou (1):
      mfd: cros_ec: Use devm_kzalloc for private data

Himanshu Jha (1):
      mfd: ab8500-debugfs: Use kasprintf

Jarkko Nikula (1):
      mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input clock

Jeffy Chen (1):
      mfd: syscon: Set name of regmap_config

Joseph Lo (1):
      mfd: cros_ec_i2c: Moving the system sleep pm ops to late

Krzysztof Kozlowski (1):
      mfd: syscon: Remove unused Exynos PMU headers

Kyle Spiers (1):
      mfd: rave-sp: Remove VLA

Ladislav Michl (1):
      mfd: omap-usb-tll: Allocate driver data at once

Lee Jones (2):
      Merge tags 'ib-mfd-hwmon-v4.18', 'ib-mfd-input-rtc-v4.18' and 'ib-mfd-pwm-v4.18' into ibs-for-mfd-merged
      mfd: tps65911-comparator: Fix an off by one bug

Marek Vasut (1):
      dt-bindings: mfd: Add bindings for DA9063L

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

Peter Ujfalusi (1):
      mfd: twl-core: Fix clock initialization

Quentin Schulz (3):
      mfd: axp20x: Make AXP209/22x cells probe their ADC via DT
      mfd: axp20x: Probe axp20x_adc driver for AXP813
      mfd: axp20x: Add battery power supply cell for AXP813

Rajmohan Mani (1):
      mfd: Update to SPDX license identifier

Robert Jarzmik (2):
      mfd: asic3: Fix broken MMC card detection
      mfd: wm97xx-core: Platform data can be NULL

Sebastian Andrzej Siewior (1):
      mfd: syscon: atmel-smc: Include string.h

Sebastian Reichel (1):
      dt-bindings: mfd: motorola-cpcap: Document audio-codec

Stephen Boyd (2):
      mfd: qcom-spmi-pmic: Add support for pm8005, pm8998 and pmi8998
      mfd: cros_ec_dev: Don't advertise junk features on failure

Steve Twiss (1):
      mfd: da9062: Use core helper regmap_reg_range macros

Vincent Palatin (2):
      mfd: cros_ec: Fail early if we cannot identify the EC
      mfd: cros_ec: Free IRQ automatically

Wei-Ning Huang (1):
      mfd: cros_ec_i2c: Add ACPI module device table

Wenkai Du (1):
      Revert "mfd: cros_ec: Add ACPI GPE handler for LID0 devices"

Yisheng Xie (1):
      mfd: omap-usb-host: Use match_string() helper

 .../devicetree/bindings/input/mtk-pmic-keys.txt    |  43 ++
 Documentation/devicetree/bindings/mfd/arizona.txt  |   6 +-
 Documentation/devicetree/bindings/mfd/da9063.txt   |  32 +-
 .../devicetree/bindings/mfd/motorola-cpcap.txt     |  42 ++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   6 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.txt     |   3 +
 MAINTAINERS                                        |  10 +
 drivers/hwmon/mc13783-adc.c                        |  60 +++
 drivers/input/keyboard/Kconfig                     |   9 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/mtk-pmic-keys.c             | 339 +++++++++++++++
 drivers/mfd/Makefile                               |   1 -
 drivers/mfd/ab8500-debugfs.c                       |   3 +-
 drivers/mfd/abx500-core.c                          |  25 +-
 drivers/mfd/arizona-core.c                         |  53 ++-
 drivers/mfd/asic3.c                                |   3 +
 drivers/mfd/atmel-smc.c                            |   1 +
 drivers/mfd/axp20x.c                               | 252 +++--------
 drivers/mfd/cros_ec.c                              |  41 +-
 drivers/mfd/cros_ec_acpi_gpe.c                     | 103 -----
 drivers/mfd/cros_ec_dev.c                          |  45 +-
 drivers/mfd/cros_ec_i2c.c                          |  17 +-
 drivers/mfd/da9062-core.c                          | 462 +++++----------------
 drivers/mfd/htc-i2cpld.c                           |   4 +-
 drivers/mfd/intel-lpss-pci.c                       |  25 +-
 drivers/mfd/intel-lpss.c                           |   8 +-
 drivers/mfd/janz-cmodio.c                          |   4 +-
 drivers/mfd/jz4740-adc.c                           |   4 +-
 drivers/mfd/max8997.c                              |   4 +-
 drivers/mfd/mc13xxx-core.c                         |  15 +-
 drivers/mfd/mt6397-core.c                          |  26 +-
 drivers/mfd/omap-usb-host.c                        |  24 +-
 drivers/mfd/omap-usb-tll.c                         |  60 ++-
 drivers/mfd/pcf50633-core.c                        |   7 +-
 drivers/mfd/qcom-spmi-pmic.c                       |   6 +
 drivers/mfd/rave-sp.c                              | 118 +++++-
 drivers/mfd/rc5t583.c                              |   6 +-
 drivers/mfd/si476x-i2c.c                           |   6 +-
 drivers/mfd/sm501.c                                |  32 +-
 drivers/mfd/smsc-ece1099.c                         |   7 +-
 drivers/mfd/sprd-sc27xx-spi.c                      |   3 +
 drivers/mfd/stm32-timers.c                         | 201 ++++++++-
 drivers/mfd/syscon.c                               |   2 +
 drivers/mfd/ti_am335x_tscadc.c                     |   5 +-
 drivers/mfd/timberdale.c                           |   2 +-
 drivers/mfd/tps65090.c                             |   4 +-
 drivers/mfd/tps6586x.c                             |   4 +-
 drivers/mfd/tps65910.c                             |  18 +-
 drivers/mfd/tps65911-comparator.c                  |  17 +-
 drivers/mfd/tps68470.c                             |  10 +-
 drivers/mfd/tps80031.c                             |   4 +-
 drivers/mfd/twl-core.c                             |   2 +-
 drivers/mfd/twl6030-irq.c                          |   4 +-
 drivers/mfd/viperboard.c                           |   4 +-
 drivers/mfd/wm97xx-core.c                          |   2 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |  20 +
 drivers/pwm/pwm-stm32.c                            | 257 ++++++++++++
 drivers/rtc/rtc-mt6397.c                           |   7 +-
 include/linux/mfd/arizona/pdata.h                  |   3 +-
 include/linux/mfd/axp20x.h                         |  10 +-
 include/linux/mfd/cros_ec.h                        |  20 +-
 include/linux/mfd/mc13xxx.h                        |   2 +
 include/linux/mfd/stm32-timers.h                   |  70 ++++
 include/linux/mfd/syscon/exynos4-pmu.h             |  21 -
 include/linux/mfd/syscon/exynos5-pmu.h             |  19 -
 include/linux/mfd/tps65218.h                       |   4 +-
 include/linux/mfd/tps68470.h                       |  17 +-
 67 files changed, 1650 insertions(+), 995 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c
 delete mode 100644 drivers/mfd/cros_ec_acpi_gpe.c
 delete mode 100644 include/linux/mfd/syscon/exynos4-pmu.h
 delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
