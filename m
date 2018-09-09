Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE7CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C268206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN53iw0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C268206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeIJHfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:35:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44811 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeIJHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:35:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so16141363lfb.11;
        Sun, 09 Sep 2018 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YK+Ty9TBR/rg1v0LhEVO8ANe8m53hJSFnx1eji2QoP8=;
        b=EN53iw0PmnRGJba9NmXxUq6PMSwOXj0JiGLHfTrvYUar0p+fI/8APzRLOV5GCt5/94
         AtkZ5Xb4OlYo7y0duCiIXvBKoeCzq5KgPBDJQQfabh7gCMONmUt52HMBLKwvPoklQ4EK
         DtHuCFT/8xNkfoEXYDtxT82vi7QGW7haBiBQc1gxBcvyqdT1rsHPwiFAACFwWIC6dOZf
         ftP7MC68XpcMscwVsorQpOWrogmZlTMmHrHW2S0zIY9qmCQPy9eS5TdNSnzl8oZ+XJXW
         QOA0IuIaECETLCl53X+jiAdYBOH+Dvry6cHuB5D/PnsNUPfHtTiDEhWiTGGKsmdkRt8l
         sTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YK+Ty9TBR/rg1v0LhEVO8ANe8m53hJSFnx1eji2QoP8=;
        b=LbegqxGlXMov5FATnHdhTfhippOQVT11Wz+94sniHMa30PeSDqMwm/k5JSZiY5kT3k
         WJ3CoPiIqtnsYhKeKjDY8fmgv69yRYjf98Zo485n9bTjiobSv/zq2RXJ+3Poe3I/tGtZ
         pOYSmGWG1gSdhUNR88aLhdyTvg9ZnwEnIcSLMLV7ouqZc4VaDP4X2DbrjQE+grmeLIPv
         aSFpuPufiljsXaR7qbKmoeu9uPEaHmPDBgma946c06SjOxHkzjpeKfJ2K+IVmWHB/6Mc
         Ybcr2239jlvC15tmh82/SoqRzKMXi2Lz20PVdCly7q/0HRqHRNWylew381NxcxSpPEBU
         4LEA==
X-Gm-Message-State: APzg51B273raRxYJGegos6V7jnHpm/Ebl2OoYwf5VFnOfVUCIAC7rN/Y
        /c7JtwdB09BgOQxrVB5OROPiIiFR
X-Google-Smtp-Source: ANB0VdZ4IFreTKtsWL0qZC/V1VJy38kZeAfN62FdlPzCgzLonaO72dEafv2Mu4fwRz4MHi1HyRuFnw==
X-Received: by 2002:a19:18d8:: with SMTP id 85-v6mr11225159lfy.133.1536536595002;
        Sun, 09 Sep 2018 16:43:15 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h4-v6sm2355373lfj.69.2018.09.09.16.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 16:43:14 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
Date:   Mon, 10 Sep 2018 01:44:17 +0200
Message-Id: <20180909234419.31261-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180909234419.31261-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180909234419.31261-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't request MODEM IRQ GPIO by its global number in
ams_delta_modem_init().  Instead, obtain its GPIO descriptor
and assign related IRQ to the MODEM.  Do that from
omap_gpio_deps_init(), where the chip is already looked up.  Then, in
ams_delta_modem_init(), just check for the IRQ number having been
already assigned.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 47 ++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 34cb63ff45b3..2b90b543c030 100644
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
@@ -898,7 +922,6 @@ static int __init late_init(void)
 
 unregister:
 	platform_device_unregister(&ams_delta_modem_device);
-	gpio_free(AMS_DELTA_GPIO_PIN_MODEM_IRQ);
 	return err;
 }
 
-- 
2.16.4

