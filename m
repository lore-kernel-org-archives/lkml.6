Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeCISEv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:04:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40798 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932276AbeCISEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:04:48 -0500
From: Mark Brown <broonie@kernel.org>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: 88pg86x: add DT bindings document" to the regulator tree
In-Reply-To: <20180308225303.329-1-amonakov@ispras.ru>
Message-Id: <E1euMNo-00028i-DH@debutante>
Date: Fri, 09 Mar 2018 18:04:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: 88pg86x: add DT bindings document

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

>From 2a254de29e995ea58d73f75b69016cf913a5447d Mon Sep 17 00:00:00 2001
From: Alexander Monakov <amonakov@ispras.ru>
Date: Fri, 9 Mar 2018 01:53:02 +0300
Subject: [PATCH] regulator: 88pg86x: add DT bindings document

The only device-specific node names are "buck1" and "buck2" for the two
regulators present on the device. Sleep mode GPIO and per-regulator GPIO
enable pins are not exposed (the driver does not support them either).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/88pg86x.txt      | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/88pg86x.txt

diff --git a/Documentation/devicetree/bindings/regulator/88pg86x.txt b/Documentation/devicetree/bindings/regulator/88pg86x.txt
new file mode 100644
index 000000000000..13b7f49a2ea8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/88pg86x.txt
@@ -0,0 +1,22 @@
+Marvell 88PG867/88PG868 voltage regulators
+
+Required properties:
+- compatible: one of "marvell,88pg867", "marvell,88pg868";
+- reg: I2C slave address.
+
+Optional subnodes for regulators: "buck1", "buck2", using common regulator
+bindings given in <Documentation/devicetree/bindings/regulator/regulator.txt>.
+
+Example:
+
+	pg868@19 {
+		compatible = "marvell,88pg868";
+		reg = <0x19>;
+
+		vcpu: buck1 {
+			regulator-boot-on;
+			regulator-always-on;
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1350000>;
+		};
+	};
-- 
2.16.2
