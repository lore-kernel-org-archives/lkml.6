Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B3EECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9D720824
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9w2YZKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9D720824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJ1NWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:22:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36690 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeJ1NWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:22:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so2323922pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 21:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZZ/r2HfK+AJe3bS7J8Q6wPTAgGD9LyrqVenBzMiWAPI=;
        b=C9w2YZKO/vk0B4D+CsBHD8GeaV7Bxuh4Svb/TRqTs05Y3KG7+kwg0NrIHaPZDH8Kib
         6JGOlT3NfDxtpNAeuiNdXVrzCoAAVDfgrgdoA40J5VAa/TndbkA4UW55yqYUrbVtqRg6
         Vv8/U22QkiJVfGbYeSdy/FGLBCePgDIq2refgeyLXVhhcN6m1MSkZpPV/Y2yZ1QUtiPH
         V65YpMdv/1zuVdOjM+9v6wFNwNAwRPUgnHlspJAeoJ4xrpvgYnGQgLP3FVjd6tik6ikr
         XHY6/5GtaLQpVWzpQ8F7aLqvR8ju4Nz7lrEPTamBdX80Aa6kABSIhZAdO58G8EHnrh75
         xtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZZ/r2HfK+AJe3bS7J8Q6wPTAgGD9LyrqVenBzMiWAPI=;
        b=AbE7gtP8586DQIXdbFwaDAk0hF7ZtoOhDd2VVIvki6OpKingM9a5mqjvQIN3oixnIU
         jtz5Dx8L+7sn+34SURm39yv2SI+dg6pZJVR7WNI8IKK8bobT5LcXl/L2nTV+iWzotEIo
         di+gLQPRjqyyZbHTr8G6JvBGm3VScq5lgf20LpV4RuuUgXwGxHR30E7lHHSjoE0TFxee
         V3eEFPvAiL7aijZN1bpwoOC/6z8Fm0RiEs6m05SXO+sHDk1306+zjArpnGIn4NdJ2wUT
         rUsIHACyoV86mcGhqLTHHju4Ws6IC0y4etFn9wShzFNClwLgaXWwn/4QZJenOoe9ORy/
         Nkdw==
X-Gm-Message-State: AGRZ1gLYW6YXCxghfroQMTIlOS9ZtsuMMy+WkOi36DYaxWiWOuMPRS2z
        ok+DoetmDx/L7IoZsEyRHHc=
X-Google-Smtp-Source: AJdET5dxNpLEspBIsHuKPWl1zeJhSJ5/SVevBm//0Hdc6BnLc+ZPZNCqJEbQ3R4BITCU4pakN7jz6g==
X-Received: by 2002:a63:e04d:: with SMTP id n13-v6mr9319624pgj.426.1540701547794;
        Sat, 27 Oct 2018 21:39:07 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id z14-v6sm20267626pfi.4.2018.10.27.21.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 21:39:07 -0700 (PDT)
Date:   Sun, 28 Oct 2018 10:09:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the gpio
 descriptor interface
Message-ID: <20181028043857.GA5200@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor
interface in olpc_dcon_xo_1.c.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.h      | 12 ++++
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c | 74 ++++++++++------------
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
index c987aaf894e7..6590d251eb6e 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.h
+++ b/drivers/staging/olpc_dcon/olpc_dcon.h
@@ -57,6 +57,18 @@
 /* Interrupt */
 #define DCON_IRQ                6
 
