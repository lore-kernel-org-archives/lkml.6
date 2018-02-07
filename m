Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754467AbeBGOOr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:14:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41514 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754263AbeBGONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:13:49 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: pwm-backlight: add a num-interpolation-steps property.
Date: Wed,  7 Feb 2018 15:13:35 +0100
Message-Id: <20180207141337.22247-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180207141337.22247-1-enric.balletbo@collabora.com>
References: <20180207141337.22247-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The num-interpolated-steps property specifies the number of
interpolated steps between each value of brightness-level table. This is
useful for high resolution PWMs to not have to list out every possible
value in the brightness-level array.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v1:
- Add an example with a small but realistic curve. Suggested by Rob and
  Daniel

 .../bindings/leds/backlight/pwm-backlight.txt         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 310810906613..ce9b5746b774 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -21,6 +21,11 @@ Optional properties:
                           and enabling the backlight using GPIO.
   - pwm-off-delay-ms: Delay in ms between disabling the backlight using GPIO
                       and setting PWM value to 0.
+  - num-interpolated-steps: Number of interpolated steps between each value
+                            of brightness-levels table. This way a high
+                            resolution pwm duty cycle can be used without
+                            having to list out every possible value in the
+                            brightness-level array.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
@@ -39,3 +44,17 @@ Example:
 		post-pwm-on-delay-ms = <10>;
 		pwm-off-delay-ms = <10>;
 	};
+
+Example using num-interpolation-steps:
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 5000000>;
+
+		brightness-levels = <0 2048 4096 8192 16384 65535>;
+		num-interpolated-steps = <2048>;
+		default-brightness-level = <4096>;
+
+		power-supply = <&vdd_bl_reg>;
+		enable-gpios = <&gpio 58 0>;
+	};
-- 
2.15.1
