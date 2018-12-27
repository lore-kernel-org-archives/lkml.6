Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E59C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7D3218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 09:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WK7nt5ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbeL0JXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:23:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42422 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbeL0JXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 04:23:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so15737198lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 01:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=u/vSs25j4ruvIJlH1GsCgfEvv5AlDueZPtV4r/dReJQ=;
        b=WK7nt5ub0nZ5giki4dFXZJ+pAj8BYF9EXHtMFdZiv16L2ouQYAwEftdsWlyo4lsuSx
         KQmITmebU7R6cQgVhWHxSUY9NJs7wRQgQ7LXYNHDy+MzKZdp3m/KhquM/ZvBipaZA15I
         kQk0YynB/3ZM7zd/HuFFqklckoLFvhM91v9wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=u/vSs25j4ruvIJlH1GsCgfEvv5AlDueZPtV4r/dReJQ=;
        b=ejXwgAJJdo61trACPH3EF2SrlKNdjYAZ+Mfw/1wvjfizD0PNK/vL7aJbTMdEfxMO6P
         mFlI+/eiHbSknyPR0uUTfDO1Bl2FWd3ZN7ks6RomPVl2xU3bKxfaAOc3oTrddJIltgaS
         rC5ib9ovlqbPrXZdQEVpEwXF998GctkN8CdESuyWSBfxZ9qiq5MgK5DbZyNMyD/ysE4s
         6nBcPl6tqFqsJTEnI/x0aw/1KppgCTfGbSrjwVj/iTZR/Ir+HR5+3QO+GVnsmoSIPgHN
         UBP+SpyZtxrzUPWhm7AMTgTWYnCys3cAXeAquLPnMjgGSOZnqKpAzVMdsDIglEvbvm4U
         bV4A==
X-Gm-Message-State: AJcUukeN/MX1Xhvj0zWB5mCwkmiBY7Dm5XnDZoaN9pGiGRcm5MzuUp4K
        Oq0JR9EWabRMrVeJqV4K7QDyVz04nqfRsQW+KGM62A==
X-Google-Smtp-Source: ALg8bN7Y5XOB3FjNo6RrBSqQ6NGsLjTU7D5Y+ny+32Nf42FVq++n0tuofH7u8W538cne/RVVcBUUXo2vLOkgCMvnYmo=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr8409399ljj.120.1545902626714;
 Thu, 27 Dec 2018 01:23:46 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Dec 2018 10:23:35 +0100
Message-ID: <CACRpkdYD7469+XPRhNHRVtwkQzsWJ5-AK7cD_yVcDCLko-P-dw@mail.gmail.com>
Subject: [GIT PULL] GPIO bulk changes for the v4.21 kernel
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the main part of the v4.21 GPIO changes.

Details are in the signed tag.

Some interesting changes have already trickled in
through the Regulator and MMC/SD trees but get
mentioned in the signed tag nevertheless.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a=
:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.21-1

for you to fetch changes up to a7c23f8d154f7919c5fcfceea6e0897be2d5ab71:

  gpio: sama5d2-piobu: Depend on OF_GPIO (2018-12-22 11:08:06 +0100)

----------------------------------------------------------------
This is the bulk of GPIO changes for the v4.21 kernel series:

Core changes:

- Some core changes are already in outside of this pull
  request as they came through the regulator tree, most
  notably devm_gpiod_unhinge() that removes devres refcount
  management from a GPIO descriptor. This is needed in
  subsystems such as regulators where the regulator core
  need to take over the reference counting and lifecycle
  management for a GPIO descriptor.

- We dropped devm_gpiochip_remove() and devm_gpio_chip_match()
  as nothing needs it. We can bring it back if need be.

- Add a global TODO so people see where we are going. This
  helps setting the direction now that we are two GPIO
  maintainers.

- Handle the MMC CD/WP properties in the device tree core.
  (The bulk of patches activating this code is already
  merged through the MMC/SD tree.)

- Augment gpiochip_request_own_desc() to pass a flag so
  we as gpiochips can request lines as active low or open
  drain etc even from ourselves.

