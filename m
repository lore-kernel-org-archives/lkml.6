Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeDRKZN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:25:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65195 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753841AbeDRKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:25:04 -0400
X-UUID: f02bb6bcf8d149c9b17eb2464045e4c6-20180418
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <airlied@linux.ie>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-clk@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 0/4] add Mali-450 support to MT7623 SoC
Date: Wed, 18 Apr 2018 18:24:52 +0800
Message-ID: <cover.1524044917.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Hi,

The series adds a required resource setup to allow Mali-450 to work on
MT7623. This also can benefits other MediaTek SoCs having Mali-450 device.

In order to prove the setup is proper, I also have added mediatek port to
linux-lima at [1] and make a few of tests along with off-screen rendering
[2][3][4][5][6][7] through mesa-lima [8]. All work correctly.

[1] https://github.com/objelf/linux-lima/tree/mediatek-lima-4.16-rc5
[2] simple triangle: https://github.com/yuq/gfx/tree/master/gbm-surface
[3] vertex shader uniform: https://github.com/yuq/gfx/tree/master/gbm-surface-move
[4] multi varying: https://github.com/yuq/gfx/tree/master/gbm-surface-color
[5] multi draw: https://github.com/yuq/gfx/tree/master/gbm-surface-draw
[6] FBO: https://github.com/yuq/gfx/tree/master/gbm-surface-fbo
[7] kmscube: https://github.com/yuq/kmscube
[8] https://github.com/yuq/mesa-lima

Hope these patches can help people working on BPI-R2.

	Sean

Sean Wang (4):
  dt-bindings: gpu: mali-utgard: add mediatek,mt7623-mali compatible
  dt-bindings: clock: mediatek: add g3dsys bindings
  clk: mediatek: add g3dsys support for MT2701 and MT7623
  arm: dts: mt7623: add Mali-450 and related device nodes

 .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 +++++++
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  9 ++
 arch/arm/boot/dts/mt7623.dtsi                      | 70 ++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi                     |  4 +
 drivers/clk/mediatek/Kconfig                       |  6 ++
 drivers/clk/mediatek/Makefile                      |  1 +
 drivers/clk/mediatek/clk-mt2701-g3d.c              | 95 ++++++++++++++++++++++
 include/dt-bindings/clock/mt2701-clk.h             |  4 +
 include/dt-bindings/reset/mt2701-resets.h          |  3 +
 9 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt
 create mode 100644 drivers/clk/mediatek/clk-mt2701-g3d.c

-- 
2.7.4
