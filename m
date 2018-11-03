Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14109C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 11:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33662081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 11:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIo5xi0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33662081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeKCUTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 16:19:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39706 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeKCUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 16:19:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id n11-v6so2196460pfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t9C81RwPS1YRNUkfpCWevzzTROpytImJV9oU41MWKJI=;
        b=RIo5xi0kPRrd8ZZ9MwMzbQWMBV8dbffSGWRyw4grY8PUHtTBGbFsMIQ3EbhtDdNOZr
         Do6XSTWfJSosZ9ew6rOdrsh62Gc9M/tlN2B98ueey614p4fn8oCy/3OwzfDiQMhWPTyB
         EbmJMftXR2ymZz9fHSWnnPZyHhf4PxUafk9rOd16+SvZOO2EsDRO5W2Sak7XrrKBAeGn
         3jfRjYbTpXsLBtntSD/LTQh6mSfMzKifDtOhiXIV1GooJ1n55hs5/VktZcMWzXcWo5T3
         g8r97pIsB9QpiDCLgZrLCbTAkDiMPogDTYgOXsQWey66EZBJ0BiIZ/TDZW66qajMsyQU
         11Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t9C81RwPS1YRNUkfpCWevzzTROpytImJV9oU41MWKJI=;
        b=REqZTNIg2oajiKhlnrpmWl4bBxrl8h1cwPpTymdIbYMHL0OdCUUA8ojY1StO4oi9Ze
         ErMkAgz87fLWUAyok2EAkD8bti21tYOLMa9FgoDTFn0GZ9LdRKB4Id/iFDvPndNxuuQO
         Mb33KMaIef4KNK9yqZpWcb9T5Rs9K7nqAJNy4d3SqDaTZSde2vT8w6q3fzAY4Kjozgdu
         BSIYWcCYoxsr0L94v+TX/d933+KXeB7NAzh4YHlsgGaBAxqiysU68MSM6ojqETluS4vf
         FzQNSstf35HyeKr1+lqxKS7TnSZBNngrMgBSpkQiB2vZoKBRd1ttH3Iro2LPaTiWs4tz
         ljng==
X-Gm-Message-State: AGRZ1gKE4FiMnQDpAQfHKYUKAj3rrmsguq0VBXBhFueJSeFzIW3CYqYv
        mwvwK4TEdeQf0csP5AcK5Ig94Y2q2jKfaA==
X-Google-Smtp-Source: AJdET5cE0a59DyaVuv9S9+ZdxqeY1qdVh8coT7uqnZrXeEe4xSvqyZ3eV+a37UMz1n5Eu5YnLRHW9g==
X-Received: by 2002:a63:2356:: with SMTP id u22-v6mr13821004pgm.122.1541243292513;
        Sat, 03 Nov 2018 04:08:12 -0700 (PDT)
Received: from nishad ([2401:4900:1889:2092:f92c:a396:b10a:3087])
        by smtp.gmail.com with ESMTPSA id u19-v6sm52336731pfj.115.2018.11.03.04.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 04:08:12 -0700 (PDT)
Date:   Sat, 3 Nov 2018 16:38:05 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the gpio
 descriptor interface
Message-ID: <20181103110759.GA31507@nishad>
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
---
Changes in v2:
 - Resolve a few compilation errors.
 - Add a level of indirection to read and write gpios.
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c | 89 +++++++++++-----------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
index ff145d493e1b..29b93897ccae 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -11,35 +11,50 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cs5535.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <asm/olpc.h>
 
 #include "olpc_dcon.h"
 
+enum dcon_gpios {
+	DCON_STAT0,
+	DCON_STAT1,
+	DCON_IRQ,
+	DCON_LOAD,
+	DCON_BLANK,
+};
+
+struct dcon_gpio {
+	const char *name;
+	unsigned long flags;
+};
+
+static const struct dcon_gpio gpios_asis[] = {
+	[DCON_STAT0] = { .name = "dcon_stat0", .flags = GPIO_ASIS },
+	[DCON_STAT1] = { .name = "dcon_stat1", .flags = GPIO_ASIS },
+	[DCON_IRQ] = { .name = "dcon_irq", .flags = GPIO_ASIS },
+	[DCON_LOAD] = { .name = "dcon_load", .flags = GPIO_ASIS },
+	[DCON_BLANK] = { .name = "dcon_blank", .flag = GPIO_ASIS },
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
+		gpios[i] = devm_gpiod_get(&dcon->client->dev, pin[i]->name,
+					  pin[i]->flags);
+		if (IS_ERR(gpios[i])) {
+			ret = PTR_ERR(gpios[i]);
+			pr_err("failed to request %s GPIO: %d\n", pin[i]->name,
+			       ret);
+			return ret;
+		}
 	}
 
 	/* Turn off the event enable for GPIO7 just to be safe */
@@ -61,12 +76,12 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
 	dcon->pending_src = dcon->curr_src;
 
 	/* Set the directions for the GPIO pins */
-	gpio_direction_input(OLPC_GPIO_DCON_STAT0);
-	gpio_direction_input(OLPC_GPIO_DCON_STAT1);
-	gpio_direction_input(OLPC_GPIO_DCON_IRQ);
-	gpio_direction_input(OLPC_GPIO_DCON_BLANK);
-	gpio_direction_output(OLPC_GPIO_DCON_LOAD,
-			      dcon->curr_src == DCON_SOURCE_CPU);
+	gpiod_direction_input(gpios[DCON_STAT0]);
+	gpiod_direction_input(gpios[DCON_STAT1]);
+	gpiod_direction_input(gpios[DCON_IRQ]);
+	gpiod_direction_input(gpios[DCON_BLANK]);
+	gpiod_direction_output(gpios[DCON_LOAD],
+			       dcon->curr_src == DCON_SOURCE_CPU);
 
 	/* Set up the interrupt mappings */
 
@@ -84,7 +99,7 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
 	/* Register the interrupt handler */
 	if (request_irq(DCON_IRQ, &dcon_interrupt, 0, "DCON", dcon)) {
 		pr_err("failed to request DCON's irq\n");
-		goto err_req_irq;
+		return -EIO;
 	}
 
 	/* Clear INV_EN for GPIO7 (DCONIRQ) */
@@ -125,18 +140,6 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
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
@@ -180,13 +183,13 @@ static void dcon_wiggle_xo_1(void)
 
 static void dcon_set_dconload_1(int val)
 {
-	gpio_set_value(OLPC_GPIO_DCON_LOAD, val);
+	gpiod_set_value(gpios[DCON_LOAD], val);
 }
 
 static int dcon_read_status_xo_1(u8 *status)
 {
-	*status = gpio_get_value(OLPC_GPIO_DCON_STAT0);
-	*status |= gpio_get_value(OLPC_GPIO_DCON_STAT1) << 1;
+	*status = gpiod_get_value(gpios[DCON_STAT0]);
+	*status |= gpiod_get_value(gpios[DCON_STAT1]) << 1;
 
 	/* Clear the negative edge status for GPIO7 */
 	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_NEGATIVE_EDGE_STS);
-- 
2.17.1

