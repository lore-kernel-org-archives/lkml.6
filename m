Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeCFMQy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:16:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60307 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753024AbeCFMQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:16:53 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v5 0/5] MIPS: add support for Microsemi MIPS SoCs
Date: Tue,  6 Mar 2018 13:16:02 +0100
Message-Id: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds initial support for the Microsemi MIPS SoCs. It
is currently focusing on the Microsemi Ocelot (VSC7513, VSC7514).

Changes in v5:
 - reworked the DT to remove ocelot_measure_hpt_freq()
 - fixed the memory node (memory@0)
 - fixed indentation
 - board-ocelot.config:
    o require CONFIG_CPU_MIPS32_R2
    o removed CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER
    o removed CONFIG_SQUASHFS because generic_defconfig has
      # CONFIG_MISC_FILESYSTEMS is not set
 - removed DMA_NONCOHERENT from MSCC_OCELOT

Alexandre Belloni (5):
  dt-bindings: mips: Add bindings for Microsemi SoCs
  MIPS: mscc: add ocelot dtsi
  MIPS: mscc: add ocelot PCB123 device tree
  MIPS: generic: Add support for Microsemi Ocelot
  MAINTAINERS: Add entry for Microsemi MIPS SoCs

 Documentation/devicetree/bindings/mips/mscc.txt |  43 +++++++++
 MAINTAINERS                                     |   9 ++
 arch/mips/Makefile                              |   4 +
 arch/mips/boot/dts/Makefile                     |   1 +
 arch/mips/boot/dts/mscc/Makefile                |   3 +
 arch/mips/boot/dts/mscc/ocelot.dtsi             | 117 ++++++++++++++++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts       |  27 ++++++
 arch/mips/configs/generic/board-ocelot.config   |  36 ++++++++
 arch/mips/generic/Kconfig                       |  16 ++++
 arch/mips/generic/Makefile                      |   1 +
 arch/mips/generic/board-ocelot.c                |  67 ++++++++++++++
 11 files changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt
 create mode 100644 arch/mips/boot/dts/mscc/Makefile
 create mode 100644 arch/mips/boot/dts/mscc/ocelot.dtsi
 create mode 100644 arch/mips/boot/dts/mscc/ocelot_pcb123.dts
 create mode 100644 arch/mips/configs/generic/board-ocelot.config
 create mode 100644 arch/mips/generic/board-ocelot.c

-- 
2.16.2
