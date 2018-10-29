Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5E0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5372080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5372080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJ3GP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:15:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37471 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3GP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:15:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id d14-v6so11126627qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81R+RnZIsM5mW3f2vJJFqWtGt/ikhiReTczNY0/ZVe8=;
        b=Ji/2g6805t14aITsJmglcbe6a54WRbH3Psu03DTRmeit7P4Vwk45A6H00bgbqrTWhO
         zEHBedH5Sqstbxftf8dq2iYyJ518QVR1W4Mtx8DHSD5h3ud0Dmzs3K2KdGDL3HSvs25F
         NgOn3mpWWYJI81ZLtE5KT/Ci9CIvoIxHBvtAEXPTHKEZ2/1DUJm3l1Mkxo35yqCfE91R
         YArQzSpzwa19K52hzhI93PHKpUfS3PYNfGTz7ot2iiOyqFhh/0mr9G5U+HIKV2am8yq0
         tkyXwWalObuW3ZmrjF/D31a46jhN4jbZ3TEKqTr/Gm/iR74fy0V/ElRcaEOqtFuBdF/x
         WvoA==
X-Gm-Message-State: AGRZ1gIGan151TJvvS1BqPoCeyb+DX6qBj8zGkLtuANVCTW0zmxlC49N
        UEr7TIOUcZTIxIdUYnTVDND9ZA1Zd69n3MQpbRc=
X-Google-Smtp-Source: AJdET5cJW1oScNRQkrnXNaxPjGsU0d8/LsMAQ7tyKzsjfcHkYP9PzhwQZZjKqc81N3IxvxhiZbCr/TB2vc4Gfi9K3Qk=
X-Received: by 2002:ac8:6899:: with SMTP id m25-v6mr83542qtq.96.1540848327672;
 Mon, 29 Oct 2018 14:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
In-Reply-To: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 22:25:11 +0100
Message-ID: <CAK8P3a0+QYho-fnVgM+QkKgHJnNKc2FFXDuLpfjBiPtGDF7vzw@mail.gmail.com>
Subject: [GIT PULL 4/4] ARM: SoC platform updates for 4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to f4f9554f16d0a14b8ced9b3b91bd4e545fca5d66:

  MAINTAINERS: Assign myself as a maintainer of ARM/LPC18XX
architecture (2018-10-11 16:27:58 +0200)

----------------------------------------------------------------
ARM: SoC platform updates for 4.20

A couple of platforms change hands in the MAINTAINERS file:

- Linus Walleij lists himself for the ARM Reference platforms:
  versatile, vexpress, integrator and realview. He has been the main
  contributor for these for a while, and makes it official now.

- Vladimir Zapolskiy takes over the LPC18xx platform from Joachim Eastwood

- Manivannan Sadhasivam becomes a secondary maintainer for the
  Actions Semi machines

- Nicolas Ferre lists updates the MAINTAINER listing for the AT91
  platform: Ludovic Desroches is now a co-maintainer for the platform, and
  several other people (Claudiu Beznea, Cristian Birsan, Eugen Hristev,
  Codrin Ciubotariu) take over individual device drivers.

Thanks everyone for working on this, and welcome to the new maintainers!

The "virt" platform on qemy or kvm can now be used in big-endian mode
without additional tricks, thanks to Jason Donenfeld.

Once again, we gain support for another NXP i.MX6 variant, this time
it's the i.MX 6ULZ 32-bit single-core version.

On arm64, we add support for two SoCs from Renesas: RZ/G2E (r8a774c0)
and RZ/G2M (r8a774a1). These are described as microcontrollers on the
manufacturer website, but appear to be rather powerful. The RZ/G2M is
used on the reference board for the CIP Super Long Term Support (SLTS)
Linux Kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Anson Huang (2):
      ARM: imx: add mmdc ipg clock operation for mmdc
      ARM: imx: add i.mx6ulz msl support

Arnd Bergmann (9):
      Merge tag 'zynq-soc-for-v4.20' of
https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'omap-for-v4.20/soc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.20/omap1-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'renesas-arm-soc-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'actions-arm64-soc-for-4.20' of
git://git.kernel.org/.../afaerber/linux-actions into next/soc
      Merge tag 'imx-soc-4.20' of
