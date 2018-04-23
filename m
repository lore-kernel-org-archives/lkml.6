Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeDWSFt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:05:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59002 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbeDWSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:05:24 -0400
From: Mark Brown <broonie@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: add drivevbus support for axp803" to the regulator tree
In-Reply-To: <1513011400-4120-1-git-send-email-jagan@amarulasolutions.com>
Message-Id: <E1fAfpz-0004Gb-3w@debutante>
Date: Mon, 23 Apr 2018 19:05:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: add drivevbus support for axp803

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

>From 1f5d6462b5856ddd44d4500ac80b7862faff351b Mon Sep 17 00:00:00 2001
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 23 Apr 2018 12:02:37 +0530
Subject: [PATCH] regulator: axp20x: add drivevbus support for axp803

Like axp221, axp223, axp813 the axp803 is also supporting external
regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.

Add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
 drivers/regulator/axp20x-regulator.c             | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 9455503b0299..d1762f3b30af 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -43,7 +43,7 @@ Optional properties:
 			  regulator to drive the OTG VBus, rather then
 			  as an input pin which signals whether the
 			  board is driving OTG VBus or not.
-			  (axp221 / axp223 / axp813 only)
+			  (axp221 / axp223 / axp803/ axp813 only)
 
 - x-powers,master-mode: Boolean (axp806 only). Set this when the PMIC is
 			wired for master mode. The default is slave mode.
@@ -132,6 +132,7 @@ FLDO2		: LDO		: fldoin-supply		: shared supply
 LDO_IO0		: LDO		: ips-supply		: GPIO 0
 LDO_IO1		: LDO		: ips-supply		: GPIO 1
 RTC_LDO		: LDO		: ips-supply		: always on
+DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
 
 AXP806 regulators, type, and corresponding input supply names:
 
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 181622b2813d..91b8ff8bac15 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -721,6 +721,8 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	case AXP803_ID:
 		regulators = axp803_regulators;
 		nregulators = AXP803_REG_ID_MAX;
+		drivevbus = of_property_read_bool(pdev->dev.parent->of_node,
+						  "x-powers,drive-vbus-en");
 		break;
 	case AXP806_ID:
 		regulators = axp806_regulators;
-- 
2.17.0
