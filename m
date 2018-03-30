Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeC3M6e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:58:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeC3M6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:58:32 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv6 1/2] dt-bindings: mfd: motorola-cpcap: document audio-codec
Date: Fri, 30 Mar 2018 14:58:23 +0200
Message-Id: <20180330125824.21418-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
References: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT binding for the audio-codec sub-module found
inside the Motorola CPCAP PMIC.

Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../devicetree/bindings/mfd/motorola-cpcap.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
index 15bc885f9df4..c639705a98ef 100644
--- a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
+++ b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
@@ -12,6 +12,30 @@ Required properties:
 - spi-max-frequency	: Typically set to 3000000
 - spi-cs-high		: SPI chip select direction
 
+Optional subnodes:
+
+The sub-functions of CPCAP get their own node with their own compatible values,
+which are described in the following files:
+
+- ../power/supply/cpcap-battery.txt
+- ../power/supply/cpcap-charger.txt
+- ../regulator/cpcap-regulator.txt
+- ../phy/phy-cpcap-usb.txt
+- ../input/cpcap-pwrbutton.txt
+- ../rtc/cpcap-rtc.txt
+- ../leds/leds-cpcap.txt
+- ../iio/adc/cpcap-adc.txt
+
+The only exception is the audio codec. Instead of a compatible value its
+node must be named "audio-codec".
+
+Required properties for the audio-codec subnode:
+
+- #sound-dai-cells = <1>;
+
+The audio-codec provides two DAIs. The first one is connected to the
+Stereo HiFi DAC and the second one is connected to the Voice DAC.
+
 Example:
 
 &mcspi1 {
@@ -26,6 +50,24 @@ Example:
 		#size-cells = <0>;
 		spi-max-frequency = <3000000>;
 		spi-cs-high;
+
+		audio-codec {
+			#sound-dai-cells = <1>;
+
+			/* HiFi */
+			port@0 {
+				endpoint {
+					remote-endpoint = <&cpu_dai1>;
+				};
+			};
+
+			/* Voice */
+			port@1 {
+				endpoint {
+					remote-endpoint = <&cpu_dai2>;
+				};
+			};
+		};
 	};
 };
 
-- 
2.16.2