git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'mvebu-soc-4.20-1' of
git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'renesas-arm64-soc-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'samsung-soc-4.20-2' of
git://git.kernel.org/.../krzk/linux into next/soc

Bartlomiej Zolnierkiewicz (1):
      ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

Benjamin Gaignard (1):
      MAINTAINERS: Update stm32 entry

Biju Das (3):
      arm64: Add Renesas R8A774A1 support
      ARM: shmobile: r8a7744: Basic SoC support
      ARM: debug-ll: Add support for r8a7744

Cedric Roux (3):
      ARM: s3c24xx: formatting cleanup in mach-mini2440.c
      ARM: s3c24xx: Correct SD card write protect detection on Mini2440
      ARM: s3c24xx: Restore proper usage of pr_info/pr_cont

Chris Packham (2):
      ARM: mvebu: use dt_fixup to provide fallback for enable-method
      dt-bindings: marvell,prestera: Add common compatible string

Claudiu Beznea (1):
      ARM: at91: pm: remove pm_bu initialization in at91_pm_backup_init()

Fabrizio Castro (1):
      arm64: Add Renesas R8A774C0 support

Geert Uytterhoeven (3):
      ARM: shmobile: r8a7779: Remove unused includes
      ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
      arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol

Janusz Krzysztofik (5):
      ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
      ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
      ARM: OMAP1: ams-delta: register MODEM device earlier
      ARM: OMAP1: ams-delta-fiq: Use <linux/platform_data/gpio-omap.h>
      ARM: OMAP1: ams-delta: Don't request unused GPIOs

Jason A. Donenfeld (1):
      ARM: support big-endian for the virt architecture

Jisheng Zhang (1):
      MAINTAINERS: fix pattern in ARM/Synaptics berlin SoC section

Krzysztof Kozlowski (4):
      ARM: exynos: Store Exynos5420 register state in one variable
      ARM: exynos: Fix imprecise abort during Exynos5422 suspend to RAM
      ARM: s3c24xx: Remove empty gta02_pmu children probe
      ARM: s3c24xx: Consistently use tab for indenting member assignments

Kuninori Morimoto (1):
      ARM: shmobile: convert to SPDX identifiers

Linus Walleij (2):
      ARM: u300: Delete dummy SPI chip
      ARM: Assume maintainership of ARM reference designs

Manivannan Sadhasivam (6):
      MAINTAINERS: Add reviewer for ACTIONS platforms
      MAINTAINERS: Add Actions Semi S900 clk entries
      MAINTAINERS: Update clock binding entry for Actions Semi Owl SoCs
      MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
      MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver
      arm64: actions: Enable PINCTRL in platforms Kconfig

Marek Szyprowski (1):
      arm64: exynos: Enable generic power domain support

Marek Vasut (1):
      ARM: shmobile: Rework the PMIC IRQ line quirk

Nicolas Ferre (11):
      MAINTAINERS: ARM: at91: add co-maintainer for ARM/Microchip
      MAINTAINERS: update entry for Microchip NAND driver support
      MAINTAINERS: media: change Microchip ISI, ISC maintainers
      MAINTAINERS: ASoC: change maintainer for Microchip ALSA drivers
      MAINTAINERS: USB: change maintainer for Microchip USBA gadget driver
      MAINTAINERS: dmaengine: add files to Microchip dma entry
      MAINTAINERS: pwm: add entry for Microchip pwm driver
      MAINTAINERS: iio: add co-maintainer to SAMA5D2-compatible ADC driver
      MAINTAINERS: remove the / ATMEL string from MICROCHIP entries
      MAINTAINERS: move former ATMEL entries to proper MICROCHIP location
      MAINTAINERS: sdhci: move the Microchip entry to proper location

Nishanth Menon (1):
      MAINTAINERS: Drop dt-bindings/genpd/k2g.h

Oleksij Rempel (1):
      ARM: imx6: register pm_power_off handler if
"fsl,pmic-stby-poweroff" is set

