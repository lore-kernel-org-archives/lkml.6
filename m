Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeDEVVj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:21:39 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:46287 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDEVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:21:35 -0400
X-Google-Smtp-Source: AIpwx49ArBex1EqVncr7Lh3t0nUJ9Ez+T8P6SNUU4/059nQiBxb7CKVjF1NqTsHFwxEVCgTCmh4tOiMqaLvUokWNWzQ=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 23:21:30 +0200
X-Google-Sender-Auth: j8ZAAZEEl4dwfhfUoVZ7xoRiWoI
Message-ID: <CAK8P3a1=Z-OmJSRx+BiMiDjSS5mkHFUNAGv+Aci9reuJ8_UOeg@mail.gmail.com>
Subject: [GIT PULL 1/3] ARM: SoC device tree updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w35LM6q9020395

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 518d2f43c358da2072948f64df99b1bd417288dc:

  arm: dts: modify Nuvoton NPCM7xx device tree structure (2018-04-05
11:13:39 +0200)

----------------------------------------------------------------
ARM: SoC device tree updates for 4.17

This is the usual set of changes for device trees, with over 700
non-merged changesets. There is an ongoing set of dtc warning fixes and
the usual bugfixes, cleanups and added device support.

The most interesting bit as usual is support for new machines listed
below:

- The Allwinner H6 makes its debut with the Pine-H64 board, and we get
  two new machines based on its older siblings: the H5 based OrangePi
  Zero+ and the A64 based Teres-I Laptop from Olimex. On the 32-bit side,
  we add The Olimex som204 based on Allwinner A20, and the Banana Pi M2
  Zero development board (based on H2).

- NVIDIA adds support for Tegra194 aka "Xavier", plus their p2972
  development board and p2888 CPU module.

- The Nuvoton npcm750 is a BMC that was newly added, for now we only
  support running on the evaluation board.

- STmicroelectronics stm32 gains support for the stm32mp157c and two
  evaluation boards.

- The Toradex Colibri board family grows a few members based on the
  i.MX6ULL variant.

- The Advantec DMS-BA16 is a Qseven module using the NXP i.MX6
  family of chips.

- The Phytec phyBOARD Mira is a family of industrial boards based on
  i.MX6. For now, four models get added.

- TI am335x based PDU-001 is an industrial embedded machine used for
  traffic monitoring

- The Aspeed platform now supports running on the BMC on the Qualcomm
  Centriq 2400 server

- Samsung Exynos4 based Galaxy S3 is a family of mobile phones Qualcomm
  msm8974 based Galaxy S5 is a rather different phone made by the same
  company.

- The Xilinx Zynq and ZynqMP platforms now gained a lot of dts file
  for the various boards made by Xilinx themselves, as well as the
  Digilent Zybo Z7.

- The ARM Versatile family now supports the "IB2" interface board.

- The Renesas H2 based "Stout" and the H3 based Salvator-X are more
  evaluation boards named after a kind of beer, as most of them are.
  The r8a77980 (V3H) based "Condor" apparently doesn't follow that
  tradition. ;-)

- ROC-RK3328-CC is a simple developement board from the Libre Computer
  Project, based on the Rockchips RK3328 SoC

- Haiku is another development board plus Qseven module based on Rockchips
  RK3368 and made by Theobroma Systems.

----------------------------------------------------------------
Aapo Vienamo (1):
      ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet

Adam Ford (3):
      ARM: dts: da850-evm: add chosen and SPI alias
      ARM: dts: Add pinmuxing for i2c2 and i2c3 for LogicPD torpedo
      ARM: dts: Add pinmuxing for i2c2 and i2c3 for LogicPD SOM-LV

Alexandre Belloni (2):
      ARM: dts: armada: netgear-rn*: fix rtc node name
      ARM: dts: at91: sam9rl: Properly assign copyright

Alexandre Torgue (2):
      dt-bindings: pinctrl: Add st,stm32f769-pinctrl compatible to stm32-pinctrl
      ARM: dts: stm32: use dedicated files for pinctrl on stm32f7 family

Amelie Delaunay (9):
      ARM: dts: stm32: add gadget fifo sizes to usbotg_hs on stm32f746
      ARM: dts: stm32: select otg mode for usbotg_hs on stm32746g_eval
      ARM: dts: stm32: enable USB HS on stm32f769-disco
      ARM: dts: stm32: enable RTC on stm32f769-disco
      ARM: dts: stm32: add USB OTG HS and FS support for STM32H743 SoC
      ARM: dts: stm32: enable USB OTG HS on stm32h743i-eval
      ARM: dts: stm32: add RTC support on STM32H743
      ARM: dts: stm32: enable RTC on stm32h743i-eval
      ARM: dts: stm32: add SPI support on STM32H743 SoC

Andrea Merello (1):
      ARM: dts: stm32: Add pin map for SDIO controller on stm32f4

Andrew F. Davis (8):
      ARM: dts: keystone: Move keystone_irq to under device-state-control
      ARM: dts: keystone: Move reset-controller to under device-state-control
      ARM: dts: keystone-k2e: Move keystone_dsp_gpio to under
device-state-control
      ARM: dts: keystone-k2l: Move keystone_dsp_gpio to under
device-state-control
      ARM: dts: keystone-k2hk: Move keystone_dsp_gpio to under
device-state-control
      ARM: dts: keystone-k2g: Move keystone_irq to under device-state-control
      ARM: dts: keystone-k2g: Move keystone_dsp_gpio to under
device-state-control
      ARM: dts: keystone-k2g: Move usb-phy nodes out of soc0

Andrew Jeffery (1):
      ARM: dts: palmetto: Request mux as per strapping configuration

Andrey Smirnov (2):
      ARM: dts: imx6: RDU2: Add RAVE SP device
      ARM: dts: imx51-zii-rdu1: Add node for RAVE SP device

Andrzej Hajda (2):
      arm64: dts: exynos: add micro-USB connector node to TM2 platforms
      arm64: dts: exynos: add OF graph between MHL and USB connector

Anson Huang (6):
      ARM: dts: imx6ul: remove unnecessary clocks for cpu-freq
      ARM: dts: imx6sx: add pu power domain support
      ARM: dts: imx6sx: add ARM power domain support
      clk: imx: imx7d: add the snvs clock
      ARM: dts: imx7s: add snvs rtc clock
      ARM: dts: imx7s: add temperature monitor support

Anurag Kumar Vulisha (1):
      arm64: zynqmp: Added OOB timing settings in zynqmp-ep108.dts

Arnd Bergmann (48):
      Merge tag 'sti-dt-for-v4.17-round1' of
ssh://gitolite.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'davinci-for-v4.17/dt' of
ssh://gitolite.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'juno-updates-4.17' of
ssh://gitolite.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'omap-for-v4.17/dt-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'keystone_dts_for_4.17' of
ssh://gitolite.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'omap-for-v4.17/dt-sdhci-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'stm32-dt-for-v4.17-1' of
ssh://gitolite.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'samsung-dt-4.17' of
ssh://gitolite.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.17' of
ssh://gitolite.kernel.org/.../krzk/linux into next/dt
      Merge tag 'xilinx-dt-for-4.17' of
https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'hisi-arm64-dt-for-4.17' of
git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'mvebu-dt-4.17-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt64-4.17-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'at91-ab-4.17-dt' of
ssh://gitolite.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'arm-soc/for-4.17/devicetree' of
https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'aspeed-4.17-devicetree' of
ssh://gitolite.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'uniphier-dt-v4.17' of
ssh://gitolite.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'imx-dt-newclk-4.17' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt-4.17' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt64-4.17' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'tegra-for-4.17-dt-bindings' of
ssh://gitolite.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.17-arm-dt' of
ssh://gitolite.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.17-arm64-dt' of
ssh://gitolite.kernel.org/.../tegra/linux into next/dt
      Merge tag 'renesas-arm64-dt-for-v4.17' of
ssh://gitolite.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-bindings-for-v4.17' of
ssh://gitolite.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-for-v4.17' of
ssh://gitolite.kernel.org/.../horms/renesas into next/dt
      Merge tag 'samsung-dt-4.17-2' of
ssh://gitolite.kernel.org/.../krzk/linux into next/dt
      Merge tag 'v4.16-next-dts32' of
ssh://gitolite.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'v4.16-next-dts64' of
ssh://gitolite.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'mvebu-dt64-4.17-2' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'amlogic-dt64' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'armsoc-versatile-drm-dts' of
ssh://gitolite.kernel.org/.../linusw/linux-integrator into next/dt
      Merge tag 'qcom-arm64-for-4.17' of
ssh://gitolite.kernel.org/.../agross/linux into next/dt
      Merge tag 'qcom-dts-for-4.17' of
ssh://gitolite.kernel.org/.../agross/linux into next/dt
      Merge tag 'amlogic-dt-1' of
ssh://gitolite.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'at91-ab-4.17-dt2' of
ssh://gitolite.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'sunxi-dt-for-4.17' of
ssh://gitolite.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.17' of
ssh://gitolite.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-h3-h5-for-4.17' of
ssh://gitolite.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'omap-for-v4.17/dt-pt2-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'socfpga_dts_for_v4.17' of
ssh://gitolite.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'imx-dt64-4.17-2' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'mvebu-dt-4.17-2' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt-4.17-spdx' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'v4.17-rockchip-dts32-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.17-rockchip-dts64-1' of
ssh://gitolite.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'uniphier-dt-v4.17-2' of
ssh://gitolite.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'imx-dt-4.17-2' of
ssh://gitolite.kernel.org/.../shawnguo/linux into next/dt

Bai Ping (1):
      ARM: dts: imx6ull: add additional pinfunc defines for i.MX 6ULL

Baolin Wang (7):
      arm64: dts: Add hwspinlock node for Spreadtrum SC9860
      arm64: dts: Add ADI device node for Spreadtrum SC9860
      arm64: dts: Add pin controller node for Spreadtrum SC9860
      arm64: dts: Add timer node for Spreadtrum SC9860
      arm64: dts: Add watchdog device node for Spreadtrum SC9860
      arm64: dts: Add DMA device node for Spreadtrum SC9860
      arm64: dts: Add SC2731 PMIC dts file for Spreadtrum SC9860

Bartosz Golaszewski (11):
      ARM: dts: use 'atmel' as at24 manufacturer for imx6qdl-zii-rdu2
      ARM: dts: use 'atmel' as at24 manufacturer for imx6qdl-rex
      ARM: dts: fix the at24 compatible string in imx6q-h100
      ARM: dts: at91: use 'atmel' as at24 manufacturer for sama5d34ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9260ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9g20ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91-sama5d2_ptc_ek
      ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9263ek
      ARM: dts: use 'atmel' as at24 manufacturer in am335x-boneblue
      ARM: dts: da850-lego-ev3: use a correct fallback for at24 compatible
      ARM: dts: use 'atmel' as at24 manufacturer for qcom-apq8064-cm-qs600

Baruch Siach (6):
      arm64: dts: marvell: add CP110 uart peripherals
      arm64: dts: marvell: mcbin: enable uart headers
      arm64: dts: marvell: mcbin: fix board name typo
      ARM: dts: bcm2835: make the firmware node into a bus
      ARM: dts: bcm2837-rpi-3-b: add GPIO expander
      ARM: dts: hummingboard: Remove mention of nonexistent node

Benjamin Gaignard (4):
      ARM: dts: stm32: Add leds support to stm32f469 Discovery board
      ARM: dts: stm32: Add leds support to stm32f769 Discovery board
      ARM: dts: stm32: Add push button to stm32f469 Discovery board
      ARM: dts: stm32: Add push button to stm32f769 Discovery board

