Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00341C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3093214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTX7PtUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3093214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbeKQJRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:17:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38796 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:17:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so4070770pfi.5;
        Fri, 16 Nov 2018 15:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=+6XVtq4oJHjTw6cvWsMsqPWuyqZ5zrnnSTv1YyHvuZo=;
        b=eTX7PtUr6Q7zkF+X5PRrXV48Zpfxuf4qKpn1IOAx0xC1C6lSMlL/wxSFvWXFmg3SrX
         ZveZ8ZKvxZzh1R8CRjOATCinMdkIwaNQqmnVA1+pUGoTaE0NvIk8ps9mNcCy+JZx+Sof
         X5TWS4qO7IMNjLQ09Fp227CNz6Twrmgsp8iq3Uo57+U52sjwxHEdZsZM0QJh9AHUXT8g
         6APhMAehtDiywKqd53cYkx/rBx20SKsU2T93vWtP/yFQp7fPhaXPOhuFTYTBAfUblRSV
         Oe4NYD5YUjn8sixq5tLbM7A4OdxqebL9itoUikgpa5nGZgsQPfyxrvO7vPMwW0qbQM0Y
         u6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+6XVtq4oJHjTw6cvWsMsqPWuyqZ5zrnnSTv1YyHvuZo=;
        b=YEImEWD5yVSwph33i5QaYtkRQkVHZ14xvQG7CSubL0muwf037/2o/+g+RCOFb6Q9ae
         6/zZeBvRkjxYGWJuPtI/EqlMnaRcNBMNjs/wwOcI9LyQn1K+nQ+tBz7hF0xtfsP8fih2
         O2oK0mkYFV5YFpzZlAAKgQclw6NPsP2+w6s5iYIGO0Su9Y/enL4LKbWGouRysLDJ2v/U
         FlOoSRaqiCDpm4RMIogNhhyLzxDlgo51Z0cEkJQ3cIPIBAuZxSlBh/aSNvdxtr2gF13J
         rdhAPF9anEZ92mtNijuXLt8eGdyBuIofAUBOggoDHaxSVRQ7O38D8ACi5OQuJrVaebEU
         qWqg==
X-Gm-Message-State: AGRZ1gLYXbjTpXQr9ayYtK7i/9RnGRuVcB2PHSjPqeZd6+8y6k+cIK3u
        jBk9DKBHUTfw7e/SsvZcqYs=
X-Google-Smtp-Source: AJdET5dI7UQJil4xr1fsCJyQTAMYEi7rUK5gXJEOsWOyg+EhmaWfXpuPjVnhmis0z1bPHxVvWCaJTg==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr11740169pgj.341.1542409368558;
        Fri, 16 Nov 2018 15:02:48 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id 18sm31043413pgl.50.2018.11.16.15.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:02:48 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] Staging: iio: adt7316: Change the name from irq_flags to irq_type
Date:   Sat, 17 Nov 2018 04:32:43 +0530
Message-Id: <20181116230243.24985-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the drivers in IIO uses irq_type as the name for
storing the interrupt type and hence change the name from
irq_flags to irq_type for maintaining the consistency.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index dfae22619287..9c72538baf9e 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2102,7 +2102,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
 	unsigned short *adt7316_platform_data = dev->platform_data;
-	int irq_flags = IRQF_TRIGGER_LOW;
+	int irq_type = IRQF_TRIGGER_LOW;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2147,18 +2147,18 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 
 	if (chip->bus.irq > 0) {
 		if (adt7316_platform_data[0])
-			irq_flags = adt7316_platform_data[0];
+			irq_type = adt7316_platform_data[0];
 
 		ret = devm_request_threaded_irq(dev, chip->bus.irq,
 						NULL,
 						adt7316_event_handler,
-						irq_flags | IRQF_ONESHOT,
+						irq_type | IRQF_ONESHOT,
 						indio_dev->name,
 						indio_dev);
 		if (ret)
 			return ret;
 
-		if (irq_flags & IRQF_TRIGGER_HIGH)
+		if (irq_type & IRQF_TRIGGER_HIGH)
 			chip->config1 |= ADT7316_INT_POLARITY;
 	}
 
-- 
2.17.1

