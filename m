Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934859AbeBMJqg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:46:36 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36812 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbeBMJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:46:32 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] R-Car M3-N initial support
Date: Tue, 13 Feb 2018 10:45:47 +0100
Message-Id: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, this series adds support for Rensas R-Car M3-N (r8a77965) Soc and
M3-N based Salvator-x development board.

The series introduces a cpg-mssr clock/power gating module, a power/reset
controller for the SoC and initial PFC support.

Clock and power areas for M3-N are identical to M3-W, with the exception of
a missing PLL line used to power M3-W Cortex-A53 little cores, not present in
M3-N.

Few functionalities have currently been enabled in DTS and tested: serial
boot console, EtherAVB and gpios (tested as ethernet interface reset).

Thanks
   j

Jacopo Mondi (15):
  Documentation: devicetree: R-Car M3-N SoC DT bindings
  clk: renesas: cpg-msr: Add support for R-Car M3-N
  soc: renesas: Add R-Car M3-N support
  pinctrl: sh-pfc: Initial R-Car M3-N support
  ARM64: dts: Add R-Car Salvator-x M3-N support
  Documentation: devicetree: dma: Add r8a77965 dmac
  ARM64: dts: r8a77965: Add dmac device nods
  Documentation: devicetree: renesas,sci: Add r8a77965
  pinctrl: sh-pfc: r8a77965: Add SCIFs groups/functions
  ARM64: dts: r8a77965: Add SCIF device nodes
  gpio: rcar: Add R-Car M3-N compatible string
  ARM64: dts: r8a77965: Add GPIO nodes
  Documentation: devicetree: ravb: Add r8a77965
  pinctrl: sh-pfc: r8a77965: Add EtherAVB groups/functions
  ARM64: dts: r8a77965: Add EtherAVB device node

 Documentation/devicetree/bindings/arm/shmobile.txt |    2 +
 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |    1 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |    1 +
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |    1 +
 .../devicetree/bindings/net/renesas,ravb.txt       |    1 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    1 +
 .../bindings/power/renesas,rcar-sysc.txt           |    1 +
 .../devicetree/bindings/reset/renesas,rst.txt      |    1 +
 .../bindings/serial/renesas,sci-serial.txt         |    2 +
 arch/arm64/Kconfig.platforms                       |    6 +
 arch/arm64/boot/dts/renesas/Makefile               |    1 +
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |   30 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  787 +++++
 drivers/clk/renesas/Kconfig                        |    5 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |  333 +++
 drivers/clk/renesas/renesas-cpg-mssr.c             |    6 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/gpio/gpio-rcar.c                           |    4 +
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 3134 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |    1 +
 drivers/soc/renesas/Kconfig                        |    9 +-
 drivers/soc/renesas/Makefile                       |    1 +
 drivers/soc/renesas/r8a77965-sysc.c                |   37 +
 drivers/soc/renesas/rcar-rst.c                     |    1 +
 drivers/soc/renesas/rcar-sysc.c                    |    3 +
 drivers/soc/renesas/rcar-sysc.h                    |    1 +
 drivers/soc/renesas/renesas-soc.c                  |    8 +
 include/dt-bindings/clock/r8a77965-cpg-mssr.h      |   62 +
 include/dt-bindings/power/r8a77965-sysc.h          |   31 +
 33 files changed, 4483 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965.dtsi
 create mode 100644 drivers/clk/renesas/r8a77965-cpg-mssr.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77965.c
 create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a77965-sysc.h

--
2.7.4
