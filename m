Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCWULk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:11:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34883 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbeCWULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:11:37 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH net-next 0/8] Microsemi Ocelot switch support
Date: Fri, 23 Mar 2018 21:11:09 +0100
Message-Id: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds initial support for the Microsemi Ethernet switch
present on Ocelot SoCs.

This only has bridging (and STP) support for now and it uses the
switchdev framework.
Coming features are VLAN filtering, link aggregation, IGMP snooping.

The switch can also be connected to an external CPU using PCIe. I have a
PoC for that but it is still a bit clunky.

Also, support for integration on other SoCs will be submitted.

The ocelot dts changes are here for reference and should probably go
through the MIPS tree once the bindings are accepted.

Cc: James Hogan <jhogan@kernel.org>

Alexandre Belloni (8):
  net: phy: Add initial support for Microsemi Ocelot internal PHYs.
  dt-bindings: net: add DT bindings for Microsemi MIIM
  net: mscc: Add MDIO driver
  dt-bindings: net: add DT bindings for Microsemi Ocelot Switch
  net: mscc: Add initial Ocelot switch support
  MIPS: mscc: Add switch to ocelot
  MIPS: mscc: connect phys to ports on ocelot_pcb123
  MAINTAINERS: Add entry for Microsemi Ethernet switches

 .../devicetree/bindings/net/mscc-miim.txt          |   25 +
 .../devicetree/bindings/net/mscc-ocelot.txt        |   62 +
 MAINTAINERS                                        |    6 +
 arch/mips/boot/dts/mscc/ocelot.dtsi                |   84 ++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts          |   16 +
 drivers/net/ethernet/Kconfig                       |    1 +
 drivers/net/ethernet/Makefile                      |    1 +
 drivers/net/ethernet/mscc/Kconfig                  |   36 +
 drivers/net/ethernet/mscc/Makefile                 |    6 +
 drivers/net/ethernet/mscc/mscc_miim.c              |  210 +++
 drivers/net/ethernet/mscc/ocelot.c                 | 1346 ++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h                 |  554 ++++++++
 drivers/net/ethernet/mscc/ocelot_ana.h             |  625 +++++++++
 drivers/net/ethernet/mscc/ocelot_board.c           |  329 +++++
 drivers/net/ethernet/mscc/ocelot_dev.h             |  275 ++++
 drivers/net/ethernet/mscc/ocelot_dev_gmii.h        |  154 +++
 drivers/net/ethernet/mscc/ocelot_hsio.h            |  785 ++++++++++++
 drivers/net/ethernet/mscc/ocelot_io.c              |  116 ++
 drivers/net/ethernet/mscc/ocelot_qs.h              |   78 ++
 drivers/net/ethernet/mscc/ocelot_qsys.h            |  270 ++++
 drivers/net/ethernet/mscc/ocelot_regs.c            |  399 ++++++
 drivers/net/ethernet/mscc/ocelot_rew.h             |   81 ++
 drivers/net/ethernet/mscc/ocelot_sys.h             |  140 ++
 drivers/net/phy/mscc.c                             |   15 +
 24 files changed, 5614 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-miim.txt
 create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
 create mode 100644 drivers/net/ethernet/mscc/Kconfig
 create mode 100644 drivers/net/ethernet/mscc/Makefile
 create mode 100644 drivers/net/ethernet/mscc/mscc_miim.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_ana.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_board.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_dev.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_dev_gmii.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_hsio.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_io.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_qs.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_qsys.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_regs.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_rew.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_sys.h

-- 
2.16.2
