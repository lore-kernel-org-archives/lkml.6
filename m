Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6542C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682FF20989
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUk9+P0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682FF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLHPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:16:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42782 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLHPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:16:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so3177587plp.9;
        Sat, 08 Dec 2018 07:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=nWcKVpbCtOeHHfzBkxr54dLK7pg5obwuEhza0JXpwy4=;
        b=PUk9+P0Hb2yaJ9Bxan1LfCT5xVEvAuf8XylcuDAOPytX6nICbix9bg8tHAcKMvI3yl
         w78d0j8Vvtufi+yEhHx1eZrvvyLnsKp4eVvx+fOk/AUasHo3u8zbJ2ZecUXiweStHlIs
         aKlRNGWo01nI+PT9CtKsUGGG1mXywVQYpTGcEIiPlW1v+w1WKPkUtbjCIqwt1dZJ37w0
         wZUPGCGQk2lZZzQTSKxwA7uG+Hg7oZP6yGXbqVwMCKAp9I+Go85UnEzyiMu7kDm8k2JV
         LZa+k9tsDX8VeFZXM01zoA9z6FpDmg2qNP7/0D22K5qDv0FhUZ7q7ZtcnYVMHHgWsRE/
         ieew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=nWcKVpbCtOeHHfzBkxr54dLK7pg5obwuEhza0JXpwy4=;
        b=aAUP89ntCVj2SwT3Xqlo0IYQh8gOJR5p759WR0jTopUm3W3T0VoPp9BYR9rYmhYvI8
         1zwTmQg5SvNRT+LI+dVrr6B8h2SiJ3WLJs0mRxY9romKRpk3r8/HjLfF71PXsuel5Zoe
         xmslzXgq5iQpCFB2VVAjFdDQXpbL3N6J2bOBlRaDJRaYvDVcjAJhgq9m1pPvKuRas6+E
         ErdfIlrLOmPJ+OFMC6Zi0O8/m33gb0+yatDEZVRWvP7HSUk5lFknZfn2N1S6b0qlvuuJ
         PyDSKrzkvQzIv+UnNK1wq9/2aHeGldAIThU5cyT3cNbedSussc+qe8RIJDlHtMVSL8Tf
         mQuw==
X-Gm-Message-State: AA+aEWac/JgVVcwBfVbNN+bE58ITbRnGQknBCwknDdten4OvdNO95eKO
        4uYayPat60hqzqerWjKPVZnMUadV
X-Google-Smtp-Source: AFSGD/U2kSHdrd/P89FvjZYlpvMBoSO0Zc+evEzCd2LVW0W7TNwSg2plK9tiPCrdAzFP2HbK5PK6hw==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr6056475plt.157.1544282207770;
        Sat, 08 Dec 2018 07:16:47 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.153])
        by smtp.gmail.com with ESMTPSA id e23sm9774091pfh.68.2018.12.08.07.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 07:16:47 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v3 1/3] Staging: iio: adt7316: Use device tree data to assign irq_type
Date:   Sat,  8 Dec 2018 20:46:36 +0530
Message-Id: <20181208151638.8759-2-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
References: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7316 driver no more uses platform data and hence use device tree
data instead of platform data for assigning irq_type field.
Switch case figures out the type of irq and if it's the default case
then assign the default value to the irq_type i.e.
irq_type = IRQF_TRIGGER_LOW
All this is implemented in a new function called adt7316_setup_irq.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 9c72538baf9e..86b2c3d53588 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1807,6 +1807,29 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int adt7316_setup_irq(struct device *dev, int irq)
+{
+	int irq_type;
+
+	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_HIGH:
+	case IRQF_TRIGGER_RISING:
+		break;
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_FALLING:
+		break;
+	default:
+		dev_info(dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
+			 irq_type);
+		irq_type = IRQF_TRIGGER_LOW;
+		break;
+	}
+
+	return irq_type;
+}
+
 /*
  * Show mask of enabled interrupts in Hex.
  */
@@ -2101,8 +2124,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
-	unsigned short *adt7316_platform_data = dev->platform_data;
-	int irq_type = IRQF_TRIGGER_LOW;
+	int irq_type;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2146,8 +2168,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (chip->bus.irq > 0) {
-		if (adt7316_platform_data[0])
-			irq_type = adt7316_platform_data[0];
+		irq_type = adt7316_setup_irq(dev, chip->bus.irq);
 
 		ret = devm_request_threaded_irq(dev, chip->bus.irq,
 						NULL,
-- 
2.17.1

