Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D75C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C4218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="HDyelLqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfAYKCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:02:01 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25347 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbfAYKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:02:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548410478; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=JCUqfA+32JF7tGEx/3f+E9HPG3nccgQIynbiq6Jj5EE5G7KtlscnqYoDBb6z5ZYeTaZoufrehKf1DRMX9xA6fZmj9K1JdEC/bFhFe4Uq6n241g8YdNPU0dwAnagl3POxZ43i/1jQmQzKJ+fRN3YZDfZpfXtdS3+fwnLBFdQUOjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548410478; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=FcFtKF5BLlOmXSfux19QpNI08n8lePBF1/zfRdupz8I=; 
        b=N7Y+r5mvQr+47zcTsnJYyWi6cMzW1t7xwb3PXAwogXa2NwN0aHAIEaKZ3mJDxSZVpCICoztcsBJB5Y0FE45iuV7x/5BT3NWKYgCAIvJVyYNs7UA3nmb1MISqrKcwnI8HwOlXhwCjOFvMQlVt6RSbe8/oUQg4PW4+WkOp0TzdBW0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=OmkVDpTuBHp4Ci2S9GNKcAAzp/BQsAXGdy+GteoIFJi3Et1ekFMuI7IQ3DJ6sVVFEsuTxhVYtQ/i
    aHYKBg8f0xWiEyHxepWvLM+XNbKikbkxomE4VqQ9c5msWikSi9a3  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548410478;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=9701; bh=FcFtKF5BLlOmXSfux19QpNI08n8lePBF1/zfRdupz8I=;
        b=HDyelLqc7OJYt+6MyFcBKGH3k2KB7ItELLSGpjZ538MpftqI77kzUlGxvJjQ6QI1
        YyPPnlP6UCd9SVxEPkrSDwFb4WWaFaPvpnXLFTmPJq666aUtEJZGomSIa7B+AMJBA1b
        j1EPa1dFiZoSRjUJy1bu/c6rL89iyvO2i/sxS/EI=
Received: from localhost.localdomain (182.149.160.17 [182.149.160.17]) by mx.zohomail.com
        with SMTPS id 154841047732094.51770114890758; Fri, 25 Jan 2019 02:01:17 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.burton@mips.com,
        paul@crapouillou.net, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: [PATCH RESEND 2/4] Pinctrl: Ingenic: Add missing parts for JZ4770 and JZ4780.
Date:   Fri, 25 Jan 2019 17:59:51 +0800
Message-Id: <1548410393-6981-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
References: <1548410393-6981-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmc2 for JZ4770 and JZ4780:
According to the datasheet, both JZ4770 and JZ4780 have mmc2. But this
part of the original code is missing. It is worth noting that JZ4770's
mmc2 supports 8bit mode while JZ4780's does not, so we added the
corresponding code for both models.

Add nemc-wait for JZ4770 and JZ4780:
Both JZ4770 and JZ4780 have a nemc-wait pin. But this part of the
original code is missing.

Add mac for JZ4770:
JZ4770 have a mac. But this part of the original code is missing.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 46 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 710062b..6501f35 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -335,6 +335,11 @@ static int jz4770_mmc1_4bit_d_pins[] = { 0x75, 0x76, 0x77, };
 static int jz4770_mmc1_1bit_e_pins[] = { 0x9c, 0x9d, 0x94, };
 static int jz4770_mmc1_4bit_e_pins[] = { 0x95, 0x96, 0x97, };
 static int jz4770_mmc1_8bit_e_pins[] = { 0x98, 0x99, 0x9a, 0x9b, };
+static int jz4770_mmc2_1bit_b_pins[] = { 0x3c, 0x3d, 0x34, };
+static int jz4770_mmc2_4bit_b_pins[] = { 0x35, 0x3e, 0x3f, };
+static int jz4770_mmc2_1bit_e_pins[] = { 0x9c, 0x9d, 0x94, };
+static int jz4770_mmc2_4bit_e_pins[] = { 0x95, 0x96, 0x97, };
+static int jz4770_mmc2_8bit_e_pins[] = { 0x98, 0x99, 0x9a, 0x9b, };
 static int jz4770_nemc_8bit_data_pins[] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
 };
@@ -345,6 +350,7 @@ static int jz4770_nemc_cle_ale_pins[] = { 0x20, 0x21, };
 static int jz4770_nemc_addr_pins[] = { 0x22, 0x23, 0x24, 0x25, };
 static int jz4770_nemc_rd_we_pins[] = { 0x10, 0x11, };
 static int jz4770_nemc_frd_fwe_pins[] = { 0x12, 0x13, };
