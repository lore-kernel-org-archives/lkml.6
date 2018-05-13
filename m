Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEMXSa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:18:30 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43920 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbeEMXS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:18:28 -0400
X-Google-Smtp-Source: AB8JxZoS+jJm+o+qVhGg75stzwq/EGnOOHusrXlk/6pAtOAT66gSfEUwmJw6ubOP/6YX7nv0FckEBw==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: am335x-baltos-ir5221: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:18:14 -0300
Message-Id: <1526253494-3333-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_LOW was being used to specify an interrupt, use
IRQ_TYPE_EDGE_RISING instead. This improves DT readability.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 5d56355..832ead8 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -94,7 +94,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <20 GPIO_ACTIVE_LOW>;
+		interrupts = <20 IRQ_TYPE_EDGE_RISING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tca6416_pins>;
 	};
-- 
2.7.4
