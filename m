Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AC2224DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ63TdOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AC2224DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeFUWmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:42:24 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40949 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeFUWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:20 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so6615562lfc.7;
        Thu, 21 Jun 2018 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F9ysB4Cbjshf6qs8F/TSKDs5HPuEza9KpDPqxVwbYiI=;
        b=OZ63TdOGsYWs0E+LXdd6tZH2lOr6B231rgRuHC1C3QzQbL3eb2p+Uzpza7LDb7cYmb
         k3xMSHFFPahxMnAJOZSDRaDgYw9lYHBmMHXa+9tVOQI5JCOUOgwl5GksvdjKuto0izjF
         iCjiunwnC5qls8Fs1a7XS4eH/9BYPummtvY1cHyeaXgT0j23jore92BS3zt+4f3/u6f9
         bi6qWR3cd9DQ8ByK7RDJ9raO4dHFFgTErwvPZRZ6mJmj9KIrt/qKgt4EIfww1LB9W4ga
         pcRI7TMtpV3rdN2sTzGpk8qAbUZmWbO4/3bra6PdeebFbwFiAdsF77PX/LhD934Mj4aB
         P7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F9ysB4Cbjshf6qs8F/TSKDs5HPuEza9KpDPqxVwbYiI=;
        b=rrPdrGNOGSy0VRXExyRRIC+ie2TiCKRp1EqwM+WF2i7OIS/JS97imEugUPfE7t9Dh6
         AfoOt7LOJoLuTR11bpQW0++SWpkex1nr4shdnppVQPQM5fwTzSGpCfblkl4Sk+/4TFH6
         3bGaPP4p0Tu8GHpJgtkeeYBF6LjxNeMRl866AlWIhrNj0tdtZj3ZIig0K70yqRsYZTJf
         BYuIbzmkBYEvBj1fBQpTZEFT+jjKmK80LZUAklF8OXs64LaOSpdBwJV4LJJzXgOCGPFA
         CqvdhURk+vCb5aAOcJucnuOFYpzIXGTiESUmU39vaxxLbn+1sNgbKUIavU9q9P04irQh
         SCyw==
X-Gm-Message-State: APt69E2OSB9ZnaBIHCxQf+/S2q6kS71RWz/QgiVSitv7OVOLko1gnOm6
        yNJFOnbjas07UrXvzuAEhrI=
X-Google-Smtp-Source: ADUXVKIY+2irZ6fsf5HEpPI5zpFO8DzpyrQZXGtO/O4WG/4cLNt3TrQ0UnOOKcyeEyuyrjK4J+BJog==
X-Received: by 2002:a19:99c7:: with SMTP id b190-v6mr5672867lfe.53.1529620938296;
        Thu, 21 Jun 2018 15:42:18 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:42:17 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 03/10] Input: ams_delta_serio: use private structure
Date:   Fri, 22 Jun 2018 00:41:21 +0200
Message-Id: <20180621224128.17623-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver private structure and allocate it on device probe.
For now, use it instead of a static variable for storing a pointer to
serio structure.  Subsequent patches will populate it with more members
as needed.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

 drivers/input/serio/ams_delta_serio.c | 69 ++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index a2a7fa19bf49..551a4fa73fe4 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -37,17 +37,17 @@ MODULE_AUTHOR("Matt Callow");
 MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
 MODULE_LICENSE("GPL");
 
-static struct serio *ams_delta_serio;
+struct ams_delta_serio {
+	struct serio *serio;
+};
 
-static int check_data(int data)
+static int check_data(struct serio *serio, int data)
 {
 	int i, parity = 0;
 
 	/* check valid stop bit */
 	if (!(data & 0x400)) {
-		dev_warn(&ams_delta_serio->dev,
-				"invalid stop bit, data=0x%X\n",
-				data);
+		dev_warn(&serio->dev, "invalid stop bit, data=0x%X\n", data);
 		return SERIO_FRAME;
 	}
 	/* calculate the parity */
@@ -57,9 +57,9 @@ static int check_data(int data)
 	}
 	/* it should be odd */
 	if (!(parity & 0x01)) {
-		dev_warn(&ams_delta_serio->dev,
-				"parity check failed, data=0x%X parity=0x%X\n",
-				data, parity);
+		dev_warn(&serio->dev,
+			 "parity check failed, data=0x%X parity=0x%X\n", data,
+			 parity);
 		return SERIO_PARITY;
 	}
 	return 0;
@@ -67,6 +67,7 @@ static int check_data(int data)
 
 static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 {
+	struct ams_delta_serio *priv = dev_id;
 	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
 	int data, dfl;
 	u8 scancode;
@@ -84,9 +85,9 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
 			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
 
-		dfl = check_data(data);
+		dfl = check_data(priv->serio, data);
 		scancode = (u8) (data >> 1) & 0xFF;
-		serio_interrupt(ams_delta_serio, scancode, dfl);
+		serio_interrupt(priv->serio, scancode, dfl);
 	}
 	return IRQ_HANDLED;
 }
@@ -130,21 +131,14 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 
 static int ams_delta_serio_init(struct platform_device *pdev)
 {
+	struct ams_delta_serio *priv;
+	struct serio *serio;
 	int err;
 
-	ams_delta_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!ams_delta_serio)
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	ams_delta_serio->id.type = SERIO_8042;
-	ams_delta_serio->open = ams_delta_serio_open;
-	ams_delta_serio->close = ams_delta_serio_close;
-	strlcpy(ams_delta_serio->name, "AMS DELTA keyboard adapter",
-			sizeof(ams_delta_serio->name));
-	strlcpy(ams_delta_serio->phys, dev_name(&pdev->dev),
-			sizeof(ams_delta_serio->phys));
-	ams_delta_serio->dev.parent = &pdev->dev;
-
 	err = gpio_request_array(ams_delta_gpios,
 				ARRAY_SIZE(ams_delta_gpios));
 	if (err) {
@@ -154,7 +148,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
-			DRIVER_NAME, 0);
+			DRIVER_NAME, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
 		goto gpio;
@@ -167,21 +161,44 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			handle_simple_irq);
 
-	serio_register_port(ams_delta_serio);
-	dev_info(&ams_delta_serio->dev, "%s\n", ams_delta_serio->name);
+	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
+	if (!serio) {
+		err = -ENOMEM;
+		goto irq;
+	}
+
+	priv->serio = serio;
+
+	serio->id.type = SERIO_8042;
+	serio->open = ams_delta_serio_open;
+	serio->close = ams_delta_serio_close;
+	strlcpy(serio->name, "AMS DELTA keyboard adapter", sizeof(serio->name));
+	strlcpy(serio->phys, dev_name(&pdev->dev), sizeof(serio->phys));
+	serio->dev.parent = &pdev->dev;
+	serio->port_data = priv;
+
+	serio_register_port(serio);
+
+	platform_set_drvdata(pdev, priv);
+
+	dev_info(&serio->dev, "%s\n", serio->name);
 
 	return 0;
+
+irq:
+	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
 gpio:
 	gpio_free_array(ams_delta_gpios,
 			ARRAY_SIZE(ams_delta_gpios));
 serio:
-	kfree(ams_delta_serio);
 	return err;
 }
 
 static int ams_delta_serio_exit(struct platform_device *pdev)
 {
-	serio_unregister_port(ams_delta_serio);
+	struct ams_delta_serio *priv = platform_get_drvdata(pdev);
+
+	serio_unregister_port(priv->serio);
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
 	gpio_free_array(ams_delta_gpios,
 			ARRAY_SIZE(ams_delta_gpios));
-- 
2.16.4