Benoît Thébaudeau (2):
      ARM: dts: imx25-pinfunc: Use consistent naming for eSDHC
      ARM: dts: imx25-pinfunc: Always set SION for eSDHC CMD

Biju Das (4):
      ARM: dts: r8a7743: Add IPMMU DT nodes
      ARM: dts: r8a7745: Add IPMMU DT nodes
      ARM: dts: r8a7743: Add VSP support
      ARM: dts: r8a7745: Add VSP support

Bjorn Andersson (1):
      arm64: dts: msm8996: Add rmtfs sharedmem node

Brendan Higgins (1):
      arm: dts: add Nuvoton NPCM750 device tree

Brian Norris (1):
      ARM: dts: rockchip: drop veyron's nonstandard 'backlight-boot-off'

Chen-Yu Tsai (14):
      ARM: dts: sun8i: a83t: bananapi-m3: Add LED device nodes
      ARM: dts: sun9i: Add CCI-400 device nodes for A80
      ARM: dts: sun9i: Add CPUCFG device node for A80 dtsi
      ARM: dts: sun9i: Add PRCM device node for the A80 dtsi
      ARM: dts: sun9i: Add secure SRAM node used for SMP hotplug
      ARM: dts: sun9i: Add enable-method for SMP support for the A80 SoC
      ARM: dts: sun8i: a33: Drop GPIO pinmux settings for A33-OLinuXino
      ARM: dts: sun8i: a33: Drop sunxi-common-regulators.dtsi for A33-OLinuXino
      ARM: dts: sun8i: a33: Enable PMIC power supplies on A33-OLinuXino
      ARM: dts: sun8i: a33: Enable A33 internal audio codec on A33-OLinuXino
      ARM: dts: sun8i: reference tablet design: Enable PMIC power supplies
      ARM: dts: sun9i: Add device nodes for documented display pipelines for A80
      ARM: dts: sun9i: Add pinmux settings for LCD0 RGB888 output.
      ARM: dts: sun9i: cubieboard4: Enable VGA display output

Chris Zhong (2):
      arm64: dts: rockchip: add cdn-dp node for rk3399.
      arm64: dts: rockchip: enable DP for rk3399-gru

Christian Hemp (2):
      ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6Quad/Dual RDK
      ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6 DualLight/Solo RDK

Chunfeng Yun (1):
      arm64: dts: mt7622: add usb device nodes

Craig Tatlor (1):
      ARM: dts: msm8974: castor: Fix typo and add startup delay in
touchscreen node

Daniele Debernardi (1):
      ARM: dts: qcom: Add initial DTS file for Samsung Galaxy S5 phone

Dave Gerlach (9):
      ARM: dts: am33xx: Reserve pm code and data regions in ocmcram sram node
      ARM: dts: am4372: Reserve pm code and data regions in ocmcram sram node
      ARM: dts: am33xx: Update emif node
      ARM: dts: am4372: Update emif node
      ARM: dts: am33xx: Add pm-sram phandle to soc node
      ARM: dts: am4372: Add soc node
      ARM: dts: am33xx: Mark emif with ti,no-idle
      ARM: dts: am4372: Mark emif with ti,no-idle
      ARM: dts: am4372: Mark omap_l3_noc with ti,no-idle

David Lechner (1):
      ARM: dts: da850-lego-ev3: Add node for reboot modes

Dien Pham (4):
      arm64: dts: renesas: r8a7795: Add OPPs table for cpu devices
      arm64: dts: renesas: r8a7796: Add OPPs table for cpu devices
      arm64: dts: renesas: r8a7796: Update OPPs to support CA53 dfs
      arm64: dts: renesas: r8a7795: Update OPPs to support CA53 dfs

Dinh Nguyen (2):
      arm64: dts: stratix10: enable watchdog timer on the S10 devkit
      arm64: dts: stratix10: disable false USB overcurrent on devkit

Dmitry Osipenko (2):
      ARM: tegra: Add IRAM node on Tegra30
      ARM: tegra: Add video decoder node on Tegra30

Dmitry Shmidt (1):
      arm64: dts: hi6220: enable watchdog

Emiliano Ingrassia (2):
      ARM: dts: meson8b: extend ethernet controller description
      ARM: dts: meson8b-odroidc1: ethernet support

Emmanuel Vadot (1):
      ARM: dts: sun8i: h3: Add eMMC for NanoPi M1 Plus

Enrico Scholz (1):
      ARM: dts: imx6: Add support for phyBOARD-Mira with i.MX 6QuadPlus

Eric Anholt (1):
      ARM: bcm2835: Add the DPI hardware to the device tree.

Fabio Estevam (27):
      arm64: dts: ls1012a: Move cpu_thermal out of bus node
      arm64: dts: ls1043a: Move cpu_thermal out of bus node
      arm64: dts: ls1046a: Move cpu_thermal out of bus node
      arm64: dts: ls1088a: Move cpu_thermal out of bus node
      arm64: dts: ls208xa: Move cpu_thermal out of bus node
      arm64: dts: ls208xa-qds: Pass unit name to dspi child nodes
      arm64: dts: ls208xa-qds: Fix the 'reg' property
      ARM: dts: imx23: Pass unit address and reg to IOMUX node
      ARM: dts: imx28: Pass unit address and reg to IOMUX node
      ARM: dts: imx28-tx28: Pass unit address and reg to IOMUX node
      ARM: dts: imx28-apx4devkit: Pass unit address and reg to IOMUX node
      ARM: dts: imx28-cfa10049: Move i2cmux out of bus node
      ARM: dts: imx27-eukrea-mbimxsd27-baseboard: Pass missing unit address
      ARM: dts: imx27-eukrea-cpuimx27: Put the clock node directly into root
      ARM: dts: imx28-tx28: Pass the memory unit name
      ARM: dts: imx6: Pass memory unit-adress
      ARM: dts: imx5: Pass the memory unit-address
      ARM: dts: vf500: Remove skeleton.dtsi inclusion
      ARM: dts: vf: Add memory node unit name
      ARM: dts: vf500: Remove the zero length reg property
      ARM: dts: vf610m4: Remove skeleton.dtsi inclusion
      ARM: dts: vf610m4: Remove the zero length reg property
      dt-bindings: ifc: Fix the unit address format in the examples
      ARM: dts: imx6-phytec: Use the standard 'stdout-path' property
      ARM: dts: imx6ul-isiot: Pass the required '#sound-dai-cells'
      Revert "arm64: dts: fsl: fix ifc simple-bus unit address format warnings"
      Revert "dt-bindings: ifc: Fix the unit address format in the examples"

Fabrizio Castro (2):
      ARM: dts: iwg20m: Enable cmt0
      ARM: dts: iwg22m: Enable cmt0

Felix Brack (1):
      ARM: dts: am33xx: add PDU001 board

Florian Fainelli (3):
      Merge tag 'bcm2835-dt-next-2018-02-28' into devicetree/next
      ARM: dts: NSP: Switch to port 8 for CPU port
      Merge tag 'bcm2835-dt-next-2018-03-13' into devicetree/next

Fugang Duan (1):
      ARM: dts: imx6ul: update i.MX 6UltraLite iomux headers

Geert Uytterhoeven (16):
      arm64: dts: renesas: r8a77970: Remove non-existing STBE region
      arm64: dts: renesas: r8a77995: Remove non-existing STBE region
      ARM: dts: kirkwood: Fix "debounce-interval" property misspelling
      dt-bindings: arm: Document SoC compatible value for Armadillo-800 EVA
      dt-bindings: arm: Document Renesas V3MSK and Wheat board part numbers
      dt-bindings: arm: Document Renesas R-Car M3-N-based Salvator-XS board
      dt-bindings: arm: Document Renesas R-Car M3-N-based Salvator-X board
      ARM: dts: atlas7: Use generic uart-has-rtscts DT property
      ARM: dts: exynos: Fix "debounce-interval" property misspelling in Midas
      arm64: dts: renesas: r8a77965: Add IIC-DVFS device node
      arm64: dts: renesas: r8a77965: Add INTC-EX device node
      arm64: dts: renesas: r8a77965-salvator-xs: Add SoC name to file header
      arm64: dts: renesas: r8a77970: sort subnodes of root node alphabetically
      arm64: dts: renesas: r8a7795: Add missing SYS-DMAC2 dmas
      ARM: dts: kzm9d: Fix "debounce-interval" property misspelling
      ARM: dts: lager: Move cec_clock to root node

Georgi Djakov (4):
      arm64: dts: qcom: msm8916: Add msm8916 A53 PLL DT node
      arm64: dts: qcom: msm8916: Probe the APCS mailbox driver
      arm64: dts: qcom: msm8916: Add clock properties to the APCS node
      arm64: dts: qcom: msm8916: Add CPU frequency scaling support

Giulio Benetti (3):
      ARM: dts: sun7i: include correct ccu clock header
      ARM: dts: sun7i: Add Mali node
      ARM: dts: sun8i-h3: Add Mali node

Gregory CLEMENT (29):
      ARM64: dts: marvell: armada-cp110: Add registers clock for SPI nodes
      ARM64: dts: marvell: armada-cp110: Add registers clock for I2C nodes
      arm64: dts: marvell: use SPDX-License-Identifier for Armada SoCs
      arm64: dts: marvell: armada-3720-db: use SPDX-License-Identifier
      arm64: dts: marvell: armada-3720-espressobin: use SPDX-License-Identifier
      arm64: dts: marvell: armada-7040-db: use SPDX-License-Identifier
      arm64: dts: marvell: armada-8040-db: use SPDX-License-Identifier
      arm64: dts: marvell: armada-8040-mcbin: use SPDX-License-Identifier
      arm64: dts: marvell: armada-8080-db: use SPDX-License-Identifier
      ARM64: dts: marvell: armada-cp110: Add registers clock for sata node
      ARM64: dts: marvell: armada-cp110: Add apb_pclk clock for the uart nodes
      ARM64: dts: marvell: armada-cp110: Add registers clock for USB host nodes
      ARM64: dts: marvell: armada-cp110: Add registers clock for XOR
engine nodes
      ARM64: dts: marvell: armada-cp110: Add registers clock for the trng node
      ARM64: dts: marvell: armada-cp110: Add registers clock for the crypto node
      ARM64: dts: marvell: armada-cp110: Add registers clock for the NAND node
      ARM64: dts: marvell: armada-cp110: Add registers clock for the PCIe nodes
      arm: dts: armada-*.dtsi: use SPDX-License-Identifier for most of
the Armada SoCs
      arm: dts: armada-xp-98dx: use SPDX-License-Identifier for
prestara 98d SoCs
      arm: dts: armada-*.dts: use SPDX-License-Identifier for most of
the Armada based board
      arm: dts: armada-370-db: use SPDX-License-Identifier
      arm: dts: armada-xp-db-dxbc2: use SPDX-License-Identifier
      arm: dts: armada-xp-db-xc3-24g4xg: use SPDX-License-Identifier
      arm: dts: armada-388-rd: use SPDX-License-Identifier
      arm: dts: armada-385-db-ap: use SPDX-License-Identifier
      arm: dts: armada-385-turris-omnia: use SPDX-License-Identifier
      arm: dts: kirkwood*.dts: use SPDX-License-Identifier for boards
using GPL-2.0
      arm: dts: kirkwood*.dts: use SPDX-License-Identifier for boards
using GPL-2.0+/MIT
      arm: dts: kirkwood*.dts: use SPDX-License-Identifier for board
using GPL-2.0+

Harald Geyer (4):
      arm64: dts: allwinner: a64: Add i2c0 pins
      arm64: dts: allwinner: a64: Add watchdog
      arm64: dts: allwinner: a64: add simplefb for A64 SoC
      arm64: dts: allwinner: a64: Add support for TERES-I laptop

