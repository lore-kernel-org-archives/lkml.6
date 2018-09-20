Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BF6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB5921546
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tP9Keeep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB5921546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbeIUCdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:33:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33113 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:33:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so9612944lfb.0;
        Thu, 20 Sep 2018 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6AmOpAih3BTiUaYr509Y9aCYj38/B8W3eJwNQe4cyQ=;
        b=tP9Keeep3Y76rRVk36RUbsUfhZvKa0YWbvZ9TC37yiM08b2gmgPMFcheoQEZKdQ4tT
         k0ZZ0sN/kewxe8EeoxiDkMEM4/zgKi+xGdd+RCC54vQK/ufI8nBeVPdeGE6V8kahWob5
         Kdk7Xa1ayzUBJ5g5EZmxaRYEv5LDO9GymN6NQsdtXZTJrLVpDX++g7liQXvYqQkjNiwg
         oDKPSqguFo5ZACG3L0Pi5Zdvx/3JOHdmJrlQ4DDTdcwM5jPviavpzGDDWobqxl8/neQ2
         753WTbEa6EJu+6wPGXBAsnPvPyyJQBEMePy8uBLDIyzm9GLfZKu2leS4CppG1ntyKH5L
         28HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B6AmOpAih3BTiUaYr509Y9aCYj38/B8W3eJwNQe4cyQ=;
        b=YHdXONSHis6i3sZKR3p4ngEE1oYhdV2MtcH+ZQjEna0wNsqvsdiQDLVFSZpchVk4L1
         OTCf2CI+SD8rabV3VxlqRXdAGLPkrcXMF9FsBUfsmYaM9lIUYCTf+VejjptJZLG26viI
         Y8gDyZAWa0Cl/2SqwI6dWaQ0QQshhTOJQFEZe/BiMUsEJDHevi1/uUBlVHwM8PziuMsM
         1XhHFKpZ0gmI6HL01pnKukTvA9e06rEGDiAAa/JeNG8m0nAh2KgJXNVh+7i2dqeqJeyt
         uJ2Nmzrnkr27LYpRcD5fDXUWrXXlYVQdLrlCQguhRWV1+qtAcXMRE74eCczq62NgVxX0
         GdEQ==
X-Gm-Message-State: APzg51Cf3mj92Mph1X47O80o97Tyszgth/AN5jYZFtJc8wx4K1jyhO4+
        75mT7KUMAHBz9D9neZ4b0GQ=
X-Google-Smtp-Source: ANB0VdbWbfx4BZABM/arDgGAC9egYGAC0cM8qlNnTkQ3TaPoHsfVEv6vVbGSkvyuYp2eFZ9bpTpFJg==
X-Received: by 2002:a19:5311:: with SMTP id h17-v6mr9518718lfb.24.1537476482881;
        Thu, 20 Sep 2018 13:48:02 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p4-v6sm1821609lfj.49.2018.09.20.13.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:48:01 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v4 6/7] [media] ad5820: Add support for ad5821 and ad5823
Date:   Thu, 20 Sep 2018 22:47:50 +0200
Message-Id: <20180920204751.29117-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
References: <20180920204751.29117-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, both AD5821 and AD5820 share a compatible
register-set:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5821.pdf

Some camera modules also refer that AD5823 is a replacement of AD5820:
https://download.kamami.com/p564094-OV8865_DS.pdf

Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/media/i2c/ad5820.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 5d1185e7f78d..c52af302d516 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -34,8 +34,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 
-#define AD5820_NAME		"ad5820"
-
 /* Register definitions */
 #define AD5820_POWER_DOWN		(1 << 15)
 #define AD5820_DAC_SHIFT		4
@@ -368,7 +366,9 @@ static int ad5820_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad5820_id_table[] = {
-	{ AD5820_NAME, 0 },
+	{ "ad5820", 0 },
+	{ "ad5821", 0 },
+	{ "ad5823", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
@@ -376,6 +376,8 @@ MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 #ifdef CONFIG_OF
 static const struct of_device_id ad5820_of_table[] = {
 	{ .compatible = "adi,ad5820" },
+	{ .compatible = "adi,ad5821" },
+	{ .compatible = "adi,ad5823" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5820_of_table);
@@ -384,6 +386,8 @@ MODULE_DEVICE_TABLE(of, ad5820_of_table);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id ad5820_acpi_ids[] = {
 	{ "AD5820" },
+	{ "AD5821" },
+	{ "AD5823" },
 	{ }
 };
 
@@ -394,7 +398,7 @@ static SIMPLE_DEV_PM_OPS(ad5820_pm, ad5820_suspend, ad5820_resume);
 
 static struct i2c_driver ad5820_i2c_driver = {
 	.driver		= {
-		.name	= AD5820_NAME,
+		.name	= "ad5820",
 		.pm	= &ad5820_pm,
 		.of_match_table = of_match_ptr(ad5820_of_table),
 		.acpi_match_table = ACPI_PTR(ad5820_acpi_ids),
-- 
2.18.0

