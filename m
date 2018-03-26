Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCZJw2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:52:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34336 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeCZJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:52:26 -0400
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
Subject: [PATCH v6 4/5] ARM: dts: rockchip: set PWM delay backlight settings for Veyron.
Date: Mon, 26 Mar 2018 11:52:12 +0200
Message-Id: <20180326095213.18362-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326095213.18362-1-enric.balletbo@collabora.com>
References: <20180326095213.18362-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For veyron the binding should provide both PWM timings, the delay between
you enable the PWM and set the enable signal, and the delay between you
disable the PWM signal and clear the enable signal. Update the binding
accordingly, in this case the panels connected to the veyron boards have
a symmetric power sequence, hence the same value is used.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
Changes since v5:
 - None.
Changes since v4:
 - Rebased on top of mainline.
Changes since v3:
 - Use new -ms names for proprieties.
Changes since v2:
 - Use new names for proprieties.
Changes since v1:
 - Add this new patch to fix current binding on veyron.
---
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index d752a315f884..5a8c7f3abb38 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -96,7 +96,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 0>;
-		pwm-delay-us = <10000>;
+		post-pwm-on-delay-ms = <10>;
+		pwm-off-delay-ms = <10>;
 	};
 
 	gpio-charger {
-- 
2.16.2
