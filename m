Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086EC04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D932E20936
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="O5h/ROqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D932E20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbeHWIBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:01:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40993 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeHWIBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:01:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so1159328pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HRmUMV30LRpW+v7lb+IE5vny/Ri4GwpVJLt12tPTCUI=;
        b=O5h/ROqqEpABHHUgetGWunJYh6gMcd3UwKXBdDOXK1r3ShouC3NtYZvl3aMy+QHNxd
         bbS7rPjCzQi6qMq6isOsASlfMi03q0lKzfwRmAr+Iet3kzjkZ0TBvY2E3wsUHyIWY1IP
         ayJxDSjMamkjuQFRGPkoAfgNHGmsks/UBEIsCin2mdSkLTcRo4ljTU1XWtViSIqAqCSQ
         QXblGdHV7UMObD8prLSqOi5VGCeVbEMrdKbU6+4n/g9wYLiGJOxxxuWkmxbexn+Zb5AL
         Godma6/Nj3hZecrusjYYsNhlQn0/8eCPkg1im70drjH8ep4b/sK66XKwUsk3YWM+O6G4
         8pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRmUMV30LRpW+v7lb+IE5vny/Ri4GwpVJLt12tPTCUI=;
        b=QK3FuIxq5lFwy7/WflpDsAprHOc/1LMIYLeVxKOgyWgpoEfA6jt1miAX6dldGpTm/T
         c6ZvkIXOoVlA4vHhde6c/xihNYu1zyZ3PUvclLCRfvG/0pXb6pstCkIyJpUygf9CTz2T
         WnQxR2zEtv3O/4KKNC762HB3uFM4VFyQI+7nZTc820EqDVUmKc74N99fVqCjgl7o4FRN
         MM60SYKWLNA0R1oZ/boT/lpEP/Sg2VRfd7VVzESfdHg4ed79GwG3RyH7FE6Tc9z645Bn
         31a10cCM8dJpB3VujRkITJ4Ok045Aua9ELnjhJydxV4gLfbV6LDCUkRmSWRkhenfMLLe
         LOVQ==
X-Gm-Message-State: AOUpUlGz7wZyRIEPeraj9LGcp2x0nQzH/TNzignZaQF2Twt92C15YCpm
        K58bylLwiGTfwsAx9j5Bw1X8ow==
X-Google-Smtp-Source: AA+uWPxGP3Ozohl/RzTWncAhEITVg3N4VfZEyhQ0h8qc8ZKF/pF0nLgBT70y7N+TcgpjEPO4vgIKgw==
X-Received: by 2002:a62:4255:: with SMTP id p82-v6mr61166083pfa.238.1534998794274;
        Wed, 22 Aug 2018 21:33:14 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 70-v6sm4859947pfz.27.2018.08.22.21.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 21:33:11 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/4] ARM: 32-bit SoC platform updates
Date:   Wed, 22 Aug 2018 21:32:54 -0700
Message-Id: <20180823043257.18582-2-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180823043257.18582-1-olof@lixom.net>
References: <20180823043257.18582-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the SoC updates in this cycle are cleanups and moves to more
modern infrastructure:

- Davinci was moved to common clock framework
- OMAP1-based Amstrad E3 "Superphone" saw a bunch of cleanups to the
keyboard interface (bitbanged AT keyboard via GPIO).
- Removal of some stale code for Renesas platforms
- Power management improvements for i.MX6LL

----------------------------------------------------------------

The following changes since commit 815f0ddb346c196018d4d8f8f55c12b83da1de3f:

  include/linux/compiler*.h: make compiler-*.h mutually exclusive

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to f0fc40aff6fee100ffbed8328a0df88f8aa75fce:

  ARM: uniphier: select RESET_CONTROLLER

----------------------------------------------------------------

Andy Shevchenko (1):
      ARM: OMAP2+: reuse DEFINE_SHOW_ATTRIBUTE() macro

