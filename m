Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D520693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTUp1oDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885D520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGQRyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:54:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39330 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbeGQRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:54:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id a134-v6so1408168lfe.6;
        Tue, 17 Jul 2018 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i9wkBg7Hsu4Be5vqekATgyLF7+tVr2R69O6VYweQI5M=;
        b=LTUp1oDAEF5g4L+LKimE8yYLIpRg/xd/FIPiJoZ/QtKKPulL/MEwdsuE+uYpqc8+Cn
         CThURZqU5i1VLBvqUhe/XP+ALbJacGhPy6b6T1P34i8XMP3tANm8lm2gdUXorZE2j7zH
         cnB/SZQT3EpBc6m4j7HnURsUbDgf9aE+8eXvBWKBWEVP+bsQTaNWykTzb+y5bSbqvE6P
         QwnIztxY8zErTc7zPZrjE46ZwEq/LSlv9DHiRyAJy6VOifdpprMvesnIfFUQ6GOKPArC
         CUhTjfscdAXcdK0MQ+Xt5MzYZ/Rjr7ywRHqu9UvCzdBb4bq4VkENaK1227Cb/xK7Bs2j
         v6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i9wkBg7Hsu4Be5vqekATgyLF7+tVr2R69O6VYweQI5M=;
        b=P8md6fin3dDc193wcqRkMZHBGkD42+6PebiCpGTLKE5IgWoLEBZMeYNVrnpvRUv8gQ
         swWAy3WpJBIdn19bZR1uFTliamLCdhBn6pW8IOlQqLkq1QpPTSWrbudgjqBdkAP+/KUk
         xgFc4dGtvZJEM5/XDwUbzfvBPY6z3PQ0Gx5FBSnxuspmisvQDxv7sll9GzH5d2AAP/1M
         Jvd/H4MYK3EqkSePDKVhrYBZ1FWED8mVpiWQJ+mZUUzZKbmQB2qpFgi0lDwcrnWlZU0/
         1vyFFce0hRn4wxaRRI1G86dtdf00Mo8O0KM5+YsBya1B01Q3pUDBswsk/C5AMp5lO2GZ
         NL3A==
X-Gm-Message-State: AOUpUlGBYH99rtJcCFDMOGEuTGVHNVbJPMPRcMFYzy7os9XSwBoWMeHL
        BY4f3MpuLH39vdM+Z0w5HgQ=
X-Google-Smtp-Source: AAOMgpexACbEhSGbFleJ/AmDqCcZmqpB0OrVU1C+Wkbea9lyMagISJiGS8JhZxZpTicknFQfTUAJ1A==
X-Received: by 2002:a19:4b90:: with SMTP id y138-v6mr1772416lfa.118.1531848023784;
        Tue, 17 Jul 2018 10:20:23 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id j9-v6sm250086ljh.40.2018.07.17.10.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 10:20:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
Date:   Tue, 17 Jul 2018 19:20:56 +0200
Message-Id: <20180717172056.18472-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ams_delta_modem_init(), replace request for hardcoded GPIO and
assignment of related IRQ number to MODEM platform data with a check
for that number having already been assigned.  Then, from init_machine,
request MODEM IRQ GPIO descriptor by its GPIO chip hardware pin number
and assign related IRQ to the MODEM.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 46 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index dd28d2614d7f..9c376ac31e25 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -630,6 +630,28 @@ static struct gpiod_hog ams_delta_gpio_hogs[] = {
 	{},
 };
 
+static struct plat_serial8250_port ams_delta_modem_ports[];
+
+/*
+ * Obtain MODEM IRQ GPIO descriptor using its hardware pin
+ * number and assign related IRQ number to the MODEM port.
+ * Keep the GPIO descriptor open so nobody steps in.
+ */
+static void __init modem_assign_irq(struct gpio_chip *chip)
+{
+	struct gpio_desc *gpiod;
+
+	gpiod = gpiochip_request_own_desc(chip, AMS_DELTA_GPIO_PIN_MODEM_IRQ,
+					  "modem_irq");
+	if (IS_ERR(gpiod)) {
+		pr_err("%s: modem IRQ GPIO request failed (%ld)\n", __func__,
+		       PTR_ERR(gpiod));
+	} else {
+		gpiod_direction_input(gpiod);
+		ams_delta_modem_ports[0].irq = gpiod_to_irq(gpiod);
+	}
+}
+
 /*
  * The purpose of this function is to take care of proper initialization of
  * devices and data structures which depend on GPIO lines provided by OMAP GPIO
@@ -649,7 +671,13 @@ static void __init omap_gpio_deps_init(void)
 		return;
 	}
 
+	/*
+	 * Start with FIQ initialization as it may have to request
+	 * and release successfully each OMAP GPIO pin in turn.
+	 */
 	ams_delta_init_fiq(chip, &ams_delta_serio_device);
+
+	modem_assign_irq(chip);
 }
 
 static void __init ams_delta_init(void)
@@ -844,20 +872,18 @@ static int __init modem_nreset_init(void)
 }
 
 
+/*
+ * This function expects MODEM IRQ number already assigned to the port
+ * and fails if it's not.
+ */
 static int __init ams_delta_modem_init(void)
 {
 	int err;
 
-	omap_cfg_reg(M14_1510_GPIO2);
-	ams_delta_modem_ports[0].irq =
-			gpio_to_irq(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
+	if (ams_delta_modem_ports[0].irq < 0)
+		return ams_delta_modem_ports[0].irq;
 
-	err = gpio_request(AMS_DELTA_GPIO_PIN_MODEM_IRQ, "modem");
-	if (err) {
-		pr_err("Couldn't request gpio pin for modem\n");
-		return err;
-	}
-	gpio_direction_input(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
+	omap_cfg_reg(M14_1510_GPIO2);
 
 	/* Initialize the modem_nreset regulator consumer before use */
 	modem_priv.regulator = ERR_PTR(-ENODEV);
@@ -866,8 +892,6 @@ static int __init ams_delta_modem_init(void)
 			AMS_DELTA_LATCH2_MODEM_CODEC);
 
 	err = platform_device_register(&ams_delta_modem_device);
-	if (err)
-		gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 
 	return err;
 }
-- 
2.16.4

