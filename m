Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33496C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB41E20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="z4AvOhMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeLaVq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:46:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43334 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbeLaVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:46:54 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so13045171pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9A+7yoanUGtCCAhWFTCiIEkDdBciZZherERnp1z9co=;
        b=z4AvOhMl/lqssutws8bytcqS2WXci7yYaVsYXelJroxPYjeMBukt497IxdAwRkUeyX
         LQylLrLjIw8zuT3fBaKQrWe9YNH/18dGkuJ16rfrDqISiomO6GvAw98bcVWcSrr+LOSp
         vPdxxfDtKHZfEui+3OeS8WjW2oYUa42m2A9rADv5g/Ju0Rw9jVhR9h3IK2Qga5JOA0Tm
         fCo09NDI6eDJEyao7RI5GgRtDz4cRbk0C0MvBmnyxNA6e8kTOEPn2X9FcIZnrSlOQVSB
         xVuI/ZMjLFAdrn8HomEmhC0gcCWDDTw5DkaATifLwuO5zmS9KdNHQ3jSMAsn5MemNDpJ
         MYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9A+7yoanUGtCCAhWFTCiIEkDdBciZZherERnp1z9co=;
        b=g3kYnGy5E/H7jwDQErD5JdKdQrO6U/HFO6ii2K2LgoclJz8pHu2HGiokmpU7MB9cNv
         muU0mz2bMzL7EcYMlzN/UdS06BfHPnCjJ4GKlohILHD5NOXn29uHjYX5nB3yRm+BLxQj
         jHxEscSeWbSILkEeZvXTtyxOT+EDW92yMw4DOV8aV1nrDRyljBRZ1FMsLYrSFuQhHl/e
         TVRHLCWBk337aBPdd92LC85J+iQAeOuc8J1M9RbYYBr9H2VGOB81p41Tgi7Ecr83eTad
         1EjLoT0epVg2PWovWKY0AQKNjDUrMa7Dx1cjXUpg47u0ricMsDroyTDsVkPes0tbhHWX
         kzTg==
X-Gm-Message-State: AJcUukdc/PGl1mlPx/oXGnwmEeenupvgcb9whPvNUID5f+0m8ocqYnaY
        kqb7ToscYgJVFKU6gQAGlOzQIg==
X-Google-Smtp-Source: ALg8bN5Fyf0DsZKsxis8f87OVJL70VPcI284h2u8fOIYswv/VAVeegkvUDMLG6fyCJi9yygkFXZLxg==
X-Received: by 2002:a63:4c04:: with SMTP id z4mr8860922pga.312.1546292813537;
        Mon, 31 Dec 2018 13:46:53 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u126sm96477085pgb.2.2018.12.31.13.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 13:46:51 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/4] ARM: SoC platform updates
Date:   Mon, 31 Dec 2018 13:46:37 -0800
Message-Id: <20181231214640.17015-2-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181231214640.17015-1-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoC updates, mostly refactorings and cleanups of old legacy platforms,
but also a few more things:

New SoC support this release:
- NXP/Freescale i.MX7ULP (1x Cortex-A7, Cortex-M4, graphics, etc)
- Allwinner F1C100, older platform with an ARM926-EJS (ARMv5) core

Cleanups of various platforms:
- OMAP1 ams-delta does some GPIO cleanups
- Davinci removes of at24 platform data
- Samsung cleans up old wakeup, PM debug and secondary core boot code
- Renesas moves around config options and PM code to drivers/soc for
sharing with 64-bit and more consistency
- i.MX, Broadcom and SoCFPGA all have tweaks to lowlevel debug console setups
- SoCFPGA adds explicit selection of ARM errata and removes some unused code

This tag also contains a few patches that I had queued up as fixes for
4.20 but didn't send in before the release.


Conflicts:

arch/arm/mach-omap1/board-ams-delta.c:
Change/remove. Remove the code that's in conflict (the leds/gpio init
functions)

arch/arm/mach-socfpga/Kconfig:
Add/change. Keep new set of errata and PCI_DOMAINS_GENERIC, drop
PCI_DOMAINS.

----------------------------------------------------------------

