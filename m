Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8644E247C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReuSGwu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8644E247C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeGBW20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:28:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44179 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeGBW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:28:24 -0400
Received: by mail-lf0-f65.google.com with SMTP id h7-v6so5148881lfc.11;
        Mon, 02 Jul 2018 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VZgBIR9wRrC8KUG8GmkX+rQdixRza3owQ+sV683E2J4=;
        b=ReuSGwu9uN/bonm+zFLkF6tS+R+H98ud2Zb2svPnPwk/X41MnyezMcyoS3KPYAtRFw
         yRsybK8LDDjGp9xZZHU/fRJO1v5VcXsx1mRfHsADD8jEph8BS0XSSZS9vgb13mZHCBKV
         QoyctG25jIVEyACxHmezm/Hy8R1u7roLobg+icuw3WHWo8C2knX9xDST1KzxEcSGimQa
         sEpHvpFb/ITSMAvgNH/xvHalkFqAUrMcs3dyj/BfMga/fWnC0zlq/Jo43HOp91UwgqkX
         ACkjWfStJGHMxGI7S4rlkFWWw6zDCTNqpa6ayvswEQN5iUsfgp/3/NnDMfwS5o+NRqe6
         D/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VZgBIR9wRrC8KUG8GmkX+rQdixRza3owQ+sV683E2J4=;
        b=Czftd1Do7iVjJcJsoCT2akjtJ8M7S6yyGofDjUxMUdD8/vqqzBg3mwIxMZvAqP6mDO
         J8L7qYQ6tqIa7+i47J27Yzk9kVSO8m6KfSrfAWfA3FDGyPcBm3rTDg8N+nyFEwlyHs7F
         yW12IVNZY3K4gDzsH50Rw1QzDjzO3EYj5/jL5io7nWCqFxaRG2WxS6RrvOcDXmesSt8F
         3fW3FY4Y4s5bNDchQ6OoY0SoY2ViJhD8cBPMpjS38sN88Tv6HAW1xRB+BErsgjKson4F
         g/6qbJWCFo5yyLS8nV6H/VU2SYWS6MssWYaXH2sgpSDSOFu6PLr6+cpMPtO7fTHpI+iW
         L1/Q==
X-Gm-Message-State: APt69E1HN9/YCWAwkr/87zH1wg/dXOmGttYsNqsEBAg9fO52O8jPCb7l
        OGVQNt9TcWjGAqrOWtO7dTM=
X-Google-Smtp-Source: AAOMgpdG0i6NnMXU4A1/xJaFRfOlC4tmxUCdeXxXQTw2T8PhmpzGdK8n3RYf6DmrImXxxIvmubBNuA==
X-Received: by 2002:a19:5512:: with SMTP id n18-v6mr15729424lfe.133.1530570502977;
        Mon, 02 Jul 2018 15:28:22 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h1-v6sm1198144ljc.15.2018.07.02.15.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 15:28:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: move late devices back to init_machine
Date:   Tue,  3 Jul 2018 00:28:28 +0200
Message-Id: <20180702222828.27779-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization of several Amstrad Delta devices was once moved to
late_initcall by commit f7519d8c8290 ("ARM: OMAP1: ams-delta: register
latch dependent devices later").  The purpose of that move was to allow
smooth conversion of Amstrad Delta latches to GPIO.

After successful conversion only ams_delta_serio driver was moved back
to device_initcall by commit 8d09a1bb3147 ("input: serio: ams-delta:
toggle keyboard power over GPIO").  Registration of ams-delta-nand and
lcd_ams_delta devices was kept in late_initcall in order to avoid
corrupt data reported by the serio driver on boot.  Registration of
cx20442-codec device was kept there for it to be probed after a
regulator on which it depended was ready.

The issue of "keybrd_dataout" GPIO pin not initilized to GPIO_OUT_LOW
before other latch2 pins causing the corruption have been apparently
fixed by commit 5322c19b117a ("ARM: OMAP1: ams-delta: Hog
"keybrd_dataout" GPIO pin").  In turn, the issue of missing regulator
has been fixed by commit 50c678772a0b ("ASoC: cx20442: Don't ignore
regulator_get() errors.").

Simplify the board init code by moving registration of those devices
back to init_machine.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Created and testet on top of recent commits 3e14de3bfb3a ("ARM: OMAP1:
ams-delta: refactor late_init()") and 5322c19b117a ("ARM: OMAP1:
ams-delta: Hog "keybrd_dataout" GPIO pin") found in branch
omap-for-v4.19/omap1 of linux-omap tree as well as on commit
50c678772a0b ("ASoC: cx20442: Don't ignore regulator_get() errors.")
already found in linux-next tree.

 arch/arm/mach-omap1/board-ams-delta.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 22f9be297c2a..dd28d2614d7f 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -596,9 +596,6 @@ static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_camera_device,
 	&ams_delta_audio_device,
 	&ams_delta_serio_device,
-};
-
-static struct platform_device *late_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
 	&cx20442_codec_device,
@@ -607,9 +604,6 @@ static struct platform_device *late_devices[] __initdata = {
 static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
 	&ams_delta_audio_gpio_table,
 	&keybrd_pwr_gpio_table,
-};
-
-static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
 	&ams_delta_lcd_gpio_table,
 	&ams_delta_nand_gpio_table,
 };
@@ -713,6 +707,8 @@ static void __init ams_delta_init(void)
 	ams_delta_audio_gpio_table.dev_id =
 			dev_name(&ams_delta_audio_device.dev);
 	keybrd_pwr_gpio_table.dev_id = dev_name(&keybrd_pwr_device.dev);
+	ams_delta_nand_gpio_table.dev_id = dev_name(&ams_delta_nand_device.dev);
+	ams_delta_lcd_gpio_table.dev_id = dev_name(&ams_delta_lcd_device.dev);
 
 	/*
 	 * Once GPIO lookup tables are populated with dev_names, register them.
@@ -836,20 +832,6 @@ static int __init ams_delta_gpio_init(void)
 }
 device_initcall_sync(ams_delta_gpio_init);
 
-static void __init ams_delta_late_devices(void)
-{
-	platform_add_devices(late_devices, ARRAY_SIZE(late_devices));
-
-	/*
-	 * As soon as devices have been registered, assign their dev_names
-	 * to respective GPIO lookup tables before they are added.
-	 */
-	ams_delta_lcd_gpio_table.dev_id = dev_name(&ams_delta_lcd_device.dev);
-	ams_delta_nand_gpio_table.dev_id = dev_name(&ams_delta_nand_device.dev);
-
-	gpiod_add_lookup_tables(late_gpio_tables, ARRAY_SIZE(late_gpio_tables));
-}
-
 static int __init modem_nreset_init(void)
 {
 	int err;
@@ -894,8 +876,6 @@ static int __init late_init(void)
 {
 	int err;
 
-	ams_delta_late_devices();
-
 	err = modem_nreset_init();
 	if (err)
 		return err;
-- 
2.16.4

