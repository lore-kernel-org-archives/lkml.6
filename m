Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeBAXXN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:23:13 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:42741 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBAXXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:23:02 -0500
X-Google-Smtp-Source: AH8x227P61k4TJ8bbe5QQLaxNH70nG/D0L+PtvUS9ht2X+V3TjCpBU9ZvQcTXBnJqVL8aZyZpvwZugANEhHUoELoZw4=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 00:22:59 +0100
X-Google-Sender-Auth: lISlfuwED3GR-pvXJKZruJ5ymAA
Message-ID: <CAK8P3a318Td4j1omAOS0yRQK8k_u06QkhxXVjcgRDwTpRz0WyA@mail.gmail.com>
Subject: [GIT PULL 1/3] ARM: SoC device tree updates for 4.16
To: Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11NNJYw010525

The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 9a288ba7d1dd088c10697905ff42d48830a7c549:

  Merge tag 'socfpga_dts_for_v4.16' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into
next/dt (2018-01-26 17:42:02 +0100)

----------------------------------------------------------------
ARM: SoC device tree updates for 4.16

We get a moderate number of new machines this time, and only one
new SoC variant (Actions S700):

Actions:
  S700 Soc and CubieBoard7 development board
  Allo.com Sparky Single-board-computer

Allwinner:
  Orange Pi R1 development board
  Libre Computer Board ALL-H3-CC H3 single-board computer

ASpeed ast2x00:
   Witherspoon: OpenPower Power9 server manufactured by IBM that uses
the ASPEED ast2500
   Zaius: OpenPower Power9 server manufactured by Invatech that uses
the ASPEED ast2500
   Q71L: Intel Xeon server manufactured by Qanta that uses the ASPEED ast2400

AT91:
  Axentia Nattis/Natte digital signage
  sama5d2 PTC-ek Evaluation board

Freescale/NXP i.MX:
   SolidRun Humminboard2 development board
   Variscite DART-MX6 SoM and Carrier-board
   Technologic TS-4600 and TS-7970 development board
   Toradex Colibri iMX7D SoM board
   v1.5 variant of Solidrun Cubox-i and Hummingboard

Freescale/NXP Layerscape:
   Moxa UC-8410A Series industrial computer

Gemini:
  D-Link DNS-313 NAS enclosure

OMAP:
  LogicPD OMAP35xx SOM-LV devkit
  LogicPD OMAP35xx Torpedo devkit

Renesas:
  r8a77970 (V3M) Starter Kit board
  r8a7795 (M3-W) Salvator-XS board

We finally managed to get the dtc warnings under control, with no more
build-time warnings for bad device tree files. This includes fixes for
the majority of platforms, including nomadik, samsung, lpc32xx, STi,
spear, mediatek, freescale, qcom, realview, keystone, omap, kirkwood,
renesas, hisilicon, and broadcom.

Files get rearranged on a few platforms, in particular the Marvell
Armada 7K/8K device tree files are changed in preparation for future
SoC support, based on more than two of the same chips in one package,
and some boards get renamed for oxnas for consistency.

Finally, many existing SoCs gain descriptions for additional on-chip
devices that we can now support with kernel drivers:

  Allwinner A83t (drm, ethernet, i2c, ...), H3/H5 (USB-OTG)
  Amlogic AXG family (clk, pinctrl, pwm, ...), and others (vpu, hdmi)
  Aspeed clk controller support
  Freescale LS1088A, LS1021A device support
  Gemini Ethernet, PCI, TVE, panel
  Keystone gpio, qspi, more uarts
  Mediatek cpufreq, regulator, clock, reset
  Marvell thermal, cpufreq, nand
  Renesas SMP, thermal, timer, PWM, sound, phy, ipmmu
  Rockchip Mipi, GPU, display
  Samsung Exynos5433 PMU, power domain, nfc
  Spreadtrum: sc9860 clocks
  Tegra TX2 PSDI, HDMI, I2C,SMMU, display, fuse, ...

----------------------------------------------------------------
Adam Ford (6):
      ARM: dts: omap3: logicpd kits: Remove partition information
      ARM: dts: Move most of logicpd-som-lv-37xx-devkit.dts to
logicpd-som-lv-baseboard.dtsi
      ARM: dts: Add minimal support for LogicPD OMAP35xx SOM-LV devkit
      ARM: dts: Move most of logicpd-torpedo-37xx-devkit to
logicpd-torpedo-baseboard
      ARM: dts: Add minimal support for LogicPD OMAP35xx Torpedo devkit
      ARM: dts: Move move WiFi bindings to logicpd-torpedo-37xx-devkit

Alexandre Belloni (45):
      ARM: at91: Document new TCB bindings
      ARM: dts: at91: at91rm9200: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91rm9200ek: use TCB0 for timers
      ARM: dts: at91: mpa1600: use TCB0 as timers
      ARM: dts: at91: at91sam9260: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91sam9260ek: use TCB0 as timers
      ARM: dts: at91: sam9_l9260: use TCB0 as timers
      ARM: dts: at91: ethernut5: use TCB0 as timers
      ARM: dts: at91: foxg20: use TCB0 as timers
      ARM: dts: at91: animeo_ip: use TCB0 as timers
      ARM: dts: at91: kizbox: use TCB0 as timers
      ARM: dts: at91: at91sam9g20ek: use TCB0 as timers
      ARM: dts: at91: ge863-pro3: use TCB0 as timers
      ARM: dts: at91: at91sam9261: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91sam9261ek: use TCB0 as timers
      ARM: dts: at91: at91sam9263: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91sam9263ek: use TCB0 as timers
      ARM: dts: at91: calao: use TCB0 as timers
      ARM: dts: at91: at91sam9g45: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91sam9m10g45ek: use TCB0 as timers
      ARM: dts: at91: pm9g45: use TCB0 as timers
      ARM: dts: at91: at91sam9rl: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91sam9rlek: use TCB0 as timers
      ARM: dts: at91: at91sam9n12: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91sam9n12ek: use TCB0 as timers
      ARM: dts: at91: at91sam9x5: TC blocks are also simple-mfd and
syscon devices
      ARM: dts: at91: at91sam9x5cm: use TCB0 as timers
      ARM: dts: at91: acme/g25: use TCB0 as timers
      ARM: dts: at91: cosino: use TCB0 as timers
      ARM: dts: at91: kizboxmini: use TCB0 as timers
      ARM: dts: at91: sama5d3: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: sama5d3xek: use TCB0 as timers
      ARM: dts: at91: sama5d3 Xplained: use TCB0 as timers
      ARM: dts: at91: kizbox2: use TCB0 as timers
      ARM: dts: at91: sama5d3xek_cmp: use TCB0 as timers
      ARM: dts: at91: linea/tse850-3: use TCB0 as timers
      ARM: dts: at91: sama5d4: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: sama5d4: Add TCB2
      ARM: dts: at91: sama5d4ek: use TCB2 as timers
      ARM: dts: at91: sama5d4 Xplained: use TCB2 as timers
      ARM: dts: at91: ma5d4: use TCB2 as timers
      ARM: dts: at91: vinco: use TCB2 as timers
      ARM: dts: at91: sama5d2: TC blocks are also simple-mfd and syscon devices
      ARM: dts: at91: sama5d2 Xplained: use TCB0 as timers
      ARM: dts: at91: sama5d27_som1_ek: use TCB0 as timers

Amit Kucheria (3):
      arm64: dts: qcom: apq8016-sbc: Allow USR4 LED to notify kernel panic
      arm64: dts: hisilicon: hi3660-hikey960: Allow USR4 LED to notify
kernel panic
      arm64: dts: hisilicon: hi6220-hikey: Allow USR1 LED to notify kernel panic

Andre Przywara (1):
      arm64: dts: allwinner: H5: remove redundant MMC0 card detect pin

Andreas Färber (6):
      dt-bindings: arm: actions: Add S700 and CubieBoard7
      dt-bindings: power: Add Actions Semi S700 SPS
      dt-bindings: Add vendor prefix for Allo.com
      dt-bindings: arm: actions: Add Sparky
      arm64: dts: actions: Add S700 and CubieBoard7
      arm: dts: owl-s500: Add Sparky

Andrew F. Davis (2):
      ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Andrew Jeffery (1):
      ARM: dts: aspeed: Add LPC and child devices

Andrew Lunn (1):
      ARM: dts: vf610-zii-dev-c: Fix switch EEPROM size

Andrew-sh Cheng (2):
      arm64: dts: mediatek: add mt8173 cpufreq related device nodes
      arm64: dts: mediatek: add mt2712 cpufreq related device nodes

Andrzej Hajda (1):
      arm64: dts: exynos: Increase bus frequency for MHL chip

Antoine Tenart (1):
      arm64: dts: marvell: armada-37xx: add a crypto node

Antony Antony (1):
      arm64: dts: allwinner: h5: NanoPi NEO Plus2 : add EMAC support

Arnd Bergmann (36):
      Merge tag 'renesas-dt-bindings-for-v4.16' of
ssh://gitolite.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-for-v4.16' of
ssh://gitolite.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-arm64-dt-for-v4.16' of
ssh://gitolite.kernel.org/.../horms/renesas into next/dt
      Merge tag 'amlogic-dt' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'amlogic-dt64' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'omap-for-v4.16/dt-clk-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'omap-for-v4.16/dt-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'gemni-dts-1' of
ssh://gitolite.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'samsung-dt-4.16' of
ssh://gitolite.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.16' of
ssh://gitolite.kernel.org/.../krzk/linux into next/dt
      Merge tag 'tegra-for-4.16-dt-bindings' of
ssh://gitolite.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.16-arm-dt' of
ssh://gitolite.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.16-arm64-dt' of
ssh://gitolite.kernel.org/.../tegra/linux into next/dt
      Merge tag 'v4.15-next-dts32' of
ssh://gitolite.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'v4.15-next-dts64' of
ssh://gitolite.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'v4.16-rockchip-dts32-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.16-rockchip-dts64-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'gemini-dts-update-2' of
ssh://gitolite.kernel.org/.../linusw/linux-nomadik into next/dt
      arm64: dts: sprd: remove broken header inclusion
      Merge tag 'qcom-arm64-for-4.16' of
ssh://gitolite.kernel.org/.../agross/linux into next/dt
      Merge tag 'qcom-dts-for-4.16' of
ssh://gitolite.kernel.org/.../agross/linux into next/dt
      Merge tag 'amlogic-dt64-2' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'aspeed-4.16-devicetree' of
