Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeEGMa5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:30:57 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43631 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeEGMa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:30:56 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 0/3] SY8106A regulator support and enable it on Orange Pi PC
Date: Mon,  7 May 2018 20:29:39 +0800
Message-Id: <20180507122942.25758-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds dt-bindings and driver for Silergy SY8106A, and then
utilize it on the Orange Pi PC board, which uses SY8016A as its CPUX
(main ARM CPU cluster in an Allwinner SoC) power supply.

The driver's functionality is restricted now, mainly {en,dis}able function
is not yet implemented, as it cannot be debugged on Orange Pi PC
(disable it will kill Linux).

Ondrej Jirman (3):
  dt-bindings: add binding for the SY8106A voltage regulator
  regulator: add support for SY8106A regulator
  ARM: dts: sun8i: h3: Add SY8106A regulator to Orange Pi PC

 .../bindings/regulator/sy8106a-regulator.txt  |  23 +++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts    |  28 +++
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   2 +-
 drivers/regulator/sy8106a-regulator.c         | 168 ++++++++++++++++++
 6 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
 create mode 100644 drivers/regulator/sy8106a-regulator.c

-- 
2.17.0
