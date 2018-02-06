Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeBFEt6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:49:58 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50187 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752208AbeBFEtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:49:50 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 00/10] Allwinner H3 DVFS support
Date: Tue,  6 Feb 2018 12:48:55 +0800
Message-Id: <20180206044905.30508-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to add DVFS support for Allwinner H3 SoC,
considering two kinds of adjustable regulators used on H3 boards:
SY8106A I2C-controlled regulator and SY8113B regulator (controllable
by GPIO with some special designs on the board), and also taking the
uncontrollable boards into consider.

PATCH 1 and PATCH 2 are for the SY8106A regulator, then PATCH 3 and
PATCH 4 are for the r_i2c bus, which is used by boards with SY8106A
to communicate with the regulator.

PATCH 5 adds the operating points v2 table to the H3 SoC, but with
OPPs higher than 1008MHz temporarily dropped.

Then there's patches for several tested boards: Orange Pi PC (with
SY8106A), Orange Pi One/Zero (with GPIO-adjustable SY8113B) and
ALL-H3-CC (unadjustable).

Icenowy Zheng (5):
  ARM: sun8i: h3: add operating-points-v2 table for CPU
  ARM: sun8i: h2+: add SY8113B regulator used by Orange Pi Zero board
  ARM: sun8i: h3: add SY8113B regulator used by Orange Pi One board
  ARM: sun8i: h3: fix ALL-H3-CC H3 ver VDD-CPUX voltage
  ARM: sun8i: h3: set the cpu-supply to VDD-CPUX on ALL-H3-CC H3 ver

Ondrej Jirman (5):
  dt-bindings: add binding for the SY8106A voltage regulator
  regulator: add support for SY8106A regulator
  ARM: sunxi: h3/h5: Add r_i2c pinmux node
  ARM: sunxi: h3/h5: Add r_i2c I2C controller
  ARM: sun8i: h3: Add SY8106A regulator to Orange Pi PC

 .../bindings/regulator/sy8106a-regulator.txt       |  20 +++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  21 +++
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts |   8 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  21 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  27 ++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  32 +++-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  18 +++
 drivers/regulator/Kconfig                          |   8 +-
 drivers/regulator/Makefile                         |   2 +-
 drivers/regulator/sy8106a-regulator.c              | 168 +++++++++++++++++++++
 10 files changed, 320 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
 create mode 100644 drivers/regulator/sy8106a-regulator.c

-- 
2.15.1
