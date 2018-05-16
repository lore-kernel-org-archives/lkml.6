Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeEPGji (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:39:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51633 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeEPGjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:39:35 -0400
X-Google-Smtp-Source: AB8JxZosYkiKCPE9IYUk1Ahw1qqEbeEoWZ8YfaRt4JzuNC48UTiRaV5l9xhFpKfV5DXYvmwsBQU+Lw==
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ARM: dts: vf610-zii-dev: enable vf610 builtin temp sensor
Date: Wed, 16 May 2018 09:39:21 +0300
Message-Id: <20180516063921.10406-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vybrid has single internal temperature sensor connected to both internal
ADC modules.

vf610-zii-dev already has ADC0 enabled. Now, to get temperature sensor
captured by iio_hwmon driver, need to configure iio_hwmon node to use
that ADC.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 4 ++++
 arch/arm/boot/dts/vfxxx.dtsi         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 4890b8a5aa44..5ae5abfe1d55 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -222,6 +222,10 @@
 	status = "okay";
 };
 
+&tempsensor {
+	io-channels = <&adc0 16>;
+};
+
 &iomuxc {
 	pinctrl_adc0_ad5: adc0ad5grp {
 		fsl,pins = <
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index c3f09b737924..d392794d9c13 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -84,7 +84,7 @@
 		mask = <0x1000>;
 	};
 
-	iio-hwmon {
+	tempsensor: iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 16>, <&adc1 16>;
 	};
-- 
2.11.0
