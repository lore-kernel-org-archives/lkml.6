Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeBBN2N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:28:13 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:44245 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbeBBN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:28:02 -0500
X-Google-Smtp-Source: AH8x227hB6Y1v0WF4FgCBsK+EYiYLxhuFqPzHzfhyRdvhmQns9PIbjjxvUBtDrQ5zH81woWPXnKMcOZzMnEEHmunsSw=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Feb 2018 14:28:00 +0100
Message-ID: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the big slew of changes in pin control for the v4.16 cycle.
Like with GPIO it is actually a bit calm this time. The patches moving
AXP209 from GPIO to pin control appear again (with the same
hashes) and everything should be just smooth.

Details are in the signed tag as usual.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.16-1

for you to fetch changes up to 02e389e63e3523828fc3832f27e0341885f60f6f:

  pinctrl: mcp23s08: fix irq setup order (2018-01-30 15:17:14 +0100)

----------------------------------------------------------------
This is the bulk of pin control changes for the v4.16 kernel cycle:

Core changes:

- After lengthy discussions and partly due to my ignorance, we have
  merged a patch making pinctrl_force_default() and pinctrl_force_sleep()
  reprogram the states into the hardware of any hogged pins, even
  if they are already in the desired state. This only apply to hogged
  pins since groups of pins owned by drivers need to be managed by
  each driver, lest they could not do things like runtime PM and
  put pins to sleeping state even if the system as a whole is not
  in sleep.

New drivers:

- New driver for the Microsemi Ocelot SoC. This is used in ethernet
  switches.

- The X-Powers AXP209 GPIO driver was extended to also deal with pin
  control and moved over from the GPIO subsystem. This circuit is
  a mixed-mode integrated circuit which is part of AllWinner designs.

- New subdriver for the Qualcomm MSM8998 SoC, core of a high end
  mobile devices (phones) chipset.

- New subdriver for the ST Microelectronics STM32MP157 MPU and
  STM32F769 MCU from the STM32 family.

- New subdriver for the MediaTek MT7622 SoC. This is used for routers,
  repeater, gateways and such network infrastructure.

- New subdriver for the NXP (former Freescale) i.MX 6ULL. This SoC has
  multimedia features and target "smart devices", I guess in-car
  entertainment, in-flight entertainment, industrial control panels etc.

General improvements:

- Incremental improvements on the SH-PFC subdrivers for things like
  the CAN bus.

- Enable the glitch filter on Baytrail GPIOs used for interrupts.

- Proper handling of pins to GPIO ranges on the Semtec SX150X

- An IRQ setup ordering fix on MCP23S08.

- A good set of janitorial coding style fixes.

----------------------------------------------------------------
Alexandre Belloni (2):
      dt-bindings: pinctrl: Add bindings for Microsemi Ocelot
      pinctrl: Add Microsemi Ocelot SoC driver

Alexandre Torgue (2):
      dt-bindings: pinctrl: stm32: fix copyright and adopt SPDX identifier
      pinctrl: stm32: add STM32F769 MCU support

Andy Shevchenko (1):
      pinctrl: intel: merrifield: Introduce ACPI device table

Bai Ping (1):
      pinctrl: imx6ul: add IOMUXC SNVS pinctrl driver for i.MX 6ULL

Benjamin Gaignard (1):
      pinctrl: stm32: Fix copyright

Biju Das (1):
      pinctrl: sh-pfc: r8a7794: Add i2c5 pin groups and function

Brian Norris (1):
      pinctrl: rockchip: enable clock when reading pin direction register

Colin Ian King (1):
      pinctrl: intel: ensure error return ret is initialized

Dmitry Mastykin (1):
      pinctrl: mcp23s08: fix irq setup order

Fabrizio Castro (6):
      pinctrl: sh-pfc: r8a7745: Add CAN[01] support
      pinctrl: sh-pfc: r8a7794: Add can_clk function
      pinctrl: sh-pfc: r8a7791: Add can_clk function
      pinctrl: sh-pfc: r8a7794: Add PWM[0123456] support
      pinctrl: sh-pfc: r8a7794: Add tpu groups and function
      pinctrl: sh-pfc: r8a7791: Add tpu groups and function

Florian Fainelli (1):
      pinctrl: Really force states during suspend/resume

Geert Uytterhoeven (1):
      pinctrl: sunxi: Use of_clk_get_parent_count() instead of open coding

Hans de Goede (1):
      pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts

Icenowy Zheng (1):
      pinctrl: sunxi: fix a typo when merging A20 support to A10 driver

Jesse Chan (1):
      pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Julia Lawall (3):
      pinctrl: at91-pio4: account for const type of of_device_id.data
      pinctrl: axp209: account for const type of of_device_id.data
      pinctrl: armada-37xx: account for const type of of_device_id.data

