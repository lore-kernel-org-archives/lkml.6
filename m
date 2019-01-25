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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C84C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15585218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8BvwZXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfAYSoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:44:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35492 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYSoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:44:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so9223890ljb.2;
        Fri, 25 Jan 2019 10:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjR22u6lXttFrgTMhVRfKccaiPxD9vLfGnMVFjSv2XU=;
        b=P8BvwZXEdIOsyfMTdW3Kc2ay1MYZg58UcxOkkTqdjOlmSmIImoWOXuk1RXpPBa+9Yg
         EL47gF97Yj/GJLKZvIU67r3IbNWhZekxDwZlrLQd3cpwcax9yAckOs8doXZcg9Ba8RF+
         jNHcM4f2d+RB/j/2zlO8AbNdg1/a12HnpFcLASQRU1e83iN+PwmCV9wJU6iifFhVEKiM
         c9zfntv0hWd36gNTDqL3T/qkZ/+qficOz6sxHryowZ7C0aL69M/9Lv4oekRcDUXWhCTc
         UsnUKTOnpTJqWTRcNbkrbpZHOYOxY5ujnhTKWLtxdy4HYK0bZ2EkGQH8RAlJgMoSNn80
         Dh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjR22u6lXttFrgTMhVRfKccaiPxD9vLfGnMVFjSv2XU=;
        b=Lu6mTfDr0YRts9o7FDffbL3yw38LY3oB9pNe6VwAjLO51RqdOnQ18Ei/b3U5WRHQ3/
         CAUpsylgBbQW8Il6HBwOjJoEQoHrjSEuoot8oqHu3WyHE6qz3g5nRA+fnsaEOKiLE/oT
         oip02iyHfu4zO2piqmx+9w4WAeIBOfsrEnlEz/uKsvEAi58nnhEM1LrA2iXXgS7KgbtS
         CBUJ09LKCIJRLQ1fIDp0lPkrD68DC0c0fNlHryummO3fhnFzNBO017T+53I8MlVRYmdj
         JWQMxkt3ThB+HMXfr73fqp5HT/wTi7QbKlAGjmzBc7jX0s+zgQKpFCpPeSnVIK5q7fpx
         s7nw==
X-Gm-Message-State: AJcUukc+sgDG6bsHNDEU4wR8lLSHXe5zTBtBCz5JDjt2ljAFY+d9UDHL
        jRigRYrGqwQRR+d1nmMZi0M=
X-Google-Smtp-Source: ALg8bN71rAUKpbv8V0UeQWmY89Ots8FBBPQEhcA5ZN8LXqId7cXUIo8Dhqqg9F4kq3/xSo39rL/u9A==
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr9852268ljj.161.1548441844952;
        Fri, 25 Jan 2019 10:44:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id f18sm1715432lfk.18.2019.01.25.10.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:44:04 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] input: misc: bma150: Use managed resources helpers
Date:   Fri, 25 Jan 2019 19:43:58 +0100
Message-Id: <20190125184400.17669-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

The driver can be cleaned up by using managed resource helpers

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 40 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 1efcfdf9f8a8..d101bb0a33d6 100644
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
@@ -582,12 +579,12 @@ static int bma150_probe(struct i2c_client *client,
 				"irq request failed %d, error %d\n",
 				client->irq, error);
 			input_unregister_device(bma150->input);
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
@@ -595,10 +592,6 @@ static int bma150_probe(struct i2c_client *client,
 	pm_runtime_enable(&client->dev);
 
 	return 0;
-
-err_free_mem:
-	kfree(bma150);
-	return error;
 }
 
 static int bma150_remove(struct i2c_client *client)
@@ -607,15 +600,10 @@ static int bma150_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 
-	if (client->irq > 0) {
-		free_irq(client->irq, bma150);
+	if (client->irq > 0)
 		input_unregister_device(bma150->input);
-	} else {
+	else
 		input_unregister_polled_device(bma150->input_polled);
-		input_free_polled_device(bma150->input_polled);
-	}
-
-	kfree(bma150);
 
 	return 0;
 }
-- 
2.17.1

