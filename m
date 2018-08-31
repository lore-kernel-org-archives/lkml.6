Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CBCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424032083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NBsUdlZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424032083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHaXWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:22:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38816 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeHaXWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:22:22 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJDUW4085373;
        Fri, 31 Aug 2018 14:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535742810;
        bh=ZkkeEQKdMokBg3jCy1LR/KmEkzVJPteW4V3+j3tWlWM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NBsUdlZNe4Vev6jpKY5PzxNWqEvH1shItmi0AHq2S9iaN5rbgEK9lYj4ALZOfIqhf
         /H3rI9gR5D567A/L6WOitZb/LpJMV8lcEgePzaccxR5gBhNl3ZWeiprKTyADeCZhML
         UiRCWaxE8A4yPCbe3f3z3X8nnoeSTGJCWTNbavw4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDUcK014487;
        Fri, 31 Aug 2018 14:13:30 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:13:29 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:13:29 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJDTGG012951;
        Fri, 31 Aug 2018 14:13:29 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJDTx13211;
        Fri, 31 Aug 2018 14:13:29 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 4/5] gpio: davinci: Remove unneeded GPIO macro
Date:   Fri, 31 Aug 2018 14:13:25 -0500
Message-ID: <20180831191326.25106-4-afd@ti.com>
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

This macro does nothing and has only one user, remove it.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-davinci/board-neuros-osd2.c  | 8 ++++----
 include/linux/platform_data/gpio-davinci.h | 5 -----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 353f9e5a1454..efdaa27241c5 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -130,10 +130,10 @@ static struct platform_device davinci_fb_device = {
 };
 
 static const struct gpio_led ntosd2_leds[] = {
-	{ .name = "led1_green", .gpio = GPIO(10), },
-	{ .name = "led1_red",   .gpio = GPIO(11), },
-	{ .name = "led2_green", .gpio = GPIO(12), },
-	{ .name = "led2_red",   .gpio = GPIO(13), },
+	{ .name = "led1_green", .gpio = 10, },
+	{ .name = "led1_red",   .gpio = 11, },
+	{ .name = "led2_green", .gpio = 12, },
+	{ .name = "led2_red",   .gpio = 13, },
 };
 
 static struct gpio_led_platform_data ntosd2_leds_data = {
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index b8e4957e7568..47695b342883 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -45,11 +45,6 @@ struct davinci_gpio_controller {
 	int			irqs[MAX_INT_PER_BANK];
 };
 
-/*
- * basic gpio routines
- */
-#define	GPIO(X)		(X)	/* 0 <= X <= (DAVINCI_N_GPIO - 1) */
-
 /* Convert GPIO signal to GPIO pin number */
 #define GPIO_TO_PIN(bank, gpio)	(16 * (bank) + (gpio))
 
-- 
2.18.0

