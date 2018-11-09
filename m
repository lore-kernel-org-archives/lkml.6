Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F7FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7DA2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTrzCvOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7DA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeKIRPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:15:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38287 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKIRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:15:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so552197pfi.5;
        Thu, 08 Nov 2018 23:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D+hgTAknwOvfgpgcMHvVyFVBDFXLuZFMqPVNoy67gvo=;
        b=QTrzCvOj6AKg8ZpmlfN2nsvfuG6x+foMlC8StA1kzAFLDwCQkHIOQTkKSD34/EzoIl
         /pcp4fXkxxuoZuhgg/4qBiboAzCM+y9fJ9iZ4cuSmNfZwHOGCdcas2u7zBYe+kS1cpTx
         Mk/sMBtnKi1fO5n2y/5L9gCpGXYAABxLlwGENMbSl34279nmmsDVa4ovia0wNCFjkcQ7
         AYDg2XRicPdjWwTvyahu8UaLH10EbdFPfDzbvCluUtculMmXYP13vOYmyR2zNXg1IEYn
         feHNOsGdhMNtfG+UQOd5/jBIUkAEJeoEXxKbj55tqAgp9jTqgiAPReUy7OO+OG5FfKh/
         6wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D+hgTAknwOvfgpgcMHvVyFVBDFXLuZFMqPVNoy67gvo=;
        b=TzC4wazqYP5FGgTfmOaClT7enbyP8WuFEccokP7Fcb+NAp1GTeoH11OqdatXuThthQ
         fzmM0HLszUvdTzVvrRHj3Yu5eYGdISq7Ccl5RxpDjX0p/yjlzB+UhaELhERHyBq3k2o3
         Cc9QpxGmBiXeJ6BGBE1ghj6ov1ca38hToZOv0BV7v9+LffvIPzO54VrnjI1lNA6f1/W+
         rkAQlysOKTj33N8dwt4Nmod8zgvuKOtroBjZ8Z0bSu9sGaFEWWwMGFssYcnzhvgA/7/u
         4mZxkTNf4XKodwSvXiaXPmUQ7386q0k5yKb9w/6ZLMaBdrccbSSsvN3o8FcO4s8GXECo
         wAmQ==
X-Gm-Message-State: AGRZ1gL3Q3XeSRCiRgQBcqD/D0PsENQeRIXYqlP3TbT+hpaBzzBouvyb
        EjdDadfZYEPpZ/WKGIaL39k=
X-Google-Smtp-Source: AJdET5c8AHD4Kf7dl/Sowt1yG7Y4P54rtXfXwTtWGoHgAPyYTN+gFNbn/fz7VJZpei4UzASaCA6fww==
X-Received: by 2002:aa7:8546:: with SMTP id y6-v6mr8047452pfn.83.1541748992787;
        Thu, 08 Nov 2018 23:36:32 -0800 (PST)
Received: from nishad ([106.210.186.71])
        by smtp.gmail.com with ESMTPSA id n17-v6sm12553638pfj.148.2018.11.08.23.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:36:32 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:06:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] staging: iio: ad7816: Do not use busy_pin in case of
 AD7818
Message-ID: <3f0bc36261c54c945a3213ef03425099e57e9060.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541733949.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AD7818 does not support busy_pin functionality as per datasheet.
Hence drop busy_pin when AD7818 is used.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 35 ++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 12c4e0ab4713..3cda5cd09365 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -43,6 +43,7 @@
  */
 
 struct ad7816_chip_info {
+	kernel_ulong_t id;
 	struct spi_device *spi_dev;
 	struct gpio_desc *rdwr_pin;
 	struct gpio_desc *convert_pin;
@@ -52,6 +53,12 @@ struct ad7816_chip_info {
 	u8  mode;
 };
 
+enum ad7816_type {
+	ID_AD7816,
+	ID_AD7817,
+	ID_AD7818,
+};
+
 /*
  * ad7816 data access by SPI
  */
@@ -78,8 +85,10 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	while (gpiod_get_value(chip->busy_pin))
-		cpu_relax();
+	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+		while (gpiod_get_value(chip->busy_pin))
+			cpu_relax();
+	}
 
 	gpiod_set_value(chip->rdwr_pin, 0);
 	gpiod_set_value(chip->rdwr_pin, 1);
@@ -359,6 +368,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
 
+	chip->id = spi_get_device_id(spi_dev)->driver_data;
 	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
 	if (IS_ERR(chip->rdwr_pin)) {
 		ret = PTR_ERR(chip->rdwr_pin);
@@ -373,12 +383,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
 			ret);
 		return ret;
 	}
-	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
-	if (IS_ERR(chip->busy_pin)) {
-		ret = PTR_ERR(chip->busy_pin);
-		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
-			ret);
-		return ret;
+	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
+		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
+						GPIOD_IN);
+		if (IS_ERR(chip->busy_pin)) {
+			ret = PTR_ERR(chip->busy_pin);
+			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
@@ -409,9 +422,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
 }
 
 static const struct spi_device_id ad7816_id[] = {
-	{ "ad7816", 0 },
-	{ "ad7817", 0 },
-	{ "ad7818", 0 },
+	{ "ad7816", ID_AD7816 },
+	{ "ad7817", ID_AD7817 },
+	{ "ad7818", ID_AD7818 },
 	{}
 };
 
-- 
2.17.1