Khan, Imran (1):
      pinctrl: qcom: Add msm8998 pinctrl driver

Krzysztof Kozlowski (1):
      pinctrl: samsung: Add SPDX license identifiers

Ladislav Michl (1):
      pinctrl: Forward declare struct device

Linus Walleij (5):
      pinctrl: gemini: Add two missing GPIO groups
      pinctrl: gemini: Support drive strength setting
      Merge branch 'ib-move-axp209' of /home/linus/linux-gpio into devel
      Merge tag 'sh-pfc-for-v4.16-tag1' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      Merge tag 'sh-pfc-for-v4.16-tag2' of
git://git.kernel.org/.../geert/renesas-drivers into devel

Ludovic Barre (2):
      devicetree: bindings: Document supported STM32 SoC family
      pinctrl: stm32: Add STM32MP157 MPU support

Markus Elfring (26):
      pinctrl: mcp23s08: Improve unlocking of a mutex in mcp23s08_irq()
      pinctrl: mvebu: Delete an error message for a failed memory
allocation in mvebu_pinctrl_probe()
      pinctrl/nomadik/abx500: Delete an error message for a failed
memory allocation in abx500_gpio_probe()
      pinctrl/nomadik/abx500: Improve a size determination in
abx500_gpio_probe()
      pinctrl: adi2: Delete an error message for a failed memory
allocation in two functions
      pinctrl: adi2: Improve a size determination in two functions
      pinctrl: msm: Delete an error message for a failed memory
allocation in msm_pinctrl_probe()
      pinctrl: at91: Delete an error message for a failed memory
allocation in at91_pinctrl_mux_mask()
      pinctrl: palmas: Delete an error message for a failed memory
allocation in palmas_pinctrl_probe()
      pinctrl: rockchip: Delete error messages for a failed memory
allocation in two functions
      pinctrl: rockchip: Improve a size determination in
rockchip_pinctrl_probe()
      pinctrl: rockchip: Fix a typo in four comment lines
      pinctrl: single: Delete an error message for a failed memory
allocation in pcs_probe()
      pinctrl: single: Delete an unnecessary return statement in
pcs_irq_chain_handler()
      pinctrl: tz1090: Delete an error message for a failed memory
allocation in two functions
      pinctrl: tz1090-pdc: Delete an error message for a failed memory
allocation in two functions
      pinctrl: utils: Delete an error message for a failed memory
allocation in pinctrl_utils_add_map_configs()
      pinctrl: xway: Delete two error messages for a failed memory
allocation in pinmux_xway_probe()
      pinctrl/spear/plgpio: Delete two error messages for a failed
memory allocation in plgpio_probe()
      pinctrl: spear: Delete an error message for a failed memory
allocation in spear_pinctrl_probe()
      pinctrl: tegra: Delete two error messages for a failed memory
allocation in tegra_pinctrl_probe()
      pinctrl: vt8500: Delete an error message for a failed memory
allocation in five functions
      pinctrl: mcp23s08: Combine two function calls into one in
mcp23s08_dbg_show()
      pinctrl: abx500: Use seq_putc() in abx500_gpio_dbg_show()
      pinctrl: pinmux: Use seq_putc() in pinmux_pins_show()
      pinctrl: sprd: Use seq_putc() in sprd_pinconf_group_dbg_show()

Masahiro Yamada (4):
      gpio: uniphier: fix mismatch between license text and MODULE_LICENSE
      dt-bindings: pinctrl: uniphier: add UniPhier pinctrl binding
      pinctrl: remove redundant mux_setting clear in pinmux_disable_setting()
      pinctrl: uniphier: refactor drive strength get/set functions

Mika Westerberg (4):
      gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO translation
      pinctrl: intel: Allow custom GPIO base for pad groups
      pinctrl: cannonlake: Align GPIO number space with Windows
      pinctrl: intel: Initialize GPIO properly when used through irqchip

Peter Rosin (3):
      pinctrl: sx150x: Unregister the pinctrl on release
      pinctrl: sx150x: Register pinctrl before adding the gpiochip
      pinctrl: sx150x: Add a static gpio/pinctrl pin range mapping

Quentin Schulz (10):
      gpio: axp209: switch unsigned variables to unsigned int
      pinctrl: move gpio-axp209 to pinctrl
      pinctrl: axp209: add pinctrl features
      dt-bindings: gpio: gpio-axp209: add pinctrl features
      pinctrl: axp209: rename everything from gpio to pctl
      pinctrl: axp209: add programmable gpio_status_offset
      pinctrl: axp209: add programmable ADC muxing value
      pinctrl: axp209: add support for AXP813 GPIOs
      pinctrl: axp209: dereference pointer after it's been set
      pinctrl: axp209: add missing Kconfig dependencies

