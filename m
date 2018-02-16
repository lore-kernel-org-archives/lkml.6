Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755859AbeBPRlH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:41:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34444 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162328AbeBPRks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:40:48 -0500
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
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [RESEND PATCH v5 4/5] ARM: dts: rockchip: set PWM delay backlight settings for Veyron.
Date: Fri, 16 Feb 2018 18:40:33 +0100
Message-Id: <20180216174034.15936-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216174034.15936-1-enric.balletbo@collabora.com>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
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
Changes since v4:
 - Rebased on top of mainline.
Changes since v3:
 - Use new -ms names for proprieties.
Changes since v2:
 - Use new names for proprieties.
Changes since v1:
 - Add this new patch to fix current binding on veyron.

 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index be487111d025..b16d570ff029 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -95,7 +95,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 0>;
-		pwm-delay-us = <10000>;
+		post-pwm-on-delay-ms = <10>;
+		pwm-off-delay-ms = <10>;
 	};
 
 	gpio-charger {
-- 
2.15.1
