Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5187C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4747620E20
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aiy19vXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4747620E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeHTMBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:01:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51736 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:01:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so13409206wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=53ktWSGI7ot3CP/upgGBNxXP4JsVtRwc9sNYqrq/o00=;
        b=Aiy19vXDnx67Uv8si5p/ag7hDtL+jbdDKlsi3nGv1Wru6sWSZq/KInx4ZtvjqeS7uX
         E8kO4tzMD5pW6kJ2zm4tVlXyBq3RQmZhis7RpgAftr+dGcekAawKfGmEXr8vQMtoNXUk
         1wuYA/54s8BIMZBHlq67nouJR6ffKnlerBRLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=53ktWSGI7ot3CP/upgGBNxXP4JsVtRwc9sNYqrq/o00=;
        b=eUvRyLe9CwCT6aHouO/rcZeUutRv/47Vpa/0e9u+OrmyhRAsc6bSVIBmTUOrkk25CJ
         GUPoB8bwbuGIcGQH9eyXlLRNO3JjoZAvIF5Ofw4kL1ZUShkgInSFP76R14Mp1Gex1Xhb
         ISQbD6n7fz01WrE20XkUprSExJYWJzw6qSkENYImnbeCn+AdSOUg7Jo2fnYNyQpX+B+5
         KZ/ikxkIDz96jgeLYg/NP5ydg3aZFLpSxBF33EXsNMzt+gV7HIYONCFKb2TEu55kukN5
         50AN8FIEs+EGraNhlawXUQQ/pRhxHeeaVPkqBLzdyATCKcRCpnWBEJEw2n9wqwk2T2Kh
         dKUg==
X-Gm-Message-State: AOUpUlE43C7ezqP806h7FcmxVr3YXsyEzb8AUF1Jp7Tb47MLSR9uNbA/
        vWui0efFNO3FNY6WKukYo7XEe5/MRDY=
X-Google-Smtp-Source: AA+uWPzDAmVR6JN/3dxLYy7tfjlfDZ6/lSDxykbURG0e83QIWB9cLSvzguJy63G6iGfHqOITQ0kTjg==
X-Received: by 2002:a1c:ec06:: with SMTP id k6-v6mr26378702wmh.39.1534754815637;
        Mon, 20 Aug 2018 01:46:55 -0700 (PDT)
Received: from dell ([2.27.167.102])
        by smtp.gmail.com with ESMTPSA id q21-v6sm9081203wmq.3.2018.08.20.01.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 01:46:54 -0700 (PDT)
Date:   Mon, 20 Aug 2018 09:46:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v4.19
Message-ID: <20180820084653.GT10054@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

NOTE: Please be aware that there are 3 trivial conflicts to be aware
of when merging.  2 of them were fixed in -next by Stephen [0][1], the
other one (in drivers/gpu/drm/i915/Kconfig) fixed itself (?)), but is
also very easy to rectify - both lines should be added.

[0] https://lkml.org/lkml/2018/8/16/739
[1] https://lkml.org/lkml/2018/7/26/59

Enjoy!

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-4.19

