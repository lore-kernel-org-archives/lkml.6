Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16271C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B82D208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iRTmf77f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B82D208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeHWIBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:01:10 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:45325 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeHWIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:01:10 -0400
Received: by mail-pf1-f174.google.com with SMTP id i26-v6so2026554pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 21:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIOmCri07eyUY3lXma9CJ/vwkSQrTf/skgZ6FWViwlA=;
        b=iRTmf77fXkKW82Q+pkhk4cdstJ5Wh6dLOCZi/f3Ta5Smn/fKRnz9mkqhPlK4reUjVD
         tAd8Q5RkpOEVP5hAqyiVgyiwNHtvA23Rocuxhpx4EogpnKS+49RY9u0m5cmxUZZsS+mJ
         WmhT1Q9dmLsb8rw8wJq49qsyG4SP3KeWQcFPHrPQsI1iRJcqy0zH2tNmVa2Brt50Fpze
         wNEX764dwqfHGpfZBvDVmGkABhz1ZQp4+CfTCemdGQwlKtpLFYoaXEdE3KC0ill1oKPm
         sACkL+1uph7qNPCaNeN1/x3G9K/GdgFf82cWCH8sgQfVo5emLf1otSPetVbm1kwQ1YyS
         lqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIOmCri07eyUY3lXma9CJ/vwkSQrTf/skgZ6FWViwlA=;
        b=nIJEf7AL8vTqWRB9iZBKCrQBB7Shzm3+uTDL0QX3t45FU2kp9AwW5C8g8itkF/4K7c
         /jtblF+OaZ8mXZfxZmGohCLStvyXvcu2J70K9c4E+uUYXmIisqZzPRwSxWyb5NCnHC5t
         87kIHR16L03RyXYrUy/5BgOAUgUMA0zRn2I2Pi1amZLsneyVrOsBH27BILvig73/+mrc
         a8nwMvrp9cSZNPZZdC/X3sjcN88TuUoNf4flom4q6SVMxp9HbpsuPwSlQ79UNWSOySWq
         xbgQIqvZliJVMV/fOCIQxa7quZoM+6Hu/Zm3Krq7hqGmOLOU7i+UuOSBv42taiEd0L2h
         MxjA==
X-Gm-Message-State: AOUpUlH+Zv74h9dHJrrIpTx9iz7PTtpHHqCc62zE1P9FgKBarmUHJZpi
        HgPPgh7sX/hW2umfhEwdkNqWOQ==
X-Google-Smtp-Source: AA+uWPyuoQVgxp9sJqkfXe4C0NWVGiziDA6L3aVlJEBhdu9u7CFlD2fu+2GdYb+e8+OtPNHInjoKxw==
X-Received: by 2002:a63:1c07:: with SMTP id c7-v6mr15668177pgc.109.1534998803404;
        Wed, 22 Aug 2018 21:33:23 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id 70-v6sm4859947pfz.27.2018.08.22.21.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 21:33:20 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/4] ARM: Device-tree updates
Date:   Wed, 22 Aug 2018 21:32:57 -0700
Message-Id: <20180823043257.18582-5-olof@lixom.net>
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

Business as usual -- the bulk of our changes are to devicetree files
with new hardware support, new SoCs and platforms, and new board types.

New SoCs/platforms:
- Raspberry Pi Compute Module (CM1) and IO board
- i.MX6SSL from NXP
- Renesas RZ/N1D SoC (R9A06G032), Dual Cortex-A7 with Ethernet, CAN and
PLC interfaces
- TI AM654 SoC, Quad Cortex-A53, safety subsystem with Cortex-R5
controllers, communication and PRU subsystem and lots of other
interfaces (PCIe, USB3, etc).

New boards and systems:
- Several Atmel at91-based boards from Laird
- Marvell Armada388-based Helios4 board from SolidRun
- Samsung Aires-based phones (s5pv210)
- Allwinner A64-based Pinebook laptop

In addition to the above, there's the usual amount of new devices
described on existing platforms, fixes and tweaks and new minor variants
of boards/platforms.

----------------------------------------------------------------

The following changes since commit a8bba4bb81f33b520f2e9bee78cf2e845e16c9c3:

  Merge tag 'armsoc-defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to afd3e3dad6761ddf08119afe121bfbe096c0844b:

  Merge tag 'qcom-arm64-for-4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux into next/dt

----------------------------------------------------------------

Adam Ford (6):
      ARM: dts: da850-evm: Enable SATA port
      ARM: dts: da850-evm: Enable LCD and backlight
      ARM: dts: am3517-evm: Remove unnessary PMIC parameters
      ARM: dts: am3517-som: Add WL127x Wifi
      ARM: dts: am3517-som:  Add builtin Bluetooth
      ARM: dts: am3517-evm: Enable USB1 Host

Alex Gonzalez (2):
      ARM: dts: imx6ul: Add DTS for ConnectCore 6UL System-On-Module (SOM)
      ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Express

Alexander Kurz (6):
      ARM: dts: imx6qdl-wandboard: remove regulators bus node
      ARM: dts: imx6dl-riotboard: remove regulators bus node
      ARM: dts: imx6qdl-wandboard: enable USB OTG
      ARM: dts: imx6dl-riotboard: fix OTG regulator polarity
      ARM: dts: imx50: fix KPP pin definition typos
      ARM: dts: imx50: remove non-existent USB instances

Alexandre Belloni (4):
      dt-bindings: arm: remove PMC bindings
      dt-bindings: clk: at91: Document all the PMC compatibles
      ARM: at91: fix USB clock detection handling
      ARM: dts: fix PMC compatible

Alexandre Torgue (2):
      ARM: dts: stm32: remove gpio aliases for stm32mp157c
      ARM: dts: stm32: Reorder nodes in stm32mp157c-ed1

Amelie Delaunay (9):
      ARM: dts: stm32: update rtc st,syscfg property on stm32f429
      ARM: dts: stm32: update rtc st,syscfg property on stm32f746
      ARM: dts: stm32: add RTC support to stm32mp157c
      ARM: dts: stm32: enable RTC on stm32mp157c-ed1
      ARM: dts: stm32: enable USB Host (USBH) EHCI controller on stm32mp157c-ev1
      ARM: dts: stm32: add USB OTG HS support for stm32mp157c SoC
      ARM: dts: stm32: enable USB OTG HS on stm32mp157c-ev1
      ARM: dts: stm32: add SPI support on stm32mp157c
      ARM: dts: stm32: add SPI1 support on stm32mp157c-ev1

Amit Kucheria (2):
      arm64: dts: msm8996: thermal: Initialise via DT and add second controller
      arm64: dts: sdm845: Add tsens nodes

Anand Moon (1):
      ARM: dts: exynos: Add missing interrupts for pwm node on Exynos5

Andre Przywara (1):
      arm64: dts: allwinner: a64: Add PWM controllers

Andrey Smirnov (13):
      ARM: dts: imx51-zii-rdu1: Make sure SD1_WP is low
      ARM: dts: imx51-zii-rdu1: Populate RAVE SP EEPROM nodes
      ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP EEPROM nodes
      ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP backlight node
      ARM: dts: imx6qdl-zii-rdu2: Populate RAVE SP power button node
      ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
      ARM: dts: imx: Add ZII SCU2 Mezz board
      ARM: dts: imx: Add ZII SCU3 ESB
      ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
      ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string
      ARM: dts: vf610: Add ZII SSMB SPU3 board
      ARM: dts: vf610: Add ZII CFU1 board
      ARM: dts: vf610-zii-ssmb-spu3: Fix W=1 level warnings

Andy Gross (2):
      Merge tag 'qcom-arm64-for-4.19' into arm64-for-4.19-2
      Merge tag 'qcom-drivers-for-4.19' into arm64-for-4.19-2

Anson Huang (14):
      ARM: dts: imx: add cooling-cells for cpufreq cooling device
      ARM: dts: imx6sll: declare src module to be compatible to imx51's src
      ARM: dts: imx6sll-evk: enable usdhc3 slot
      ARM: dts: imx6: correct anatop regulators range
      ARM: dts: imx6sx: add ocram_s support
      ARM: dts: imx6ul: add GPIO clocks
      ARM: dts: imx6sll-evk: enable PWM1 for backlight driver
      ARM: dts: imx6sll-evk: correct lcd regulator GPIO pin
      ARM: dts: imx6sll-evk: enable SEIKO 43WVF1G lcdif panel
      ARM: dts: imx6sl-evk: add missing GPIO iomux setting
      ARM: dts: imx6qdl-sabresd: make pfuze100 sw4 always on
      ARM: dts: imx6sx-sdb-reva: make pfuze100 sw4 always on
      ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
      ARM: dts: imx7d: remove "operating-points" property for cpu1

Antoine Tenart (2):
      arm64: dts: marvell: armada-cp110: update the crypto engine compatible
      arm64: dts: marvell: armada-37xx: update the crypto engine compatible

Anton Gerasimov (1):
      ARM: dts: zynq: Add support for Z-turn board

Bai Ping (2):
      ARM: dts: imx: Add basic dtsi file for imx6sll
      ARM: dts: imx: Add basic dts support for imx6sll EVK board

Baolin Wang (5):
      arm64: dts: sprd: Add SC27XX breathing light controller device
      arm64: dts: sprd: Add SC27XX vibrator device
      arm64: dts: sprd: Add SC27XX eFuse device
      arm64: dts: sprd: Add SC27XX ADC device
      arm64: dts: sprd: Add one suspend timer

