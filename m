Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbeDRNSO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:18:14 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:56398 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbeDRNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:18:09 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/4] dt-bindings: mfd: bd9571mwv: Document DDR Backup Mode properties
Date: Wed, 18 Apr 2018 15:18:01 +0200
Message-Id: <1524057484-25350-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
References: <1524057484-25350-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new optional properties related to DDR Backup Mode and
toggle/momentary power switches.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

v3:
  - Add Reviewed-by, Acked-for-MFD-by (for Lee's own reference),
  - Use a hex value for the bit mask,

v2:
  - Improve property description,
  - Add properties for power switch type.
---
 Documentation/devicetree/bindings/mfd/bd9571mwv.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
index 9ab216a851d5619b..25d1f697eb25c67d 100644
--- a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
+++ b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
@@ -25,6 +25,25 @@ Required properties:
 			    Each child node is defined using the standard
 			    binding for regulators.
 
+Optional properties:
+  - rohm,ddr-backup-power : Value to use for DDR-Backup Power (default 0).
+			    This is a bitmask that specifies which DDR power
+			    rails need to be kept powered when backup mode is
+			    entered, for system suspend:
+			      - bit 0: DDR0
+			      - bit 1: DDR1
+			      - bit 2: DDR0C
+			      - bit 3: DDR1C
+			    These bits match the KEEPON_DDR* bits in the
+			    documentation for the "BKUP Mode Cnt" register.
+  - rohm,rstbmode-level: The RSTB signal is configured for level mode, to
+			 accommodate a toggle power switch (the RSTBMODE pin is
+			 strapped low).
+  - rohm,rstbmode-pulse: The RSTB signal is configured for pulse mode, to
+			 accommodate a momentary power switch (the RSTBMODE pin
+			 is strapped high).
+			 The two properties above are mutually exclusive.
+
 Example:
 
 	pmic: pmic@30 {
@@ -36,6 +55,8 @@ Example:
 		#interrupt-cells = <2>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		rohm,ddr-backup-power = <0xf>;
+		rohm,rstbmode-pulse;
 
 		regulators {
 			dvfs: dvfs {
-- 
2.7.4
