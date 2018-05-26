Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031586AbeEZJjL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:39:11 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:43709 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031347AbeEZJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:39:10 -0400
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 26 May 2018 11:39:09 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: hx4700: fix the usb client
Date: Sat, 26 May 2018 11:38:34 +0200
Message-Id: <20180526093834.21277-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb client of the hx4700 is not working because no platform data is
declared. Fix it by adding the missing call.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/hx4700.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index e2e7f247a645..b79b757fdd41 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -54,6 +54,7 @@
 
 #include "devices.h"
 #include "generic.h"
+#include "udc.h"
 
 /* Physical address space information */
 
@@ -594,6 +595,8 @@ static struct platform_device gpio_vbus = {
 	},
 };
 
+static struct pxa2xx_udc_mach_info hx4700_udc_info;
+
 /*
  * Touchscreen - TSC2046 connected to SSP2
  */
@@ -891,6 +894,7 @@ static void __init hx4700_init(void)
 	gpio_set_value(GPIO71_HX4700_ASIC3_nRESET, 1);
 	mdelay(10);
 
+	pxa_set_udc_info(&hx4700_udc_info);
 	regulator_has_full_constraints();
 }
 
-- 
2.11.0
