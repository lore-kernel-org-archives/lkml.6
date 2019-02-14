Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BC6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0BE222DE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550160038;
	bh=2AUvdhlep5pIsQDeoi6xxocnEQV775Chwqp0BqU8YOw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oXYPKk5xyetBgHpVAojf6fS+YRrOhgzlky8NitVYnaxXdKMHNBXW8tiSaebBIUOtg
	 crcWfMdun9NENNtPHRDHhpxSNGM6glr3zaZRdAQYOvFIPTmtFm9xnmUhNrjhNEFrGH
	 YnbsbsGyaTpWp0AvYmG5xzp9SOxe6B2JDDBsNCvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407758AbfBNQAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:00:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57476 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407618AbfBNQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GUc2/LC2t9xjAGfdm0T5caJI2Xk4i+AzzSVWBMUFoDA=; b=PoWyDBtdOsPk
        X9bQYRFoU95Gf7zR2vMtIGL5mRlEhb6w3vcS7j71kQoPxft+ZB/TuohxjET9VdRfFpA5OBYLFQKkZ
        KzKCdiMPQCyKp7MU4zfsOeKB2XZn0XKc4R4JyPntgQd3N1Xxxj1/6tBFGNZFkfZPxR00e3kl0maLd
        6/1J4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guJR4-0005dZ-0T; Thu, 14 Feb 2019 16:00:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 65B8E1126F78; Thu, 14 Feb 2019 16:00:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Angus Ainslie <angus@akkea.ca>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "devicetree: bindings: bd718x7: document HW state related ROHM specific properties" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190214160025.65B8E1126F78@debutante.sirena.org.uk>
Date:   Thu, 14 Feb 2019 16:00:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   devicetree: bindings: bd718x7: document HW state related ROHM specific properties

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

From f43d1b388f9be4aa47ed42c33659243a675c5c76 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Thu, 14 Feb 2019 11:34:50 +0200
Subject: [PATCH] devicetree: bindings: bd718x7: document HW state related ROHM
 specific properties

Add ROHM BD71837 / BD71847 specific device tree bindings for
controlling the PMIC shutdown/reset states and voltages for
different HW states. The PMIC was designed to be used with NXP
i.MX8 SoC and it supports SNVS low power state which seems to
be typical for NXP i.MX SoCs. However, when SNVS is used we must
not allow SW to control enabling/disabling those regulators which
are crucial for system to boot as there is a HW limitation which
causes SW controlled regulators to be kept shut down after SNVS
reset.

Allow setting the SNVS to be used as reset target state and allow
marking those regulators which are critical for boot.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/mfd/rohm,bd71837-pmic.txt        | 17 +++++++++
 .../regulator/rohm,bd71837-regulator.txt      | 38 +++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
index a4b056761eaa..d5f68ac78d15 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -23,6 +23,20 @@ Required properties:
 
 Optional properties:
 - clock-output-names	: Should contain name for output clock.
+- rohm,reset-snvs-powered : Transfer BD718x7 to SNVS state at reset.
+
+The BD718x7 supports two different HW states as reset target states. States
+are called as SNVS and READY. At READY state all the PMIC power outputs go
+down and OTP is reload. At the SNVS state all other logic and external
+devices apart from the SNVS power domain are shut off. Please refer to NXP
+i.MX8 documentation for further information regarding SNVS state. When a
+reset is done via SNVS state the PMIC OTP data is not reload. This causes
+power outputs that have been under SW control to stay down when reset has
+switched power state to SNVS. If reset is done via READY state the power
+outputs will be returned to HW control by OTP loading. Thus the reset
+target state is set to READY by default. If SNVS state is used the boot
+crucial regulators must have the regulator-always-on and regulator-boot-on
+properties set in regulator node.
 
 Example:
 
@@ -43,6 +57,7 @@ Example:
 		#clock-cells = <0>;
 		clocks = <&osc 0>;
 		clock-output-names = "bd71837-32k-out";
+		rohm,reset-snvs-powered;
 
 		regulators {
 			buck1: BUCK1 {
@@ -50,8 +65,10 @@ Example:
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
+				regulator-always-on;
 				regulator-ramp-delay = <1250>;
 			};
+			// [...]
 		};
 	};
 
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
index 4b98ca26e61a..cbce62c22b60 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -27,8 +27,38 @@ BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
 LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
 
 Optional properties:
+- rohm,dvs-run-voltage		: PMIC default "RUN" state voltage in uV.
+				  See below table for bucks which support this.
+- rohm,dvs-idle-voltage		: PMIC default "IDLE" state voltage in uV.
+				  See below table for bucks which support this.
+- rohm,dvs-suspend-voltage	: PMIC default "SUSPEND" state voltage in uV.
+				  See below table for bucks which support this.
 - Any optional property defined in bindings/regulator/regulator.txt
 
+Supported default DVS states:
+
+BD71837:
+buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
+-----------------------------------------------------------------------------
+1	| supported		| supported		| supported
+----------------------------------------------------------------------------
+2	| supported		| supported		| not supported
+----------------------------------------------------------------------------
+3	| supported		| not supported		| not supported
+----------------------------------------------------------------------------
+4	| supported		| not supported		| not supported
+----------------------------------------------------------------------------
+rest	| not supported		| not supported		| not supported
+
+BD71847:
+buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
+-----------------------------------------------------------------------------
+1	| supported		| supported		| supported
+----------------------------------------------------------------------------
+2	| supported		| supported		| not supported
+----------------------------------------------------------------------------
+rest	| not supported		| not supported		| not supported
+
 Example:
 regulators {
 	buck1: BUCK1 {
@@ -36,7 +66,11 @@ regulators {
 		regulator-min-microvolt = <700000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-boot-on;
+		regulator-always-on;
 		regulator-ramp-delay = <1250>;
+		rohm,dvs-run-voltage = <900000>;
+		rohm,dvs-idle-voltage = <850000>;
+		rohm,dvs-suspend-voltage = <800000>;
 	};
 	buck2: BUCK2 {
 		regulator-name = "buck2";
@@ -45,18 +79,22 @@ regulators {
 		regulator-boot-on;
 		regulator-always-on;
 		regulator-ramp-delay = <1250>;
+		rohm,dvs-run-voltage = <1000000>;
+		rohm,dvs-idle-voltage = <900000>;
 	};
 	buck3: BUCK3 {
 		regulator-name = "buck3";
 		regulator-min-microvolt = <700000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-boot-on;
+		rohm,dvs-run-voltage = <1000000>;
 	};
 	buck4: BUCK4 {
 		regulator-name = "buck4";
 		regulator-min-microvolt = <700000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-boot-on;
+		rohm,dvs-run-voltage = <1000000>;
 	};
 	buck5: BUCK5 {
 		regulator-name = "buck5";
-- 
2.20.1