The following changes since commit f12e840c819bab42621685558a01d3f46ab9a226:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to cac1fc8fb561ac766468394d49c3dd11a2b8cb44:

  Merge branch 'fixes' into next/soc

----------------------------------------------------------------

A.s. Dong (1):
      ARM: imx: add initial support for imx7ulp

Aaro Koskinen (4):
      ARM: OMAP1/2: fix SoC name printing
      ARM: OMAP1: devices: configure omap1_spi100k only on OMAP7xx
      ARM: OMAP1: add MMC configuration for Palm Tungsten E
      ARM: OMAP1: fix USB configuration for device-only setups

Arnd Bergmann (8):
      ARM: imx: fix dependencies on imx7ulp
      ARM: mmp: fix timer_init calls
      ARM: mmp: fix pxa168_device_usb_phy use on aspenite
      ARM: pxa: avoid section mismatch warning
      ARM: ks8695: fix section mismatch warning
      ARM: tegra: avoid section mismatch warning
      ARM: omap2: avoid section mismatch warning
      Merge tag 'renesas-fixes2-for-v4.20' of git://git.kernel.org/.../horms/renesas into fixes

Bartlomiej Zolnierkiewicz (2):
      ARM: exynos: Remove no longer needed s3c_pm_check_*() calls
      ARM: samsung: Limit SAMSUNG_PM_DEBUG config option to non-Exynos platforms

Bartosz Golaszewski (7):
      ARM: davinci: dm365-evm: use cell nvmem lookup for mac address
      ARM: davinci: dm644x-evm: use cell nvmem lookup for mac address
      ARM: davinci: dm646x-evm: use cell nvmem lookup for mac address
      ARM: davinci: da830-evm: use cell nvmem lookup for mac address
      ARM: davinci: mityomapl138: use cell nvmem lookup for mac address
      ARM: davinci: dm850-evm: use cell nvmem lookup for mac address
      ARM: davinci: da850-evm: remove unnecessary include

Carlo Caione (1):
      MAINTAINERS: Remove myself from the list

Clément Péron (2):
      ARM: debug: enable UART1 for socfpga Cyclone5
      ARM: socfpga: Clean unused functions

Corentin Labbe (1):
      MAINTAINERS: add drivers/soc/amlogic/ to amlogic list

Dinh Nguyen (1):
      ARM: socfpga: Turn on ARM errata for L2 cache

Felix Brack (1):
      ARM: dts: am335x-pdu001: Fix polarity of card detection input

Florian Fainelli (2):
      ARM: BCM63XX: Enable reset controller support
      Merge tag 'tags/bcm2835-soc-next-2018-11-27' into soc/next

Geert Uytterhoeven (9):
      ARM: shmobile: Restrict SCU support to SoCs that have it
      ARM: shmobile: Restrict TWD support to SoCs that have it
      ARM: shmobile: sh73a0: Remove obsolete inclusion of <asm/smp_twd.h>
      ARM: shmobile: Hide ARCH_RZN1 to improve consistency
      arm64: renesas: Move SoC Kconfig symbols to drivers/soc/renesas/
      ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/
      ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h>
      ARM: shmobile: R-Mobile: Clean up struct rmobile_pm_domain
      ARM: shmobile: R-Mobile: Move pm-rmobile to drivers/soc/renesas/

Gerald Baeza (1):
      ARM: stm32: debug: add low-level debug support

Janusz Krzysztofik (6):
      ARM: OMAP1: ams-delta: make board header file local to mach-omap1
      ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device
      ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
      ARM: OMAP1: ams-delta: Drop unused symbols from the board header
      ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file
      ARM: OMAP1: ams-delta: Fix audio permanently muted

Justin Chen (1):
      ARM: brcmstb: Add entry for 7255

Krzysztof Kozlowski (2):
      ARM: s5pv210: Remove legacy setting of external wakeup interrupts
      ARM: exynos: Remove legacy setting of external wakeup interrupts

Laurent Pinchart (1):
      arm64: dts: renesas: draak: Fix CVBS input

Lubomir Rintel (4):
      ARM: mmp2: initialize clocks before the timer
      ARM: mmp/mmp2: dt: enable the clock
      ARM: mmp: add a pxa-usb-phy device
      ARM: mmp: add an instance of pxa-usb-phy to ttc_dkb and aspenite

