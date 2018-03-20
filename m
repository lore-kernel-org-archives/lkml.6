Return-Path: <kishon@ti.com>
X-Google-Smtp-Source: AG47ELsqp+9IBYx6hr9Cmk+mooSSxf1ovAObezhqzibZnhID3ZRj3nxkPXsqWezxD2pNvRdE8TKu
ARC-Seal: i=1; a=rsa-sha256; t=1521534870; cv=none;
        d=google.com; s=arc-20160816;
        b=shpCUCuLThpE9plssiOb3NMPG7p9mDTA//VpM+P61abZAUvA0umMr8J8bID2VtbQi8
         X2LdEPjWagfJ07jErABzQL8g22zPJaEIFwapAwv1oIIQjraQGZdjAdAcH6GNNfwuS7Gp
         W9ncneWG+yDGFBDuPd65zuv7SM3P40wH7qp02q/CR41YEWlcL1bKt1ccupbbNX64GQ1p
         DNvkIEQqwjbscuvNWK6ccyjPhfIwXYXjPw4IInVbX+SuxUruA3m+lALonZYzCw2U6Z7O
         3nZDnhiD5ar3tLmTT29kltminrhbKUAuWvwjs11oUiSwrNrYD4HXJSTLvKHZKCLjCRVj
         Eeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=K24tEsTpDuvng5XvC5/28+HROxVWn1+z+PGfrciClJg=;
        b=AHapAy8MIcMCUKNqn8h1kLvon4OZ7HFY0FrdsV6P/SaIHS/XG+d6s0tcDQTYDTtf5K
         lE1y+CRH12yjuGsq3cRnUMzG0te2EL//ZdrzoSgwfppeGg/sBlgfZw5ma3J1/RZxxH2Q
         t1LMfInCCfYHEQDUHzf1zKawauFkt8yw+6tZkQQDoX2ftWRagRI+2DaN4nML2Rzg7LJc
         ZuOzweAe2X7CL9Pm5zRvDjKtS3KSOxMiNpOCO9gLLMcGjFjFvppaNnrAhEkxa9JktlCE
         2dSM0f2Cr93HfvmD9z7AnyTqxWCPV94HV89hglfHfFmS1Zirb5YyVoHrOPHkQHAWjDVB
         0ycA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=UXTsohzZ;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=UXTsohzZ;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <gregkh@linuxfoundation.org>
CC: <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] phy: for 4.17
Date: Tue, 20 Mar 2018 14:04:26 +0530
Message-ID: <20180320083426.25404-1-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595444947842553025?=
X-GMAIL-MSGID: =?utf-8?q?1595444947842553025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Please find the pull request for 4.17 merge window below.

This adds 5 new phy drivers (mostly USB) apart from adding support for
3 PHYs in existing PHY drivers. This also adds USB speed related PHY
modes in PHY core like PHY_MODE_USB_HOST_LS, PHY_MODE_USB_HOST_FS etc.,
in order for the USB controller driver to be able to use set_mode ops
to indicate the enumerated speed modes. This is apparently required
to enable appropriate DP/DM wakeup interrupts polarity in suspend state
in Qualcomm SoC. For the detailed list of changes, please see the tag
message below.

Let me know If I have to make any changes.

Thanks
Kishon

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.17

for you to fetch changes up to e7f4da4c44fe74e1c9277bac9b12ea1ef4eb70db:

  phy: tegra: xusb: Uncomment register write (2018-03-16 16:55:38 +0530)

