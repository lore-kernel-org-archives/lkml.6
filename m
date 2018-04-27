Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758686AbeD0QFc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:05:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34900 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758654AbeD0QF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:05:28 -0400
X-Google-Smtp-Source: AB8JxZpPjrjXVhLa7Deajq8l7lAFU3YGLQ5aG+/fG2JTsdkH/i4khqbNmulNWuiVCgFHP7L64ORSoQ==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode binding
Date: Fri, 27 Apr 2018 18:03:02 +0200
Message-Id: <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree bindings documentation for
battery charging controller as the subnode of MAX8998 PMIC.
It's based on current behavior of driver.

Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 Documentation/devicetree/bindings/mfd/max8998.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max8998.txt b/Documentation/devicetree/bindings/mfd/max8998.txt
index 23a3650ff2a2..f95610afb57f 100644
--- a/Documentation/devicetree/bindings/mfd/max8998.txt
+++ b/Documentation/devicetree/bindings/mfd/max8998.txt
@@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
 - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
   for buck2 regulator that can be selected using dvs gpio.
 
+Charger: Configuration for battery charging controller should be added
+inside a child node named 'charger'.
+  Required properties:
+  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
+    remain value set from bootloader or default value will be used.
+    Valid values: 0, 10 - 45
+
+  - max8998,charge-restart: Setup "Charge Restart Level". If value equals 0,
+    remain value set from bootloader or default value will be used.
+    Valid values: -1, 0, 100, 150, 200
+
+  - max8998,charge-timeout: Setup "Charge Full Timeout". If value equals 0,
+    remain value set from bootloader or default value will be used.
+    Valid values: -1, 0, 5, 6, 7
+
 Regulators: All the regulators of MAX8998 to be instantiated shall be
 listed in a child node named 'regulators'. Each regulator is represented
 by a child node of the 'regulators' node.
@@ -99,6 +114,13 @@ Example:
 		max8998,pmic-buck2-dvs-gpio = <&gpx0 0 3 0 0>; /* SET3 */
 		max8998,pmic-buck2-dvs-voltage = <1350000>, <1300000>;
 
+		/* Charger configuration */
+		charger {
+			max8998,charge-eoc = <0>;
+			max8998,charge-restart = <(-1)>;
+			max8998,charge-timeout = <7>;
+		};
+
 		/* Regulators to instantiate */
 		regulators {
 			ldo2_reg: LDO2 {
-- 
2.7.4