Hauke Mehrtens (3):
      ARM: dts: sun8i: activate SPI on Orange Pi R1
      arm64: allwinner: H5: Add Xunlong Orange Pi Zero Plus
      ARM: dts: armada-385-linksys: Disable internal RTC

Heiko Stuebner (2):
      arm64: dts: rockchip: move rk3399-sapphire sdio to excavator baseboard
      arm64: dts: rockchip: add a standalone version of the rk3399 sapphire

Henry Zhang (1):
      ARM: dts: bcm283x: Fix pin function of JTAG pins

Huazhong Tan (1):
      arm64: dts: hisi: add hns-dsaf cpld control for the hip07 SoC

INAGAKI Hiroshi (1):
      ARM: dts: BCM5301X: add missing LEDs for Buffalo WZR-900DHP

Ian Ray (1):
      ARM: dts: imx6q-bx50v3: disable SD card

Icenowy Zheng (3):
      ARM: dts: sun8i: h2+: add support for Banana Pi M2 Zero board
      arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
      arm64: allwinner: h6: add support for Pine H64 board

Ilia Lin (1):
      arm64: dts: qcom: Fix SPI5 config on MSM8996

Jacopo Mondi (24):
      dt-bindings: arm: Document R-Car M3-N SoC DT bindings
      arm64: add Renesas R8A77965 support
      arm64: dts: renesas: initial R8A77965 SoC device tree
      arm64: dts: renesas: Add R-Car Salvator-x M3-N support
      arm64: dts: renesas: r8a77965: Add dmac device nods
      arm64: dts: renesas: r8a77965: Add SCIF device nodes
      arm64: dts: renesas: r8a77965: Add GPIO nodes
      arm64: dts: renesas: r8a77965: Add "reg" properties
      arm64: dts: renesas: r8a77965: Add #address-cells and #size-cells
      arm64: dts: renesas: r8a77965: Remove stale reg property
      arm64: dts: renesas: r8a77965: Add #phy-cells property
      arm64: dts: renesas: r8a77965: Add #pwm-cells property
      arm64: dts: renesas: r8a77965: Add #interrupt-cells property
      arm64: dts: renesas: r8a77965: Move usb2_phy1 up
      arm64: dts: renesas: salvator-common: Override EtherAVB phy-mode
      arm64: dts: renesas: ulcb: Override EtherAVB phy-mode
      arm64: dts: renesas: draak: Override EtherAVB phy-mode
      arm64: dts: renesas: eagle: Override EtherAVB phy-mode
      arm64: dts: renesas: v3msk: Override EtherAVB phy-mode
      arm64: dts: renesas: r8a7796: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a7795: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a77995: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a77970: Set EtherAVB phy mode to "rgmii"
      arm64: dts: renesas: r8a77965: Add EtherAVB device node

Jagan Teki (1):
      ARM: dts: rockchip: Add eMMC node for rk3288-vyasa

Jelle van der Waa (1):
      ARM: dts: nanopi-neo-air: Add WiFi / eMMC

Jernej Skrabec (5):
      ARM: dts: sun8i: a83t: Add HDMI display pipeline
      ARM: dts: sun8i: a83t: Enable HDMI on BananaPi M3
      ARM: dts: sunxi: h3/h5: Add HDMI pipeline
      ARM: dts: sun8i: h3: Enable HDMI output on H3 boards
      ARM64: dts: sun50i: h5: Enable HDMI output on H5 boards

Jerome Brunet (5):
      ARM64: meson-axg: enable hardware rng
      ARM64: dts: meson-axg: add sec_AO system controller
      ARM64: dts: meson-axg: fix pwm_AO_cd compatible
      ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
      ARM64: dts: meson-gx: make efuse read-only

Jian Hu (3):
      ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC
      ARM64: dts: meson-axg: describe pin DT info for I2C controller
      ARM64: dts: meson-axg: enable I2C Master-1 for the audio speaker

Joel Stanley (9):
      ARM: dts: aspeed: Add IPMI BT node
      ARM: dts: aspeed: Enable IPMI BT node on OpenPower machines
      ARM: dts: aspeed-g5: Update LPC node
      ARM: dts: aspeed: Add LPC clock phandles
      ARM: dts: palmetto: Add LEDs and GPIO keys
      ARM: dts: aspeed: Add Palmetto GPIO hogs
      ARM: dts: aspeed: Add LPC reset controller node
      ARM: dts: palmetto: Enable rear UART
      ARM: dts: romulus: Remove MAX31785 device

John Keeping (3):
      ARM: dts: rockchip: add power key for Rock2 Square
      ARM: dts: rockchip: add recovery button for Rock2 Square
      ARM: dts: rockchip: enable USB-OTG port on Radxa Rock2 Square

Jon Nettleton (1):
      ARM: dts: imx6qdl-hummingboard: fix USBOTG-ID pin

Joonas Kylmälä (5):
      ARM: dts: sunxi: h3-h5: remove mmc0 card detection pin from pinctrl
      ARM: dts: sunxi: h3-h5: Move pinctrl of mmc0 from dts to dtsi
      ARM: dts: sunxi: h3-h5: Move pinctrl of mmc1 from dts to dtsi
      ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and mmc1_pins_a
      ARM: dts: sun8i: h2-plus: remove unnecessary mmc1_pins node

Jorge Ramirez-Ortiz (2):
      ARM64: dts: meson s905x: accept MAC addr from u-boot environment
      ARM64: dts: meson: accept MAC addr from u-boot environment

Jörg Krause (2):
      ARM: dts: imx6ul: rename mux mode name REF_CLK_32K to OSC32K_32K_OUT
      ARM: dts: imx6ul: add wdog3 node

Katsuhiro Suzuki (8):
      ARM: dts: uniphier: add audio in/out pin-mux node
      arm64: dts: uniphier: add sound node
      arm64: dts: uniphier: add speaker out for LD11/LD20 boards
      arm64: dts: uniphier: add compress audio out for LD11/LD20
      arm64: dts: uniphier: add fixed regulators for audio codec
      ARM: dts: uniphier: add sound node for PXs2
      arm64: dts: uniphier: add syscon property for UniPhier sound system
      ARM: dts: uniphier: add syscon property for UniPhier sound system

Ken Chen (1):
      ARM: dts: aspeed: Add Qualcomm Centriq 2400 REP BMC

Ken Lin (1):
      ARM: dts: imx: Add support for Advantech DMS-BA16

Kieran Bingham (7):
      arm64: dts: renesas: r8a77995: add FCPV nodes
      arm64: dts: renesas: r8a77995: add VSP instances
      arm64: dts: renesas: r8a77995: add DU support
      arm64: dts: renesas: r8a7795-es1: Fix register mappings on VSPs
      arm64: dts: renesas: r8a7795: Fix register mappings on VSPs
      arm64: dts: renesas: r8a7796: Fix register mappings on VSPs
      arm64: dts: renesas: draak: Enable DU

Kishon Vijay Abraham I (9):
      ARM: multi_v7_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
      ARM: omap2plus_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
      ARM: dts: am57xx-beagle-x15: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra7-evm: Remove mmc specific pinmux
      ARM: dts: dra7-evm: Add "vqmmc-supply" property for mmc2
      ARM: dts: am57xx-idk: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra76-evm: Add "vqmmc-supply" property for mmc2
      ARM: dts: dra71-evm: Select pull down for mmc1_clk line in default mode
      ARM: dts: am57xx-idk: Select pull down for mmc1_clk line in default mode

Klaus Goger (7):
      arm64: dts: rockchip: enable tsadc on rk3399-puma
      arm64: dts: rockchip: add i2s0-2ch-bus pins on rk3399
      dt-bindings: add RK3368-uQ7 SoM and EVK base board
      arm64: dts: rockchip: add RK3368-uQ7 (Lion) SoM
      arm64: dts: rockchip: add Haikou baseboard with RK3368-uQ7 SoM
      arm64: dts: rockchip: move i2s0 node from baseboard to SoM on rk3399-puma
      arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou

Krzysztof Kozlowski (6):
      ARM: dts: samsung: Remove unused samsung_k3pe0e000b
      ARM: dts: exynos: Add SPDX license identifiers
      ARM: dts: exynos: Remove duplicated inclusion of syscon restart
nodes on Exynos5410
      ARM: dts: exynos: Fix address of PPMU ACP on Exynos4210
      ARM: dts: exynos: Fix unit addresses of PDMA nodes in Exynos5410
      ARM: dts: exynos: Remove unused bypass-smu property from Xyref5260

Kunihiko Hayashi (4):
      ARM: dts: uniphier: add AVE ethernet node
      arm64: dts: uniphier: add AVE ethernet node
      ARM: dts: uniphier: add pinctrl groups of ethernet for second instance
      arm64: dts: uniphier: add ethernet node for PXs3

Laurent Pinchart (1):
      ARM: dts: porter: Fix HDMI output routing

Lei YU (2):
      ARM: dts: aspeed: romulus: hog GPIOS7
      ARM: dts: aspeed: romulus: Add w83773g temp sensor

Leo Yan (1):
      arm64: dts: Hi3660: Remove 'CPU_NAP' idle state

Levin Du (1):
      arm64: dts: rockchip: add roc-rk3328-cc board

Linus Lüssing (1):
      ARM: dts: meson8b-odroidc1: add microSD support

Linus Walleij (7):
      ARM: dts: add XOADC and IIO HWMON to APQ8064
      ARM: dts: Augment VGA connector bridge on PB11MPcore
      ARM: dts: Augment VGA connector bridge on PB1176
      ARM: dts: Augment VGA connector bridge on Realview EB
      ARM: dts: Augment VGA connector bridge on Realview PBX
      ARM: dts: Add Versatile IB2 device tree
      ARM: dts: Augment panel setting for Versatile

Lothar Waßmann (2):
      ARM: dts: imx6ull: fix the imx6ull-14x14-evk configuration
      ARM: dts: imx6dl: remove 'lcdif' node

Lucas Stach (3):
      ARM: dts: imx6: RDU2: disable internal watchdog
      ARM: dts: imx6: RDU2: detail USDHC description
      ARM: dts: imx6: remove GPU subsystem nodes

Ludovic Barre (6):
      ARM: dts: stm32: add exti support for stm32h743
      ARM: dts: stm32: add system config bank node for stm32h743
      ARM: dts: stm32: add support of exti on stm32h743 pinctrl
      ARM: dts: stm32: add stm32mp157c initial support
      ARM: dts: stm32: add initial support of stm32mp157c eval board
      dt-bindings: stm32: add support of STM32MP157

Maciej Purski (14):
      ARM: dts: exynos: Use pinctrl labels in exynos4210-pinctrl
      ARM: dts: exynos: Use pinctrl labels in exynos4412-pinctrl
      ARM: dts: exynos: Use labels instead of full paths in exynos4210
      ARM: dts: exynos: Use labels instead of full paths in exynos4210-trats
      ARM: dts: exynos: Use labels instead of full paths in
exynos4210-universal_c210
      ARM: dts: exynos: Use label instead of full path in exynos4412
      ARM: dts: exynos: Use label instead of full path in
exynos4412-odroid-common
      ARM: dts: exynos: Use labels instead of full paths in exynos4412-trats2
      ARM: dts: exynos: Use label instead of full path in exynos4412-itop-elite
      ARM: dts: exynos: Use pmu label in exynos4412
      ARM: dts: exynos: Add soc node to exynos5440
      ARM: dts: exynos: Add soc node to exynos4
      ARM: dts: exynos: Add soc node to exynos4210
      ARM: dts: exynos: Add soc node to exynos4412