----------------------------------------------------------------
phy: for 4.17

 *) Add USB PHY driver for MDM6600 on Droid
 *) Add USB PHY driver for STM32 USB PHY Controller
 *) Add inno-usb2-phy driver for hi3798cv200 SoC
 *) Add combo phy driver (SATA/USB/PCIE) for HiSilicon STB SoCs
 *) Add USB3 PHY driver for Meson GXL and GXM
 *) Add support for R8A77965 Gen3 USB 2.0 PHY in phy-rcar-gen3-usb2 driver
 *) Add support for qualcomm QUSB2 V2 and QMP V3 USB3 PHY in phy-qcom-qusb2
    and phy-qcom-qmp PHY driver respectively
 *) Add support for runtime PM in phy-qcom-qusb2 and phy-qcom-qmp PHY drivers
 *) Add support for Allwinner R40 USB PHY in sun4i-usb PHY driver
 *) Add support in rockchip-typec PHY driver to make extcon optional and
    fallback to working in host mode if extcon is missing
 *) Add support in rockchip-typec PHY driver to mux PHYs connected to DP
 *) Add support to configure slew rate parameters in phy-mtk-tphy PHY driver
 *) Add workaround for missing Vbus det interrupts on Allwinner A23/A33
 *) Add USB speed related PHY modes in phy core
 *) Fix PHY 'structure' documentation
 *) Force rockchip-typec PHY to USB2 if DP-only mode is used
 *) Fix phy-qcom-qusb2 and phy-qcom-qmp PHY drivers to follow PHY reset and
    initialization sequence as per hardware programming manual
 *) Fix Marvell BG2CD SoC USB failure in phy-berlin-usb driver
 *) Minor fixes in lpc18xx-usb-otg, xusb-tegra210 and phy-rockchip-emmc PHY
    drivers

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Alexander Monakov (1):
      phy: berlin-usb: adjust USB_PHY_RX_CTRL init flags

Alexey Khoroshilov (1):
      phy: lpc18xx-usb-otg: error handling in lpc18xx_usb_otg_phy_power_on()

Amelie Delaunay (2):
      dt-bindings: phy: add support for STM32 USB PHY Controller (USBPHYC)
      phy: stm32: add support for STM32 USB PHY Controller (USBPHYC)

Chen-Yu Tsai (1):
      phy: allwinner: sun4i-usb: poll vbus changes on A23/A33 when driving VBUS

Chris Zhong (2):
      phy: rockchip-typec: force to USB2 if DP at 4 lanes mode
      phy: rockchip-typec: support DP phy switch

Chunfeng Yun (3):
      phy: phy-mtk-tphy: keep default value of mcu_bus_ck_gate_en
      phy: phy-mtk-tphy: add configurable parameters for slew rate calibrate
      dt-bindings: phy-mtk-tphy: add properties for U2 slew rate calibrate

Colin Ian King (1):
      phy: tegra: remove redundant self assignment of 'map'

Dov Levenglick (1):
      phy: fix structure documentation

Enric Balletbo i Serra (4):
      phy: rockchip-typec: deprecate some DT properties for various register fields.
      dt-bindings: phy-rockchip-typec: deprecate some register properties.
      dt-bindings: phy-rockchip-typec: move extcon property to be optional.
      phy: rockchip-typec: fall back to working in host-mode if extcon is missing.

Icenowy Zheng (1):
      phy: sun4i-usb: add support for R40 USB PHY

Jianguo Sun (2):
      dt-bindings: add bindings doc for hi3798cv200 combphy
      phy: add combo phy driver for HiSilicon STB SoCs

Manu Gautam (15):
      phy: qcom-qmp: Power-on PHY before initialization
      phy: qcom-qusb2: Power-on PHY before initialization
      phy: qcom-qmp: Fix PHY block reset sequence
      phy: qcom-qmp: Move SERDES/PCS START after PHY reset
      phy: qcom-qusb2: Add support for different register layouts
      dt-bindings: phy-qcom-qusb2: Update binding for QUSB2 V2 version
      phy: qcom-qusb2: Add support for QUSB2 V2 version
      phy: qcom-qmp: Move register offsets to header file
      phy: qcom-qmp: Add register offsets for QMP V3 PHY
      dt-bindings: phy-qcom-qmp: Update bindings for QMP V3 USB PHY
      phy: qcom-qmp: Add support for QMP V3 USB3 PHY
      phy: Add USB speed related PHY modes
      phy: qcom-qusb2: Add support for runtime PM
      phy: qcom-qmp: Add support for runtime PM
      phy: add SPDX identifier to QMP and QUSB2 PHY drivers

Martin Blumenstingl (7):
      dt-bindings: phy: meson-gxl-usb2-phy: add the reset line and clock
      phy: amlogic: phy-meson-gxl-usb2: don't log an error on -EPROBE_DEFER
      phy: amlogic: phy-meson-gxl-usb2: support the clock and reset line
      phy: amlogic: phy-meson-gxl-usb2: default to host mode
      phy: amlogic: phy-meson-gxl-usb2: rename some of the U2P_R2 registers
      dt-bindings: phy: Add support for the USB3 PHY on Amlogic Meson GXL SoCs
      phy: amlogic: add USB3 PHY support for Meson GXL and GXM

