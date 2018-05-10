Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEJSsf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:48:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56278 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeEJSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:48:32 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 5/8] MIPS: jz4740: dts: Add bindings for the jz4740-wdt driver
Date: Thu, 10 May 2018 20:47:48 +0200
Message-Id: <20180510184751.13416-5-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also remove the watchdog platform_device from platform.c, since it
wasn't used anywhere anyway.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi |  8 ++++++++
 arch/mips/jz4740/platform.c            | 16 ----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

 v2: No change
 v3: No change

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index cd5185bb90ae..26c6b561d6f7 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -45,6 +45,14 @@
 		#clock-cells = <1>;
 	};
 
+	watchdog: watchdog@10002000 {
+		compatible = "ingenic,jz4740-watchdog";
+		reg = <0x10002000 0x10>;
+
+		clocks = <&cgu JZ4740_CLK_RTC>;
+		clock-names = "rtc";
+	};
+
 	rtc_dev: rtc@10003000 {
 		compatible = "ingenic,jz4740-rtc";
 		reg = <0x10003000 0x40>;
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index 5b7cdd67a9d9..cbc5f8e87230 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -233,22 +233,6 @@ struct platform_device jz4740_adc_device = {
 	.resource	= jz4740_adc_resources,
 };
 
-/* Watchdog */
-static struct resource jz4740_wdt_resources[] = {
-	{
-		.start = JZ4740_WDT_BASE_ADDR,
-		.end   = JZ4740_WDT_BASE_ADDR + 0x10 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device jz4740_wdt_device = {
-	.name	       = "jz4740-wdt",
-	.id	       = -1,
-	.num_resources = ARRAY_SIZE(jz4740_wdt_resources),
-	.resource      = jz4740_wdt_resources,
-};
-
 /* PWM */
 struct platform_device jz4740_pwm_device = {
 	.name = "jz4740-pwm",
-- 
2.11.0
