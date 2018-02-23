Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933361AbeBWUDL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:03:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38248 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754917AbeBWUDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:07 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv5 1/5] dt-bindings: mfd: motorola-cpcap: document audio-codec
Date: Fri, 23 Feb 2018 21:02:50 +0100
Message-Id: <20180223200254.25685-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DT binding for the audio-codec sub-module found
inside the Motorola CPCAP PMIC.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../devicetree/bindings/mfd/motorola-cpcap.txt     | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt b/Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
index 15bc885f9df4..82c3a7140660 100644
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
+- Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
+- Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
+- Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
+- Documentation/devicetree/bindings/phy/phy-cpcap-usb.txt
+- Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
+- Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
+- Documentation/devicetree/bindings/leds/leds-cpcap.txt
+- Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
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
2.16.1