Magnus Damm (3):
      ARM: dts: marzen: Add SDHI0 VCCQ Regulator
      ARM: dts: silk: Add r1ex24002 EEPROM to DT
      ARM: dts: silk: Add GPIO keys to DT

Marcel Ziswiler (15):
      dt-bindings: phy: Clarify ULPI PHY source clock
      ARM: tegra: Fix ULPI regression on Tegra20
      dt/bindings: Fix binding examples for Tegra GMI controller
      ARM: tegra: Use proper IRQ type definitions
      ARM: tegra: beaver: Remove invalid uses of rsvd1
      ARM: tegra: venice2: Remove duplicate pcie-1 node
      ARM: tegra: Fix I2C bus frequencies on Apalis/Colibri
      ARM: tegra: apalis/colibri: Use correct compatible for RTC
      ARM: tegra: apalis/colibri: Remove unneeded reg property
      ARM: tegra: apalis-tk1: Set critical trips
      ARM: tegra: apalis-tk1: Activate PWM pin muxing for pwm3
      ARM: tegra: apalis-tk1: Add missing as3722 gpio0 configuration
      ARM: tegra: apalis-tk1: Hog group for ethernet, PCIe, reset GPIOs
      ARM: tegra: apalis-tk1: Copyright period, spurious newlines
      ARM: tegra: apalis-tk1: Support v1.2 hardware revision

Marco Franchi (5):
      ARM: dts: imx6ul-evk: Add support for mag3110 sensor
      ARM: dts: imx7d-sdb: Add support for mpl3115 sensor
      ARM: dts: imx: Pass empty memory size on board dts
      ARM: dts: imx: Remove empty memory size nodes
      ARM: dts: imx: Add memory node unit name

Marcus Cooper (8):
      ARM: dts: sun7i: Enable HDMI support on the MK808C
      ARM: dts: sun4i: Enable HDMI support on the MK802
      ARM: dts: sun7i: Enable HDMI support on the Olimex EVB
      ARM: dts: sun6i: a31: Enable HDMI support on the Mele I7
      arm64: dts: allwinner: a64: Add the SPDIF block and pin
      arm64: dts: allwinner: a64: Add SPDIF to the A64
      arm64: dts: allwinner: a64: Add SPDIF to the Pine64
      arm64: dts: allwinner: a64: Add DAI nodes

Marek Szyprowski (3):
      ARM: dts: exynos: Cleanup power domain nodes in exynos3250.dtsi
      ARM: dts: exynos: Add missing interrupts property to PMIC on Trats board
      ARM: dts: exynos: Fix IOMMU support for GScaler devices on Exynos5250

Marek Vasut (2):
      dt-bindings: arm: Document Renesas H2-based Stout DT bindings
      ARM: dts: stout: Initial r8a7790 Stout board support

Martin Blumenstingl (5):
      ARM: dts: meson8b: grow the reset controller memory zone
      ARM: dts: meson8: add the reset controller
      ARM: dts: meson8: add the USB reset line
      ARM: dts: meson8b: add the I2C clocks
      ARM: dts: meson8b: the CBUS GPIO controller only has 83 GPIOs

Martin Kaiser (1):
      ARM: dts: i.MX25: define SSI FIFO depth

Martyn Welch (1):
      ARM: dts: imx53-ppd: Add touchscreen reset line

Masahiro Yamada (2):
      ARM: dts: uniphier: use proper SPDX-License-Identifier style
      arm64: dts: uniphier: use proper SPDX-License-Identifier style

Mathieu Malaterre (1):
      ARM: dts: stm32: dts: Remove leading 0x and 0s from bindings notation

Maxime Ripard (1):
      ARM: dts: sun8i: a33 Enable our display frontend

Michael Lyle (1):
      ARM: dts: exynos: Add support for wlan to Artik 5

Michal Simek (19):
      arm64: zynqmp: Use zynqmp specific compatible string for macb
      arm64: zynqmp: Fix alignment in dts files
      arm64: zynqmp: Add SPDX license identifier
      dt-bindings: xilinx: Add description for ZynqMP
      arm64: zynqmp: Add support for Xilinx zcu100-revC
      arm64: zynqmp: Add support for Xilinx zcu102
      arm64: zynqmp: Add support for Xilinx zcu104-revA
      arm64: zynqmp: Add support for Xilinx zcu106-revA
      arm64: zynqmp: Add support for Xilinx zcu111-revA
      arm64: zynqmp: Add support for Xilinx zc12XX boards
      arm64: zynqmp: Add support for Xilinx zc1751
      arm: zynq: Use i2c-mux instead of i2cswitch for pca9548
      arm: dts: zynq: Use SPDX-License-Identifier
      arm: zynq: Add missing address node name in microzed board
      arm: zynq: Add Xilinx cc108 board
      arm: zynq: Add support for Xilinx zc770 xm010 dc1 board
      arm: zynq: Add support for Xilinx zc770 xm011 dc2 board
      arm: zynq: Add support for Xilinx zc770 xm012 dc3 board
      arm: zynq: Add support for Xilinx zc770 xm013 dc4 board

Mikko Perttunen (4):
      dt-bindings: tegra: Add missing chips and NVIDIA boards
      dt-bindings: tegra: Add documentation for nvidia,tegra194-pmc
      arm64: tegra: Add Tegra194 chip device tree
      arm64: tegra: Add device tree for the Tegra194 P2972-0000 board

Miquel Raynal (2):
      arm64: dts: marvell: use reworked NAND controller driver on Armada 7K
      arm64: dts: marvell: use reworked NAND controller driver on Armada 8K

Murali Karicheri (1):
      ARM: dts: Keystone: add ECC error handler support

Neil Armstrong (4):
      ARM64: dts: amlogic: Convert to new-style SPDX license identifiers
      ARM64: dts: meson-gxbb-wetek: add a wetek specific dtsi to
cleanup hub and play2
      meson-gx-socinfo: Add package id for S905H
      ARM64: dts: meson: bump mali450 clk to 744MHz

Nicolas Ferre (1):
      ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Niklas Cassel (8):
      ARM: dts: artpec: disable Accelerator Coherency Port
      ARM: dts: artpec: use 1 GiB RAM
      ARM: dts: artpec: remove 0x prefix from clkctrl unit address
      ARM: dts: artpec: migrate ethernet to stmmac binding
      ARM: dts: artpec: add and utilize artpec6 pin controller
      ARM: dts: artpec: add and utilize nbpfaxi DMA controllers
      ARM: dts: artpec: add disabled node for PCIe endpoint mode
      ARM: dts: artpec: add node for hardware crypto accelerator

Niklas Söderlund (5):
      ARM: dts: lager: Add CEC clock for HDMI transmitter
      arm64: dts: renesas: r8a7796: add thermal cooling management
      arm64: dts: renesas: r8a7795: add thermal cooling management
      arm64: dts: renesas: r8a7795: update register size for thermal
      arm64: dts: renesas: r8a7796: update register size for thermal

Nobuhiro Iwamatsu (1):
      arm: dts: zynq: Add Digilent Zybo Z7 board

P L Sai Krishna (1):
      arm64: zynqmp: Add 8-bit bus width property for ep108

Patrice Chotard (22):
      ARM: dts: STi: Fix bindings notation
      ARM: dts: STi: Move leds node outside soc node
      ARM: dts: STi: Add fake reg property for sti-display-subsystem
      ARM: dts: STi: Add fake reg property for miphy28lp_phy
      ARM: dts: STi: Add fake reg property for irq-syscfg
      ARM: dts: STi: Add fake reg property for remote processors
      ARM: dts: STi: Add fake reg for restart, powerdown and picophy/softreset
      ARM: dts: STi: Add fake reg property for usb2_picophyX nodes
      ARM: dts: STi: Update sound related nodes location
      ARM: dts: STi: Update clocks node location
      ARM: dts: STi: Remove unused clk_ext2f_a9 clock
      ARM: dts: stm32: Add SDIO controller for stm32f746
      ARM: dts: stm32: Add SDIO controller for stm32f429
      ARM: dts: stm32: Enable SDIO controller on stm32f469 disco board
      ARM: dts: stm32: Enable SDIO controller on stm32429i-eval board
      ARM: dts: stm32: Fix HSE clock frequency for stm32h743i-disco board
      ARM: dts: stm32: Add sdio pins definition for stm32f7
      ARM: dts: stm32: Enable sdio1 for stm32f746-disco
      ARM: dts: stm32: Enable sdio1 for stm32f746-eval
      ARM: dts: stm32: Enable sdio1 for stm32f769-disco
      dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
      ARM: dts: stm32: Fix sdio2 rcc hard coded value

Pavel Machek (1):
      ARM: dts: nokia N9: Add support for magnetometer

Peter Rosin (8):
      ARM: dts: at91: nattis: use the correct compatible for the eeprom
      ARM: dts: at91: tse850: use the correct compatible for the eeprom
      ARM: dts: at91: nattis: use up-to-date mtd partitions
      ARM: dts: at91: nattis: add lvds-encoder
      ARM: dts: at91: tse850: make the sound dai cell count explicit
      ARM: dts: at91: fixes uart pinctrl, set pullup on rx, clear pullup on tx
      ARM: dts: at91rm9200: pullup rx on uart0
      ARM: dts: at91sam9260: pullup rx on usart0

Peter Senna Tschudin (1):
      ARM: dts: imx6q-bx50v3: Enable secure-reg-access

Peter Ujfalusi (1):
      ARM: dts: omap5-board-common: Add phandle for mclk clock for twl6040

Philipp Puschmann (1):
      arm: dts: socfpga: fix GIC PPI warning

Preetham Ramchandra (2):
      arm64: tegra: Add SATA node for Tegra210
      arm64: tegra: Enable AHCI on Jetson TX1

Quentin Schulz (9):
      ARM: dtsi: axp209: add node for ADC
      ARM: dtsi: axp22x: add node for ADC
      ARM: dtsi: axp81x: add node for ADC
      ARM: dtsi: axp81x: add battery power supply subnode
      ARM: dtsi: sun8i: a711: enable battery power supply subnode
      ARM: dtsi: axp81x: remove IP name from DT node name
      ARM: dts: sun8i: a83t: add cpu0 and cpu100 labels
      ARM: dts: sun8i: a83t: add stable OPP tables and CPUfreq
      ARM: dts: sun8i: a711: set regulator for each cluster of CPUs

Rajendra Nayak (4):
      arm64: dts: msm8996: Fix wrong use of GIC_CPU_MASK_SIMPLE()
      arm64: dts: msm8916: Add cpu cooling maps
      dt-bindings: arm: Document kryo385 cpu
      dt-bindings: qcom: Add SDM845 bindings

Rasmus Villemoes (1):
      ARM: dts: ls1021a: add nodes for on-chip ram

Ravikumar Kattekola (1):
      ARM: dts: dra71-evm: Correct evm_sd regulator max voltage

Rob Herring (6):
      ARM: dts: omap3: Add missing #sound-dai-cells
      arm: dts: kirkwood: fix error in #sound-dai-cells size
      arm: dts: replace 'linux,stdout-path' with 'stdout-path'
      arm64: dts: replace 'linux,stdout-path' with 'stdout-path'
      ARM: dts: imx: Add missing #sound-dai-cells for sgtl5000 codec
      ARM: dts: stih4xx: Add missing #sound-dai-cells

Robin Murphy (2):
      arm64: dts: rockchip: Fix RK3328 UART DMAs
      arm64: dts: juno: Describe the full GICv2m region

Roger Quadros (1):
      ARM: dts: am43xx: Enable dual-role mode for USB1

Roy Pledge (1):
      arm64: dts: Add DPAA QBMan portal 9