Ramesh Shanmugasundaram (2):
      pinctrl: sh-pfc: r8a7795: Add CAN support
      pinctrl: sh-pfc: r8a7795: Add CAN FD support

Sean Wang (6):
      dt-bindings: pinctrl: add bindings for MediaTek MT7622 SoC
      pinctrl: mediatek: cleanup for placing all drivers under the menu
      pinctrl: mediatek: add pinctrl driver for MT7622 SoC
      pinctrl: mediatek: update MAINTAINERS entry with MediaTek pinctrl driver
      pinctrl: mediatek: mt7622: fix potential uninitialized value
being returned
      pinctrl: mediatek: mt7622: align error handling of mtk_hw_get_value call

Sergei Shtylyov (2):
      pinctrl: sh-pfc: Add PORT_GP_CFG_{6|22}() helper macros
      pinctrl: sh-pfc: Add R8A77970 PFC support

Stefan Agner (4):
      pinctrl: imx: use struct imx_pinctrl_soc_info as a const
      pinctrl: imx7d: simplify imx7d_pinctrl_probe
      pinctrl: imx: constify struct imx_pinctrl_soc_info
      pinctrl: imx7ulp: constify struct imx_cfg_params_decode

Takeshi Kihara (6):
      pinctrl: sh-pfc: r8a7795: Add GP-1-28 port pin support
      pinctrl: sh-pfc: r8a7795-es1: Fix MOD_SEL1 bit[25:24] to 0x3
when using STP_ISEN_1_D
      pinctrl: sh-pfc: r8a7795: Fix to delete A20..A25 pins function definitions
      pinctrl: sh-pfc: r8a7796: Fix to delete A20..A25 pins function definitions
      pinctrl: sh-pfc: r8a7795: Rename RTS{0,1,3,4}# pin function definitions
      pinctrl: sh-pfc: r8a7796: Rename RTS{0,1,3,4}# pin function definitions

Tony Lindgren (1):
      pinctrl: single: Remove invalid message

Ulrich Hecht (3):
      pinctrl: sh-pfc: r8a77995: Add missing pins SCL0 and SDA0 to pinmux data
      pinctrl: sh-pfc: r8a77995: Add CAN support
      pinctrl: sh-pfc: r8a77995: Add CAN FD support

Wei Yongjun (1):
      pinctrl: ingenic: Remove redundant dev_err call in ingenic_pinctrl_probe()

Wolfram Sang (1):
      pinctrl: sh-pfc: r8a7795: Add SATA pins, groups, and functions

Xingyu Chen (3):
      documentation: Add compatibles for Amlogic Meson AXG pin controllers
      pinctrl: meson-axg: Introduce a pinctrl pinmux ops for Meson-AXG SoC
      pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC

Yixun Lan (1):
      pinctrl: meson-axg: adjust spicc pin naming