Martin Blumenstingl (1):
      ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER

Mesih Kilinc (4):
      ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
      dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
      ARM: sunxi: add Allwinner ARMv5 SoCs
      dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt

Nathan Chancellor (2):
      ARM: OMAP2+: hwmod: Fix some section annotations
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Olof Johansson (13):
      Merge tag 'socfpga_updates_for_v5.0' of git://git.kernel.org/.../dinguyen/linux into next/soc
      Merge tag 'omap-for-v4.21/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'arm-soc/for-4.21/soc' of https://github.com/Broadcom/stblinux into next/soc
      Merge tag 'renesas-soc-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'davinci-for-v4.21/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'sunxi-core-for-4.21' of https://git.kernel.org/.../sunxi/linux into next/soc
      Merge tag 'samsung-soc-4.21' of https://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'imx-soc-4.21' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'omap-for-v4.21/omap1-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'amlogic-soc' of https://git.kernel.org/.../khilman/linux-amlogic into next/soc
      Merge tag 'omap-for-v4.20/fixes-rc6' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'v4.20-rockchip-dts64fixes-2' of git://git.kernel.org/.../mmind/linux-rockchip into fixes
      Merge branch 'fixes' into next/soc

Oskari Lemmela (1):
      arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios

Pankaj Dubey (1):
      ARM: exynos: Remove secondary startup initialization from smp_prepare_cpus

Roger Quadros (1):
      ARM: dts: omap5: Fix dual-role mode on Super-Speed port

Russell King - ARM Linux (1):
      ARM: dts: Fix OMAP4430 SDP Ethernet startup

Stefan Wahren (1):
      ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier

Takeshi Kihara (1):
      arm64: renesas: Enable GPIOLIB to allow GPIO driver selection

Tony Lindgren (2):
      Merge branch 'audio-fix' into omap-for-v4.20/fixes
      Merge branch 'omap1-usb-fix' into omap-for-v4.21/omap1

Uwe Kleine-König (1):
      ARM: debug-imx: only define DEBUG_IMX_UART_PORT if needed

