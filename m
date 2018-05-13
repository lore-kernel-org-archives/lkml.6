Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeEMXWg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:22:36 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38137 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeEMXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:22:33 -0400
X-Google-Smtp-Source: AB8JxZpfGHTl5tCZJVhQnWN65MpmWaTgmXUZxJ0XS+STYMZeq+/TTWXBIBCCuc73ewYVZz0cn68E1A==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: nicolas.ferre@microchip.com
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:22:04 -0300
Message-Id: <1526253724-3596-1-git-send-email-hernan@vanguardiasur.com.ar>
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
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index e4bbb7e..fcc85d7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -232,7 +232,7 @@
 						pinctrl-names = "default";
 						pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 						interrupt-parent = <&pioA>;
-						interrupts = <PIN_PB13 GPIO_ACTIVE_LOW>;
+						interrupts = <PIN_PB13 IRQ_TYPE_EDGE_RISING>;
 
 						active-semi,chglev-gpios = <&pioA PIN_PA12 GPIO_ACTIVE_HIGH>;
 						active-semi,lbo-gpios = <&pioA PIN_PC8 GPIO_ACTIVE_LOW>;
-- 
2.7.4
