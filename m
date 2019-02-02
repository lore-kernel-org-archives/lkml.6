Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C012DC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910EA20869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McbOK6zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBBPSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:18:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37062 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfBBPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:18:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so8309721ljd.4;
        Sat, 02 Feb 2019 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9XW8JHW2HMbnk4KsLSLzGop36qwVdtujfqQY6TQl2+I=;
        b=McbOK6zBwtCf8cTjIBRcBTLAl51psFnrnQXdF0/qtjdggbSzOmm1pvcDvB85hqqSHf
         Ot2Jak4k3ffEzZNe/O2TpE0Lf9Iui3AK59GBBsYvXzAQSmdJWq3ef/kiaXT4jC6uW4HM
         WF37g7LHMJhrZpwYDFL8soVqxLBHGdaaOGNp4C1ZRH2VjNg6IXqcLfz4qOjQs1/DeW8y
         wkSOoJsmlk/pbfCHqfTjtRhlv6GQwZLKWU+YWDYDGYqvIfSYhSFRMHyFqxk7Lfxi2b+i
         tsbUOLGaVmOZH7GbHHLJ1VVCYrryHsjfuV12aHeXCR42LjTC6qutvbJGbOIXGo2t05qr
         gFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9XW8JHW2HMbnk4KsLSLzGop36qwVdtujfqQY6TQl2+I=;
        b=FnO3+TNx+Jctu5zs5KCZSjGl6YvewV5dmMAziylvl/JBaN4DDBIZI6obdu/lPro7YD
         xsEwWpdotJlAcdo4yIIRMAnNwP3H9Z+AU3yLIb8DmWyNfPyOgEvKEXWFI/BGvUP5ztl4
         nGd5nSri0B0l4kerHmbanULvsAlTdlWnar+HjlhosmVLayjdWUhhmFqTzlVpj/6kB19Q
         b4cvN4z6uPuCagcVaLTSQXG3e8+vtRmz8JEiwix81R1V8L5CI+C3O0+cdwPU8mCV2WF/
         Q3FAqiOvGSMu+14wy6oqeptZ+h134pS2AFyJJH54RNSlUFaHcCSs67E3sxxmufWaq4F9
         6FqQ==
X-Gm-Message-State: AJcUukfraWDFMouDzkpF7sTm8P9X27mgNU3+ujLxieBSIvOOrOUxjyvI
        xZcFi0sukAjvAEuqwusucLLYYmVu
X-Google-Smtp-Source: ALg8bN6/JwnoEAMNUQdoz41uxTtdZj1UTPIe8xDA2nKeKkFnOJQvcm1Sy5mtsbjIx+Mbgu7hYer+3g==
X-Received: by 2002:a2e:9944:: with SMTP id r4-v6mr34837257ljj.185.1549120693264;
        Sat, 02 Feb 2019 07:18:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1863245ljj.48.2019.02.02.07.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:18:12 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] input: misc: bma150: Use managed resources helpers
Date:   Sat,  2 Feb 2019 16:18:03 +0100
Message-Id: <20190202151806.9064-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

The driver can be cleaned up by using managed resource helpers

Changes from v1:
 - Correct devm input unregistering

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 44 ++++++++++---------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 1efcfdf9f8a8..79acaaf86b7e 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -471,7 +471,7 @@ static int bma150_register_input_device(struct bma150_data *bma150)
 	struct input_dev *idev;
 	int error;
 
-	idev = input_allocate_device();
+	idev = devm_input_allocate_device(&bma150->client->dev);
 	if (!idev)
 		return -ENOMEM;
 
@@ -482,10 +482,8 @@ static int bma150_register_input_device(struct bma150_data *bma150)
 	input_set_drvdata(idev, bma150);
 
 	error = input_register_device(idev);
-	if (error) {
-		input_free_device(idev);
+	if (error)
 		return error;
-	}
 
 	bma150->input = idev;
 	return 0;
@@ -496,7 +494,7 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 	struct input_polled_dev *ipoll_dev;
 	int error;
 
-	ipoll_dev = input_allocate_polled_device();
+	ipoll_dev = devm_input_allocate_polled_device(&bma150->client->dev);
 	if (!ipoll_dev)
 		return -ENOMEM;
 
@@ -511,10 +509,8 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 	bma150_init_input_device(bma150, ipoll_dev->input);
 
 	error = input_register_polled_device(ipoll_dev);
-	if (error) {
-		input_free_polled_device(ipoll_dev);
+	if (error)
 		return error;
-	}
 
 	bma150->input_polled = ipoll_dev;
 	bma150->input = ipoll_dev->input;
@@ -543,7 +539,8 @@ static int bma150_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	bma150 = kzalloc(sizeof(struct bma150_data), GFP_KERNEL);
+	bma150 = devm_kzalloc(&client->dev, sizeof(struct bma150_data),
+			      GFP_KERNEL);
 	if (!bma150)
 		return -ENOMEM;
 
@@ -556,7 +553,7 @@ static int bma150_probe(struct i2c_client *client,
 				dev_err(&client->dev,
 					"IRQ GPIO conf. error %d, error %d\n",
 					client->irq, error);
-				goto err_free_mem;
+				return error;
 			}
 		}
 		cfg = &pdata->cfg;
@@ -566,14 +563,14 @@ static int bma150_probe(struct i2c_client *client,
 
 	error = bma150_initialize(bma150, cfg);
 	if (error)
-		goto err_free_mem;
+		return error;
 
 	if (client->irq > 0) {
 		error = bma150_register_input_device(bma150);
 		if (error)
-			goto err_free_mem;
+			return error;
 
-		error = request_threaded_irq(client->irq,
+		error = devm_request_threaded_irq(&client->dev, client->irq,
 					NULL, bma150_irq_thread,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					BMA150_DRIVER, bma150);
@@ -581,13 +578,12 @@ static int bma150_probe(struct i2c_client *client,
 			dev_err(&client->dev,
 				"irq request failed %d, error %d\n",
 				client->irq, error);
-			input_unregister_device(bma150->input);
-			goto err_free_mem;
+			return error;
 		}
 	} else {
 		error = bma150_register_polled_device(bma150);
 		if (error)
-			goto err_free_mem;
+			return error;
 	}
 
 	i2c_set_clientdata(client, bma150);
@@ -595,28 +591,12 @@ static int bma150_probe(struct i2c_client *client,
 	pm_runtime_enable(&client->dev);
 
 	return 0;
-
-err_free_mem:
-	kfree(bma150);
-	return error;
 }
 
 static int bma150_remove(struct i2c_client *client)
 {
-	struct bma150_data *bma150 = i2c_get_clientdata(client);
-
 	pm_runtime_disable(&client->dev);
 
-	if (client->irq > 0) {
-		free_irq(client->irq, bma150);
-		input_unregister_device(bma150->input);
-	} else {
-		input_unregister_polled_device(bma150->input_polled);
-		input_free_polled_device(bma150->input_polled);
-	}
-
-	kfree(bma150);
-
 	return 0;
 }
 
-- 
2.17.1

