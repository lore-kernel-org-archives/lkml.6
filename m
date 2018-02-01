Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeBAReK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:34:10 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41169 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeBAReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:34:07 -0500
X-Google-Smtp-Source: AH8x227JeR5dGDqp/2a5+T3f8CbgTbBu4ISWtiKrT4Wq5PNNHYCUNX2XBpUPHVIka8fGzH0J8COZFgeq5IxLEsNkH2E=
MIME-Version: 1.0
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 1 Feb 2018 11:33:46 -0600
Message-ID: <CAL_JsqLyk84TBTV9ZWZohD7s-GWC9m2G2riZ4NwxYqQGf2FkAw@mail.gmail.com>
Subject: [GIT PULL] DeviceTree updates for 4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11HYFEn018535

Linus,

Please pull DT updates for 4.16. There will be a trivial context
conflict with the PCI tree in drivers/of/Kconfig, but looks like I'm
first.

Rob

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-4.16

for you to fetch changes up to 3a6fbcb2e2e4b263df1cc8647ce1858c57ddc805:

  xtensa: remove arch specific early DT functions (2018-01-30 11:17:37 -0600)

----------------------------------------------------------------
DeviceTree updates for 4.16:

- Convert to use memblock_virt_alloc in DT code which supports bootmem
  arches. With this we can remove the arch specific
  early_init_dt_alloc_memory_arch() functions.

- Enable running the DT unittests on UML

- Use SPDX license tags on DT files

- Fix early FDT kconfig ifdef logic

- Clean-up unittest Makefile

- Fix function comment for of_irq_parse_raw

- Add missing documentation for linux,initrd-{start,end} properties

- Clean-up of binding examples using uppercase hex

- Add trivial devices W83773G and Infineon TLV493D-A1B6

- Add missing STM32 SoC bindings

- Various small binding doc fixes

----------------------------------------------------------------
Andreas Färber (1):
      dt-bindings: Add Infineon TLV493D-A1B6

Fabio Estevam (1):
      dt-bindings: imx6q-pcie: Add required property for i.MX6SX

Geert Uytterhoeven (1):
      of/fdt: Fix #ifdef dependency of early flattree declarations

Jonathan Neuschäfer (2):
      dt-bindings: chosen: Document linux,initrd-{start,end}
      dt-bindings: display: panel: Fix compatible string for Toshiba
LT089AC29000

Lei YU (1):
      dt-bindings: Add W83773G as a trivial device

Ludovic Barre (1):
      dt-bindings: arm: document supported STM32 SoC family

Masahiro Yamada (2):
      of: unittest: refactor Makefile
      libfdt: remove unnecessary include directive from <linux/libfdt.h>

Nishanth Menon (1):
      dt-bindings: mailbox: ti,message-manager: Fix interrupt name error

Rob Herring (10):
      of: enable unittests on UML
      dt-bindings: Use lower case hex in unit-addresses
      of: Use SPDX license tag for DT files
      of/fdt: use memblock_virt_alloc for early alloc
      cris: remove arch specific early DT functions
      metag: remove arch specific early DT functions
      mips: remove arch specific early_init_dt_alloc_memory_arch
      nios2: remove arch specific early_init_dt_alloc_memory_arch
      x86: remove arch specific early_init_dt_alloc_memory_arch
      xtensa: remove arch specific early DT functions

Simon Horman (1):
      dt-bindings: h8300 clocksource: correct spelling of pulse

Tuomas Tynkkynen (1):
      mmc: Don't reference Linux-specific OF_GPIO_ACTIVE_LOW flag in DT binding

