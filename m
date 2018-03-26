Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCZJw1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:52:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34296 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCZJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:52:24 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v6 2/5] dt-bindings: pwm-backlight: add PWM delay proprieties.
Date: Mon, 26 Mar 2018 11:52:10 +0200
Message-Id: <20180326095213.18362-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326095213.18362-1-enric.balletbo@collabora.com>
References: <20180326095213.18362-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware needs a delay between setting an initial (non-zero) PWM and
enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
this delay in milli seconds. Hardware also needs a delay between disabing
the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
is this delay in milli seconds.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
Based on the original Huang Lin <hl@rock-chips.com> work.
Changes since v5:
 - Add Acked-by: Thierry Reding <thierry.reding@gmail.com>
 - CC DT mainling list (for some reason dropped at some point, my
   fault)
Changes since v4:
 - Rebase on top of mainline.
Changes since v3:
 - Replace us for ms.
 - Add Acked-by: Pavel Machek <pavel@ucw.cz>
Changes since v2:
 - Use separate properties (Rob Herring)
Changes since v1:
 - As suggested by Daniel Thompson
   - Do not assume power-on delay and power-off delay will be the same
---
 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 764db86d441a..310810906613 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -17,6 +17,10 @@ Optional properties:
                "pwms" property (see PWM binding[0])
   - enable-gpios: contains a single GPIO specifier for the GPIO which enables
                   and disables the backlight (see GPIO binding[1])
+  - post-pwm-on-delay-ms: Delay in ms between setting an initial (non-zero) PWM
+                          and enabling the backlight using GPIO.
+  - pwm-off-delay-ms: Delay in ms between disabling the backlight using GPIO
+                      and setting PWM value to 0.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
@@ -32,4 +36,6 @@ Example:
 
 		power-supply = <&vdd_bl_reg>;
 		enable-gpios = <&gpio 58 0>;
+		post-pwm-on-delay-ms = <10>;
+		pwm-off-delay-ms = <10>;
 	};
-- 
2.16.2