ssh://gitolite.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'imx-dt-4.16' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt64-4.16' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'mvebu-dt64-4.16-2' of
git://git.infradead.org/linux-mvebu into next/dt
      ARM: dts: exynos: fix RTC interrupt for exynos5410
      arm64: dts: add #cooling-cells to CPU nodes
      ARM: lpc3250: fix uda1380 gpio numbers
      ARM: dts: s5pv210: add interrupt-parent for ohci
      Merge tag 'mvebu-dt64-4.16-3' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'gemini-dts-update-3' of
ssh://gitolite.kernel.org/.../linusw/linux-nomadik into next/dt
      ARM: dts: nomadik: add interrupt-parent for clcd
      Merge tag 'omap-for-v4.16/dt-clk-dts-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'omap-for-v4.16/dt-pt3-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'socfpga_dts_for_v4.16' of
ssh://gitolite.kernel.org/.../dinguyen/linux into next/dt

Ashish Kumar (1):
      arm64: dts: ls1088a: Added dcfg node in ls1088a dtsi

Bhumika Goyal (2):
      ARM: OMAP2+: CM: make some pointers and function arguments as const
      ARM: OMAP2+: CM: make cm_ll_data structures as const

Biju Das (27):
      ARM: dts: r8a7745: Add HS-USB device node
      ARM: dts: r8a7745: Add USB-DMAC device nodes
      ARM: dts: r8a7745: Enable DMA for HSUSB
      ARM: dts: iwg22d-sodimm: Enable HS-USB
      ARM: dts: r8a7743: Add default PCIe bus clock
      ARM: dts: r8a7743: Add PCIe Controller device node
      ARM: dts: iwg20d-q7: Enable PCIe Controller
      ARM: dts: r8a7743: Add audio clocks
      ARM: dts: r8a7743: Add audio DMAC support
      ARM: dts: r8a7743: Add sound support
      ARM: dts: r8a7743: Add thermal device to DT
      ARM: dts: iwg20d-q7-common: Enable SGTL5000 audio codec
      ARM: dts: iwg20d-q7-common: Sound PIO support
      ARM: dts: iwg20d-q7-common: Sound DMA support on DTS
      ARM: dts: iwg20d-q7-common: Sound DMA support via BUSIF on DTS
      ARM: dts: iwg20d-q7-common: Sound DMA support via SRC on DTS
      ARM: dts: iwg20d-q7-common: Sound DMA support via DVC on DTS
      ARM: dts: r8a7745: Add audio clocks
      ARM: dts: r8a7745: Add audio DMAC support
      ARM: dts: r8a7745: Add sound support
      ARM: dts: iwg22d-sodimm: Enable SGTL5000 audio codec
      ARM: dts: iwg22d-sodimm: Sound PIO support
      ARM: dts: iwg22d-sodimm: Sound DMA support on DTS
      ARM: dts: iwg22d-sodimm: Sound DMA support via BUSIF on DTS
      ARM: dts: iwg22d-sodimm: Sound DMA support via SRC on DTS
      ARM: dts: iwg22d-sodimm: Sound DMA support via DVC on DTS
      ARM: dts: r8a7745: Add missing clock for secondary CA7 CPU core

Bjorn Andersson (2):
      arm64: dts: msm8916: Add missing #phy-cells
      arm64: dts: msm8916: Correct ipc references for smsm

Brian Norris (1):
      arm64: dts: rockchip: add rk3399 DSI0 reset

Chen-Yu Tsai (5):
      ARM: dts: sun8i: h3: Add dts file for Libre Computer Board
ALL-H3-CC H3 ver.
      ARM: dts: sun8i: a83t: Enable Ethernet on two boards
      arm64: dts: allwinner: a64: bananapi-m64: Add LED device node
      ARM: dts: sun8i: a83t: Add I2S controller device nodes
      ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings

Chris Paterson (3):
      ARM: dts: r8a7790: Correct critical CPU temperature
      ARM: dts: r8a7791: Correct critical CPU temperature
      ARM: dts: r8a7793: Correct critical CPU temperature

Chris Zhong (1):
      ARM: dts: rockchip: add reset property for rk3066a-rayeager emac phy

Chunyan Zhang (2):
      arm64: dts: add syscon for whale2 platform
      arm64: dts: add clocks for SC9860

Corentin LABBE (1):
      ARM: dts: sun8i: a83t: add dwmac-sun8i device node

Corentin Labbe (1):
      ARM: dts: sun8i-h3: Remove allwinner,leds-active-low for non internal PHY

Damien Riegel (6):
      arm64: dts: qcom: pm8916: fix wcd_codec indentation
      arm64: dts: qcom: msm8916-pins: remove assignments to bias-disable
      arm64: dts: qcom: msm8916: drop unused board-specific nodes
      arm64: dts: qcom: msm8916: normalize I2C and SPI nodes
      arm64: dts: qcom: msm8916-pins: move sdhc2 cd node with its siblings
      arm64: dts: qcom: msm8916-pins: keep cdc_dmic pins in suspend mode

Daniel Golle (1):
      ARM: dts: rename oxnas dts files

Dave Gerlach (11):
      ARM: dts: am43xx: Fix inverted DS0_PULL_UP_DOWN_EN macro
      ARM: dts: am437x-idk-evm: Disable OPP50 for MPU
      ARM: dts: am43x-epos-evm: Hook dcdc2 as the cpu0-supply
      ARM: dts: dra7: Add vbb-supply to cpu and additional voltages
      ARM: dts: dra7: Add MPU OPP supply node
      ARM: dts: dra7: Enable 1.5 GHz operation for the CPU
      ARM: dts: am57xx-beagle-x15-common: Add cpu0 vdd supply
      ARM: dts: dra7-evm: Add cpu0 vdd supply
      ARM: dts: dra72-evm-tps65917: Add cpu0 vdd supply
      ARM: dts: am571x-idk: Add cpu0 vdd supply
      ARM: dts: am572x-idk: Add cpu0 vdd supply

Dinh Nguyen (3):
      ARM: dts: socfpga: disable over-current for Arria10 USB devkit
      arm64: dts: stratix10: enable USB on the devkit
      arm64: dts: stratix10: add USB ECC reset bit

Dmitry Osipenko (1):
      ARM: tegra: Add video decoder on Tegra20

Dongjin Kim (1):
      ARM: dts: exynos: Fix property values of LDO15/17 for Odroid XU3/XU4

Emmanuel Vadot (1):
      ARM: dts: sunxi: Add codec for A13 Olinuxino

Enric Balletbo i Serra (5):
      arm64: dts: rockchip: add pd_usb3 power-domain node for rk3399
      arm64: dts: rockchip: add the aclk_usb3 clocks for USB3 on rk3399
      arm64: dts: rockchip: add reset property for dwc3 controllers on rk3399
      arm64: dts: rockchip: add usb3-phy otg-port support for rk3399
      arm64: dts: rockchip: add extcon nodes and enable tcphy rk3399-gru

Esben Haabendal (2):
      ARM: dts: ls1021a: Add label to USB controllers
      ARM: dts: ls1021a: Specify interrupt-affinity for pmu node

Eugen Hristev (1):
      ARM: dts: at91: sama5d2: added dma property for ADC device

Fabio Estevam (41):
      ARM: dts: imx6qdl-wandboard-revd1: Make EDID functional
      ARM: dts: imx6sx: Fix the PCI representation
      ARM: dts: imx6sx-sdb: Rearrange the regulators node
      ARM: dts: imx6sx-sdb: Add PCIe support
      ARM: dts: imx6qdl-sabreauto: Pass the DDC I2C bus
      ARM: dts: imx6qdl-sabreauto: Add CEC support
      ARM: dts: imx53-cx9020: Fix the Ethernet PHY reset GPIO polarity
      ARM: dts: imx53: Move nodes which have no reg property out of bus
      ARM: dts: imx6: Move nodes which have no reg property out of bus
      ARM: dts: imx6: Add unit address and reg for the anatop nodes
      ARM: dts: imx6dl: Pass the reg properties for mipi nodes
      ARM: dts: imx6dl: Remove unneeded label and unit address
      ARM: dts: imx7: Move nodes which have no reg property out of bus
      ARM: dts: imx7d: Fix pcie node warnings
      ARM: dts: imx7s: Add unit address and reg for the anatop nodes
      ARM: dts: vfxxx: Move nodes which have no reg property out of bus
      ARM: dts: imx6sx: Fix spba-bus unit address
      ARM: dts: vf500: Fix interrupt-controller unit address
      ARM: dts: imx51-ts4800: Fix syscon and touschscreen nodes
      ARM: dts: imx51-zii-rdu1: Add the unit addresses in sysled
      ARM: dts: imx53-m53: Remove unneeded reg property
      ARM: dts: imx53-tx53-x03x: Move display node out of 'soc'
      ARM: dts: imx6qdl-apf6dev: Move regulators out of simple-bus
      ARM: dts: imx6qdl-aristainetos: Move regulators out of simple-bus
      ARM: dts: imx6qdl-aristainetos: Move display node out of 'soc'
      ARM: dts: imx6qdl-apalis: Remove unneeded reg property
      ARM: dts: imx6qdl-colibri: Remove unneeded reg property
      ARM: dts: imx6q-h100: Remove unneeded unit address
      ARM: dts: imx6qdl-nitrogen6_max: Remove unneeded unit address
      ARM: dts: imx6ul-14x14-evk: Move regulators out of simple-bus
      ARM: dts: imx6qdl-zii-rdu2: Remove device_type from PCI subnode
      ARM: dts: imx51-babbage: Pass the USB PHY regulator
      ARM: dts: imx6sx: Fix PCI non-prefetchable memory range
      ARM: dts: imx6sx: Add support for PCI power domain
      dt-bindings: imx-gpcv2: Fix the unit address
      ARM: dts: ls1021a-qds: Remove extra clock cell
      ARM: dts: ls1021a-twr: Remove extra clock cell
      ARM: dts: imx51-babbage: Fix the 26MHz clock modelling
      ARM: dts: imx6qdl-hummingboard2: Remove leading zero in unit address
      ARM: dts: imx51-zii-rdu1: Add missing #phy-cells to usb-nop-xceiv
      ARM: dts: imx7s: Avoid using label in unit address and reg

