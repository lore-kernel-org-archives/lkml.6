Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeBQTzG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 14:55:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5922 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751131AbeBQTzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 14:55:04 -0500
X-UUID: a5ba97e43905453985b1fbbe278cc868-20180218
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v3 00/15] add dts nodes to MT7622 SoC
Date: Sun, 18 Feb 2018 03:54:35 +0800
Message-ID: <cover.1518895232.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v2:
- rebase to 4.16-rc1 and solve all conflicts
- add proper list Cc in patch 1
- add fixup in patch 4 in v2 with the uniform pinmux definition
  that is always adding property function before property groups
- add Acked-by from Philippe in patch 5
- add clock related property into all CPU nodes in patch 6
- merge patch 14 in v2 into patch 8 as this is where the node is
  defined in the first place

Changes since v1:
- add usb, thermal, HSDMA, mmc related nodes
- fix Warning (unit_address_vs_reg): Node /oscillator@0 has
  a unit name, but no reg property in patch 2
- fix Warning (pci_bridge): Node /pcie@1a140000/pcie@0,0 missing
  bus-range for PCI bridge
- fix Warning (pci_bridge): Node /pcie@1a140000/pcie@1,0 missing
  bus-range for PCI bridge
- fix Warning (unit_address_format): Failed prerequisite 'pci_bridge'
- fix Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
- fix Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
- enhance commit log in patch 4
- use - instead of _ in DT node name in patch 4 and 6
- use SPDX-License-Identifier for newly added files in patch 5
- use proper #size-cells for spi nor nodes in patch 9
- remove currently no needed #address-cells and #size-cells in
children nodes of spi nor in patch 9.

Chunfeng Yun (1):
  arm64: dts: mt7622: add usb device nodes

Ryder Lee (2):
  arm64: dts: mt7622: add PCIe device nodes
  arm64: dts: mt7622: add SATA device nodes

Sean Wang (12):
  dt-bindings: clock: mediatek: add missing required #reset-cells
  arm64: dts: mt7622: add clock controller device nodes
  arm64: dts: mt7622: add power domain controller device nodes
  arm64: dts: mt7622: add pinctrl related device nodes
  arm64: dts: mt7622: add PMIC MT6380 related nodes
  arm64: dts: mt7622: add cpufreq related device nodes
  arm64: dts: mt7622: turn uart0 clock to real ones
  arm64: dts: mt7622: add SoC and peripheral related device nodes
  arm64: dts: mt7622: add flash related device nodes
  arm64: dts: mt7622: add ethernet device nodes
  arm64: dts: mt7622: add High-Speed DMA device nodes
  arm64: dts: mt7622: add mmc related device nodes

 .../bindings/arm/mediatek/mediatek,ethsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,pciesys.txt     |   2 +
 .../bindings/arm/mediatek/mediatek,ssusbsys.txt    |   2 +
 arch/arm64/boot/dts/mediatek/mt6380.dtsi           |  86 +++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       | 469 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 685 ++++++++++++++++++++-
 6 files changed, 1240 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi

-- 
2.7.4