+static int jz4770_nemc_wait_pins[] = { 0x1b, };
 static int jz4770_nemc_cs1_pins[] = { 0x15, };
 static int jz4770_nemc_cs2_pins[] = { 0x16, };
 static int jz4770_nemc_cs3_pins[] = { 0x17, };
@@ -375,6 +381,10 @@ static int jz4770_pwm_pwm4_pins[] = { 0x84, };
 static int jz4770_pwm_pwm5_pins[] = { 0x85, };
 static int jz4770_pwm_pwm6_pins[] = { 0x6a, };
 static int jz4770_pwm_pwm7_pins[] = { 0x6b, };
+static int jz4770_mac_rmii_pins[] = {
+	0xa9, 0xab, 0xaa, 0xac, 0xa5, 0xa4, 0xad, 0xae, 0xa6, 0xa8,
+};
+static int jz4770_mac_mii_pins[] = { 0xa7, 0xaf, };
 
 static int jz4770_uart0_data_funcs[] = { 0, 0, };
 static int jz4770_uart0_hwflow_funcs[] = { 0, 0, };
@@ -394,12 +404,18 @@ static int jz4770_mmc1_4bit_d_funcs[] = { 0, 0, 0, };
 static int jz4770_mmc1_1bit_e_funcs[] = { 1, 1, 1, };
 static int jz4770_mmc1_4bit_e_funcs[] = { 1, 1, 1, };
 static int jz4770_mmc1_8bit_e_funcs[] = { 1, 1, 1, 1, };
+static int jz4770_mmc2_1bit_b_funcs[] = { 0, 0, 0, };
+static int jz4770_mmc2_4bit_b_funcs[] = { 0, 0, 0, };
+static int jz4770_mmc2_1bit_e_funcs[] = { 2, 2, 2, };
+static int jz4770_mmc2_4bit_e_funcs[] = { 2, 2, 2, };
+static int jz4770_mmc2_8bit_e_funcs[] = { 2, 2, 2, 2, };
 static int jz4770_nemc_8bit_data_funcs[] = { 0, 0, 0, 0, 0, 0, 0, 0, };
 static int jz4770_nemc_16bit_data_funcs[] = { 0, 0, 0, 0, 0, 0, 0, 0, };
 static int jz4770_nemc_cle_ale_funcs[] = { 0, 0, };
 static int jz4770_nemc_addr_funcs[] = { 0, 0, 0, 0, };
 static int jz4770_nemc_rd_we_funcs[] = { 0, 0, };
 static int jz4770_nemc_frd_fwe_funcs[] = { 0, 0, };
+static int jz4770_nemc_wait_funcs[] = { 0, };
 static int jz4770_nemc_cs1_funcs[] = { 0, };
 static int jz4770_nemc_cs2_funcs[] = { 0, };
 static int jz4770_nemc_cs3_funcs[] = { 0, };
@@ -425,6 +441,8 @@ static int jz4770_pwm_pwm4_funcs[] = { 0, };
 static int jz4770_pwm_pwm5_funcs[] = { 0, };
 static int jz4770_pwm_pwm6_funcs[] = { 0, };
 static int jz4770_pwm_pwm7_funcs[] = { 0, };