Masahiro Yamada (1):
      phy: add 'depends on HAS_IOMEM' to fix unmet dependency

Pengcheng Li (2):
      dt-bindings: add bindings doc for HiSilicon INNO USB2 PHY
      phy: add inno-usb2-phy driver for hi3798cv200 SoC

Shawn Guo (1):
      dt-bindings: hisilicon: add doc for Hi3798CV200 peripheral controller

Shawn Lin (2):
      phy: rockchip-emmc: retry calpad busy trimming
      phy: rockchip-emmc: use regmap_read_poll_timeout to poll dllrdy

Thierry Reding (1):
      phy: tegra: xusb: Uncomment register write

Tony Lindgren (1):
      phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4

Ulf Magnusson (1):
      phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB

Vivek Gautam (2):
      phy: qcom-qmp: Fix phy pipe clock gating
      phy: qcom-qmp: Adapt to clk_bulk_* APIs

William wu (1):
      phy: rockchip-typec: enable usb3 host during usb3 phy power on

Yoshihiro Shimoda (3):
      dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8a77965
      phy: rcar-gen3-usb2: Add support for r8a77965
      dt-bindings: rcar-gen3-phy-usb3: Add bindings for r8a77965

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt     |  23 +++++
 Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt      |   4 +
 Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt      |  31 +++++++
 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt |  59 ++++++++++++
 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt      |  71 +++++++++++++++
 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt    |  29 ++++++
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt            |   4 +
 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt      |  35 ++------
 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt       |  73 +++++++++++++++
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt            |   6 +-
 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt          |   5 +-
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt      |   2 +
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt      |   2 +
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt           |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c                             |  22 ++++-
 drivers/phy/amlogic/Kconfig                                       |  13 ++-
 drivers/phy/amlogic/Makefile                                      |   1 +
 drivers/phy/amlogic/phy-meson-gxl-usb2.c                          |  78 +++++++++++-----
 drivers/phy/amlogic/phy-meson-gxl-usb3.c                          | 282 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/hisilicon/Kconfig                                     |  20 +++++
 drivers/phy/hisilicon/Makefile                                    |   2 +
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                        | 197 ++++++++++++++++++++++++++++++++++++++++
 drivers/phy/hisilicon/phy-histb-combphy.c                         | 289 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/marvell/phy-berlin-usb.c                              |   2 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                               |  23 +++--
 drivers/phy/motorola/Kconfig                                      |   8 ++
 drivers/phy/motorola/Makefile                                     |   1 +
 drivers/phy/motorola/phy-mapphone-mdm6600.c                       | 542 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/phy-core.c                                            |   2 +
 drivers/phy/phy-lpc18xx-usb-otg.c                                 |   8 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                               | 647 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
 drivers/phy/qualcomm/phy-qcom-qmp.h                               | 280 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                             | 418 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 drivers/phy/ralink/Kconfig                                        |   1 +
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                          |   4 +
 drivers/phy/rockchip/Kconfig                                      |   1 +
 drivers/phy/rockchip/phy-rockchip-emmc.c                          |  60 ++++++-------
 drivers/phy/rockchip/phy-rockchip-typec.c                         | 160 ++++++++++++++++++++++-----------
 drivers/phy/samsung/Kconfig                                       |   2 +-
 drivers/phy/st/Kconfig                                            |  14 +++
 drivers/phy/st/Makefile                                           |   1 +
 drivers/phy/st/phy-stm32-usbphyc.c                                | 461 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb-tegra210.c                                 |   6 +-
 drivers/phy/tegra/xusb.c                                          |   2 +-
 include/linux/phy/phy.h                                           |  31 ++++++-
 45 files changed, 3499 insertions(+), 424 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3798cv200-combphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hisi-inno-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-gxl-usb3.c
 create mode 100644 drivers/phy/hisilicon/phy-hisi-inno-usb2.c
 create mode 100644 drivers/phy/hisilicon/phy-histb-combphy.c
 create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp.h
 create mode 100644 drivers/phy/st/phy-stm32-usbphyc.c
-- 
2.11.0
