Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeBTPNC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:13:02 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39855 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeBTPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:13:01 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/19] R-Car M3-N initial support
Date: Tue, 20 Feb 2018 16:12:02 +0100
Message-Id: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, second round for R-Car M3-N SoC and M3-N based Salvator-X board.

I have fixed all comments I have received and re-based on latest Geert's
renesas-drivers-2018-02-13-v4.16-rc1

I have applied requested changes, and updated PFC tables to comply with
last patches applied to r8a7796 that were not part of v4.15 which v1 was
based on.

I have added a per-patch change log as summarizing all little changes here
had not real benefit imho, being them mostly tiny changes specific to each
patch.

As a general note, I have split patches and bindings where requested and split
single patches in multiple ones where opportune (mostly when adding components
to drivers/soc/ and when introducing board and SoC DT files).

Tested serial console output and Ethernet interface.

Thanks
   j

v1 -> v2:
- Rebased on renesas-drivers-2018-02-13-v4.16-rc1
- Split patches when introducing rst, sysc in drivers/soc/
- Split patches when adding device tree file for Salvator-X board and
  r8a77965 SoC.
- Single change logs are reported per-patch

Jacopo Mondi (19):
  clk: renesas: cpg-mssr: Add support for R-Car M3-N
  soc: renesas: rcar-rst: Add support for R-Car M3-N
  soc: renesas: Identify R-Car M3-N
  soc: renesas: rcar-sysc: Add R-Car M3-N support
  pinctrl: sh-pfc: Initial R-Car M3-N support
  dt-bindings: arm: Document R-Car M3-N SoC DT bindings
  ARM64: Add Renesas R-Car M3-N config symbol
  ARM64: dts: Add Renesas R8A77965 SoC support
  ARM64: dts: Add R-Car Salvator-x M3-N support
  dt-bindings: dmaengine: rcar-dmac: document R8A77965 support
  ARM64: dts: r8a77965: Add dmac device nods
  dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
  pinctrl: sh-pfc: r8a77965: Add SCIFs groups/functions
  ARM64: dts: r8a77965: Add SCIF device nodes
  dt-bindings: gpio: Add support for r8a77965
  ARM64: dts: r8a77965: Add GPIO nodes
  dt-bindings: net: ravb: Add support for r8a77965 SoC
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
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |   21 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  782 +++++
 drivers/clk/renesas/Kconfig                        |    5 +
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |  334 +++
 drivers/clk/renesas/renesas-cpg-mssr.c             |    6 +
 drivers/clk/renesas/renesas-cpg-mssr.h             |    1 +
 drivers/pinctrl/sh-pfc/Kconfig                     |    5 +
 drivers/pinctrl/sh-pfc/Makefile                    |    1 +
 drivers/pinctrl/sh-pfc/core.c                      |    6 +
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 3128 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |    1 +
 drivers/soc/renesas/Kconfig                        |    9 +-
 drivers/soc/renesas/Makefile                       |    1 +
 drivers/soc/renesas/r8a77965-sysc.c                |   37 +
 drivers/soc/renesas/rcar-rst.c                     |    1 +
 drivers/soc/renesas/rcar-sysc.c                    |    3 +
 drivers/soc/renesas/rcar-sysc.h                    |    1 +
 drivers/soc/renesas/renesas-soc.c                  |    8 +
 include/dt-bindings/clock/r8a77965-cpg-mssr.h      |   62 +
 include/dt-bindings/power/r8a77965-sysc.h          |   30 +
 32 files changed, 4459 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965.dtsi
 create mode 100644 drivers/clk/renesas/r8a77965-cpg-mssr.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77965.c
 create mode 100644 drivers/soc/renesas/r8a77965-sysc.c
 create mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h
 create mode 100644 include/dt-bindings/power/r8a77965-sysc.h

--
2.7.4