Fabrizio Castro (25):
      ARM: dts: r8a7743: Add DU support
      ARM: dts: iwg20d-q7-dbcm-ca: Add HDMI video output
      ARM: dts: iwg22d: Use /dev/ttySC3 as debug console
      ARM: dts: iwg22d: Add /dev/ttySC5 support
      ARM: dts: iwg22d-sodimm-dbhd-ca: Add device tree for HDMI DB
      ARM: dts: iwg22d-sodimm: sort dt nodes
      ARM: dts: r8a7745: Add IIC cores to dtsi
      ARM: dts: iwg20d-q7: Add support for ttySC3
      ARM: dts: r8a7745: Add DU support
      ARM: dts: iwg22d-sodimm-dbhd-ca: Add HDMI video output
      ARM: dts: r8a7745: Add CAN[01] SoC support
      ARM: dts: iwg22d-sodimm: Add can0 support to carrier board
      ARM: dts: iwg22d-sodimm-dbhd-ca: Add can1 support to HDMI DB
      ARM: dts: r8a7743: Add CAN[01] SoC support
      ARM: dts: iwg20d-q7-common: Add can0 support to carrier board
      ARM: dts: iwg20d-q7-dbcm-ca: Add can1 support to camera DB
      ARM: dts: r8a7743: add VIN dt support
      ARM: dts: r8a7745: add VIN dt support
      ARM: dts: r8a7745: Add APMU node and second CPU core
      ARM: dts: r8a7743: Add PWM SoC support
      ARM: dts: r8a7743: Add TPU support
      ARM: dts: r8a7745: Add PWM SoC support
      ARM: dts: r8a7745: Add TPU support
      ARM: dts: r8a7743: Add CMT SoC specific support
      ARM: dts: r8a7745: Add CMT SoC specific support

Finley Xiao (1):
      arm64: dts: rockchip: Add efuse device node for RK3328 SoC

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2017-12-19' into devicetree/next

Franklin S Cooper Jr (2):
      ARM: dts: k2g: Add UART 1 and 2 instances
      ARM: dts: k2g-evm: Enable UART 2

Geert Uytterhoeven (19):
      ARM: shmobile: Document Renesas M3-W-based Salvator-XS board DT bindings
      ARM: dts: koelsch: Correct primary compatible value for eeprom
      ARM: dts: genmai: Correct primary compatible value for eeprom
      arm64: dts: renesas: r8a77970: Add RWDT node
      arm64: dts: renesas: eagle: Move avb node to preserve sort order
      arm64: dts: renesas: eagle: Enable watchdog timer
      arm64: dts: renesas: Add support for Salvator-XS with R-Car M3-W
      arm64: dts: renesas: salvator-common: Add BD9571 PMIC
      arm64: dts: renesas: r8a7795-es1-salvator-x: Add SoC name to file header
      arm64: dts: renesas: r8a7795-salvator-x: Add SoC name to file header
      arm64: dts: renesas: r8a7796-salvator-x: Add SoC name to file header
      arm64: dts: renesas: r8a7795-salvator-xs: Add SoC name to file header
      ARM: dts: armadillo800eva: Convert to named i2c-gpio bindings
      ARM: dts: lager: Convert to named i2c-gpio bindings
      ARM: dts: koelsch: Convert to named i2c-gpio bindings
      ARM: dts: alt: Convert to named i2c-gpio bindings
      arm64: dts: renesas: salvator-common: Add EthernetAVB PHY reset
      arm64: dts: renesas: ulcb: Add EthernetAVB PHY reset
      ARM: dts: r8a7740: Correct TPU register block size

Gregory CLEMENT (4):
      arm64: dts: marvell: armada-37xx: add nodes allowing cpufreq support
      ARM64: dts: marvell: armada-cp110: Fix clock resources for various node
      Merge branch 'mvebu/fixes' into HEAD
      arm64: dts: marvell: armada-80x0: Fix pinctrl compatible string

H. Nikolaus Schaller (2):
      ARM: dts: gta04: improve panel compatibility string
      ARM: dts: pandora: fix panel compatibility string

Heiko Stuebner (2):
      dt-bindings: gpu: mali-utgard: add rockchip,rk3328-mali compatible
      arm64: dts: rockchip: add rk3328 mali gpu node

Icenowy Zheng (6):
      ARM: dts: sun8i: add support for Orange Pi R1
      ARM: dts: sun8i: fix USB Ethernet of Orange Pi R1
      dt-bindings: simplefb-sunxi: add pipelines for DE2
      ARM: sun8i: h3/h5: add DE2 CCU device node for H3
      arm64: allwinner: h5: add compatible string for DE2 CCU
      ARM: sunxi: h3/h5: add simplefb nodes

Ioana Ciornei (1):
      arm64: dts: ls1088a: add fsl-mc hardware resource manager node

Ivaylo Dimitrov (1):
      ARM: dts: n900: Add aliases for lcd and tvout displays

Jagan Teki (2):
      arm64: allwinner: a64: Enable AXP803 for Orangepi Win
      arm64: dts: a64-olinuxino: Enable RTL8723BS WiFi

Javier Martinez Canillas (4):
      ARM: dts: keystone: Add generic compatible string for I2C EEPROM
      ARM: dts: efm32: Add generic compatible string for I2C EEPROM
      ARM: dts: lpc18xx: Add generic compatible string for I2C EEPROM
      ARM: dts: socfpga: Add generic compatible string for I2C EEPROM

Jeffy Chen (1):
      arm64: dts: rockchip: Enable edp disaplay on kevin

Jerome Brunet (1):
      ARM64: dts: meson-gxm: fix q200 interrupt number

Jian Hu (1):
      ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC

Joel Stanley (17):
      dt-bindings: clock: Add ASPEED constants
      dt-bindings: gpio: Add ASPEED constants
      ARM: dts: aspeed: Add proper clock references
      ARM: dts: aspeed: Add MAC clocks
      ARM: dts: aspeed: Add watchdog clocks
      ARM: dts: aspeed: Add flash controller clocks
      ARM: dts: aspeed: Add clock phandle to GPIO
      ARM: dts: aspeed: Add PWM and tachometer node
      ARM: dts: aspeed: Add LPC Snoop device
      ARM: dts: aspeed: Remove skeleton.dtsi
      ARM: dts: aspeed: Update license headers
      ARM: dts: Add OpenBMC flash layout
      ARM: dts: aspeed: Sort ASPEED entries in makefile
      ARM: dts: aspeed: Add Witherspoon BMC machine
      ARM: dts: aspeed-romulus: Update Romulus system
      ARM: dts: aspeed-plametto: Add flash layout and fix memory node
      ARM: dts: aspeed-evb: Add unit name to memory node

Jon Hunter (1):
      arm64: tegra: Add CPU and PSCI nodes for NVIDIA Tegra210 platforms

Jon Nettleton (1):
      ARM: dts: imx6qdl: add HummingBoard2 boards

Keerthy (2):
      ARM: dts: keystone-k2l: Add the second gpio bank node
      ARM: dts: DRA76-EVM: Set powerhold property for tps65917

Keiji Hayashibara (1):
      ARM: dts: uniphier: add efuse node for UniPhier 32bit SoC

Kevin Hilman (2):
      ARM64: dts: amlogic: use generic bus node names
      Merge tag 'meson-clk-headers-for-v4.16-2' of
git://github.com/BayLibre/clk-meson into v4.16/dt64

Kishon Vijay Abraham I (5):
      ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
      ARM: dts: DRA74x: Use PCIe compatible specific to dra74
      ARM: dts: DRA72x: Use PCIe compatible specific to dra72
      ARM: dts: dra76-evm: Enable x2 PCIe lanes
      ARM: dts: dra7: Remove deprecated PCI compatible string

Krzysztof Adamski (1):
      ARM: dts: sun8i: h3: enable USB OTG for NanoPi Neo board

Krzysztof Kozlowski (10):
      ARM: dts: exynos: Add missing interrupt-controller properties to
Exynos5410 PMU
      ARM: dts: exynos: Use lower case hex addresses in node unit addresses
      arm64: dts: exynos: Use lower case hex addresses in node unit addresses
      arm64: dts: exynos: Fix typo in MSCL clock controller unit
address of Exynos5433
      arm64: dts: exynos: Add SPDX license identifiers
      ARM: dts: exynos: Add SPDX license identifiers
      ARM: dts: s3c24xx: Add SPDX license identifiers
      ARM: dts: s3c64xx: Add SPDX license identifiers
      ARM: dts: s5pv210: Add SPDX license identifiers
      Revert "ARM: dts: exynos: Add missing interrupt-controller
properties to Exynos5410 PMU"

Kunihiko Hayashi (2):
      ARM: dts: uniphier: add has-transaction-translator property to
usb node for LD4, sLD8 and Pro4
      arm64: dts: uniphier: add has-transaction-translator property to
usb node for LD11

Linus Walleij (8):
      ARM: dts: Add ethernet PHYs to the a bunch of Geminis
      ARM: dts: Add basic devicetree for D-Link DNS-313
      ARM: dts: Flags D-Link DIR-685 I2C bus gpios
      ARM: dts: Add PCI to WBD111 and WBD222
      ARM: dts: Add TVE/TVC and ILI9322 panel to DIR-685
      ARM: dts: Delete bogus reference to the charlcd
      ARM: dts: Add ethernet to the Gemini SoC
      ARM: dts: Add ethernet to a bunch of platforms

Lokesh Vutla (1):
      ARM: dts: am57xx: Add support for am574x-idk

Luca Weiss (1):
      ARM: dts: msm8974-FP2: Add uSD slot nodes

Lucas Stach (10):
      ARM: dts: imx6: RDU2: add i210 node
      ARM: dts: imx: rdu1: cosmetic changes to the audio nodes
      ARM: dts: imx6: RDU2: add alias for RTC
      ARM: dts: imx6*-hummingboard2: fix formatting
      ARM: dts: imx6*-hummingboard2: add SGTL5000 VDDD supply
      ARM: dts: imx6*-hummingboard2: remove LDB node
      ARM: dts: imx6*-hummingboard2: fix PCIe reset polarity
      ARM: dts: imx6*-hummingboard2: remove non-mainline property from RTC
      ARM: dts: imx6*-hummingboard2: remove redundant PWM disables
      ARM: dts: imx6*-hummingboard2: rework regulators

Ludovic Desroches (1):
      ARM: dts: at91: introduce the sama5d2 ptc ek board

Maciej S. Szmigiero (2):
      ARM: dts: imx6qdl-udoo: disable AC'97 input pins pad drivers
      ARM: dts: imx6qdl-udoo: add support for powering off

