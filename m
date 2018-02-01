Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeBAXYm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:24:42 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40660 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBAXYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:24:36 -0500
X-Google-Smtp-Source: AH8x227TZ0KOVGU3bjp3GgmA7xgjYHhWwNfWqoq9FZdy9+UMcaWbsl2V+TkBaztuRDvC82y9PVwOqg4OqdSMimDBpkQ=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 00:24:34 +0100
X-Google-Sender-Auth: 8bWmA7ZKL7FS7Wy5wkq2Y89xZY8
Message-ID: <CAK8P3a10BtiVv3m3Rx0sZLUUKxpJkw+djgRTH_Vbxq2NxwQ05g@mail.gmail.com>
Subject: [GIT PULL 2/3] ARM: SoC platform updates for 4.16
To: Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 0ca14cdea789f70c4dc7ef5844aad52cb9675aee:

  ARM: omap: hwmod: fix section mismatch warnings (2018-01-22 12:39:36 +0100)

----------------------------------------------------------------
ARM: SoC platform updates for 4.16

These are mostly minor bugfixes, cleanup and many defconfig updates to
support added drivers. In particular OMAP and PXA keep cleaning up the
legacy code base, as usual.

Nvidia adds some more SoC support code for Tegra 186.

For the first time on years, we are actually adding a non-DT platform for,
the EP93xx based Liebherr controller BK3.1. It's a minor variation of
the EP93xx reference design and in active use, while EP93xx apparently
doesn't have enough new development to have any device tree support.

----------------------------------------------------------------
Alex Elder (3):
      arm64: defconfig: remove CONFIG_USB_EHCI_MSM
      arm64: defconfig: remove CONFIG_USB_MSM_OTG
      arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY

Amit Kucheria (1):
      arm64: defconfig: enable new trigger modes for leds

Andrea Adami (4):
      ARM: pxa/corgi: Remove hardcoded partitioning, use sharpslpart parser
      ARM: pxa/tosa: Remove hardcoded partitioning, use sharpslpart parser
      ARM: pxa/spitz: Remove hardcoded partitioning, use sharpslpart parser
      ARM: pxa/poodle: Remove hardcoded partitioning, use sharpslpart parser

Aparna Balasubramanian (1):
      ARM: davinci_all_defconfig: enable support for USB network adaptors

Ard Biesheuvel (1):
      ARM: omap2plus_defconfig: enable NEON based crypto

Arnd Bergmann (14):
      Merge tag 'renesas-soc-for-v4.16' of
ssh://gitolite.kernel.org/.../horms/renesas into next/soc
      Merge tag 'bk3' of https://github.com/sverdlin/ep93xx into next/soc
      Merge tag 'omap-for-v4.16/soc-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.15/defconfig-v2-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'samsung-defconfig-4.16' of
ssh://gitolite.kernel.org/.../krzk/linux into next/soc
      Merge tag 'tegra-for-4.16-soc-2' of
ssh://gitolite.kernel.org/.../tegra/linux into next/soc
      Merge tag 'v4.15-next-soc' of
ssh://gitolite.kernel.org/.../matthias.bgg/linux into next/soc
      Merge tag 'qcom-arm64-defconfig-for-4.16' of
ssh://gitolite.kernel.org/.../agross/linux into next/soc
      Merge tag 'qcom-defconfig-for-4.16' of
ssh://gitolite.kernel.org/.../agross/linux into next/soc
      Merge tag 'imx-soc-4.16' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'davinci-for-v4.16/soc-v2' of
ssh://gitolite.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge commit '8bb65fc06c' into next/soc
      ARM: pxa/tosa-bt: add MODULE_LICENSE tag
      ARM: omap: hwmod: fix section mismatch warnings

Arvind Yadav (1):
      ARM: davinci: constify gpio_led

Bhumika Goyal (4):
      ARM: OMAP2+: CM: make some pointers and function arguments as const
      ARM: OMAP2+: CM: make cm_ll_data structures as const
      ARM: davinci: make argument to davinci_common_init() as const
      ARM: davinci: make davinci_soc_info structures const

