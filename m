Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeDWSF0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:05:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58718 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932506AbeDWSFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:05:15 -0400
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: mfd: bd9571mwv: Document DDR Backup Mode properties" to the regulator tree
In-Reply-To: <1524057484-25350-2-git-send-email-geert+renesas@glider.be>
Message-Id: <E1fAfpv-0004FS-DO@debutante>
Date: Mon, 23 Apr 2018 19:05:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: mfd: bd9571mwv: Document DDR Backup Mode properties

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c85964de544cae98c3d8d29c936b6d13258e4a10 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Apr 2018 15:18:01 +0200
Subject: [PATCH] dt-bindings: mfd: bd9571mwv: Document DDR Backup Mode
 properties

Document the new optional properties related to DDR Backup Mode and
toggle/momentary power switches.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/mfd/bd9571mwv.txt     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
index 9ab216a851d5..25d1f697eb25 100644
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
2.17.0
