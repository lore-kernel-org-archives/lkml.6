Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA6C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E51A218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmTuPevg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfAYRu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:50:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43005 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAYRux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:50:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so9084163lja.9;
        Fri, 25 Jan 2019 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtdKYC1cMTw55JdBBHfZAU6HnadYIoDV9dvqtWpcWmU=;
        b=YmTuPevgvOUOOi3z6+pZGPOUHjib4bWLNyYuxJHSgBDuI3rMPRzVgNrU+J4xMwEe45
         sieuQ+Ri/Dpf+zQmeHVGVQlBpz7b6nYpuv1urFWK1ciVkJGkXeyrg2t/EFNrgo6R5+DZ
         ji3SCuSqZM/QT2N6nkI5xxMMtl6Cvc9hV/Yjq/bW06P8YxobpQovPFT7C6H3FjV9Ezlt
         qJ7Zad53nqaKh0uFUPQ9eMi5ObbG+orBV6xA19IIy3nsWjCRynhlJ23teVf+A8JUpD4k
         7mXUiiyky4K5cpY7Bn50gJ2RPlgmo/UbwGhGAkYifGZxUUVd721o3N3LTmDrXJ4J3Z6O
         Fkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtdKYC1cMTw55JdBBHfZAU6HnadYIoDV9dvqtWpcWmU=;
        b=uj6RJuY7sNEYDVKXaAF5nyYG8AZgcnJb6kXIL9mgWRdKievCqfF7O7kKKJmAAxHnOT
         2sto9K4sbfNcXnm3w70FkM7XX3/6EIiJkunFNMTiPD1X1KwkXXf0lIYyY20G7vSkk6ks
         HvbaSMt1NJbe6fmm8YyLbcNepUIaciubmUnJzOJKxfMnX0e6rS/eEH9Nz2m7sAAk5GXO
         IeiodLIDBrkJfYsuafl+jgInm54Bi2BXL7gk3coSJg+f0ziOwNHhR9ULVZ1kzDCWXR0A
         lEk/b9a6ubngVkVberalMLRW9S8PVw5+NC59pL3j3w2+0gIjZ7aIPjIQ+TaYAjpExKti
         zoVg==
X-Gm-Message-State: AJcUukelC7zUyuVbPjzHT3oXkkGgof7JXFHiuiaANmGAi6BucptzEtw/
        Tr50J+XrMnpB33QYONpWIKk=
X-Google-Smtp-Source: ALg8bN7utHtsx0w25xuuxjDR2zwYT+EvDohrCfYoDgLuwVZ6gbTuMcYkjE/8YYvrs5EyVu/6NF9xKQ==
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr9608125ljb.119.1548438650620;
        Fri, 25 Jan 2019 09:50:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1575606ljj.48.2019.01.25.09.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:50:49 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/4] input: misc: gp2a: Use managed resource helpers
Date:   Fri, 25 Jan 2019 18:50:42 +0100
Message-Id: <20190125175045.22576-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Simplify cleanup of failures by using managed resource helpers

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/gp2ap002a00f.c | 37 ++++++++++---------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index c6a29e57b5e4..79c8c4c56d1a 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -138,14 +138,15 @@ static int gp2a_probe(struct i2c_client *client,
 			return error;
 	}
 
-	error = gpio_request_one(pdata->vout_gpio, GPIOF_IN, GP2A_I2C_NAME);
+	error = devm_gpio_request_one(&client->dev, pdata->vout_gpio,
+				      GPIOF_IN, GP2A_I2C_NAME);
 	if (error)
 		goto err_hw_shutdown;
 
-	dt = kzalloc(sizeof(struct gp2a_data), GFP_KERNEL);
+	dt = devm_kzalloc(&client->dev, sizeof(struct gp2a_data), GFP_KERNEL);
 	if (!dt) {
 		error = -ENOMEM;
-		goto err_free_gpio;
+		goto err_hw_shutdown;
 	}
 
 	dt->pdata = pdata;
@@ -153,12 +154,12 @@ static int gp2a_probe(struct i2c_client *client,
 
 	error = gp2a_initialize(dt);
 	if (error < 0)
-		goto err_free_mem;
+		goto err_hw_shutdown;
 
-	dt->input = input_allocate_device();
+	dt->input = devm_input_allocate_device(&client->dev);
 	if (!dt->input) {
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err_hw_shutdown;
 	}
 
 	input_set_drvdata(dt->input, dt);
@@ -171,19 +172,18 @@ static int gp2a_probe(struct i2c_client *client,
 
 	input_set_capability(dt->input, EV_SW, SW_FRONT_PROXIMITY);
 
-	error = request_threaded_irq(client->irq, NULL, gp2a_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-				IRQF_ONESHOT,
-			GP2A_I2C_NAME, dt);
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+			gp2a_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+			IRQF_ONESHOT, GP2A_I2C_NAME, dt);
 	if (error) {
 		dev_err(&client->dev, "irq request failed\n");
-		goto err_free_input_dev;
+		goto err_hw_shutdown;
 	}
 
 	error = input_register_device(dt->input);
 	if (error) {
 		dev_err(&client->dev, "device registration failed\n");
-		goto err_free_irq;
+		goto err_hw_shutdown;
 	}
 
 	device_init_wakeup(&client->dev, pdata->wakeup);
@@ -191,14 +191,6 @@ static int gp2a_probe(struct i2c_client *client,
 
 	return 0;
 
-err_free_irq:
-	free_irq(client->irq, dt);
-err_free_input_dev:
-	input_free_device(dt->input);
-err_free_mem:
-	kfree(dt);
-err_free_gpio:
-	gpio_free(pdata->vout_gpio);
 err_hw_shutdown:
 	if (pdata->hw_shutdown)
 		pdata->hw_shutdown(client);
@@ -210,12 +202,7 @@ static int gp2a_remove(struct i2c_client *client)
 	struct gp2a_data *dt = i2c_get_clientdata(client);
 	const struct gp2a_platform_data *pdata = dt->pdata;
 
-	free_irq(client->irq, dt);
-
 	input_unregister_device(dt->input);
-	kfree(dt);
-
-	gpio_free(pdata->vout_gpio);
 
 	if (pdata->hw_shutdown)
 		pdata->hw_shutdown(client);
-- 
2.17.1