Anson Huang (6):
      ARM: imx: add standby mode suspend for i.MX6SLL
      ARM: imx: add mem mode suspend for i.MX6SLL
      ARM: imx: add L2 page power control for GPC
      ARM: imx: add cpu idle support for i.MX6SLL
      ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle driver
      ARM: imx: enable bus auto clock gating function for i.mx6sll

Arnd Bergmann (4):
      ARM: imx: fix i.MX6SLL build
      ARM: imx: call imx6sx_cpuidle_init() conditionally for 6sll
      soc: r9a06g032: don't build SMP files for non-SMP config
      ARM: shmobile: r8a7779: hide unused r8a7779_platform_cpu_kill

Arvind Yadav (1):
      ARM: OMAP1: constify gpio_led

Bartosz Golaszewski (13):
      clk: davinci: psc-da850: remove the 'davinci_nand.0" lookup
      clk: davinci: psc-dm365: use two lookup entries for the aemif clock
      clk: davinci: psc-dm644x: use two lookup entries for the aemif clock
      clk: davinci: psc-dm646x: use two lookup entries for the aemif clock
      clk: davinci: psc-da830: add a lookup entry for aemif clock
      ARM: davinci: omapl138-hawk: add aemif & nand support
      ARM: davinci: da850-evm: use aemif platform driver in legacy mode
      ARM: davinci: dm365-evm: use the ti-aemif soc driver
      ARM: davinci: dm644x-evm: use aemif platform driver
      ARM: davinci: da830-evm: use aemif platform driver
      ARM: davinci: dm646x-evm: use aemif platform driver
      ARM: davinci: mityomapl138: use aemif platform driver
      ARM: davinci: unduplicate aemif support

Boris Brezillon (1):
      MAINTAINERS: Remove the AT91 clk driver entry

Claudiu Beznea (3):
      ARM: at91: pm: Use ULP0 naming instead of slow clock
      ARM: at91: pm: add PMC fast startup registers defines
      ARM: at91: pm: configure wakeup sources for ULP1 mode

Clément Peron (3):
      ARM: imx: remove inexistant EPIT timer init
      ARM: debug: Add iProc UART3 debug addresses
      ARM: debug: fix BCM2836 order entry

Dave Gerlach (2):
      ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq enabled
      ARM: OMAP2+: sleep33/43xx: Make sleep actions configurable

David Lechner (21):
      ARM: davinci: pass clock as parameter to davinci_timer_init()
      ARM: davinci: da830: add new clock init using common clock framework
      ARM: davinci: da850: add new clock init using common clock framework
      ARM: davinci: dm355: add new clock init using common clock framework
      ARM: davinci: dm365: add new clock init using common clock framework
      ARM: davinci: dm644x: add new clock init using common clock framework
      ARM: davinci: dm646x: add new clock init using common clock framework
      ARM: davinci: da8xx: add new USB PHY clock init using common clock framework
      ARM: davinci: da8xx: add new sata_refclk init using common clock framework
      ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
      ARM: davinci: switch to common clock framework
      ARM: davinci: da830: Remove legacy clock init
      ARM: davinci: da850: Remove legacy clock init
      ARM: davinci: dm355: Remove legacy clock init
      ARM: davinci: dm365: Remove legacy clock init
      ARM: davinci: dm644x: Remove legacy clock init
      ARM: davinci: dm646x: Remove legacy clock init
      ARM: davinci: da8xx: Remove legacy USB and SATA clock init
      ARM: davinci: remove legacy clocks
      ARM: davinci: add device tree support to timer
      ARM: davinci: da8xx-dt: switch to device tree clocks

Denis Efremov (1):
      ARM: s3c24xx: Fix typo in guard macro of s3c2412.h

Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Fabio Estevam (2):
      ARM: imx51: Configure M4IF to avoid visual artifacts
      ARM: mx5: Set the DBGEN bit in ARM_GPC register