Bartlomiej Zolnierkiewicz (2):
      ARM: dts: exynos: remove no longer needed samsung thermal properties
      arm64: dts: exynos: Remove no longer needed samsung thermal properties

Bartosz Golaszewski (2):
      ARM: davinci: dts: make psc0 a reset provider
      ARM: davinci: dts: add a reset control to the dsp node

Baruch Siach (3):
      arm64: dts: marvell: mcbin: fix eth3 connector name
      ARM: dts: armada388-clearfog: enable spi flash
      ARM: dts: armada388-clearfog: drop future changes disclaimer

Ben Whitten (6):
      dt-bindings: add laird and giantec vendor prefix
      ARM: dts: at91: add labels to soc dtsi for derivative boards
      ARM: dts: add support for Laird WB45N cpu module and DVK
      ARM: dts: add support for Laird WB50N cpu module and DVK
      ARM: dts: add support for Gatwick board based on WB50N
      ARM: dts: add support for Laird SOM60 module and DVK boards

Benjamin Herrenschmidt (7):
      ARM: dts: aspeed: Add G4 USB pinmux
      ARM: dts: aspeed: Add G5 USB host pinmux
      ARM: dts: aspeed: Add G4 USB Virtual Hub
      ARM: dts: aspeed: Add G5 USB Virtual Hub
      ARM: dts: aspeed: Enable vhub on port A of AST2500 EVB
      ARM: dts: aspeed: Fix Romulus VGA frame buffer
      ARM: dts: aspeed: Add coprocessor interrupt controller

Bhushan Shah (1):
      ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci

Boris Brezillon (1):
      ARM: dts: bcm283x: Add Transposer block

Chen-Yu Tsai (4):
      arm64: dts: allwinner: h6: Add LED device nodes for Pine H64
      ARM: dts: sun8i: a83t: Add CPU regulator supplies for A83T boards
      ARM: dts: sunxi: libretech-all-h3-cc: Enable eMMC module
      arm64: dts: allwinner: h6: Use macros for R_CCU clock and reset indices

Christophe Roullier (3):
      ARM: dts: stm32: Add syscfg on stm32mp1
      ARM: dts: stm32: Add ethernet dwmac on stm32mp1
      ARM: dts: stm32: add support of ethernet on stm32mp157c-ev1

Claudiu Beznea (1):
      ARM: dts: at91: fix typos for SSC TD functions

Clément Péron (1):
      ARM: dts: cygnus: add ethernet0 alias

Corentin Labbe (5):
      dt-bindings: net: dwmac-sun8i: Remove unused address-cells/size-cells
      ARM: dts: sun8i: a83t: Remove unused address-cells/size-cells of dwmac-sun8i
      ARM: dts: sun8i: r40: Remove unused address-cells/size-cells of dwmac-sun8i
      ARM: dts: sunxi-h3-h5: Remove unused address-cells/size-cells of dwmac-sun8i
      arm64: dts: allwinner: a64: Remove unused address-cells/size-cells of dwmac-sun8i

Daniel Mack (4):
      ARM: dts: imx6: make edt-ft5x06 a wakeup source for imx6 boards
      ARM: dts: pxa: add label to lcd controller node
      arm: dts: pxa3xx: provide correct clk-names property for nand controller node
      arm: dts: pxa3xx: Add ssp ports to pxa3xx device tree

David Lechner (4):
      dt-bindings: timer: new bindings for TI DaVinci timer
      ARM: dts: da850: Add clocks
      ARM: dts: da850: Add power-domains to PWM nodes
      ARM: dts: da850-lego-ev3: Add Bluetooth nodes

Dennis Gilmore (1):
      ARM: dts: armada388-helios4

Derald D. Woods (1):
      ARM: dts: am3517-evm: Add 'vdd_io_reg' regulator references

Dinh Nguyen (2):
      arm64: dts: stratix10: fill in clocks field for usb and watchdog
      arm64: dts: stratix10: add OCP reset property for ethernet

Dmitry Osipenko (2):
      ARM: dts: tegra20: Add Memory Client reset to VDE
      ARM: dts: tegra30: Add Memory Client reset to VDE

Douglas Anderson (5):
      arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes
      arm64: dts: qcom: sdm845: Enable debug UART and I2C10 on sdm845-mtp
      arm64: dts: sdm845: Add rpmh-rsc node
      arm64: dts: sdm845: Add rpmh-clk node
      arm64: dts: sdm845: Default qupv3_id_0 as "disabled" like _id_1

Emmanuel Vadot (4):
      arm64: dts: allwinner: sun50i: a64: Add spi flash node for sopine
      arm64: dts: allwinner: sun50i: h5: Add spi flash node for OrangePi PC2
      arm64: allwinner: a64-sopine: Add cd-gpios to mmc0 node
      ARM: dts: imx6: RIoTboard Add chosen stdout-path property

Enric Balletbo i Serra (11):
      ARM: dts: am335x-sl50: update backlight nodes
      ARM: dts: am335x-sl50: use phy-phandle declarations
      ARM: dts: am335x-sl50: add a node for the LCD controller
      ARM: dts: am335x-sl50: set dr_mode to otg
      ARM: dts: am335x-sl50: add support for DS1339 Real Time Clock
      ARM: dts: am335x-sl50: use audio-graph-card for sound
      ARM: dts: am335x-sl50: fix label names for all LEDs
      ARM: dts: am335x-sl50: enable tsadc on SL50 board
      arm64: dts: rockchip: add USB 2.0 and 3.0 support on Ficus board
      arm64: dts: rockchip: add voltage properties for vcc3v3_pcie on rk3399 ficus
      arm64: dts: rockchip: remove deprecated Type-C PHY properties on rk3399

Eric Anholt (1):
      ARM: dts: bcm283x: Add the PMU to the devicetree.

Erwan Le Ray (2):
      ARM: dts: stm32: m_can support to stm32mp157c
      ARM: dts: stm32: m_can activation on stm32mp157c-ev1

Ezequiel Garcia (2):
      dt-bindings: Add vendor prefix for Vamrs Ltd.
      arm64: dts: rockchip: add 96boards RK3399 Ficus board

Fabio Estevam (18):
      ARM: dts: imx51: Add aipstz nodes
      ARM: dts: imx51: Add sahara crypto support
      ARM: dts: imx6ull: Switch to SPDX identifier
      ARM: dts: imx53-qsb: Let the codec control MCLK pinctrl
      ARM: dts: imx6sll: Fix the SPDX notation for header file
      ARM: dts: imx51: Fix USB PHY duplicate unit-address
      ARM: dts: imx: Remove optional 'fsl,sec-era' property
      dt-bindings: freescale: Add bindings for the M4IF module
      ARM: dts: imx51: Add M4IF support
      dt-bindings: freescale: Add bindings for the tigerp module
      ARM: dts: imx51: Add PMU support
      ARM: dts: imx51: Add tigerp support
      ARM: dts: imx53: Add tigerp support
      ARM: dts: imx53: Add a label for the PMU node
      ARM: dts: imx51-zii-rdu1: Disable internal watchdog
      ARM: dts: imx51-babbage: Enable secure-reg-access
      ARM: dts: imx51-zii-rdu1: Enable secure-reg-access
      ARM: dts: imx6ul-pico-hobbit: Do not hardcode the memory size

Fabrice Gasnier (2):
      ARM: dts: stm32: Add ADC support to stm32mp157c
      ARM: dts: stm32: Add DFSDM support to stm32mp157c

Faiz Abbas (2):
      ARM: dts: Add generic interconnect target module node for MCAN
      ARM: dts: dra76x: Add MCAN node

Felix Brack (1):
      ARM: dts: am33xx: Fix syntax of alias names

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2018-07-03' into devicetree/next

Frank Wunderlich (1):
      arm: dts: mediatek: Fix pio-leds for Bananapi-R2

Gary Bisson (3):
      ARM: dts: imx: Switch Boundary Devices boards to SPDX identifier
      ARM: dts: imx7d-nitrogen7: use OF graph to describe the display
      ARM: dts: imx6sx-nitrogen6sx: remove obsolete display configuration

Geert Uytterhoeven (6):
      arm64: dts: renesas: r8a77965: Use r8a77965-cpg-mssr binding definitions
      arm64: dts: renesas: r8a77990: Add secondary CA53 CPU core
      arm64: dts: renesas: r8a77990: Remove non-existing STBE region
      arm64: dts: renesas: salvator-common: Fix adv7482 decimal unit addresses
      arm64: dts: renesas: salvator-common: Prefer HSCIF1 over SCIF1
      ARM: dts: r8a77470: Use r8a77470-cpg-mssr binding definitions

Gilad Ben-Yossef (1):
      arm64: dts: renesas: r8a7795: add ccree to device tree

Gregory CLEMENT (1):
      arm64: dts: marvell: armada-37xx: add the node allowing AVS support

Harunobu Kurokawa (1):
      arm64: dts: renesas: r8a7796: Add PCIe device nodes

Heiko Stuebner (8):
      ARM: dts: rockchip: fix graph node unit address error from dtc
      ARM: dts: rockchip: convert rk3288 to operating-points-v2
      arm64: dts: rockchip: generalize rk3399 #sound-dai-cells
      arm64: dts: rockchip: add phandles to some nodes on rk3399-gru
      arm64: dts: rockchip: move Chromebook-specific Gru-parts to a separate file
      arm64: dts: rockchip: move core edp from rk3399-kevin to shared chromebook
      arm64: dts: rockchip: add Google Bob
      arm64: dts: rockchip: drop out-of-tree properties from rk3399-ficus regulator