Biju Das (1):
      ARM: shmobile: defconfig: Enable SGTL5000 audio codec

Dmitry Osipenko (2):
      soc/tegra: fuse: Fix reading registers using DMA on Tegra20
      soc/tegra: fuse: Explicitly request DMA channel from APB DMA driver

Dong Aisheng (1):
      ARM: imx_v6_v7_defconfig: enable CONFIG_CPU_FREQ_STAT

Fabrizio Castro (2):
      ARM: multi_v7_defconfig: Select PWM_RCAR as module
      ARM: shmobile: defconfig: Enable PWM

Geert Uytterhoeven (2):
      soc: renesas: Identify R-Car M3-W ES1.1
      soc: renesas: rcar-sysc: Keep wakeup sources active during system suspend

Gregory CLEMENT (1):
      arm64: defconfig: enable ARM_ARMADA_37XX_CPUFREQ

Grygorii Strashko (1):
      gpio: gpio-reg: fix build

Jagan Teki (1):
      arm64: defconfig: enable MUSB HDRC along with Allwinner glue

Julia Lawall (1):
      ARM: davinci: drop unneeded newline

Keiji Hayashibara (1):
      arm64: defconfig: enable CONFIG_UNIPHIER_EFUSE

Kishon Vijay Abraham I (2):
      ARM: omap2plus_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device modes)
      ARM: multi_v7_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device modes)

Krzysztof Kozlowski (5):
      ARM: EXYNOS: Add SPDX license identifiers
      ARM: S3C24XX: Add SPDX license identifiers
      ARM: S3C64XX: Add SPDX license identifiers
      ARM: S5PV210: Add SPDX license identifiers
      ARM: SAMSUNG: Add SPDX license identifiers

Linus Walleij (2):
      MAINTAINERS: Add self as extended maintainer for a slew of files
      soc: Add SoC driver for Gemini

Lokesh Vutla (2):
      ARM: OMAP2+: dra762: Add support for device package identification
      ARM: OMAP2+: dra762: Register package specific hwmod

Lucas Stach (1):
      ARM: imx: don't abort MMDC probe if power saving status doesn't match

Lukasz Majewski (4):
      ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h file
      ARM: ep93xx: ts72xx: Rewrite ts72xx_register_flash() to accept parameters
      ARM: ep93xx: ts72xx: cosmetic: Add some description to ts72xx code
      ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx derivative

Marc Gonzalez (1):
      Wind down ARM/TANGO port

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable missing drivers for supported Exynos boards
      ARM: multi_v7_defconfig: Enable missing drivers for supported
Exynos boards

Martin Kaiser (1):
      ARM: imx: remove unused imx3 pm definitions

Matthias Brugger (1):
      Merge remote-tracking branch 'mainline-kernel/v4.15-next/pdids'
into v4.15-next/soc

Neil Armstrong (1):
      ARM: imx_v6_v7_defconfig: Add missing config for DART-MX6 SoM

Olof Johansson (10):
      Merge tag 'renesas-defconfig-for-v4.16' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'renesas-soc2-for-v4.16' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'mvebu-arm64-4.16-1' of
git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'omap-for-v4.16/soc-pt2-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.16/defconfig-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'pxa-for-4.16' of https://github.com/rjarzmik/linux
into next/soc
      Merge tag 'keystone_config_for_4.16' of
git://git.kernel.org/.../ssantosh/linux-keystone into next/soc
      Merge tag 'sunxi-config64-for-4.16' of
https://git.kernel.org/.../sunxi/linux into next/soc
      Merge tag 'imx-defconfig-4.16' of
git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'samsung-soc-4.16-2' of
https://git.kernel.org/.../krzk/linux into next/soc

Patrick Bruenn (1):
      ARM: imx_v6_v7_defconfig: enable RTC_DRV_MXC_V2

Russell King (1):
      ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register

