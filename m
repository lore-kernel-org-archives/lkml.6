Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEVAiY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:38:24 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:32827 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeEVAiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:38:21 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <gregkh@linuxfoundation.org>
CC: <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: for 4.18
Date: Tue, 22 May 2018 06:08:18 +0530
Message-ID: <20180522003818.15406-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 4.18 merge window below. It adds a couple of
new USB PHY drivers, adds support for couple of newer PHYs in existing
drivers and few cleanups. Please find the complete set of changes in the tag
message below.

Consider merging it and let me know If I have to make any changes.

Thanks
Kishon

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.18

for you to fetch changes up to c1eb8f83845b6ca9e53c41c26a4dff57597d4969:

  phy: mediatek: add XS-PHY driver (2018-05-20 21:51:35 +0530)

----------------------------------------------------------------
phy: for 4.18

 *) Add PHY driver for the ATH79 USB PHY
 *) Add USB3 PHY driver for Mediatek XS-PHY
 *) Add QUSB/QMP V3 USB3 PHY Support for Qualcomm's SDM845
 *) Add runtime PM support for mapphone PHY driver
 *) Allow phy_pm_runtime_xxx API calls to accept NULL
 *) Other minor cleanups and fixes

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Alban Bedel (1):
      phy: Add a driver for the ATH79 USB phy

Amelie Delaunay (1):
      phy: stm32: fix usbphyc static checker and checkpatch warnings

Andy Shevchenko (1):
      phy: tegra: Convert to use match_string() helper

Chunfeng Yun (2):
      dt-bindings: add MediaTek XS-PHY binding
      phy: mediatek: add XS-PHY driver

Manu Gautam (7):
      phy: core: Allow phy_pm_runtime_xxx API calls with NULL phy
      phy: qcom-qmp: Enable pipe_clk before PHY initialization
      phy: qcom-qusb2: Fix crash if nvmem cell not specified
      dt-bindings: phy-qcom-qmp: Update bindings for sdm845
      phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
      dt-bindings: phy-qcom-usb2: Add support to override tuning values
      phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845

Sylwester Nawrocki (1):
      phy: exynos-mipi-video: Simplify code by using regmap_update_bits()

Tony Lindgren (1):
      phy: mapphone-mdm6600: Add runtime PM support for n_gsm on USB suspend

 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt  | 109 ++++++++++++++++++++++++++
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt   |   3 +-
 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt |  23 +++++-
 MAINTAINERS                                              |   8 ++
 drivers/phy/mediatek/Kconfig                             |   9 +++
 drivers/phy/mediatek/Makefile                            |   1 +
 drivers/phy/mediatek/phy-mtk-xsphy.c                     | 600 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/motorola/phy-mapphone-mdm6600.c              |  85 ++++++++++++++++++++
 drivers/phy/phy-core.c                                   |  18 +++++
 drivers/phy/qualcomm/Kconfig                             |  11 ++-
 drivers/phy/qualcomm/Makefile                            |   1 +
 drivers/phy/qualcomm/phy-ath79-usb.c                     | 108 +++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                      | 169 +++++++++++++++++++++++++++++++++++----
 drivers/phy/qualcomm/phy-qcom-qmp.h                      |   5 ++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                    | 130 ++++++++++++++++++++++++++++--
 drivers/phy/samsung/phy-exynos-mipi-video.c              |  34 ++++----
 drivers/phy/st/phy-stm32-usbphyc.c                       |   9 +--
 drivers/phy/tegra/xusb.c                                 |  15 +---
 include/dt-bindings/phy/phy-qcom-qusb2.h                 |  37 +++++++++
 19 files changed, 1310 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
 create mode 100644 drivers/phy/mediatek/phy-mtk-xsphy.c
 create mode 100644 drivers/phy/qualcomm/phy-ath79-usb.c
 create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h
-- 
2.17.0