Hiromitsu Yamasaki (2):
      arm64: dts: renesas: salvator-common: Add HSCIF1 device support
      arm64: dts: renesas: r8a77995: Add MSIOF device nodes

Huibin Hong (1):
      arm64: dts: rockchip: corrected uart1 clock-names for rk3328

Icenowy Zheng (13):
      arm64: dts: allwinner: a64: add R_I2C controller
      arm64: dts: allwinner: add support for Pinebook
      arm64: dts: allwinner: a64: add SRAM controller device tree node
      arm64: allwinner: a64: change TERES-I DLDO3's name to start with "vdd"
      arm64: allwinner: a64: allow laptops to wake up from lid
      arm64: dts: allwinner: a64: add necessary device tree nodes for DE2 CCU
      arm64: dts: allwinner: a64: add device tree node for HDMI simplefb
      arm64: dts: allwinner: a64: add HDMI regulator to all DTs' simplefb_hdmi
      ARM: sun8i: h3: add SY8113B regulator on Banana Pi M2 Zero board
      arm64: dts: allwinner: h6: enable AXP805 PMIC on Pine H64
      dt-binding: mmc: sunxi: add H6 compatible (with A64 fallback)
      arm64: allwinner: h6: add device tree nodes for MMC controllers
      arm64: allwinner: h6: enable MMC0/2 on Pine H64

Jacopo Mondi (3):
      arm64: dts: renesas: draak: Describe CVBS input
      arm64: dts: renesas: draak: Describe HDMI input
      ARM: dts: gr-peach: Add GR-Peach audiocamerashield support

Jagan Teki (8):
      arm64: allwinner: a64: Add Amarula A64-Relic initial support
      arm64: allwinner: a64: Add RTC clock to phandle 32kHz external oscillator
      arm64: allwinner: a64-amarula-relic: Enable AP6330 WiFi support
      ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support
      ARM: dts: imx6q-icore-mipi: Add OV5640 Camera sensor
      ARM: dts: imx6qdl-icore: Fix wrong reg_2p5 regulator node name
      ARM: dts: imx6dl-mamoj: Add parallel display support
      ARM: dts: imx6dl-mamoj: Add Wifi support

Jernej Skrabec (7):
      ARM: dts: sun8i: r40: Add HDMI pipeline
      ARM: dts: sun8i: r40: Enable HDMI output on BananaPi M2 Ultra
      ARM: dts: sun8i: r40: Remove fallback display engine compatible
      ARM: dts: sun8i: r40: Add mixer ids to TCON TOP
      ARM: dts: sun8i: r40: Remove fallback compatible for TCON TV
      ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON connections
      ARM: dts: sun8i: r40: Disable TCONs by default.

Jerome Brunet (21):
      ARM64: dts: meson-axg: add s400 microphone card leds
      ARM64: dts: meson-axg: add s400 main 12v supply
      ARM64: dts: meson-axg: add s400 speaker amplifier
      ARM64: dts: meson-axg: add spdif output pins
      ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
      ARM64: dts: meson-axg: add adc buttons the S400
      ARM64: dts: meson-axg: remove spdif out from gpio a7
      ARM64: dts: meson-axg: add spdif input pins
      ARM64: dts: meson-axg: add pdm pins
      ARM64: dts: meson-axg: add the audio clock controller
      arm64: dts: meson-axg: improve power supplies description
      arm64: dts: meson-axg: add vcc 5v regulator on the s400
      arm64: dts: meson-axg: add usb power regulator
      arm64: dts: meson-axg: add audio arb reset controller
      arm64: dts: meson-axg: add spdifout
      arm64: dts: meson-axg: add tdmin formatters
      arm64: dts: meson-axg: add tdmout formatters
      arm64: dts: meson-axg: add tdm interfaces
      arm64: dts: meson-axg: add linein codec
      arm64: dts: meson-axg: add lineout codec
      arm64: dts: meson-axg: add spdif-dit codec

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Jonathan Bakker (2):
      ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
      dt-bindings: samsung: Document bindings for SGH-T959P board

Katsuhiro Suzuki (2):
      arm64: dts: uniphier: add headphone detect gpio for LD20 global board
      arm64: dts: uniphier: add headphone detect gpio for LD11 global board

Kevin Hilman (2):
      ARM: dts: dra7: fix DCAN node addresses
      Merge tag 'meson-clk-dt-for-v4.19' of https://github.com/BayLibre/clk-meson into v4.19/dt64-2

Kishon Vijay Abraham I (2):
      ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
      ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model

Klaus Goger (2):
      ARM: dts: rockchip: use SPDX-License-Identifier
      arm64: dts: rockchip: use SPDX-License-Identifier

Koen Kooi (2):
      dt-bindings: Add vendor prefix for Sancloud
      ARM: dts: am335x: add am335x-sancloud-bbe board support

Krzysztof Kozlowski (7):
      ARM: dts: exynos: Add missing CPU clocks to secondary CPUs on Exynos542x
      dt-bindings: arm: Remove obsolete insignal-boards.txt
      arm64: dts: exynos: Remove leading 0x from unit addresses in Exynos5433
      ARM: tegra: Remove usage of deprecated skeleton.dtsi
      ARM: tegra: Fix unit_address_vs_reg DTC warnings for /memory
      ARM: tegra: Fix unit_address_vs_reg and avoid_unnecessary_addr_size DTC warnings
      ARM: tegra: Work safely with 256 MB Colibri-T20 modules

Laurent Pinchart (1):
      arm64: dts: renesas: Fix VSPD registers range

Lei YU (1):
      ARM: dts: aspeed: Use 24MHz fixed clock for pwm

Leonard Crestez (6):
      ARM: dts: imx6qdl-sabreauto: Add sensors
      ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
      ARM: dts: imx7d-sdb: Restore pwm backlight support
      ARM: dts: imx: Add missing chosen/stdout-path
      ARM: dts: imx6sl: Convert gpc to new bindings
      ARM: dts: imx6sl: Add vivante gpu nodes

Li Yang (1):
      arm64: dts: freescale: Update to use SPDX identifiers

Linus Walleij (4):
      ARM: dts: nomadik: Cut FSMC timings
      ARM: dts: Add WAN ethernet port to the SQ201
      ARM: dts: Add Vitesse G5e switch to the Gemini SQ201
      ARM: dts: Add devicetree for Storlink/Storm SL93512R

Lionel Debieve (1):
      ARM: dts: stm32: Add HASH support on stm32mp157c

Loic Poulain (1):
      arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Lokesh Vutla (1):
      ARM: dts: dra762: Add MCAN clock support

Lucas Stach (2):
      ARM: dts: imx6: RDU2: correct touchscreen axis inversion
      ARM: dts: tegra: add Tegra20 NAND flash controller node

Ludovic Barre (3):
      ARM: dts: stm32: add iwdg2 support for stm32mp157c
      ARM: dts: stm32: add iwdg2 support for stm32mp157c-ed1
      ARM: dts: stm32: update iwdg with lsi clock name for stm32f429

Luis Araneda (9):
      ARM: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed boards
      ARM: dts: zynq: correct and improve the model property of dt files
      dt-bindings: xilinx: zynq: Improve boards description
      dt-bindings: xilinx: zynq: Sort entries alphabetically
      dt-bindings: xilinx: zynq: Move Paralella board to Xilinx
      dt-bindings: xilinx: zynq: Add missing boards
      ARM: dts: zynq: Fix memory size on the Zybo Z7 board
      ARM: dts: zynq: Use gpio constants for the Zybo Z7 board
      ARM: dts: zynq: Add LEDs to the Zybo Z7 board

Lukasz Majewski (1):
      ARM: dts: imx53: Add support for imx53 HSC/DDC boards from K+P

Magnus Damm (2):
      arm64: dts: renesas: r8a77995: Add IPMMU power domains
      arm64: dts: renesas: r8a779{65,80,90}: Add IPMMU devices nodes

Manivannan Sadhasivam (3):
      dt-bindings: arm: mediatek: Document Mediatek X20 Development Board
      arm64: dts: Add Mediatek X20 Development Board support
      arm64: dts: qcom: db820c: Add gpio-line-names property

Marcel Ziswiler (1):
      ARM: tegra: Fix can2 on Tegra30 Apalis

Marcus Cooper (1):
      ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2

Marek Vasut (1):
      ARM: dts: porter: Add missing PMIC nodes

Martin Blumenstingl (7):
      ARM64: dts: meson: enable the saradc node in meson-gx-p23x-q20x.dtsi
      ARM64: dts: meson-gx-p23x-q20x: move the wifi node to each board's .dts
      dt-bindings: add vendor prefix for Shenzhen Oranth Technology Co., Ltd.
      dt-bindings: arm: amlogic: Add support for GXL S905W and the P281 board
      dt-bindings: arm: amlogic: Add support for the Oranth Tanix TX3 Mini
      ARM64: dts: meson-gxl: add support for the S905W SoC and the P281 board
      ARM64: dts: meson-gxl: add support for the Oranth Tanix TX3 Mini

Masaharu Hayakawa (1):
      arm64: dts: renesas: Add sdhi2_ds pin group to SDHI2 pinctrl groups