Rui Miguel Silva (2):
      clk: imx7d: add CAAM clock
      ARM: dts: imx7s: add CAAM device node

Russell King (2):
      ARM: dts: armada388-clearfog: increase speed of i2c0 to 400kHz
      ARM: dts: armada388-clearfog: add SFP module support

Ryan Harkin (1):
      ARM: dts: imx7s-warp: enable uart6 on mikroBus

Ryder Lee (3):
      arm64: dts: mt7622: add PCIe device nodes
      arm64: dts: mt7622: add SATA device nodes
      arm: dts: mt7623: add PCIe related nodes

Santiago Esteban (1):
      ARM: dts: at91: sama5d4: fix pinctrl compatible string

Sean Wang (18):
      arm64: dts: mt7622: add clock controller device nodes
      arm64: dts: mt7622: add power domain controller device nodes
      arm64: dts: mt7622: add pinctrl related device nodes
      arm64: dts: mt7622: add PMIC MT6380 related nodes
      arm64: dts: mt7622: add cpufreq related device nodes
      arm64: dts: mt7622: turn uart0 clock to real ones
      arm64: dts: mt7622: add SoC and peripheral related device nodes
      arm64: dts: mt7622: add flash related device nodes
      arm64: dts: mt7622: add ethernet device nodes
      arm64: dts: mt7622: add mmc related device nodes
      dt-bindings: arm: mediatek: add support for more mt7623 reference boards
      arm: dts: mt7623: fix USB initialization fails on bananapi-r2
      dt-bindings: clock: mediatek: add missing required #reset-cells
      arm: dts: mt7623: fix the regulators mmc should use on bananapi-r2
      arm: dts: mt7623: enable three available UARTs on bananapi-r2
      arm: dts: mt7623: add related clock properties to cpu[1-3] nodes
      arm: dts: mt7623: remove useless property pinctrl-names at node switch@0
      arm: dts: mt7623: use - instead of _ in DT node name

Sebastian Reichel (4):
      ARM: dts: imx53-ppd: use PMIC's TSI pins in adc mode
      ARM: dts: omap4-droid4: update touchscreen
      ARM: dts: motorola-cpcap-mapphone: add audio-codec
      ARM: dts: omap4-droid4: add soundcard

Sekhar Nori (3):
      ARM: dts: dra76x: Create a common file with MMC/SD IOdelay data
      ARM: dts: dra76-evm: Shift to using common IOdelay data
      ARM: dts: dra76-evm: Add pinctrl data for higher speed MMC/SD modes

Sergei Shtylyov (16):
      dt-bindings: arm: document R8A77980 SoC bindings
      arm64: add Renesas R8A77980 support
      arm64: dts: renesas: initial R8A77980 SoC device tree
      arm64: dts: renesas: r8a77980: add SYS-DMAC support
      arm64: dts: renesas: r8a77970: add PFC support
      arm64: dts: renesas: eagle: add SCIF0 pins
      arm64: dts: renesas: r8a77970: add GPIO support
      arm64: dts: renesas: eagle: specify EtherAVB PHY IRQ
      dt-bindings: arm: document Condor board bindings
      arm64: dts: renesas: r8a77980: add [H]SCIF support
      arm64: dts: renesas: r8a77980: add EtherAVB support
      arm64: dts: renesas: initial Condor board device tree
      arm64: dts: renesas: condor: add EtherAVB support
      arm64: dts: renesas: r8a77970: add I2C support
      arm64: dts: renesas: eagle: add I2C0 support
      arm64: dts: renesas: v3msk: add SCIF0 pins

Shameerali Kolothum Thodi (1):
      arm64: dts: hisi: Disable hisilicon smmu node on hip06/hip07

Shawn Guo (2):
      arm64: dts: fsl: fix ifc simple-bus unit address format warnings
      arm64: dts: ls1046a: add a dummy memory 'reg' property

Shawn Lin (2):
      ARM: dts: rockchip: add "rockchip,rk3228-grf" compatible for
rk322x grf node
      arm64: dts: rockchip: remove keep-power-in-suspend from sdhci of
rk3399-sapphire

Shunqian Zheng (2):
      arm64: dts: rockchip: Add cif test clocks for rk3399
      arm64: dts: rockchip: assign clock rate for ACLK_VIO on rk3399

Shyam Saini (1):
      ARM: dts: imx6dl-icore-rqs: Fix invalid PHY address assignment
for ethernet

Simon Horman (28):
      ARM: dts: r8a7790: Reduce size of thermal registers
      ARM: dts: r8a7791: Reduce size of thermal registers
      ARM: dts: r8a7793: Reduce size of thermal registers
      ARM: dts: r8a7790: consistently use single space after =
      ARM: dts: r8a7790: add soc node
      ARM: dts: r8a7790: sort subnodes of soc node
      ARM: dts: r8a7790: sort subnodes of root node
      ARM: dts: r8a7791: consistently use single space after =
      ARM: dts: r8a7791: add soc node
      ARM: dts: r8a7791: sort subnodes of root node
      ARM: dts: r8a7792: sort subnodes of soc node
      ARM: dts: r8a7793: consistently use single space after =
      ARM: dts: r8a7793: add soc node
      ARM: dts: r8a7793: sort subnodes of soc node
      ARM: dts: r8a7793: sort subnodes of root node
      ARM: dts: r8a7794: consistently use single space after =
      ARM: dts: r8a7794: add soc node
      ARM: dts: r8a7794: sort subnodes of soc node
      ARM: dts: r8a7794: sort subnodes of root node
      ARM: dts: r8a7790: consistently use single space before =
      ARM: dts: r8a7791: consistently use single space before =
      ARM: dts: r8a7793: consistently use single space before =
      ARM: dts: r8a7743: sort subnodes of soc node
      ARM: dts: r8a7745: sort subnodes of soc node
      arm64: dts: renesas: r8a7795: move scif node into alphabetical order
      arm64: dts: renesas: r8a77970: move node which has no reg
property out of bus
      arm64: dts: renesas: r8a77995: move nodes which have no reg
property out of bus
      arm64: dts: renesas: r8a7795: Add IPMMU-PV1 device node

Simon Shields (4):
      dt-bindings: samsung: Document bindings for Midas family boards
      ARM: dts: exynos: Split Trats2 DTS in preparation for Midas boards
      ARM: dts: exynos: Add Samsung's Exynos4412-based Midas boards
      ARM: dts: exynos: Add touchscreen node to Exynos4412 N710x

Stefan Agner (10):
      ARM: dts: imx6ul: add interrupt of virt-capable GIC
      ARM: dts: imx6ul: add ARM architected timer
      ARM: dts: imx6ull: add IOMUXC SNVS instance
      ARM: dts: imx6ull: add UART8 support
      ARM: dts: imx6ull: add Toradex Colibri iMX6ULL support
      ARM: dts: imx6dl-colibri-eval-v3: Add chosen node
      ARM: dts: imx7: add CPU PMU support
      clk: imx: imx7d: add the Keypad Port module clock
      ARM: dts: imx7s: add Keypad Port module
      ARM: dts: imx7s: add spba-bus abstraction

Stefan Mavrodiev (2):
      ARM: dts: sunxi: Add Olimex A20-SOM204-EVB board
      ARM: dts: sunxi: Add Olimex A20-SOM204-EVB-eMMC board

Stefan Monnier (2):
      ARM: dts: sun7i: Enable HDMI support on the Banana Pi
      ARM: dts: sun7i: Enable HDMI support on the Orange Pi mini

Stefan Riedmueller (2):
      ARM: dts: imx6: Add initial support for phyCORE-i.MX 6 SOM
      ARM: dts: imx6: Add initial support for phyBOARD-Mira

Stefan Wahren (5):
      dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
      ARM: dts: bcm283x: Fix probing of bcm2835-i2s
      ARM: dts: bcm283x: Apply pull settings to Zero W relevant groups
      ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial slave
      ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode

Sudeep Holla (1):
      arm64: dts: juno: fix size of GICv2m MSI frames

Suman Anna (2):
      ARM: dts: keystone-k2e-clocks: Fix missing unit address separator
      ARM: dts: keystone-k2g: Fix unit-address formatting for serial nodes

Sylwester Nawrocki (10):
      ARM: dts: exynos: Add I2S1 device node to exynos5433
      ARM: dts: exynos: Update I2S0 device node in exynos5433
      ARM: dts: exynos: Add support for HDMI audio on Exynos 5433 TM2 board
      ARM: dts: exynos: Add #sound-dai-cells property to hdmi node in
exynos5250.dtsi
      ARM: dts: exynos: Add audio clocks configuration for Snow Chromebook
      ARM: dts: exynos: Add missing clock and DAI properties to the
max98095 node in Snow Chromebook
      ARM: dts: exynos: Enable HDMI audio on Snow Chromebook
      ARM: dts: exynos: Enable HDMI audio support on Peach Pit
      ARM: dts: exynos: Enable HDMI audio support on Peach Pi
      ARM: dts: exynos: Add #sound-dai-cells property to exynos5250 i2s nodes

Takeshi Kihara (1):
      arm64: dts: renesas: Add support for Salvator-XS with R-Car M3-N

Tero Kristo (7):
      ARM: dts: am33xx: add emif interrupt info
      ARM: dts: am43xx: add emif interrupt info
      dt-bindings: memory: ti-emif: add edac support under emif
      ARM: dts: keystone-k2g: add watchdog support
      dt-bindings: omap5: ctrl: Support for control module wkup pad config
      ARM: dts: omap5: add support for control module wkup pad config
      ARM: dts: omap5: add fref_xtal_ck support

Thierry Reding (1):
      ARM: tegra: Add unit address to VDE IRAM area

Tomer Maimon (6):
      arm: dts: add watchdog device to NPCM750 device tree
      arm: dts: modify UART compatible name in NPCM750 device tree
      arm: dts: modify timer register size in NPCM750 device tree
      arm: dts: modify clock binding in NPCM750 device tree
      arm: dts: modify Makefile NPCM750 configuration name
      arm: dts: modify Nuvoton NPCM7xx device tree structure

Tony Lindgren (3):
      ARM: dts: omap4-droid4: Fix USB PHY port naming
      ARM: dts: omap4-droid4: Configure MDM6600 USB PHY
      ARM: dts: omap4-droid4: Configure uart1 pins

Tuomas Tynkkynen (2):
      ARM: dts: sunxi: Switch MMC nodes away from cd-inverted property
      arm64: dts: sunxi: Switch MMC nodes away from cd-inverted property

Ulrich Hecht (4):
      arm64: dts: renesas: r8a77995: add I2C support
      arm64: dts: renesas: draak: enable I2C controller 0 and EEPROM
      arm64: dts: renesas: draak: enable I2C controller 1
      arm64: dts: renesas: draak: enable SDHI2

Uwe Kleine-König (1):
      arm64: dts: armada-3720-espressobin: Document URL for schematic

Vicente Bergas (3):
      arm64: dts: rockchip: vdd_log on rk3399-sapphire is not an i2c slave
      arm64: dts: rockchip: move rk3399-sapphire i2s2 to daughterboard
      arm64: dts: rockchip: move rk3399-sapphire pwr_btn to daughterboard

Viresh Kumar (7):
      ARM: dts: sun[4-7]i: Remove "cooling-{min|max}-level" for CPU nodes
      ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes
      ARM: dts: omap: Remove "cooling-{min|max}-level" for CPU nodes
      ARM64: dts: hi6220: Remove "cooling-{min|max}-level" for CPU nodes
      ARM64: dts: meson: Remove "cooling-{min|max}-level" for CPU nodes
      ARM: dts: gemini: Remove "cooling-{min|max}-level" for gpio-fan node
      ARM64: dts: meson: Remove "cooling-{min|max}-level" for gpio-fan node

