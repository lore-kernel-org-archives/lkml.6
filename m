Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7A5D6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED97208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="D1p3dSVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED97208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934142AbeFLACT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:02:19 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44529 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeFLACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:02:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id p21-v6so10529616pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQGLAMYDZ1THiF6rhfMMJllrHahrNztnAhjyHFLNa0Q=;
        b=D1p3dSVJ5PkSCAA6NLf1TWEbnBlXbNqrHzN2EFsCYch56YFaK/E8ZPex9pE7vfNbdw
         Dcho8fSkohvPnB4hNWPORY93uvjeTPfWL6gYRsWxbMc25jpZafKaKVanVXfjwG4icTpT
         qp302sfzamS4nrPaAhovQ6QDJSa/3A4swA7CQmIW+U5TzUPzYpOxRt65Un5T96iPXZqU
         83Bm2yX4Z/D64Zi6n/c+kTQoYhYwbQk9YUiCBnqw9GvJjaSx6bahyPR5w2d77ldKBfv5
         uqpX0tCC2zmtQEq9EM/9bnItAICL/mZnMmP1NCn2zamxb/Fvfd7RrG+ymI/BN92e1tP6
         imvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQGLAMYDZ1THiF6rhfMMJllrHahrNztnAhjyHFLNa0Q=;
        b=BIkhBZJjmm3XbwAtKKynrMnb8Nq9vRJf9OQLRZ61pUw1bB1dbgNtqsGpObtesJAzTz
         AqJ9Xr0DvUh9oaEJDThRShmPfeGQDDSGBeuoRRqb3x0feaNVFNxENh0huqRQMarZd2yW
         MCvHL28P0QIq7gXySfidettYSI0OCtbHLO9vU9zt3Sd0Dz7Eps+Vu3GBNvjNqSCyqUcE
         3q3W2aeDK8hgXTzT3VF8/Ra63ICPUSquhbJlGpIhVJwsPSdQtbyAOYqsECUZTnnbC2Xb
         YHx4U5YolE4ovWaOu/AVspiY2geUQdmHsjjslcfKC6sDdmi5f6FCMbdxRe8TIsTlDOV+
         m15g==
X-Gm-Message-State: APt69E1Mdd9COf7WeHt7rhW8c67agK58jiEyfxYtvQDvxdHRJIDX0yAk
        aQoJd8X+A0Zbl6VdaQHgjGS1qQ==
X-Google-Smtp-Source: ADUXVKL+d6Fmzx+AjMOQrVJzCdTHJdOf+JqB0Yxg4NPTEBd/IVablU3fQJzb60AAW9tI9HXa8ynRjQ==
X-Received: by 2002:a65:5246:: with SMTP id q6-v6mr1085453pgp.152.1528761733932;
        Mon, 11 Jun 2018 17:02:13 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id c27-v6sm82016623pfl.63.2018.06.11.17.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:02:11 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/4] ARM: SoC platform updates
Date:   Mon, 11 Jun 2018 17:01:39 -0700
Message-Id: <20180612000142.28883-2-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612000142.28883-1-olof@lixom.net>
References: <20180612000142.28883-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the main updates for SoC support (besides DT additions) for ARM
32- and 64-bit platforms. The branch also contains defconfig updates to
turn on drivers and options as needed on the various platforms.

The largest parts of the delta are from cleanups moving platform data
and board file setup of TI platforms to ti-sysc bus drivers. There are
also some sweeping changes of eeprom and nand setup on Davinci, i.MX
and other platforms.

Samsung is removing support for Exynos5440, which was an oddball SoC
that hasn't been seen much use in designs.

Renesas is adding support for new SoCs (R-Car E3, RZ/G1C and RZ/N1D).

Linus Walleij is also removing support for ux500 (Sony Ericsson)
U8540/9540 SoCs that never made it to significant mass production and
products.



Conflicts:

arch/arm/include/asm/cputype.h: Add/add. Keep our version
arch/arm/mach-exynos/Kconfig: Change/remove. SOC_EXYNOS5440 is being removed.

----------------------------------------------------------------

The following changes since commit a2b7ab45b8905b9c1813b0212e82a39d5c081c8a:

  Merge tag 'linux-watchdog-4.18-rc1' of git://www.linux-watchdog.org/linux-watchdog

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 958da6e3ff446fe558bdf0fd06fb2713539ebeef:

  Merge branch 'next/defconfig' into next/soc

----------------------------------------------------------------

