Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59C12084D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 21:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbiCrIZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfBXVkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 16:40:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39822 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfBXVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 16:40:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so8402244qtk.6;
        Sun, 24 Feb 2019 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qa9ZzQ4ViF1H9Hw3jMJanuqn5quGoLiOQ0qxsvv8VJE=;
        b=MbiCrIZFpnB3sX3RIdNkNnKPKo3PRzvbrdLPUejtJintpIQpwB07+5mXeVJldVQKcW
         q97H5twugQ233oCFsZnm7HaWNaGgqewW5rkk3b+JyEmZz2VqkKdkMVHzZFvUUpVS2hZp
         klqX8y/fPcEZavJzhVaPJytcZro7ZUz2jgRZmw8TB9Q2651ozpdYAUGSxyMdkbnmipMU
         3fs0mvLQdokZOgwwdIjFDPpof8IcJF3yNmid6Mw4NZMFdyIgJV1HnM01fLd66ZFDvTqb
         kYQKxCL/LYJmUov3YJAeD8ER3MkokPtEnPvUXM72mQpYZrAOg+PyloNi1oXpXuAIVRZP
         +qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qa9ZzQ4ViF1H9Hw3jMJanuqn5quGoLiOQ0qxsvv8VJE=;
        b=DyKEEPVjUiLiJM5Vn1vOwf8UzIO+ARbNjCKx8pGvDFtemL22miHpC17CdFN1fwEYnn
         poxWdLU/mToYTe4wFkdt3iaDmWNVjuVgF2on5XrN8tE9HqfkFjz5+bgYkuMjZjvvLFRx
         IUNy9E7211sD11cvskeaDD/0hkJJsjrBUPe3fRMnwqKGxufFmA5QJo/f3hVA+Rzz3uP+
         ftueBWdqg118TgPZMQ3+eOyEdsLamQEuS7GsjrwNaWv8fla6zbZZhimX3hxrG/4Pxqa1
         R6b6aFNU0ZELzAutjD+xMhQf/WBIqth3DEgzYb4KcdZyWr4OblMxGtX9J9jl03V+0Ecf
         lpPg==
X-Gm-Message-State: AHQUAuY3A5006034iMmhHTyKt+TI0wPr1htmLeiyQlpJdWg4FhJXnG2Q
        +ZxarT3L3ICrSwPfmpj9NVY=
X-Google-Smtp-Source: AHgI3IbqkzmqBi5eWqJzIeC1TZ1U8N5OLLH+z6S69ygaV742kutnWxvyp/XG1JLYPoiUU2+SDyPxSw==
X-Received: by 2002:a0c:fac3:: with SMTP id p3mr11418394qvo.190.1551044422054;
        Sun, 24 Feb 2019 13:40:22 -0800 (PST)
Received: from voyager.ufabc.int.br ([2801:a4:102:5::5ae3])
        by smtp.gmail.com with ESMTPSA id a68sm4794146qkj.82.2019.02.24.13.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 13:40:21 -0800 (PST)
From:   =?UTF-8?q?Camylla=20Gon=C3=A7alves=20Cantanheide?= 
        <c.cantanheide@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH] iio: adc: ad7766: Change alignment to match paranthesis
Date:   Sun, 24 Feb 2019 18:40:10 -0300
Message-Id: <20190224214010.10894-1-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit align broken line to match upper line parenthesis,
in lines 80, 130, 237, 242, 255, 264 and 293. Solves the checkpatch.pl's message:

CHECK: Alignment should match open parenthesis

In lines 130, 255, 264 and 293 it was necessary to break a line.
---
 drivers/iio/adc/ad7766.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 3ae14fc8c649..101502435768 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -77,7 +77,7 @@ static irqreturn_t ad7766_trigger_handler(int irq, void *p)
 		goto done;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
-		pf->timestamp);
+					   pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -127,7 +127,8 @@ static int ad7766_postdisable(struct iio_dev *indio_dev)
 }
 
 static int ad7766_read_raw(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, int *val, int *val2, long info)
+			   const struct iio_chan_spec *chan, int *val,
+			   int *val2, long info)
 {
 	struct ad7766 *ad7766 = iio_priv(indio_dev);
 	struct regulator *vref = ad7766->reg[AD7766_SUPPLY_VREF].consumer;
@@ -234,12 +235,12 @@ static int ad7766_probe(struct spi_device *spi)
 	ad7766->reg[AD7766_SUPPLY_VREF].supply = "vref";
 
 	ret = devm_regulator_bulk_get(&spi->dev, ARRAY_SIZE(ad7766->reg),
-		ad7766->reg);
+				      ad7766->reg);
 	if (ret)
 		return ret;
 
 	ad7766->pd_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
-		GPIOD_OUT_HIGH);
+						  GPIOD_OUT_HIGH);
 	if (IS_ERR(ad7766->pd_gpio))
 		return PTR_ERR(ad7766->pd_gpio);
 
@@ -252,7 +253,8 @@ static int ad7766_probe(struct spi_device *spi)
 
 	if (spi->irq > 0) {
 		ad7766->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
-			indio_dev->name, indio_dev->id);
+						      indio_dev->name,
+						      indio_dev->id);
 		if (!ad7766->trig)
 			return -ENOMEM;
 
@@ -261,8 +263,9 @@ static int ad7766_probe(struct spi_device *spi)
 		iio_trigger_set_drvdata(ad7766->trig, ad7766);
 
 		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
-			IRQF_TRIGGER_FALLING, dev_name(&spi->dev),
-			ad7766->trig);
+				       IRQF_TRIGGER_FALLING,
+				       dev_name(&spi->dev),
+				       ad7766->trig);
 		if (ret < 0)
 			return ret;
 
@@ -290,8 +293,9 @@ static int ad7766_probe(struct spi_device *spi)
 	spi_message_add_tail(&ad7766->xfer, &ad7766->msg);
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-		&iio_pollfunc_store_time, &ad7766_trigger_handler,
-		&ad7766_buffer_setup_ops);
+					      &iio_pollfunc_store_time,
+					      &ad7766_trigger_handler,
+					      &ad7766_buffer_setup_ops);
 	if (ret)
 		return ret;
 
-- 
2.17.1

