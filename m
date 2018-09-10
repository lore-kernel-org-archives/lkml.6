Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16ABB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvcVRxHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16ABB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbeIKAom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:44:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35183 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbeIKAol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:44:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id q13-v6so18470230lfc.2;
        Mon, 10 Sep 2018 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xgYuvQY4yWBtm2f06S/yg/wR5OiT+6uG/z3l5BwPSgs=;
        b=kvcVRxHc0q7ew0GiemJwa4rHm7Rufnyursm5uL/H4JKgS9Cqs62a32S2bpcf5Y/F+w
         QtV5wo3adm6mepF1vSiqmsX4kqvRBuCfqTwJLRV/QLXKJkgZI3H2XWh7MxJIVTNfiMG2
         zWRjXxE9JMUcxlRyrqV4eWyFmPJkeTfbZpYDoObntWA9MVgsZCDHjOMPItDiHWbzhoKI
         xaWQl1MLR0501ylQQkj/sVyMAPpqUcRtDihsXebZzG47e2v7iavFvqE2J7KEdTEpGqQL
         MyfvW1cVtSW3pQ4QXsNln79hDdELoc3gOyqqEQXh2fPSmlID+hZ4qZFADKdKzQ3js5O5
         prGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xgYuvQY4yWBtm2f06S/yg/wR5OiT+6uG/z3l5BwPSgs=;
        b=GaPz2TRDzc/DSx71D3giykinUwfLV9W4jlOvmFty7KegW72rjc71zqs4UPm8rNQToW
         cyVJsvoyE6DymaNQQ3VwEb6cF6thqzh6T15OnXig5Lr732TJnMZWHDbl9cmbgkmhKQU/
         /KJ7u6n39Za5g3ty68pHMf6/PeSFmbIVFMIHdGNEvWTf1VJGQrqclUpyG0eBz3j4g/z4
         pS4yg45vtu/tNSpJ+NB6bPo/Epib+qvp+vzzaSbLRPSUmYmQPDPTl/Zp+NsAiQGpzGxR
         SbSdtJ5oEY23GnkgWQ81mqAO2fRHaynQ1Q+MIpMvGUum4skXoHaNZFt6lr9hTZJ7+4Cc
         OTmw==
X-Gm-Message-State: APzg51AZV0JaGftMDdK8NMKth8/+AFz9rvxnHwt4LfoQr8+7yZix/9ST
        zJvWxeFh8DBRKIehzHA3WlY=
X-Google-Smtp-Source: ANB0VdZkdYMpAi24AE+zfrsCIFCILeJHedQVkWFuLJtVPC4drrleNP2vpuV4aQrvjsgBlYzNAb3Eog==
X-Received: by 2002:a19:129e:: with SMTP id 30-v6mr13209565lfs.29.1536608940620;
        Mon, 10 Sep 2018 12:49:00 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f7-v6sm2871492lfc.4.2018.09.10.12.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 12:48:59 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: ams-delta: Don't request unused GPIOs
Date:   Mon, 10 Sep 2018 21:50:08 +0200
Message-Id: <20180910195008.24127-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs with no kernel drivers can still be used from user space, don't
request them from the board file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 40 +----------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index dd625ac3cd09..fee528dccc3e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -250,39 +250,6 @@ static struct platform_device latch2_gpio_device = {
 #define LATCH2_PIN_HOOKFLASH1		14
 #define LATCH2_PIN_HOOKFLASH2		15
 
-static const struct gpio latch_gpios[] __initconst = {
-	{
-		.gpio	= LATCH1_GPIO_BASE + 6,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "dockit1",
-	},
-	{
-		.gpio	= LATCH1_GPIO_BASE + 7,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "dockit2",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_SCARD_RSTIN,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "scard_rstin",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_SCARD_CMDVCC,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "scard_cmdvcc",
-	},
-	{
-		.gpio	= AMS_DELTA_LATCH2_GPIO_BASE + 14,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "hookflash1",
-	},
-	{
-		.gpio	= AMS_DELTA_LATCH2_GPIO_BASE + 15,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "hookflash2",
-	},
-};
-
 static struct regulator_consumer_supply modem_nreset_consumers[] = {
 	REGULATOR_SUPPLY("RESET#", "serial8250.1"),
 	REGULATOR_SUPPLY("POR", "cx20442-codec"),
@@ -860,7 +827,6 @@ static void __init ams_delta_led_init(struct gpio_chip *chip)
 static int __init ams_delta_gpio_init(void)
 {
 	struct gpio_chip *chip;
-	int err;
 
 	if (!machine_is_ams_delta())
 		return -ENODEV;
@@ -871,11 +837,7 @@ static int __init ams_delta_gpio_init(void)
 	else
 		ams_delta_led_init(chip);
 
-	err = gpio_request_array(latch_gpios, ARRAY_SIZE(latch_gpios));
-	if (err)
-		pr_err("Couldn't take over latch1/latch2 GPIO pins\n");
-
-	return err;
+	return 0;
 }
 device_initcall_sync(ams_delta_gpio_init);
 
-- 
2.16.4

