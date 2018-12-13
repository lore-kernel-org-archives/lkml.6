Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F915C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7DC2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WazAsnA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7DC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeLMTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:43:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37337 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeLMTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:43:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so1534505plr.4;
        Thu, 13 Dec 2018 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=YWzLkl43TNrxxJ4UiH7VZTyugNvX9odVpZLVLKgv65c=;
        b=WazAsnA8ozMaviZ0Tmva3rpf8uEAU9q9lJyvuEIV6x56FIT0e+K62qJ+oUQGsVwmN1
         MVfjMaOzN2hGU/3gazco4HnqCtbrjppRPtIW12SFF7BbBZ+E2pPH8vM1XuGCLSJEoZoh
         RMAQ38G0+yIvM1PTsgYduzJy91YjXoLO+9/ECXYkzrPWeuwGHM4LVPaY+eZHXmRGWDjh
         BQIp9afqQiSo3BAMm3FpiRZMWOdI22hNa9aMUdpK4QHq4V5KN9XFRD5mW22x9SNz7NZn
         Iew+qSOTZz4fWL8/K1fczoi2rvNoiF4zAoQaBhcZBRBHrJQXgXMjRm2jkQgd55gQRPol
         HZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=YWzLkl43TNrxxJ4UiH7VZTyugNvX9odVpZLVLKgv65c=;
        b=NYQbiqfA1sifdFq8PTSq5/sdcOWwh7pyIhMmJfT4euz09wAeDbBQt3ZqbvXRsTw6VL
         QbnGyIwAuGcdEIX3dEdWfO1KJoM5G37gzv172SBIAv6XG+S5J/9qakDL9dfSC2HI/Psr
         eMYVf7IgXNg9NrvbPJ4MwdyzUEFiD2IxbJYeH62+fxo48tNhZjL2de+MqEA/IaJvKHJm
         7GbypjqyJpyIGC10XOgMGt9Emg5vGwL+tjQD56AxYxGIvnS289VtLq+Ex8G8h+GZjx2x
         Z7F+DyQJF5UqMvtCqp3ZOMAcdrOAL2bNECnmnssNpt+xr/ARSidWrac3flPp1GoLNcG1
         FPmg==
X-Gm-Message-State: AA+aEWY36MJ6KxXnIo931PMr9g175xN3a9vNDchZFt7WCDI6ws1aOdX3
        PAYuhoIi5O2Evi2lM8n9KA0=
X-Google-Smtp-Source: AFSGD/XafBNMSkq2NEdJZiNBXWB6fUbPe3t5VX7ZPuoS2Nh9IYkqi57Grm+m/czdP/yLuAP8MG7RqQ==
X-Received: by 2002:a17:902:e10a:: with SMTP id cc10mr90594plb.165.1544730222252;
        Thu, 13 Dec 2018 11:43:42 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id h82sm5548852pfa.105.2018.12.13.11.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:43:41 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] Staging: iio: adt7316: Add all irq related code in adt7316_irq_setup()
Date:   Fri, 14 Dec 2018 01:13:35 +0530
Message-Id: <20181213194335.11075-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7316 driver no more uses platform data and hence use device tree
data instead of platform data for assigning irq_type field and
implement this in adt7316_irq_setup function.
Switch case figures out the type of irq and if it's the default case
then assign the default value to the irq_type i.e.
irq_type = IRQF_TRIGGER_LOW
Move devm_request_threaded_irq() and assignment of chip->config1
into the adt7316_setup_irq() to unclutter the code in probe function.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
Changes in v4
  - Merge patches *[1/3 v3], *[2/3 v3] and *[3/3 v3] to make it less
complex to review.

Changes in v3
  - Add a new function for having all interrupt related code.

Changes in v2
  - Make the commit message of patch *[1/5] appropriate.


 drivers/staging/iio/addac/adt7316.c | 52 +++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 9c72538baf9e..1ca4ee0f30ee 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1807,6 +1807,43 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int adt7316_setup_irq(struct iio_dev *indio_dev)
+{
+	struct adt7316_chip_info *chip = iio_priv(indio_dev);
+	int irq_type, ret;
+
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_HIGH:
+	case IRQF_TRIGGER_RISING:
+		break;
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_FALLING:
+		break;
+	default:
+		dev_info(&indio_dev->dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
+			 irq_type);
+		irq_type = IRQF_TRIGGER_LOW;
+		break;
+	}
+
+	ret = devm_request_threaded_irq(&indio_dev->dev, chip->bus.irq,
+					NULL, adt7316_event_handler,
+					irq_type | IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret) {
+		dev_err(&indio_dev->dev, "failed to request irq %d\n",
+			chip->bus.irq);
+		return ret;
+	}
+
+	if (irq_type & IRQF_TRIGGER_HIGH)
+		chip->config1 |= ADT7316_INT_POLARITY;
+
+	return 0;
+}
+
 /*
  * Show mask of enabled interrupts in Hex.
  */
@@ -2101,8 +2138,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
-	unsigned short *adt7316_platform_data = dev->platform_data;
-	int irq_type = IRQF_TRIGGER_LOW;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2146,20 +2181,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (chip->bus.irq > 0) {
-		if (adt7316_platform_data[0])
-			irq_type = adt7316_platform_data[0];
-
-		ret = devm_request_threaded_irq(dev, chip->bus.irq,
-						NULL,
-						adt7316_event_handler,
-						irq_type | IRQF_ONESHOT,
-						indio_dev->name,
-						indio_dev);
+		ret = adt7316_setup_irq(indio_dev);
 		if (ret)
 			return ret;
-
-		if (irq_type & IRQF_TRIGGER_HIGH)
-			chip->config1 |= ADT7316_INT_POLARITY;
 	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, chip->config1);
-- 
2.17.1

