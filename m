Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeBWKQt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:16:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4379 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751357AbeBWKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:47 -0500
X-UUID: e5e4536d269e4f668e309c16a7d5a5be-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 00/19] refactor dts and add support for more boards
Date: Fri, 23 Feb 2018 18:16:20 +0800
Message-ID: <cover.1519378871.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The series is to refactor current .dts for allowing more boards can properly
join and reuse almost the same device node definitions.

Before we're doing that, some works about enhancements and fixups are being
made on the dt-binding document and .dts files. In addition, the series has to
depend on the patch [1][2]. Otherwise, certain build failure would have an
occurrence.

[1] arm: dts: mt7623: add PCIe related nodes
http://lists.infradead.org/pipermail/linux-mediatek/2018-February/012053.html

[2] dt-bindings: soc: add header files required for MT7623A SCPSYS dt-binding
http://lists.infradead.org/pipermail/linux-mediatek/2018-February/011930.html

Sean Wang (19):
  dt-bindings: pinctrl: mediatek: use - instead of _ in examples
  dt-bindings: cpufreq: mediatek: use - instead of _ in examples
  dt-bindings: pinctrl: mediatek: add bindings for I2C2 and SPI2 on
    MT7623
  dt-bindings: arm: mediatek: add support for more mt7623 reference
    boards
  arm: dts: mt7623: add BTIF, HSDMA and SPI-NOR device nodes
  arm: dts: mt7623: fix USB initialization fails on bananapi-r2
  arm: dts: mt7623: fix the regulators mmc should use on bananapi-r2
  arm: dts: mt7623: enable three available UARTs on bananapi-r2
  arm: dts: mt7623: add related clock properties to cpu[1-3] nodes
  arm: dts: mt7623: remove useless property pinctrl-names at node
    switch@0
  arm: dts: mt7623: use - instead of _ in DT node name
  arm: dts: mt7623: fix all Warnings (unit_address_vs_reg)
  arm: dts: mt7623: move node mt6323 leds to mt6323.dtsi
  arm: dts: mt7623: extend common file to unify all boards with MT7623
    SoCs
  arm: dts: mt7623: add SPI[1,2], I2C2 and sound related nodes to
    reference board
  arm: dts: mt7623: fixup available memory size on bananapi-r2
  arm: dts: mt7623: add MT7623N reference board with eMMC
  arm: dts: mt7623: add MT7623A reference boards
  arm: dts: mediatek: converted to using SPDX identifiers

 Documentation/devicetree/bindings/arm/mediatek.txt |   9 +
 .../bindings/cpufreq/cpufreq-mediatek.txt          |   6 +-
 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |   4 +-
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/mt2701-evb.dts                   |   9 +-
 arch/arm/boot/dts/mt2701.dtsi                      |   9 +-
 arch/arm/boot/dts/mt6323.dtsi                      |  34 +-
 arch/arm/boot/dts/mt6580-evbp1.dts                 |   9 +-
 arch/arm/boot/dts/mt6580.dtsi                      |   9 +-
 arch/arm/boot/dts/mt6589-aquaris5.dts              |  10 +-
 arch/arm/boot/dts/mt6589.dtsi                      |  12 +-
 arch/arm/boot/dts/mt6592-evb.dts                   |   9 +-
 arch/arm/boot/dts/mt6592.dtsi                      |   9 +-
 arch/arm/boot/dts/mt7623.dtsi                      |  70 ++-
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts             |  22 +
 arch/arm/boot/dts/mt7623a-rfb-nand.dts             |  26 +
 arch/arm/boot/dts/mt7623a-rfb.dtsi                 |  84 +++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts      | 462 +--------------
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts             |  37 ++
 arch/arm/boot/dts/mt7623n-rfb-nand.dts             | 100 +---
 arch/arm/boot/dts/mt7623n-rfb.dtsi                 | 652 ++++++++++++++++++++-
 arch/arm/boot/dts/mt8127-moose.dts                 |   9 +-
 arch/arm/boot/dts/mt8127.dtsi                      |   9 +-
 arch/arm/boot/dts/mt8135-evbp1.dts                 |   9 +-
 arch/arm/boot/dts/mt8135.dtsi                      |   9 +-
 include/dt-bindings/pinctrl/mt7623-pinfunc.h       |  24 +
 26 files changed, 966 insertions(+), 679 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb.dtsi
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-emmc.dts

-- 
2.7.4