Maxime Ripard (4):
      ARM: dts: sun5i: Add support for the C1 SRAM region with the SRAM controller
      ARM: dts: sun7i: Add support for the C1 SRAM region with the SRAM controller
      ARM: dts: sun8i: a23-a33: Add SRAM controller node and C1 SRAM region
      ARM: dts: sun5i: Fix the SRAM A3-A4 declaration

Michael Trimarchi (1):
      ARM: dts: imx6dl-mamoj: Add usb host and device support

Michal Simek (6):
      arm64: dts: zynqmp: Use serdev for zcu100 BT
      arm64: dts: zynqmp: Remove ep108 board
      arm64: dts: zynqmp: Remove #address/#size-cells from gpio-keys
      arm64: dts: zynqmp: Add support for Avnet Ultra96 rev1 board
      ARM: dts: zynq: Add mmc alias for zc702/zc706/zed/zybo
      ARM: dts: zynq: Remove #address/#size-cells from gpio-keys

Michel Pollet (5):
      dt-bindings: arm: Document the RZN1D-DB board
      dt-bindings: cpu: Add Renesas R9A06G032 SMP enable method.
      ARM: dts: Renesas R9A06G032 base device tree file
      ARM: dts: Renesas RZN1D-DB Board base file
      ARM: dts: Renesas R9A06G032 SMP enable method

Mikko Perttunen (5):
      arm64: tegra: Add GPIO controller on Tegra194
      arm64: tegra: Enable card detect for SD card on P2888
      arm64: tegra: Add ethernet controller on Tegra194
      arm64: tegra: Add CPU nodes to Tegra194 device tree
      dt-bindings: arm: Add compatible string for NVIDIA Carmel

Mohamed Ismail Abdul Packir Mohamed (1):
      ARM: dts: cygnus: enable iproc-hwrng

Murali Karicheri (3):
      ARM: dts: k2g: add dt bindings to support network driver
      ARM: dts: keystone-k2g-evm: Enable netcp network driver
      ARM: dts: keystone-k2g-ice: Enable netcp network driver

Neeraj Dantu (1):
      ARM: dts: Add DT support for Octavo Systems OSD3358-SM-RED based on TI AM335x

Neil Armstrong (3):
      ARM64: dts: meson-gxbb-nanopi-k2: Add HDMI, CEC and CVBS nodes
      dt-bindings: amlogic: Add support for GXL S805X and the P241 board
      ARM64: dts: add S805X based P241 board

Nick Dyer (1):
      ARM: dts: imx51-zii-rdu1: correct touchscreen axis inversion

Nikita Yushchenko (1):
      ARM: dts: imx51-zii-rdu1: add rave-sp subdevices

Niklas Cassel (1):
      arm64: dts: msm8916: drop legacy suffix for clocks used by MSM DRM driver

Nishanth Menon (5):
      dt-bindings: arm: ti: Add bindings for AM654 SoC
      arm64: Add support for TI's K3 Multicore SoC architecture
      arm64: dts: ti: Add Support for AM654 SoC
      soc: ti: Add Support for AM654 SoC config option
      arm64: dts: ti: Add support for AM654 EVM base board

Olof Johansson (52):
      Merge tag 'renesas-arm64-dt-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'socfpga_updates_for_v4.19_part1' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'keystone_dts_for_4.19' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'v4.19-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.19-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'arm-soc/for-4.19/devicetree' of https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'arm-soc/for-4.19/devicetree-arm64' of https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'davinci-for-v4.19/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'omap-for-v4.19/dt-signed-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'omap-for-v4.19/dt-mcan-v2-signed-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'tegra-for-4.19-dt-bindings' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.19-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.19-arm64-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'samsung-dt-4.19' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.19' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'pxa-dt-4.19' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'mvebu-dt-4.19-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt64-4.19-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'stm32-dt-for-v4.19-1' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'v4.18-rockchip-dts32fixes-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'gemini-dts-v4.19' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'omap-for-v4.19/dt-pt2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'uniphier-dt-v4.19' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'uniphier-dt64-v4.19' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'zynqmp-dt-for-v4.19-v2' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'zynq-dt-for-v4.19-v2' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'hisi-arm64-dt-for-4.19v2' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'at91-ab-4.19-dt' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'renesas-arm64-dt2-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-bindings-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'amlogic-dt64-1' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'imx-dt-clkdep-4.19' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt-4.19' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt64-4.19' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'am654-for-v4.19-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'qcom-arm64-for-4.19' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'qcom-dts-for-4.19' of git://git.kernel.org/.../agross/linux into next/dt
      Merge branch 'sprd/dt' into next/dt
      Merge tag 'renesas-arm-dt-for-v4.19' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'amlogic-dt64-2-1' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'omap-for-v4.19/dt-pt3-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'sunxi-dt-for-4.19' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.19' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'samsung-dt-4.19-2' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'sunxi-h3-h5-for-4.19' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'v4.18-next-dts32' of https://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'v4.18-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'aspeed-4.19-devicetree-no-fsi' of git://git.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'mvebu-dt64-4.19-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'amlogic-dt64-3' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'v4.19-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'qcom-arm64-for-4.19-2' of git://git.kernel.org/.../agross/linux into next/dt

Paul Kocialkowski (4):
      ARM: dts: sun4i: Switch to new system control compatible string
      ARM: dts: sun5i: Use most-qualified system control compatibles
      ARM: dts: sun7i: Use most-qualified system control compatibles
      ARM: dts: sun8i: h3: Add SRAM controller node and C1 SRAM region

Paweł Chmiel (4):
      ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
      ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
      ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
      dt-bindings: samsung: Document bindings for Samsung aries boards

Peter Robinson (1):
      ARM: dts: pandaboard: add gpio user button

Philipp Zabel (1):
      ARM: dts: imx51: add CodaHx4 VPU

Pramod Kumar (1):
      arm64: dts: Update Stingray clock DT nodes

Rafał Miłecki (1):
      ARM: dts: BCM53573: Add architected timer

Randy Li (1):
      arm64: dts: rockchip: add some common pin-settings to rk3399

Ray Jui (2):
      arm64: dts: set initial SR watchdog timeout to 60 seconds
      arm64: dts: stingray: add PAXC support

Robin Gong (1):
      ARM: dts: imx6sl-evk: make pfuze100 sw4 always on

Roger Quadros (4):
      ARM: dts: am57xx-idk: Enable dual role for USB2 port
      ARM: dts: dra7-evm: Add extcon to USB2 port
      ARM: dts: dra71-evm: Add VBUS GPIO to USB1/USB2 extcon
      ARM: dts: dra76-evm: Add VBUS GPIO to USB1/USB2 extcon

Ryder Lee (3):
      arm: dts: mt7623: cleanup MT7623N NAND dts file
      dt-bindings: arm: mediatek: cleanup MT7623N reference boards
      arm64: dts: mt7622: update a clock property for UART0

Scott Branden (2):
      arm64: dts: stingray: move common board components to stingray-board-base
      arm64: dts: stingray: Add OTP device node

Sean Wang (3):
      arm64: dts: mt7622: add EINT support to pinctrl
      arm64: dts: mt7622: use gpio-ranges to pinctrl device
      arm64: dts: mt7622: add earlycon to mt7622-rfb1 board

Sebastian Reichel (3):
      ARM: dts: imx53-ppd: Add fixed-regulator information
      ARM: dts: imx53-ppd: Rename usbphy nodes
      ARM: dts: imx53-ppd: Enable secure-reg-access

Sekhar Nori (1):
      ARM: dts: da850: Add power-domains to CPPI 4.1 node

Sergei Shtylyov (9):
      arm64: dts: renesas: r8a77980: add SMP support
      arm64: dts: renesas: r8a77980: add GEther support
      arm64: dts: renesas: v3hsk: add GEther support
      arm64: dts: renesas: r8a77980: add I2C support
      arm64: dts: renesas: condor: add I2C0 support
      arm64: dts: renesas: r8a77980: add GPIO support
      arm64: dts: renesas: condor/v3hsk: specify Ethernet PHY IRQs
      arm64: dts: renesas: r8a77980: add FCPVD/VSPD/DU/LVDS support
      arm64: dts: renesas: r8a77980: add INTC-EX support

Shohei Maruyama (2):
      arm64: dts: rockchip: add power button support for Firefly-RK3399
      arm64: dts: rockchip: add led support for Firefly-RK3399

Simon Horman (2):
      arm64: dts: renesas: r8a77995: don't use deprecated renesas,gpio-rcar compat string
      arm64: dts: renesas: r8a77965: Add second port to rcar_sound placeholder

Simon Shields (5):
      ARM: dts: exynos: Add max77693 pinctrl config for Midas
      ARM: dts: exynos: Add pinctrl config for Midas keys
      ARM: dts: exynos: Add pinctrl for Midas fuelgauge IRQ pin
      ARM: dts: exynos: Configure max77686 IRQ pin on Midas
      ARM: dts: exynos: Configure Midas SD card CD pin

Sricharan R (1):
      ARM: dts: qcom: Fix 'interrupts = <>' property to use proper macros