New drivers:

- New driver for Cadence GPIO blocks.

- New driver for Atmel SAMA5D2 PIOBU GPIO lines.

Driver improvements:

- A major refactoring of the PCA953x driver - this driver has
  been around for ages, and is now modernized to reduce code
  duplication that has stacked up and is using regmap to read
  write and cache registers.

- Intel drivers are now maintained in a separate tree and
  start with a round of cleanups and unifications.

----------------------------------------------------------------
A.s. Dong (2):
      dt-bindings: gpio: vf610: add optional clocks property
      gpio: vf610: add optional clock support

Andrei.Stefanescu@microchip.com (2):
      dt-bindings: arm: atmel: describe SECUMOD usage as a GPIO controller
      gpio: add driver for SAMA5D2 PIOBU pins

Andy Shevchenko (27):
      MAINTAINERS: Do maintain Intel GPIO drivers via separate tree
      gpio: pch: Convert to use managed functions pcim_* and devm_*
      gpio: sodaville: Convert to use managed functions pcim_* and devm_*
      gpio: pch: Convert to dev_pm_ops
      gpio: lynxpoint: Use for_each_set_bit() in IRQ handler
      gpio: pch: Use for_each_set_bit() in IRQ handler
      gpio: sodaville: Use for_each_set_bit() in IRQ handler
      gpio: ich: Simplify error handling in ichx_write_bit()
      gpio: ich: Switch to use struct device instead of platform_device
      gpio: ich: Convert pr_<level> to dev_<level>
      gpio: ich: Join string literals back
      gpio: pch: Remove redundant __func__ from debug print
      gpio: pch: Remove duplicate assignments
      gpio: intel-mid: Remove linux/module.h and sort headers
      gpio: lynxpoint: Remove linux/init.h and sort headers
      gpio: merrifield: Remove linux/init.h
      gpio: sch: Remove linux/init.h and sort headers
      gpio: ich: Sort headers alphabetically
      gpio: pch: Sort headers alphabetically
      gpio: sodaville: Sort headers alphabetically
      gpio: ich: Convert to use SPDX identifier
      gpio: intel-mid: Convert to use SPDX identifier
      gpio: lynxpoint: Convert to use SPDX identifier
      gpio: merrifield: Convert to use SPDX identifier
      gpio: pch: Convert to use SPDX identifier
      gpio: sch: Convert to use SPDX identifier
      gpio: sodaville: Convert to use SPDX identifier

Anson Huang (1):
      gpio: mxc: move gpio noirq suspend/resume to syscore phase

Bartosz Golaszewski (1):
      MAINTAINERS: remove a duplicate entry for gpio-mockup

Brajeswar Ghosh (1):
      drivers/gpio/gpio-grgpio.c: Remove duplicate header

Brandon Maier (1):
      gpio: zynq: Report gpio direction at boot

Colin Ian King (2):
      gpio: sch311x: clean an indentation issue, remove extraneous space
      gpiolib-acpi: remove unused variable 'err', cleans up build warning

Fabrizio Castro (1):
      dt-bindings: gpio: rcar: Add r8a774c0 (RZ/G2E) support

Jan Kotas (2):
      dt-bindings: gpio: Add bindings for Cadence GPIO
      gpio: Add Cadence GPIO driver

Johan Hovold (1):
      gpio: drop broken to_gpio_irq_chip() helper

Krzysztof Kozlowski (1):
      gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB

Kuninori Morimoto (1):
      gpio: rcar: convert to SPDX identifiers

Laurent Pinchart (1):
      gpio: drop devm_gpio_chip_match()

Linus Walleij (9):
      gpio: Add global TODO file for GPIO
      gpio: OF: Parse MMC-specific CD and WP properties
      gpio: Pass a flag to gpiochip_request_own_desc()
      Merge tag 'intel-gpio-v4.21-1' of
