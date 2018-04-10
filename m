Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeDJIfZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:35:25 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:60244 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751966AbeDJIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:35:24 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517842800";
   d="scan'208";a="277754316"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, buserror+upstream@gmail.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 0/8] arm: Base support for Renesas RZN1D-DB Board
Date: Tue, 10 Apr 2018 09:30:00 +0100
Message-Id: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the plain basic support for booting a bare
kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
minimum as a 'base', further patches that will add the
rest of the support, pinctrl, clock architecture and quite
a few others.

Thanks for the comments on the previous versions!

v4:
 + Fixes for suggestions by Simon Horman
 + Fixes for suggestions by Jacopo Mondi
 + Fixes for suggestions by Geert Uytterhoeven
 + Renamed the r9a06g0xx.dtsi file, given up on trying to get a family
   common file in, so dropped potential RZ/N1S support and now only
   focus on RZ/N1D for this patchset.
 + Added 'always-on' to the architected timer node, because it is.
 + Added ARCH_R9A06G032, to match others patterns like RCAR
 + Sorted the .dts files, added empty lines as required.
 + Fixed patch prefixes to match git-log for bindings&dts
 + Merged board .dts & Makefile changes together
 + Rebased on next-20180410
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
  arm: shmobile: Add the RZ/N1 arch to the shmobile Kconfig
  arm: shmobile: Add the RZ/N1D (R9A06G032) to the shmobile Kconfig
  dt-bindings: mfd: renesas,rzn1-sysctrl: document RZ/N1 sysctrl node
  dt-bindings: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
  dt-bindings: arm: Document the RZN1D-DB board
  ARM: dts: Renesas RZ/N1 SoC base device tree file
  ARM: dts: Renesas RZN1D-DB Board base file
  reset: Renesas RZ/N1 reboot driver

 Documentation/devicetree/bindings/arm/shmobile.txt |   5 +-
 .../bindings/mfd/renesas,rzn1-sysctrl.txt          |  23 +++++
 .../bindings/power/renesas,rzn1-reboot.txt         |  23 +++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts        |  29 ++++++
 arch/arm/boot/dts/r9a06g032.dtsi                   |  94 ++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   9 ++
 drivers/power/reset/Kconfig                        |   7 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/rzn1-reboot.c                  | 105 +++++++++++++++++++++
 10 files changed, 296 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
 create mode 100644 arch/arm/boot/dts/r9a06g032.dtsi
 create mode 100644 drivers/power/reset/rzn1-reboot.c

-- 
2.7.4
