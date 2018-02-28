Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935617AbeB1XGv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:06:51 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42866 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935541AbeB1XGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:06:49 -0500
X-Google-Smtp-Source: AG47ELuFGK3tR7KFn/LelxRNazVuOMTG/sTxV5USrLsnyP9NFR9araRr/7YrO06aLuYKjb1LQzmnm+VtlW6wELG+5Sk=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 1 Mar 2018 00:06:47 +0100
X-Google-Sender-Auth: QaPXBGUkIe9kDwHIYXjeRzBfWOo
Message-ID: <CAK8P3a02QO4LvvFyxmGNw4cn5VA+o47J3ekRTMD+=cx79Ftw2Q@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1SN6w2U028759

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to 8f148f32926c8226cb26b0108aec0c295056775b:

  Merge tag 'arm-soc/for-4.16/drivers-fixes' of
https://github.com/Broadcom/stblinux into fixes (2018-02-28 23:27:21
+0100)

----------------------------------------------------------------
ARM: SoC fixes for 4.16

This is the first set of bugfixes for ARM SoCs, fixing a couple
of stability problems, mostly on TI OMAP and Rockchips platforms:

- OMAP2 hwmod clocks must be enabled in the correct order

- OMAP3 Wakeup from resume through PRM IRQ was unreliable

- One regression on OMAP5 caused by a kexec fix

- Rockchip ethernet needs some settings for stable operation on Rock64

- Rockchip based Chrombook Plus needs another clock setting for
  stable display suspend/resume

- Rockchip based phyCORE-RK3288 was able to run at an invalid
  CPU clock frequency

- Rockchip MMC link was sometimes unreliable

- Multiple fixes to avoid crashes in the Broadcom STB DPFE driver

Other minor changes include:

- Devicetree fixes for incorrect hardware description (rockchip,
  omap, Gemini, amlogic)

- Some MAINTAINER file updates to correct email and git addresses

- Some fixes addressing 'make W=1' dtc warnings (broadcom, amlogic,
  cavium, qualcomm, hisilicon, zx)

- Fixes for LTO-compilation (orion, davinci, clps711x)

- One fix for an incorrect Kconfig errata selection

- A memory leak in the OMAP timer driver

- A kernel data leak in OMAP1 debugfs files

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
      ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux

Alexandre Belloni (1):
      MAINTAINERS: ARM: at91: update my email address

Alexandre Torgue (1):
      MAINTAINERS: update entries for ARM/STM32

Arnd Bergmann (13):
      Merge tag 'amlogic-fixes' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into fixes
      Merge tag 'at91-ab-4.16-soc-fixes' of
ssh://gitolite.kernel.org/.../abelloni/linux into fixes
      ARM: clps711x: mark clps711x_compat as const
      ARM: davinci: mark spi_board_info arrays as const
      Merge tag 'mvebu-fixes-4.16-1' of
git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'omap-for-v4.16/fixes-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'v4.16-rockchip-dts32fixes-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into fixes
      Merge tag 'v4.16-rockchip-dts64fixes-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into fixes
      ARM: orion: fix orion_ge00_switch_board_info initialization
      ARM: omap2: set CONFIG_LIRC=y in defconfig
      Merge tag 'imx-fixes-4.16' of
ssh://gitolite.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'arm-soc/for-4.16/devicetree-fixes' of
https://github.com/Broadcom/stblinux into fixes
      Merge tag 'arm-soc/for-4.16/drivers-fixes' of
https://github.com/Broadcom/stblinux into fixes

Daniel Schultz (1):
      ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som

Florian Fainelli (1):
      ARM: dts: NSP: Fix amount of RAM on BCM958625HR

Geert Uytterhoeven (2):
      ARM: OMAP1: clock: Fix debugfs_create_*() usage
      ARM: dts: OMAP5: uevm: Fix "debounce-interval" property misspelling

Gregory CLEMENT (1):
      MAINTAINERS: update email address for Gregory CLEMENT

Jerome Brunet (1):
      ARM64: dts: meson-gxl: add internal ethernet PHY irq

Kamil Trzciński (1):
      arm64: dts: rockchip: fix rock64 gmac2io stability issues

Linus Walleij (1):
      ARM: dts: Set D-Link DNS-313 SATA to muxmode 0