Magnus Damm (30):
      arm64: dts: renesas: r8a7796: Add IPMMU device nodes
      arm64: dts: renesas: r8a7796: Tie SYS-DMAC to IPMMU-DS0/1
      arm64: dts: renesas: r8a7796: Enable IPMMU-DS0, DS1, MP, VI0, VC0 and MM
      arm64: dts: renesas: r8a7795: Add IPMMU device nodes
      arm64: dts: renesas: r8a7795-es1: Add IPMMU device nodes
      arm64: dts: renesas: r8a7795: Tie SYS-DMAC to IPMMU-DS0/1
      arm64: dts: renesas: r8a7795: Tie Audio-DMAC to IPMMU-MP0/1
      arm64: dts: renesas: r8a7795: Point DU/VSPD via FCPVD to IPMMU-VI0/1
      arm64: dts: renesas: r8a7795-es1: Point DU/VSPD via FCPVD to IPMMU-VI0
      arm64: dts: renesas: r8a7795: Point FDP1 via FCPF to IPMMU-VP0/1
      arm64: dts: renesas: r8a7795-es1: Point FDP1 via FCPF to IPMMU-VP0
      arm64: dts: renesas: r8a7795: Point VSPBC/VSPBD via FCPVB to IPMMU-VP0/1
      arm64: dts: renesas: r8a7795: Point VSPI via FCPVI to IPMMU-VP0/1
      arm64: dts: renesas: r8a7795-es1: Point VSPI via FCPVI to IPMMU-VP
      arm64: dts: renesas: r8a7795: Connect Ethernet-AVB to IPMMU-DS0
      arm64: dts: renesas: r8a7795: Connect SATA to IPMMU-HC
      arm64: dts: renesas: r8a7795-es1: Enable IPMMU-MP1
      arm64: dts: renesas: r8a7795: Enable IPMMU-VI0, VP1, DS0, DS1 and MM
      ARM: dts: r8a73a4: Update CMT compat string
      ARM: dts: r8a7790: Update CMT compat strings
      ARM: dts: r8a7791: Update CMT compat strings
      ARM: dts: r8a7793: Update CMT compat strings
      ARM: dts: r8a7794: Update CMT compat strings
      ARM: dts: r8a73a4: Remove CMT renesas,channels-mask
      ARM: dts: r8a7740: Remove CMT renesas,channels-mask
      ARM: dts: r8a7790: Remove CMT renesas,channels-mask
      ARM: dts: r8a7791: Remove CMT renesas,channels-mask
      ARM: dts: r8a7793: Remove CMT renesas,channels-mask
      ARM: dts: r8a7794: Remove CMT renesas,channels-mask
      ARM: dts: sh73a0: Remove CMT renesas,channels-mask

Marco Franchi (4):
      ARM: dts: imx53-tx53: Fix 'ethernet-phy@0' node with unit name
and no reg property
      ARM: dts: imx6sx-sdb: Convert from fbdev to drm bindings
      ARM: dts: imx6sl-evk: Rearrange the regulators node
      ARM: dts: imx6sl-evk: Convert from fbdev to drm bindings

Marek Szyprowski (13):
      arm64: dts: exynos: Add CPU performance counters to Exynos5433 boards
      arm64: dts: exynos: Add support for S3FWRN5 NFC chip to TM2(e) boards
      arm64: dts: exynos: Add GSCL power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add DISP power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add MSCL power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add MFC power domain to Exynos 5433 SoC
      arm64: dts: exynos: Add AUD power domain to Exynos5433 SoC
      arm64: dts: exynos: Add remaining power domains to Exynos5433 SoC
      ARM: dts: exynos: Add Exynos4412 ISP clock controller
      ARM: dts: exynos: Add audio power domain support to Exynos542x SoCs
      ARM: dts: exynos: Fix power domain node names for Exynos5250
      ARM: dts: exynos: Add audio power domain to Exynos5250
      ARM: dts: exynos: Add G3D power domain to Exynos5250

Marian Mihailescu (1):
      ARM: dts: exynos: Add CPU perf counters to Exynos54xx boards

Martin Blumenstingl (8):
      ARM: dts: meson8b: add more L2 cache settings
      ARM: dts: meson8: add more L2 cache settings
      ARM: dts: meson8: use stable UART bindings with correct gate clock
      ARM: dts: meson8b: use stable UART bindings with correct gate clock
      ARM64: dts: meson: add comments with the GPIO for the PHY interrupts
      ARM64: dts: meson-gxm: add the PHY interrupt line on Khadas VIM2
      ARM: dts: meson8: enable the GPIO interrupt controller
      ARM: meson: enable MESON_IRQ_GPIO also for MACH_MESON8

Masahiro Yamada (5):
      ARM: dts: uniphier: use macros in dt-bindings header
      arm64: dts: uniphier: use macros in dt-bindings header
      arm64: dts: uniphier: add GPIO hog definition for PXs3
      ARM: make ARCH_S3C24XX select USE_OF and clean-up boot/dts/Makefile
      arm64: dts: uniphier: enable more serial ports for PXs3 ref board

Mathieu Malaterre (5):
      ARM: dts: am3/am4/dra7/omap: Remove leading 0x and 0s from
bindings notation
      arm: mt7: dts: Remove leading 0x and 0s from bindings notation
      arm: kirkwood: dts: Use lower case for bindings notation
      ARM: imx: dts: Use lower case for bindings notation
      ARM: dts: at91: Remove leading 0x and 0s from bindings notation

Matthias Brugger (4):
      arm: dts: mt7623: Update ethsys binding
      arm: dts: mt2701: Add reset-cells
      dt-bindings: ARM: Mediatek: Fix ethsys documentation
      Merge remote-tracking branch 'mainline-kernel/v4.15-next/pdids'
into v4.15-next/dts64

Maxime Ripard (4):
      ARM: dts: sun8i: a83t: Add display pipeline
      ARM: dts: sun8i: a83t: Enable the PWM
      ARM: dts: sun8i: a83t: Add LVDS pins group
      ARM: dts: sun8i: a711: Enable the LCD

Michael Tretter (1):
      ARM: dts: imx6q-h100: use usdhc2 VSELECT

Miquel Raynal (2):
      arm64: dts: marvell: add NAND support on the 8040-DB board
      ARM64: dts: marvell: Add thermal support for A7K/A8K

Neil Armstrong (9):
      ARM64: dts: meson-gx: add VPU power domain
      ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards
      ARM64: dts: meson-gx: grow reset controller memory zone
      ARM64: dts: odroid-c2: Add HDMI and CEC Nodes
      ARM: dts: imx6qdl-pinfunc: Add missing
MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT
      dt-bindings: Add vendor prefix for Solomon Goldentek Display Corporation
      dt-bindings: display: Add bindings for SGD GKTW70SDAE4SE Panel
      ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM support
      ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board support

Nickey Yang (2):
      arm64: dts: rockchip: add mipi_dsi1 support for rk3399
      arm64: dts: rockchip: update mipi cells for RK3399

Nicolas Ferre (1):
      ARM: dts: at91: sama5d2_ptc_ek: use TCB0 as timers

Nishanth Menon (8):
      ARM: dts: keystone*: Standardize license with SPDX tag
      ARM: dts: keystone*: Use a single soc0 instance
      ARM: dts: keystone: Get rid of usage of skeleton.dtsi
      ARM: dts: keystone: Add missing unit name to interrupt controller
      ARM: dts: keystone-clocks: Add missing unit name to clock nodes
that have regs
      ARM: dts: keystone-hk-clocks: Add missing unit name to clock
nodes that have regs
      ARM: dts: keystone-k2e-clocks: Add missing unit name to clock
nodes that have regs
      ARM: dts: keystone-k2l-clocks: Add missing unit name to clock
nodes that have regs

Oleksij Rempel (1):
      ARM: dts: imx6: add snvs-lpgpr node

Olof Johansson (19):
      Merge tag 'arm-soc/for-4.16/devicetree' of
http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'hisi-arm64-dt-for-4.16-v2' of
git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'actions-arm-dt-for-4.16' of
git://git.kernel.org/.../afaerber/linux-actions into next/dt
      Merge tag 'actions-arm64-dt-for-4.16' of
git://git.kernel.org/.../afaerber/linux-actions into next/dt
      Merge tag 'renesas-arm64-dt2-for-v4.16' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt2-for-v4.16' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'mvebu-dt-4.16-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt64-4.16-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'omap-for-v4.16/dt-pt2-v2-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'keystone_dts_for_4.16' of
git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'sunxi-dt-for-4.16' of
https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.16' of
https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'uniphier-dt-v4.16' of
git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'uniphier-dt64-v4.16' of
git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'at91-ab-4.16-dt' of
git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'amlogic-dt64-3' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'sunxi-dt-for-4.16-2' of
https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'samsung-dt-4.16-2' of
https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.16-2' of
https://git.kernel.org/.../krzk/linux into next/dt

Otavio Salvador (1):
      ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions

Patrice Chotard (1):
      ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Patrick Bruenn (1):
      ARM: dts: imx53: add srtc node

Pavel Machek (1):
      ARM: dts: Nokia N9: add support for up/down keys in the dts

Peter Rosin (1):
      ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power

Peter Ujfalusi (4):
      ARM: dts: dra7: Add missing hdmi audio DMA channel information
      ARM: dts: am437x-gp-evm: Add phandle for the backlight for the panel
      ARM: dts: am437x-sk-evm: Add phandle for the backlight for the panel
      ARM: dts: am43xx-epos-evm: Add phandle for the backlight for the panel

Philipp Rossak (2):
      ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Nanopi M1
      ARM: dts: sun8i: h3: nanopi-m1-plus: fix missing ethernet 0 in aliases

Prabhakar Kushwaha (1):
      ARM: dts: ls1021aqds: Add nand node for ifc controller

Qiufang Dai (2):
      clk: meson-axg: add clocks dt-bindings required header
      arm64: dts: meson-axg: add clock DT info for Meson AXG SoC

Quentin Schulz (2):
      ARM: dtsi: axp81x: add GPIO DT node
      ARM: dtsi: axp81x: set pinmux for GPIO0/1 when used as LDOs

Rasmus Villemoes (2):
      ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node
      ARM: dts: ls1021a: add reboot node to .dtsi

Ravikumar Kattekola (1):
      ARM: dts: dra7: Reduce shut down temperature of non-cpu thermal zones

Rick Altherr (1):
      ARM: dts: aspeed: Add Qanta Q71L BMC machine

Rob Herring (1):
      ARM: dts: imx: Add missing #phy-cells to usb-nop-xceiv

Robert Nelson (3):
      ARM: dts: am335x-boneblue: fix wl1835 IRQ pin
      ARM: dts: am335x-boneblue: enable usarts
      ARM: dts: am335x-boneblue: enable can

Roger Quadros (1):
      ARM: dts: dra7: Disable USB metastability workaround for USB2

