Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeFEGCq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:02:46 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:15466 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeFEGC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:02:27 -0400
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>, Nishanth Menon <nm@ti.com>
Subject: [RFC PATCH 0/6] arm64: Initial support Texas Instrument's AM654 Platform
Date: Tue, 5 Jun 2018 01:01:19 -0500
Message-ID: <20180605060125.9518-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series enables support for newest addition in TI's SoC
portfolio - AM654 SoC.

The series is an RFC based off next-20180604 and will post formally once
v4.18-rc1 is available.

The series (part 1 of 4) is available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/next-20180604/k3-1-am6-base

Full Boot log is available here: https://pastebin.ubuntu.com/p/vWCzMKtBCW/

The AM654 SoC is a lead device of the K3 Multicore SoC architecture
platform, targeted for broad market and industrial control with aim to
meet the complex processing needs of modern embedded products.

The Linux development follows closely the 66AK2G SoC model in aarch64.

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Lokesh Vutla (1):
  serial: 8250_omap: Make 8250_omap driver driver depend on ARCH_K3

Nishanth Menon (5):
  Documentation: arm: ti: Add bindings for AM654 SoC
  arm64: Add support for TI's K3 Multicore SoC architecture
  serial: 8250_omap: Add support for AM654 UART controller
  arm64: dts: ti: Add Support for AM654 SoC
  arm64: dts: ti: Add support for AM654 EVM base board

 Documentation/devicetree/bindings/arm/ti/k3.txt    |  33 +++++
 .../devicetree/bindings/serial/omap_serial.txt     |   1 +
 MAINTAINERS                                        |   9 ++
 arch/arm64/Kconfig.platforms                       |   7 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/ti/Makefile                    |   9 ++
 arch/arm64/boot/dts/ti/k3-am6.dtsi                 | 144 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |  40 ++++++
 arch/arm64/boot/dts/ti/k3-am654.dtsi               | 117 +++++++++++++++++
 drivers/soc/ti/Kconfig                             |  14 ++
 drivers/tty/serial/8250/8250_omap.c                |   1 +
 drivers/tty/serial/8250/Kconfig                    |   2 +-
 12 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt
 create mode 100644 arch/arm64/boot/dts/ti/Makefile
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi

-- 
2.15.1
