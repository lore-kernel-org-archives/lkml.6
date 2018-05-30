Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeE3OK3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:10:29 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:25600 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeE3OK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:10:27 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC: <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 0/6] Add MCAN Support for dra76x
Date: Wed, 30 May 2018 19:41:27 +0530
Message-ID: <20180530141133.3711-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add dts, hwmod and sysconfig support
for MCAN on TI's dra76 SOCs

The patches depend on the following series:
https://patchwork.kernel.org/patch/10221105/

Changes in v2:
 1. Added Support for mcan in the ti-sysc driver
    Also added the target-module node for the same

 2. Added clkctrl data for mcan clocks

Faiz Abbas (3):
  clk: ti: dra7: Add clkctrl clock data for the mcan clocks
  bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
  ARM: dts: Add generic interconnect target module node for MCAN

Franklin S Cooper Jr (1):
  ARM: dts: dra76x: Add MCAN node

Lokesh Vutla (2):
  ARM: dra762: hwmod: Add MCAN support
  ARM: dts: dra762: Add MCAN clock support

 .../devicetree/bindings/bus/ti-sysc.txt       |  1 +
 arch/arm/boot/dts/dra76-evm.dts               |  7 ++
 arch/arm/boot/dts/dra76x.dtsi                 | 67 +++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c     | 32 +++++++++
 drivers/bus/ti-sysc.c                         | 17 +++++
 drivers/clk/ti/clk-7xx.c                      |  1 +
 include/dt-bindings/bus/ti-sysc.h             |  2 +
 include/dt-bindings/clock/dra7.h              |  1 +
 include/linux/platform_data/ti-sysc.h         |  1 +
 9 files changed, 129 insertions(+)

-- 
2.17.0