Russell King (31):
      ARM: dts: imx6qdl: SolidRun: remove redundant regulators node
      ARM: dts: imx6qdl: SolidRun: move AR8035 into microsom
      ARM: dts: imx6qdl-microsom: rename to imx6qdl-sr-som
      ARM: dts: imx6qdl: SolidRun: move microsom includes into .dts
      ARM: dts: imx6qdl-sr-som: use real iomuxc values for ethernet
      ARM: dts: imx6qdl-sr-som: split out Broadcom Wi-Fi support
      ARM: dts: imx6qdl-sr-som-brcm: rename sdio clock
      ARM: dts: imx6qdl-sr-som: add 3.3V vcc regulator
      ARM: dts: imx6qdl-sr-som: add support for TI Wi-Fi
      ARM: dts: imx6qdl-sr-som: add support for eMMC
      ARM: dts: imx6qdl-hummingboard: add SD card regulator
      ARM: dts: imx6qdl: SolidRun: rename regulators to match schematic
      ARM: dts: imx6qdl: SolidRun: fix node names
      ARM: dts: imx6qdl: SolidRun: add v1.5 som without eMMC
      ARM: dts: imx6qdl: SolidRun: add v1.5 som with eMMC
      ARM: dts: imx6qdl-cubox-i: update GPIO specification
      ARM: dts: imx6*-hummingboard2: remove ar8035 include
      ARM: dts: imx6qdl-hummingboard2: rename microsom include
      ARM: dts: imx6*-hummingboard2: move microsom includes into .dts
      ARM: dts: imx6*-hummingboard2: add Broadcom Wi-Fi include
      ARM: dts: imx6*-hummingboard2: fix SD card detect
      ARM: dts: imx6*-hummingboard2: use proper gpio flags definitions
      ARM: dts: imx6*-hummingboard2: convert to more conventional vmmc-supply
      ARM: dts: imx6*-hummingboard2: split out eMMC support
      ARM: dts: imx6qdl-hummingboard2: add PWM3 support
      ARM: dts: imx6qdl-hummingboard2: add v1.5 som without eMMC
      ARM: dts: imx6qdl-hummingboard2: add v1.5 som with eMMC
      ARM: dts: imx6qdl-hummingboard2: rename regulators to match schematic
      ARM: dts: vf610-zii-dev: enable edma1
      ARM: dts: vf610-zii-dev-rev-b: fix interrupt for GPIO expander
      ARM: dts: vf610-zii-dev-rev-b: add PHYs for switch2

SZ Lin (2):
      ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC
      ARM: dts: ls1021a: add support for Moxa UC-8410A open platform

Sean Nyekjaer (1):
      ARM: dts: armada-38x: Add NAND RB pinctrl information

Sean Wang (2):
      arm: dts: mt7623: update mmc related nodes with the appropriate fallback
      arm: dts: mt7623: fix card detection issue on bananapi-r2

Sebastian Reichel (2):
      ARM: dts: omap4-droid4: improve LCD description
      ARM: dts: n950: add display support

Sebastien Bourdelin (4):
      of: documentation: add bindings documentation for TS-7970
      ARM: dts: TS-7970: add basic device tree
      of: documentation: add bindings documentation for TS-4600
      ARM: dts: TS-4600: add basic device tree

Sergei Shtylyov (6):
      arm64: renesas: document V3MSK board bindings
      ARM: dts: r8a7794: Add SMP support
      arm64: dts: renesas: initial V3MSK board device tree
      arm64: dts: renesas: v3msk: add EtherAVB support
      arm64: dts: renesas: r8a77970: use CPG core clock macros
      arm64: dts: renesas: r8a77970: use SYSC power domain macros

Sergey Matyukevich (1):
      arm64: dts: orange-pi-zero-plus2: enable AP6212a WiFi/BT combo

Shawn Guo (1):
      arm64: dts: hi3798cv200: add SD card support

Simon Horman (41):
      ARM: dts: r8a7743: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7745: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7778: Use R-Car Gen1 Ether fallback compat string
      ARM: dts: r8a7790: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7791: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7793: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7794: Use R-Car Gen2 Ether fallback compat string
      ARM: dts: r8a7743: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7745: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7778: Use R-Car SDHI Gen1 fallback compat string
      ARM: dts: r8a7779: Use R-Car SDHI Gen1 fallback compat string
      ARM: dts: r8a7790: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7791: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7792: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7793: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: r8a7794: Use R-Car SDHI Gen2 fallback compat string
      ARM: dts: koelsch: Move cec_clock to root node
      arm64: dts: renesas: r8a7795: Use R-Car SDHI Gen3 fallback compat string
      arm64: dts: renesas: r8a7796: Use R-Car SDHI Gen3 fallback compat string
      arm64: dts: renesas: r8a7796: Tie Audio-DMAC to IPMMU-MP
      arm64: dts: renesas: r8a7796: Point FDP1 via FCPF to IPMMU-VI0
      arm64: dts: renesas: r8a7796: Point VSPI via FCPVI to IPMMU-VC0
      arm64: dts: renesas: r8a7796: Connect Ethernet-AVB to IPMMU-DS0
      arm64: dts: renesas: r8a77970: sort includes
      arm64: dts: renesas: r8a77970: Add IPMMU device nodes
      arm64: dts: renesas: r8a77970: Tie SYS-DMAC to IPMMU-DS1
      arm64: dts: renesas: r8a77970: Connect Ethernet-AVB to IPMMU-RT
      arm64: dts: renesas: r8a77970: Enable IPMMU-DS1, RT and MM
      arm64: dts: renesas: r8a77995: Add IPMMU device nodes
      arm64: dts: renesas: r8a77995: Connect Ethernet-AVB to IPMMU-RT
      arm64: dts: renesas: r8a7795: Move nodes which have no reg
property out of bus
      arm64: dts: renesas: r8a7795: sort subnodes of root node alphabetically
      arm64: dts: renesas: r8a7796: sort subnodes of root node alphabetically
      arm64: dts: renesas: r8a7796: move nodes which have no reg
property out of bus
      arm64: dts: renesas: r8a7796: add reg properties to pciec[01] nodes
      ARM: dts: r8a7745: sort root sub-nodes alphabetically
      ARM: dts: r8a7745: move timer node out of bus
      ARM: dts: r8a7792: sort root sub-nodes alphabetically
      ARM: dts: r8a7792: move timer node out of bus
      ARM: dts: r8a7743: sort root sub-nodes alphabetically
      ARM: dts: r8a7743: move timer and thermal-zones nodes out of bus

Simon Shields (2):
      ARM: dts: exynos: Correct Trats2 panel reset line
      ARM: dts: exynos: Add bcm4334 device node to Trats2

Stefan Agner (10):
      ARM: dts: colibri/apalis: use correct compatible for RTC
      ARM: dts: imx7-colibri: move and rename USB Host power regulator
      ARM: dts: imx7-colibri: make sure multiplexed pins are not active
      ARM: dts: imx7-colibri: mux pull-ups where appropriate
      ARM: dts: imx7-colibri: use NAND_CE1 as GPIO
      ARM: dts: imx7-colibri: specify cpu-supply
      ARM: dts: imx7-colibri: specify usdhc1 supplies
      ARM: dts: imx7-colibri: specify backlight GPIO
      ARM: dts: imx7-colibri: add MCP2515 CAN controller
      ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) support

Stefan Wahren (1):
      ARM: dts: bcm283x: Use GPIO polarity defines consistently

Sunny Luo (1):
      ARM64: dts: meson-axg: add the SPICC controller

Sylwester Nawrocki (2):
      ARM: dts: exynos: Switch to dedicated Odroid XU3 sound card binding
      ARM: dts: exynos: Add sound support for Odroid XU4

Takeshi Kihara (1):
      arm64: dts: renesas: r8a7795: Increase the number of GPIO bank 1
ports to 29

Tero Kristo (55):
      clk: ti: clkctrl: fix error messages to print out node name properly
      clk: ti: clkctrl: add support for clkdm init for clkctrl clocks
      clk: ti: add support for clkctrl aliases
      clk: ti: clkctrl: use fallback udelay approach if timekeeping is suspended
      clk: ti: convert retry_init param to use void data type
      clk: ti: clkctrl: add support for retrying failed init
      clk: ti: clkctrl: fix flags for mux and divider opt clocks
      clk: ti: omap4: cleanup unnecessary clock aliases
      clk: ti: dra7: drop unnecessary clock aliases
      clk: ti: omap5: cleanup unnecessary clock aliases
      clk: ti: dm814x: cleanup unnecessary clock aliases
      clk: ti: dm816x: cleanup unnecessary clock aliases
      clk: ti: am33xx: cleanup unnecessary clock aliases
      clk: ti: am43xx: cleanup unnecessary clock aliases
      clk: ti: omap3: cleanup unnecessary clock aliases
      dt-bindings: clk: add omap5 clkctrl definitions
      clk: ti: omap5: add clkctrl clock data
      dt-bindings: clk: add dra7 clkctrl definitions
      clk: ti: dra7: add clkctrl clock data
      dt-bindings: clk: add am33xx clkctrl definitions
      clk: ti: am33xx: add clkctrl clock data
      dt-bindings: clk: add am43xx clkctrl definitions
      clk: ti: am43xx: add clkctrl clock data
      dt-bindings: clk: add dm814 clkctrl definitions
      clk: ti: dm814: add clkctrl clock data
      dt-bindings: clk: add dm816 clkctrl definitions
      clk: ti: dm816: add clkctrl clock data
      clk: ti: omap4: clkctrl data fixes for opt-clocks
      ARM: OMAP2+: CM: add support for getting phys address for a
clkctrl register
      ARM: OMAP4: CMINST: add support for translating clkctrl addresses
      ARM: OMAP2+: hwmod: fix clkctrl address translation logic
      ARM: OMAP2+: clockdomain: remove the obsolete clkdm_xlate_address API
      ARM: AM33xx: CM: add support for getting physical address for a register
      ARM: OMAP2+: hwmod: calculate physical register address on am33xx
      ARM: DM816x: hwmod_data: fix clockdomain name for sata hwmod
      ARM: dts: omap5: add fck under timer1
      ARM: dts: omap4: add fck under timer1
      ARM: dts: am33xx: add fck under timers1/2
      ARM: dts: am43xx: add fck under timers1/2
      ARM: dts: dra7: add fck under timer1
      ARM: dts: dm814x: add fck under timers1/2
      ARM: dts: dm816x: add fck under timers1/2
      ARM: dts: omap5: add bus functionality to base PRCM nodes
      ARM: dts: omap4: add bus functionality to base PRCM nodes
      ARM: dts: dra7: add bus functionality to base PRCM nodes
      ARM: dts: am33xx: add bus functionality to base PRCM node
      ARM: dts: am43xx: add bus functionality to base PRCM node
      ARM: dts: dm816x: add bus functionality to base PRCM node
      ARM: dts: omap4: add clkctrl nodes
      ARM: dts: omap5: add clkctrl nodes
      ARM: dts: dra7: add clkctrl nodes
      ARM: dts: am33xx: add clkctrl nodes
      ARM: dts: am43xx: add clkctrl nodes
      ARM: dts: dm814x: add clkctrl nodes
      ARM: dts: dm816x: add clkctrl nodes