Wadim Egorov (2):
      ARM: dts: rockchip: Fix supply node for card's power on phycore som
      ARM: dts: rockchip: Support UHS mode for SD card on phyCORE-RK3288 RDK

Wolfram Sang (10):
      ARM: dts: lager: use demuxer for IIC2/I2C2
      ARM: dts: lager: use demuxer for IIC3/I2C3
      ARM: dts: koelsch: use demuxer for I2C2
      ARM: dts: koelsch: use demuxer for I2C4
      ARM: dts: porter: use demuxer for I2C2
      ARM: dts: alt: use demuxer for I2C1
      ARM: dts: silk: use demuxer for I2C1
      ARM: dts: gose: use demuxer for I2C2
      ARM: dts: gose: use demuxer for I2C4
      arm64: dts: renesas: salvator-common: add GPIO extender

Yixun Lan (5):
      ARM64: dts: meson-axg: add RMII pins for ethernet controller
      ARM64: dts: meson-axg: uart: drop legacy compatible name from EE UART
      ARM64: dts: meson-axg: uart: Add the pinctrl info description
      ARM64: dts: meson-axg: complete the pinctrl info for UART_AO_A
      ARM64: dts: meson-axg: enable the UART_A controller

Yuantian Tang (3):
      arm64: dts: ls1012a: add cpu idle support
      arm64: dts: ls1043a: add cpu idle support
      arm64: dts: fsl: update the cpu idle node

Zhang Ying-22455 (1):
      arm64: dts: ls1088a: add DT node of watchdog

Zhiyong Tao (1):
      arm64: dts: mt2712: Add auxadc device node.