hao_zhang (1):
      pinctrl: sunxi-pinctrl: fix pin funtion can not be match correctly.

 Documentation/devicetree/bindings/arm/stm32.txt    |    9 +
 .../devicetree/bindings/gpio/gpio-axp209.txt       |   49 +-
 .../bindings/pinctrl/cortina,gemini-pinctrl.txt    |    3 +
 .../bindings/pinctrl/fsl,imx6ul-pinctrl.txt        |    3 +-
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    2 +
 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       |   39 +
 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt |  351 +++
 .../bindings/pinctrl/qcom,msm8998-pinctrl.txt      |  193 ++
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
 .../pinctrl/socionext,uniphier-pinctrl.txt         |   27 +
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    2 +
 MAINTAINERS                                        |   11 +
 drivers/gpio/Kconfig                               |    6 -
 drivers/gpio/Makefile                              |    1 -
 drivers/gpio/gpio-axp209.c                         |  188 --
 drivers/gpio/gpio-uniphier.c                       |    2 +-
 drivers/gpio/gpiolib-acpi.c                        |   75 +-
 drivers/pinctrl/Kconfig                            |   25 +
 drivers/pinctrl/Makefile                           |    4 +-
 drivers/pinctrl/core.c                             |   24 +-
 drivers/pinctrl/freescale/pinctrl-imx.c            |   81 +-
 drivers/pinctrl/freescale/pinctrl-imx.h            |   13 +-
 drivers/pinctrl/freescale/pinctrl-imx25.c          |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx35.c          |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx50.c          |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx51.c          |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx53.c          |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx6dl.c         |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx6q.c          |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx6sl.c         |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx6sx.c         |    2 +-
 drivers/pinctrl/freescale/pinctrl-imx6ul.c         |   52 +-
 drivers/pinctrl/freescale/pinctrl-imx7d.c          |   10 +-
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c        |    7 +-
 drivers/pinctrl/freescale/pinctrl-vf610.c          |    5 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |    6 +
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |   65 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   59 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |  179 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |    3 +
 drivers/pinctrl/intel/pinctrl-merrifield.c         |    7 +
 drivers/pinctrl/mediatek/Kconfig                   |   15 +-
 drivers/pinctrl/mediatek/Makefile                  |    3 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          | 1597 ++++++++++++++
 drivers/pinctrl/meson/Kconfig                      |    9 +
 drivers/pinctrl/meson/Makefile                     |    2 +
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c      |  118 +
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h      |   62 +
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |  975 ++++++++
 drivers/pinctrl/meson/pinctrl-meson.h              |    1 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |    4 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c              |    5 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |   10 +-
 drivers/pinctrl/pinctrl-adi2.c                     |   13 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |    4 +-
 drivers/pinctrl/pinctrl-at91.c                     |    4 +-
 drivers/pinctrl/pinctrl-axp209.c                   |  478 ++++
 drivers/pinctrl/pinctrl-gemini.c                   |   84 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |    4 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |   54 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |  511 +++++
 drivers/pinctrl/pinctrl-palmas.c                   |    4 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |   31 +-
 drivers/pinctrl/pinctrl-single.c                   |   10 +-
 drivers/pinctrl/pinctrl-sx150x.c                   |   40 +-
 drivers/pinctrl/pinctrl-tz1090-pdc.c               |    9 +-
 drivers/pinctrl/pinctrl-tz1090.c                   |    9 +-
 drivers/pinctrl/pinctrl-utils.c                    |    4 +-
 drivers/pinctrl/pinctrl-xway.c                     |   10 +-
 drivers/pinctrl/pinmux.c                           |    4 +-
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c               |    4 +
 drivers/pinctrl/qcom/Kconfig                       |    8 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    5 +-
 drivers/pinctrl/qcom/pinctrl-msm8998.c             | 1590 +++++++++++++
 drivers/pinctrl/samsung/Kconfig                    |    1 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |   33 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |   33 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   33 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h           |    6 +-
 drivers/pinctrl/samsung/pinctrl-exynos5440.c       |   21 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |   23 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |   27 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   37 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    6 +-
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |   62 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               |  473 ++++
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c           |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               |  193 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |   66 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c              | 2329 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c              |   88 +
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   17 +-
 drivers/pinctrl/spear/pinctrl-plgpio.c             |    8 +-
 drivers/pinctrl/spear/pinctrl-spear.c              |    4 +-
 drivers/pinctrl/sprd/pinctrl-sprd.c                |    2 +-
 drivers/pinctrl/stm32/Kconfig                      |   12 +
 drivers/pinctrl/stm32/Makefile                     |    2 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    3 +-
 drivers/pinctrl/stm32/pinctrl-stm32.h              |    3 +-
 drivers/pinctrl/stm32/pinctrl-stm32f429.c          |    3 +-
 drivers/pinctrl/stm32/pinctrl-stm32f469.c          |    6 +-
 drivers/pinctrl/stm32/pinctrl-stm32f746.c          |    3 +-
 drivers/pinctrl/stm32/pinctrl-stm32f769.c          | 1827 +++++++++++++++
 drivers/pinctrl/stm32/pinctrl-stm32h743.c          |    6 +-
 drivers/pinctrl/stm32/pinctrl-stm32mp157.c         | 2188 ++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c          |    2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |    7 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |    9 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c   |  176 +-
 drivers/pinctrl/vt8500/pinctrl-vt8500.c            |    4 +-
 drivers/pinctrl/vt8500/pinctrl-wm8505.c            |    4 +-
 drivers/pinctrl/vt8500/pinctrl-wm8650.c            |    4 +-
 drivers/pinctrl/vt8500/pinctrl-wm8750.c            |    4 +-
 drivers/pinctrl/vt8500/pinctrl-wm8850.c            |    4 +-
 include/dt-bindings/gpio/meson-axg-gpio.h          |  116 +
 include/dt-bindings/pinctrl/stm32-pinfunc.h        |    6 +
 include/linux/pinctrl/devinfo.h                    |    2 +
 121 files changed, 14122 insertions(+), 947 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
 delete mode 100644 drivers/gpio/gpio-axp209.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7622.c
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg.c
 create mode 100644 drivers/pinctrl/pinctrl-axp209.c
 create mode 100644 drivers/pinctrl/pinctrl-ocelot.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8998.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77970.c
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f769.c
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32mp157.c
 create mode 100644 include/dt-bindings/gpio/meson-axg-gpio.h