Alexander Monakov (1):
      ARM: berlin: extend BG2CD Kconfig entry

Alexandre Torgue (1):
      ARM: multi_v7_defconfig: Add STM32F7 I2C & STM32 USBPHYC support

Anson Huang (1):
      ARM: imx_v6_v7_defconfig: Select CONFIG_GPIO_MAX732X by default

Antoine Tenart (1):
      arm64: defconfig: enable the Armada thermal driver

Arnd Bergmann (1):
      ARM: stm32: Don't select DMA unconditionally on STM32MP157C

Bai Ping (2):
      ARM: imx: select imx6sll pinctrl when imx6sll enabled
      ARM: imx_v6_v7_defconfig: enable imx6sll by default

Bartlomiej Zolnierkiewicz (1):
      ARM: exynos: no need to select ARCH_HAS_BANDGAP any longer

Bartosz Golaszewski (20):
      ARM: s3c24xx: mini2440: Use device properties for at24 eeprom
      ARM: imx: vpr200: drop at24_platform_data
      ARM: imx: pcm043: use device properties for at24 eeprom
      ARM: imx: pca100: use device properties for at24 eeprom
      ARM: imx: pcm037: use device properties for at24 eeprom
      ARM: davinci_all_defconfig: enable support for remoteproc drivers
      ARM: omap1: osk: use device properties for at24 eeprom
      mtd: rawnand: davinci: store the core chipselect number in platform data
      ARM: davinci: da830-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: da850-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm355-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm355-leopard: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm365-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm644x-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: mityomapl138: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm646x-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: neuros-osd2: specify the chipselect in davinci_nand_pdata
      mtd: rawnand: davinci: stop using pdev->id as chipselect
      ARM: davinci: aemif: stop using pdev->id as nand chipselect
      ARM: pxa: stargate2: use device properties for at24 eeprom

Biju Das (7):
      soc: renesas: Identify RZ/G1C
      soc: renesas: rcar-rst: Add support for RZ/G1C
      soc: renesas: rcar-sysc: Add r8a77470 support
      ARM: shmobile: r8a77470: basic SoC support
      ARM: debug-ll: Add support for r8a77470
      ARM: shmobile: defconfig: Enable r8a77470 SoC
      ARM: multi_v7_defconfig: Enable r8a77470 SoC

Bjorn Andersson (2):
      arm64: defconfig: Enable UFS on msm8996
      arm64: defconfig: Enable PCIe on msm8996 and db820c

Daniel Mack (1):
      ARM: pxa3xx: enable external wakeup pins

Dave Gerlach (1):
      ARM: OMAP2+: prm44xx: Introduce context save/restore for am43 PRCM IO

Dmitry Osipenko (1):
      ARM: tegra: Create platform device for tegra20-cpufreq driver

Dong Aisheng (1):
      MAINTAINERS: add NXP linux team maillist as i.MX reviewer

Doug Berger (4):
      ARM: Allow this header to be included by assembly files
      ARM: Allow this header to be included by assembly files
      ARM: add Broadcom Brahma-B53 main ID definition
      ARM: brcmstb: Add support for the V7 memory map

Enric Balletbo i Serra (3):
      arm64: defconfig: Enable typec-phy and extcon-usbc-cros-ec for rk3399
      arm64: defconfig: Enable Rockchip io-domain driver
      arm64: defconfig: Enable ChromeOS EC drivers for supported Chromebooks.

Ezequiel Garcia (4):
      arm64: defconfig: Enable HID over I2C drivers
      arm64: defconfig: Enable Atmel Maxtouch driver
      arm64: defconfig: Enable Marvell WiFi-Ex PCIe driver
      arm64: defconfig: Enable bluetooth USB support

Fabrizio Castro (1):
      ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN

Florian Fainelli (4):
      ARM: B15: Update to support Brahma-B53
      Merge tag 'bcm2835-defconfig-next-2018-04-30' into defconfig/next
      Merge tag 'bcm2835-defconfig-64-next-2018-04-30' into defconfig-arm64/next
      ARM: add Broadcom Brahma-B15 main ID definition

Geert Uytterhoeven (4):
      soc: renesas: r8a77995-sysc: Cleanups
      arm: shmobile: Change platform dependency to ARCH_RENESAS
      ARM: shmobile: defconfig: Disable CONFIG_FB_SH_MOBILE_MERAM
      ARM: multi_v7_defconfig: Disable CONFIG_FB_SH_MOBILE_MERAM