Yangtao Li (2):
      ARM: OMAP1: clock: Change to use DEFINE_SHOW_ATTRIBUTE macro
      ARM: OMAP: PM: Change to use DEFINE_SHOW_ATTRIBUTE macro


 Documentation/devicetree/bindings/arm/sunxi.txt |   1 +
 .../devicetree/bindings/watchdog/sunxi-wdt.txt  |   1 +
 MAINTAINERS                                     |   2 +-
 arch/arm/Kconfig.debug                          |  78 ++++--
 arch/arm/boot/dts/am335x-pdu001.dts             |   2 +-
 arch/arm/boot/dts/omap4-sdp.dts                 |   1 +
 arch/arm/boot/dts/omap5-board-common.dtsi       |   1 +
 arch/arm/include/debug/brcmstb.S                |  24 +-
 arch/arm/include/debug/stm32.S                  |  41 ++++
 arch/arm/mach-bcm/Kconfig                       |   1 +
 arch/arm/mach-bcm/board_bcm2835.c               |  11 +-
 arch/arm/mach-bcm/platsmp.c                     |  10 +-
 arch/arm/mach-bcm/platsmp.h                     |   6 +-
 arch/arm/mach-davinci/board-da830-evm.c         |  26 ++
 arch/arm/mach-davinci/board-da850-evm.c         |  30 ++-
 arch/arm/mach-davinci/board-dm365-evm.c         |  25 ++
 arch/arm/mach-davinci/board-dm644x-evm.c        |  24 ++
 arch/arm/mach-davinci/board-dm646x-evm.c        |  24 ++
 arch/arm/mach-davinci/board-mityomapl138.c      |  29 +++
 arch/arm/mach-exynos/common.h                   |   2 -
 arch/arm/mach-exynos/platsmp.c                  |  26 --
 arch/arm/mach-exynos/suspend.c                  |  37 ++-
 arch/arm/mach-imx/Kconfig                       |   9 +
 arch/arm/mach-imx/Makefile                      |   1 +
 arch/arm/mach-imx/common.h                      |   1 +
 arch/arm/mach-imx/cpu.c                         |   3 +
 arch/arm/mach-imx/mach-imx7ulp.c                |  31 +++
 arch/arm/mach-imx/mxc.h                         |   1 +
 arch/arm/mach-imx/pm-imx7ulp.c                  |  29 +++
 arch/arm/mach-ks8695/board-acs5k.c              |   2 +-
 arch/arm/mach-meson/Kconfig                     |   2 +
 arch/arm/mach-mmp/aspenite.c                    |   7 +
 arch/arm/mach-mmp/common.h                      |   2 +-
 arch/arm/mach-mmp/devices.c                     |  21 ++
 arch/arm/mach-mmp/mmp2-dt.c                     |   2 +-
 arch/arm/mach-mmp/mmp2.c                        |   2 +-
 arch/arm/mach-mmp/pxa168.c                      |   2 +-
 arch/arm/mach-mmp/pxa910.c                      |   2 +-
 arch/arm/mach-mmp/pxa910.h                      |   1 +
 arch/arm/mach-mmp/time.c                        |  32 ++-
 arch/arm/mach-mmp/ttc_dkb.c                     |   6 +
 arch/arm/mach-omap1/Makefile                    |   2 +-
 arch/arm/mach-omap1/ams-delta-fiq-handler.S     |   2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c             |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c           | 112 +++------
 .../{include/mach => }/board-ams-delta.h        |  24 +-
 arch/arm/mach-omap1/board-palmte.c              |  29 +++
 arch/arm/mach-omap1/clock.c                     |  14 +-
 arch/arm/mach-omap1/devices.c                   |   3 +
 arch/arm/mach-omap1/id.c                        |   6 +-
 arch/arm/mach-omap1/include/mach/usb.h          |   2 +-
 arch/arm/mach-omap1/pm.c                        |  13 +-
 arch/arm/mach-omap2/id.c                        |   4 +-
 arch/arm/mach-omap2/omap_hwmod.c                |   6 +-
 arch/arm/mach-omap2/pm33xx-core.c               |   2 +-
 arch/arm/mach-omap2/timer.c                     |   1 -
 arch/arm/mach-pxa/cm-x300.c                     |   2 +-
 arch/arm/mach-pxa/littleton.c                   |   2 +-
 arch/arm/mach-pxa/zeus.c                        |   2 +-
 arch/arm/mach-s5pv210/common.h                  |   1 -
 arch/arm/mach-s5pv210/pm.c                      |  16 +-
 arch/arm/mach-shmobile/Kconfig                  | 129 ----------
 arch/arm/mach-shmobile/Makefile                 |   1 -
 arch/arm/mach-shmobile/pm-rmobile.h             |  22 --
 arch/arm/mach-shmobile/smp-sh73a0.c             |   1 -
 arch/arm/mach-socfpga/Kconfig                   |   7 +
 arch/arm/mach-socfpga/core.h                    |   2 -
 arch/arm/mach-socfpga/socfpga.c                 |   2 +-
 arch/arm/mach-sunxi/Kconfig                     |  19 +-
 arch/arm/mach-sunxi/sunxi.c                     |   9 +
 arch/arm/mach-tegra/irq.c                       |   4 +-
 arch/arm/plat-samsung/Kconfig                   |   1 +
 arch/arm64/Kconfig.platforms                    |  60 +----
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |   2 +-
 .../boot/dts/rockchip/rk3399-rockpro64.dts      |  20 +-
 drivers/soc/renesas/Kconfig                     | 241 +++++++++++++++++--
 drivers/soc/renesas/Makefile                    |   1 +
 .../soc/renesas/rmobile-sysc.c                  |  37 ++-
 78 files changed, 822 insertions(+), 540 deletions(-)
 create mode 100644 arch/arm/include/debug/stm32.S
 create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
 create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (66%)
 delete mode 100644 arch/arm/mach-shmobile/pm-rmobile.h
 rename arch/arm/mach-shmobile/pm-rmobile.c => drivers/soc/renesas/rmobile-sysc.c (93%)