Geert Uytterhoeven (16):
      ARM: shmobile: r8a7790: Remove legacy SMP fallback code
      ARM: shmobile: r8a7790: Use common R-Car Gen2 machine definition
      ARM: shmobile: r8a7791: Remove legacy SMP fallback code
      ARM: shmobile: r8a7791: Use common R-Car Gen2 machine definition
      ARM: shmobile: Remove unused shmobile_smp_init_fallback_ops()
      ARM: shmobile: apmu: Move cpu_leave_lowpower() to SUSPEND section
      ARM: shmobile: apmu: Remove obsolete shmobile_smp_apmu_prepare_cpus()
      ARM: shmobile: apmu: Remove platsmp-apmu.h
      ARM: shmobile: rcar-gen2: Remove explicit SYSC config and init
      ARM: shmobile: r8a7779: Stop powering down secondary CPUs during early boot
      soc: renesas: rcar-sysc: Provide helpers to power up/down CPUs
      ARM: shmobile: r8a7779: Use rcar_sysc_power_{down,up}_cpu()
      ARM: shmobile: r8a7779: Remove explicit SYSC config and init
      soc: renesas: rcar-sysc: Drop legacy handling
      ARM: shmobile: rcar-gen2: Stop compiling headsmp-apmu on !SMP
      ARM: shmobile: Always enable ARCH_TIMER on SoCs with A7 and/or A15

Janusz Krzysztofik (13):
      ARM: OMAP1: ams-delta: refactor late_init()
      ARM: OMAP1: ams-delta: assign LED GPIO numbers from descriptors
      ARM: OMAP1: ams-delta: drop GPIO lookup table for serio device
      Input: ams_delta_serio: convert to platform driver
      Input: ams_delta_serio: use private structure
      Input: ams_delta_serio: Replace power GPIO with regulator
      ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin
      ARM: OMAP1: ams-delta FIQ: don't use static GPIO numbers
      ARM: OMAP1: ams-delta FIQ: Keep serio input GPIOs requested
      ARM: OMAP1: Get rid of <mach/ams-delta-fiq.h>
      Input: ams_delta_serio: use IRQ resource
      Input: ams_delta_serio: Get FIQ buffer from platform_data
      ARM: OMAP1: ams-delta: move late devices back to init_machine

Keerthy (1):
      ARM: OMAP2+: sleep33/43xx: Add RTC-Mode support

Krzysztof Kozlowski (2):
      ARM: exynos: Remove outdated maintainer information
      ARM: exynos: Clear global variable on init error path

Lucas Stach (1):
      ARM: mvebu: convert secondary CPU clock sync to hotplug state

Masahiro Yamada (3):
      ARM: uniphier: remove empty Makefile
      arm64: uniphier: select RESET_CONTROLLER
      ARM: uniphier: select RESET_CONTROLLER

Michel Pollet (1):
      ARM: shmobile: Add the R9A06G032 SMP enabler driver

Nicholas Mc Guire (4):
      ARM: imx: flag failure of of_iomap
      ARM: hisi: fix error handling and missing of_node_put
      ARM: hisi: check of_iomap and fix missing of_node_put
      ARM: hisi: handle of_iomap and fix missing of_node_put

Oleksij Rempel (1):
      ARM: imx: Provide support for NXP i.MX7D Cortex-M4

Olof Johansson (14):
      Merge tag 'renesas-arm-soc-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'arm-soc/for-4.19/soc' of https://github.com/Broadcom/stblinux into next/soc
      Merge tag 'davinci-for-v4.19/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'imx-maintainer-4.19' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'omap-for-v4.19/omap1-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.19/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'tegra-for-4.19-firmware' of git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'pxa-for-4.19-v2' of https://github.com/rjarzmik/linux into next/soc
      Merge tag 'mvebu-arm-4.19-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'hisi-armv7-soc-for-4.19' of git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'at91-ab-4.19-soc' of git://git.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'renesas-arm-soc2-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'imx-soc-4.19' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'samsung-soc-4.19' of https://git.kernel.org/.../krzk/linux into next/soc