Gregory CLEMENT (1):
      arm64: defconfig: enable CONFIG_SPI_ARMADA_3700

Heiko Stuebner (1):
      arm64: defconfig: enable rockchip efuse

Janusz Krzysztofik (2):
      ARM: OMAP1: ams-delta: add GPIO lookup tables
      ASoC: ams_delta: use GPIO lookup table

Jisheng Zhang (2):
      arm: berlin: remove non-necessary flush_cache_all()
      ARM: berlin: switch to SPDX license identifier

John Garry (1):
      arm64: defconfig: Enable HISILICON_LPC

Keerthy (4):
      ARM: OMAP2+: clockdomain: Inroduce cpu_pm notifiers for context save/restore
      ARM: OMAP2+: powerdomain: Introduce cpu_pm notifiers for context save/restore
      ARM: OMAP2+: prm44xx: Inroduce cpu_pm notifiers for context save/restore
      OMAP: CLK: CLKSRC: Add suspend resume hooks

Krzysztof Kozlowski (1):
      ARM: exynos: Remove support for Exynos5440

Kuninori Morimoto (2):
      arm64: defconfig: makes SND_SIMPLE_CARD to module
      arm64: defconfig: Enable CONFIG_SND_AUDIO_GRAPH_CARD

Linus Walleij (2):
      ARM: ux500: Drop U8540/9540 support
      ARM: ux500: Cut down Kconfig options

Marek Szyprowski (2):
      ARM: exynos_defconfig: enable S6E63J0X03 panel driver
      ARM: multi_v7_config: enable S6E63J0X03 panel driver

Martin Blumenstingl (2):
      arm: multi_v7_defconfig: enable the Amlogic Meson I2C driver
      ARM: multi_v7_defconfig: enable the Meson PWM controller

Michel Pollet (2):
      ARM: shmobile: Add the RZ/N1 arch to the shmobile Kconfig
      arm: shmobile: Add the RZ/N1D (R9A06G032) to the shmobile Kconfig

Mylène Josserand (7):
      ARM: sunxi: smp: Move assembly code into a file
      ARM: smp: Add initialization of CNTVOFF
      ARM: sunxi: Add initialization of CNTVOFF
      ARM: shmobile: Convert file to use cntvoff
      ARM: sun9i: smp: Rename clusters's power-off
      ARM: sun9i: smp: Add is_a83t field
      ARM: sun8i: smp: Add support for A83T

Olof Johansson (29):
      Merge tag 'ux500-machine-arm-soc' of git://git.kernel.org/.../linusw/linux-stericsson into next/soc
      Merge tag 'omap-for-v4.18/ti-sysc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'arm-soc/for-4.18/defconfig' of https://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'arm-soc/for-4.18/defconfig-arm64' of https://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'arm-soc/for-4.18/soc' of https://github.com/Broadcom/stblinux into next/soc
      Merge tag 'samsung-defconfig-4.18' of https://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'samsung-soc-4.18' of https://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'v4.17-next-defconfig' of https://git.kernel.org/.../matthias.bgg/linux into next/defconfig
      Merge tag 'v4.18-rockchip-defconfig64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/defconfig
      Merge tag 'amlogic-defconfig' of https://git.kernel.org/.../khilman/linux-amlogic into next/defconfig
      Merge tag 'davinci-for-v4.18/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'davinci-for-v4.18/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v4.18' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'tegra-for-4.18-arm-soc' of git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'mvebu-arm64-4.18-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'imx-soc-4.18' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'imx-defconfig-4.18' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'sunxi-core-for-4.18' of https://git.kernel.org/.../sunxi/linux into next/soc
      Merge tag 'omap-for-v4.18/ti-sysc-fix-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.18/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'berlin-core-for-v4.18' of git://git.kernel.org/.../jszhang/linux-berlin into next/soc
      Merge tag 'omap-for-v4.18/soc-late-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'hisi-defconfig-for-4.18v3' of git://github.com/hisilicon/linux-hisi into next/defconfig
      Merge tag 'qcom-arm64-defconfig-for-4.18' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.18' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'renesas-soc-for-v4.18' of https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'imx-maintainers-4.18' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'pxa-for-4.18' of https://github.com/rjarzmik/linux into next/soc
      Merge branch 'next/defconfig' into next/soc

Pankaj Dubey (2):
      ARM: exynos: Remove static mapping of SCU SFR
      ARM: exynos: Remove unused soc_is_exynos{4,5}