Markus Mayer (3):
      memory: brcmstb: dpfe: properly mask vendor error bits
      memory: brcmstb: dpfe: fix type declaration of variable "ret"
      memory: brcmstb: dpfe: support new way of passing data from the DCPU

Mathieu Malaterre (3):
      arm64: dts: Remove leading 0x and 0s from bindings notation
      arm: zx: dts: Remove leading 0x and 0s from bindings notation
      ARM: BCM: dts: Remove leading 0x and 0s from bindings notation

Qi Hou (1):
      ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt

Rob Herring (1):
      arm64: dts: cavium: fix PCI bus dtc warnings

Robin Murphy (2):
      arm64: dts: rockchip: Fix DWMMC clocks
      ARM: dts: rockchip: Fix DWMMC clocks

Shawn Lin (1):
      arm64: dts: rockchip: correct ep-gpios for rk3399-sapphire

Shyam Saini (1):
      ARM: dts: imx6dl: Include correct dtsi file for Engicam i.CoreM6
DualLite/Solo RQS

Stefan Agner (1):
      soc: imx: gpc: de-register power domains only if initialized

Stefan Wahren (2):
      ARM: dts: bcm283x: Fix unit address of local_intc
      ARM: dts: bcm283x: Move arm-pmu out of soc node

Tero Kristo (1):
      ARM: OMAP2+: hwmod_core: enable optional clocks before main clock

Tony Lindgren (4):
      Merge branch 'omap-for-v4.16/soc' into omap-for-v4.16/fixes
      ARM: OMAP3: Fix prm wake interrupt for resume
      ARM: OMAP2+: Fix sar_base inititalization for HS omaps
      bus: ti-sysc: Fix checking of no-reset-on-init quirk

Ulf Magnusson (1):
      ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Yakir Yang (1):
      arm64: dts: rockchip: introduce pclk_vio_grf in rk3399-eDP device node

Yixun Lan (1):
      ARM64: dts: meson: uart: fix address space range

 MAINTAINERS                                       | 10 +--
 arch/arm/boot/dts/bcm11351.dtsi                   |  2 +-
 arch/arm/boot/dts/bcm21664.dtsi                   |  2 +-
 arch/arm/boot/dts/bcm2835.dtsi                    |  6 +-
 arch/arm/boot/dts/bcm2836.dtsi                    | 12 ++--
 arch/arm/boot/dts/bcm2837.dtsi                    |  2 +-
 arch/arm/boot/dts/bcm283x.dtsi                    |  2 +-
 arch/arm/boot/dts/bcm958625hr.dts                 |  2 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts        |  2 +-
 arch/arm/boot/dts/imx6dl-icore-rqs.dts            |  2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi             |  9 ++-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi        |  8 +++
 arch/arm/boot/dts/omap5-uevm.dts                  |  2 +-
 arch/arm/boot/dts/rk3036.dtsi                     |  4 +-
 arch/arm/boot/dts/rk322x.dtsi                     |  6 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi         | 20 ------
 arch/arm/boot/dts/zx296702.dtsi                   | 20 +++---
 arch/arm/configs/omap2plus_defconfig              |  2 +-
 arch/arm/mach-clps711x/board-dt.c                 |  2 +-
 arch/arm/mach-davinci/board-dm355-evm.c           |  2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c       |  2 +-
 arch/arm/mach-davinci/board-dm365-evm.c           |  2 +-
 arch/arm/mach-mvebu/Kconfig                       |  4 +-
 arch/arm/mach-omap1/clock.c                       |  6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c              |  4 +-
 arch/arm/mach-omap2/omap_hwmod.c                  |  6 +-
 arch/arm/mach-omap2/pm.c                          |  4 +-
 arch/arm/mach-omap2/timer.c                       | 19 +++---
 arch/arm/plat-orion/common.c                      | 23 ++++---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        |  4 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 10 +--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        |  1 +
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi     |  3 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts    |  2 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi      |  6 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi             |  6 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts    |  7 +--
 arch/arm64/boot/dts/rockchip/rk3328.dtsi          |  6 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi          |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi          |  4 +-
 drivers/bus/ti-sysc.c                             |  2 +-
 drivers/memory/brcmstb_dpfe.c                     | 74 ++++++++++++++++++-----
 drivers/soc/imx/gpc.c                             | 10 ++-
 45 files changed, 191 insertions(+), 137 deletions(-)