Thierry Reding (12):
      dt-bindings: misc: Add Tegra186 MISC registers bindings
      dt-bindings: memory: Add Tegra186 support
      arm64: tegra: Add MISC registers on Tegra186
      arm64: tegra: Add FUSE block on Tegra186
      arm64: tegra: Add memory controller on Tegra186
      arm64: tegra: Enable memory controller on P3310
      arm64: tegra: Add SMMU node for Tegra186
      arm64: tegra: Add display nodes on Tegra186
      arm64: tegra: Mark I2C4 as DDC on P3310
      arm64: tegra: Enable HDMI on Jetson TX2
      arm64: tegra: Fix SD write-protect polarity on Jetson TX2
      arm64: tegra: Use sor1_out clock

Thomas Petazzoni (9):
      ARM: dts: kirkwood: fix pin-muxing of MPP7 on OpenBlocks A7
      arm64: dts: marvell: fix watchdog unit address in Armada AP806
      arm64: dts: marvell: use lower case for unit address and reg property
      arm64: dts: marvell: fix typos in comment describing the NAND controller
      arm64: dts: marvell: fix compatible string list for Armada CP110
slave NAND
      arm64: dts: marvell: use mvebu-icu.h where possible
      arm64: dts: marvell: use aliases for SPI busses on Armada 7K/8K
      arm64: dts: marvell: de-duplicate CP110 description
      arm64: dts: marvell: replace cpm by cp0, cps by cp1

Thor Thayer (1):
      arm64: dts: stratix10: fix SPI settings

Tim Sander (1):
      ARM: dts: socfpga: add i2c reset signals

Tobias Jakobi (1):
      ARM: dts: exynos: Move G2D node to exynos5.dtsi

Tony Lindgren (8):
      Merge branch '4.15-rc1-clkctrl-mach-omap2' of
https://github.com/t-kristo/linux-pm into omap-for-v4.16/soc
      Merge commit 'fe7020e64f04' into omap-for-v4.16/dt-clk
      Merge branch 'omap-for-v4.15/fixes-dt' into omap-for-v4.16/dt
      dt-bindings: ti-sysc: Update binding for timers and capabilities
      Revert "ARM: dts: dra7: Add properties to enable PCIe x2 lane mode"
      Merge commit '20a2742e5784295b9197250b50c40f6d38a55880' into
omap-for-v4.16/dt-clk
      ARM: dts: Fix smartreflex compatible for omap3 shared mpu-iva instance
      ARM: dts: Update ti-sysc data for existing users

Troy Kisky (1):
      ARM: dts: imx: name the interrupts for the fec ethernet driver

Tuomas Tynkkynen (1):
      ARM: dts: sun7i: Enable HDMI on pcDuino3 Nano

Ulrich Hecht (6):
      arm64: dts: renesas: r8a77995: add SYS-DMAC nodes
      arm64: dts: renesas: r8a77995: Add SDHI (MMC) support
      arm64: dts: renesas: r8a77995: Add CAN external clock support
      arm64: dts: renesas: r8a77995: Add CAN support
      arm64: dts: renesas: r8a77995: Add CAN FD support
      arm64: dts: renesas: r8a77995: add DMA for SCIF2

Valentin Schneider (1):
      arm64: dts: hisilicon: Add hi3660 cpu capacity-dmips-mhz information

Vanessa Maegima (1):
      ARM: dts: imx7d-pico-pi: Separate into cpu and baseboard dts

Vignesh R (5):
      ARM: dts: keystone-k2g: Add QSPI DT entry
      ARM: dts: keystone-k2g-evm: Fix botched up merge
      ARM: dts: keystone-k2g: Move ti,non-removable property to board dts
      ARM: dts: keystone-k2g-evm: Add QSPI DT node.
      ARM: dts: keystone-k2g-ice: Add DT nodes for few peripherals

Viresh Kumar (3):
      arm: spear600: Add missing interrupt-parent of rtc
      arm: spear13xx: Fix dmas cells
      arm: spear13xx: Fix spics gpio controller's warning

Vladimir Barinov (2):
      arm64: dts: renesas: ulcb-kf: enable USB2 PHY of channel 0
      arm64: dts: renesas: ulcb-kf: add dr_mode property for USB2.0 channel 0

Vladimir Zapolskiy (1):
      ARM: tegra: Add device tree node to describe IRAM on Tegra20

Wolfram Sang (1):
      arm64: dts: renesas: salvator: set driver type for eMMC

Xingyu Chen (4):
      ARM64: dts: meson: drop "sana" clock from SAR ADC
      ARM: dts: meson: drop "sana" clock from SAR ADC
      documentation: Add compatibles for Amlogic Meson AXG pin controllers
      ARM64: dts: meson-axg: add pinctrl DT info for Meson-AXG SoC

Xo Wang (1):
      ARM: dts: aspeed: Add Ingrasys Zaius BMC machine

Xu YiPing (1):
      arm64: dts: hi3660: improve pmu description

Yan Markman (1):
      arm64: dts: marvell: add Ethernet aliases

Yangbo Lu (1):
      ARM: dts: ls1021a: fix the value of TMR_FIPER1

Yixun Lan (6):
      dt-bindings: clock: add compatible variant for the Meson-AXG
      arm64: dts: meson-axg: add new reset DT node
      arm64: dts: meson-axg: switch uart_ao clock to CLK81
      ARM64: dts: meson-axg: enable IR controller
      ARM64: dts: meson-axg: add ethernet mac controller
      ARM64: dts: meson-axg: enable ethernet for A113D S400 board

Yoshihiro Shimoda (4):
      arm64: dts: renesas: r8a7795: add usb3_phy node
      arm64: dts: renesas: r8a7796: add usb3_phy node
      arm64: dts: renesas: salvator-common: enable usb3_phy0 node
      arm64: dts: renesas: salvator-common: enable usb3_peri0

Yuantian Tang (1):
      arm64: dts: ls208xa: add power monitor chip node

weiyi.lu@mediatek.com (3):
      dt-bindings: soc: add MT2712 power dt-bindings
      arm64: dts: mt2712: Add clock controller device nodes
      arm64: dts: Add power controller device node of MT2712

yinbo.zhu (2):
      ARM: dts: ls1021a: Enable the esdhc
      arm64: dts: ls1088a: Add USB support