git://git.kernel.org/.../andy/linux-gpio-intel into devel
      Merge branch 'ib-pca953x' into devel
      ARM: omap1: Fix new user of gpiochip_request_own_desc()
      memory: omap-gpmc: Get the header of the enum
      gpio/mmc/of: Respect polarity in the device tree
      gpio: sama5d2-piobu: Depend on OF_GPIO

Manivannan Sadhasivam (1):
      gpio: pl061: Move irq_chip definition inside struct pl061

Marek Vasut (15):
      gpio: pca953x: Deduplicate the bank_shift
      gpio: pca953x: Fix AI overflow on PCAL6524
      gpio: pca953x: Repair multi-byte IO address increment on PCA9575
      gpio: pca953x: Unify pca95{3,7}x_write_regs_16()
      gpio: pca953x: Unify pca953x_{read,write}_regs_{16,24}()
      gpio: pca953x: Unify pca953x_{read,write}_regs_{8,mul}()
      gpio: pca953x: Factor out common code from device_pca95xx_init()
      gpio: pca953x: Zap ad-hoc I2C block write in multi GPIO set
      gpio: pca953x: Extract the register address mangling to single functi=
on
      gpio: pca953x: Perform basic regmap conversion
      gpio: pca953x: Zap ad-hoc reg_direction cache
      gpio: pca953x: Zap ad-hoc reg_output cache
      gpio: pca953x: Zap single use of pca953x_read_single()
      gpio: pca953x: Restore registers after suspend/resume cycle
      gpio: pca953x: Add regmap dependency for PCA953x driver

Masahiro Yamada (1):
      gpio: uniphier: convert to SPDX License Identifier

Muchun Song (1):
      gpiolib: Fix possible use after free on label

Nicholas Mc Guire (2):
      gpio: mt7621: report failure of devm_kasprintf()
      gpio: mt7621: pass mediatek_gpio_bank_probe() failure up the stack

Nicolas Saenz Julienne (1):
      gpio: raspberrypi-exp: decrease refcount on firmware dt node

Phil Edworthy (1):
      gpio: dwapb: Correct the DT node name in the example

Tao Ren (1):
      gpio: aspeed: remove duplicated statement

Thierry Reding (2):
      dt-bindings: tegra186-gpio: Add Tegra186 specific prefix
      gpio: tegra186: Rename flow variable to type

Uwe Kleine-K=C3=B6nig (2):
      gpio: drop devm_gpiochip_remove()
      gpio: mxs: read pin level directly instead of using .get

Vladimir Zapolskiy (8):
      gpio: restore original GPLv2+ license of gpiolib-of.c sources
      gpio: rcar: reference device instead of platform device
      gpio: lpc18xx: use SPDX license identifier
      gpio: lpc18xx: add struct device local variable
      gpio: lpc18xx: use resource managed interface to register GPIO contro=
ller
      gpio: lpc18xx: add GPIO pin interrupt controller support
      dt-bindings: gpio: lpc18xx: describe interrupt controllers of
GPIO controller
      gpio: lpc18xx: fix GPIO controller driver build as a module

William Breathitt Gray (6):
      gpio: 104-dio-48e: Mask read inputs for get_multiple
      gpio: 104-idi-48e: Mask the read inputs for get_multiple
      gpio: gpio-mm: Mask read inputs for get_multiple
      gpio: ws16c48: Mask read inputs for get_multiple
      gpio: pci-idio-16: Mask read inputs for get_multiple
      gpio: pcie-idio-24: Mask read inputs for get_multiple

Wolfram Sang (6):
      gpio: gpio-dwapb: simplify getting .driver_data
      gpio: gpio-lynxpoint: simplify getting .driver_data
      gpio: gpio-mxc: simplify getting .driver_data
      gpio: gpio-omap: simplify getting .driver_data
      gpio: gpio-zynq: simplify getting .driver_data
      gpio: gpio-tegra: simplify getting .driver_data