Robert Jarzmik (6):
      ARM: pxa: hx4700: fix the usb client
      ARM: pxa: mioa701 convert to the new AC97 bus
      ARM: pxa: add the missing AC97 clocks
      ARM: pxa: zylonite: use the new ac97 bus support
      net: smc911x: remove the dmaengine compat need
      net: smc91x: remove the dmaengine compat need

Sekhar Nori (1):
      Merge branch 'for-sekhar' of https://github.com/dlech/linux into v4.19/soc

Shawn Guo (1):
      MAINTAINERS: add Freescale Layerscape ARM architecture entry

Stefan Agner (1):
      ARM: trusted_foundations: do not use naked function

Vladimir Zapolskiy (1):
      ARM: i.MX31: remove rnga registration as a platform device

Wenyou Yang (1):
      ARM: at91: pm: Add ULP1 mode support

Wolfram Sang (1):
      ARM: shmobile: convert to SPDX identifier


 MAINTAINERS                                     |  16 +-
 arch/arm/Kconfig                                |   5 +-
 arch/arm/Kconfig.debug                          |  14 +-
 arch/arm/Makefile                               |   1 -
 arch/arm/firmware/trusted_foundations.c         |  14 +-
 arch/arm/include/debug/renesas-scif.S           |   5 +-
 arch/arm/mach-at91/pm.c                         | 187 ++++-
 arch/arm/mach-at91/pm.h                         |   6 +-
 arch/arm/mach-at91/pm_suspend.S                 | 142 +++-
 arch/arm/mach-davinci/Kconfig                   |  13 +-
 arch/arm/mach-davinci/Makefile                  |   4 +-
 arch/arm/mach-davinci/aemif.c                   | 218 ------
 arch/arm/mach-davinci/board-da830-evm.c         |  68 +-
 arch/arm/mach-davinci/board-da850-evm.c         |  95 ++-
 arch/arm/mach-davinci/board-dm355-evm.c         |   2 +
 arch/arm/mach-davinci/board-dm355-leopard.c     |   2 +
 arch/arm/mach-davinci/board-dm365-evm.c         |  61 +-
 arch/arm/mach-davinci/board-dm644x-evm.c        |  57 +-
 arch/arm/mach-davinci/board-dm646x-evm.c        |  54 +-
 arch/arm/mach-davinci/board-mityomapl138.c      |  57 +-
 arch/arm/mach-davinci/board-neuros-osd2.c       |   2 +
 arch/arm/mach-davinci/board-omapl138-hawk.c     | 143 +++-
 arch/arm/mach-davinci/board-sffsdr.c            |   2 +
 arch/arm/mach-davinci/clock.c                   | 745 ------------------
 arch/arm/mach-davinci/clock.h                   |  76 --
 arch/arm/mach-davinci/common.c                  |   3 -
 arch/arm/mach-davinci/da830.c                   | 462 ++---------
 arch/arm/mach-davinci/da850.c                   | 778 +++----------------
 arch/arm/mach-davinci/da8xx-dt.c                |  66 --
 arch/arm/mach-davinci/davinci.h                 |   8 +
 arch/arm/mach-davinci/devices-da8xx.c           |  43 +-
 arch/arm/mach-davinci/devices.c                 |   1 -
 arch/arm/mach-davinci/dm355.c                   | 406 ++--------
 arch/arm/mach-davinci/dm365.c                   | 485 +-----------
 arch/arm/mach-davinci/dm644x.c                  | 344 ++------
 arch/arm/mach-davinci/dm646x.c                  | 372 ++-------
 arch/arm/mach-davinci/include/mach/clock.h      |   3 -
 arch/arm/mach-davinci/include/mach/common.h     |  11 +-
 arch/arm/mach-davinci/include/mach/da8xx.h      |   6 +-
 arch/arm/mach-davinci/pm_domain.c               |   5 +
 arch/arm/mach-davinci/psc.c                     | 137 ----
 arch/arm/mach-davinci/psc.h                     |  12 -
 arch/arm/mach-davinci/time.c                    |  22 +-
 arch/arm/mach-davinci/usb-da8xx.c               | 242 +-----
 arch/arm/mach-exynos/exynos.c                   |   2 -
 arch/arm/mach-exynos/suspend.c                  |   1 +
 arch/arm/mach-hisi/hotplug.c                    |  41 +-
 arch/arm/mach-imx/Kconfig                       |  33 +-
 arch/arm/mach-imx/Makefile                      |   5 +-
 arch/arm/mach-imx/common.h                      |   3 +-
 arch/arm/mach-imx/cpu-imx5.c                    |  45 ++
 arch/arm/mach-imx/cpu.c                         |   1 +
 arch/arm/mach-imx/cpuidle-imx6sl.c              |   7 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c              |   1 +
 arch/arm/mach-imx/gpc.c                         |  14 +
 arch/arm/mach-imx/imx31-dt.c                    |  18 -
 arch/arm/mach-imx/mach-imx51.c                  |  30 +-
 arch/arm/mach-imx/mach-imx53.c                  |   2 +-
 arch/arm/mach-imx/mach-imx6sl.c                 |   5 +-
 arch/arm/mach-imx/mach-imx7d-cm4.c              |  18 +
 arch/arm/mach-imx/pm-imx6.c                     |  33 +-
 arch/arm/mach-mvebu/platsmp.c                   |  49 +-
 arch/arm/mach-mvebu/pmsu.c                      |   6 +-
 arch/arm/mach-omap1/ams-delta-fiq-handler.S     |   5 +-
 arch/arm/mach-omap1/ams-delta-fiq.c             | 113 ++-
 arch/arm/mach-omap1/ams-delta-fiq.h             |  42 +
 arch/arm/mach-omap1/board-ams-delta.c           | 301 +++++--
 arch/arm/mach-omap1/board-h2.c                  |   2 +-
 arch/arm/mach-omap1/board-h3.c                  |   2 +-
 arch/arm/mach-omap1/board-htcherald.c           |   2 +-
 arch/arm/mach-omap1/board-osk.c                 |   4 +-
 arch/arm/mach-omap2/omap_hwmod_reset.c          |  12 +-
 arch/arm/mach-omap2/pm-asm-offsets.c            |   2 +
 arch/arm/mach-omap2/pm-debug.c                  |  37 +-
 arch/arm/mach-omap2/pm33xx-core.c               |  20 +-
 arch/arm/mach-omap2/sleep33xx.S                 |  52 +-
 arch/arm/mach-omap2/sleep43xx.S                 | 110 ++-
 arch/arm/mach-pxa/devices.c                     |  13 +
 arch/arm/mach-pxa/hx4700.c                      |   4 +
 arch/arm/mach-pxa/mioa701.c                     |   2 -
 arch/arm/mach-pxa/zylonite.c                    |  11 -
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h    |   2 +-
 arch/arm/mach-shmobile/Kconfig                  |   2 +
 arch/arm/mach-shmobile/Makefile                 |   8 +-
 arch/arm/mach-shmobile/common.h                 |   1 -
 arch/arm/mach-shmobile/headsmp-apmu.S           |   7 +-
 arch/arm/mach-shmobile/platsmp-apmu.c           | 245 +++---
 arch/arm/mach-shmobile/platsmp-apmu.h           |  32 -
 arch/arm/mach-shmobile/platsmp.c                |   9 -
 arch/arm/mach-shmobile/pm-r8a7779.c             |  41 -
 arch/arm/mach-shmobile/pm-rcar-gen2.c           |  25 -
 arch/arm/mach-shmobile/r8a7779.h                |   2 -
 arch/arm/mach-shmobile/r8a7790.h                |   7 -
 arch/arm/mach-shmobile/r8a7791.h                |   7 -
 .../mach-shmobile/regulator-quirk-rcar-gen2.c   |  10 +-
 arch/arm/mach-shmobile/setup-emev2.c            |  10 +-
 arch/arm/mach-shmobile/setup-r7s72100.c         |  10 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c          |  11 +-
 arch/arm/mach-shmobile/setup-r8a7740.c          |  10 +-
 arch/arm/mach-shmobile/setup-r8a7778.c          |  10 +-
 arch/arm/mach-shmobile/setup-r8a7779.c          |  10 +-
 arch/arm/mach-shmobile/setup-r8a7790.c          |  38 -
 arch/arm/mach-shmobile/setup-r8a7791.c          |  39 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |  20 +-
 arch/arm/mach-shmobile/setup-sh73a0.c           |  10 +-
 arch/arm/mach-shmobile/smp-emev2.c              |  10 +-
 arch/arm/mach-shmobile/smp-r8a7779.c            |  78 +-
 arch/arm/mach-shmobile/smp-r8a7790.c            |  71 --
 arch/arm/mach-shmobile/smp-r8a7791.c            |  53 --
 arch/arm/mach-shmobile/timer.c                  |   8 -
 arch/arm/mach-uniphier/Kconfig                  |   1 +
 arch/arm/mach-uniphier/Makefile                 |   0
 arch/arm64/Kconfig.platforms                    |   1 +
 drivers/clk/davinci/psc-da830.c                 |   3 +-
 drivers/clk/davinci/psc-da850.c                 |   3 +-
 drivers/clk/davinci/psc-dm365.c                 |   3 +-
 drivers/clk/davinci/psc-dm644x.c                |   3 +-
 drivers/clk/davinci/psc-dm646x.c                |   3 +-
 drivers/input/serio/ams_delta_serio.c           | 198 ++---
 drivers/net/ethernet/smsc/smc911x.c             |  13 +-
 drivers/net/ethernet/smsc/smc91x.c              |   9 +-
 drivers/net/ethernet/smsc/smc91x.h              |   1 -
 drivers/soc/renesas/Makefile                    |   3 +
 drivers/soc/renesas/r9a06g032-smp.c             |  96 +++
 drivers/soc/renesas/rcar-sysc.c                 |  64 +-
 drivers/soc/ti/pm33xx.c                         |  16 +-
 include/linux/clk/at91_pmc.h                    |  15 +
 include/linux/cpuhotplug.h                      |   1 +
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h     |   3 +
 .../linux/platform_data}/ams-delta-fiq.h        |  31 +-
 include/linux/platform_data/mtd-davinci-aemif.h |   1 -
 include/linux/platform_data/pm33xx.h            |  29 +-
 include/linux/soc/renesas/rcar-sysc.h           |  13 +-
 133 files changed, 2432 insertions(+), 5307 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/aemif.c
 delete mode 100644 arch/arm/mach-davinci/clock.c
 delete mode 100644 arch/arm/mach-davinci/psc.c
 create mode 100644 arch/arm/mach-imx/mach-imx7d-cm4.c
 create mode 100644 arch/arm/mach-omap1/ams-delta-fiq.h
 delete mode 100644 arch/arm/mach-shmobile/platsmp-apmu.h
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7779.c
 delete mode 100644 arch/arm/mach-shmobile/r8a7790.h
 delete mode 100644 arch/arm/mach-shmobile/r8a7791.h
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7791.c
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7791.c
 delete mode 100644 arch/arm/mach-uniphier/Makefile
 create mode 100644 drivers/soc/renesas/r9a06g032-smp.c
 rename {arch/arm/mach-omap1/include/mach => include/linux/platform_data}/ams-delta-fiq.h (68%)
