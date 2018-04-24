Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756970AbeDXLeb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:34:31 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:36306 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756895AbeDXLea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:34:30 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/7] ARM: dts: sunxi: Support ALL-H3-CC H2+/H5 variants
Date: Tue, 24 Apr 2018 19:34:17 +0800
Message-Id: <20180424113424.13196-1-wens@csie.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is adds support for the H2+ and H5 variants of the Libre
Computer Project ALL-H3-CC board. The board uses the same board design
with the H2+, H3, and H5 SoCs, with different memory capacities. The
H3 version was supported in 4.16.

The H5 version is mostly the same as Neil's. I had the patches around
for a few days and was waiting for stuff to calm down for the H3/H5
branch. These patches are properly rebased.

Patch 1 fixes the regulator voltage specified for the VCC-1V2 regulator,
which is a fixed regulator and should obviously be outputting 1.2 volts,
not 3.3 volts.

Patch 2 splits out the common board design of the ALL-H3-CC.

Patch 3 cleans up the H2+ section of the ARM dts Makefile.

Patch 4 adds a device tree for the H2+ variant of ALL-H3-CC.

Patch 5 adds a cpu0 label for the first core on the H5 SoC.
This is needed so we can share the ALL-H3-CC device tree, which
already has DVFS enabled and fixed regulator set for the CPU domain.

Patch 6 cleans up the H5 section of the arm64 allwinner dts Makefile.

Patch 7 adds a device tree for the H5 variant of ALL-H3-CC.

Please have a look.

ChenYu

Chen-Yu Tsai (7):
  ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2 regulator voltage
  ARM: dts: sun8i: h3: Split out common board design for ALL-H3-CC
  ARM: dts: sun8i: h2-plus: Sort dtb entries in Makefile
  ARM: dts: sun8i: h2+: Add Libre Computer Board ALL-H3-CC H2+ ver.
  arm64: dts: allwinner: h5: Add cpu0 label for first cpu
  arm64: dts: allwinner: Sort dtb entries in Makefile
  arm64: dts: allwinner: h5: Add Libre Computer Board ALL-H3-CC H5 ver.

 arch/arm/boot/dts/Makefile                    |   3 +-
 .../dts/sun8i-h2-plus-libretech-all-h3-cc.dts |  13 ++
 .../boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 213 +-----------------
 ....dts => sunxi-hx-libretech-all-h3-cc.dtsi} |  15 +-
 arch/arm64/boot/dts/allwinner/Makefile        |   5 +-
 .../sun50i-h5-libretech-all-h3-cc.dts         |  14 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |   2 +-
 7 files changed, 40 insertions(+), 225 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts
 copy arch/arm/boot/dts/{sun8i-h3-libretech-all-h3-cc.dts => sunxi-hx-libretech-all-h3-cc.dtsi} (93%)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts

-- 
2.17.0
