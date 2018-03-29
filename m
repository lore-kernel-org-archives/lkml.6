Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeC2HvZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:51:25 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:55970 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751086AbeC2HvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:51:23 -0400
X-IronPort-AV: E=Sophos;i="5.48,375,1517842800";
   d="scan'208";a="276602143"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/8] arm: Base support for Renesas RZN1D-DB Board
Date: Thu, 29 Mar 2018 08:46:56 +0100
Message-Id: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the plain basic support for booting a bare
kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
minimum as a 'base', further patches that will add the
rest of the support, pinctrl, clock architecture and quite
a few others.

Thanks for the comments on the previous version!

v3:
 + Fixes for suggestions by Geert Uytterhoeven
 + Removed SoC Specific renesas,r9a06g032-xxx, as it's not needed for now.
 + Kept renesas,rzn1 as a family/generic for this family.
 + Fixed a couple of the commit messages.
 + Added Geert's Reviewed-By where appropriate.
v2: 
 + Fixes for suggestions by Simon Horman
 + Fixes for suggestions by Rob Herring
 + Fixes for suggestions by Geert Uytterhoeven
 + Removed the mach file
 + Added a MFD base for the sysctrl block
 + Added a regmap based sub driver for the reboot handler
 + Renamed the files to match shmobile conventions
 + Adapted the compatible= strings to reflect 'family' vs 'part'
   distinction.
 + Removed the sysctrl.h file entirelly. 
 + Fixed every warnings from the DTC compiler on W=12 mode.
 + Split the device-tree patches from the code.

Michel Pollet (8):
  DT: mfd: renesas,rzn1-sysctrl: document RZ/N1 sysctrl node
  DT: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
  DT: arm: renesas,rzn1: add the RZ/N1 SoC and RZN1D-DB board
  reset: Renesas RZ/N1 reboot driver
  arm: shmobile: Add the RZ/N1 arch to the shmobile Kconfig
  DT: arm: Add Renesas RZ/N1 SoC base device tree file
  DT: arm: Add Renesas RZN1D-DB Board base file
  DT: arm: Add the RZN1D-DB Board to Renesas Makefile target

 Documentation/devicetree/bindings/arm/shmobile.txt |   7 +-
 .../bindings/mfd/renesas,rzn1-sysctrl.txt          |  19 ++++
 .../bindings/power/renesas,rzn1-reboot.txt         |  20 ++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  26 +++++
 arch/arm/boot/dts/r9a06g0xx.dtsi                   |  96 +++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   5 +
 drivers/power/reset/Kconfig                        |   7 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/rzn1-reboot.c                  | 105 +++++++++++++++++++++
 10 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
 create mode 100644 arch/arm/boot/dts/r9a06g0xx.dtsi
 create mode 100644 drivers/power/reset/rzn1-reboot.c

-- 
2.7.4
