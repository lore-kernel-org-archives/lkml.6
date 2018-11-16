Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27280C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38252086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdXxrj99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38252086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeKQJTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:19:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42899 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:19:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so9081032pln.9;
        Fri, 16 Nov 2018 15:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=+/WUkaayRJ8LV3dIb3j9FE2qSHbPHPjvZWttEtLlGIc=;
        b=XdXxrj994D7OXruPigzaHdUJ8WfDYHtQE7mmV5nWT+DXuLGaVTEk5IQ0qGYx7/DPjD
         toVzSqEyPcpxxODrqe3IOfiWhr6pYUgOcfh1bLbo3io5PqPQf9MZR69cU2luxg5lytg0
         9BVY0xx7vJqIVNdVPL66Y1PpHFnlhgjopfIGOvrW9xV2wQCpBbW7RYeqmtESsq9eFUzt
         OX0G2xTysTPa9nVfShIcJkHJ1HSbR1HOjXmnzt2oOFleqGeF8ErYkjiceax8APGTuGP4
         D/HuR/Y1cHqzg1CRBFzYEpAuqEjmBS/42kMOmq+Ohh+BcNy4SDeXJf/ANsvMAsc8HZup
         b1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+/WUkaayRJ8LV3dIb3j9FE2qSHbPHPjvZWttEtLlGIc=;
        b=OBsr3tO49PUmQWjyEAcBnx8yph7TycpE9yHO/aTfhip42AWwLpf3mDDbqeE4Pf84ET
         trbMegE1Go5W66o+XDzU06PneSJhhkamlEtx73misycJpNYk/LZ3BEPm6yoFru7L7F2I
         vjQrHgbqxijPbXwb0C8iF+PPyIsZYxgTsj25TkcLDAPpY2MU9YtiH8TB8mungTekSGKq
         +PRAPJXD9a7LtCkNF0GxRNrkLeCuaqVq4zV11figSgYnlf+4qUIY+tHpUaHOh3xoO0a1
         KwYqxebdrA2P44BhnR6XfoiOJ/OlPIBe50DhheKrC8aRCZWvERikRJ4h7EKmSPTfTKcl
         SeaA==
X-Gm-Message-State: AGRZ1gJfOxROMaW1qKSM1aV8n/6J6XHUyGqXNCsD9K6llY2HicGjOwsS
        57tvyd+trRQYFZrKMmzDc92us1yk
X-Google-Smtp-Source: AJdET5e2SCRXbpBRhjzsuLc7kXwBj/2KUHTbHUIbPuWkEcQzPAa6gHrOxsDcPgdmYgGj7T4dro/xiw==
X-Received: by 2002:a17:902:d890:: with SMTP id b16-v6mr12522921plz.207.1542409501394;
        Fri, 16 Nov 2018 15:05:01 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.154])
        by smtp.gmail.com with ESMTPSA id w80-v6sm55326522pfk.11.2018.11.16.15.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:05:00 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Staging: iio: adt7316: Use device tree data to assign irq_type
Date:   Sat, 17 Nov 2018 04:34:55 +0530
Message-Id: <20181116230455.25073-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADT7316 driver no more uses platform data and hence use device tree
data instead of platform data for assigning irq_type field.
Switch case figures out the type of irq and if it's the default case
then assign the default value to the irq_type i.e.
irq_type = IRQF_TRIGGER_LOW

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 9c72538baf9e..c647875a64f5 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2101,8 +2101,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
-	unsigned short *adt7316_platform_data = dev->platform_data;
-	int irq_type = IRQF_TRIGGER_LOW;
+	int irq_type;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2146,8 +2145,22 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (chip->bus.irq > 0) {
-		if (adt7316_platform_data[0])
-			irq_type = adt7316_platform_data[0];
+		irq_type =
+			irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
+
+		switch (irq_type) {
+		case IRQF_TRIGGER_HIGH:
+		case IRQF_TRIGGER_RISING:
+			break;
+		case IRQF_TRIGGER_LOW:
+		case IRQF_TRIGGER_FALLING:
+			break;
+		default:
+			dev_info(dev, "mode %d unsupported, using IRQF_TRIGGER_LOW\n",
+				 irq_type);
+			irq_type = IRQF_TRIGGER_LOW;
+			break;
+		}
 
 		ret = devm_request_threaded_irq(dev, chip->bus.irq,
 						NULL,
-- 
2.17.1

