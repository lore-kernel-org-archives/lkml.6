Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeEHFlA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:41:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42694 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbeEHFkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:40:55 -0400
X-Google-Smtp-Source: AB8JxZoamYn2z6VG0r11ngU5f81AKAGKjqJCrTkOEPYct9TgNYwR4ztlt0PlAMA+w3U3SJZ/kQ24fQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: xiaotong.lu@spreadtrum.com, baolin.wang@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: leds: Add SC27xx breathing light controller documentation
Date: Tue,  8 May 2018 13:39:44 +0800
Message-Id: <f393ca5a99059e7086307b99fc435777fe09018b.1525757122.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27xx series
breathing light controller, which supports 3 outputs: red LED, green
LED and blue LED.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Change the compatible string to be one explicit SoC name.
 - Change the child node name.
 - Change to be upper case for the first character.
---
 .../devicetree/bindings/leds/leds-sc27xx-bltc.txt  |   41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
new file mode 100644
index 0000000..b3de7fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt
@@ -0,0 +1,41 @@
+LEDs connected to Spreadtrum SC27XX PMIC breathing light controller
+
+The SC27xx breathing light controller supports to 3 outputs:
+red LED, green LED and blue LED. Each LED can work at normal
+PWM mode or breath light mode.
+
+Required properties:
+- compatible: Should be "sprd,sc2731-bltc".
+- #address-cells: Must be 1.
+- #size-cells: Must be 0.
+- reg: Specify controller address.
+
+Required child properties:
+- reg: Number of LED line (could be from 0 to 2).
+
+Optional child properties:
+- label: See Documentation/devicetree/bindings/leds/common.txt.
+
+Examples:
+
+led-controller@200 {
+	compatible = "sprd,sc2731-bltc";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x200>;
+
+	led@0 {
+		label = "red";
+		reg = <0x0>;
+	};
+
+	led@1 {
+		label = "green";
+		reg = <0x1>;
+	};
+
+	led@2 {
+		label = "blue";
+		reg = <0x2>;
+	};
+};
-- 
1.7.9.5
