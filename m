Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755513AbeDCLKa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 07:10:30 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45710 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755361AbeDCLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 07:10:24 -0400
X-Google-Smtp-Source: AIpwx48JbCEB4dxb9kXkQDXsjhBGAfE4Lyei1CDLvJ/KskO2y06+gWw3zg4B6gUdQea78yiIFme8lN6vBkIQZXeRRPw=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 3 Apr 2018 13:10:22 +0200
Message-ID: <CACRpkdZru02jw0eBmJOnAQrxgsUk9FRRA6W7E2R_U8uXKk2P9w@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w33BAovW022667

Hi Linus,

here is the bulk of pin control changes for the v4.17 kernel cycle,
all details are in the signed tag as usual.

This has seen some rotation in linux-next and should be a smooth
merge, I just tested to pull it into your tree and all seems to
work fine.

Some ACKed deletions already came in from Arnd Bergman as
we dropped the Blackfin ADI2 drivers, making this a more or less
+/-0 merge window in the end.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.17-1

for you to fetch changes up to 4fc97ef94bbfa185d16b3e44199b7559d0668747:

  pinctrl: uniphier: add UART hardware flow control pin-mux settings
(2018-03-27 15:14:43 +0200)

----------------------------------------------------------------
Pin control bulk changes for the v4.17 kernel cycle:

New drivers:

- Qualcomm SDM845: this is their new flagship SoC platform
  which seems to be targeted at premium mobile handsets.

- Renesas R-Car M3-N SoC.

- Renesas R8A77980 SoC.

- NXP (ex Freescale) i.MX 6SLL SoC.

- Mediatek MT2712 SoC.

- Allwinner H6 SoC.

Improvements:

- Uniphier adds a few new functions and pins.

- Renesas refactorings and additional pin definitions.

- Improved pin groups for Axis Artpec6.

Cleanup:

- Drop the TZ1090 drivers. This platform is no longer
  maintained and is being deleted.

- Drop ST-Ericsson U8540/U9540 support as this was never
  productified.

- Overall minor fixes and janitorial.

----------------------------------------------------------------
Alexandre Belloni (1):
      pinctrl: ocelot: fix gpio direction

Andre Przywara (1):
      pinctrl: sunxi: always look for apb block

Andy Shevchenko (1):
      pinctrl: Re-use DEFINE_SHOW_ATTRIBUTE() macro

Bai Ping (2):
      dt-bindings: imx: update pinctrl doc for imx6sll
      pinctrl: imx: Add pinctrl driver support for imx6sll

Bjorn Andersson (2):
      dt-bindings: pinctrl: Add Qualcomm SDM845 TLMM binding
      pinctrl: msm: Use dynamic GPIO numbering

Colin Ian King (1):
      pinctrl: ocelot: make function ocelot_pinctrl_probe static

Daniel Kurtz (2):
      pinctrl/amd: add get_direction handler
      pinctrl/amd: poll InterruptEnable bits in enable_irq

David Lechner (1):
      pinctrl: pinctrl-single: Fix pcs_request_gpio() when bits_per_mux != 0

Fabio Estevam (1):
      pinctrl: msm8998: Remove owner assignment from platform_driver

Geert Uytterhoeven (8):
      dt-bindings: pinctrl: sh-pfc: Correct SoC family name for R8A7778
      pinctrl: sh-pfc: r8a7790: Add missing TX_ER pin to avb_mii group
      pinctrl: sh-pfc: Add SH_PFC_PIN_GROUP_ALIAS()
      pinctrl: sh-pfc: r8a7795: Rename EtherAVB "mdc" pin group to "mdio"
      pinctrl: sh-pfc: r8a7795-es1: Rename EtherAVB "mdc" pin group to "mdio"
      pinctrl: sh-pfc: r8a7796: Rename EtherAVB "mdc" pin group to "mdio"
      pinctrl: sh-pfc: r8a77965: Rename EtherAVB "mdc" pin group to "mdio"
      pinctrl: sh-pfc: r8a77995: Rename EtherAVB "mdc" pin group to "mdio"

Gustavo A. R. Silva (1):
      pinctrl: mediatek: mtk-common: use true and false for boolean values

Icenowy Zheng (4):
      pinctrl: sunxi: refactor irq related register function to have desc
      pinctrl: sunxi: introduce IRQ bank conversion function
      pinctrl: sunxi: change irq_bank_base to irq_bank_map
      pinctrl: sunxi: add support for the Allwinner H6 main pin controller

Jacopo Mondi (3):
      pinctrl: sh-pfc: Initial R-Car M3-N support
      pinctrl: sh-pfc: r8a77965: Add SCIFs groups/functions
      pinctrl: sh-pfc: r8a77965: Add EtherAVB groups/functions