Stefan Agner (12):
      ARM: dts: imx6qdl-colibri: mux SD/MMC card detect explicitly
      ARM: dts: imx6qdl-colibri: move card detect to module device tree
      ARM: dts: imx6qdl-colibri: use pull-down on wake-up pin
      ARM: dts: tegra: enable NAND flash on Colibri T20
      ARM: dts: imx6q-apalis: add chosen node
      ARM: dts: imx6q-apalis-eval: add carrier board 3.3V supply
      ARM: dts: imx6qdl-apalis/-colibri: prevent 1.8V modes
      ARM: dts: imx6qdl-apalis/-colibri: disable read-only switch
      ARM: dts: imx6qdl-apalis/-colibri: remove 1.8V regulator
      ARM: dts: imx6qdl-apalis/-colibri: fix on-module regulators
      ARM: dts: imx6qdl-apalis/-colibri: assign VDDD to SGTL5000
      ARM: dts: imx6qdl-apalis/-colibri: remove unused pinctrl groups

Stefan Wahren (1):
      ARM: dts: add Raspberry Pi Compute Module and IO board

Stephen Boyd (2):
      arm64: dts: qcom: Add pmu node to sdm845
      arm64: dts: qcom: Add pm8005 and pm8998 support

Steven Vanden Branden (1):
      ARM: dts: sun4i: Add GPU node

Sébastien Szymanski (1):
      ARM: dts: imx6ull: add operating points

Takeshi Kihara (6):
      arm64: dts: renesas: r8a77965: Add Watchdog Timer controller node using RCLK Watchdog Timer
      arm64: dts: renesas: r8a77965: Add all HSCIF nodes
      arm64: dts: renesas: salvator-x(s): Update I2C ch4 clock to 400kHz
      arm64: dts: renesas: r8a77990: ebisu: Enable watchdog timer
      arm64: dts: renesas: r8a77965: Add PCIe device nodes
      arm64: dts: renesas: r8a77995: Add SCIF {0,1,3,4,5} and all HSCIF device nodes

Thor Thayer (3):
      arm64: dts: stratix10: Add QSPI support for Stratix10
      ARM: dts: Add SPI0 node for Arria10
      arm64: dts: stratix10: Add SPI node clocks for Stratix10

Tony Lindgren (10):
      ARM: dts: Improve omap l4per idling with wlcore edge sensitive interrupt
      ARM: dts: Configure duovero for to allow core retention during idle
      ARM: dts: omap4-droid4: Use software debounce for gpio-keys
      dt-bindings: Update omap l4 binding for optional registers
      Merge commit '949bdcc8a97c' into omap-for-v4.19/dt
      ARM: dts: omap4: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: omap4: Probe watchdog 3 with ti-sysc
      ARM: dts: omap4: Move l4 child devices to probe them with ti-sysc
      ARM: dts: omap4: Add l4 ranges for 4460
      Merge branch 'omap-for-v4.19/dt-sysc-v2' into omap-for-v4.19/dt

Ulrich Hecht (1):
      arm64: dts: renesas: draak: add X12 input dot clock

Vicente Bergas (2):
      arm64: dts: rockchip: connect hdmi sound in rk3399
      arm64: dts: rockchip: enable hdmi sound on rk3399-sapphire

Victor Gu (1):
      arm64: dts: marvell: armada-37xx: reserve memory for ATF

Vincent Guittot (1):
      arm64: hikey960: update idle-states

Viresh Kumar (21):
      ARM: dts: rockchip: Add missing cooling device properties for CPUs on rk322x
      ARM: dts: sunxi: Add missing cooling device properties for CPUs
      ARM: dts: sun8i-h3: Add missing cooling device properties for CPUs
      ARM: dts: rockchip: Add missing cooling device properties for CPUs on rk3288
      arm64: dts: rockchip: Add missing cooling device properties for CPUs
      arm: dts: mediatek: Add missing cooling device properties for CPUs
      arm: dts: exynos: Add missing cooling device properties for CPUs
      arm64: dts: mediatek: Add missing cooling device properties for CPUs
      arm: dts: highbank: Add missing OPP properties for CPUs
      ARM: dts: ls1021a: Add missing cooling device properties for CPUs
      ARM: dts: dra74x: Add missing cooling device properties for CPUs
      ARM: dts: omap5: Add missing cooling device properties for CPUs
      arm64: dts: freescale: Add missing cooling device properties for CPUs
      ARM: dts: imx: Add missing OPP properties for CPUs
      arm64: dts: hisilicon: Add missing cooling device properties for CPUs
      ARM: dts: uniphier: Add missing cooling device properties for CPUs
      arm64: dts: uniphier: Add missing cooling device properties for CPUs
      ARM64: dts: amlogic: Add missing cooling device properties for CPUs
      ARM: dts: qcom: Add missing OPP properties for CPUs
      ARM: dts: berlin: Add missing OPP properties for CPUs
      ARM: dts: r8a77(43|9[013]): Add missing OPP properties for CPUs

Vitaly Andrianov (3):
      ARM: dts: k2hk: add dts node for k2hk hw_rng driver
      ARM: dts: k2l: add dts node for k2l hw_rng driver
      ARM: dts: k2e: add dts node for k2e hw_rng driver

Vivek Unune (2):
      ARM: dts: BCM5301X: Make USB 3.0 PHY use MDIO PHY driver
      ARM: dts: BCM5301X: Add support for Linksys EA9500

Vladimir Olovyannikov (1):
      arm64: dts: stingray: add bcm958802a802x dts

Vladimir Zapolskiy (2):
      ARM: dts: imx31: add device tree description of basic controllers
      ARM: dts: imx31: add LogicPD MX31Lite board description

Wolfram Sang (2):
      arm64: dts: renesas: convert to SPDX identifiers
      ARM: dts: convert to SPDX identifier for Renesas boards

Xingyu Chen (1):
      ARM64: dts: meson-axg: add saradc support

Yong Wu (1):
      dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI

Yoshihiro Kaneko (1):
      arm64: dts: renesas: r8a77995: add thermal device support

Yoshihiro Shimoda (3):
      arm64: dts: renesas: r8a77990: Enable USB2.0 Host for Ebisu board
      arm64: dts: renesas: Unify the labels for RWDT
      arm64: dts: renesas: r8a77990: Enable USB3.0 host for Ebisu board