Łukasz Stelmach (3):
      ARM: dts: exynos: Remove duplicate definitions of SSS nodes for Exynos5
      ARM: dts: exynos: Add DT nodes for PRNG in Exynos5 SoCs
      ARM: dts: exynos: Add nodes for True Random Number Generator

 Documentation/devicetree/bindings/arm/actions.txt  |   16 +
 .../devicetree/bindings/arm/atmel-at91.txt         |   32 -
 Documentation/devicetree/bindings/arm/axentia.txt  |    9 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |    1 +
 Documentation/devicetree/bindings/arm/shmobile.txt |    4 +
 .../devicetree/bindings/arm/technologic.txt        |   11 +
 Documentation/devicetree/bindings/bus/ti-sysc.txt  |   36 +
 .../bindings/clock/amlogic,gxbb-clkc.txt           |    7 +-
 .../bindings/display/panel/sgd,gktw70sdae4se.txt   |   41 +
 .../bindings/display/simple-framebuffer-sunxi.txt  |    4 +
 Documentation/devicetree/bindings/dma/snps-dma.txt |    2 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |    1 +
 .../memory-controllers/nvidia,tegra30-mc.txt       |    2 +
 .../devicetree/bindings/mfd/atmel-tcb.txt          |   56 +
 .../bindings/misc/nvidia,tegra186-misc.txt         |   12 +
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    2 +
 .../devicetree/bindings/power/actions,owl-sps.txt  |    2 +
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |    4 +-
 .../devicetree/bindings/power/ti-smartreflex.txt   |    2 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |    3 +
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 MAINTAINERS                                        |    2 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/Makefile                         |   47 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |    2 +-
 arch/arm/boot/dts/am335x-boneblue.dts              |   81 +-
 arch/arm/boot/dts/am335x-evm.dts                   |    2 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |    2 +-
 arch/arm/boot/dts/am335x-pepper.dts                |    2 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi               |  205 ++--
 arch/arm/boot/dts/am33xx.dtsi                      |   18 +-
 arch/arm/boot/dts/am3517.dtsi                      |    8 +-
 arch/arm/boot/dts/am4372.dtsi                      |   20 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |    4 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |   14 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |    4 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   10 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               |  230 ++---
 arch/arm/boot/dts/am571x-idk.dts                   |    4 +
 arch/arm/boot/dts/am572x-idk-common.dtsi           |  100 ++
 arch/arm/boot/dts/am572x-idk.dts                   |   93 +-
 arch/arm/boot/dts/am574x-idk.dts                   |   22 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |    4 +-
 arch/arm/boot/dts/animeo_ip.dts                    |   12 +
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi          |    5 -
 arch/arm/boot/dts/armada-38x.dtsi                  |    5 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |    4 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |    5 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |  135 ++-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |  548 ++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |  426 ++++++++
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts       |  458 +++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |  165 +--
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  156 +--
 arch/arm/boot/dts/at91-ariag25.dts                 |   12 +
 arch/arm/boot/dts/at91-ariettag25.dts              |   12 +
 arch/arm/boot/dts/at91-cosino.dtsi                 |   12 +
 arch/arm/boot/dts/at91-foxg20.dts                  |   12 +
 arch/arm/boot/dts/at91-kizbox.dts                  |   12 +
 arch/arm/boot/dts/at91-kizbox2.dts                 |   12 +
 arch/arm/boot/dts/at91-kizboxmini.dts              |   12 +
 arch/arm/boot/dts/at91-linea.dtsi                  |   12 +
 arch/arm/boot/dts/at91-natte.dtsi                  |  244 +++++
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        |  258 +++++
 arch/arm/boot/dts/at91-qil_a9260.dts               |   12 +
 arch/arm/boot/dts/at91-sam9_l9260.dts              |   12 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   12 +
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |  413 ++++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   12 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |   12 +
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |   12 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |   12 +
 arch/arm/boot/dts/at91-sama5d4ek.dts               |   12 +
 arch/arm/boot/dts/at91-vinco.dts                   |   12 +
 arch/arm/boot/dts/at91rm9200.dtsi                  |    8 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |   12 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |    8 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |   12 +
 arch/arm/boot/dts/at91sam9261.dtsi                 |    6 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |   22 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |    6 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |   14 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   12 +
 arch/arm/boot/dts/at91sam9g25ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   10 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   14 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    8 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |   12 +
 arch/arm/boot/dts/at91sam9rl.dtsi                  |    4 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |   12 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    8 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   12 +
 arch/arm/boot/dts/axp81x.dtsi                      |   20 +
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |    2 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |    2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |    4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |    2 +-
 arch/arm/boot/dts/dm814x-clocks.dtsi               |   30 +
 arch/arm/boot/dts/dm814x.dtsi                      |    4 +
 arch/arm/boot/dts/dm816x-clocks.dtsi               |   30 +
 arch/arm/boot/dts/dm816x.dtsi                      |    9 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |    8 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi             |    4 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    2 +-
 arch/arm/boot/dts/dra7.dtsi                        |  165 ++-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |    4 +-
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi          |    4 +
 arch/arm/boot/dts/dra72x.dtsi                      |   16 +-
 arch/arm/boot/dts/dra74x.dtsi                      |   18 +-
 arch/arm/boot/dts/dra76-evm.dts                    |   17 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  909 ++++-------------
 arch/arm/boot/dts/efm32gg-dk3750.dts               |    2 +-
 arch/arm/boot/dts/ethernut5.dts                    |   12 +
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |    5 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |    5 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |    5 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          |    7 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |    5 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   39 +-
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |    6 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   62 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |    7 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |    7 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |    7 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |    7 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |    7 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |   15 +-
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |    5 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |    5 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    5 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |    7 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    7 +-
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |    7 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    7 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          |    9 +-
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |    5 +-
 arch/arm/boot/dts/exynos4412-prime.dtsi            |    5 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |    7 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   29 +-
 arch/arm/boot/dts/exynos4412.dtsi                  |  100 +-
 arch/arm/boot/dts/exynos5.dtsi                     |   50 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |    5 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |    7 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    5 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |    5 +-
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |    5 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |    5 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |    5 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |  133 ++-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          |    7 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |    7 +-
 arch/arm/boot/dts/exynos5260.dtsi                  |   33 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |    5 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |    5 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |    7 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   21 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    7 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |   15 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |    5 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    7 +-
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |    6 +-
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      |    6 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |   76 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |   15 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   13 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |    7 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  |   67 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |    7 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |    7 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |    7 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         |   59 +-
 arch/arm/boot/dts/exynos5440-sd5v1.dts             |    7 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          |    7 +-
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |    6 +-
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      |    6 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |   21 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    |    7 +-
 arch/arm/boot/dts/exynos54xx.dtsi                  |   31 +-
 arch/arm/boot/dts/ge863-pro3.dtsi                  |   12 +
 arch/arm/boot/dts/gemini-dlink-dir-685.dts         |   67 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts         |  303 ++++++
 arch/arm/boot/dts/gemini-nas4220b.dts              |   69 ++
 arch/arm/boot/dts/gemini-rut1xx.dts                |   25 +
 arch/arm/boot/dts/gemini-wbd111.dts                |   47 +
 arch/arm/boot/dts/gemini-wbd222.dts                |   60 ++
 arch/arm/boot/dts/gemini.dtsi                      |   44 +-
 arch/arm/boot/dts/imx25.dtsi                       |    2 +
 arch/arm/boot/dts/imx27-pdk.dts                    |    1 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |    1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |    1 +
 arch/arm/boot/dts/imx28-ts4600.dts                 |   79 ++
 arch/arm/boot/dts/imx35.dtsi                       |    2 +
 arch/arm/boot/dts/imx51-babbage.dts                |   77 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |    1 +
 arch/arm/boot/dts/imx51-ts4800.dts                 |    6 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |   12 +-
 arch/arm/boot/dts/imx51.dtsi                       |    1 +
 arch/arm/boot/dts/imx53-cx9020.dts                 |    2 +-
 arch/arm/boot/dts/imx53-m53.dtsi                   |    1 -
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |  232 +++--
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   14 +-
 arch/arm/boot/dts/imx53.dtsi                       |   48 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |   50 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |   48 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts  |   52 +
 arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts       |   51 +
 arch/arm/boot/dts/imx6dl-cubox-i.dts               |    2 +
 .../boot/dts/imx6dl-hummingboard-emmc-som-v15.dts  |   53 +
 arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dts  |   52 +
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |    2 +
 .../boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts |   55 +
 arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts |   54 +
 arch/arm/boot/dts/imx6dl-hummingboard2.dts         |   53 +
 arch/arm/boot/dts/imx6dl-pinfunc.h                 |    1 +
 arch/arm/boot/dts/imx6dl-ts7970.dts                |   50 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   12 +-
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |    2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |    2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |    2 +-
 arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts   |   60 ++
 arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts        |   59 ++
 arch/arm/boot/dts/imx6q-cubox-i.dts                |    2 +
 arch/arm/boot/dts/imx6q-display5.dtsi              |    2 +-
 arch/arm/boot/dts/imx6q-h100.dts                   |   33 +-
 .../boot/dts/imx6q-hummingboard-emmc-som-v15.dts   |   61 ++
 arch/arm/boot/dts/imx6q-hummingboard-som-v15.dts   |   60 ++
 arch/arm/boot/dts/imx6q-hummingboard.dts           |    2 +
 .../boot/dts/imx6q-hummingboard2-emmc-som-v15.dts  |   63 ++
 arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts  |   62 ++
 arch/arm/boot/dts/imx6q-hummingboard2.dts          |   61 ++
 arch/arm/boot/dts/imx6q-pinfunc.h                  |    1 +
 arch/arm/boot/dts/imx6q-ts7970.dts                 |   54 +
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts     |  235 +++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |    1 -
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |   44 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   73 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |   76 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |    1 -
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |   72 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  103 +-
 arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi  |   72 ++
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       |  540 ++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |   10 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   17 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    9 +
 ...6qdl-microsom.dtsi => imx6qdl-sr-som-brcm.dtsi} |   41 +-
 arch/arm/boot/dts/imx6qdl-sr-som-emmc.dtsi         |   70 ++
 arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi           |  170 ++++
 ...dl-microsom-ar8035.dtsi => imx6qdl-sr-som.dtsi} |   36 +-
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi              |  594 +++++++++++
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |   25 +-
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi            |  503 +++++++++
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi     |    5 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |   14 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  161 +--
 arch/arm/boot/dts/imx6sl-evk.dts                   |  133 ++-
 arch/arm/boot/dts/imx6sl.dtsi                      |   48 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  220 ++--
 arch/arm/boot/dts/imx6sx.dtsi                      |   93 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |   19 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   49 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi        |   39 +-
 arch/arm/boot/dts/imx7-colibri.dtsi                |  116 ++-
 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts   |   19 +
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi          |   21 +
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts        |   13 +-
 arch/arm/boot/dts/imx7d-colibri.dtsi               |    4 +
 arch/arm/boot/dts/imx7d-pico-pi.dts                |  181 ++++
 .../boot/dts/{imx7d-pico.dts => imx7d-pico.dtsi}   |  133 ---
 arch/arm/boot/dts/imx7d.dtsi                       |   22 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  133 +--
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |  122 +++
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           |   87 ++
 arch/arm/boot/dts/keystone-clocks.dtsi             |   59 +-
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi         |   15 +-
 arch/arm/boot/dts/keystone-k2e-evm.dts             |   13 +-
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi          |    7 +-
 arch/arm/boot/dts/keystone-k2e.dtsi                |   11 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts             |  115 ++-
 arch/arm/boot/dts/keystone-k2g-ice.dts             |  339 +++++-
 arch/arm/boot/dts/keystone-k2g.dtsi                |   58 +-
 arch/arm/boot/dts/keystone-k2hk-clocks.dtsi        |   81 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts            |   59 +-
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi         |    7 +-
 arch/arm/boot/dts/keystone-k2hk.dtsi               |   11 +-
 arch/arm/boot/dts/keystone-k2l-clocks.dtsi         |   51 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts             |   13 +-
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi          |    7 +-
 arch/arm/boot/dts/keystone-k2l.dtsi                |   55 +-
 arch/arm/boot/dts/keystone.dtsi                    |   18 +-
 arch/arm/boot/dts/kirkwood-linksys-viper.dts       |   10 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |   10 +-
 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts   |   17 +
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |  249 +----
 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi    |  256 +++++
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |   27 -
 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts  |   17 +
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  411 +-------
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   |  395 +++++++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   84 --
 arch/arm/boot/dts/lpc3250-ea3250.dts               |    4 +-
 arch/arm/boot/dts/lpc3250-phy3250.dts              |    4 +-
 arch/arm/boot/dts/lpc4337-ciaa.dts                 |    6 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |    2 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts        |    2 +-
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        |  241 +++++
 arch/arm/boot/dts/ls1021a-qds.dts                  |    7 +-
 arch/arm/boot/dts/ls1021a-twr.dts                  |    6 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |   30 +-
 arch/arm/boot/dts/meson8.dtsi                      |   29 +-
 arch/arm/boot/dts/meson8b.dtsi                     |   24 +-
 arch/arm/boot/dts/mpa1600.dts                      |   12 +
 arch/arm/boot/dts/mt2701.dtsi                      |    2 +
 arch/arm/boot/dts/mt7623.dtsi                      |    5 +-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      |    2 +-
 arch/arm/boot/dts/mt7623n-rfb-nand.dts             |    2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |    8 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts               |    8 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |    2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |    8 +-
 arch/arm/boot/dts/omap3-n9.dts                     |    7 +
 arch/arm/boot/dts/omap3-n900.dts                   |    8 +-
 arch/arm/boot/dts/omap3-n950.dts                   |   88 ++
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   14 -
 arch/arm/boot/dts/omap34xx.dtsi                    |   39 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   46 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |    6 +-
 arch/arm/boot/dts/omap4.dtsi                       |  141 ++-
 arch/arm/boot/dts/omap44xx-clocks.dtsi             |  895 ++++++----------
 arch/arm/boot/dts/omap5.dtsi                       |   46 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi             |  623 ++++--------
 arch/arm/boot/dts/openbmc-flash-layout.dtsi        |   32 +
 arch/arm/boot/dts/owl-s500-sparky.dts              |   43 +
 .../boot/dts/{wd-mbwe.dts => ox810se-wd-mbwe.dts}  |    0
 ...ts => ox820-cloudengines-pogoplug-series-3.dts} |    0
 arch/arm/boot/dts/pm9g45.dts                       |   12 +
 arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts   |   34 +
 arch/arm/boot/dts/r7s72100-genmai.dts              |    2 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     |    5 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |    5 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |    5 +-
 arch/arm/boot/dts/r8a7743.dtsi                     |  607 ++++++++++-
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts |  158 +++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        |  183 +++-
 arch/arm/boot/dts/r8a7745.dtsi                     |  585 ++++++++++-
 arch/arm/boot/dts/r8a7778.dtsi                     |   12 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |   12 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |    5 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |   25 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   19 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   22 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |   67 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |   22 +-
 arch/arm/boot/dts/r8a7794-alt.dts                  |    5 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |   27 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts             |    1 +
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi             |    5 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |    5 +-
 arch/arm/boot/dts/s3c2416.dtsi                     |    5 +-
 arch/arm/boot/dts/s3c24xx.dtsi                     |    5 +-
 arch/arm/boot/dts/s3c6400.dtsi                     |    7 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             |    7 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts             |    7 +-
 arch/arm/boot/dts/s3c6410.dtsi                     |    7 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             |    5 +-
 arch/arm/boot/dts/s3c64xx.dtsi                     |    5 +-
 arch/arm/boot/dts/s5pv210-aquila.dts               |    5 +-
 arch/arm/boot/dts/s5pv210-goni.dts                 |    5 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |    5 +-
 arch/arm/boot/dts/s5pv210-smdkc110.dts             |    5 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |    5 +-
 arch/arm/boot/dts/s5pv210-torbreck.dts             |    5 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |    8 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |   10 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |    4 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |    4 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |   12 +
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              |   12 +
 arch/arm/boot/dts/sama5d3xmb.dtsi                  |    2 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi              |    2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   18 +-
 arch/arm/boot/dts/sh73a0.dtsi                      |    3 -
 arch/arm/boot/dts/socfpga.dtsi                     |    4 +
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |    1 +
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |    2 +-
 arch/arm/boot/dts/spear1310-evb.dts                |    2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |    4 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |    6 +-
 arch/arm/boot/dts/spear600.dtsi                    |    1 +
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         |    1 +
 arch/arm/boot/dts/stih407.dtsi                     |    3 +-
 arch/arm/boot/dts/stih410.dtsi                     |    3 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |    4 +
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |   25 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |   19 +
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |   17 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |   61 ++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  234 +++++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts    |   91 ++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |    1 -
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts |  196 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |    3 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |   11 +
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |   17 +
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |    1 -
 arch/arm/boot/dts/sun8i-h3.dtsi                    |    4 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   38 +
 arch/arm/boot/dts/tegra20.dtsi                     |   35 +
 arch/arm/boot/dts/tny_a9260_common.dtsi            |   12 +
 arch/arm/boot/dts/tny_a9263.dts                    |   12 +
 arch/arm/boot/dts/uniphier-ld4-ref.dts             |    2 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi                |   23 +
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            |    2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |    2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi               |   27 +
 arch/arm/boot/dts/uniphier-pro5.dtsi               |   33 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |   19 +
 arch/arm/boot/dts/uniphier-sld8-ref.dts            |    2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi               |   23 +
 arch/arm/boot/dts/usb_a9260_common.dtsi            |   12 +
 arch/arm/boot/dts/usb_a9263.dts                    |   12 +
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |    2 +-
 arch/arm/boot/dts/vf500.dtsi                       |    2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |   20 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |    4 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |    4 +
 arch/arm/boot/dts/vfxxx.dtsi                       |   10 +-
 arch/arm/mach-meson/Kconfig                        |    1 +
 arch/arm/mach-omap2/clockdomain.c                  |    8 -
 arch/arm/mach-omap2/clockdomain.h                  |    2 -
 arch/arm/mach-omap2/cm.h                           |    7 +-
 arch/arm/mach-omap2/cm2xxx.c                       |    2 +-
 arch/arm/mach-omap2/cm33xx.c                       |    8 +-
 arch/arm/mach-omap2/cm3xxx.c                       |    2 +-
 arch/arm/mach-omap2/cm_common.c                    |   16 +-
 arch/arm/mach-omap2/cminst44xx.c                   |   12 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |   73 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |    2 +-
 arch/arm64/boot/dts/actions/Makefile               |    2 +
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |   46 +
 arch/arm64/boot/dts/actions/s700.dtsi              |  169 +++
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |   36 +
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |   23 +
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  125 ++-
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |   19 +-
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |    2 +-
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |    2 +-
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |    2 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |   34 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |    4 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   16 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |    4 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   13 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  343 ++++++-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |   12 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   19 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |    1 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   32 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |    1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   46 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |   12 +
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |   12 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   46 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |   15 +
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts     |    3 +-
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |    5 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |   19 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    5 +-
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |    5 +-
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  147 ++-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |    7 +-
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |    7 +-
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |    6 +-
 .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |    6 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |    9 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |    8 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   97 ++
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |   12 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |    1 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   30 +-
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts      |    6 +
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     |   12 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |    1 +
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |    1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   21 +
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   52 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |   37 +-
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |    2 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |  111 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |   82 +-
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |    2 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |   93 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   10 +-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |   10 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  443 --------
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |  441 --------
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  424 ++++++++
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |   27 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  188 ++++
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   18 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   92 ++
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   51 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   10 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  351 +++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |   23 +
 arch/arm64/boot/dts/nvidia/tegra210-p2530.dtsi     |   23 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |    4 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |    1 +
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |   88 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   29 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |   82 +-
 arch/arm64/boot/dts/renesas/Makefile               |    3 +-
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |    2 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |   85 ++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    2 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |    2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  379 +++++--
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |    2 +-
 .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |   58 ++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  373 +++++--
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |   23 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |   55 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |  115 ++-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  234 +++++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |   50 +
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   29 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   47 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |   29 +
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   42 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   85 +-
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |    2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |    6 +-
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |    2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |    3 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   16 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |    3 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi               |  114 +++
 arch/arm64/boot/dts/sprd/whale2.dtsi               |   62 +-
 drivers/clk/ti/apll.c                              |    3 +-
 drivers/clk/ti/clk-33xx.c                          |  279 +++--
 drivers/clk/ti/clk-3xxx.c                          |  263 +----
 drivers/clk/ti/clk-43xx.c                          |  295 ++++--
 drivers/clk/ti/clk-44xx.c                          |  200 ++--
 drivers/clk/ti/clk-54xx.c                          |  697 +++++++++----
 drivers/clk/ti/clk-7xx.c                           | 1076 +++++++++++++++-----
 drivers/clk/ti/clk-814x.c                          |   50 +-
 drivers/clk/ti/clk-816x.c                          |   62 +-
 drivers/clk/ti/clk.c                               |   70 +-
 drivers/clk/ti/clkctrl.c                           |   91 +-
 drivers/clk/ti/clock.h                             |   13 +-
 drivers/clk/ti/composite.c                         |    3 +-
 drivers/clk/ti/dpll.c                              |    3 +-
 include/dt-bindings/bus/ti-sysc.h                  |   22 +
 include/dt-bindings/clock/am3.h                    |  108 ++
 include/dt-bindings/clock/am4.h                    |  113 ++
 include/dt-bindings/clock/aspeed-clock.h           |   52 +
 include/dt-bindings/clock/axg-clkc.h               |   71 ++
 include/dt-bindings/clock/dm814.h                  |   45 +
 include/dt-bindings/clock/dm816.h                  |   53 +
 include/dt-bindings/clock/dra7.h                   |  172 ++++
 include/dt-bindings/clock/omap5.h                  |  118 +++
 include/dt-bindings/gpio/aspeed-gpio.h             |   49 +
 include/dt-bindings/memory/tegra186-mc.h           |  111 ++
 include/dt-bindings/pinctrl/am43xx.h               |    3 +-
 include/dt-bindings/power/mt2712-power.h           |   26 +
 include/dt-bindings/power/owl-s700-powergate.h     |   19 +
 577 files changed, 23197 insertions(+), 7952 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644