James Hogan (1):
      pinctrl: Drop TZ1090 drivers

Jan Kundrát (3):
      pinctrl: mcp23s08: spi: Fix regmap debugfs entries
      pinctrl: mcp23s08: spi: Add HW address to gpio_chip.label
      pinctrl: mcp23s08: spi: Fix duplicate pinctrl debugfs entries

Javier Arteaga (1):
      pinctrl: intel: Implement intel_gpio_get_direction callback

Jesper Nilsson (1):
      pinctrl: artpec-6: Add smaller groups for uarts

Katsuhiro Suzuki (2):
      pinctrl: uniphier: add PXs2 Audio in/out pin-mux settings
      pinctrl: uniphier: divide I2S and S/PDIF audio out pin-mux group

Kunihiko Hayashi (1):
      pinctrl: uniphier: add UART hardware flow control pin-mux settings

Kyle Yan (1):
      pinctrl: qcom: Add sdm845 pinctrl driver

Linus Walleij (4):
      pinctrl: nomadik: add USB functions for STn8815
      Merge tag 'sh-pfc-for-v4.17-tag1' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      Merge tag 'sh-pfc-for-v4.17-tag2' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      pinctrl: nomadik: Drop U8540/9540 support

Manivannan Sadhasivam (1):
      dt-bindings: pinctrl: Add bindings for Actions S900 SoC

Markus Elfring (1):
      pinctrl: sh-pfc: Use seq_puts() in sh_pfc_pin_dbg_show()

Martin Blumenstingl (1):
      pinctrl: meson: meson8b: fix requesting GPIOs greater than GPIOZ_3

Masahiro Yamada (1):
      pinctrl: stm32: add 'depends on HAS_IOMEM' to fix unmet dependency

Niklas Cassel (2):
      pinctrl: artpec6: dt: add missing pin group uart5nocts
      pinctrl: artpec6: dt: add smaller groups for uarts

Phil Reid (3):
      pinctrl: mcp23s08: fix probing of mcp23s18
      dt-bindings: pinctrl: mcp23s08: add documentation for drive-open-drain
      pinctrl: mcp23s08: add open drain configuration for irq output

Radoslaw Pietrzyk (1):
      pinctrl: stm32: Optimizes and enhances stm32gpio irqchip

Richard Fitzgerald (2):
      pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs
      pinctrl: core: Add missing EXPORT on pinctrl_register_mappings

Sean Wang (2):
      dt-bindings: pinctrl: mediatek: use - instead of _ in examples
      dt-bindings: pinctrl: mediatek: add bindings for I2C2 and SPI2 on MT7623

Sergei Shtylyov (3):
      pinctrl: sh-pfc: Add PORT_GP_CFG_25() helper macro
      pinctrl: sh-pfc: Add R8A77980 PFC support
      pinctrl: sh-pfc: r8a77970: Add EtherAVB pin groups

Takeshi Kihara (12):
      pinctrl: sh-pfc: r8a7795: Fix MOD_SEL register pin assignment
for SSI pins group
      pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment
for SSI pins group
      pinctrl: sh-pfc: r8a7796: Fix IPSR and MOD_SEL register pin
assignment for NDFC pins group
      pinctrl: sh-pfc: r8a7795: Add HDMI pins, groups and functions
      pinctrl: sh-pfc: r8a7795-es1: Add HDMI pins, groups and functions
      pinctrl: sh-pfc: r8a7796: Add HDMI pins, groups and functions
      pinctrl: sh-pfc: r8a7795: Add TMU pins, groups and functions
      pinctrl: sh-pfc: r8a7795-es1: Add TMU pins, groups and functions
      pinctrl: sh-pfc: r8a7796: Add TMU pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add support for INTC-EX IRQ pins
      pinctrl: sh-pfc: r8a77965: Add USB2.0 host pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add USB3.0 host pins, groups and functions

Ulrich Hecht (10):
      pinctrl: sh-pfc: r8a77995: Add DU pins, groups and function
      pinctrl: sh-pfc: r8a7796: Add VIN4, VIN5 pins, groups and functions
      pinctrl: sh-pfc: r8a7795: Add VIN4, VIN5 pins, groups and functions
      pinctrl: sh-pfc: r8a77995: Add VIN4 pins, groups and function
      pinctrl: sh-pfc: r8a7795: Correct VIN4 18-bit pins
      pinctrl: sh-pfc: r8a7796: Correct VIN4 18-bit pins
      pinctrl: sh-pfc: r8a77995: Correct VIN4 18-bit pins
      pinctrl: sh-pfc: r8a7795: Deduplicate VIN4 pin definitions
      pinctrl: sh-pfc: r8a7796: Deduplicate VIN4 pin definitions
      pinctrl: sh-pfc: r8a77995: Deduplicate VIN4 pin definitions

