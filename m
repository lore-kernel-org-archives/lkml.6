Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2A3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B232083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oDRrI51r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B232083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeHaXWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:22:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38820 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeHaXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:22:23 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJDVPf085377;
        Fri, 31 Aug 2018 14:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535742811;
        bh=Suy1yTqz+yiqc4ELlBcD5IjBUyMsYsgf4GqYvn3+2NI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oDRrI51rnt75Ah4R9BExsHa+EO9XAsSl9S44viNta1algtWiO6ayXUXT6k36VXHqW
         EK6XGMgR/6oQLUqEzqnAenfGlsQ1PRK/Wms9nEIWJa0cn0K1NMD1RkiAnaPceAs+d0
         ZErXnIsiwfz8WPuJ1gyCouLA4n10SoZQNCtASFMI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDVkh025268;
        Fri, 31 Aug 2018 14:13:31 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:13:30 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:13:30 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDUmB008547;
        Fri, 31 Aug 2018 14:13:30 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJDUx13215;
        Fri, 31 Aug 2018 14:13:30 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 5/5] gpio: davinci: Move driver local definitions to driver
Date:   Fri, 31 Aug 2018 14:13:26 -0500
Message-ID: <20180831191326.25106-5-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831191326.25106-1-afd@ti.com>
References: <20180831191326.25106-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These defines, structs and inline functions are used only internally by
the driver, they do not belong in platform_data. Move them.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/gpio/gpio-davinci.c                | 28 ++++++++++++++++++++++
 include/linux/platform_data/gpio-davinci.h | 28 ----------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 121a7948f785..5c1564fcc24e 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -9,6 +9,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
+
 #include <linux/gpio/driver.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -24,6 +25,12 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/spinlock.h>
+
+#include <asm-generic/gpio.h>
+
+#define MAX_REGS_BANKS 5
+#define MAX_INT_PER_BANK 32
 
 struct davinci_gpio_regs {
 	u32	dir;
@@ -45,6 +52,27 @@ typedef struct irq_chip *(*gpio_get_irq_chip_cb_t)(unsigned int irq);
 static void __iomem *gpio_base;
 static unsigned int offset_array[5] = {0x10, 0x38, 0x60, 0x88, 0xb0};
 
+struct davinci_gpio_irq_data {
+	void __iomem			*regs;
+	struct davinci_gpio_controller	*chip;
+	int				bank_num;
+};
+
+struct davinci_gpio_controller {
+	struct gpio_chip	chip;
+	struct irq_domain	*irq_domain;
+	/* Serialize access to GPIO registers */
+	spinlock_t		lock;
+	void __iomem		*regs[MAX_REGS_BANKS];
+	int			gpio_unbanked;
+	int			irqs[MAX_INT_PER_BANK];
+};
+
+static inline u32 __gpio_mask(unsigned gpio)
+{
+	return 1 << (gpio % 32);
+}
+
 static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
 {
 	struct davinci_gpio_regs __iomem *g;
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index 47695b342883..f92a47e18034 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -16,40 +16,12 @@
 #ifndef __DAVINCI_GPIO_PLATFORM_H
 #define __DAVINCI_GPIO_PLATFORM_H
 
-#include <linux/io.h>
-#include <linux/spinlock.h>
-
-#include <asm-generic/gpio.h>
-
-#define MAX_REGS_BANKS		5
-#define MAX_INT_PER_BANK 32
-
 struct davinci_gpio_platform_data {
 	u32	ngpio;
 	u32	gpio_unbanked;
 };
 
-struct davinci_gpio_irq_data {
-	void __iomem			*regs;
-	struct davinci_gpio_controller	*chip;
-	int				bank_num;
-};
-
-struct davinci_gpio_controller {
-	struct gpio_chip	chip;
-	struct irq_domain	*irq_domain;
-	/* Serialize access to GPIO registers */
-	spinlock_t		lock;
-	void __iomem		*regs[MAX_REGS_BANKS];
-	int			gpio_unbanked;
-	int			irqs[MAX_INT_PER_BANK];
-};
-
 /* Convert GPIO signal to GPIO pin number */
 #define GPIO_TO_PIN(bank, gpio)	(16 * (bank) + (gpio))
 
-static inline u32 __gpio_mask(unsigned gpio)
-{
-	return 1 << (gpio % 32);
-}
 #endif
-- 
2.18.0

