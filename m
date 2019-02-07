Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E52C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DABE21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="J+fnWeO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBGNzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:55:50 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:52020 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfBGNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549547748; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=DHCRnQmY/k+4Uvfesnw5yfavn02GD/mg/4hU5ufyjpk=;
        b=J+fnWeO7GmPdB1XaHK8lhL9PAZL4AZ2PPSIRsDcAIG7LpDfXbPtSCfZhUdI0nybN0cuNb7
        nRRLJ/Kalip29pX+iPACr4mN1k0FjaMohAV6NMLaxQ/gXuRscI+sSNXdZZX/a7X5IoyuBM
        LdmxAlp4t6DazSDI1ahzU6WYPd2kUwA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] pinctrl: ingenic: Add LCD pins for the JZ4725B SoC
Date:   Thu,  7 Feb 2019 10:55:36 -0300
Message-Id: <20190207135536.6757-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pins and groups for the "lcd" pin function in the JZ4725B SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/pinctrl-ingenic.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index db6b48ea5f47..49532e3ecb1e 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -233,6 +233,19 @@ static int jz4725b_pwm_pwm2_pins[] = { 0x4c, };
 static int jz4725b_pwm_pwm3_pins[] = { 0x4d, };
 static int jz4725b_pwm_pwm4_pins[] = { 0x4e, };
 static int jz4725b_pwm_pwm5_pins[] = { 0x4f, };
+static int jz4725b_lcd_8bit_pins[] = {
+	0x72, 0x73, 0x74,
+	0x60, 0x61, 0x62, 0x63,
+	0x64, 0x65, 0x66, 0x67,
+};
+static int jz4725b_lcd_16bit_pins[] = {
+	0x68, 0x69, 0x6a, 0x6b,
+	0x6c, 0x6d, 0x6e, 0x6f,
+};
+static int jz4725b_lcd_18bit_pins[] = { 0x70, 0x71, };
+static int jz4725b_lcd_24bit_pins[] = { 0x76, 0x77, 0x78, 0x79, };
+static int jz4725b_lcd_special_pins[] = { 0x76, 0x77, 0x78, 0x79, };
+static int jz4725b_lcd_generic_pins[] = { 0x75, };
 
 static int jz4725b_mmc0_1bit_funcs[] = { 1, 1, 1, };
 static int jz4725b_mmc0_4bit_funcs[] = { 1, 0, 1, };
@@ -251,6 +264,12 @@ static int jz4725b_pwm_pwm2_funcs[] = { 0, };
 static int jz4725b_pwm_pwm3_funcs[] = { 0, };
 static int jz4725b_pwm_pwm4_funcs[] = { 0, };
 static int jz4725b_pwm_pwm5_funcs[] = { 0, };
+static int jz4725b_lcd_8bit_funcs[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };
+static int jz4725b_lcd_16bit_funcs[] = { 0, 0, 0, 0, 0, 0, 0, 0, };
+static int jz4725b_lcd_18bit_funcs[] = { 0, 0, };
+static int jz4725b_lcd_24bit_funcs[] = { 1, 1, 1, 1, };
+static int jz4725b_lcd_special_funcs[] = { 0, 0, 0, 0, };
+static int jz4725b_lcd_generic_funcs[] = { 0, };
 
 static const struct group_desc jz4725b_groups[] = {
 	INGENIC_PIN_GROUP("mmc0-1bit", jz4725b_mmc0_1bit),
@@ -270,6 +289,12 @@ static const struct group_desc jz4725b_groups[] = {
 	INGENIC_PIN_GROUP("pwm3", jz4725b_pwm_pwm3),
 	INGENIC_PIN_GROUP("pwm4", jz4725b_pwm_pwm4),
 	INGENIC_PIN_GROUP("pwm5", jz4725b_pwm_pwm5),
+	INGENIC_PIN_GROUP("lcd-8bit", jz4725b_lcd_8bit),
+	INGENIC_PIN_GROUP("lcd-16bit", jz4725b_lcd_16bit),
+	INGENIC_PIN_GROUP("lcd-18bit", jz4725b_lcd_18bit),
+	INGENIC_PIN_GROUP("lcd-24bit", jz4725b_lcd_24bit),
+	INGENIC_PIN_GROUP("lcd-special", jz4725b_lcd_special),
+	INGENIC_PIN_GROUP("lcd-generic", jz4725b_lcd_generic),
 };
 
 static const char *jz4725b_mmc0_groups[] = { "mmc0-1bit", "mmc0-4bit", };
@@ -285,6 +310,10 @@ static const char *jz4725b_pwm2_groups[] = { "pwm2", };
 static const char *jz4725b_pwm3_groups[] = { "pwm3", };
 static const char *jz4725b_pwm4_groups[] = { "pwm4", };
 static const char *jz4725b_pwm5_groups[] = { "pwm5", };
+static const char *jz4725b_lcd_groups[] = {
+	"lcd-8bit", "lcd-16bit", "lcd-18bit", "lcd-24bit",
+	"lcd-special", "lcd-generic",
+};
 
 static const struct function_desc jz4725b_functions[] = {
 	{ "mmc0", jz4725b_mmc0_groups, ARRAY_SIZE(jz4725b_mmc0_groups), },
@@ -297,6 +326,7 @@ static const struct function_desc jz4725b_functions[] = {
 	{ "pwm3", jz4725b_pwm3_groups, ARRAY_SIZE(jz4725b_pwm3_groups), },
 	{ "pwm4", jz4725b_pwm4_groups, ARRAY_SIZE(jz4725b_pwm4_groups), },
 	{ "pwm5", jz4725b_pwm5_groups, ARRAY_SIZE(jz4725b_pwm5_groups), },
+	{ "lcd", jz4725b_lcd_groups, ARRAY_SIZE(jz4725b_lcd_groups), },
 };
 
 static const struct ingenic_chip_info jz4725b_chip_info = {
-- 
2.11.0