Zhiyong Tao (3):
      pinctrl: add mt2712 pinctrl driver
      pintcrl: mtk: support bias-disable of generic and special pins
simultaneously
      pinctrl: mtk: fix check warnings.

 .../bindings/pinctrl/actions,s900-pinctrl.txt      |  178 ++
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |    1 +
 .../bindings/pinctrl/axis,artpec6-pinctrl.txt      |   16 +-
 .../bindings/pinctrl/fsl,imx6sll-pinctrl.txt       |   40 +
 .../bindings/pinctrl/img,tz1090-pdc-pinctrl.txt    |  127 -
 .../bindings/pinctrl/img,tz1090-pinctrl.txt        |  227 --
 .../bindings/pinctrl/pinctrl-mcp23s08.txt          |    2 +
 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    4 +-
 .../bindings/pinctrl/qcom,sdm845-pinctrl.txt       |  176 ++
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    4 +-
 drivers/pinctrl/Kconfig                            |   12 -
 drivers/pinctrl/Makefile                           |    2 -
 drivers/pinctrl/core.c                             |  109 +-
 drivers/pinctrl/devicetree.c                       |    6 +-
 drivers/pinctrl/freescale/Kconfig                  |    7 +
 drivers/pinctrl/freescale/Makefile                 |    1 +
 drivers/pinctrl/freescale/pinctrl-imx6sll.c        |  360 +++
 drivers/pinctrl/intel/pinctrl-intel.c              |   19 +
 drivers/pinctrl/mediatek/Kconfig                   |    7 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2712.c          |  633 ++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   12 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h      |  840 ++---
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h      | 1757 +++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6397.h      |  123 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8127.h      |  429 +--
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h      |  609 ++--
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h      |  405 +--
 drivers/pinctrl/meson/pinctrl-meson8b.c            |   20 +-
 drivers/pinctrl/nomadik/Kconfig                    |   12 -
 drivers/pinctrl/nomadik/Makefile                   |    3 -
 drivers/pinctrl/nomadik/pinctrl-ab8540.c           |  408 ---
 drivers/pinctrl/nomadik/pinctrl-ab9540.c           |  486 ---
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |  197 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.h           |   44 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-db8540.c   | 1243 --------
 drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c  |   16 +-
 drivers/pinctrl/pinctrl-amd.c                      |   23 +
 drivers/pinctrl/pinctrl-artpec6.c                  |   66 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |   54 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |    4 +-
 drivers/pinctrl/pinctrl-single.c                   |   22 +-
 drivers/pinctrl/pinctrl-tz1090-pdc.c               |  989 ------
 drivers/pinctrl/pinctrl-tz1090.c                   | 2005 ------------
 drivers/pinctrl/qcom/Kconfig                       |    9 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    2 +-
 drivers/pinctrl/qcom/pinctrl-msm8998.c             |    1 -
 drivers/pinctrl/qcom/pinctrl-sdm845.c              | 1323 ++++++++
 drivers/pinctrl/sh-pfc/Kconfig                     |   10 +
 drivers/pinctrl/sh-pfc/Makefile                    |    2 +
 drivers/pinctrl/sh-pfc/core.c                      |   12 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               |    8 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c           |   82 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               |  410 ++-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  415 ++-
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 3243 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c              |   98 +
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c              | 2799 +++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c              |  221 +-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |    2 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   15 +-
 drivers/pinctrl/stm32/Kconfig                      |   12 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    3 +-
 drivers/pinctrl/sunxi/Kconfig                      |    4 +
 drivers/pinctrl/sunxi/Makefile                     |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          |  614 ++++
 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c          |    4 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c          |    4 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   25 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |   40 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c    |    5 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c   |    5 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c   |    5 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c   |    5 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c   |   40 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c   |    5 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c   |    5 +-
 include/dt-bindings/gpio/meson8b-gpio.h            |  121 +-
 include/dt-bindings/pinctrl/mt7623-pinfunc.h       |   24 +
 82 files changed, 13691 insertions(+), 7623 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/img,tz1090-pdc-pinctrl.txt
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/img,tz1090-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx6sll.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
 delete mode 100644 drivers/pinctrl/nomadik/pinctrl-ab8540.c
 delete mode 100644 drivers/pinctrl/nomadik/pinctrl-ab9540.c
 delete mode 100644 drivers/pinctrl/nomadik/pinctrl-nomadik-db8540.c
 delete mode 100644 drivers/pinctrl/pinctrl-tz1090-pdc.c
 delete mode 100644 drivers/pinctrl/pinctrl-tz1090.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm845.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77965.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77980.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
