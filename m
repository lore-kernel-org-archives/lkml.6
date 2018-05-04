Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeEDKKF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:10:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42529 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbeEDKJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:09:37 -0400
X-Google-Smtp-Source: AB8JxZoyxo/KJhqbIP5XqugzQ9K3qMRzGRxgBouZrtaw7QxYmJQeZi0cce4RnNdx/LzZqPWH2M2/Jw==
From: Baolin Wang <baolin.wang@linaro.org>
To: jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: xiaotong.lu@spreadtrum.com, baolin.wang@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: leds: Add SC27xx breathing light controller documentation
Date: Fri,  4 May 2018 18:08:35 +0800
Message-Id: <099f4075ec489e425b5f1e7668a078c05f0d8509.1525427961.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27xx series
breathing light controller, which supports 3 outputs: red LED, green
LED and blue LED.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
new file mode 100644
index 0000000..d4e267d
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
@@ -0,0 +1,39 @@
+LEDs connected to Spreadtrum SC27XX PMIC breathing light controller
+
+The SC27xx breathing light controller supports to 3 outputs:
+red LED, green LED and blue LED. Each LED can work at normal
+PWM mode or breath light mode.
+
+Required properties:
+- compatible: should be "sprd,sc27xx-bltc".
+- #address-cells: must be 1.
+- #size-cells: must be 0.
+- reg: specify controller address.
+
+LED sub-node properties:
+- reg: number of LED line (could be from 0 to 2).
+- label: (optional) name of LED.
+
+Examples:
+
+led-controller@200 {
+	compatible = "sprd,sc27xx-bltc";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x200>;
+
+	red@0 {
+		label = "red";
+		reg = <0x0>;
+	};
+
+	green@1 {
+		label = "green";
+		reg = <0x1>;
+	};
+
+	blue@2 {
+		label = "blue";
+		reg = <0x2>;
+	};
+};
-- 
1.7.9.5
