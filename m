Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755736AbeDKTZN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:25:13 -0400
Received: from www.linux-watchdog.org ([185.87.125.42]:55942 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757164AbeDKTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:25:11 -0400
Date: Wed, 11 Apr 2018 21:12:33 +0200
From: wim@www.linux-watchdog.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [GIT PULL REQUEST] watchdog - v4.17-rc merge window
Message-ID: <20180411191233.GA6828@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the watchdog changes for the v4.17 release cycle.

This series contains:
* Add Nuvoton NPCM watchdog driver
* renesas_wdt: Add R-Car Gen2 support
* renesas_wdt: add suspend/resume and restart handler support
* hpwdt: convert to watchdog core and improve NMI
* improve timeout setting/handling in various drivers
* coh901327: make license text and module licence match
* fix error handling in asm9260_wdt, sprd_wdt and davinci_wdt
* aspeed imrovements
* dw improvements (for control register & suspend/resume)
* add SPDX identifiers for watchdog subsystem

The output from git request-pull:
----------------------------------------------------------------

The following changes since commit 2b3d89b402b085b08498e896c65267a145bed486:

  watchdog: hpwdt: Remove legacy NMI sourcing. (2018-03-03 15:52:33 +0100)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-4.17-rc1

for you to fetch changes up to 1991a55dc87e8f2557bc90d7f0062b7110ab8437:

  Merge branch 'v4.17-rc1' (2018-03-26 20:48:27 +0200)

----------------------------------------------------------------
linux-watchdog 4.17-rc1 merge window tag

----------------------------------------------------------------
Alexey Khoroshilov (3):
      watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()
      watchdog: sprd_wdt: Fix error handling in sprd_wdt_enable()
      watchdog: davinci_wdt: fix error handling in davinci_wdt_probe()

Brian Norris (2):
      watchdog: dw: RMW the control register
      watchdog: dw: save/restore control and timeout across suspend/resume

Fabrizio Castro (3):
      watchdog: renesas_wdt: Add suspend/resume support
      watchdog: renesas_wdt: Add R-Car Gen2 support
      watchdog: renesas_wdt: Add restart handler

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix WD_EN register read

Jerry Hoemann (8):
      watchdog: hpwdt: Update Module info and copyright.
      watchdog: hpwdt: Update nmi_panic message.
      watchdog: hpwdt: Modify to use watchdog core.
      watchdog: hpwdt: condition early return of NMI handler on iLO5
      watchdog: hpwdt: remove allow_kdump module parameter.
      watchdog: hpwdt: Programable Pretimeout NMI
      watchdog: hpwdt: Add dynamic debug
      watchdog: hpwdt: Update driver version.

Joel Stanley (2):
      dt-bindings: watchdog: Add Nuvoton NPCM description
      watchdog: Add Nuvoton NPCM watchdog driver

Marcus Folkesson (14):
      watchdog: imx2_wdt: allow setting timeout in devicetree
      watchdog: sama5d4: make use of timeout-secs provided in devicetree
      watchdog: sunxi: allow setting timeout in devicetree
      watchdog: sirfsoc: allow setting timeout in devicetree
      watchdog: pnx4008: make use of timeout-secs provided in devicetree
      watchdog: mtk: allow setting timeout in devicetree
      watchdog: meson: allow setting timeout in devicetree
      watchdog: coh901327: make use of timeout-secs provided in devicetree
      watchdog: uniphier: change order for setting default timeout
      watchdog: omap_wdt: change order for setting default timeout
      watchdog: gpio: change order for setting default timeout
      watchdog: lpc18xx: remove assignment of unused ret-value
      watchdog: coh901327: make license text and module licence match
      watchdog: add SPDX identifiers for watchdog subsystem

Milton Miller (2):
      watchdog: aspeed: Fix translation of reset mode to ctrl register
      watchdog: aspeed: Allow configuring for alternate boot

Wim Van Sebroeck (4):
      Merge branch 'v4.16-fixes'
      Merge branch 'v4.16-fixes'
      Merge branch 'v4.17-rc1'
      Merge branch 'v4.17-rc1'

 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |   2 +
 .../devicetree/bindings/watchdog/meson-wdt.txt     |   4 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   4 +
 .../bindings/watchdog/nuvoton,npcm-wdt.txt         |  28 ++
 .../devicetree/bindings/watchdog/sirfsoc_wdt.txt   |   4 +
 .../devicetree/bindings/watchdog/sunxi-wdt.txt     |   4 +
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ar7_wdt.c                         |  14 +-
 drivers/watchdog/asm9260_wdt.c                     |   8 +-
 drivers/watchdog/aspeed_wdt.c                      |  13 +-
 drivers/watchdog/at91rm9200_wdt.c                  |   5 +-
 drivers/watchdog/at91sam9_wdt.c                    |   5 +-
 drivers/watchdog/at91sam9_wdt.h                    |   5 +-
 drivers/watchdog/bcm2835_wdt.c                     |   5 +-
 drivers/watchdog/bcm47xx_wdt.c                     |   5 +-
 drivers/watchdog/bcm63xx_wdt.c                     |   5 +-
 drivers/watchdog/bcm7038_wdt.c                     |  12 +-
 drivers/watchdog/bcm_kona_wdt.c                    |   9 +-
 drivers/watchdog/cadence_wdt.c                     |   5 +-
 drivers/watchdog/coh901327_wdt.c                   |  18 +-
 drivers/watchdog/da9052_wdt.c                      |   6 +-
 drivers/watchdog/da9055_wdt.c                      |   6 +-
 drivers/watchdog/da9062_wdt.c                      |  10 +-
 drivers/watchdog/da9063_wdt.c                      |   5 +-
 drivers/watchdog/davinci_wdt.c                     |  15 +-
 drivers/watchdog/digicolor_wdt.c                   |   5 +-
 drivers/watchdog/dw_wdt.c                          |  32 ++-
 drivers/watchdog/ebc-c384_wdt.c                    |   1 +
 drivers/watchdog/f71808e_wdt.c                     |   2 +-
 drivers/watchdog/gpio_wdt.c                        |   4 +-
 drivers/watchdog/hpwdt.c                           | 312 ++++++++-------------
 drivers/watchdog/imx2_wdt.c                        |   8 +-
 drivers/watchdog/lpc18xx_wdt.c                     |   2 +-
 drivers/watchdog/mei_wdt.c                         |  12 +-
 drivers/watchdog/mena21_wdt.c                      |   4 +-
 drivers/watchdog/meson_gxbb_wdt.c                  |  50 +---
 drivers/watchdog/meson_wdt.c                       |   2 +-
 drivers/watchdog/mtk_wdt.c                         |  13 +-
 drivers/watchdog/mtx-1_wdt.c                       |  11 +-
 drivers/watchdog/npcm_wdt.c                        | 254 +++++++++++++++++
 drivers/watchdog/of_xilinx_wdt.c                   |   8 +-
 drivers/watchdog/omap_wdt.c                        |   4 +-
 drivers/watchdog/pnx4008_wdt.c                     |   2 +-
 drivers/watchdog/renesas_wdt.c                     |  87 +++++-
 drivers/watchdog/sama5d4_wdt.c                     |   6 +-
 drivers/watchdog/sirfsoc_wdt.c                     |   2 +-
 drivers/watchdog/sprd_wdt.c                        |   4 +-
 drivers/watchdog/st_lpc_wdt.c                      |   6 +-
 drivers/watchdog/sunxi_wdt.c                       |   2 +-
 drivers/watchdog/tangox_wdt.c                      |   6 +-
 drivers/watchdog/tegra_wdt.c                       |  10 +-
 drivers/watchdog/uniphier_wdt.c                    |  15 +-
 drivers/watchdog/wm831x_wdt.c                      |   5 +-
 drivers/watchdog/wm8350_wdt.c                      |   5 +-
 55 files changed, 628 insertions(+), 456 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
 create mode 100644 drivers/watchdog/npcm_wdt.c