Yangtao Li (1):
      gpio: ks8695: Change to use DEFINE_SHOW_ATTRIBUTE macro

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  12 +-
 .../devicetree/bindings/gpio/cdns,gpio.txt         |  43 ++
 .../devicetree/bindings/gpio/gpio-vf610.txt        |   6 +
 .../devicetree/bindings/gpio/nxp,lpc1850-gpio.txt  |  38 +-
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |   4 +-
 Documentation/driver-api/gpio/driver.rst           |   4 +-
 Documentation/driver-model/devres.txt              |   1 -
 MAINTAINERS                                        |  40 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                |   2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   4 +-
 drivers/gpio/Kconfig                               |  22 +
 drivers/gpio/Makefile                              |   2 +
 drivers/gpio/TODO                                  | 109 +++++
 drivers/gpio/gpio-104-dio-48e.c                    |   2 +-
 drivers/gpio/gpio-104-idi-48.c                     |   2 +-
 drivers/gpio/gpio-aspeed.c                         |   1 -
 drivers/gpio/gpio-cadence.c                        | 291 +++++++++++++
 drivers/gpio/gpio-dwapb.c                          |   6 +-
 drivers/gpio/gpio-gpio-mm.c                        |   2 +-
 drivers/gpio/gpio-grgpio.c                         |   1 -
 drivers/gpio/gpio-ich.c                            |  73 ++--
 drivers/gpio/gpio-intel-mid.c                      |  16 +-
 drivers/gpio/gpio-ks8695.c                         |  15 +-
 drivers/gpio/gpio-lpc18xx.c                        | 286 +++++++++++-
 drivers/gpio/gpio-lynxpoint.c                      |  47 +-
 drivers/gpio/gpio-merrifield.c                     |   6 +-
 drivers/gpio/gpio-mt7621.c                         |  10 +-
 drivers/gpio/gpio-mvebu.c                          |   2 +-
 drivers/gpio/gpio-mxc.c                            |  41 +-
 drivers/gpio/gpio-mxs.c                            |   2 +-
 drivers/gpio/gpio-omap.c                           |  12 +-
 drivers/gpio/gpio-pca953x.c                        | 484 +++++++++++++----=
----
 drivers/gpio/gpio-pch.c                            | 165 ++-----
 drivers/gpio/gpio-pci-idio-16.c                    |   2 +-
 drivers/gpio/gpio-pcie-idio-24.c                   |   2 +-
 drivers/gpio/gpio-pl061.c                          |  21 +-
 drivers/gpio/gpio-raspberrypi-exp.c                |   1 +
 drivers/gpio/gpio-rcar.c                           |  34 +-
 drivers/gpio/gpio-sama5d2-piobu.c                  | 253 +++++++++++
 drivers/gpio/gpio-sch.c                            |  27 +-
 drivers/gpio/gpio-sch311x.c                        |   2 +-
 drivers/gpio/gpio-sodaville.c                      |  73 ++--
 drivers/gpio/gpio-tegra.c                          |   6 +-
 drivers/gpio/gpio-tegra186.c                       |   6 +-
 drivers/gpio/gpio-uniphier.c                       |  17 +-
 drivers/gpio/gpio-vf610.c                          |  44 ++
 drivers/gpio/gpio-ws16c48.c                        |   2 +-
 drivers/gpio/gpio-zynq.c                           |  29 +-
 drivers/gpio/gpiolib-acpi.c                        |  14 +-
 drivers/gpio/gpiolib-of.c                          |  26 +-
 drivers/gpio/gpiolib.c                             |  76 ++--
 drivers/hid/hid-cp2112.c                           |   2 +-
 drivers/memory/omap-gpmc.c                         |   4 +-
 include/dt-bindings/gpio/tegra186-gpio.h           |  41 ++
 include/linux/gpio/consumer.h                      |   8 +-
 include/linux/gpio/driver.h                        |  10 +-
 57 files changed, 1762 insertions(+), 690 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/cdns,gpio.txt
 create mode 100644 drivers/gpio/TODO
 create mode 100644 drivers/gpio/gpio-cadence.c
 create mode 100644 drivers/gpio/gpio-sama5d2-piobu.c
