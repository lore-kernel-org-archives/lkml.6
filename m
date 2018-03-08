Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeCHWx0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:53:26 -0500
Received: from bran.ispras.ru ([83.149.199.196]:10298 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751114AbeCHWxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:53:25 -0500
From: Alexander Monakov <amonakov@ispras.ru>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Monakov <amonakov@ispras.ru>
Subject: [PATCH 1/2] regulator: 88pg86x: add DT bindings document
Date: Fri,  9 Mar 2018 01:53:02 +0300
Message-Id: <20180308225303.329-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only device-specific node names are "buck1" and "buck2" for the two
regulators present on the device. Sleep mode GPIO and per-regulator GPIO
enable pins are not exposed (the driver does not support them either).

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
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
2.11.0