oscardagrach (4):
      arm64: dts: hikey960: Remove deprecated MMC properties
      arm64: dts: hikey960: Clean up MMC properties and move to proper file
      arm64: dts: hikey960: Remove keep-power-in-suspend property
      arm64: dts: hikey: Remove keep-power-in-suspend property


 .../devicetree/bindings/arm/adapteva.txt        |    7 -
 .../devicetree/bindings/arm/amlogic.txt         |   13 +
 .../devicetree/bindings/arm/atmel-pmc.txt       |   14 -
 Documentation/devicetree/bindings/arm/cpus.txt  |    2 +
 .../devicetree/bindings/arm/freescale/m4if.txt  |   12 +
 .../bindings/arm/freescale/tigerp.txt           |   12 +
 Documentation/devicetree/bindings/arm/fsl.txt   |    4 +
 .../devicetree/bindings/arm/insignal-boards.txt |    8 -
 .../devicetree/bindings/arm/mediatek.txt        |    6 +-
 .../devicetree/bindings/arm/omap/l4.txt         |   15 +-
 .../devicetree/bindings/arm/rockchip.txt        |   14 +
 .../bindings/arm/samsung/samsung-boards.txt     |    5 +-
 .../devicetree/bindings/arm/shmobile.txt        |    5 +-
 Documentation/devicetree/bindings/arm/ti/k3.txt |   23 +
 .../devicetree/bindings/arm/xilinx.txt          |   30 +-
 .../devicetree/bindings/clock/at91-clock.txt    |    9 +-
 .../bindings/iommu/mediatek,iommu.txt           |    6 +-
 .../memory-controllers/mediatek,smi-common.txt  |    6 +-
 .../memory-controllers/mediatek,smi-larb.txt    |    5 +-
 .../devicetree/bindings/mmc/sunxi-mmc.txt       |    2 +
 .../devicetree/bindings/net/dwmac-sun8i.txt     |    8 -
 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt  |    8 +-
 .../bindings/timer/ti,davinci-timer.txt         |   37 +
 .../devicetree/bindings/vendor-prefixes.txt     |    5 +
 MAINTAINERS                                     |   10 +
 arch/arm/boot/dts/Makefile                      |   35 +-
 arch/arm/boot/dts/am335x-baltos.dtsi            |    2 +-
 arch/arm/boot/dts/am335x-evm.dts                |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |    2 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts     |  457 ++++
 arch/arm/boot/dts/am335x-sancloud-bbe.dts       |  136 +
 arch/arm/boot/dts/am335x-sl50.dts               |  297 ++-
 arch/arm/boot/dts/am33xx.dtsi                   |    4 +-
 arch/arm/boot/dts/am3517-evm.dts                |   50 +-
 arch/arm/boot/dts/am3517-som.dtsi               |  105 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |    2 +-
 arch/arm/boot/dts/am571x-idk.dts                |    4 -
 arch/arm/boot/dts/am572x-idk-common.dtsi        |    4 -
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |    7 +-
 arch/arm/boot/dts/armada-388-clearfog-base.dts  |    5 -
 arch/arm/boot/dts/armada-388-clearfog-pro.dts   |    5 -
 arch/arm/boot/dts/armada-388-clearfog.dts       |    7 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi      |    7 +-
 arch/arm/boot/dts/armada-388-helios4.dts        |  313 +++
 .../boot/dts/armada-38x-solidrun-microsom.dtsi  |    6 -
 arch/arm/boot/dts/aspeed-ast2500-evb.dts        |   14 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |    4 +-
 arch/arm/boot/dts/aspeed-g4.dtsi                |   26 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                |   34 +-
 arch/arm/boot/dts/at91-dvk_som60.dts            |   95 +
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi       |  159 ++
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi   |   90 +
 arch/arm/boot/dts/at91-gatwick.dts              |  121 +
 arch/arm/boot/dts/at91-som60.dtsi               |  230 ++
 arch/arm/boot/dts/at91-wb45n.dts                |   64 +
 arch/arm/boot/dts/at91-wb45n.dtsi               |  165 ++
 arch/arm/boot/dts/at91-wb50n.dts                |  112 +
 arch/arm/boot/dts/at91-wb50n.dtsi               |  198 ++
 arch/arm/boot/dts/at91sam9261.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |    2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |    2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi               |    8 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi               |    9 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts       |   88 +
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi          |   34 +
 arch/arm/boot/dts/bcm2837.dtsi                  |    6 +
 arch/arm/boot/dts/bcm283x.dtsi                  |    6 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts     |    4 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts     |    4 +
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |    4 +
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts |    4 +
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts    |    4 +
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts    |    4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |    4 +
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts  |    4 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |    4 +
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts     |    4 +
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |    4 +
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts    |    4 +
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts   |    4 +
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts   |    4 +
 .../boot/dts/bcm47081-tplink-archer-c5-v2.dts   |    4 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts     |    4 +
 .../boot/dts/bcm4709-buffalo-wxr-1900dhp.dts    |    4 +
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts    |    4 +
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts     |    4 +
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts     |    4 +
 .../boot/dts/bcm4709-tplink-archer-c9-v1.dts    |    4 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts   |    4 +
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts |  233 ++
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts   |    4 +
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts   |    4 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts   |    4 +
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts    |    4 +
 arch/arm/boot/dts/bcm47094.dtsi                 |    7 +-
 arch/arm/boot/dts/bcm5301x.dtsi                 |   35 +-
 arch/arm/boot/dts/bcm53573.dtsi                 |    8 +
 arch/arm/boot/dts/bcm94708.dts                  |    4 +
 arch/arm/boot/dts/bcm94709.dts                  |    4 +
 arch/arm/boot/dts/bcm953012er.dts               |    4 +
 arch/arm/boot/dts/bcm953012hr.dts               |    4 +
 arch/arm/boot/dts/bcm953012k.dts                |    4 +
 arch/arm/boot/dts/berlin2.dtsi                  |   10 +
 arch/arm/boot/dts/berlin2q.dtsi                 |   33 +
 arch/arm/boot/dts/da850-enbw-cmc.dts            |    4 +
 arch/arm/boot/dts/da850-evm.dts                 |   91 +-
 arch/arm/boot/dts/da850-lcdk.dts                |    9 +
 arch/arm/boot/dts/da850-lego-ev3.dts            |   86 +
 arch/arm/boot/dts/da850.dtsi                    |  176 ++
 arch/arm/boot/dts/dra7-evm-common.dtsi          |   10 +
 arch/arm/boot/dts/dra7-evm.dts                  |    9 -
 arch/arm/boot/dts/dra7.dtsi                     |    4 +-
 arch/arm/boot/dts/dra71-evm.dts                 |    8 +
 arch/arm/boot/dts/dra72-evm-common.dtsi         |    1 +
 arch/arm/boot/dts/dra74x.dtsi                   |   10 +
 arch/arm/boot/dts/dra76-evm.dts                 |   14 +
 arch/arm/boot/dts/dra76x.dtsi                   |   64 +
 arch/arm/boot/dts/emev2-kzm9d.dts               |    5 +-
 arch/arm/boot/dts/emev2.dtsi                    |    5 +-
 arch/arm/boot/dts/exynos3250.dtsi               |   18 +-
 arch/arm/boot/dts/exynos4.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos4210.dtsi               |   13 +
 arch/arm/boot/dts/exynos4412-midas.dtsi         |   35 +-
 .../boot/dts/exynos4412-tmu-sensor-conf.dtsi    |   20 -
 arch/arm/boot/dts/exynos4412.dtsi               |    9 +
 arch/arm/boot/dts/exynos5.dtsi                  |    5 +
 arch/arm/boot/dts/exynos5250.dtsi               |   25 +-
 arch/arm/boot/dts/exynos5410.dtsi               |    8 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi          |    6 +
 .../boot/dts/exynos5420-tmu-sensor-conf.dtsi    |   21 -
 arch/arm/boot/dts/exynos5420.dtsi               |   10 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi          |    8 +-
 arch/arm/boot/dts/gemini-sl93512r.dts           |  328 +++
 arch/arm/boot/dts/gemini-sq201.dts              |  159 ++
 .../boot/dts/gr-peach-audiocamerashield.dtsi    |   79 +
 arch/arm/boot/dts/highbank.dts                  |   30 +
 arch/arm/boot/dts/imx31-lite.dts                |  177 ++
 arch/arm/boot/dts/imx31.dtsi                    |  223 ++
 arch/arm/boot/dts/imx50-evk.dts                 |    8 -
 arch/arm/boot/dts/imx50-pinfunc.h               |    4 +-
 arch/arm/boot/dts/imx50.dtsi                    |   18 -
 arch/arm/boot/dts/imx51-babbage.dts             |   29 +-
 .../dts/imx51-eukrea-mbimxsd51-baseboard.dts    |   21 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts            |   75 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts       |  448 ++++
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts        |  467 ++++
 arch/arm/boot/dts/imx51.dtsi                    |   61 +-
 arch/arm/boot/dts/imx53-kp-ddc.dts              |  146 ++
 arch/arm/boot/dts/imx53-kp-hsc.dts              |   52 +
 arch/arm/boot/dts/imx53-kp.dtsi                 |  189 ++
 arch/arm/boot/dts/imx53-ppd.dts                 |   40 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi         |    9 +-
 arch/arm/boot/dts/imx53.dtsi                    |    7 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts    |    3 -
 arch/arm/boot/dts/imx6dl-icore-mipi.dts         |   25 +
 arch/arm/boot/dts/imx6dl-mamoj.dts              |  265 ++
 arch/arm/boot/dts/imx6dl-nit6xlite.dts          |   38 +-
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts         |   38 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts          |   54 +-
 arch/arm/boot/dts/imx6dl.dtsi                   |   24 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts         |   16 +
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts   |    4 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts        |    4 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts              |   66 +
 arch/arm/boot/dts/imx6q-icore-mipi.dts          |    8 +
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts       |   38 +-
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts      |   38 +-
 arch/arm/boot/dts/imx6q-nitrogen6x.dts          |   38 +-
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts  |    1 +
 arch/arm/boot/dts/imx6q.dtsi                    |   88 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |   75 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi          |   78 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi            |   49 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi        |   39 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi    |   39 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi   |   39 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       |   39 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |   25 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |    1 +
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |   59 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         |   30 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |    1 -
 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts      |   39 +-
 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts     |   39 +-
 arch/arm/boot/dts/imx6sl-evk.dts                |   13 +
 arch/arm/boot/dts/imx6sl.dtsi                   |   64 +-
 arch/arm/boot/dts/imx6sll-evk.dts               |  463 ++++
 arch/arm/boot/dts/imx6sll-pinfunc.h             |  880 +++++++
 arch/arm/boot/dts/imx6sll.dtsi                  |  780 ++++++
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts        |  109 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           |    1 +
 arch/arm/boot/dts/imx6sx.dtsi                   |   16 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts |  200 ++
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi       |  201 ++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts        |    3 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |    6 +
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi     |   14 -
 arch/arm/boot/dts/imx6ull.dtsi                  |   62 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts           |   87 +-
 arch/arm/boot/dts/imx7d-sdb.dts                 |   33 +-
 arch/arm/boot/dts/imx7d.dtsi                    |    1 +
 arch/arm/boot/dts/imx7s.dtsi                    |    1 -
 arch/arm/boot/dts/iwg20d-q7-common.dtsi         |    5 +-
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi        |    5 +-
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi       |   20 +
 arch/arm/boot/dts/keystone-k2g-evm.dts          |   63 +
 arch/arm/boot/dts/keystone-k2g-ice.dts          |   59 +
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi       |  147 ++
 arch/arm/boot/dts/keystone-k2g.dtsi             |   25 +-
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi      |   20 +
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi       |   20 +
 arch/arm/boot/dts/logicpd-som-lv.dtsi           |    2 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit.dts    |    2 +-
 arch/arm/boot/dts/ls1021a.dtsi                  |    1 +
 arch/arm/boot/dts/mt7623.dtsi                   |    3 +
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts   |    6 +-
 arch/arm/boot/dts/mt7623n-rfb-nand.dts          |   73 -
 arch/arm/boot/dts/mt7623n-rfb.dtsi              |   86 -
 arch/arm/boot/dts/omap3-cm-t3517.dts            |    2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts            |    2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi         |    2 +-
 arch/arm/boot/dts/omap3-igep0020-rev-f.dts      |    2 +-
 arch/arm/boot/dts/omap3-igep0030-rev-g.dts      |    2 +-
 arch/arm/boot/dts/omap3-zoom3.dts               |    2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts        |    7 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts      |    4 +-
 arch/arm/boot/dts/omap4-duovero.dtsi            |    1 +
 arch/arm/boot/dts/omap4-l4.dtsi                 | 2444 ++++++++++++++++++
 arch/arm/boot/dts/omap4-panda-common.dtsi       |   24 +-
 arch/arm/boot/dts/omap4-panda-es.dts            |   14 +-
 arch/arm/boot/dts/omap4-sdp.dts                 |    2 +-
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi  |    2 +-
 arch/arm/boot/dts/omap4.dtsi                    |  812 +-----
 arch/arm/boot/dts/omap4460.dtsi                 |   36 +
 arch/arm/boot/dts/omap5-board-common.dtsi       |    2 +-
 arch/arm/boot/dts/omap5.dtsi                    |   14 +
 arch/arm/boot/dts/pxa2xx.dtsi                   |    2 +-
 arch/arm/boot/dts/pxa3xx.dtsi                   |   33 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi             |   24 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi             |   41 +-
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts  |    2 +
 arch/arm/boot/dts/r7s72100-genmai.dts           |    5 +-
 arch/arm/boot/dts/r7s72100-gr-peach.dts         |    5 +-
 arch/arm/boot/dts/r7s72100-rskrza1.dts          |    5 +-
 arch/arm/boot/dts/r7s72100.dtsi                 |    5 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |    5 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |    5 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |    5 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |    5 +-
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts |    5 +-
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts         |    5 +-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi           |    5 +-
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts          |    5 +-
 arch/arm/boot/dts/r8a7743.dtsi                  |   14 +-
 .../boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts  |    5 +-
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts     |    5 +-
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi           |    5 +-
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts          |    5 +-
 arch/arm/boot/dts/r8a7745.dtsi                  |    5 +-
 arch/arm/boot/dts/r8a77470.dtsi                 |   16 +-
 arch/arm/boot/dts/r8a7778-bockw.dts             |    5 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |    5 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |    5 +-
 arch/arm/boot/dts/r8a7779.dtsi                  |    5 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |    5 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |   39 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    5 +-
 arch/arm/boot/dts/r8a7791-porter.dts            |   38 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |   19 +-
 arch/arm/boot/dts/r8a7792-blanche.dts           |    5 +-
 arch/arm/boot/dts/r8a7792-wheat.dts             |    5 +-
 arch/arm/boot/dts/r8a7792.dtsi                  |    5 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |    5 +-
 arch/arm/boot/dts/r8a7793.dtsi                  |   20 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |    5 +-
 arch/arm/boot/dts/r8a7794-silk.dts              |    5 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |    5 +-
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi  |    5 +-
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi  |    5 +-
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts     |   28 +
 arch/arm/boot/dts/r9a06g032.dtsi                |  115 +
 arch/arm/boot/dts/rk3036-evb.dts                |   40 +-
 arch/arm/boot/dts/rk3036-kylin.dts              |   40 +-
 arch/arm/boot/dts/rk3036.dtsi                   |   40 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          |   39 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts         |   39 +-
 arch/arm/boot/dts/rk3066a-mk808.dts             |   39 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts          |   39 +-
 arch/arm/boot/dts/rk3066a.dtsi                  |   39 +-
 arch/arm/boot/dts/rk3188-px3-evb.dts            |   39 +-
 arch/arm/boot/dts/rk3188-radxarock.dts          |   39 +-
 arch/arm/boot/dts/rk3188.dtsi                   |   39 +-
 arch/arm/boot/dts/rk3228-evb.dts                |   40 +-
 arch/arm/boot/dts/rk3229-evb.dts                |   40 +-
 arch/arm/boot/dts/rk3229.dtsi                   |   39 +-
 arch/arm/boot/dts/rk322x.dtsi                   |   43 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts        |   40 +-
 arch/arm/boot/dts/rk3288-evb-rk808.dts          |   40 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               |   42 +-
 arch/arm/boot/dts/rk3288-fennec.dts             |   40 +-
 arch/arm/boot/dts/rk3288-firefly-beta.dts       |   39 +-
 .../boot/dts/rk3288-firefly-reload-core.dtsi    |   39 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts     |   39 +-
 arch/arm/boot/dts/rk3288-firefly.dts            |   39 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi           |   39 +-
 arch/arm/boot/dts/rk3288-miqi.dts               |   39 +-
 arch/arm/boot/dts/rk3288-phycore-rdk.dts        |   39 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi       |   39 +-
 arch/arm/boot/dts/rk3288-popmetal.dts           |   39 +-
 arch/arm/boot/dts/rk3288-r89.dts                |   39 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |   40 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts       |   40 +-
 arch/arm/boot/dts/rk3288-tinker.dts             |   39 +-
 .../boot/dts/rk3288-veyron-analog-audio.dtsi    |    5 +-
 arch/arm/boot/dts/rk3288-veyron-brain.dts       |   39 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |   41 +-
 arch/arm/boot/dts/rk3288-veyron-jaq.dts         |   39 +-
 arch/arm/boot/dts/rk3288-veyron-jerry.dts       |   39 +-
 arch/arm/boot/dts/rk3288-veyron-mickey.dts      |   39 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |   39 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts       |   39 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi      |   39 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts      |   39 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi            |   75 +-
 arch/arm/boot/dts/rk3288-vyasa.dts              |   39 +-
 arch/arm/boot/dts/rk3288.dtsi                   |  122 +-
 arch/arm/boot/dts/rk3xxx.dtsi                   |   39 +-
 arch/arm/boot/dts/rv1108-evb.dts                |   40 +-
 arch/arm/boot/dts/rv1108.dtsi                   |   40 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi            |  419 +++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts       |   45 +
 arch/arm/boot/dts/s5pv210-galaxys.dts           |   77 +
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi          |    2 +
 arch/arm/boot/dts/sama5d2-pinfunc.h             |    4 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |    8 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |    2 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |    5 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |    5 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi          |   12 +
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi      |    1 -
 arch/arm/boot/dts/stm32f429.dtsi                |    3 +-
 arch/arm/boot/dts/stm32f746.dtsi                |    2 +-
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi       |   75 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts           |   25 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts           |   45 +
 arch/arm/boot/dts/stm32mp157c.dtsi              |  309 ++-
 arch/arm/boot/dts/sun4i-a10.dtsi                |   25 +-
 arch/arm/boot/dts/sun5i.dtsi                    |   32 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                |   30 +
 arch/arm/boot/dts/sun7i-a20.dtsi                |   38 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   22 +
 arch/arm/boot/dts/sun8i-a33.dtsi                |    9 +
 .../dts/sun8i-a83t-allwinner-h8homlet-v2.dts    |    8 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts    |    8 +
 .../arm/boot/dts/sun8i-a83t-cubietruck-plus.dts |    8 +
 arch/arm/boot/dts/sun8i-a83t.dtsi               |    2 -
 .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts |   21 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts       |    7 +
 arch/arm/boot/dts/sun8i-h3.dtsi                 |   31 +
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts    |   29 +
 arch/arm/boot/dts/sun8i-r40.dtsi                |  319 ++-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              |    2 -
 .../arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi |    9 +
 arch/arm/boot/dts/tegra114-dalmore.dts          |    2 +-
 arch/arm/boot/dts/tegra114-roth.dts             |    2 +-
 arch/arm/boot/dts/tegra114-tn7.dts              |    2 +-
 arch/arm/boot/dts/tegra114.dtsi                 |    9 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     |    2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi          |    2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |    2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi            |    2 +-
 arch/arm/boot/dts/tegra124-venice2.dts          |    2 +-
 arch/arm/boot/dts/tegra124.dtsi                 |    7 +-
 ...20-iris-512.dts => tegra20-colibri-iris.dts} |    4 +-
 ...20-colibri-512.dtsi => tegra20-colibri.dtsi} |   27 +-
 arch/arm/boot/dts/tegra20-harmony.dts           |    2 +-
 arch/arm/boot/dts/tegra20-paz00.dts             |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts          |    2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |    2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts         |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts           |    2 +-
 arch/arm/boot/dts/tegra20.dtsi                  |   31 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi           |    9 +-
 arch/arm/boot/dts/tegra30-beaver.dts            |    5 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi           |    3 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi          |    4 +-
 arch/arm/boot/dts/tegra30.dtsi                  |   13 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |    3 +
 arch/arm/boot/dts/vf610-zii-cfu1.dts            |  305 +++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts       |  341 +++
 arch/arm/boot/dts/zynq-cc108.dts                |    2 +-
 arch/arm/boot/dts/zynq-microzed.dts             |    4 +-
 arch/arm/boot/dts/zynq-parallella.dts           |    2 +-
 arch/arm/boot/dts/zynq-zc702.dts                |    5 +-
 arch/arm/boot/dts/zynq-zc706.dts                |    3 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts          |    2 +-
 arch/arm/boot/dts/zynq-zc770-xm011.dts          |    2 +-
 arch/arm/boot/dts/zynq-zc770-xm012.dts          |    2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts          |    2 +-
 arch/arm/boot/dts/zynq-zed.dts                  |    5 +-
 arch/arm/boot/dts/zynq-zturn.dts                |  114 +
 arch/arm/boot/dts/zynq-zybo-z7.dts              |   16 +-
 arch/arm/boot/dts/zynq-zybo.dts                 |    3 +-
 arch/arm/mach-at91/pm.c                         |    5 +
 arch/arm64/Kconfig.platforms                    |    7 +
 arch/arm64/boot/dts/Makefile                    |    1 +
 arch/arm64/boot/dts/allwinner/Makefile          |    2 +
 .../dts/allwinner/sun50i-a64-amarula-relic.dts  |  219 ++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts   |    4 +
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts     |    4 +
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts |    4 +
 .../dts/allwinner/sun50i-a64-orangepi-win.dts   |    4 +
 .../boot/dts/allwinner/sun50i-a64-pine64.dts    |    4 +
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts  |  285 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts   |    4 +
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi   |   15 +
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts   |    7 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |  113 +-
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts    |   12 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   |  146 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |   67 +-
 .../boot/dts/altera/socfpga_stratix10.dtsi      |   41 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts |   35 +
 arch/arm64/boot/dts/amlogic/Makefile            |    3 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts  |  168 ++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi      |  311 +++
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    |   17 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts   |   48 +
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts   |  218 ++
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts   |   15 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts   |    7 +
 .../boot/dts/amlogic/meson-gxl-s905w-p281.dts   |   22 +
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts    |   22 +
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts  |   24 +
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts  |   15 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts  |    7 +
 arch/arm64/boot/dts/broadcom/stingray/Makefile  |    2 +
 .../dts/broadcom/stingray/bcm958742-base.dtsi   |   35 +-
 .../dts/broadcom/stingray/bcm958802a802x.dts    |   26 +
 .../broadcom/stingray/stingray-board-base.dtsi  |   51 +
 .../dts/broadcom/stingray/stingray-clock.dtsi   |   26 +-
 .../dts/broadcom/stingray/stingray-pcie.dtsi    |   54 +
 .../boot/dts/broadcom/stingray/stingray.dtsi    |   19 +
 .../exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  |   20 -
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi  |   19 -
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   14 +-
 .../dts/exynos/exynos7-tmu-sensor-conf.dtsi     |   21 -
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |    2 +-
 .../boot/dts/freescale/fsl-ls1012a-frdm.dts     |   38 +-
 .../boot/dts/freescale/fsl-ls1012a-qds.dts      |   38 +-
 .../boot/dts/freescale/fsl-ls1012a-rdb.dts      |   38 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |   38 +-
 .../boot/dts/freescale/fsl-ls1043-post.dtsi     |    3 +-
 .../boot/dts/freescale/fsl-ls1043a-qds.dts      |   39 +-
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts      |   39 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  |   44 +-
 .../boot/dts/freescale/fsl-ls1046-post.dtsi     |    2 +-
 .../boot/dts/freescale/fsl-ls1046a-qds.dts      |   39 +-
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts      |   39 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |   42 +-
 .../boot/dts/freescale/fsl-ls1088a-qds.dts      |   38 +-
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts      |   38 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi  |   44 +-
 .../boot/dts/freescale/fsl-ls2080a-qds.dts      |   38 +-
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts      |   38 +-
 .../boot/dts/freescale/fsl-ls2080a-simu.dts     |   38 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi  |   42 +-
 .../boot/dts/freescale/fsl-ls2088a-qds.dts      |   38 +-
 .../boot/dts/freescale/fsl-ls2088a-rdb.dts      |   38 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi  |   42 +-
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi     |   38 +-
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi     |   38 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi  |   38 +-
 .../boot/dts/freescale/qoriq-bman-portals.dtsi  |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi  |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi  |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi  |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi  |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi  |    2 +-
 .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi  |    2 +-
 .../arm64/boot/dts/freescale/qoriq-fman3-0.dtsi |    2 +-
 .../boot/dts/freescale/qoriq-qman-portals.dtsi  |    2 +-
 .../boot/dts/hisilicon/hi3660-hikey960.dts      |   26 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |   79 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  |    1 -
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |   16 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi    |   23 +-
 .../boot/dts/marvell/armada-8040-mcbin.dts      |    2 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi   |    2 +-
 arch/arm64/boot/dts/mediatek/Makefile           |    1 +
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts |   33 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts    |    4 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi        |   12 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |    2 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi  |   22 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |  106 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |    2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    |  239 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |   28 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |   22 +-
 arch/arm64/boot/dts/qcom/pm8005.dtsi            |   33 +
 arch/arm64/boot/dts/qcom/pm8998.dtsi            |   55 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts         |   45 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |  780 ++++++
 .../boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dts  |    5 +-
 .../boot/dts/renesas/r8a7795-es1-h3ulcb.dts     |    5 +-
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts |    5 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi    |    7 +-
 .../boot/dts/renesas/r8a7795-h3ulcb-kf.dts      |    5 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts  |    5 +-
 .../boot/dts/renesas/r8a7795-salvator-x.dts     |    5 +-
 .../boot/dts/renesas/r8a7795-salvator-xs.dts    |    5 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        |   22 +-
 .../boot/dts/renesas/r8a7796-m3ulcb-kf.dts      |    5 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts  |    5 +-
 .../boot/dts/renesas/r8a7796-salvator-x.dts     |    5 +-
 .../boot/dts/renesas/r8a7796-salvator-xs.dts    |    5 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        |   63 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |  253 +-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts  |    5 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts  |    5 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi       |    7 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |   29 +
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  |   23 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |  403 ++-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts  |   37 +
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |  169 +-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |  133 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |  251 +-
 .../arm64/boot/dts/renesas/salvator-common.dtsi |   34 +-
 arch/arm64/boot/dts/renesas/salvator-x.dtsi     |    7 +-
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi    |    7 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi        |    5 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi           |   11 +-
 arch/arm64/boot/dts/rockchip/Makefile           |    2 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts     |   39 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts  |   39 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |   44 +-
 .../boot/dts/rockchip/rk3368-evb-act8846.dts    |   39 +-
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi    |   39 +-
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts |   39 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts |   39 +-
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts |   39 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     |   39 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |   47 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts     |   39 +-
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts   |  599 +++++
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts |   86 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts |   79 +
 .../dts/rockchip/rk3399-gru-chromebook.dtsi     |  397 +++
 .../boot/dts/rockchip/rk3399-gru-kevin.dts      |   86 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    |  367 +--
 .../arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi |   39 +-
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi    |   39 +-
 .../boot/dts/rockchip/rk3399-puma-haikou.dts    |   39 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi   |   40 +-
 .../dts/rockchip/rk3399-sapphire-excavator.dts  |   41 +-
 .../boot/dts/rockchip/rk3399-sapphire.dtsi      |   44 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |  161 +-
 .../boot/dts/socionext/uniphier-ld11-global.dts |    1 +
 .../boot/dts/socionext/uniphier-ld20-global.dts |    1 +
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |    2 +
 arch/arm64/boot/dts/sprd/sc2731.dtsi            |   44 +
 arch/arm64/boot/dts/sprd/whale2.dtsi            |    6 +
 arch/arm64/boot/dts/ti/Makefile                 |    9 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |   31 +
 arch/arm64/boot/dts/ti/k3-am65.dtsi             |   87 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |   36 +
 arch/arm64/boot/dts/ti/k3-am654.dtsi            |  115 +
 arch/arm64/boot/dts/xilinx/Makefile             |    2 +-
 .../boot/dts/xilinx/avnet-ultra96-rev1.dts      |   19 +
 .../arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi |  137 -
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts     |  154 --
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts      |   12 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts      |    2 -
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts      |    2 -
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts      |    2 -
 drivers/soc/ti/Kconfig                          |   14 +
 include/dt-bindings/memory/mt2712-larb-port.h   |   95 +
 581 files changed, 22415 insertions(+), 7095 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/m4if.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/tigerp.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/insignal-boards.txt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
 create mode 100755 arch/arm/boot/dts/am335x-osd3358-sm-red.dts
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts
 create mode 100644 arch/arm/boot/dts/armada-388-helios4.dts
 create mode 100644 arch/arm/boot/dts/at91-dvk_som60.dts
 create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
 create mode 100644 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
 create mode 100644 arch/arm/boot/dts/at91-gatwick.dts
 create mode 100644 arch/arm/boot/dts/at91-som60.dtsi
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dts
 create mode 100644 arch/arm/boot/dts/at91-wb50n.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/gemini-sl93512r.dts
 create mode 100644 arch/arm/boot/dts/gr-peach-audiocamerashield.dtsi
 create mode 100644 arch/arm/boot/dts/imx31-lite.dts
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
 create mode 100644 arch/arm/boot/dts/imx51-zii-scu3-esb.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp-ddc.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp-hsc.dts
 create mode 100644 arch/arm/boot/dts/imx53-kp.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-icore-mipi.dts
 create mode 100644 arch/arm/boot/dts/imx6sll-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6sll-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6sll.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcexpress.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
 create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi
 delete mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
 delete mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-l4.dtsi
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
 create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts
 rename arch/arm/boot/dts/{tegra20-iris-512.dts => tegra20-colibri-iris.dts} (95%)
 rename arch/arm/boot/dts/{tegra20-colibri-512.dtsi => tegra20-colibri.dtsi} (96%)
 create mode 100644 arch/arm/boot/dts/vf610-zii-cfu1.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
 create mode 100644 arch/arm/boot/dts/zynq-zturn.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958802a802x.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-board-base.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
 create mode 100644 arch/arm64/boot/dts/qcom/pm8005.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8998.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/Makefile
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
 create mode 100644 include/dt-bindings/memory/mt2712-larb-port.h