Sean Wang (1):
      ARM: mediatek: use more generic prompts for SoCs with ARMv7

Shuah Khan (1):
      ARM: exynos_defconfig: Enable CONFIG_EXYNOS_IOMMU

Srinivas Kandagatla (3):
      ARM: qcom_defconfig: Enable DRM for 8064 display
      ARM: qcom_defconfig: enable MSM IOMMU for display
      ARM: qcom_defconfig: Enable Frambuffer console support

Tero Kristo (7):
      ARM: OMAP2+: CM: add support for getting phys address for a
clkctrl register
      ARM: OMAP4: CMINST: add support for translating clkctrl addresses
      ARM: OMAP2+: hwmod: fix clkctrl address translation logic
      ARM: OMAP2+: clockdomain: remove the obsolete clkdm_xlate_address API
      ARM: AM33xx: CM: add support for getting physical address for a register
      ARM: OMAP2+: hwmod: calculate physical register address on am33xx
      ARM: DM816x: hwmod_data: fix clockdomain name for sata hwmod

Thierry Reding (7):
      dt-bindings: misc: Add Tegra186 MISC registers bindings
      Merge branch 'for-4.16/dt-bindings' into for-4.16/soc
      soc/tegra: fuse: Move register mapping check
      soc/tegra: fuse: Warn if accessing unmapped registers
      soc/tegra: fuse: Add Tegra186 chip ID support
      soc/tegra: pmc: Parameterize driver
      soc/tegra: pmc: Consolidate Tegra186 support

Timo Alho (1):
      soc/tegra: fuse: Add Tegra186 support

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Enable droid 4 USB PHY
      Merge branch '4.15-rc1-clkctrl-mach-omap2' of
https://github.com/t-kristo/linux-pm into omap-for-v4.16/soc
      ARM: OMAP2+: Drop unused legacy data for prcm_reg_id and module_bit

Vasyl Gomonovych (1):
      ARM: davinci: Use PTR_ERR_OR_ZERO()

Vignesh R (1):
      ARM: configs: keystone_defconfig: Enable few peripheral drivers

Wolfram Sang (2):
      ARM: pxa: move declarations to proper place
      ARM: pxa: move header file out of I2C realm

shiju.jose@huawei.com (3):
      arm64: defconfig: enable CONFIG_ACPI_APEI_MEMORY_FAILURE
      arm64: defconfig: enable EDAC GHES option
      arm64: defconfig: enable CONFIG_ACPI_APEI_EINJ

