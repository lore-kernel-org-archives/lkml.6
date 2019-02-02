Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B7C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26A420856
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ345MV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfBBPSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:18:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37864 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfBBPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:18:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id n23so1898223lfl.4;
        Sat, 02 Feb 2019 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nAdENCgE82YRmVnjO7HwlMtyEtzqUQlTdhx3sh5cawA=;
        b=PZ345MV1cnqqS0Sv6kb4cxA8q1zO5C9BTMpCiNWPnh0pcMmvdL0Hj4aPZTmE7miXxL
         ADK1RiA/3AGxdWjQrXWaPNFj4epcJkK3hDcgQZI4uI61Kud+rCVRKc4ie+rANHI2SfuZ
         OcwT/TdrGyKHRLTl25UB5RqAZpNvu2fhEs/B43NX2GGRXUpBnESun1nswzvx6X5edm4A
         WAZ0T+pRigoQTy+NMhrpaKWx3cRJc6MalRBhDsY7xq73i4tw/JNzrnQmc9Fpo0TgoNlv
         vG4ZVCf+nhuXK36zmsEyXK4uhHVu3FZM/t4B82K5YvtP1lqMG1hCIcmUP3Mgc8nhMq9l
         1BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nAdENCgE82YRmVnjO7HwlMtyEtzqUQlTdhx3sh5cawA=;
        b=OkIRKLXUK6x8qtz3gKEzSTCB8dTkPqCkiW/SEnSHDX37s/fb+ILPXWtPYgYtlQMgOO
         2eMRVDvsVS4KjJ2TIsT+G05/e9tJGVuC1C5DQ2g7KlCTgwSjzCVamGrWE74KuNIj9K90
         3oP0TxENXzI1uUYu6ut6QDIsqjrsgb2zz05pCKpAoRQnQ+jGbWtVRp1hP+sX51yKeF/G
         tcV5iECx63WpIljBtwg+NLihI4AtyzXWL7Y2bPk9OHA3zuEGzM+CuRrATzyhwWwacXbm
         Nt/hHoE0v29k1JkAX9T3fpdsaUnPEs1weo+/Pqvdy28BbAshYWxhoc7jZ6sf8Z9z9tDX
         j/zQ==
X-Gm-Message-State: AJcUukd2/e/ezgHrf2Rv1LKDjdnmtEhaXk2QEDalFn6aVIGrsmHrEoV+
        ilb581zj1/rDc/apIhwoK9/0s8zd
X-Google-Smtp-Source: ALg8bN7ZTYoVwLu1/UZxVi8jxevtnRMMNgQaSU0Us9Jd9I299n7oL8q8AesdS3Vkq2KdGuvuTNcj7A==
X-Received: by 2002:a19:7111:: with SMTP id m17mr33772134lfc.64.1549120695968;
        Sat, 02 Feb 2019 07:18:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6cb2:9e25:2436:6eda])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1863245ljj.48.2019.02.02.07.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:18:15 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] input: misc: bma150: Drop platform data
Date:   Sat,  2 Feb 2019 16:18:05 +0100
Message-Id: <20190202151806.9064-5-pawel.mikolaj.chmiel@gmail.com>
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

bma150 supports DT now and as there are no in-kernel users of
the platform data, remove it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 27 +++++----------------------
 include/linux/bma150.h      |  5 -----
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index e86df79490ad..1cdc8ce97968 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -567,8 +567,6 @@ int bma150_cfg_from_of(struct device_node *np)
 static int bma150_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	const struct bma150_platform_data *pdata =
-			dev_get_platdata(&client->dev);
 	const struct bma150_cfg *cfg;
 	struct bma150_data *bma150;
 	int chip_id;
@@ -592,27 +590,12 @@ static int bma150_probe(struct i2c_client *client,
 
 	bma150->client = client;
 
-	if (pdata) {
-		if (pdata->irq_gpio_cfg) {
-			error = pdata->irq_gpio_cfg();
-			if (error) {
-				dev_err(&client->dev,
-					"IRQ GPIO conf. error %d, error %d\n",
-					client->irq, error);
-				return error;
-			}
-		}
-		cfg = &pdata->cfg;
-	} else if (client->dev.of_node) {
-		error = bma150_cfg_from_of(client->dev.of_node);
-		if (error) {
-			dev_err(&client->dev, "Failed to parse of data\n");
-			return error;
-		}
-		cfg = &default_cfg;
-	} else {
-		cfg = &default_cfg;
+	error = bma150_cfg_from_of(client->dev.of_node);
+	if (error) {
+		dev_err(&client->dev, "Failed to parse of data\n");
+		return error;
 	}
+	cfg = &default_cfg;
 
 	error = bma150_initialize(bma150, cfg);
 	if (error)
diff --git a/include/linux/bma150.h b/include/linux/bma150.h
index ad19dc7a30d7..650ffe9fa4cf 100644
--- a/include/linux/bma150.h
+++ b/include/linux/bma150.h
@@ -41,9 +41,4 @@ struct bma150_cfg {
 	u32 bandwidth;			/* one of BMA0150_BW_xxx */
 };
 
-struct bma150_platform_data {
-	struct bma150_cfg cfg;
-	int (*irq_gpio_cfg)(void);
-};
-
 #endif /* _BMA150_H_ */
-- 
2.17.1