Vasyl Gomonovych (1):
      of: irq: Fix function description comment

 .../devicetree/bindings/arm/samsung/exynos-adc.txt  |  6 +++---
 .../bindings/arm/samsung/samsung-boards.txt         |  2 +-
 Documentation/devicetree/bindings/arm/stm32.txt     |  9 +++++++++
 Documentation/devicetree/bindings/chosen.txt        | 15 +++++++++++++++
 .../devicetree/bindings/clock/exynos3250-clock.txt  |  2 +-
 .../devicetree/bindings/clock/exynos5260-clock.txt  |  2 +-
 .../devicetree/bindings/clock/exynos5410-clock.txt  |  2 +-
 .../devicetree/bindings/clock/exynos5433-clock.txt  |  2 +-
 .../devicetree/bindings/crypto/atmel-crypto.txt     |  2 +-
 .../bindings/devfreq/event/exynos-nocp.txt          |  2 +-
 .../bindings/display/exynos/exynos_dsim.txt         |  2 +-
 .../bindings/display/panel/toshiba,lt089ac29000.txt |  2 +-
 .../devicetree/bindings/display/st,stih4xx.txt      |  2 +-
 Documentation/devicetree/bindings/dma/ste-dma40.txt |  2 +-
 .../devicetree/bindings/gpio/abilis,tb10x-gpio.txt  |  2 +-
 .../devicetree/bindings/gpio/gpio-stp-xway.txt      |  2 +-
 Documentation/devicetree/bindings/gpio/gpio.txt     |  2 +-
 .../bindings/i2c/i2c-arb-gpio-challenge.txt         |  2 +-
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt       |  2 +-
 .../devicetree/bindings/input/samsung-keypad.txt    |  2 +-
 .../input/touchscreen/brcm,iproc-touchscreen.txt    |  2 +-
 .../devicetree/bindings/iommu/samsung,sysmmu.txt    |  2 +-
 .../devicetree/bindings/mailbox/omap-mailbox.txt    |  2 +-
 .../bindings/mailbox/ti,message-manager.txt         |  4 ++--
 Documentation/devicetree/bindings/media/s5p-cec.txt |  2 +-
 .../devicetree/bindings/media/samsung-s5c73m3.txt   |  2 +-
 .../bindings/memory-controllers/ti-aemif.txt        |  2 +-
 Documentation/devicetree/bindings/mfd/cros-ec.txt   |  2 +-
 Documentation/devicetree/bindings/mmc/mmc.txt       |  4 ++--
 .../devicetree/bindings/mtd/lpc32xx-mlc.txt         |  2 +-
 Documentation/devicetree/bindings/net/cpsw.txt      |  4 ++--
 .../devicetree/bindings/net/davinci-mdio.txt        |  4 ++--
 .../devicetree/bindings/net/fsl-tsec-phy.txt        |  2 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt      |  1 +
 Documentation/devicetree/bindings/phy/ti-phy.txt    |  2 +-
 .../bindings/pinctrl/abilis,tb10x-iomux.txt         |  6 +++---
 .../bindings/pinctrl/img,pistachio-pinctrl.txt      |  2 +-
 .../bindings/pinctrl/lantiq,pinctrl-xway.txt        |  2 +-
 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt  |  2 +-
 .../bindings/powerpc/fsl/interlaken-lac.txt         | 12 ++++++------
 .../bindings/regulator/st,stm32-vrefbuf.txt         |  2 +-
 .../devicetree/bindings/serial/lantiq_asc.txt       |  2 +-
 .../devicetree/bindings/sound/img,i2s-out.txt       |  2 +-
 .../devicetree/bindings/sound/img,parallel-out.txt  |  2 +-
 .../devicetree/bindings/sound/img,spdif-in.txt      |  2 +-
 .../devicetree/bindings/sound/img,spdif-out.txt     |  2 +-
 .../devicetree/bindings/sound/st,sti-asoc-card.txt  |  8 ++++----
 .../devicetree/bindings/spi/spi-davinci.txt         |  2 +-
 .../devicetree/bindings/spi/spi-lantiq-ssc.txt      |  2 +-
 .../devicetree/bindings/thermal/exynos-thermal.txt  |  2 +-
 .../devicetree/bindings/thermal/thermal.txt         |  6 +++---
 .../devicetree/bindings/timer/renesas,tpu.txt       |  2 +-
 .../bindings/timer/samsung,exynos4210-mct.txt       |  2 +-
 .../devicetree/bindings/trivial-devices.txt         |  2 ++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt    |  2 +-
 .../devicetree/bindings/watchdog/samsung-wdt.txt    |  2 +-
 arch/cris/kernel/Makefile                           | 19 -------------------
 arch/cris/kernel/devicetree.c                       | 15 ---------------
 arch/metag/kernel/devtree.c                         | 14 --------------
 arch/mips/kernel/prom.c                             |  5 -----
 arch/nios2/kernel/prom.c                            |  5 -----
 arch/x86/kernel/devicetree.c                        |  6 ------
 arch/xtensa/kernel/setup.c                          | 12 ------------
 drivers/of/Kconfig                                  |  6 ++++--
 drivers/of/address.c                                |  2 +-
 drivers/of/base.c                                   |  6 +-----
 drivers/of/device.c                                 |  1 +
 drivers/of/dynamic.c                                |  1 +
 drivers/of/fdt.c                                    | 21 +++++----------------
 drivers/of/fdt_address.c                            |  6 +-----
 drivers/of/irq.c                                    |  9 ++-------
 drivers/of/kobj.c                                   |  2 +-
 drivers/of/of_numa.c                                | 13 +------------
 drivers/of/of_private.h                             |  6 +-----
 drivers/of/of_reserved_mem.c                        |  6 +-----
 drivers/of/overlay.c                                |  5 +----
 drivers/of/pdt.c                                    |  6 +-----
 drivers/of/platform.c                               |  7 +------
 drivers/of/property.c                               |  6 +-----
 drivers/of/resolver.c                               |  5 +----
 drivers/of/unittest-data/Makefile                   | 19 +++++--------------
 drivers/of/unittest-data/overlay_bad_symbol.dts     |  1 +
 drivers/of/unittest.c                               | 11 ++++++++---
 include/linux/libfdt.h                              |  1 -
 include/linux/of.h                                  |  6 +-----
 include/linux/of_dma.h                              |  5 +----
 include/linux/of_fdt.h                              | 18 +++++++++---------
 include/linux/of_gpio.h                             |  6 +-----
 include/linux/of_graph.h                            |  5 +----
 include/linux/of_pdt.h                              |  6 +-----
 include/linux/of_platform.h                         |  7 +------
 91 files changed, 151 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32.txt
 delete mode 100644 arch/cris/kernel/devicetree.c
