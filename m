Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeDKOTS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:19:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48275 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbeDKOTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:19:16 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/5] Add support in dwmac-sun8i for accessing EMAC clock
Date: Wed, 11 Apr 2018 22:16:36 +0800
Message-Id: <20180411141641.14675-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Allwinner SoCs, the EMAC clock register is in another device's
emory space, e.g. on A64 it's in the memory space of SRAM controller.

This patchset adds the possibility for the device to export the EMAC
clock register as a single-register regmap.

PATCH 1 adds the device tree binding for dwmac-sun8i to use another
device's regmap.

PATCH 2 and 3 are dwmac-sun8i refactors.

PATCH 4 exports the EMAC clock regmap in the SRAM controller driver.

PATCH 5 enable SRAM controller in the A64 device tree (replaces
syscon), and bind dwmac-sun8i to it.

Chen-Yu Tsai (2):
  net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access
  net: stmmac: dwmac-sun8i: Allow getting syscon regmap from device

Icenowy Zheng (3):
  dt-bindings: allow dwmac-sun8i to use other devices' exported regmap
  drivers: soc: sunxi: export a regmap for EMAC clock reg on A64
  arm64: allwinner: a64: add SRAM controller device tree node

 .../devicetree/bindings/net/dwmac-sun8i.txt        |  5 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 23 +++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 85 +++++++++++++++++++---
 drivers/soc/sunxi/sunxi_sram.c                     | 48 +++++++++++-
 4 files changed, 141 insertions(+), 20 deletions(-)

-- 
2.15.1