for you to fetch changes up to d2c9281c184bf2b768ac141a7a10586e0643695d:

  mfd: madera: Add register definitions for accessory detect (2018-08-16 10:14:05 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add Cirrus Logic Madera Codec (CS47L35, CS47L85 and CS47L90/91) driver
   - Add ChromeOS EC CEC driver
   - Add ROHM BD71837 PMIC driver

 - New Device Support
   - Add support for Dialog Semi DA9063L PMIC variant to DA9063
   - Add support for Intel Ice Lake to Intel-PLSS-PCI
   - Add support for X-Powers AXP806 to AXP20x

 - New Functionality
   - Add support for USB Charging to the ChromeOS Embedded Controller
   - Add support for HDMI CEC to the ChromeOS Embedded Controller
   - Add support for HDMI CEC to Intel HDMI
   - Add support for accessory detection to Madera devices
   - Allow individual pins to be configured via DT' wlf,csnaddr-pd
   - Provide legacy platform specific EEPROM/Watchdog commands; rave-sp

 - Fix-ups
   - Trivial renaming/spelling fixes; cros_ec, da9063-*
   - Convert to Managed Resources (devm_*); da9063-*, ti_am335x_tscadc
   - Transition to helper macros/functions; da9063-*
   - Constify; kempld-core
   - Improve error path/messages; wm8994-core
   - Disable IRQs locally instead of relying on USB subsystem; dln2
   - Remove unused code; rave-sp
   - New exports; sec-core

 - Bug Fixes
   - Fix possible false I2C transaction error; arizona-core
   - Fix declared memory area size; hi655x-pmic
   - Fix checksum type; rave-sp
   - Fix incorrect default serial port configuration: rave-sp
   - Fix incorrect coherent DMA mask for sub-devices; sm501

----------------------------------------------------------------
Alberto Panizzo (2):
      mfd: wm8994: Allow to configure Speaker Mode Pullup from dts
      mfd: wm8994: Allow to configure CS/ADDR Pulldown from dts

Andrey Smirnov (6):
      mfd: rave-sp: Remove unused defines
      mfd: rave-sp: Fix incorrectly specified checksum type
      mfd: rave-sp: Initialize flow control and parity of the port
      mfd: rave-sp: Add legacy EEPROM access command translation
      mfd: rave-sp: Add legacy watchdog ping command translation
      mfd: rave-sp: Emulate CMD_GET_STATUS on device that don't support it

Anthony Brandon (1):
      mfd: wm8994-core: Fix error path in wm8994_device_init

Arnd Bergmann (1):
      media: platform: cros-ec-cec: Fix dependency on MFD_CROS_EC

Charles Keepax (1):
      mfd: arizona: Don't use regmap_read_poll_timeout

Chen-Yu Tsai (3):
      dt-bindings: mfd: axp20x: Add "self-working" mode for AXP806
      mfd: axp20x: Add self-working mode support for AXP806
      mfd: axp20x: Support AXP806 in I2C mode

Christoph Fritz (1):
      dt-bindings: mfd: Fix documentation of tps65911

Enric Balletbo i Serra (4):
      platform/chrome: Move cros-ec transport drivers to drivers/platform.
      arm/arm64: configs: Remove the MFD_ prefix for MFD_CROS_EC_I2C/SPI symbols.
      Input: keyboard: Fix ChromeOS EC keyboard help message.
      mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.

Guenter Roeck (1):
      mfd: sm501: Set coherent_dma_mask when creating subdevices

Julia Lawall (1):
      mfd: kempld-core: Constify variables that point to const structure

Krzysztof Kozlowski (1):
      mfd: sec-core: Export OF module alias table

Lee Jones (1):
      Merge branches 'ib-mfd-4.19', 'ib-mfd-gpio-pinctrl-4.19', 'ib-mfd-i915-media-platform-4.19' and 'ib-mfd-regulator-4.19', tag 'ib-platform-chrome-mfd-move-cros-ec-transport-for-4.19' into ibs-for-mfd-merged

Marcel Ziswiler (1):
      mfd: as3722: Disable auto-power-on when AC OK

Marek Vasut (14):
      mfd: da9063: Replace regmap_add_irq_chip with devm counterpart
      mfd: da9063: Replace mfd_add_devices with devm counterpart
      mfd: da9063: Use regmap_reg_range
      mfd: da9063: Use REGMAP_IRQ_REG
      mfd: da9063: Use PLATFORM_DEVID_NONE
      mfd: da9063: Replace DA9063_NUM_IRQ with ARRAY_SIZE
      mfd: da9063: Rename PMIC_DA9063 to PMIC_CHIP_ID_DA9063
      mfd: da9063: Replace model with type
      mfd: da9063: Add DA9063L type
      mfd: da9063: Add custom regmap for DA9063L
      mfd: da9063: Add custom IRQ map for DA9063L
      mfd: da9063: Register RTC only on DA9063L
      regulator: da9063: Handle less LDOs on DA9063L
      mfd: da9063: Add DA9063L support

Matti Vaittinen (2):
      mfd: bd71837: Core driver for ROHM BD71837 PMIC
      mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC

Mika Westerberg (1):
      mfd: intel-lpss: Add Ice Lake PCI IDs

Neil Armstrong (6):
      media: cec-notifier: Get notifier by device and connector name
      drm/i915: hdmi: add CEC notifier to intel_hdmi
      mfd: cros-ec: Increase maximum mkbp event size
      mfd: cros-ec: Introduce CEC commands and events definitions.
      mfd: cros_ec_dev: Add CEC sub-device registration
      media: platform: Add ChromeOS EC CEC driver

Rafael David Tinoco (1):
      mfd: hi655x: Fix regmap area declared size for hi655x

Richard Fitzgerald (10):
      mfd: madera: Add register definitions for Cirrus Logic Madera codecs
      mfd: madera: Add DT bindings for Cirrus Logic Madera codecs
      mfd: madera: Add common support for Cirrus Logic Madera codecs
      mfd: madera: Register map tables for Cirrus Logic CS47L35
      mfd: madera: Register map tables for Cirrus Logic CS47L85
      mfd: madera: Register map tables for Cirrus Logic CS47L90/91
      pinctrl: madera: Add DT bindings for Cirrus Logic Madera codecs
      pinctrl: madera: Add driver for Cirrus Logic Madera codecs
      gpio: madera: Support Cirrus Logic Madera class codecs
      mfd: madera: Add register definitions for accessory detect

Sameer Nanda (1):
      mfd: cros_ec: Add USBPD charger commands and struct definitions.

Sebastian Andrzej Siewior (1):
      mfd: dln2: Use irqsave() in USB's complete callback

Zumeng Chen (1):
      mfd: ti_am335x_tscadc: Fix struct clk memory leak

 Documentation/devicetree/bindings/mfd/as3722.txt   |    2 +
 Documentation/devicetree/bindings/mfd/axp20x.txt   |    7 +-
 Documentation/devicetree/bindings/mfd/madera.txt   |  102 +
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   62 +
 Documentation/devicetree/bindings/mfd/tps65910.txt |    2 +-
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |   99 +
 MAINTAINERS                                        |   16 +
 arch/arm/configs/exynos_defconfig                  |    4 +-
 arch/arm/configs/multi_v7_defconfig                |    4 +-
 arch/arm/configs/pxa_defconfig                     |    4 +-
 arch/arm64/configs/defconfig                       |    4 +-
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-madera.c                         |  206 +
 drivers/gpu/drm/i915/Kconfig                       |    1 +
 drivers/gpu/drm/i915/intel_display.h               |   24 +
 drivers/gpu/drm/i915/intel_drv.h                   |    2 +
 drivers/gpu/drm/i915/intel_hdmi.c                  |   13 +
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/media/cec/cec-notifier.c                   |   11 +-
 drivers/media/platform/Kconfig                     |   11 +
 drivers/media/platform/Makefile                    |    2 +
 drivers/media/platform/cros-ec-cec/Makefile        |    1 +
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c   |  347 ++
 drivers/mfd/Kconfig                                |   83 +-
 drivers/mfd/Makefile                               |   17 +-
 drivers/mfd/arizona-core.c                         |   34 +-
 drivers/mfd/as3722.c                               |   12 +
 drivers/mfd/axp20x-i2c.c                           |    2 +
 drivers/mfd/axp20x.c                               |   28 +-
 drivers/mfd/cros_ec_dev.c                          |   32 +
 drivers/mfd/cs47l35-tables.c                       | 1609 ++++++++
 drivers/mfd/cs47l85-tables.c                       | 3009 +++++++++++++++
 drivers/mfd/cs47l90-tables.c                       | 2674 +++++++++++++
 drivers/mfd/da9063-core.c                          |   44 +-
 drivers/mfd/da9063-i2c.c                           |  239 +-
 drivers/mfd/da9063-irq.c                           |  264 +-
 drivers/mfd/dln2.c                                 |   10 +-
 drivers/mfd/hi655x-pmic.c                          |    2 +-
 drivers/mfd/intel-lpss-pci.c                       |   13 +
 drivers/mfd/kempld-core.c                          |   15 +-
 drivers/mfd/madera-core.c                          |  609 +++
 drivers/mfd/madera-i2c.c                           |  140 +
 drivers/mfd/madera-spi.c                           |  139 +
 drivers/mfd/madera.h                               |   44 +
 drivers/mfd/rave-sp.c                              |  119 +-
 drivers/mfd/rohm-bd718x7.c                         |  211 ++
 drivers/mfd/sec-core.c                             |    1 +
 drivers/mfd/sm501.c                                |    1 +
 drivers/mfd/ti_am335x_tscadc.c                     |    3 +-
 drivers/mfd/wm8994-core.c                          |   15 +-
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/cirrus/Kconfig                     |   14 +
 drivers/pinctrl/cirrus/Makefile                    |   13 +
 drivers/pinctrl/cirrus/pinctrl-cs47l35.c           |   45 +
 drivers/pinctrl/cirrus/pinctrl-cs47l85.c           |   59 +
 drivers/pinctrl/cirrus/pinctrl-cs47l90.c           |   57 +
 drivers/pinctrl/cirrus/pinctrl-madera-core.c       | 1076 ++++++
 drivers/pinctrl/cirrus/pinctrl-madera.h            |   41 +
 drivers/platform/chrome/Kconfig                    |   20 +
 drivers/platform/chrome/Makefile                   |    2 +
 drivers/{mfd => platform/chrome}/cros_ec_i2c.c     |    0
 drivers/platform/chrome/cros_ec_proto.c            |   40 +-
 drivers/{mfd => platform/chrome}/cros_ec_spi.c     |    0
 drivers/regulator/da9063-regulator.c               |   84 +-
 include/linux/mfd/as3722.h                         |    3 +
 include/linux/mfd/cros_ec.h                        |    2 +-
 include/linux/mfd/cros_ec_commands.h               |  229 +-
 include/linux/mfd/da9063/core.h                    |   15 +-
 include/linux/mfd/madera/core.h                    |  187 +
 include/linux/mfd/madera/pdata.h                   |   59 +
 include/linux/mfd/madera/registers.h               | 3968 ++++++++++++++++++++
 include/linux/mfd/rave-sp.h                        |    1 +
 include/linux/mfd/rohm-bd718x7.h                   |  332 ++
 include/linux/mfd/wm8994/pdata.h                   |    6 +
 include/media/cec-notifier.h                       |   27 +-
 77 files changed, 16124 insertions(+), 460 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 create mode 100644 drivers/gpio/gpio-madera.c
 create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
 create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c
 create mode 100644 drivers/mfd/cs47l35-tables.c
 create mode 100644 drivers/mfd/cs47l85-tables.c
 create mode 100644 drivers/mfd/cs47l90-tables.c
 create mode 100644 drivers/mfd/madera-core.c
 create mode 100644 drivers/mfd/madera-i2c.c
 create mode 100644 drivers/mfd/madera-spi.c
 create mode 100644 drivers/mfd/madera.h
 create mode 100644 drivers/mfd/rohm-bd718x7.c
 create mode 100644 drivers/pinctrl/cirrus/Kconfig
 create mode 100644 drivers/pinctrl/cirrus/Makefile
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l35.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l85.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l90.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera-core.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera.h
 rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
 rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)
 create mode 100644 include/linux/mfd/madera/core.h
 create mode 100644 include/linux/mfd/madera/pdata.h
 create mode 100644 include/linux/mfd/madera/registers.h
 create mode 100644 include/linux/mfd/rohm-bd718x7.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