Pierre-Yves MORDRET (1):
      ARM: stm32: Select DMA, DMAMUX and MDMA support on STM32MP157C

Russ Dill (2):
      ARM: OMAP2+: Add functions to save and restore clockdomain context en-masse.
      ARM: OMAP2+: Add functions to save and restore powerdomain context

Sean Wang (1):
      arm64: defconfig: Enable CONFIG_PINCTRL_MT7622 by default

Sekhar Nori (2):
      ARM: davinci: dm644x: remove unnecessary postcore_initcall()
      Merge branch 'v4.18/nand-cs-simplification' into v4.18/soc

Shawn Guo (1):
      arm64: defconfig: enable drivers for Poplar support

Simon Horman (2):
      arm64: defconfig: enable R8A77990 SoC
      ARM: multi_v7_defconfig: Enable RENESAS_WDT

Stefan Agner (3):
      ARM: imx_v6_v7_defconfig: add RN5T618 PMIC family support
      ARM: imx_v6_v7_defconfig: add mwifiex driver
      ARM: imx_v6_v7_defconfig: enable Vybrid OCOTP driver

Stefan Wahren (5):
      ARM: bcm2835_defconfig: Enable LAN78XX driver
      ARM: bcm2835_defconfig: Enable VCHIQ driver
      ARM: multi_v7_defconfig: Enable LAN and BT for RPi 3 B+
      arm64: defconfig: Enable LAN and BT support for RPi 3 B+
      arm64: defconfig: Increase CMA size for VC4

Takeshi Kihara (4):
      soc: renesas: identify R-Car E3
      soc: renesas: Add r8a77990 SYSC PM Domain Binding Definitions
      soc: renesas: rcar-rst: Add support for R-Car E3
      soc: renesas: rcar-sysc: Add support for R-Car E3 power areas

Tero Kristo (1):
      ARM: AM43XX: Add functions to save/restore am43xx control registers

Thomas Gleixner (1):
      ARM: s3c24xx: Fix invalid SPDX identifier

Tony Lindgren (19):
      ARM: OMAP2+: Drop unused pm-noop
      ARM: OMAP2+: Allow using ti-sysc for system timers
      ARM: OMAP2+: Use signed value for sysc register offsets
      ARM: OMAP2+: Only probe SDMA via ti-sysc if configured in dts
      ARM: OMAP2+: Initialize SoC PM later
      ARM: OMAP2+: Make display related init into device_initcall
      bus: ti-sysc: Handle simple-bus for nested children
      bus: ti-sysc: Make child clock alias handling more generic
      bus: ti-sysc: Add handling for clkctrl opt clocks
      bus: ti-sysc: Tag some modules resource providers for noirq suspend
      bus: ti-sysc: Improve suspend and resume handling
      bus: ti-sysc: Add initial support for external resets
      bus: ti-sysc: Detect omap4 type timers for quirk
      bus: ti-sysc: Detect UARTs for SYSC_QUIRK_LEGACY_IDLE quirk on omap4
      bus: ti-sysc: Tag sdio and wdt with legacy mode for suspend
      bus: ti-sysc: Show module information for suspend if DEBUG is enabled
      ARM: OMAP2+: Make sure LOGICRETSTATE bits are not cleared
      bus: ti-sysc: Fix optional clocks array access
      Merge branch 'omap-for-v4.18/soc-fixes' into omap-for-v4.18/soc

Trent Piepho (1):
      ARM: imx: Update spi_imx platform data to reflect current state

Wolfram Sang (1):
      ARM: samsung: simplify getting .drvdata

