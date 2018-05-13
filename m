Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEMXUM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:20:12 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41243 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeEMXUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:20:10 -0400
X-Google-Smtp-Source: AB8JxZpTVni9TnevLoxXXqT+wcRTbArLnEVAyFjGhB0qFxPqLEYRsWDD56OBmKPvdIs6KroB238sKA==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: am335x-boneblue: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:19:56 -0300
Message-Id: <1526253596-3468-1-git-send-email-hernan@vanguardiasur.com.ar>
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
 arch/arm/boot/dts/am335x-boneblue.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 58baee1..7bcd726 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -364,7 +364,7 @@
 		compatible = "invensense,mpu9250";
 		reg = <0x68>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <21 GPIO_ACTIVE_LOW>;
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>;
 		i2c-gate {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