oscardagrach (1):
      arm64: dts: hikey: Enable HS200 mode on eMMC

 .../arm/cpu-enable-method/nuvoton,npcm750-smp      |   42 +
 Documentation/devicetree/bindings/arm/cpus.txt     |    1 +
 Documentation/devicetree/bindings/arm/mediatek.txt |    9 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,pciesys.txt     |    2 +
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    |    2 +
 .../devicetree/bindings/arm/npcm/npcm.txt          |    6 +
 .../devicetree/bindings/arm/omap/ctrl.txt          |    1 +
 Documentation/devicetree/bindings/arm/qcom.txt     |    1 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   12 +
 .../bindings/arm/samsung/samsung-boards.txt        |    4 +
 Documentation/devicetree/bindings/arm/shmobile.txt |   18 +-
 Documentation/devicetree/bindings/arm/stm32.txt    |    1 +
 Documentation/devicetree/bindings/arm/tegra.txt    |   16 +
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |    2 +
 Documentation/devicetree/bindings/arm/xilinx.txt   |   56 +
 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt |    6 +-
 .../devicetree/bindings/crypto/fsl-sec4.txt        |   17 +
 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |    4 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |    1 +
 .../bindings/memory-controllers/ti/emif.txt        |   13 +-
 .../bindings/phy/nvidia,tegra20-usb-phy.txt        |    4 +-
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    1 +
 .../devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    9 +-
 .../devicetree/bindings/watchdog/sunxi-wdt.txt     |    6 +-
 MAINTAINERS                                        |    1 -
 arch/arm/boot/dts/Makefile                         |   37 +-
 arch/arm/boot/dts/am335x-boneblue.dts              |    2 +-
 arch/arm/boot/dts/am335x-pdu001.dts                |  595 ++++
 arch/arm/boot/dts/am33xx.dtsi                      |   21 +
 arch/arm/boot/dts/am4372.dtsi                      |   30 +
 arch/arm/boot/dts/am437x-gp-evm.dts                |    2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |    2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |    2 +-
 arch/arm/boot/dts/am571x-idk.dts                   |    2 +-
 arch/arm/boot/dts/am572x-idk.dts                   |    3 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |    1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   12 +
 arch/arm/boot/dts/animeo_ip.dts                    |    2 +-
 arch/arm/boot/dts/arm-realview-eb.dtsi             |   64 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts          |   66 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |   78 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi            |   82 +-
 arch/arm/boot/dts/armada-370-db.dts                |   39 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     |   39 +-
 arch/arm/boot/dts/armada-370-mirabox.dts           |   39 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |   41 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |   41 +-
 arch/arm/boot/dts/armada-370-rd.dts                |   39 +-
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |    5 +-
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |    5 +-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi |    5 +-
 .../dts/armada-370-seagate-personal-cloud-2bay.dts |    5 +-
 .../boot/dts/armada-370-seagate-personal-cloud.dts |    5 +-
 .../dts/armada-370-seagate-personal-cloud.dtsi     |    5 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts   |   39 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   39 +-
 arch/arm/boot/dts/armada-370.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-375-db.dts                |   39 +-
 arch/arm/boot/dts/armada-375.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-380.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-385-db-ap.dts             |   33 +-
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    |   34 +-
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     |   34 +-
 arch/arm/boot/dts/armada-385-linksys-rango.dts     |   34 +-
 arch/arm/boot/dts/armada-385-linksys-shelby.dts    |   34 +-
 arch/arm/boot/dts/armada-385-linksys.dtsi          |   39 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts    |   33 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |   35 +-
 arch/arm/boot/dts/armada-385.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-388-clearfog-base.dts     |   38 +-
 arch/arm/boot/dts/armada-388-clearfog-pro.dts      |   38 +-
 arch/arm/boot/dts/armada-388-clearfog.dts          |   38 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi         |   90 +-
 arch/arm/boot/dts/armada-388-db.dts                |   39 +-
 arch/arm/boot/dts/armada-388-gp.dts                |   33 +-
 arch/arm/boot/dts/armada-388-rd.dts                |   39 +-
 arch/arm/boot/dts/armada-388.dtsi                  |   34 +-
 .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi |   38 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-390-db.dts                |   39 +-
 arch/arm/boot/dts/armada-390.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-395-gp.dts                |   33 +-
 arch/arm/boot/dts/armada-395.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-398-db.dts                |   39 +-
 arch/arm/boot/dts/armada-398.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |   39 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |   39 +-
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |   39 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |   39 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts          |   39 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   39 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   39 +-
 arch/arm/boot/dts/armada-xp-db.dts                 |   38 +-
 arch/arm/boot/dts/armada-xp-gp.dts                 |   39 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   39 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   33 +-
 arch/arm/boot/dts/armada-xp-matrix.dts             |   39 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   39 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   39 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   39 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |   41 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts   |   39 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts     |   39 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   39 +-
 arch/arm/boot/dts/artpec6-devboard.dts             |    3 +-
 arch/arm/boot/dts/artpec6.dtsi                     |  163 +-
 .../boot/dts/aspeed-bmc-arm-centriq2400-rep.dts    |  225 ++
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  206 ++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |   16 +-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |    4 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |    4 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   18 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   25 +-
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        |   60 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |    2 +-
 arch/arm/boot/dts/at91-tse850-3.dts                |    3 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   16 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |   24 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   12 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   12 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi                 |    2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   16 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    4 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   15 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |    3 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   12 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi           |    4 +-
 arch/arm/boot/dts/atlas7-evb.dts                   |    2 +-
 arch/arm/boot/dts/axp209.dtsi                      |    5 +
 arch/arm/boot/dts/axp22x.dtsi                      |    5 +
 arch/arm/boot/dts/axp81x.dtsi                      |   12 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |   16 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    4 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |   17 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   20 +-
 arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts  |   68 +
 arch/arm/boot/dts/bcm958622hr.dts                  |    6 +-
 arch/arm/boot/dts/bcm958623hr.dts                  |    6 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |    6 +-
 arch/arm/boot/dts/bcm958625k.dts                   |    6 +-
 arch/arm/boot/dts/bcm988312hr.dts                  |    6 +-
 arch/arm/boot/dts/da850-evm.dts                    |    5 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |   19 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   28 +-
 arch/arm/boot/dts/dra7.dtsi                        |    2 -
 arch/arm/boot/dts/dra71-evm.dts                    |   17 +-
 arch/arm/boot/dts/dra76-evm.dts                    |   50 +-
 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi          |  285 ++
 arch/arm/boot/dts/emev2-kzm9d.dts                  |    8 +-
 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi  |    5 +-
 arch/arm/boot/dts/exynos-syscon-restart.dtsi       |    5 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |   36 +
 arch/arm/boot/dts/exynos3250.dtsi                  |   15 +-
 arch/arm/boot/dts/exynos4.dtsi                     | 1719 +++++------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 1680 ++++++-----
 arch/arm/boot/dts/exynos4210-trats.dts             |   74 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  115 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |  610 ++--
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi        |  140 +
 arch/arm/boot/dts/exynos4412-i9300.dts             |   22 +
 arch/arm/boot/dts/exynos4412-i9305.dts             |   20 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |   16 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            | 1308 +++++++++
 arch/arm/boot/dts/exynos4412-n710x.dts             |   77 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   12 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          | 1914 +++++++------
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |    7 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |    6 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            | 1396 +--------
 arch/arm/boot/dts/exynos4412.dtsi                  |  868 +++---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   18 +
 arch/arm/boot/dts/exynos5250-snow.dts              |   11 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   15 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |    1 -
 arch/arm/boot/dts/exynos5410.dtsi                  |    9 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |   16 -
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   17 +
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |   16 -
 arch/arm/boot/dts/exynos5440.dtsi                  |  514 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   22 +-
 arch/arm/boot/dts/exynos5800.dtsi                  |    5 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts         |    2 -
 arch/arm/boot/dts/imx1-ads.dts                     |    2 +-
 arch/arm/boot/dts/imx1-apf9328.dts                 |    2 +-
 arch/arm/boot/dts/imx1.dtsi                        |    2 +-
 arch/arm/boot/dts/imx23-evk.dts                    |    2 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |    2 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |    2 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |    2 +-
 arch/arm/boot/dts/imx23-xfi3.dts                   |    2 +-
 arch/arm/boot/dts/imx23.dtsi                       |    8 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |    2 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |   12 +-
 arch/arm/boot/dts/imx25-karo-tx25.dts              |    2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   14 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  |   72 +-
 arch/arm/boot/dts/imx25.dtsi                       |    4 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |    2 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |   17 +-
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx27-pdk.dts                    |    2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |    2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |    2 +-
 arch/arm/boot/dts/imx27.dtsi                       |    2 +-
 arch/arm/boot/dts/imx28-apf28.dts                  |    2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |    6 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |    2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |  130 +-
 arch/arm/boot/dts/imx28-duckbill-2-485.dts         |    2 +-
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts     |    2 +-
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts         |    2 +-
 arch/arm/boot/dts/imx28-duckbill-2.dts             |    2 +-
 arch/arm/boot/dts/imx28-duckbill.dts               |    2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts       |    2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts       |    2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi       |    1 +
 arch/arm/boot/dts/imx28-evk.dts                    |    3 +-
 arch/arm/boot/dts/imx28-m28.dtsi                   |    2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |    1 +
 arch/arm/boot/dts/imx28-sps1.dts                   |    2 +-
 arch/arm/boot/dts/imx28-ts4600.dts                 |    2 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |   34 +-
 arch/arm/boot/dts/imx28.dtsi                       |   20 +-
 arch/arm/boot/dts/imx31-bug.dts                    |    2 +-
 arch/arm/boot/dts/imx31.dtsi                       |    2 +-
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |    2 +-
 arch/arm/boot/dts/imx35-pdk.dts                    |    2 +-
 arch/arm/boot/dts/imx35.dtsi                       |    2 +-
 arch/arm/boot/dts/imx50-evk.dts                    |    2 +-
 arch/arm/boot/dts/imx50.dtsi                       |    2 +-
 arch/arm/boot/dts/imx51-apf51.dts                  |    2 +-
 arch/arm/boot/dts/imx51-babbage.dts                |    3 +-
 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts   |    2 +-
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  |    2 +-
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |    2 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 |    2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |   14 +
 arch/arm/boot/dts/imx51.dtsi                       |    2 +-
 arch/arm/boot/dts/imx53-ard.dts                    |    2 +-
 arch/arm/boot/dts/imx53-cx9020.dts                 |    2 +-
 arch/arm/boot/dts/imx53-m53.dtsi                   |    2 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |    1 +
 arch/arm/boot/dts/imx53-ppd.dts                    |   12 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |    3 +-
 arch/arm/boot/dts/imx53-smd.dts                    |    2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |    2 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |    1 +
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |    1 +
 arch/arm/boot/dts/imx53-tx53.dtsi                  |    5 +
 arch/arm/boot/dts/imx53-usbarmory.dts              |    2 +-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |    1 +
 arch/arm/boot/dts/imx53.dtsi                       |    2 +-
 arch/arm/boot/dts/imx6dl-apf6dev.dts               |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |    2 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |    9 +
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts         |    5 +
 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |   64 +
 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi        |    2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts             |    2 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |    2 +-
 arch/arm/boot/dts/imx6dl-ts4900.dts                |    5 +
 arch/arm/boot/dts/imx6dl-ts7970.dts                |    5 +
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-wandboard.dts             |    2 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |   10 -
 arch/arm/boot/dts/imx6q-apf6dev.dts                |    2 +-
 arch/arm/boot/dts/imx6q-arm2.dts                   |    2 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |    2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |    8 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts          |    5 +
 arch/arm/boot/dts/imx6q-display5.dtsi              |    2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |    2 +-
 arch/arm/boot/dts/imx6q-dms-ba16.dts               |  139 +
 arch/arm/boot/dts/imx6q-evi.dts                    |    2 +-
 arch/arm/boot/dts/imx6q-gk802.dts                  |    2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |    2 +-
 arch/arm/boot/dts/imx6q-h100.dts                   |    7 +-
 arch/arm/boot/dts/imx6q-marsboard.dts              |    2 +-
 arch/arm/boot/dts/imx6q-mccmon6.dts                |    2 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |    5 +
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |   72 +
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts   |   72 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |    2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts              |    2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts                |    2 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |    2 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts                |    2 +-
 arch/arm/boot/dts/imx6q-ts4900.dts                 |    5 +
 arch/arm/boot/dts/imx6q-ts7970.dts                 |    5 +
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts        |    2 +-
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts        |    2 +-
 arch/arm/boot/dts/imx6q-wandboard.dts              |    2 +-
 arch/arm/boot/dts/imx6q-zii-rdu2.dts               |    5 +
 arch/arm/boot/dts/imx6q.dtsi                       |    5 -
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |    5 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |    5 +
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |    1 +
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |    2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |   10 +-
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       |    9 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |    8 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |    2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |    2 +-
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi         |  390 +++
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi  |  279 ++
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |    2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |    2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |    4 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |    2 +-
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi            |    2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |   22 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |    4 +-
 arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |   72 +
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts       |    2 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts              |    5 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |    2 +-
 arch/arm/boot/dts/imx6sl-warp.dts                  |    2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |    2 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |    2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |    2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |    2 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts   |    2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts        |    2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts     |    2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts         |    2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   20 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  480 +---
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            |  499 ++++
 arch/arm/boot/dts/imx6ul-geam.dts                  |    3 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |    3 +-
 arch/arm/boot/dts/imx6ul-litesom.dtsi              |    2 +-
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi              |    2 +-
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |    2 +-
 arch/arm/boot/dts/imx6ul-pinfunc.h                 |  169 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |    4 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   31 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |    5 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts      |   14 +
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi     |  157 +
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi     |   23 +
 arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts |   14 +
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi        |   65 +
 arch/arm/boot/dts/imx6ull-colibri.dtsi             |  553 ++++
 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h           |   26 +
 arch/arm/boot/dts/imx6ull.dtsi                     |   32 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |   54 +-
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi          |    2 +-
 arch/arm/boot/dts/imx7d-colibri.dtsi               |    2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |    2 +-
 arch/arm/boot/dts/imx7d-pico.dtsi                  |    2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |    7 +-
 arch/arm/boot/dts/imx7s-colibri.dtsi               |    2 +-
 arch/arm/boot/dts/imx7s-warp.dts                   |   18 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  280 +-
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi         |    2 +-
 arch/arm/boot/dts/keystone-k2e.dtsi                |   13 +-
 arch/arm/boot/dts/keystone-k2g.dtsi                |   82 +-
 arch/arm/boot/dts/keystone-k2hk.dtsi               |  104 +-
 arch/arm/boot/dts/keystone-k2l.dtsi                |   52 +-
 arch/arm/boot/dts/keystone.dtsi                    |   42 +-
 arch/arm/boot/dts/kirkwood-b3.dts                  |    5 +-
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   |    3 +-
 arch/arm/boot/dts/kirkwood-d2net.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |    4 +-
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          |    4 +-
 arch/arm/boot/dts/kirkwood-db.dtsi                 |    5 +-
 arch/arm/boot/dts/kirkwood-dir665.dts              |    4 +-
 arch/arm/boot/dts/kirkwood-ds109.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds110jv10.dts           |    4 +-
 arch/arm/boot/dts/kirkwood-ds111.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds112.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds209.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds210.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds212.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds212j.dts              |    4 +-
 arch/arm/boot/dts/kirkwood-ds409.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds409slim.dts           |    4 +-
 arch/arm/boot/dts/kirkwood-ds411.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ds411j.dts              |    4 +-
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |    4 +-
 arch/arm/boot/dts/kirkwood-laplug.dts              |    4 +-
 arch/arm/boot/dts/kirkwood-linkstation-6282.dtsi   |   39 +-
 .../boot/dts/kirkwood-linkstation-duo-6281.dtsi    |   39 +-
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   |   39 +-
 arch/arm/boot/dts/kirkwood-linkstation-lsvl.dts    |   39 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswsxl.dts  |   39 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswvl.dts   |   39 +-
 arch/arm/boot/dts/kirkwood-linkstation-lswxl.dts   |   39 +-
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        |   39 +-
 arch/arm/boot/dts/kirkwood-linksys-viper.dts       |    4 +-
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     |    5 +-
 arch/arm/boot/dts/kirkwood-nas2big.dts             |    4 +-
 arch/arm/boot/dts/kirkwood-net2big.dts             |    4 +-
 arch/arm/boot/dts/kirkwood-net5big.dts             |    4 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |    6 +-
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  |    6 +-
 arch/arm/boot/dts/kirkwood-netxbig.dtsi            |    4 +-
 arch/arm/boot/dts/kirkwood-nsa320.dts              |    5 +-
 arch/arm/boot/dts/kirkwood-nsa325.dts              |    5 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |    4 +-
 arch/arm/boot/dts/kirkwood-openrd-base.dts         |    5 +-
 arch/arm/boot/dts/kirkwood-openrd-client.dts       |    5 +-
 arch/arm/boot/dts/kirkwood-openrd-ultimate.dts     |    5 +-
 arch/arm/boot/dts/kirkwood-openrd.dtsi             |    5 +-
 arch/arm/boot/dts/kirkwood-pogo_e02.dts            |    4 +-
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts   |    2 +-
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           |    5 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         |    5 +-
 arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |    5 +-
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          |    5 +-
 arch/arm/boot/dts/kirkwood-rs212.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-rs409.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-rs411.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi  |    3 +-
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts    |    3 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts          |    3 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi           |    4 +-
 arch/arm/boot/dts/kirkwood-t5325.dts               |    4 +-
 arch/arm/boot/dts/kirkwood-ts419-6281.dts          |    6 +-
 arch/arm/boot/dts/kirkwood-ts419-6282.dts          |    6 +-
 arch/arm/boot/dts/kirkwood-ts419.dtsi              |    6 +-
 arch/arm/boot/dts/kirkwood.dtsi                    |    2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |   16 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   16 +
 arch/arm/boot/dts/ls1021a.dtsi                     |   16 +
 arch/arm/boot/dts/meson8.dtsi                      |    9 +
 arch/arm/boot/dts/meson8b-odroidc1.dts             |   88 +
 arch/arm/boot/dts/meson8b.dtsi                     |   59 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |   13 +
 arch/arm/boot/dts/mt7623.dtsi                      |  126 +-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      |  133 +-
 arch/arm/boot/dts/mt7623n-rfb-nand.dts             |    6 +-
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi      |  187 ++
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts          |   39 +
 arch/arm/boot/dts/nuvoton-npcm750.dtsi             |   44 +
 arch/arm/boot/dts/omap3-n9.dts                     |    7 +
 arch/arm/boot/dts/omap3.dtsi                       |    1 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  203 +-
 arch/arm/boot/dts/omap443x.dtsi                    |    2 -
 arch/arm/boot/dts/omap4460.dtsi                    |    2 -
 arch/arm/boot/dts/omap5-board-common.dtsi          |    4 +-
 arch/arm/boot/dts/omap5.dtsi                       |   24 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi             |   10 +
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts     |    2 +-
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
 arch/arm/boot/dts/orion5x-linkstation.dtsi         |    2 +-
 arch/arm/boot/dts/orion5x-lswsgl.dts               |    2 +-
 .../boot/dts/orion5x-maxtor-shared-storage-2.dts   |    2 +-
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts        |    2 +-
 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts       |    2 +-
 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts       |    2 +-
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |    2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   63 +
 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts    |   24 +
 .../boot/dts/qcom-msm8974-sony-xperia-castor.dts   |    4 +-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |    4 +
 arch/arm/boot/dts/r8a7743.dtsi                     | 1324 +++++----
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi              |    4 +
 arch/arm/boot/dts/r8a7745.dtsi                     | 1778 ++++++------
 arch/arm/boot/dts/r8a7779-marzen.dts               |   14 +
 arch/arm/boot/dts/r8a7790-lager.dts                |  287 +-
 arch/arm/boot/dts/r8a7790-stout.dts                |  363 +++
 arch/arm/boot/dts/r8a7790.dtsi                     | 2837 ++++++++++---------
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  232 +-
 arch/arm/boot/dts/r8a7791-porter.dts               |  130 +-
 arch/arm/boot/dts/r8a7791.dtsi                     | 2986 ++++++++++----------
 arch/arm/boot/dts/r8a7792.dtsi                     |  498 ++--
 arch/arm/boot/dts/r8a7793-gose.dts                 |  252 +-
 arch/arm/boot/dts/r8a7793.dtsi                     | 2392 ++++++++--------
 arch/arm/boot/dts/r8a7794-alt.dts                  |   53 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |  189 +-
 arch/arm/boot/dts/r8a7794.dtsi                     | 2421 ++++++++--------
 arch/arm/boot/dts/rk322x.dtsi                      |    2 +-
 arch/arm/boot/dts/rk3288-phycore-rdk.dts           |    6 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi          |    5 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |    4 +
 arch/arm/boot/dts/rk3288-rock2-square.dts          |   41 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    |    1 -
 arch/arm/boot/dts/rk3288-vyasa.dts                 |   11 +
 arch/arm/boot/dts/sama5d3.dtsi                     |   24 +-
 arch/arm/boot/dts/sama5d34ek.dts                   |    2 +-
 arch/arm/boot/dts/sama5d3_uart.dtsi                |    8 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   30 +-
 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi          |   68 -
 arch/arm/boot/dts/socfpga.dtsi                     |    2 +-
 arch/arm/boot/dts/stih407-b2120.dts                |    4 +-
 arch/arm/boot/dts/stih407-clock.dtsi               |   92 +-
 arch/arm/boot/dts/stih407-family.dtsi              |   42 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |   10 +-
 arch/arm/boot/dts/stih407.dtsi                     |    5 +-
 arch/arm/boot/dts/stih410-b2120.dts                |   10 +-
 arch/arm/boot/dts/stih410-b2260.dts                |   91 +-
 arch/arm/boot/dts/stih410-clock.dtsi               |   96 +-
 arch/arm/boot/dts/stih410-pinctrl.dtsi             |    2 +-
 arch/arm/boot/dts/stih410.dtsi                     |   14 +-
 arch/arm/boot/dts/stih418-b2199.dts                |   32 +-
 arch/arm/boot/dts/stih418-clock.dtsi               |   95 +-
 arch/arm/boot/dts/stih418.dtsi                     |    6 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |  126 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |   19 +
 arch/arm/boot/dts/stm32746g-eval.dts               |   20 +-
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi             |   31 +
 arch/arm/boot/dts/stm32f429.dtsi                   |   11 +
 arch/arm/boot/dts/stm32f469-disco.dts              |   50 +
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             |  289 ++
 arch/arm/boot/dts/stm32f746-disco.dts              |   20 +
 arch/arm/boot/dts/stm32f746-pinctrl.dtsi           |   11 +
 arch/arm/boot/dts/stm32f746.dtsi                   |  242 +-
 arch/arm/boot/dts/stm32f769-disco.dts              |   65 +-
 arch/arm/boot/dts/stm32f769-pinctrl.dtsi           |   11 +
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |   44 +
 arch/arm/boot/dts/stm32h743.dtsi                   |  112 +-
 arch/arm/boot/dts/stm32h743i-disco.dts             |    2 +-
 arch/arm/boot/dts/stm32h743i-eval.dts              |   20 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  185 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   32 +
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   21 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |  194 ++
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |    3 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |    3 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |    3 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |    3 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |    3 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |    3 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |    3 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |    3 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |    3 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |    3 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |    3 +-
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |    3 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |    3 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |    3 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |    3 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   28 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |    3 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |    4 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |    3 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |    3 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |    2 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |    3 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |    3 +-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |    3 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |    6 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      |    3 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |    3 +-
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |    3 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |    3 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |    3 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |    3 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |    2 -
 arch/arm/boot/dts/sun5i-gr8-evb.dts                |    3 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |    3 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |    3 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |    3 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |   32 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |    3 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |    3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |    2 -
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |    3 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |    3 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |    3 +-
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |    3 +-
 .../boot/dts/sun6i-reference-design-tablet.dtsi    |    3 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |    3 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |   28 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |    3 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |    3 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |    3 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |    3 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |    3 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |    3 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |    3 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |    3 +-
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |    3 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |   28 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   31 +-
 .../boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts  |   36 +
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts  |  335 +++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |    3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |    3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |    6 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |   31 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |    3 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |    3 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |    3 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |    3 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |    3 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   29 +-
 arch/arm/boot/dts/sun8i-a23-evb.dts                |    3 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |   58 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |    3 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |    1 -
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |    3 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |   42 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |    3 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |   12 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  230 +-
 .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    |  121 +
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts    |    8 +
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |   11 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |   32 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |   32 +-
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts |   30 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |   12 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |   25 +
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts      |   27 +-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |    5 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |   32 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |   32 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |   29 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |    2 -
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   30 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   27 +
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts       |    3 +-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |    3 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |   11 +-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  |    3 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |   71 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |    3 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  475 ++++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  122 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |    2 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts         |   23 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts    |  250 ++
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi        | 2052 ++++++++++++++
 arch/arm/boot/dts/tegra124-apalis.dtsi             |   72 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |    2 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |    9 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi         |   16 +-
 arch/arm/boot/dts/tegra20.dtsi                     |    4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |    4 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi              |    7 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |   32 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |    6 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi             |    3 +-
 arch/arm/boot/dts/tegra30.dtsi                     |   35 +
 arch/arm/boot/dts/uniphier-ld4-ref.dts             |   14 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi                |   14 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            |   25 +-
 arch/arm/boot/dts/uniphier-ld6b.dtsi               |   14 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi            |   64 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts            |   25 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |   25 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts          |   25 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi               |   32 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi               |   14 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |   49 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts          |   62 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |   89 +-
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi       |   14 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts            |   14 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi               |   14 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi       |   14 +-
 arch/arm/boot/dts/versatile-ab-ib2.dts             |   26 +
 arch/arm/boot/dts/versatile-ab.dts                 |   83 +-
 arch/arm/boot/dts/vf500-colibri.dtsi               |    2 +-
 arch/arm/boot/dts/vf500.dtsi                       |    7 +-
 arch/arm/boot/dts/vf610-colibri.dtsi               |    2 +-
 arch/arm/boot/dts/vf610-cosmic.dts                 |    2 +-
 arch/arm/boot/dts/vf610-twr.dts                    |    2 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |    2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts              |    4 +-
 arch/arm/boot/dts/vf610m4.dtsi                     |    9 +-
 arch/arm/boot/dts/zynq-7000.dtsi                   |   12 +-
 arch/arm/boot/dts/zynq-cc108.dts                   |   75 +
 arch/arm/boot/dts/zynq-microzed.dts                |   12 +-
 arch/arm/boot/dts/zynq-parallella.dts              |   10 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |   12 +-
 arch/arm/boot/dts/zynq-zc706.dts                   |   12 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts             |   95 +
 arch/arm/boot/dts/zynq-zc770-xm011.dts             |   64 +
 arch/arm/boot/dts/zynq-zc770-xm012.dts             |   64 +
 arch/arm/boot/dts/zynq-zc770-xm013.dts             |   78 +
 arch/arm/boot/dts/zynq-zed.dts                     |   10 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts                 |   58 +
 arch/arm/boot/dts/zynq-zybo.dts                    |   10 +-
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/configs/omap2plus_defconfig               |    3 +
 arch/arm64/Kconfig.platforms                       |   12 +
 arch/arm64/boot/dts/allwinner/Makefile             |    3 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |    3 +-
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |    3 +-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |    3 +-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |    3 +-
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |    8 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      |  265 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   99 +
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |    4 -
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |    2 -
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |   27 +-
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |   29 +-
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts |  143 +
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |   29 +-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |   29 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |  175 ++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |    5 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   18 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  275 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |   40 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   40 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |   42 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |   40 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |   42 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |   39 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    |   39 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   40 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |   39 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |   39 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |   39 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |   40 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |   82 +-
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    |  122 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi  |  256 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   50 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi    |   14 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |   39 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |   39 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d.dtsi   |   39 +-
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |    4 +-
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |    4 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |    4 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |   40 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |   39 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |    4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |   39 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   39 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |    9 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |   40 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts     |   39 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts     |   39 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |   40 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts |    3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |   39 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |   21 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |   90 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |   24 +-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   80 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   83 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   66 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  134 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |    8 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   98 +-
 .../boot/dts/freescale/qoriq-bman-portals.dtsi     |    6 +
 .../boot/dts/freescale/qoriq-qman-portals.dtsi     |    7 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   32 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |    2 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |   10 +-
 arch/arm64/boot/dts/hisilicon/hip06.dtsi           |   56 +
 arch/arm64/boot/dts/hisilicon/hip07.dtsi           |   33 +
 arch/arm64/boot/dts/marvell/armada-371x.dtsi       |   38 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   39 +-
 .../boot/dts/marvell/armada-3720-espressobin.dts   |   41 +-
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   38 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   38 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |   41 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |   93 +-
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |   41 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |   41 +-
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   41 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     |   87 +-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |   65 +-
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   41 +-
 arch/arm64/boot/dts/marvell/armada-8080-db.dts     |   41 +-
 arch/arm64/boot/dts/marvell/armada-8080.dtsi       |   41 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |   41 +-
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |   41 +-
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |   41 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   41 +-
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    |   41 +-
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  |   41 +-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |    2 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  118 +-
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |    4 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |    9 +
 arch/arm64/boot/dts/mediatek/mt6380.dtsi           |   86 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |  469 +++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  675 ++++-
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |  248 ++
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |   16 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  344 +++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |    5 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   16 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   60 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   23 +-
 arch/arm64/boot/dts/renesas/Makefile               |    2 +
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |    3 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  194 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  130 +-
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |   21 +
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |   21 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  878 ++++++
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |   33 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |   11 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |  218 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |   58 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |  385 +++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |  124 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  193 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |    8 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    3 +
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |  267 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    6 +-
 .../arm64/boot/dts/rockchip/rk3368-lion-haikou.dts |  146 +
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      |  317 +++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   13 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   71 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |   28 +
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |   44 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts   |   12 +
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |   67 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   79 +-
 .../boot/dts/socionext/uniphier-ld11-global.dts    |  109 +-
 .../arm64/boot/dts/socionext/uniphier-ld11-ref.dts |   25 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |  127 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |  111 +-
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |   25 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  138 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   36 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |   50 +-
 arch/arm64/boot/dts/sprd/sc2731.dtsi               |  169 ++
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts          |    2 +
 arch/arm64/boot/dts/sprd/whale2.dtsi               |   81 +
 arch/arm64/boot/dts/xilinx/Makefile                |   16 +
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi         |  213 ++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi   |    1 +
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts        |   13 +-
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   54 +
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   42 +
 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   42 +
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  131 +
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  168 ++
 .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  150 +
 .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |  178 ++
 .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  125 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |  289 ++
 .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |   36 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |  548 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |   40 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |  195 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |  522 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |  444 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   17 +-
 drivers/clk/imx/clk-imx7d.c                        |    3 +
 drivers/soc/amlogic/meson-gx-socinfo.c             |    1 +
 include/dt-bindings/clock/imx7d-clock.h            |    5 +-
 include/dt-bindings/clock/tegra194-clock.h         |  321 +++
 include/dt-bindings/gpio/tegra194-gpio.h           |   61 +
 include/dt-bindings/mfd/stm32f7-rcc.h              |    1 +
 include/dt-bindings/power/tegra194-powergate.h     |   35 +
 include/dt-bindings/reset/tegra194-reset.h         |  152 +
 879 files changed, 39742 insertions(+), 20459 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
 create mode 100644 arch/arm/boot/dts/am335x-pdu001.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
 create mode 100644 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-i9300.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-i9305.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-midas.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-n710x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dms-ba16.dts
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
 create mode 100644 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
 create mode 100644 arch/arm/boot/dts/r8a7790-stout.dts
 delete mode 100644 arch/arm/boot/dts/samsung_k3pe0e000b.dtsi
 create mode 100644 arch/arm/boot/dts/stm32f7-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32f746-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32f769-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ed1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-ev1.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
 create mode 100644 arch/arm/boot/dts/versatile-ab-ib2.dts
 create mode 100644 arch/arm/boot/dts/zynq-cc108.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm010.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm011.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm012.dts
 create mode 100644 arch/arm/boot/dts/zynq-zc770-xm013.dts
 create mode 100644 arch/arm/boot/dts/zynq-zybo-z7.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
 create mode 100644
arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-xs.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980-condor.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts
 create mode 100644 arch/arm64/boot/dts/sprd/sc2731.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
 create mode 100644 include/dt-bindings/clock/tegra194-clock.h
 create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
 create mode 100644 include/dt-bindings/power/tegra194-powergate.h
 create mode 100644 include/dt-bindings/reset/tegra194-reset.h