+struct dcon_gpio {
+	struct gpio_desc **ptr;
+	const char *name;
+	unsigned long flags;
+};
+
+struct gpio_desc *dcon_stat0;
+struct gpio_desc *dcon_stat1;
+struct gpio_desc *dcon_irq;
+struct gpio_desc *dcon_load;
+struct gpio_desc *dcon_blank;
+
 struct dcon_priv {
 	struct i2c_client *client;
 	struct fb_info *fbinfo;
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
index ff145d493e1b..83607efcb21f 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -11,7 +11,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cs5535.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <asm/olpc.h>
 
@@ -20,26 +20,29 @@
 static int dcon_init_xo_1(struct dcon_priv *dcon)
 {
 	unsigned char lob;
-
-	if (gpio_request(OLPC_GPIO_DCON_STAT0, "OLPC-DCON")) {
-		pr_err("failed to request STAT0 GPIO\n");
-		return -EIO;
-	}
-	if (gpio_request(OLPC_GPIO_DCON_STAT1, "OLPC-DCON")) {
-		pr_err("failed to request STAT1 GPIO\n");
-		goto err_gp_stat1;
-	}
-	if (gpio_request(OLPC_GPIO_DCON_IRQ, "OLPC-DCON")) {
-		pr_err("failed to request IRQ GPIO\n");
-		goto err_gp_irq;
-	}
-	if (gpio_request(OLPC_GPIO_DCON_LOAD, "OLPC-DCON")) {
-		pr_err("failed to request LOAD GPIO\n");
-		goto err_gp_load;
-	}
-	if (gpio_request(OLPC_GPIO_DCON_BLANK, "OLPC-DCON")) {
-		pr_err("failed to request BLANK GPIO\n");
-		goto err_gp_blank;
+	int ret, i;
+	struct dcon_gpio *pin;
+	unsigned long flags = GPIOD_ASIS;
+
+	struct dcon_gpio gpios[] = {
+		{ .ptr = &dcon_stat0, .name = "dcon_stat0", .flags = flags },
+		{ .ptr = &dcon_stat1, .name = "dcon_stat1", .flags = flags },
+		{ .ptr = &dcon_irq, .name = "dcon_irq", .flags = flags },
+		{ .ptr = &dcon_load, .name = "dcon_load", .flags = flags },
+		{ .ptr = &dcon_blank, .name = "dcon_blank", .flags = flags },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		pin = &gpios[i];
+		*pin->ptr = devm_gpiod_get(&dcon->bl_dev->dev, pin->name,
+					   pin->flags);
+		if (IS_ERR(*pin->ptr)) {
+			ret = PTR_ERR(*pin->ptr);
+			dev_err(&dcon->bl_dev->dev,
+				"failed to request %s GPIO: %d\n",
+				pin->name, ret);
+			return ret;
+		}
 	}
 
 	/* Turn off the event enable for GPIO7 just to be safe */
@@ -61,12 +64,11 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
 	dcon->pending_src = dcon->curr_src;
 
 	/* Set the directions for the GPIO pins */
-	gpio_direction_input(OLPC_GPIO_DCON_STAT0);
-	gpio_direction_input(OLPC_GPIO_DCON_STAT1);
-	gpio_direction_input(OLPC_GPIO_DCON_IRQ);
-	gpio_direction_input(OLPC_GPIO_DCON_BLANK);
-	gpio_direction_output(OLPC_GPIO_DCON_LOAD,
-			      dcon->curr_src == DCON_SOURCE_CPU);
+	gpiod_direction_input(dcon_stat0);
+	gpiod_direction_input(dcon_stat1);
+	gpiod_direction_input(dcon_irq);
+	gpiod_direction_input(dcon_blank);
+	gpiod_direction_output(dcon_load, dcon->curr_src == DCON_SOURCE_CPU);
 
 	/* Set up the interrupt mappings */
 
@@ -125,18 +127,6 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
 	cs5535_gpio_set(OLPC_GPIO_DCON_BLANK, GPIO_EVENTS_ENABLE);
 
 	return 0;
-
-err_req_irq:
-	gpio_free(OLPC_GPIO_DCON_BLANK);
-err_gp_blank:
-	gpio_free(OLPC_GPIO_DCON_LOAD);
-err_gp_load:
-	gpio_free(OLPC_GPIO_DCON_IRQ);
-err_gp_irq:
-	gpio_free(OLPC_GPIO_DCON_STAT1);
-err_gp_stat1:
-	gpio_free(OLPC_GPIO_DCON_STAT0);
-	return -EIO;
 }
 
 static void dcon_wiggle_xo_1(void)
@@ -180,13 +170,13 @@ static void dcon_wiggle_xo_1(void)
 
 static void dcon_set_dconload_1(int val)
 {
-	gpio_set_value(OLPC_GPIO_DCON_LOAD, val);
+	gpiod_set_value(dcon_load, val);
 }
 
 static int dcon_read_status_xo_1(u8 *status)
 {
-	*status = gpio_get_value(OLPC_GPIO_DCON_STAT0);
-	*status |= gpio_get_value(OLPC_GPIO_DCON_STAT1) << 1;
+	*status = gpiod_get_value(dcon_stat0);
+	*status |= gpiod_get_value(dcon_stat1) << 1;
 
 	/* Clear the negative edge status for GPIO7 */
 	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_NEGATIVE_EDGE_STS);
-- 
2.17.1

