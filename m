Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3AEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDCD2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/S8jBeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfBGG1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:27:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41539 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfBGG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:27:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so4328112pfi.8;
        Wed, 06 Feb 2019 22:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I83CQrxs0HTPbGxcBSWD2tbXcztOVId8PcT0t6IuLR0=;
        b=O/S8jBeuGFLPEoEz7rWDcAo7j/WryemRTInwQASdjLZALa4q1sswwTMkb1d53MI2E6
         xmFPL8YTw04pmzg6nrrGco03wNfnqtJkp5vcxtS/kH/cUZwsHenxPtnNsoZiC2z643/R
         d5VnFAmagvq9JLaV2UOInmzAc/Vwe21oIEzRoeAjHj8AgZSasVd0TbeHv91zZdwatU99
         knqeQA6xB6ujVsfmV6x82qB/16TtGEp/VaPGstPZvh9461HiUqkh4oRwlHrBFHks2kbM
         DqBU8tk39jiUT47ljqEerIYNy4EjIaVE6mTRAqs5r3g3NLPxt9NP3OrTfQGX8RfJ8eWY
         bNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I83CQrxs0HTPbGxcBSWD2tbXcztOVId8PcT0t6IuLR0=;
        b=Upg+Kx9a38F0+UIh4LoKprbb6pO4moKa4AJ0TnUKKuhs5zDYFaCBrq39JLb+TxBh2M
         wuUqkQeQqJBars1RJerJQWs2WUBG9vqr5wjWE6uAxhIzSMDILi8EL1MpVibn9HYmwemM
         abpXOA8iXKAUy5VX5MzWdlou6ByZcJRFknmdkkS85K2QSzYv6gV7eE32bW5x9qnk1ujJ
         DiL/FawhRCpGtZjHogHrHNhyMm7DmYdLgHnn7Ikl6wWEToZrXwCFxE6ZBxcYST9eR9FR
         bsvljpPxs4J2107wuAmLITxNHKpkKwfYf2fhC10mEy2JrE9164yGLYDGdxYrIDahlxk4
         TsHw==
X-Gm-Message-State: AHQUAuaJx59YmDSeuzNbvfW/PJpZZSPgNO1rKt1RtaizttaJPjhIweP5
        5gtVYr4x0sbf0TnYpS48mUa+JCr5
X-Google-Smtp-Source: AHgI3IYqZQayjmwpGFdb2mUS9rliXz4q33lSVKyhCbW7H9QPP0U+xb7KhWKHwuVP2gVKQYRSlseOlg==
X-Received: by 2002:a63:c444:: with SMTP id m4mr13467659pgg.310.1549520869680;
        Wed, 06 Feb 2019 22:27:49 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d3sm10200084pgl.64.2019.02.06.22.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 22:27:48 -0800 (PST)
Date:   Wed, 6 Feb 2019 22:27:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ili210x - switch to using devm_device_add_group()
Message-ID: <20190207062746.GA30406@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By switching to devm_device_add_group() we can complete driver conversion
to using managed resources and get rid of ili210x_i2c_remove().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ili210x.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 6cfe463ac118..af1dd9cff12a 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -376,7 +376,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&dev->kobj, &ili210x_attr_group);
+	error = devm_device_add_group(dev, &ili210x_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to create sysfs attributes, err: %d\n",
 			error);
@@ -386,7 +386,7 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 	error = input_register_device(priv->input);
 	if (error) {
 		dev_err(dev, "Cannot register input device, err: %d\n", error);
-		goto err_remove_sysfs;
+		return error;
 	}
 
 	device_init_wakeup(dev, 1);
@@ -396,17 +396,6 @@ static int ili210x_i2c_probe(struct i2c_client *client,
 		client->irq, firmware.id, firmware.major, firmware.minor);
 
 	return 0;
-
-err_remove_sysfs:
-	sysfs_remove_group(&dev->kobj, &ili210x_attr_group);
-	return error;
-}
-
-static int ili210x_i2c_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &ili210x_attr_group);
-
-	return 0;
 }
 
 static int __maybe_unused ili210x_i2c_suspend(struct device *dev)
@@ -454,7 +443,6 @@ static struct i2c_driver ili210x_ts_driver = {
 	},
 	.id_table = ili210x_i2c_id,
 	.probe = ili210x_i2c_probe,
-	.remove = ili210x_i2c_remove,
 };
 
 module_i2c_driver(ili210x_ts_driver);
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
