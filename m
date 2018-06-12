Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 688D5C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E59208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="aXOsrwLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E59208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934276AbeFLAC2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:02:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35368 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934138AbeFLACT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:02:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id c22-v6so10677485pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ro1p7Tj8RHj7+/7x1WAZcmHvNBnAfbXlYkQftZmeAWM=;
        b=aXOsrwLtoJlqUgJMEVJ92MIWkWCTQjJgZQPx9eUpW766x9pHr9H20tpUo126ellmu3
         u5LPXvrL0TQ8VL30G5087C0NEaDNxncQoFDeqjJEAweBhZQzbp0G7vj8X+cy9XAfWclF
         P5wgPXZp7f9zXeGzCdPb/fD5NNNeFgWF4sBK0BwwW8yjv11vzkRF8Iqaa8/eurWHxtmK
         ASupx3PYqZz6Ph04jbeDJVIS7Fpjpow0JzLU3W5kU6GHVyWuHQ+rHyNmjWLWxsllx2mr
         /2D5KMXkDV9OYXcjwnsoENts/Q7yXM71Te64W4zTjePNBKDCOMU5Fu2vYR15GoQiXn4N
         HYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ro1p7Tj8RHj7+/7x1WAZcmHvNBnAfbXlYkQftZmeAWM=;
        b=Bq+wSVN4KRASCB4Y/xgGWQuu/6DZsunRXsddkZEAiOAWkdYv/e1Ht7zY7VVKApYEHV
         hVqR9OJMiXfsxzv0tvO2j0llKgjeyF+CIEcGNE+/pvnpB91v6Aq3oqUyYEc4pIpbzZtA
         RLcSU6n8HHqHwxeZfHWKR+cXWnWrr9I51hyWp7CQX8t2MQJQT1IAp4NHEmGnNHXpQXyJ
         0Ir+qRTojosRx7KTeCgBOoObn4WZaPeyoaZNE1gIbO8mneypDugeLNO8xLQnX//00bk/
         Yt0hP54vP7qJeNwPBgw5Fp25YizfKeNc/mVvNefQN1q6Hm5sIKFIsvtLd6JamOjdbgUh
         thpA==
X-Gm-Message-State: APt69E1Ek8lJwjHyN0pNHRn+hPEmh52Fnrk8XJetmIDC99ZVKckQ3Gvj
        H3tHFUl9t79rw6inUTcPyM6/9w==
X-Google-Smtp-Source: ADUXVKK7mgIOHdVDsMhtfVyq6aocBbY41jsFm8xh+3dkDGoRybJ84VT8oChuEiItn21LtfoJMEuRnQ==
X-Received: by 2002:a63:b812:: with SMTP id p18-v6mr1097605pge.11.1528761737428;
        Mon, 11 Jun 2018 17:02:17 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id c27-v6sm82016623pfl.63.2018.06.11.17.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:02:14 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/4] ARM: Device-tree updates
Date:   Mon, 11 Jun 2018 17:01:40 -0700
Message-Id: <20180612000142.28883-3-olof@lixom.net>
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

As always, a large number of DT updates. Too many to enumerate them all,
but at a glance:

New SoCs introduced in this release:

- Amlogic:
+ Meson 8M2 SoC, a.k.a. S812. A quad Cortex-A9 SoC used in some set
top boxes and other products.

- Mediatek:
+ MT7623A, which is a flavor of the MT7623 family with other on-chip
ethernet options.

- Qualcomm:
+ SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
(Cortex-A75/A55 derivative) SoC that's one of the current high-end
mobile SoCs.

It's great to see mainline support for it. So far, you
can't do much with it, since a lot of peripherals are not yet in the
DTs but driver support for USB, GPU and other pieces are starting to
trickle in. This might end up being a well-supported SoC upstream if
the momentum keeps up.

- Renesas:
+ R8A77990, a.k.a R-Car E3, a new automotive entertainment-targeted
SoC. Currently only one Cortex-A53 CPU is enabled, we are eagerly
awaiting more. So far, basic drivers such as serial, gpios, PMU and
ethernet are enabled.
+ R8A77470, a.k.a. RZ/G1C, a new dual Cortex-A7 SoC with PowerVR
GPU. Same here, basic set of drivers such as serial, gpios and ethernet
enabled, and SMP support is also forthcoming.

- STMicroelectronics:
+ STM32F469, very similar tih STM32F429 but with display support

Enhancements to SoCs/platforms (DTS contents, some driver portions might
not be in yet):

- Allwinner sun8i (h3/a33/a83t) SMP, DVFS tweaks, misc
- Amlogic Meson: I2C, UFS, TDM, GPIO external interrupts, MMC resets
- Hisilicon hi3660: Thermal cooling, CPU frequency scaling, mailbox interfaces
- Marvell Berlin2CD: SMP support, thermal sensors
- Mediatek MT7623: Highspeed DMA, audio support
- Qualcomm IPQ8074 PCIe support, MSM8996 UFS support
- Renesas: Watchdog and PMU support across many platforms
- Rockchip RK3399: USB3 OTG support
- Samsung Exynos: Audio-over-HDMI on Odroid X/X2/U3
- STMicro STM32: Lots of peripherals added to STM32MP175C
- Uniphier: Ethernet support

New boards:

- Allwinner A20: Olimex A20-SOM-EVB-eMMC variant
- Allwinner H2+: Libre Computer ALL-H3-CC (h2+ version)
- Allwinner A33: Nintendo NES/SuperNES Classic Edition
- Aspeed: S2600WF, Inventec Lanyang BMC, Portwell Neptune
- Berlin2CD: Valve Steam Link
- Broadcom BCM5301X: Luxul XAP-1610 and XWR-3150 V1
- Broadcom: Raspberry Pi 3 B+
- Mediatek MT7623N and MT7623A: reference boards
- Meson 8M2: Tronsmart MXIII Plus
- NXP i.MX: Engicam i.CoreM6, DHCOM iMX6 SOM, BTicino i.MX6DL Mamoj
- Qualcomm MSM8974: Sony Xperia Z1 Compact support
- Qualcomm SDM845: MTP development board
- Renesas: Ebisu R8A77990 board
- Renesas RZ/G1C: iwg23s: iWave G235-SDB
- TI am335x: Pocketbeagle support



Conflicts:

arch/arm/boot/dts/stm32mp157c.dtsi: Add/add. The new 'exti' entry
should stay, but please move it up to its place in the list of entries
as sorted by unit-address (i.e. right after rcc@50000000). Also, git
doesn't duplicate the closing brace so make sure you add one.

arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi: Add/add/remove. A bit
of a mess due to the BT maintainer picking up DTS changes this release
cycle. Keep our version for both conflicts (remove the bt regulator and
keep our pcie@ node instead of the qcom,pcie# one).

----------------------------------------------------------------

The following changes since commit c32aed8869e03f3221542e1748dfed75adbd2a4b:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 87815dda55934180d8e6ec0a0a448b104d251c54:

  Merge tag 'pxa-dt-4.18' of https://github.com/rjarzmik/linux into next/dt

----------------------------------------------------------------

Adam Ford (15):
      ARM: dts: da850-evm: Enable usb_phy, usb0 and usb1
      ARM: dts: logicpd-som-lv: Enable Touchscreen controller
      ARM: dts: da850-evm: use phandles to extend nodes
      ARM: dts: logicpd-torpedo: Add fixed 26MHz clock as fck for twl
      ARM: dts: logicpd-som-lv: Add fixed 26MHz clock as fck for twl
      ARM: dts: am3517: Add pinmuxing, CD and WP for MMC1
      ARM: dts: am3517-evm: Split off SOM features from baseboard
      ARM: dts: am3517-som: Add TI TPS65023 regulators
      ARM: dts: am3517-som: Associate cpu to regulator supply
      ARM: dts: am3517-evm: Add LCD panel type 15 support
      ARM: dts: am3517-som: Add Seiko Instruments RTC s35390a
      ARM: dts: logicpd-som-lv: Fix Touchscreen controller
      ARM: dts: da850-evm: add WP and CD to MMC
      ARM: dts: am3517-evm: Add I/O expander for User DIP switches and LEDS
      ARM: dts: am3517-evm: Add User LEDs and Pushbutton

Alexander Monakov (7):
      ARM: dts: berlin2cd: fix local timer interrupt flags
      ARM: dts: berlin2cd: move PMU node from soc to root
      ARM: dts: berlin2cd: add ADC/thermal sensor node
      ARM: dts: berlin2cd: add remaining Cortex-A9 nodes
      ARM: dts: berlin2cd: add remaining nodes to apb subtrees
      ARM: dts: berlin2cd: add a label for the CPU node
      ARM: dts: berlin2cd: add Valve Steam Link board

Alexandre Torgue (2):
      ARM: dts: stm32: Fix DTC warnings for stm32mp157
      ARM: dts: stm32: Fix IRQ_TYPE_NONE warnings on stm32mp157c

Amelie Delaunay (4):
      ARM: dts: stm32: add USBPHYC support to stm32mp157c
      ARM: dts: stm32: add supplies to usbphyc ports on stm32mp157c-ed1
      ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1
      ARM: dts: stm32: add USB Host (USBH) support to stm32mp157c

Amithash Prasad (1):
      ARM: dts: aspeed: Add Portwell Neptune machine

Andi Shyti (1):
      ARM: dts: exynos: Update x and y properties for mms114 touchscreen

Andrzej Pietrasiewicz (2):
      ARM: dts: exynos: Add mem-2-mem Scaler devices
      arm64: dts: exynos: Add mem-2-mem Scaler devices

Anson Huang (13):
      ARM: dts: imx7d-sdb: add gpio key support
      ARM: dts: imx7s: add anatop vdd1p2 regulator
      ARM: dts: imx6sx-sabreauto: add external 24MHz clock source
      ARM: dts: imx6sx-sabreauto: add PMIC support
      ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
      ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
      ARM: dts: imx6sx-sabreauto: add fec support
      ARM: dts: imx6sx-sabreauto: add wdog external reset
      ARM: dts: imx6sx-sabreauto: add debug LED support
      ARM: dts: imx6sx-sabreauto: add egalax touch screen support
      ARM: dts: imx7d: correct cpu supply name for voltage scaling
      ARM: dts: imx7s-warp: remove unnecessary cpu regulator supply
      ARM: dts: imx7d: use operating-points-v2 for cpu

Antoine Tenart (3):
      arm64: dts: marvell: mcbin: enable the fourth network interface
      arm64: dts: marvell: 8040-db: describe the 10G interfaces as fixed-link
      arm64: dts: marvell: 7040-db: describe the 10G interface as fixed-link

Arnd Bergmann (1):
      arm64: dts: qcom: rename qcom,pcie devices to pcie

Attila Szöllősi (1):
      ARM: dts: qcom: msm8974: Add Sony Xperia Z1 Compact

Baolin Wang (2):
      arm64: dts: sprd: Add GPIO and GPIO keys device nodes
      arm64: dts: sprd: whale2: Add the rtc enable clock for watchdog

Benjamin Herrenschmidt (2):
      ARM: dts: Add Aspeed SoC USB controllers to device-tree
      ARM: dts: Aspeed: Enable USB ports on eval board.

Biju Das (1):
      dt-bindings: arm: Document iW-RainboW-G23S single board computer

Bjorn Andersson (2):
      arm64: dts: qcom: msm8996: Add ufs related nodes
      arm64: dts: qcom: msm8996: Use UFS_GDSC for UFS

Brad Bishop (1):
      ARM: dts: aspeed: witherspoon: Enable checkstop and cooling gpio keys

Brian Yang (1):
      ARM: dts: aspeed: Add Inventec Lanyang BMC

Chen-Yu Tsai (8):
      ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2 regulator voltage
      ARM: dts: sun8i: h2-plus: Sort dtb entries in Makefile
      ARM: dts: sun8i: h2+: Add Libre Computer Board ALL-H3-CC H2+ ver.
      arm64: dts: allwinner: h5: Add cpu0 label for first cpu
      arm64: dts: allwinner: Sort dtb entries in Makefile
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Sort device node dereferences
      ARM: dts: sun8i: r40: Add device node and RGMII pinmux node for GMAC
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable GMAC ethernet controller

Chris Packham (1):
      ARM: dts: armada-xp-98dx: Add NAND pinctrl information

Christopher Bostic (1):
      ARM: dts: aspeed: witherspoon: Add gpio keys for power supply presence

Craig Tatlor (1):
      ARM: dts: qcom: pm8941: Add vadc nodes needed to estimate an ocv

Dan Haab (2):
      ARM: dts: BCM5301X: Add DT for Luxul XWR-3150 V1
      ARM: dts: BCM5301X: Add DT for Luxul XAP-1610

Daniel Mack (4):
      ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source
      ARM: pxa: dts: add gpio-ranges to gpio controller
      ARM: pxa: dts: add pin definitions for extended GPIOs
      ARM: dts: pxa3xx: fix MMC clocks

Daniel Schultz (1):
      ARM: dts: rockchip: Add dp83867 CLK_OUT muxing on rk3288-phycore-som

David Lechner (2):
      ARM: dts: da850: use gpio-ranges
      ARM: dts: da850-lego-ev3: remove unnecessary gpio-keys properties

Dmitry Osipenko (5):
      dt-bindings: arm: tegra: Remove duplicated Tegra30+ MC binding
      dt-bindings: memory: tegra: Document #reset-cells property of the Tegra30 MC
      dt-bindings: arm: tegra: Document #reset-cells property of the Tegra20 MC
      ARM: dts: tegra30: Add IOMMU nodes to Host1x and its clients
      ARM: dts: tegra114: Add IOMMU nodes to Host1x and its clients

Dmitry Torokhov (2):
      ARM: dts: at91: sama5d4ek: use canonical compatible for touchscreen
      arm64: dts: rockchip: use canonical compatible for touchpad/touchscreen on gru-kevin

Douglas Anderson (4):
      arm64: dts: sdm845: Fix xo_board clock name and speed
      arm64: dts: sdm845: Add command DB node
      arm64: dts: qcom: sdm845: Sort nodes in the reserved mem by address
      arm64: dts: qcom: sdm845: Sort nodes in the soc by address

Eddie James (1):
      ARM: dts: aspeed: witherspoon: Set alternate boot

Ellie Reeves (1):
      arm64: dts: armada-3720-espressobin: wire up spi flash

Enric Balletbo i Serra (7):
      ARM: dts: rockchip: set PWM delay backlight settings for Veyron
      ARM: dts: rockchip: set PWM delay backlight settings for Minnie
      arm64: dts: rockchip: enable typec-phy for rk3399-sapphire
      arm64: dts: rockchip: enable typec-phy for rk3399-firefly
      arm64: dts: rockchip: enable typec-phy1 for rk3399-puma
      arm64: dts: rockchip: enable typec-phy0 for rk3399-puma-haikou
      arm64: dts: rockchip: add usb3-phy otg-port support for rk3399

Eyal Reizer (1):
      ARM: dts: am437x-sk-evm: add wilink8 support

Fabio Estevam (28):
      ARM: dts: imx25-pdk: Remove unneeded 'codec-handle' property
      ARM: dts: imx53-tx53: Remove unneeded 'codec-handle' property
      ARM: dts: imx6qdl-wandboard: Let the codec control MCLK pinctrl
      ARM: dts: imx7: Move tempmon node out of bus
      ARM: dts: imx6qdl-tx6: Remove 'bus-format-override' property
      ARM: dts: imx6ul: Add CAAM support
      ARM: dts: imx6qdl: Remove #address/#size-cells from mipi_dsi
      arm64: dts: ls208xa-rdb: Pass unit name to SPI flash node
      ARM: dts: imx: Remove #address/#size-cells from switch nodes
      ARM: dts: imx: Remove #address/#size-cells from stmpe nodes
      ARM: dts: imx6qdl-sabre: Remove #address/#size-cells from camera port nodes
      ARM: dts: imx53-ppd: Remove unnecessary #address/#size-cells
      ARM: dts: imx6dl-aristainetos2_4: Remove #address/#size-cells from display0
      ARM: dts: imx6q-b850v3: Remove #address/#size-cells from stdp2690
      ARM: dts: imx6q-utilite-pro: Remove #address/#size-cells from encoder
      ARM: dts: imx6q-var-dt6customboard: Remove #address/#size-cells from gpio-keys
      ARM: dts: imx6q-pistachio: Use 'uart-has-rtscts' property
      ARM: dts: imx6qdl-wandboard: Switch to SPDX identifier
      ARM: dts: imx6qdl-udoo: Switch to SPDX identifier
      ARM: dts: imx28-cfa10049: Remove unnecessary #address/#size-cells
      ARM: dts: imx28-duckbill-2-enocean: Remove unnecessary #address/#size-cells
      ARM: dts: imx: Switch to SPDX identifier
      ARM: dts: imx53-ard: Do not hardcode input codes
      ARM: dts: imx53-smd: Do not hardcode input codes
      ARM: dts: imx6q-gk802: Do not hardcode input codes
      arm64: dts: fsl-ls1012a: Fix DTC aliases warnings
      ARM: dts: imx: Switch NXP boards to SPDX identifier
      ARM: dts: imx6/7: Remove unit-address from anatop regulators

Fabrice Gasnier (8):
      ARM: dts: stm32: add timers support to stm32mp157c
      ARM: dts: stm32: add PWM pins used on stm32mp157c-ev1 board
      ARM: dts: stm32: add PWM and triggers on stm32mp157c-ev1 board
      ARM: dts: stm32: enable timer trigger 6 on stm32mp157c-ed1
      ARM: dts: stm32: Add vrefbuf support to stm32mp157c
      ARM: dts: stm32: Add LPtimer support to stm32mp157c
      ARM: dts: stm32: Add DAC support to stm32mp157c
      ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743

Fabrizio Castro (1):
      dt-bindings: timer: renesas, cmt: Document r8a774[35] CMT support

Faiz Abbas (2):
      ARM: dts: am33xx: Add pinmux data for mmc1 in am335x-evm, evmsk and beaglebone
      ARM: dts: k2g-evm: Add DCAN dt nodes

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2018-04-30' into devicetree/next

Gabriel Fernandez (2):
      ARM: dts: stm32: Enable stm32mp1 clock driver on stm32mp157c
      ARM: dts: stm32: add reset binding on stm32mp157c

Geert Uytterhoeven (2):
      ARM: dts: Ux500: Fix "debounce-interval" property misspelling
      ARM: dts: gemini: Fix "debounce-interval" property misspelling

Graeme Smecher (1):
      ARM: dts: correct invalid I/O definition for MMC/SD card detect on T410

Greg Ungerer (1):
      ARM: dts: imx6ull: add UART5 input select register definitions

H. Nikolaus Schaller (2):
      ARM: dts: omap3-pandora: Add fixed 26MHz clock as fck for twl
      ARM: dts: omap3-gta04: Add fixed 26MHz clock as fck for twl

Hari Nagalla (2):
      ARM: dts: dra72-evm-common: Add wilink8 wlan support
      ARM: dts: dra7-evm: Add wilink8 wlan support

Heinrich Schuchardt (1):
      ARM: dts: rockchip: default serial for rk3288 Tinker Board

Hernán Gonzalez (10):
      ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier
      ARM: dts: vf-colibri-eval-v3: Use IRQ_TYPE specifier
      ARM: dts: imx53-qsb: Use IRQ_TYPE specifier
      ARM: dts: imx53-voipac-dmm-668: Use IRQ_TYPE specifier
      ARM: dts: imx6qdl-phytec-pfla02: Use IRQ_TYPE specifier
      ARM: dts: am335x-baltos-ir3220: Use IRQ_TYPE specifier
      ARM: dts: am335x-baltos-ir5221: Use IRQ_TYPE specifier
      ARM: dts: am335x-baltos.dtsi: Use IRQ_TYPE specifier
      ARM: dts: am335x-boneblue: Use IRQ_TYPE specifier
      ARM: dts: omap3-pandora-common: Use IRQ_TYPE specifier

Icenowy Zheng (12):
      ARM: sun8i: v40: enable USB host ports for Banana Pi M2 Berry
      ARM: dts: sun8i: h3: add operating-points-v2 table for CPU
      ARM: dts: sun8i: h2+: add SY8113B regulator used by Orange Pi Zero board
      ARM: dts: sun8i: h3: add SY8113B regulator used by Orange Pi One board
      arm64: allwinner: h6: restore the usage of CCU slice macros
      ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VDD-CPUX voltage
      ARM: dts: sun8i: h3: set the cpu-supply to VDD-CPUX on ALL-H3-CC H3 ver
      arm64: allwinner: h6: add PRCM CCU device node
      arm64: allwinner: h6: add node for R_PIO pin controller
      arm64: allwinner: h6: add R_INTC interrupt controller
      arm64: allwinner: h6: add R_I2C controller
      arm64: allwinner: h6: add PCF8563 RTC on Pine H64 board

Jacob Chen (1):
      ARM: dts: rockchip: fix uart4 pin-numbers for rk3288

Jagan Teki (6):
      dt-bindings: Add vendor prefix for Bticino
      ARM: dts: i.MX6: Add BTicino i.MX6DL Mamoj initial support
      ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from panel-simple
      ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support
      arm64: dts: allwinner: axp803: Add drivevbus regulator
      arm64: dts: allwinner: a64: bananapi-m64: add usb otg

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: enable hdmi on rk3399-puma-haikou

James Feist (1):
      ARM: dts: aspeed: Add S2600WF BMC Machine

Jeffy Chen (2):
      ARM: dts: rockchip: add clocks in iommu nodes
      arm64: dts: rockchip: add clocks in iommu nodes

Jeremy McNicoll (2):
      arm64: dts: Enable onboard SDHCI on msm8992
      arm64: dts: msm8992: add pstore-ramoops support

Jerome Brunet (10):
      dt-bindings: clock: meson: update documentation with hhi syscon
      ARM64: dts: meson-gx: sysctrl is the parent of the clock controller
      ARM64: dts: meson-axg: use hhi syscon for the clock controller
      ARM64: dts: meson-gx: fix gxl clock controller compatible
      ARM64: dts: meson-axg: add tdm pins
      ARM64: dts: meson: add MMC resets
      ARM64: dts: meson-axg: clean-up i2c nodes
      ARM64: dts: meson-axg: correct i2c AO clock
      ARM64: dts: meson-axg: add i2c AO pins
      ARM64: dts: meson-axg: enable i2c AO on the S400 board

Jisheng Zhang (10):
      arm64: dts: berlin4ct: use SPDX-License-Identifier
      arm64: dts: berlin4ct-*.dts: use SPDX-License-Identifier
      arm64: dts: move berlin SoC files from marvell dir to synaptics dir
      ARM: dts: berlin2q: add interrupt-affinity to pmu node
      ARM: dts: berlin2q: add "cache-unified" to l2 node
      ARM: dts: berlin2q: fix irq type for arm twd timer
      ARM: dts: berlin2: fix irq type for arm twd timer
      ARM: dts: berlin*.dtsi: use SPDX-License-Identifier for berlin SoCs
      ARM: dts: berlin*-dts: use SPDX-License-Identifier for berlin based board
      ARM: dts: berlin2q: move PMU node from soc to root

Joel Stanley (2):
      ARM: dts: aspeed: Describe random number device
      ARM: dts: aspeed: Fix hwrng register address

John Garry (2):
      arm64: dts: hisi: Enable Hisi LPC node for hip06
      arm64: dts: hisi: Enable Hisi LPC node for hip07

Kaihua Zhong (2):
      arm64: dts: hi3660: Add mailbox node
      arm64: dts: hi3660: Add stub clock node

Karthikeyan Ramasubramanian (1):
      dt-bindings: soc: qcom: Add device tree binding for GENI SE

Ken Lin (1):
      ARM: dts: imx: ba16: add "mfg" Q7 SPI-NOR partition

Kevin Hilman (1):
      Merge tag 'for-kevin-meson-clk-bindings-v4.18-1' of https://github.com/BayLibre/clk-meson into v4.18/dt64

Kishon Vijay Abraham I (10):
      ARM: dts: dra72-evm-common: Remove mmc specific pinmux
      ARM: dts: dra71-evm: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra7-mmc-iodelay: Add a new pinctrl group for clk line without pullup
      ARM: dts: am57xx-idk: Use pinctrl group from dra7-mmc-iodelay.dtsi to select pulldown
      ARM: dts: dra71-evm: Use pinctrl group from dra7-mmc-iodelay.dtsi to select pulldown
      ARM: dts: am57xx-beagle-x15/am57xx-idk: Fix pinctrl-names
      ARM: dts: dra7-evm: Model EVM_3V6 regulator
      ARM: dts: dra7: Use sdhci-omap programming model
      ARM: dts: dra7: Add high speed modes capability to MMC1/MMC2 dt node
      Documentation: ARM: Add new MMC requirements for DRA7/K2G

Krzysztof Kozlowski (13):
      ARM: dts: exynos: Move syscon poweroff and restart nodes under the PMU
      arm64: dts: exynos: Move syscon poweroff and restart nodes under the PMU
      ARM: dts: exynos: Fix invalid node referenced by i2c20 alias in Peach Pit and Pi
      arm64: dts: exynos: Remove unneeded address space mapping for soc node
      ARM: dts: exynos: Remove unnecessary address/size properties in Midas boards
      ARM: dts: exynos: Remove unnecessary address/size properties in Origen
      ARM: dts: exynos: Remove regulators node container in Origen and N710x
      ARM: dts: exynos: Bring order in fixed-regulators naming in Midas boards
      ARM: dts: exynos: Remove unnecessary address/size properties in dp-controller of Exynos5
      ARM: dts: exynos: Remove Exynos5440
      ARM: dts: s3c24xx: Remove skeleton.dtsi and fix DTC warning for /memory
      ARM: dts: s3c24xx: Fix unnecessary address/size cells DTC warnings
      ARM: dts: s3c64xx: Remove skeleton.dtsi and fix DTC warnings for /memory

Kunihiko Hayashi (4):
      arm64: dts: uniphier: add clock-names and reset-names to ethernet node
      arm64: dts: uniphier: add syscon-phy-mode property to each ethernet node
      ARM: dts: uniphier: add required clocks and resets to Pro4 ethernet node
      ARM: dts: uniphier: add syscon-phy-mode property to each ethernet node

Lei YU (2):
      ARM: dts: aspeed: romulus: Add id-button gpio key
      ARM: dts: aspeed: zaius: Add pcie-e2b-present gpio key

Leo Yan (1):
      arm64: dts: hi3660: Add CPU frequency scaling support

Lin Huang (1):
      arm64: dts: rockchip: assign clock rate for cpll child clocks on rk3399

Linus Walleij (9):
      ARM: ux500: Drop the U8540 device trees
      ARM: dts: vexpress: Restructure motherboard includes
      ARM: dtd: Set DNS-313 LEDs to use better triggers
      ARM: dts: Set DNS-685 LEDs to use better triggers
      ARM: dts: Fix the DNS-313 flash compatible
      ARM: dts: Fix bootargs for Gemini D-Link devices
      ARM: dts: Add second ATA to NAS4220B
      ARM: dts: Fix DTC warnings
      ARM: dts: Fix the RPM clock controller compatible string

Lionel Debieve (4):
      ARM: dts: stm32: Add RNG support on stm32mp157c
      ARM: dts: stm32: Enable RNG for stm32mp157c-ed1
      ARM: dts: stm32: Add CRYP support on stm32mp157c
      ARM: dts: stm32: Add CRC support on stm32mp157c

Lucas Stach (3):
      ARM: dts: imx6: RDU2: bump SoC/PU operating points by 25mV
      ARM: dts: imx6: RDU2+: add assigned clocks for GPU 3D
      ARM: dts: imx6: RDU2: add eGalax touchscreen

Ludovic Barre (2):
      ARM: dts: stm32: add qspi support for stm32mp157c
      ARM: dts: stm32: add flash nor support on stm32mp157c eval board

Lukasz Majewski (1):
      ARM: dts: tpc: Device tree description of the iMX6Q TPC board

Mahesh Sivasubramanian (1):
      dt-bindings: introduce Command DB for QCOM SoCs

Marcel Ziswiler (1):
      ARM: tegra: apalis-tk1: Fix high speed UART compatible

Marek Szyprowski (4):
      ARM: dts: exynos: Add support for USB OTG port on Origen board
      ARM: dts: exynos: Add serial path for Rinato board to get earlycon support
      ARM: dts: exynos: Remove obsolete clock properties from power domains
      arm64: dts: exynos: Add more clocks to Exynos5433 Decon/DeconTV

Marek Vasut (1):
      ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and PDK2

Mark Kettenis (1):
      arm64: dts: marvell: mark CP110 ahci as dma-coherent

Martin Blumenstingl (11):
      ARM: dts: meson8: add the cortex-a9-pmu compatible PMU
      ARM: dts: meson8b: add the cortex-a5-pmu compatible PMU
      dt-bindings: arm: amlogic: add support for the Meson8m2 SoC
      dt-bindings: arm: amlogic: add support for the Tronsmart MXIII Plus
      ARM: dts: meson8b: odroid-c1: sort nodes alphabetically
      ARM: dts: meson8b: odroid-c1: enable the IR receiver
      ARM: meson: add support for the Meson8m2 SoCs
      ARM: dts: meson: add support for the Meson8m2 SoC
      ARM: dts: meson8: add the uart_A pins
      ARM: dts: meson: build the Meson8b .dtbs with MACH_MESON8
      ARM: meson: merge Kconfig symbol MACH_MESON8B into MACH_MESON8

Mathieu Malaterre (1):
      ARM: dts: exynos/s3c: Remove leading 0x and 0s from bindings notation

Matt Porter (1):
      ARM: dts: hummingboard: convert onboard audio to simple-audio-card

Maxime Ripard (1):
      ARM: dts: sun8i: a33: Add the DSI-related nodes

Miquel Raynal (6):
      ARM: dts: sun8i: a23/a33: declare NAND pins
      ARM: dts: nes: add Nintendo NES/SuperNES Classic Edition support
      ARM: dts: armada-370-xp: update NAND node with new bindings
      ARM: dts: armada-375: update NAND node with new bindings
      ARM: dts: armada-38x: update NAND node with new bindings
      ARM: dts: armada-39x: update NAND node with new bindings

Mylène Josserand (4):
      ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
      ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
      ARM: dts: sun8i: a83t: Add CCI-400 node
      ARM: dts: sun8i: Add enable-method for SMP support for the A83T SoC

Nan Li (1):
      ARM64: dts: meson-axg: enable the eMMC controller

Neil Armstrong (2):
      arm: dts: sun8i: h3: libretech-all-h3-cc: Move board definition to common dtsi
      arm64: dts: allwinner: Add dts file for Libre Computer Board ALL-H3-CC H5 ver.

Nikita Yushchenko (3):
      ARM: dts: imx51-zii-rdu1: limit usbh1 to full-speed
      ARM: dts: vf610-zii-dev: enable vf610 builtin temp sensor
      ARM: dts: imx51-zii-rdu1: cleanup eMMC node

Niklas Cassel (2):
      ARM: dts: qcom-apq8064: use correct pci address for address translation
      arm64: dts: fix regulator property name for wlan pcie endpoint

Oleg Ivanov (1):
      ARM: dts: meson8m2: add support for the Tronsmart MXIII Plus

Olof Johansson (47):
      Merge tag 'ux500-dts-arm-soc' of git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      Merge tag 'stm32-dt-for-v4.18-1' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'omap-for-v4.18/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'keystone_dts_for_4.18' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'omap-for-v4.18/dt-sdhci-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'arm-soc/for-4.18/devicetree' of https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'gemini-dts-arm-soc' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'samsung-dt-4.18' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.18' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'v4.17-next-dts32' of https://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'v4.17-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'sti-dt-for-v4.18-round1' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'vexpress-updates-4.18' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'juno-updates-4.18' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'v4.18-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.18-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'hisi-arm64-dt-for-4.18v2' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'amlogic-dt' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'amlogic-dt64' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'davinci-for-v4.18/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'tegra-for-4.18-dt-bindings' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.18-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'mvebu-dt-4.18-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt64-4.18-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'uniphier-dt-v4.18' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'uniphier-dt64-v4.18' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'imx-dt-4.18' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt64-4.18' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'sunxi-dt-for-4.18' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-h3-h5-for-4.18' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.18' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'omap-for-v4.18/dt-part2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'qcom-arm64-for-4.18' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'qcom-dts-for-4.18' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'amlogic-dt-2' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'amlogic-dt64-2' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'amlogic-dt64-3' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'berlin64-dt-for-v4.18' of git://git.kernel.org/.../jszhang/linux-berlin into next/dt
      Merge tag 'berlin-dt-for-v4.18' of git://git.kernel.org/.../jszhang/linux-berlin into next/dt
      Merge tag 'samsung-dt-4.18-2' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.18-2' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'aspeed-4.18-devicetree' of git://git.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'at91-ab-4.18-dt' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'qcom-arm64-for-4.18-2' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'qcom-dts-for-4.18-2' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'renesas-dt-bindings-for-v4.18' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'pxa-dt-4.18' of https://github.com/rjarzmik/linux into next/dt

Ondrej Jirman (3):
      ARM: dts: sunxi: h3/h5: Add r_i2c pinmux node
      ARM: dts: sunxi: h3/h5: Add r_i2c I2C controller
      ARM: dts: sun8i: h3: Add SY8106A regulator to Orange Pi PC

Patrice Chotard (5):
      ARM: dts: stih407-family: Fix complain about IRQ_TYPE_NONE usage
      ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage
      ARM: dts: stih407: Fix complain about IRQ_TYPE_NONE usage
      ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
      ARM: dts: stihxxx-b2120: Fix complain about IRQ_TYPE_NONE usage

Peter Ujfalusi (12):
      ARM: dts: omap3-beagle-xm: Add fixed 26MHz clock as fck for twl
      ARM: dts: am437x-gp-evm: Correct tps65218 irq type
      ARM: dts: am437x-cm-t43: Correct tps65218 irq type
      ARM: dts: am437x-epos-evm: Correct tps65218 irq type
      ARM: dts: am437x-sk-evm: Correct tps65218 irq type
      ARM: dts: omap2420-n810: Enable McBSP2 for audio
      ARM: dts: omap2420-n810: Correct the audio codec (tlv320aic33) node
      ARM: dts: am335x-evmsk: Add phandle for the backlight for the panel
      ARM: dts: am437x-gp-evm: Fixup (again) tps65218 irq type
      ARM: dts: am437x-cm-t43: Fixup (again) tps65218 irq type
      ARM: dts: am437x-epos-evm: Fixup (again) tps65218 irq type
      Revert "ARM: dts: am437x-sk-evm: Correct tps65218 irq type"

Philippe CORNU (1):
      ARM: dts: stm32: Add display support on stm32f469-disco

Philippe Cornu (2):
      ARM: dts: stm32: Use gpio bindings in stm32f469-disco
      ARM: dts: stm32: Add new stm32f469 dtsi file with mipi dsi

Pierre-Yves MORDRET (12):
      ARM: dts: stm32: Add DMAv2 support on STM32MP157C
      ARM: dts: stm32: Add DMAMUX support on STM32MP157C
      ARM: dts: stm32: Add MDMA support on STM32MP157C
      ARM: dts: stm32: Add STM32F7 I2C support for STM32MP157C SoC
      ARM: dts: stm32: Add I2Cs pins used on STM32MP157C
      ARM: dts: stm32: Add I2C4 support for STM32MP157C-ED1
      ARM: dts: stm32: Add I2C2/5 support for STM32MP157C-EV1
      ARM: dts: stm32: Append additional I2Cs for STM32F746 SoC
      ARM: dts: stm32: Add I2C1 support for stm32f769-disco Board
      ARM: dts: stm32: Add I2C1 support for stm32f746-disco Board
      ARM: dts: stm32: Add I2C support for STM32H743 SoC
      ARM: dts: stm32: Add I2C1 support for stm32h743i-eval Board

Qiufang Dai (1):
      ARM64: dts: meson-axg: add AO clock driver

Rafał Miłecki (5):
      ARM: dts: BCM5301X: Switch Luxul XWC-1000 to the new fixed partitions syntax
      ARM: dts: BCM5301X: Relicense most DTS files to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Relicense Buffalo files to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Relicense Asus RT-AC87U file to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Switch D-Link DIR-885L to the new partitions syntax

Rajendra Nayak (1):
      arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP

Rob Herring (8):
      arm64: dts: juno: fix missing Coresight STM graph connection
      arm64: dts: juno: fix OF graph endpoint node names
      ARM: dts: imx: fix IPU OF graph endpoint node names
      ARM: dts: imx53: Fix LDB OF graph warning
      ARM: dts: imx7: Fix error in coresight TPIU graph connection
      ARM: dts: omap: fix OF graph in omap3-devkit8000
      ARM: dts: omap: fix OMAP3 CM-T3x OF graph video connectors
      arm64: dts: sprd: fix typo in 'remote-endpoint'

Robert Nelson (1):
      ARM: dts: Add am335x-pocketbeagle

Russell King (1):
      arm64: dts: marvell: mcbin: add 10G SFP support

Ryder Lee (2):
      arm: dts: mediatek: modify audio related nodes for both MT2701 and MT7623
      arm64: dts: mt7622: add audio related device nodes

Sean Wang (11):
      arm: dts: mediatek: converted to using SPDX identifiers
      arm: dts: mt7623: fix invalid memory node being generated
      arm: dts: mt7623: fix available memory size on bananapi-r2
      arm: dts: mt7623: fix all Warnings (unit_address_vs_reg)
      arm: dts: mt7623: add BTIF, HSDMA and SPI-NOR device nodes
      arm: dts: mt6323: move node mt6323 leds to mt6323.dtsi
      arm: dts: mt7623: extend common file reused by all boards with MT7623 SoCs
      arm: dts: mt7623: add MT7623A SoC level DTS
      arm: dts: mt7623: add MT7623A reference boards
      arm: dts: mt7623: add MT7623N reference board with eMMC
      arm64: dts: mt7622: add High-Speed DMA device nodes

Sebastian Reichel (1):
      ARM: dts: imx53-ppd: Use IRQ_TYPE_* constants

Sekhar Nori (1):
      ARM: dts: am574x-idk: Add pinmux configuration for MMC

Sergei Shtylyov (1):
      dt-bindings: arm: document Renesas V3HSK board bindings

Shawn Guo (10):
      ARM: dts: imx6sx-sabreauto: drop 'regulators' container node
      ARM: dts: imx6sx-sabreauto: drop board specific pinctrl container node
      ARM: dts: imx: drop unnecessary #address-cells/#size-cells
      ARM: dts: imx1: move clk32 clock into soc dtsi
      ARM: dts: imx27: use label to override osc26m clock setting
      ARM: dts: imx: drop 'clocks' container for board level clocks
      ARM: dts: imx: replace underscore with hyphen in aliases name
      arm64: dts: hi3798cv200: enable PCIe support for poplar board
      arm64: dts: hi3798cv200: enable usb2 support for poplar board
      arm64: dts: hi3798cv200: enable emmc support for poplar board

Shengjiu Wang (1):
      ARM: dts: imx7d-pinfunc: update sai select input value

Sibi S (2):
      arm64: dts: qcom: Add APSS shared mailbox node to SDM845
      arm64: dts: qcom: Add SDM845 SMEM nodes

Simon Horman (1):
      dt-bindings: arm: consistently name r8a77965 as M3-N

Sricharan R (12):
      ARM: dts: ipq4019: Add a default chosen node
      ARM: dts: ipq4019: Add a few peripheral nodes
      ARM: dts: ipq4019: Change the max opp frequency
      ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
      ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board file
      ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3 board file
      ARM: dts: ipq4019: Add ipq4019-ap.dk07.1 common data
      ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c1 board file
      ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2 board file
      ARM: dts: ipq8074: Add peripheral nodes
      ARM: dts: ipq8074: Add pcie nodes
      ARM: dts: ipq8074: Enable few peripherals for hk01 board

Srinivas Kandagatla (4):
      ARM: dts: qcom-apq8064: disable i2c by default at soc dtsi
      arm64: dts: apq8096-db820c: Enable wlan and bt en pins
      arm64: dts: apq8096-db820c: Add micro sd card supplies
      arm64: dts: msm8916: fix gic_irq_domain_translate warnings

Stefan Mavrodiev (1):
      ARM: dts: sun7i: Add Olimex A20-SOM-EVB-eMMC board

Stefan Wahren (8):
      dt-binding: rng: Add interrupt property for BCM2835
      ARM: bcm283x: Add missing interrupt for RNG block
      ARM: dts: bcm283x: Fix PWM pin assignment
      ARM: dts: bcm2837: Add missing GPIOs of Expander
      dt-bindings: bcm: Add Raspberry Pi 3 B+
      ARM: dts: bcm2837: Add Raspberry Pi 3 B+
      arm64: dts: broadcom: Add reference to Raspberry Pi 3 B+
      ARM: dts: imx6ull: add UART5 RTS input select register

Sudeep Holla (5):
      arm64: dts: juno: Fix "debounce-interval" property misspelling
      arm64: dts: juno: replace '_' with '-' in node names
      arm64: dts: juno/rtsm: re-structure motherboard includes
      ARM: dts: vexpress: use standard gpio bindings for sys_{led,mci,flash}
      ARM: dts: vexpress: replace '_' with '-' in node names

Sven Eckelmann (1):
      ARM: dts: ipq4019: Add TZ and SMEM reserved regions

Sylwester Nawrocki (1):
      ARM: dts: exynos: Add support for audio over HDMI for Odroid X/X2/U3

Tao Wang (1):
      arm64: dts: hi3660: Add thermal cooling management

Thierry Escande (5):
      ARM: dts: qcom-apq8064: fix gic_irq_domain_translate warnings
      arm64: dts: apq8096-db820c: enable bluetooth node
      dt-bindings: net: bluetooth: Add qualcomm-bluetooth
      arm64: dts: msm8996: fix gic_irq_domain_translate warnings
      arm64: dts: apq8096-db820c: Removed bt-en-1-8v regulator

Thierry Reding (1):
      dt-bindings: Relocate Tegra20 memory controller bindings

Thomas Hebb (2):
      ARM: dts: chromecast: override bad bootloader memory info
      ARM: dts: chromecast: use PWM for LEDs

Tony Lindgren (1):
      Merge branch 'omap-for-v4.18/dt-fixes' into omap-for-v4.18/dt

Tuomas Tynkkynen (1):
      ARM: dts: sunxi: Change sun7i-a20-olimex-som204-evb to not use cd-inverted

Uwe Kleine-König (1):
      arm64: dts: marvell: armada-37xx: mark the gpio controllers as irq controller

Vicente Bergas (2):
      arm64: dts: rockchip: move rk3399-sapphire PCIe to excavator baseboard
      arm64: dts: rockchip: remove PCIe assigned-clocks in excavator baseboard

Vishal Mahaveer (1):
      ARM: dts: dra76-evm: Add wilink8 wlan support

Yao Chen (1):
      arm64: dts: hi3660: Add pcie msi interrupt attribute

Yixun Lan (4):
      ARM64: dts: meson-axg: add GPIO interrupt controller support
      ARM64: dts: meson-axg: add an 32K alt aoclk
      ARM64: dts: meson-axg: enable AP6255 wifi module
      ARM64: dts: meson: fix clock source of the pclk for UART_AO

Yoshihiro Shimoda (2):
      dt-bindings: arm: Document R-Car E3 SoC DT bindings
      dt-bindings: arm: Document Renesas Ebisu board DT bindings

Zhiyong Tao (2):
      arm64: dts: mt2712: add pintcrl file
      arm64: dts: mt2712: add pintcrl device node.

kevans@FreeBSD.org (1):
      ARM: dts: sunxi: Add sid for a83t

weiyi.lu@mediatek.com (1):
      arm64: dts: add clock device nodes of MT2712

yannick fertre (5):
      ARM: dts: stm32: add ltdc support on stm32mp157c
      ARM: dts: stm32: add dsi support on stm32mp157c
      ARM: dts: stm32: add cec support on stm32mp157c
      ARM: dts: stm32: add cec pins to stm32mp157c
      ARM: dts: stm32: add cec support on stm32mp157c-ev1


 Documentation/arm/OMAP/README                   |    4 +
 .../devicetree/bindings/arm/amlogic.txt         |    6 +
 .../bindings/arm/bcm/brcm,bcm2835.txt           |    4 +
 .../bindings/arm/samsung/samsung-boards.txt     |    2 -
 .../devicetree/bindings/arm/shmobile.txt        |   10 +-
 .../bindings/arm/tegra/nvidia,tegra30-mc.txt    |   18 -
 .../bindings/clock/amlogic,gxbb-clkc.txt        |   16 +-
 .../memory-controllers/nvidia,tegra20-mc.txt    |   12 +-
 .../memory-controllers/nvidia,tegra30-mc.txt    |    5 +
 .../bindings/nvmem/allwinner,sunxi-sid.txt      |    1 +
 .../bindings/reserved-memory/qcom,cmd-db.txt    |   37 +
 .../devicetree/bindings/rng/brcm,bcm2835.txt    |    9 +-
 .../bindings/soc/qcom/qcom,geni-se.txt          |  119 ++
 .../devicetree/bindings/timer/renesas,cmt.txt   |   14 +-
 .../devicetree/bindings/vendor-prefixes.txt     |    2 +
 arch/arm/boot/dts/Makefile                      |   40 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts      |    2 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |    2 +-
 arch/arm/boot/dts/am335x-baltos.dtsi            |    2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi       |    9 +-
 arch/arm/boot/dts/am335x-boneblue.dts           |    2 +-
 arch/arm/boot/dts/am335x-evm.dts                |    9 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |   12 +-
 arch/arm/boot/dts/am335x-osd335x-common.dtsi    |  124 ++
 arch/arm/boot/dts/am335x-pocketbeagle.dts       |  237 ++++
 arch/arm/boot/dts/am3517-evm.dts                |  233 +++-
 arch/arm/boot/dts/am3517-som.dtsi               |  142 +++
 arch/arm/boot/dts/am437x-cm-t43.dts             |    2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |    2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts             |  115 ++
 arch/arm/boot/dts/am43x-epos-evm.dts            |    2 +-
 arch/arm/boot/dts/am571x-idk.dts                |    5 +-
 arch/arm/boot/dts/am572x-idk.dts                |    5 +-
 arch/arm/boot/dts/am574x-idk.dts                |   20 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |    4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |    3 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |   14 +-
 arch/arm/boot/dts/armada-370-db.dts             |   57 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts  |  120 +-
 arch/arm/boot/dts/armada-370-mirabox.dts        |   51 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts  |   90 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts  |   90 +-
 arch/arm/boot/dts/armada-370-rd.dts             |   52 +-
 .../boot/dts/armada-370-seagate-nas-xbay.dtsi   |   64 +-
 arch/arm/boot/dts/armada-370-xp.dtsi            |    6 +-
 arch/arm/boot/dts/armada-375-db.dts             |   50 +-
 arch/arm/boot/dts/armada-375.dtsi               |    6 +-
 arch/arm/boot/dts/armada-385-db-ap.dts          |   69 +-
 arch/arm/boot/dts/armada-385-linksys-caiman.dts |  129 +-
 arch/arm/boot/dts/armada-385-linksys-cobra.dts  |  129 +-
 arch/arm/boot/dts/armada-385-linksys-rango.dts  |  141 +--
 arch/arm/boot/dts/armada-385-linksys-shelby.dts |  129 +-
 arch/arm/boot/dts/armada-385-linksys.dtsi       |   16 +-
 arch/arm/boot/dts/armada-388-db.dts             |   55 +-
 arch/arm/boot/dts/armada-38x.dtsi               |    6 +-
 arch/arm/boot/dts/armada-390-db.dts             |   66 +-
 arch/arm/boot/dts/armada-395-gp.dts             |   74 +-
 arch/arm/boot/dts/armada-398-db.dts             |   60 +-
 arch/arm/boot/dts/armada-39x.dtsi               |    6 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi       |   13 +
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts        |    2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts   |    2 +-
 arch/arm/boot/dts/armada-xp-db.dts              |    2 +-
 arch/arm/boot/dts/armada-xp-gp.dts              |    2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |    2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts   |  156 +--
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts  |   90 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts        |   18 +
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts  |  129 ++
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts    |  325 +++++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |    6 +
 .../arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |   32 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts      |    6 +
 .../boot/dts/aspeed-bmc-portwell-neptune.dts    |  159 +++
 arch/arm/boot/dts/aspeed-g4.dtsi                |   35 +
 arch/arm/boot/dts/aspeed-g5.dtsi                |   47 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |    2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts            |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts        |    6 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts             |    6 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts        |    6 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts        |    6 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts             |    6 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |    6 -
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts           |    6 +
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts      |  108 ++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts           |   26 +-
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi      |   27 +
 arch/arm/boot/dts/bcm283x.dtsi                  |    1 +
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts     |   13 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts     |   13 +-
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |    3 +-
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts |    3 +-
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts    |    3 +-
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts    |   15 +-
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts  |   13 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |    3 +-
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts     |   13 +-
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |   13 +-
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts    |   13 +-
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts   |    3 +-
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts   |    3 +-
 .../boot/dts/bcm47081-tplink-archer-c5-v2.dts   |    3 +-
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts     |   13 +-
 .../boot/dts/bcm4709-buffalo-wxr-1900dhp.dts    |    3 +-
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts    |    3 +-
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts     |   13 +-
 .../boot/dts/bcm4709-tplink-archer-c9-v1.dts    |    3 +-
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts   |   25 +-
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts |    3 +-
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts   |    3 +-
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts   |   57 +
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts   |    3 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts   |    3 +-
 .../arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts |   77 ++
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts    |    3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch1.dtsi   |    3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi   |    3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch8.dtsi   |    3 +-
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi        |    3 +-
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts      |   33 +-
 arch/arm/boot/dts/berlin2.dtsi                  |   35 +-
 .../boot/dts/berlin2cd-google-chromecast.dts    |   65 +-
 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts |   79 ++
 arch/arm/boot/dts/berlin2cd.dtsi                |  167 ++-
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts      |   33 +-
 arch/arm/boot/dts/berlin2q.dtsi                 |   65 +-
 arch/arm/boot/dts/da850-evm.dts                 |  298 ++---
 arch/arm/boot/dts/da850-lego-ev3.dts            |   83 +-
 arch/arm/boot/dts/da850.dtsi                    |  154 +++
 arch/arm/boot/dts/dm8148-t410.dts               |    2 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi          |   15 +
 arch/arm/boot/dts/dra7-evm.dts                  |   68 ++
 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi         |   19 +
 arch/arm/boot/dts/dra7.dtsi                     |   32 +-
 arch/arm/boot/dts/dra71-evm.dts                 |   17 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   71 +-
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi       |   11 +
 arch/arm/boot/dts/dra76-evm.dts                 |   34 +-
 arch/arm/boot/dts/exynos-syscon-restart.dtsi    |   28 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |    4 +
 arch/arm/boot/dts/exynos3250.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |   34 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi     |   36 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi         |   86 +-
 arch/arm/boot/dts/exynos4412-n710x.dts          |   16 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   33 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |    6 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |    6 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |    2 +-
 arch/arm/boot/dts/exynos4412.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5.dtsi                  |    3 -
 arch/arm/boot/dts/exynos5250.dtsi               |    7 +-
 arch/arm/boot/dts/exynos5410.dtsi               |    1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |    4 +-
 arch/arm/boot/dts/exynos5420.dtsi               |   87 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |    2 +-
 arch/arm/boot/dts/exynos5440-sd5v1.dts          |   42 -
 arch/arm/boot/dts/exynos5440-ssdk5440.dts       |   81 --
 .../boot/dts/exynos5440-tmu-sensor-conf.dtsi    |   20 -
 arch/arm/boot/dts/exynos5440-trip-points.dtsi   |   21 -
 arch/arm/boot/dts/exynos5440.dtsi               |  355 ------
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |    4 +-
 arch/arm/boot/dts/gemini-dlink-dir-685.dts      |   16 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts      |   19 +-
 arch/arm/boot/dts/gemini-nas4220b.dts           |   20 +-
 arch/arm/boot/dts/gemini-rut1xx.dts             |   12 +-
 arch/arm/boot/dts/gemini-sq201.dts              |   12 +-
 arch/arm/boot/dts/gemini-wbd111.dts             |   17 +-
 arch/arm/boot/dts/gemini-wbd222.dts             |   16 +-
 arch/arm/boot/dts/gemini.dtsi                   |    2 -
 arch/arm/boot/dts/imx1-ads.dts                  |   11 -
 arch/arm/boot/dts/imx1.dtsi                     |   21 +-
 arch/arm/boot/dts/imx23-evk.dts                 |   13 +-
 arch/arm/boot/dts/imx23.dtsi                    |   13 +-
 arch/arm/boot/dts/imx25-pdk.dts                 |   14 +-
 arch/arm/boot/dts/imx25.dtsi                    |   16 +-
 arch/arm/boot/dts/imx27-apf27.dts               |   13 +-
 arch/arm/boot/dts/imx27-pdk.dts                 |   13 +-
 arch/arm/boot/dts/imx27.dtsi                    |   18 +-
 arch/arm/boot/dts/imx28-cfa10049.dts            |    2 -
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts  |    2 -
 arch/arm/boot/dts/imx28-evk.dts                 |   13 +-
 arch/arm/boot/dts/imx28-tx28.dts                |   14 +-
 arch/arm/boot/dts/imx28.dtsi                    |   13 +-
 arch/arm/boot/dts/imx31.dtsi                    |   13 +-
 arch/arm/boot/dts/imx35-pdk.dts                 |   15 +-
 arch/arm/boot/dts/imx35.dtsi                    |   14 +-
 arch/arm/boot/dts/imx50-evk.dts                 |   17 +-
 arch/arm/boot/dts/imx50.dtsi                    |    3 -
 arch/arm/boot/dts/imx51-babbage.dts             |   15 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts            |    6 +-
 arch/arm/boot/dts/imx51.dtsi                    |   18 +-
 arch/arm/boot/dts/imx53-ard.dts                 |   11 +-
 arch/arm/boot/dts/imx53-m53.dtsi                |    2 -
 arch/arm/boot/dts/imx53-ppd.dts                 |   12 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi         |   15 +-
 arch/arm/boot/dts/imx53-qsb.dts                 |   17 +-
 arch/arm/boot/dts/imx53-qsrb.dts                |   15 +-
 arch/arm/boot/dts/imx53-smd.dts                 |   20 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts           |    1 +
 arch/arm/boot/dts/imx53-tx53.dtsi               |   14 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi     |    2 +-
 arch/arm/boot/dts/imx53.dtsi                    |   11 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts    |    2 -
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts    |   15 +-
 arch/arm/boot/dts/imx6dl-mamoj.dts              |  224 ++++
 arch/arm/boot/dts/imx6dl-sabreauto.dts          |   10 +-
 arch/arm/boot/dts/imx6dl-sabresd.dts            |   10 +-
 arch/arm/boot/dts/imx6dl-udoo.dts               |    6 +-
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts    |    6 +-
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts    |    6 +-
 arch/arm/boot/dts/imx6dl-wandboard.dts          |    6 +-
 arch/arm/boot/dts/imx6dl.dtsi                   |   12 +-
 arch/arm/boot/dts/imx6q-b850v3.dts              |    4 -
 arch/arm/boot/dts/imx6q-ba16.dtsi               |    7 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi             |   13 +-
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts          |  151 +++
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi          |  476 ++++++++
 arch/arm/boot/dts/imx6q-gk802.dts               |    3 +-
 arch/arm/boot/dts/imx6q-icore-mipi.dts          |   25 +
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts       |   31 +-
 arch/arm/boot/dts/imx6q-kp-tpc.dts              |   22 +
 arch/arm/boot/dts/imx6q-kp.dtsi                 |  432 +++++++
 arch/arm/boot/dts/imx6q-novena.dts              |    2 -
 arch/arm/boot/dts/imx6q-pistachio.dts           |    2 +-
 arch/arm/boot/dts/imx6q-sabreauto.dts           |   15 +-
 arch/arm/boot/dts/imx6q-sabresd.dts             |   15 +-
 arch/arm/boot/dts/imx6q-udoo.dts                |    6 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts         |    2 -
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts  |    2 -
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts     |    6 +-
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts     |    6 +-
 arch/arm/boot/dts/imx6q-wandboard.dts           |    6 +-
 arch/arm/boot/dts/imx6q.dtsi                    |   39 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |    2 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi          |    2 -
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi           |    2 -
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi     |   52 +-
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi    |   47 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi            |   25 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi    |    2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |   15 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |    3 -
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |   18 +-
 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi          |    1 -
 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi          |    3 -
 arch/arm/boot/dts/imx6qdl-tx6.dtsi              |    6 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi             |    6 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi  |    1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi  |    1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi  |    1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |   14 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         |   24 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |   70 +-
 arch/arm/boot/dts/imx6qp-sabreauto.dts          |   44 +-
 arch/arm/boot/dts/imx6qp-sabresd.dts            |   44 +-
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts    |    6 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts           |    5 +
 arch/arm/boot/dts/imx6qp.dtsi                   |   44 +-
 arch/arm/boot/dts/imx6sl-evk.dts                |   10 +-
 arch/arm/boot/dts/imx6sl.dtsi                   |   34 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts        |    4 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts          |  427 +++++--
 arch/arm/boot/dts/imx6sx.dtsi                   |  101 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts          |   10 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi             |    2 -
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts    |    2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi             |    6 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |   51 +-
 arch/arm/boot/dts/imx6ull-pinfunc.h             |    9 +
 arch/arm/boot/dts/imx6ull.dtsi                  |    2 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts         |    2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts           |    6 +-
 arch/arm/boot/dts/imx7d-pinfunc.h               |    6 +-
 arch/arm/boot/dts/imx7d-sdb-sht11.dts           |   44 +-
 arch/arm/boot/dts/imx7d-sdb.dts                 |   70 +-
 arch/arm/boot/dts/imx7d.dtsi                    |   71 +-
 arch/arm/boot/dts/imx7s-warp.dts                |    4 -
 arch/arm/boot/dts/imx7s.dtsi                    |   88 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts          |   26 +
 arch/arm/boot/dts/logicpd-som-lv.dtsi           |   34 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi      |   10 +
 arch/arm/boot/dts/meson8.dtsi                   |   33 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts          |   68 +-
 arch/arm/boot/dts/meson8b.dtsi                  |   24 +-
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts       |  244 ++++
 arch/arm/boot/dts/meson8m2.dtsi                 |   54 +
 arch/arm/boot/dts/mt2701-evb.dts                |    9 +-
 arch/arm/boot/dts/mt2701.dtsi                   |  197 ++-
 arch/arm/boot/dts/mt6323.dtsi                   |   17 +-
 arch/arm/boot/dts/mt6580-evbp1.dts              |    9 +-
 arch/arm/boot/dts/mt6580.dtsi                   |    9 +-
 arch/arm/boot/dts/mt6589-aquaris5.dts           |   10 +-
 arch/arm/boot/dts/mt6589.dtsi                   |   12 +-
 arch/arm/boot/dts/mt6592-evb.dts                |    9 +-
 arch/arm/boot/dts/mt6592.dtsi                   |    9 +-
 arch/arm/boot/dts/mt7623.dtsi                   |  537 +++++++--
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts          |  291 +++++
 arch/arm/boot/dts/mt7623a-rfb-nand.dts          |  337 ++++++
 arch/arm/boot/dts/mt7623a.dtsi                  |   44 +
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts   |  279 +----
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts          |  326 +++++
 arch/arm/boot/dts/mt7623n-rfb-nand.dts          |   40 +-
 arch/arm/boot/dts/mt7623n-rfb.dtsi              |   12 +-
 arch/arm/boot/dts/mt8127-moose.dts              |    9 +-
 arch/arm/boot/dts/mt8127.dtsi                   |    9 +-
 arch/arm/boot/dts/mt8135-evbp1.dts              |    9 +-
 arch/arm/boot/dts/mt8135.dtsi                   |    9 +-
 arch/arm/boot/dts/omap2420-n810.dts             |   63 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts           |   10 +
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |    2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi  |    9 +-
 .../boot/dts/omap3-devkit8000-lcd-common.dtsi   |    5 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |   10 +
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |   12 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi             |    2 +-
 arch/arm/boot/dts/pxa3xx.dtsi                   |   20 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi             |   58 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi   |   10 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts |   19 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts |    9 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   |  111 ++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts |   64 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts |   25 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi   |   75 ++
 arch/arm/boot/dts/qcom-ipq4019.dtsi             |  178 ++-
 arch/arm/boot/dts/qcom-msm8660.dtsi             |    2 +-
 .../boot/dts/qcom-msm8974-sony-xperia-amami.dts |  436 +++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi              |    6 +
 arch/arm/boot/dts/rk3036.dtsi                   |    2 +
 arch/arm/boot/dts/rk322x.dtsi                   |    8 +
 arch/arm/boot/dts/rk3288-phycore-som.dtsi       |    1 +
 arch/arm/boot/dts/rk3288-tinker.dts             |    4 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |    3 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |    2 +
 arch/arm/boot/dts/rk3288.dtsi                   |   20 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts          |    5 +-
 arch/arm/boot/dts/s3c2416.dtsi                  |   11 +-
 arch/arm/boot/dts/s3c24xx.dtsi                  |    4 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts          |    3 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts          |    3 +-
 arch/arm/boot/dts/s3c64xx.dtsi                  |    4 +-
 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi      |  196 ---
 arch/arm/boot/dts/ste-ccu8540.dts               |   94 --
 arch/arm/boot/dts/ste-ccu9540.dts               |   79 --
 arch/arm/boot/dts/ste-snowball.dts              |   10 +-
 arch/arm/boot/dts/stih407-family.dtsi           |   52 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi          |   10 +-
 arch/arm/boot/dts/stih407.dtsi                  |    2 +-
 arch/arm/boot/dts/stih410.dtsi                  |   18 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi            |    4 +-
 arch/arm/boot/dts/stm32f469-disco.dts           |   53 +-
 arch/arm/boot/dts/stm32f469.dtsi                |   19 +
 arch/arm/boot/dts/stm32f746-disco.dts           |    8 +
 arch/arm/boot/dts/stm32f746.dtsi                |   36 +
 arch/arm/boot/dts/stm32f769-disco.dts           |    8 +
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi        |   10 +
 arch/arm/boot/dts/stm32h743.dtsi                |   53 +
 arch/arm/boot/dts/stm32h743i-eval.dts           |    8 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi       |  151 ++-
 arch/arm/boot/dts/stm32mp157c-ed1.dts           |   57 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts           |   87 ++
 arch/arm/boot/dts/stm32mp157c.dtsi              |  720 ++++++++++-
 .../boot/dts/sun7i-a20-olimex-som-evb-emmc.dts  |   37 +
 .../boot/dts/sun7i-a20-olimex-som204-evb.dts    |    3 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   33 +
 arch/arm/boot/dts/sun8i-a33.dtsi                |   44 +
 arch/arm/boot/dts/sun8i-a83t.dtsi               |   64 +
 .../dts/sun8i-h2-plus-libretech-all-h3-cc.dts   |   13 +
 .../boot/dts/sun8i-h2-plus-orangepi-zero.dts    |   21 +
 .../boot/dts/sun8i-h3-libretech-all-h3-cc.dts   |  206 +---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     |   21 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      |   28 +
 arch/arm/boot/dts/sun8i-h3.dtsi                 |   32 +-
 .../boot/dts/sun8i-r16-nintendo-nes-classic.dts |   56 +
 .../sun8i-r16-nintendo-super-nes-classic.dts    |   11 +
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts    |   99 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                |   34 +
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts    |   10 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              |   18 +
 .../arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi |  215 ++++
 arch/arm/boot/dts/tegra114.dtsi                 |    5 +
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     |    6 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi          |    6 +-
 arch/arm/boot/dts/tegra30.dtsi                  |   14 +
 arch/arm/boot/dts/uniphier-pro4.dtsi            |   10 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |    3 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi         |  712 +++++------
 arch/arm/boot/dts/vexpress-v2m.dtsi             |  710 +++++------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts     |    3 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts      |    9 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts         |    5 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts          |    5 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi       |    2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts       |    6 -
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts       |    4 -
 arch/arm/boot/dts/vf610-zii-dev.dtsi            |    4 +
 arch/arm/boot/dts/vfxxx.dtsi                    |    2 +-
 arch/arm/mach-meson/Kconfig                     |    9 +-
 arch/arm/mach-meson/meson.c                     |    1 +
 arch/arm64/boot/dts/Makefile                    |    1 +
 arch/arm64/boot/dts/allwinner/Makefile          |    5 +-
 arch/arm64/boot/dts/allwinner/axp803.dtsi       |    5 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts   |   21 +
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts |   14 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |    2 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   |   10 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |   70 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts  |  106 ++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi      |  453 ++++++-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     |   12 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      |   16 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi          |   15 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi   |   18 +-
 arch/arm64/boot/dts/arm/juno-r1.dts             |    8 +-
 arch/arm64/boot/dts/arm/juno-r2.dts             |    8 +-
 arch/arm64/boot/dts/arm/juno.dts                |    4 +-
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts      |    4 +-
 .../arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi |  453 +++----
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts   |    5 +-
 arch/arm64/boot/dts/broadcom/Makefile           |    3 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts  |    2 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   80 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |   18 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |   10 +-
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi     |    2 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |  147 +++
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts   |   38 +
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi  |  205 +++-
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts     |    8 +
 arch/arm64/boot/dts/hisilicon/hip06.dtsi        |   21 +
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts     |    4 +
 arch/arm64/boot/dts/hisilicon/hip07.dtsi        |   14 +
 .../boot/dts/hisilicon/poplar-pinctrl.dtsi      |   98 ++
 arch/arm64/boot/dts/marvell/Makefile            |    4 -
 .../dts/marvell/armada-3720-espressobin.dts     |   27 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi    |    6 +
 arch/arm64/boot/dts/marvell/armada-7040-db.dts  |    5 +
 arch/arm64/boot/dts/marvell/armada-8040-db.dts  |   10 +
 .../boot/dts/marvell/armada-8040-mcbin.dts      |   70 ++
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi   |    1 +
 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts   |   66 -
 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts   |   66 -
 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h   | 1123 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi       |   46 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts    |   11 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi        |   99 ++
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi |    2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    |   31 +-
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts       |   62 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi           |  313 ++++-
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |   18 +-
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts  |   17 +
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi      |   60 +
 arch/arm64/boot/dts/qcom/msm8992.dtsi           |   87 +-
 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi   |  276 +++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |  110 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts         |   15 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |  327 +++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |   10 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |   10 +
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts |    8 +
 .../boot/dts/rockchip/rk3399-gru-kevin.dts      |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    |    8 +-
 .../boot/dts/rockchip/rk3399-puma-haikou.dts    |   25 +
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi   |    4 +
 .../dts/rockchip/rk3399-sapphire-excavator.dts  |   12 +
 .../boot/dts/rockchip/rk3399-sapphire.dtsi      |   23 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |   36 +-
 .../arm64/boot/dts/socionext/uniphier-ld11.dtsi |    5 +-
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |    3 +
 .../arm64/boot/dts/socionext/uniphier-pxs3.dtsi |    8 +-
 arch/arm64/boot/dts/sprd/sc2731.dtsi            |   11 +
 arch/arm64/boot/dts/sprd/sc9860.dtsi            |   32 +-
 arch/arm64/boot/dts/sprd/whale2.dtsi            |   55 +-
 arch/arm64/boot/dts/synaptics/Makefile          |    4 +
 arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts |   29 +
 arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts |   29 +
 .../dts/{marvell => synaptics}/berlin4ct.dtsi   |   39 +-
 483 files changed, 16879 insertions(+), 6129 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-mc.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
 create mode 100644 arch/arm/boot/dts/am335x-osd335x-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-pocketbeagle.dts
 create mode 100644 arch/arm/boot/dts/am3517-som.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
 create mode 100644 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
 create mode 100644 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-mamoj.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dhcom-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-icore-mipi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
 create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi
 create mode 100644 arch/arm/boot/dts/meson8m2-mxiii-plus.dts
 create mode 100644 arch/arm/boot/dts/meson8m2.dtsi
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts
 create mode 100644 arch/arm/boot/dts/mt7623a.dtsi
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-emmc.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dts
 delete mode 100644 arch/arm/boot/dts/ste-ccu8540-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/ste-ccu8540.dts
 delete mode 100644 arch/arm/boot/dts/ste-ccu9540.dts
 create mode 100644 arch/arm/boot/dts/stm32f469.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts
 create mode 100644 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-plus.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/poplar-pinctrl.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
 delete mode 100644 arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
 create mode 100644 arch/arm64/boot/dts/synaptics/Makefile
 create mode 100644 arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
 create mode 100644 arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi (78%)