weiyi.lu@mediatek.com (4):
      dt-bindings: soc: add MT2712 power dt-bindings
      soc: mediatek: extend bus protection API
      soc: mediatek: add dependent clock jpgdec/audio for scpsys
      soc: mediatek: add MT2712 scpsys support

 .../bindings/misc/nvidia,tegra186-misc.txt         |  12 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |   3 +
 MAINTAINERS                                        |  74 +++--
 arch/arm/configs/davinci_all_defconfig             |   1 +
 arch/arm/configs/exynos_defconfig                  |   7 +
 arch/arm/configs/imx_v6_v7_defconfig               |   8 +
 arch/arm/configs/keystone_defconfig                |   7 +
 arch/arm/configs/multi_v7_defconfig                |  12 +
 arch/arm/configs/omap2plus_defconfig               |  19 ++
 arch/arm/configs/qcom_defconfig                    |   3 +
 arch/arm/configs/shmobile_defconfig                |   2 +
 arch/arm/mach-davinci/board-da850-evm.c            |   4 +-
 arch/arm/mach-davinci/board-neuros-osd2.c          |   2 +-
 arch/arm/mach-davinci/common.c                     |   2 +-
 arch/arm/mach-davinci/da830.c                      |   2 +-
 arch/arm/mach-davinci/da850.c                      |   2 +-
 arch/arm/mach-davinci/devices-da8xx.c              |   4 +-
 arch/arm/mach-davinci/dm355.c                      |   2 +-
 arch/arm/mach-davinci/dm365.c                      |   2 +-
 arch/arm/mach-davinci/dm644x.c                     |   2 +-
 arch/arm/mach-davinci/dm646x.c                     |   4 +-
 arch/arm/mach-davinci/include/mach/common.h        |   2 +-
 arch/arm/mach-ep93xx/Kconfig                       |   7 +
 arch/arm/mach-ep93xx/ts72xx.c                      | 165 ++++++++++-
 arch/arm/mach-ep93xx/ts72xx.h                      |   9 +
 arch/arm/mach-exynos/Kconfig                       |   4 +-
 arch/arm/mach-exynos/Makefile                      |   4 +-
 arch/arm/mach-exynos/common.h                      |   5 +-
 arch/arm/mach-exynos/exynos-smc.S                  |   5 +-
 arch/arm/mach-exynos/exynos.c                      |  16 +-
 arch/arm/mach-exynos/firmware.c                    |  14 +-
 arch/arm/mach-exynos/headsmp.S                     |   6 +-
 arch/arm/mach-exynos/include/mach/map.h            |   7 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |  17 +-
 arch/arm/mach-exynos/platsmp.c                     |  21 +-
 arch/arm/mach-exynos/pm.c                          |  24 +-
 arch/arm/mach-exynos/sleep.S                       |  11 +-
 arch/arm/mach-exynos/smc.h                         |   5 +-
 arch/arm/mach-exynos/suspend.c                     |  24 +-
 arch/arm/mach-imx/common.h                         |   9 -
 arch/arm/mach-imx/mmdc.c                           |  11 -
 arch/arm/mach-mediatek/Kconfig                     |   2 +-
 arch/arm/mach-mmp/mmp2.h                           |   2 +-
 arch/arm/mach-mmp/pxa168.h                         |   2 +-
 arch/arm/mach-mmp/pxa910.h                         |   2 +-
 arch/arm/mach-omap2/clockdomain.c                  |   8 -
 arch/arm/mach-omap2/clockdomain.h                  |   2 -
 arch/arm/mach-omap2/cm-regbits-24xx.h              |  81 ------
 arch/arm/mach-omap2/cm-regbits-34xx.h              | 162 -----------
 arch/arm/mach-omap2/cm.h                           |   7 +-
 arch/arm/mach-omap2/cm2xxx.c                       |   2 +-
 arch/arm/mach-omap2/cm33xx.c                       |   8 +-
 arch/arm/mach-omap2/cm3xxx.c                       |   2 +-
 arch/arm/mach-omap2/cm_common.c                    |  16 +-
 arch/arm/mach-omap2/cminst44xx.c                   |  12 +-
 arch/arm/mach-omap2/id.c                           |  17 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  77 +++---
 arch/arm/mach-omap2/omap_hwmod.h                   |   6 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  28 --
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  64 -----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 131 ---------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  27 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |   2 +-
 arch/arm/mach-omap2/soc.h                          |  16 ++
 arch/arm/mach-pxa/Kconfig                          |   1 +
 arch/arm/mach-pxa/balloon3.c                       |   2 +-
 arch/arm/mach-pxa/cm-x300.c                        |   2 +-
 arch/arm/mach-pxa/colibri-evalboard.c              |   2 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c          |   2 +-
 arch/arm/mach-pxa/corgi.c                          |  33 +--
 arch/arm/mach-pxa/csb726.c                         |   2 +-
 arch/arm/mach-pxa/devices.c                        |   2 +-
 arch/arm/mach-pxa/devices.h                        |   9 +
 arch/arm/mach-pxa/em-x270.c                        |   2 +-
 arch/arm/mach-pxa/ezx.c                            |   2 +-
 arch/arm/mach-pxa/hx4700.c                         |   2 +-
 arch/arm/mach-pxa/littleton.c                      |   3 +-
 arch/arm/mach-pxa/lubbock.c                        |  24 +-
 arch/arm/mach-pxa/magician.c                       |   2 +-
 arch/arm/mach-pxa/mainstone.c                      |   2 +-
 arch/arm/mach-pxa/mioa701.c                        |   2 +-
 arch/arm/mach-pxa/mxm8x10.c                        |   2 +-
 arch/arm/mach-pxa/palm27x.c                        |   2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |   2 +-
 arch/arm/mach-pxa/poodle.c                         |  30 +-
 arch/arm/mach-pxa/pxa27x.c                         |   2 +-
 arch/arm/mach-pxa/pxa3xx.c                         |   2 +-
 arch/arm/mach-pxa/raumfeld.c                       |   2 +-
 arch/arm/mach-pxa/saar.c                           |   2 +-
 arch/arm/mach-pxa/spitz.c                          |  36 +--
 arch/arm/mach-pxa/stargate2.c                      |   2 +-
 arch/arm/mach-pxa/tosa-bt.c                        |   4 +
 arch/arm/mach-pxa/tosa.c                           |  30 +-
 arch/arm/mach-pxa/trizeps4.c                       |   2 +-
 arch/arm/mach-pxa/viper.c                          |   2 +-
 arch/arm/mach-pxa/vpac270.c                        |   2 +-
 arch/arm/mach-pxa/xcep.c                           |   3 +-
 arch/arm/mach-pxa/z2.c                             |   2 +-
 arch/arm/mach-pxa/zeus.c                           |   3 +-
 arch/arm/mach-pxa/zylonite_pxa300.c                |   3 +-
 arch/arm/mach-s3c24xx/Kconfig                      |   4 +-
 arch/arm/mach-s3c24xx/Makefile                     |   4 +-
 arch/arm/mach-s3c24xx/Makefile.boot                |   2 +
 arch/arm/mach-s3c24xx/anubis.h                     |   7 +-
 arch/arm/mach-s3c24xx/bast-ide.c                   |  17 +-
 arch/arm/mach-s3c24xx/bast-irq.c                   |  28 +-
 arch/arm/mach-s3c24xx/bast.h                       |   7 +-
 arch/arm/mach-s3c24xx/common-smdk.c                |  21 +-
 arch/arm/mach-s3c24xx/common-smdk.h                |   7 +-
 arch/arm/mach-s3c24xx/common.c                     |  29 +-
 arch/arm/mach-s3c24xx/common.h                     |   5 +-
 arch/arm/mach-s3c24xx/cpufreq-utils.c              |  18 +-
 arch/arm/mach-s3c24xx/fb-core.h                    |   5 +-
 arch/arm/mach-s3c24xx/gta02.h                      |   7 +-
 arch/arm/mach-s3c24xx/h1940-bluetooth.c            |  16 +-
 arch/arm/mach-s3c24xx/h1940.h                      |   7 +-
 arch/arm/mach-s3c24xx/include/mach/dma.h           |  10 +-
 arch/arm/mach-s3c24xx/include/mach/fb.h            |   1 +
 arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h  |   7 +-
 arch/arm/mach-s3c24xx/include/mach/hardware.h      |   7 +-
 arch/arm/mach-s3c24xx/include/mach/irqs.h          |  10 +-
 arch/arm/mach-s3c24xx/include/mach/map.h           |  10 +-
 arch/arm/mach-s3c24xx/include/mach/pm-core.h       |   9 +-
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h    |  10 +-
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     |  10 +-
 arch/arm/mach-s3c24xx/include/mach/regs-irq.h      |  10 +-
 arch/arm/mach-s3c24xx/include/mach/regs-lcd.h      |  11 +-
 .../mach-s3c24xx/include/mach/regs-s3c2443-clock.h |  10 +-
 arch/arm/mach-s3c24xx/include/mach/rtc-core.h      |   7 +-
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h       |   5 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c           |  18 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |  18 +-
 arch/arm/mach-s3c24xx/irq-pm.c                     |  19 +-
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |  35 +--
 arch/arm/mach-s3c24xx/mach-anubis.c                |  15 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |  21 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |  17 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |  33 +--
 arch/arm/mach-s3c24xx/mach-h1940.c                 |  17 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |  17 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |  23 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |  27 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |  22 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |  19 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |  14 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |  13 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |  27 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |  17 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |  18 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |  28 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |  39 +--
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |  19 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |  18 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |  23 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |  22 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |  33 +--
 arch/arm/mach-s3c24xx/mach-vr1000.c                |  19 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |  15 +-
 arch/arm/mach-s3c24xx/nand-core.h                  |   7 +-
 arch/arm/mach-s3c24xx/osiris.h                     |   7 +-
 arch/arm/mach-s3c24xx/otom.h                       |   7 +-
 arch/arm/mach-s3c24xx/pll-s3c2410.c                |  30 +-
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c       |  20 +-
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c       |  20 +-
 arch/arm/mach-s3c24xx/pm-h1940.S                   |  19 +-
 arch/arm/mach-s3c24xx/pm-s3c2410.c                 |  27 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c                 |  17 +-
 arch/arm/mach-s3c24xx/pm-s3c2416.c                 |  17 +-
 arch/arm/mach-s3c24xx/pm.c                         |  39 +--
 arch/arm/mach-s3c24xx/regs-dsc.h                   |   7 +-
 arch/arm/mach-s3c24xx/regs-mem.h                   |   5 +-
 arch/arm/mach-s3c24xx/s3c2410.c                    |  17 +-
 arch/arm/mach-s3c24xx/s3c2412-power.h              |   5 +-
 arch/arm/mach-s3c24xx/s3c2412.c                    |  16 +-
 arch/arm/mach-s3c24xx/s3c2416.c                    |  31 +--
 arch/arm/mach-s3c24xx/s3c2440.c                    |  17 +-
 arch/arm/mach-s3c24xx/s3c2442.c                    |  29 +-
 arch/arm/mach-s3c24xx/s3c2443.c                    |  17 +-
 arch/arm/mach-s3c24xx/s3c244x.c                    |  17 +-
 arch/arm/mach-s3c24xx/setup-camif.c                |  14 +-
 arch/arm/mach-s3c24xx/setup-i2c.c                  |  17 +-
 arch/arm/mach-s3c24xx/setup-sdhci-gpio.c           |  21 +-
 arch/arm/mach-s3c24xx/setup-spi.c                  |  16 +-
 arch/arm/mach-s3c24xx/setup-ts.c                   |  17 +-
 arch/arm/mach-s3c24xx/simtec-audio.c               |  19 +-
 arch/arm/mach-s3c24xx/simtec-nor.c                 |  19 +-
 arch/arm/mach-s3c24xx/simtec-pm.c                  |  21 +-
 arch/arm/mach-s3c24xx/simtec-usb.c                 |  21 +-
 arch/arm/mach-s3c24xx/simtec.h                     |  10 +-
 arch/arm/mach-s3c24xx/sleep-s3c2410.S              |  20 +-
 arch/arm/mach-s3c24xx/sleep-s3c2412.S              |  20 +-
 arch/arm/mach-s3c24xx/sleep.S                      |  20 +-
 arch/arm/mach-s3c24xx/spi-core.h                   |   5 +-
 arch/arm/mach-s3c24xx/vr1000.h                     |  11 +-
 arch/arm/mach-s3c64xx/Kconfig                      |   5 +-
 arch/arm/mach-s3c64xx/Makefile                     |   4 +-
 arch/arm/mach-s3c64xx/ata-core.h                   |   7 +-
 arch/arm/mach-s3c64xx/backlight.h                  |   5 +-
 arch/arm/mach-s3c64xx/common.c                     |  26 +-
 arch/arm/mach-s3c64xx/common.h                     |   5 +-
 arch/arm/mach-s3c64xx/cpuidle.c                    |  15 +-
 arch/arm/mach-s3c64xx/crag6410.h                   |   5 +-
 arch/arm/mach-s3c64xx/dev-audio.c                  |  13 +-
 arch/arm/mach-s3c64xx/dev-backlight.c              |  16 +-
 arch/arm/mach-s3c64xx/dev-uart.c                   |  22 +-
 arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h  |   7 +-
 arch/arm/mach-s3c64xx/include/mach/hardware.h      |   1 +
 arch/arm/mach-s3c64xx/include/mach/map.h           |  10 +-
 arch/arm/mach-s3c64xx/include/mach/pm-core.h       |   8 +-
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h    |  10 +-
 arch/arm/mach-s3c64xx/include/mach/regs-irq.h      |  10 +-
 arch/arm/mach-s3c64xx/irq-pm.c                     |  21 +-
 arch/arm/mach-s3c64xx/irq-uart.h                   |   7 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |  22 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       |  15 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |  19 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                   |  14 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c              |  20 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                   |  13 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |  20 +-
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c            |  14 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |  13 +-
 arch/arm/mach-s3c64xx/mach-smartq.h                |   6 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c               |  13 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c               |  13 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |  15 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |  18 +-
 arch/arm/mach-s3c64xx/onenand-core.h               |   7 +-
 arch/arm/mach-s3c64xx/pl080.c                      |  14 +-
 arch/arm/mach-s3c64xx/pm.c                         |  21 +-
 arch/arm/mach-s3c64xx/regs-modem.h                 |   7 +-
 arch/arm/mach-s3c64xx/regs-srom.h                  |   7 +-
 arch/arm/mach-s3c64xx/s3c6400.c                    |  15 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |  17 +-
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c             |  21 +-
 arch/arm/mach-s3c64xx/setup-i2c0.c                 |  21 +-
 arch/arm/mach-s3c64xx/setup-i2c1.c                 |  21 +-
 arch/arm/mach-s3c64xx/setup-ide.c                  |  17 +-
 arch/arm/mach-s3c64xx/setup-keypad.c               |  17 +-
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c           |  19 +-
 arch/arm/mach-s3c64xx/setup-spi.c                  |  13 +-
 arch/arm/mach-s3c64xx/setup-usb-phy.c              |  14 +-
 arch/arm/mach-s3c64xx/sleep.S                      |   7 +-
 arch/arm/mach-s3c64xx/watchdog-reset.h             |   7 +-
 arch/arm/mach-s5pv210/Kconfig                      |   4 +-
 arch/arm/mach-s5pv210/Makefile                     |   4 +-
 arch/arm/mach-s5pv210/common.h                     |   5 +-
 arch/arm/mach-s5pv210/pm.c                         |  25 +-
 arch/arm/mach-s5pv210/regs-clock.h                 |   7 +-
 arch/arm/mach-s5pv210/s5pv210.c                    |  18 +-
 arch/arm/mach-s5pv210/sleep.S                      |   6 +-
 arch/arm/plat-samsung/Kconfig                      |   4 +-
 arch/arm/plat-samsung/Makefile                     |   4 +-
 arch/arm/plat-samsung/adc.c                        |  19 +-
 arch/arm/plat-samsung/cpu.c                        |  17 +-
 arch/arm/plat-samsung/dev-uart.c                   |  21 +-
 arch/arm/plat-samsung/devs.c                       |  17 +-
 arch/arm/plat-samsung/gpio-samsung.c               |  26 +-
 arch/arm/plat-samsung/include/plat/adc-core.h      |  10 +-
 arch/arm/plat-samsung/include/plat/adc.h           |  10 +-
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h |  10 +-
 arch/arm/plat-samsung/include/plat/cpu-freq.h      |  10 +-
 arch/arm/plat-samsung/include/plat/cpu.h           |  10 +-
 arch/arm/plat-samsung/include/plat/devs.h          |  10 +-
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h    |   8 +-
 arch/arm/plat-samsung/include/plat/fb.h            |  10 +-
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |  10 +-
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      |  10 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h     |  10 +-
 arch/arm/plat-samsung/include/plat/iic-core.h      |  10 +-
 arch/arm/plat-samsung/include/plat/keypad.h        |   6 +-
 arch/arm/plat-samsung/include/plat/map-base.h      |  10 +-
 arch/arm/plat-samsung/include/plat/map-s3c.h       |  10 +-
 arch/arm/plat-samsung/include/plat/map-s5p.h       |  10 +-
 arch/arm/plat-samsung/include/plat/pm-common.h     |   7 +-
 arch/arm/plat-samsung/include/plat/pm.h            |  10 +-
 arch/arm/plat-samsung/include/plat/pwm-core.h      |   5 +-
 arch/arm/plat-samsung/include/plat/regs-adc.h      |  10 +-
 arch/arm/plat-samsung/include/plat/regs-irqtype.h  |   8 +-
 arch/arm/plat-samsung/include/plat/regs-spi.h      |  10 +-
 arch/arm/plat-samsung/include/plat/regs-udc.h      |  11 +-
 arch/arm/plat-samsung/include/plat/samsung-time.h  |  10 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |  10 +-
 arch/arm/plat-samsung/include/plat/usb-phy.h       |   6 +-
 arch/arm/plat-samsung/include/plat/wakeup-mask.h   |  11 +-
 arch/arm/plat-samsung/init.c                       |  19 +-
 arch/arm/plat-samsung/platformdata.c               |  15 +-
 arch/arm/plat-samsung/pm-check.c                   |  22 +-
 arch/arm/plat-samsung/pm-common.c                  |  24 +-
 arch/arm/plat-samsung/pm-debug.c                   |  24 +-
 arch/arm/plat-samsung/pm-gpio.c                    |  22 +-
 arch/arm/plat-samsung/pm.c                         |  21 +-
 arch/arm/plat-samsung/wakeup-mask.c                |  15 +-
 arch/arm/plat-samsung/watchdog-reset.c             |  21 +-
 arch/arm/tools/mach-types                          |   1 +
 arch/arm64/configs/defconfig                       |  13 +-
 drivers/gpio/gpio-reg.c                            |   4 +-
 drivers/i2c/busses/i2c-pxa-pci.c                   |   2 +-
 drivers/i2c/busses/i2c-pxa.c                       |   2 +-
 drivers/soc/Makefile                               |   1 +
 drivers/soc/gemini/Makefile                        |   2 +
 drivers/soc/gemini/soc-gemini.c                    |  71 +++++
 drivers/soc/mediatek/mtk-infracfg.c                |  26 +-
 drivers/soc/mediatek/mtk-scpsys.c                  | 140 +++++++++-
 drivers/soc/renesas/rcar-sysc.c                    |   2 +-
 drivers/soc/renesas/renesas-soc.c                  |   3 +
 drivers/soc/tegra/Kconfig                          |   5 +-
 drivers/soc/tegra/Makefile                         |   1 -
 drivers/soc/tegra/fuse/fuse-tegra.c                |   4 +
 drivers/soc/tegra/fuse/fuse-tegra20.c              |  13 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  24 +-
 drivers/soc/tegra/fuse/fuse.h                      |   4 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |  11 +-
 drivers/soc/tegra/pmc-tegra186.c                   | 169 ------------
 drivers/soc/tegra/pmc.c                            | 304 +++++++++++++++++----
 include/dt-bindings/power/mt2712-power.h           |  26 ++
 .../{i2c/pxa-i2c.h => platform_data/i2c-pxa.h}     |  11 -
 include/linux/soc/mediatek/infracfg.h              |   7 +-
 include/soc/tegra/pmc.h                            |  12 +
 320 files changed, 2058 insertions(+), 3055 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 create mode 100644 drivers/soc/gemini/Makefile
 create mode 100644 drivers/soc/gemini/soc-gemini.c
 delete mode 100644 drivers/soc/tegra/pmc-tegra186.c
 create mode 100644 include/dt-bindings/power/mt2712-power.h
 rename include/linux/{i2c/pxa-i2c.h => platform_data/i2c-pxa.h} (90%)
