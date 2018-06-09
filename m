Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9qY5MQ/eG1tYUQAAmS7hNA
	; Sat, 09 Jun 2018 14:03:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 77AE9608FF; Sat,  9 Jun 2018 14:02:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9goHlsB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3CBF3608EA;
	Sat,  9 Jun 2018 14:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CBF3608EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeFIOCx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:02:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33436 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeFIOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:02:51 -0400
Received: by mail-lf0-f66.google.com with SMTP id y20-v6so24230674lfy.0;
        Sat, 09 Jun 2018 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cSGIAu+yPFYzl2tKjFSyAudgSsSy/f+rBZug1MC7D5Q=;
        b=T9goHlsBUeUCIQ18jmiyntUOufRm1V89//DWJ8YL/0Ymgsn8+au42NOpf7VJ7d09rw
         9WcBhKnh5UohEGNtwDsHdr5oLejleFNOxo7eKG6E6xf8UN1O0X66BJOMS39PfTvJRGtt
         BmDiEuaiWX26x6ZYZJB06Jh3zTdajH5foG2fIMsONllX9vx3WIDMXxhvXdBITSU6nsQc
         cNDL+0RxG4PF6z0ba6CpaBzSzrxpXXKYdCJhlSh9jGKMGvo5c+I7ct+AIlG08q7cz8Up
         RYDSsW1Kr7XwDHWmxZQjr6IbYY1Yj4zqjW3ft780aanBJKDknmHEjxFozZ/Iz8Hhs9IN
         BVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cSGIAu+yPFYzl2tKjFSyAudgSsSy/f+rBZug1MC7D5Q=;
        b=aoO1bKLwe87ZUH3YPSqe6+Y1rxScXp1SDDDQScbuwAKbxLiwGK2fe1HbF8GNu/wCqV
         M0duIya61PKJLiPyw5xdXn0Xrmujpv+otxOnumnNGLWgAs7Ttbmbctv6XLkAZL1XeWJr
         t9qCbZ9zCrfJZEWY8TBNdKk9NqE/17Qs0n87LLDp57wtgQw4vdZtXve9mShgWzgmL3n0
         KLnQugdF8CRSxt44M3V0ururrlKHVa3nY40j+1NB3ILJFF/plvVjU6JSIBs2QtkGObcD
         4TsB1aRKwqU7ADlzO9PlStdWNsk+//wP8m0i6dWb2ISnYhF5UHru804tYdN+Fw2xV07R
         /waw==
X-Gm-Message-State: APt69E0t2QsbnRQjx3YNwKqKdeuhQy2tr9dbk6OmYU3UBmxfQ65BX0r5
        wYJxxj5eTwb4Hutt0hJIVlc=
X-Google-Smtp-Source: ADUXVKJOqhM2HSjTlmi7MYQGcF6IufBrpEuFLt3JGN2PX+zOdZW8y2PxIxzUTbRiYYIJfVuM0qtw6A==
X-Received: by 2002:a2e:7c02:: with SMTP id x2-v6mr7290347ljc.71.1528552968999;
        Sat, 09 Jun 2018 07:02:48 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-40-98.dynamic.gprs.plus.pl. [31.0.40.98])
        by smtp.gmail.com with ESMTPSA id n84-v6sm4477727lfi.19.2018.06.09.07.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 07:02:48 -0700 (PDT)
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
Subject: [PATCH 03/10] Input: ams_delta_serio: use private structure
Date: Sat,  9 Jun 2018 16:02:17 +0200
Message-Id: <20180609140224.32606-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a driver private structure and allocate it on device probe.
For now, use it instead of a static variable for storing a pointer to
serio structure.  Subsequent patches will populate it with more members
as needed.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

# Conflicts:
#	drivers/input/serio/ams_delta_serio.c
---
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
2.16.1
