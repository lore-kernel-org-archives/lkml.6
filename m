Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784E1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B542086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGOmxlP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B542086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeKGWTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:19:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39002 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:19:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so7290409pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 04:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=euAPtF5QankM66nnRvSjerWX0WPzKv2MbQqo7hxGLRQ=;
        b=bGOmxlP/DO5+t8APTrNLtZtRnEzUUquvWjXQdQyiljZLvmX/0mQ18KG+ygz8g24mwd
         coLOsp7wZmBNJNj0IsWeT794le7NCyZsuENSvImaFbRi94O0WWDemhrR1EVSxOvXVXbd
         lc7uuMFiJf7Iv/gO3SisWVBn0tdYL2Yn6iUEDNRQibgQ0X6E7kbVPqetrb4TlWvscO/9
         Nzs/UUglqPBycFQxRhcaso74gEAk47FrU/Ng6XLdMlY9QVevUE6fmSnM18yC0hBlqS9g
         KQV0MD1HB/tXfi5UalPJCV4uL+o7RXxW1GVvEPI62RIseqOnccV2QQ3Sop2mTFMv7fUP
         r+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=euAPtF5QankM66nnRvSjerWX0WPzKv2MbQqo7hxGLRQ=;
        b=MDHwoXsHOQHUMj+ESNPPzZuBqSigefY0OKUMKuf8D9KS5OsBl5gEv6Wj7E60XhAk4i
         VHsSMYTG7q1yTQl4vEBCWmfOQIR3QpL+3DX7a+siHdVz/3Uw427sErE5u7ZQtC5fBVXU
         5Lmkkm+xm8ZkW9wOuWMsHGn1x4rkTSpWlOnKoY6ukj82o/znOij97giDvn0/yym3A06W
         wdRdpC62RjSpNIi0yiqy16WBz9N5tdEl3p3/EPRI+cjhqad5YgY5WKk3QQJVh7y0seqx
         gS6vXP1LpqQgHY3AYLKw3BfOBXpZ1XMo6el2N9VsyGVBEieEvxMN1PkwmFDuHSJl2Fob
         fjtA==
X-Gm-Message-State: AGRZ1gIIEcLZObXrZ5zt8C9b4sjWCC7hjW9Vq4LZU2f8Tmucy8piYbEj
        eZ4pXIBM40UgE6P+Nd5wKgg=
X-Google-Smtp-Source: AJdET5fYNtesTlYduJbnb8AAXmJQkh4PyCC7OQgjvOx/hcVoBoIRGUv5QhvzHRhq5ST7nzHKq2GHpQ==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr84501pgb.56.1541594945318;
        Wed, 07 Nov 2018 04:49:05 -0800 (PST)
Received: from nishad ([2401:4900:1880:5d72:7998:219b:665e:21b1])
        by smtp.gmail.com with ESMTPSA id m5-v6sm1260856pfc.188.2018.11.07.04.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 04:49:04 -0800 (PST)
Date:   Wed, 7 Nov 2018 18:18:54 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the gpio
 descriptor interface
Message-ID: <20181107124849.GA21899@nishad>
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
Changes in v4:
 - Move changelog after signed-off line.
Changes in v3:
 - Resolve a few compilation errors.
Changes in v2:
 - Resolve a few compilation errors.
 - Add a level of indirection to read and write gpios.
---
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c | 90 +++++++++++-----------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
index ff145d493e1b..80b8d4153414 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -11,35 +11,51 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cs5535.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
 #include <asm/olpc.h>
 
 #include "olpc_dcon.h"
 
+enum dcon_gpios {
+	OLPC_DCON_STAT0,
+	OLPC_DCON_STAT1,
+	OLPC_DCON_IRQ,
+	OLPC_DCON_LOAD,
+	OLPC_DCON_BLANK,
+};
+
+struct dcon_gpio {
+	const char *name;
+	unsigned long flags;
+};
+
+static const struct dcon_gpio gpios_asis[] = {
+	[OLPC_DCON_STAT0] = { .name = "dcon_stat0", .flags = GPIOD_ASIS },
+	[OLPC_DCON_STAT1] = { .name = "dcon_stat1", .flags = GPIOD_ASIS },
+	[OLPC_DCON_IRQ] = { .name = "dcon_irq", .flags = GPIOD_ASIS },
+	[OLPC_DCON_LOAD] = { .name = "dcon_load", .flags = GPIOD_ASIS },
+	[OLPC_DCON_BLANK] = { .name = "dcon_blank", .flags = GPIOD_ASIS },
+};
+
+struct gpio_desc *gpios[5];
+
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
+	struct dcon_gpio *pin = &gpios_asis[0];
+
+	for (i = 0; i < ARRAY_SIZE(gpios_asis); i++) {
+		gpios[i] = devm_gpiod_get(&dcon->client->dev, pin[i].name,
+					  pin[i].flags);
+		if (IS_ERR(gpios[i])) {
+			ret = PTR_ERR(gpios[i]);
+			pr_err("failed to request %s GPIO: %d\n", pin[i].name,
+			       ret);
+			return ret;
+		}
 	}
 
 	/* Turn off the event enable for GPIO7 just to be safe */
@@ -61,12 +77,12 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
 	dcon->pending_src = dcon->curr_src;
 
 	/* Set the directions for the GPIO pins */
-	gpio_direction_input(OLPC_GPIO_DCON_STAT0);
-	gpio_direction_input(OLPC_GPIO_DCON_STAT1);
-	gpio_direction_input(OLPC_GPIO_DCON_IRQ);
-	gpio_direction_input(OLPC_GPIO_DCON_BLANK);
-	gpio_direction_output(OLPC_GPIO_DCON_LOAD,
-			      dcon->curr_src == DCON_SOURCE_CPU);
+	gpiod_direction_input(gpios[OLPC_DCON_STAT0]);
+	gpiod_direction_input(gpios[OLPC_DCON_STAT1]);
+	gpiod_direction_input(gpios[OLPC_DCON_IRQ]);
+	gpiod_direction_input(gpios[OLPC_DCON_BLANK]);
+	gpiod_direction_output(gpios[OLPC_DCON_LOAD],
+			       dcon->curr_src == DCON_SOURCE_CPU);
 
 	/* Set up the interrupt mappings */
 
@@ -84,7 +100,7 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
 	/* Register the interrupt handler */
 	if (request_irq(DCON_IRQ, &dcon_interrupt, 0, "DCON", dcon)) {
 		pr_err("failed to request DCON's irq\n");
-		goto err_req_irq;
+		return -EIO;
 	}
 
 	/* Clear INV_EN for GPIO7 (DCONIRQ) */
@@ -125,18 +141,6 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
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
@@ -180,13 +184,13 @@ static void dcon_wiggle_xo_1(void)
 
 static void dcon_set_dconload_1(int val)
 {
-	gpio_set_value(OLPC_GPIO_DCON_LOAD, val);
+	gpiod_set_value(gpios[OLPC_DCON_LOAD], val);
 }
 
 static int dcon_read_status_xo_1(u8 *status)
 {
-	*status = gpio_get_value(OLPC_GPIO_DCON_STAT0);
-	*status |= gpio_get_value(OLPC_GPIO_DCON_STAT1) << 1;
+	*status = gpiod_get_value(gpios[OLPC_DCON_STAT0]);
+	*status |= gpiod_get_value(gpios[OLPC_DCON_STAT1]) << 1;
 
 	/* Clear the negative edge status for GPIO7 */
 	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_NEGATIVE_EDGE_STS);
-- 
2.17.1