+static int jz4770_mac_rmii_funcs[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, };
+static int jz4770_mac_mii_funcs[] = { 0, 0, };
 
 static const struct group_desc jz4770_groups[] = {
 	INGENIC_PIN_GROUP("uart0-data", jz4770_uart0_data),
@@ -445,12 +463,18 @@ static const struct group_desc jz4770_groups[] = {
 	INGENIC_PIN_GROUP("mmc1-1bit-e", jz4770_mmc1_1bit_e),
 	INGENIC_PIN_GROUP("mmc1-4bit-e", jz4770_mmc1_4bit_e),
 	INGENIC_PIN_GROUP("mmc1-8bit-e", jz4770_mmc1_8bit_e),
+	INGENIC_PIN_GROUP("mmc2-1bit-b", jz4770_mmc2_1bit_b),
+	INGENIC_PIN_GROUP("mmc2-4bit-b", jz4770_mmc2_4bit_b),
+	INGENIC_PIN_GROUP("mmc2-1bit-e", jz4770_mmc2_1bit_e),
+	INGENIC_PIN_GROUP("mmc2-4bit-e", jz4770_mmc2_4bit_e),
+	INGENIC_PIN_GROUP("mmc2-8bit-e", jz4770_mmc2_8bit_e),
 	INGENIC_PIN_GROUP("nemc-8bit-data", jz4770_nemc_8bit_data),
 	INGENIC_PIN_GROUP("nemc-16bit-data", jz4770_nemc_16bit_data),
 	INGENIC_PIN_GROUP("nemc-cle-ale", jz4770_nemc_cle_ale),
 	INGENIC_PIN_GROUP("nemc-addr", jz4770_nemc_addr),
 	INGENIC_PIN_GROUP("nemc-rd-we", jz4770_nemc_rd_we),
 	INGENIC_PIN_GROUP("nemc-frd-fwe", jz4770_nemc_frd_fwe),
+	INGENIC_PIN_GROUP("nemc-wait", jz4770_nemc_wait),
 	INGENIC_PIN_GROUP("nemc-cs1", jz4770_nemc_cs1),
 	INGENIC_PIN_GROUP("nemc-cs2", jz4770_nemc_cs2),
 	INGENIC_PIN_GROUP("nemc-cs3", jz4770_nemc_cs3),
@@ -472,6 +496,8 @@ static const struct group_desc jz4770_groups[] = {
 	INGENIC_PIN_GROUP("pwm5", jz4770_pwm_pwm5),
 	INGENIC_PIN_GROUP("pwm6", jz4770_pwm_pwm6),
 	INGENIC_PIN_GROUP("pwm7", jz4770_pwm_pwm7),
+	INGENIC_PIN_GROUP("mac-rmii", jz4770_mac_rmii),
+	INGENIC_PIN_GROUP("mac-mii", jz4770_mac_mii),
 };
 
 static const char *jz4770_uart0_groups[] = { "uart0-data", "uart0-hwflow", };
@@ -486,9 +512,13 @@ static const char *jz4770_mmc1_groups[] = {
 	"mmc1-1bit-d", "mmc1-4bit-d",
 	"mmc1-1bit-e", "mmc1-4bit-e", "mmc1-8bit-e",
 };
+static const char *jz4770_mmc2_groups[] = {
+	"mmc2-1bit-b", "mmc2-4bit-b",
+	"mmc2-1bit-e", "mmc2-4bit-e", "mmc2-8bit-e",
+};
 static const char *jz4770_nemc_groups[] = {
 	"nemc-8bit-data", "nemc-16bit-data", "nemc-cle-ale",
-	"nemc-addr", "nemc-rd-we", "nemc-frd-fwe",
+	"nemc-addr", "nemc-rd-we", "nemc-frd-fwe", "nemc-wait",
 };
 static const char *jz4770_cs1_groups[] = { "nemc-cs1", };
 static const char *jz4770_cs2_groups[] = { "nemc-cs2", };
@@ -509,6 +539,7 @@ static const char *jz4770_pwm4_groups[] = { "pwm4", };
 static const char *jz4770_pwm5_groups[] = { "pwm5", };
 static const char *jz4770_pwm6_groups[] = { "pwm6", };
 static const char *jz4770_pwm7_groups[] = { "pwm7", };
+static const char *jz4770_mac_groups[] = { "mac-rmii", "mac-mii", };
 
 static const struct function_desc jz4770_functions[] = {
 	{ "uart0", jz4770_uart0_groups, ARRAY_SIZE(jz4770_uart0_groups), },
@@ -517,6 +548,7 @@ static const struct function_desc jz4770_functions[] = {
 	{ "uart3", jz4770_uart3_groups, ARRAY_SIZE(jz4770_uart3_groups), },
 	{ "mmc0", jz4770_mmc0_groups, ARRAY_SIZE(jz4770_mmc0_groups), },
 	{ "mmc1", jz4770_mmc1_groups, ARRAY_SIZE(jz4770_mmc1_groups), },
+	{ "mmc2", jz4770_mmc2_groups, ARRAY_SIZE(jz4770_mmc2_groups), },
 	{ "nemc", jz4770_nemc_groups, ARRAY_SIZE(jz4770_nemc_groups), },
 	{ "nemc-cs1", jz4770_cs1_groups, ARRAY_SIZE(jz4770_cs1_groups), },
 	{ "nemc-cs2", jz4770_cs2_groups, ARRAY_SIZE(jz4770_cs2_groups), },
@@ -537,6 +569,7 @@ static const struct function_desc jz4770_functions[] = {
 	{ "pwm5", jz4770_pwm5_groups, ARRAY_SIZE(jz4770_pwm5_groups), },
 	{ "pwm6", jz4770_pwm6_groups, ARRAY_SIZE(jz4770_pwm6_groups), },
 	{ "pwm7", jz4770_pwm7_groups, ARRAY_SIZE(jz4770_pwm7_groups), },
+	{ "mac", jz4770_mac_groups, ARRAY_SIZE(jz4770_mac_groups), },
 };
 
 static const struct ingenic_chip_info jz4770_chip_info = {
@@ -584,11 +617,16 @@ static const struct group_desc jz4780_groups[] = {
 	INGENIC_PIN_GROUP("mmc1-4bit-d", jz4770_mmc1_4bit_d),
 	INGENIC_PIN_GROUP("mmc1-1bit-e", jz4770_mmc1_1bit_e),
 	INGENIC_PIN_GROUP("mmc1-4bit-e", jz4770_mmc1_4bit_e),
+	INGENIC_PIN_GROUP("mmc2-1bit-b", jz4770_mmc2_1bit_b),
+	INGENIC_PIN_GROUP("mmc2-4bit-b", jz4770_mmc2_4bit_b),
+	INGENIC_PIN_GROUP("mmc2-1bit-e", jz4770_mmc2_1bit_e),
+	INGENIC_PIN_GROUP("mmc2-4bit-e", jz4770_mmc2_4bit_e),
 	INGENIC_PIN_GROUP("nemc-data", jz4770_nemc_8bit_data),
 	INGENIC_PIN_GROUP("nemc-cle-ale", jz4770_nemc_cle_ale),
 	INGENIC_PIN_GROUP("nemc-addr", jz4770_nemc_addr),
 	INGENIC_PIN_GROUP("nemc-rd-we", jz4770_nemc_rd_we),
 	INGENIC_PIN_GROUP("nemc-frd-fwe", jz4770_nemc_frd_fwe),
+	INGENIC_PIN_GROUP("nemc-wait", jz4770_nemc_wait),
 	INGENIC_PIN_GROUP("nemc-cs1", jz4770_nemc_cs1),
 	INGENIC_PIN_GROUP("nemc-cs2", jz4770_nemc_cs2),
 	INGENIC_PIN_GROUP("nemc-cs3", jz4770_nemc_cs3),
@@ -623,9 +661,12 @@ static const char *jz4780_mmc0_groups[] = {
 static const char *jz4780_mmc1_groups[] = {
 	"mmc1-1bit-d", "mmc1-4bit-d", "mmc1-1bit-e", "mmc1-4bit-e",
 };
+static const char *jz4780_mmc2_groups[] = {
+	"mmc2-1bit-b", "mmc2-4bit-b", "mmc2-1bit-e", "mmc2-4bit-e",
+};
 static const char *jz4780_nemc_groups[] = {
 	"nemc-data", "nemc-cle-ale", "nemc-addr",
-	"nemc-rd-we", "nemc-frd-fwe",
+	"nemc-rd-we", "nemc-frd-fwe", "nemc-wait",
 };
 static const char *jz4780_i2c3_groups[] = { "i2c3-data", };
 static const char *jz4780_i2c4_groups[] = { "i2c4-data-e", "i2c4-data-f", };
@@ -639,6 +680,7 @@ static const struct function_desc jz4780_functions[] = {
 	{ "uart4", jz4780_uart4_groups, ARRAY_SIZE(jz4780_uart4_groups), },
 	{ "mmc0", jz4780_mmc0_groups, ARRAY_SIZE(jz4780_mmc0_groups), },
 	{ "mmc1", jz4780_mmc1_groups, ARRAY_SIZE(jz4780_mmc1_groups), },
+	{ "mmc2", jz4780_mmc2_groups, ARRAY_SIZE(jz4780_mmc2_groups), },
 	{ "nemc", jz4780_nemc_groups, ARRAY_SIZE(jz4780_nemc_groups), },
 	{ "nemc-cs1", jz4770_cs1_groups, ARRAY_SIZE(jz4770_cs1_groups), },
 	{ "nemc-cs2", jz4770_cs2_groups, ARRAY_SIZE(jz4770_cs2_groups), },
-- 
2.7.4