Olof Johansson (1):
      Merge tag 'at91-4.20-soc' of git://git.kernel.org/.../at91/linux
into next/soc

Rob Herring (3):
      ARM: shmobile: Convert to using %pOFn instead of device_node.name
      ARM: zynq: Convert to using %pOFn instead of device_node.name
      ARM: OMAP2+: Convert to using %pOFn instead of device_node.name

Sergei Shtylyov (1):
      arm64: enable CMT/TMU support for Renesas SoC

Shawn Guo (1):
      MAINTAINERS: remove non-exsiting email address of Baoyou

Tero Kristo (1):
      ARM: OMAP2+: hwmod_core: improve the support for clkctrl clocks

Thomas Petazzoni (1):
      MAINTAINERS: replace free-electrons.com by bootlin.com for
Thomas Petazzoni

Tony Lindgren (1):
      Merge commit '1dbcb97c656eed1a244c960b8b3a469c3d20ce7b' into
omap-for-v4.20/soc

Vladimir Zapolskiy (1):
      MAINTAINERS: Assign myself as a maintainer of ARM/LPC18XX architecture

zhong jiang (1):
      ARM: at91: pm: call put_device instead of of_node_put in at91_pm_config_ws

 Documentation/arm/Samsung/Bootloader-interface.txt |   1 +
 .../devicetree/bindings/net/marvell,prestera.txt   |   4 +-
 MAINTAINERS                                        | 260 +++++++++++--------
 arch/arm/Kconfig                                   |   1 +
 arch/arm/Kconfig.debug                             |   9 +-
 arch/arm/mach-at91/pm.c                            |   9 +-
 arch/arm/mach-exynos/common.h                      |   1 +
 arch/arm/mach-exynos/firmware.c                    |  14 +-
 arch/arm/mach-exynos/suspend.c                     |  34 ++-
 arch/arm/mach-imx/anatop.c                         |  20 ++
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/mmdc.c                           |  14 ++
 arch/arm/mach-imx/mxc.h                            |   7 +
 arch/arm/mach-imx/pm-imx6.c                        |  29 ++-
 arch/arm/mach-mvebu/board-v7.c                     |  14 +-
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |  12 +-
 arch/arm/mach-omap1/board-ams-delta.c              | 161 ++++++------
 arch/arm/mach-omap1/include/mach/board-ams-delta.h |   7 -
 arch/arm/mach-omap2/omap_hwmod.c                   |  88 ++++---
 arch/arm/mach-s3c24xx/mach-gta02.c                 |  42 ----
 arch/arm/mach-s3c24xx/mach-mini2440.c              | 113 +++++----
 arch/arm/mach-shmobile/Kconfig                     |  10 +-
 arch/arm/mach-shmobile/headsmp-scu.S               |  13 +-
 arch/arm/mach-shmobile/headsmp.S                   |   7 +-
 arch/arm/mach-shmobile/platsmp-scu.c               |   5 +-
 arch/arm/mach-shmobile/platsmp.c                   |   5 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |   5 +-
 arch/arm/mach-shmobile/pm-rmobile.c                |   7 +-
 arch/arm/mach-shmobile/pm-rmobile.h                |   7 +-
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 139 ++++++++---
 arch/arm/mach-shmobile/setup-r8a7779.c             |   2 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |   2 +
 arch/arm/mach-shmobile/smp-sh73a0.c                |  10 +-
 arch/arm/mach-shmobile/suspend.c                   |   5 +-
 arch/arm/mach-shmobile/timer.c                     |  10 +-
 arch/arm/mach-u300/Kconfig                         |  13 -
 arch/arm/mach-u300/Makefile                        |   1 -
 arch/arm/mach-u300/dummyspichip.c                  | 276 ---------------------
 arch/arm/mach-zynq/slcr.c                          |   2 +-
 arch/arm/plat-samsung/Kconfig                      |   2 +-
 arch/arm64/Kconfig.platforms                       |  60 +++--
 include/linux/platform_data/gpio-omap.h            |   4 +
 42 files changed, 662 insertions(+), 766 deletions(-)
 delete mode 100644 arch/arm/mach-u300/dummyspichip.c
