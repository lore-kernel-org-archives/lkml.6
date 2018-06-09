Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VxbSNGHeG1tUWAAAmS7hNA
	; Sat, 09 Jun 2018 14:04:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CF32E608BF; Sat,  9 Jun 2018 14:04:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOpHnwO6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 486E86074D;
	Sat,  9 Jun 2018 14:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 486E86074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeFIOEe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:04:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34477 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753376AbeFIODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:03:01 -0400
Received: by mail-lf0-f68.google.com with SMTP id o9-v6so24194978lfk.1;
        Sat, 09 Jun 2018 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cllgb48Ha6uWerR09aJv3S2+cDev6DG6WH9tvQJMi9w=;
        b=QOpHnwO66Pq5QbaGVTCZ23HmrHOOMH/RQYDROTSRT2/0KpwDX8M5eX0BiegT00QNG6
         x48ZTFSCx+dPC3bYpYhwseecLUGCl5VQz7meXN79XfEGujo2R1B25S2sG1ixsHITz1u6
         ONGIfl04vZGLQCMQrc08RsPsap2+skfIGlVZMZSnY5dwtl5uZ96bKrQlhbJndnLrBpLJ
         0ikrocrcKdWmGqlapZF6O4kqO9DDc1DD1tKdC+ViIXzu/VW11c5RXpr0MduGtWEJ8/Ys
         rpH8UoO2dO3U9ANiIVEF1prBCKl5DKNfNBLkoPRII3C2SwwIdb3FLmSbFrX+y1CgYQ6o
         ehNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cllgb48Ha6uWerR09aJv3S2+cDev6DG6WH9tvQJMi9w=;
        b=OCNNRQHLymC7QBbGVaVNm3OM7xQGx7XR6EhTIAtXB7vhCuLuSMIjT0qIShpQufkQwF
         r2efrjM71OsqkxISnhN/2/0FFOeBo01oAsZtUkSvtuazuyqmSS6DQfo1/F5OdBZuoQDV
         K7xCc4XnWfp3ErN6+9/yb2hTW3F+SwgEzCFLEwZuqNjUdzhwpX7Zx/d3gk0Bhz+km3+C
         gfcDTFiUwLRHYE+oXdKZaV1dYzjN00iTAmF28P6BCGvjVvSgToSrbS383VfNW2wIS6NB
         KoyYdBJTUDPBi9CaxTtb8U3mYP6L9/kl9vW+D9BlNR8N2u+teQ60aaj6jvY5Icyte9LC
         ADXg==
X-Gm-Message-State: APt69E1pVWhwugA56JeUXlsgbhrZIg70SVry6WxZQcXH8xPWXe5n8Uyd
        6MQXDeKJSf5CPe0ZyB+7EGk=
X-Google-Smtp-Source: ADUXVKLg8vI07CGiWyN8GwUv/qV9EhDp5kRn2lsVuCI+lf6shsWJ3n9OQ3ZRr9qgfm370FpbKJd4Sg==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr4877596ljj.49.1528552979402;
        Sat, 09 Jun 2018 07:02:59 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-40-98.dynamic.gprs.plus.pl. [31.0.40.98])
        by smtp.gmail.com with ESMTPSA id n84-v6sm4477727lfi.19.2018.06.09.07.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 07:02:58 -0700 (PDT)
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 05/10] ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin
Date: Sat,  9 Jun 2018 16:02:19 +0200
Message-Id: <20180609140224.32606-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"keybrd_dataout" GPIO pin used to be initialized by ams-delta-serio
driver to a state safe for ams-delta-serio device function and not
changed thereafter.  As such, it may be assumed not under the driver
control and responsibility for its initialization handed over to board
init file.

Introduce a GPIO hog table and take over control of the
"keybrd_dataout" GPIO pin from the ams-delta-serio driver.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 8 ++++++++
 drivers/input/serio/ams_delta_serio.c | 5 -----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 706eb2f9301d..2821284aa0c9 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -574,6 +574,12 @@ static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
 	&ams_delta_nand_gpio_table,
 };
 
+static struct gpiod_hog ams_delta_gpio_hogs[] = {
+	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
+		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
+	{},
+};
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -594,6 +600,8 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J19_1610_CAM_D6);
 	omap_cfg_reg(J18_1610_CAM_D7);
 
+	gpiod_add_hogs(ams_delta_gpio_hogs);
+
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index d48beab1d00d..0b4d5a952ecb 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -121,11 +121,6 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 		.flags	= GPIOF_DIR_IN,
 		.label	= "serio-clock",
 	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "serio-dataout",
-	},
 };
 
 static int ams_delta_serio_init(struct platform_device *pdev)
-- 
2.16.1