Documentation/devicetree/bindings/misc/nvidia,tegra186-misc.txt
 create mode 100644 arch/arm/boot/dts/am572x-idk-common.dtsi
 create mode 100644 arch/arm/boot/dts/am574x-idk.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
 create mode 100644 arch/arm/boot/dts/at91-natte.dtsi
 create mode 100644 arch/arm/boot/dts/at91-nattis-2-natte-2.dts
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
 create mode 100644 arch/arm/boot/dts/gemini-dlink-dns-313.dts
 create mode 100644 arch/arm/boot/dts/imx28-ts4600.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-ts7970.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ts7970.dts
 create mode 100644 arch/arm/boot/dts/imx6q-var-dt6customboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
 rename arch/arm/boot/dts/{imx6qdl-microsom.dtsi =>
imx6qdl-sr-som-brcm.dtsi} (85%)
 create mode 100644 arch/arm/boot/dts/imx6qdl-sr-som-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi
 rename arch/arm/boot/dts/{imx6qdl-microsom-ar8035.dtsi =>
imx6qdl-sr-som.dtsi} (84%)
 create mode 100644 arch/arm/boot/dts/imx6qdl-ts7970.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pico-pi.dts
 rename arch/arm/boot/dts/{imx7d-pico.dts => imx7d-pico.dtsi} (71%)
 create mode 100644 arch/arm/boot/dts/logicpd-som-lv-35xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-35xx-devkit.dts
 create mode 100644 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
 create mode 100644 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout.dtsi
 create mode 100644 arch/arm/boot/dts/owl-s500-sparky.dts
 rename arch/arm/boot/dts/{wd-mbwe.dts => ox810se-wd-mbwe.dts} (100%)
 rename arch/arm/boot/dts/{cloudengines-pogoplug-series-3.dts =>
ox820-cloudengines-pogoplug-series-3.dts} (100%)
 create mode 100644 arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700-cubieboard7.dts
 create mode 100644 arch/arm64/boot/dts/actions/s700.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-common.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
 create mode 100644 include/dt-bindings/bus/ti-sysc.h
 create mode 100644 include/dt-bindings/clock/am3.h
 create mode 100644 include/dt-bindings/clock/am4.h
 create mode 100644 include/dt-bindings/clock/aspeed-clock.h
 create mode 100644 include/dt-bindings/clock/axg-clkc.h
 create mode 100644 include/dt-bindings/clock/dm814.h
 create mode 100644 include/dt-bindings/clock/dm816.h
 create mode 100644 include/dt-bindings/clock/dra7.h
 create mode 100644 include/dt-bindings/clock/omap5.h
 create mode 100644 include/dt-bindings/gpio/aspeed-gpio.h
 create mode 100644 include/dt-bindings/memory/tegra186-mc.h
 create mode 100644 include/dt-bindings/power/mt2712-power.h
 create mode 100644 include/dt-bindings/power/owl-s700-powergate.h