Yoshihiro Shimoda (1):
      soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B}


 .../devicetree/bindings/arm/shmobile.txt        |   2 +
 .../devicetree/bindings/bus/ti-sysc.txt         |   6 +-
 .../bindings/power/renesas,rcar-sysc.txt        |   2 +
 .../devicetree/bindings/reset/renesas,rst.txt   |   2 +
 MAINTAINERS                                     |   1 +
 arch/arm/Kconfig                                |   2 +-
 arch/arm/Kconfig.debug                          |  13 +-
 arch/arm/Makefile                               |   2 +-
 arch/arm/common/Makefile                        |   1 +
 arch/arm/common/secure_cntvoff.S                |  32 ++
 arch/arm/configs/bcm2835_defconfig              |   2 +
 arch/arm/configs/davinci_all_defconfig          |   4 +-
 arch/arm/configs/exynos_defconfig               |   1 +
 arch/arm/configs/imx_v6_v7_defconfig            |   9 +
 arch/arm/configs/multi_v7_defconfig             |  12 +-
 arch/arm/configs/shmobile_defconfig             |   3 +-
 arch/arm/include/asm/cputype.h                  |  14 +-
 arch/arm/include/asm/secure_cntvoff.h           |   8 +
 arch/arm/include/debug/brcmstb.S                |  21 +-
 arch/arm/mach-berlin/Kconfig                    |   6 +-
 arch/arm/mach-berlin/berlin.c                   |   5 +-
 arch/arm/mach-berlin/headsmp.S                  |   5 +-
 arch/arm/mach-berlin/platsmp.c                  |   6 +-
 arch/arm/mach-davinci/aemif.c                   |   8 +-
 arch/arm/mach-davinci/board-da830-evm.c         |   1 +
 arch/arm/mach-davinci/board-da850-evm.c         |   1 +
 arch/arm/mach-davinci/board-dm355-evm.c         |   1 +
 arch/arm/mach-davinci/board-dm355-leopard.c     |   1 +
 arch/arm/mach-davinci/board-dm365-evm.c         |   1 +
 arch/arm/mach-davinci/board-dm644x-evm.c        |   3 +
 arch/arm/mach-davinci/board-dm646x-evm.c        |   1 +
 arch/arm/mach-davinci/board-mityomapl138.c      |   1 +
 arch/arm/mach-davinci/board-neuros-osd2.c       |   3 +
 arch/arm/mach-davinci/board-sffsdr.c            |   2 +
 arch/arm/mach-davinci/davinci.h                 |   1 +
 arch/arm/mach-davinci/dm644x.c                  |  13 +-
 arch/arm/mach-exynos/Kconfig                    |  12 -
 arch/arm/mach-exynos/common.h                   |  17 +-
 arch/arm/mach-exynos/exynos.c                   |  37 +-
 arch/arm/mach-exynos/include/mach/map.h         |   2 -
 arch/arm/mach-exynos/platsmp.c                  |  27 +-
 arch/arm/mach-exynos/pm.c                       |   4 +-
 arch/arm/mach-exynos/suspend.c                  |   4 +-
 arch/arm/mach-imx/Kconfig                       |   1 +
 arch/arm/mach-imx/mach-mx31_3ds.c               |  18 +-
 arch/arm/mach-imx/mach-mx31lilly.c              |  12 +-
 arch/arm/mach-imx/mach-mx31lite.c               |  16 +-
 arch/arm/mach-imx/mach-mx31moboard.c            |  17 +-
 arch/arm/mach-imx/mach-pca100.c                 |  13 +-
 arch/arm/mach-imx/mach-pcm037.c                 |  13 +-
 arch/arm/mach-imx/mach-pcm037_eet.c             |   5 +-
 arch/arm/mach-imx/mach-pcm043.c                 |  13 +-
 arch/arm/mach-imx/mach-vpr200.c                 |   9 +-
 arch/arm/mach-omap1/board-ams-delta.c           | 107 ++++-
 arch/arm/mach-omap1/board-osk.c                 |  10 +-
 arch/arm/mach-omap2/Makefile                    |   1 -
 arch/arm/mach-omap2/board-generic.c             |   2 -
 arch/arm/mach-omap2/clockdomain.c               |  73 ++++
 arch/arm/mach-omap2/clockdomain.h               |   8 +
 arch/arm/mach-omap2/cm33xx.c                    |  53 +++
 arch/arm/mach-omap2/cminst44xx.c                |  43 ++
 arch/arm/mach-omap2/common.h                    |  18 +-
 arch/arm/mach-omap2/control.c                   | 112 ++++++
 arch/arm/mach-omap2/control.h                   |  61 +++
 arch/arm/mach-omap2/display.c                   |  10 +-
 arch/arm/mach-omap2/hsmmc.c                     |   1 -
 arch/arm/mach-omap2/i2c.c                       |   1 -
 arch/arm/mach-omap2/io.c                        |  70 +---
 arch/arm/mach-omap2/omap-pm-noop.c              | 176 ---------
 arch/arm/mach-omap2/omap-pm.h                   | 161 --------
 arch/arm/mach-omap2/omap_device.c               |  22 +-
 arch/arm/mach-omap2/omap_hwmod.c                |  21 +-
 arch/arm/mach-omap2/omap_hwmod.h                |   6 +-
 .../omap_hwmod_33xx_43xx_ipblock_data.c         |   1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |   4 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |   1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |   4 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c      |   3 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |   6 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      |   1 +
 arch/arm/mach-omap2/pdata-quirks.c              |  15 -
 arch/arm/mach-omap2/pm-debug.c                  |   5 -
 arch/arm/mach-omap2/pm.c                        |  21 +-
 arch/arm/mach-omap2/pm33xx-core.c               |   4 +-
 arch/arm/mach-omap2/pm44xx.c                    |  13 +
 arch/arm/mach-omap2/powerdomain.c               |  87 +++++
 arch/arm/mach-omap2/powerdomain.h               |   7 +
 arch/arm/mach-omap2/prm33xx.c                   |  31 ++
 arch/arm/mach-omap2/prm44xx.c                   | 104 +++++
 arch/arm/mach-omap2/timer.c                     | 100 ++++-
 arch/arm/mach-pxa/pxa3xx.c                      |   4 +
 arch/arm/mach-pxa/stargate2.c                   |  10 +-
 arch/arm/mach-s3c24xx/h1940-bluetooth.c         |   2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c           |  10 +-
 arch/arm/mach-shmobile/Kconfig                  |  13 +
 arch/arm/mach-shmobile/common.h                 |   1 -
 arch/arm/mach-shmobile/headsmp-apmu.S           |  22 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |   5 +-
 arch/arm/mach-sunxi/Kconfig                     |   2 +-
 arch/arm/mach-sunxi/Makefile                    |   2 +-
 arch/arm/mach-sunxi/headsmp.S                   |  81 ++++
 arch/arm/mach-sunxi/mc_smp.c                    | 239 +++++++-----
 arch/arm/mach-sunxi/sunxi.c                     |  20 +-
 arch/arm/mach-tegra/tegra.c                     |   4 +
 arch/arm/mach-ux500/Kconfig                     |  53 +--
 arch/arm/mach-ux500/cpu-db8500.c                |  16 +-
 arch/arm/mach-ux500/db8500-regs.h               |   4 -
 arch/arm/mm/cache-b15-rac.c                     |  30 +-
 arch/arm/plat-omap/Kconfig                      |  10 -
 arch/arm/plat-samsung/adc.c                     |   3 +-
 arch/arm/plat-samsung/include/plat/map-s5p.h    |   4 -
 arch/arm64/configs/defconfig                    |  43 +-
 drivers/bus/ti-sysc.c                           | 388 +++++++++++++++++--
 drivers/media/rc/ir-rx51.c                      |  17 +-
 drivers/mtd/nand/raw/davinci_nand.c             |   6 +-
 drivers/soc/renesas/Kconfig                     |  13 +-
 drivers/soc/renesas/Makefile                    |   2 +
 drivers/soc/renesas/r8a77470-sysc.c             |  29 ++
 drivers/soc/renesas/r8a77990-sysc.c             |  68 ++++
 drivers/soc/renesas/r8a77995-sysc.c             |   3 +-
 drivers/soc/renesas/rcar-rst.c                  |   2 +
 drivers/soc/renesas/rcar-sysc.c                 |   6 +
 drivers/soc/renesas/rcar-sysc.h                 |   2 +
 drivers/soc/renesas/renesas-soc.c               |  16 +
 include/dt-bindings/power/r8a77470-sysc.h       |  22 ++
 include/dt-bindings/power/r8a77990-sysc.h       |  26 ++
 include/linux/platform_data/media/ir-rx51.h     |   9 -
 include/linux/platform_data/mtd-davinci.h       |  10 +
 include/linux/platform_data/spi-imx.h           |  29 +-
 include/linux/platform_data/ti-sysc.h           |   1 +
 sound/soc/omap/ams-delta.c                      |  38 +-
 131 files changed, 2038 insertions(+), 1006 deletions(-)
 create mode 100644 arch/arm/common/secure_cntvoff.S
 create mode 100644 arch/arm/include/asm/secure_cntvoff.h
 delete mode 100644 arch/arm/mach-omap2/omap-pm-noop.c
 delete mode 100644 arch/arm/mach-omap2/omap-pm.h
 create mode 100644 arch/arm/mach-sunxi/headsmp.S
 create mode 100644 drivers/soc/renesas/r8a77470-sysc.c
 create mode 100644 drivers/soc/renesas/r8a77990-sysc.c
 create mode 100644 include/dt-bindings/power/r8a77470-sysc.h
 create mode 100644 include/dt-bindings/power/r8a77990-sysc.h
 delete mode 100644 include/linux/platform_data/media/ir-rx51.h
