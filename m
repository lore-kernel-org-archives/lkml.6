Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A1CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2C9218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7iBPOuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfAXVcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:32:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37265 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:32:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so5793734edb.4;
        Thu, 24 Jan 2019 13:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nHhy75h0M+XnKhlhRGvdc3h5y52wRsXerFO8ELPp8XI=;
        b=B7iBPOuJCOK5a1dQZyHSN73uCzw2OrG3kJ4KcdRkWQYP2Q4iux5lE7tugF1xLXv6Bs
         EyzC6QJ0UgcvUC1XsboWh5HjHAqVcO9sYBd6MCgKpDi+l4izfHcN7w2YlI1H+v1kJNLj
         uv10qDRZ4W1pgOn/1IirQtu/1AsZ2L0mlq5kHx2LDeJukttyEDoaXVOucV7r98cnVrbC
         sepldAJ1SM28zfpjhxXmh9oEECu3fx/QBSgBQiED807/wrd6uYOBPQn4s9UF89gJF0+b
         FZa0ccUb90/kGkBFkofm0DAGsPceOIOUqmPr4GZzaJvtyXVxKSJa4QquMsF3iYMc8nYe
         3z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nHhy75h0M+XnKhlhRGvdc3h5y52wRsXerFO8ELPp8XI=;
        b=iKwVqDk6YGEw978ET/dpAYalNV4gchOG2TS/JRtPXvQ4L8ZtWOn+Dhi4Qo4+gdPTRL
         aIXG8uTMs31kapNi/U/h2+sjp0HMiCx9zsLznLhyxE/ovxHhw0jooKnk/bseBlytNVRC
         blNeer9hAqwZ7M7vuWVolwC737ZEx1qFO3eWBVOxBd7RWmN5CeFg7N25tVuP0OrV4ZJ/
         IX1rkmI+DoR2Atq2Bz/bcsMzpVyEFf0ZF0wAfIs0sJpWxWKjuaTXpmFEFC7XZzyNg9P6
         kLk/j0M0Wq1gjt7jhdIpUQO6oAljzfqly2goqygM6oUwMW7nJofr34speW0Ne/mvXb6x
         AqnA==
X-Gm-Message-State: AJcUukdV1zeNr7cL46hQKAMQLXwFqL9NuJzfy0788ZAsP+qUgGbEK9LK
        7PVi8I2eRR8CcuxUbZy0dwaIFHae
X-Google-Smtp-Source: ALg8bN7CfzTmVbuVGtW+fFk0aDU1x1nBtpizV7C01XqZAcnxGHr3M2RBa+hsS86RwSV3mxEnjQGZyA==
X-Received: by 2002:a17:906:914a:: with SMTP id y10mr7509154ejw.124.1548365550659;
        Thu, 24 Jan 2019 13:32:30 -0800 (PST)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p7-v6sm6462959ejx.27.2019.01.24.13.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:32:29 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH] iio: adc: ad7476: Add support for ADS786X ADCs
Date:   Thu, 24 Jan 2019 22:32:25 +0100
Message-Id: <20190124213225.11803-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
ADC.

Datasheet: http://www.ti.com/product/ADS7866
Datasheet: http://www.ti.com/product/ADS7867
Datasheet: http://www.ti.com/product/ADS7868

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
 drivers/iio/adc/Kconfig  |  3 ++-
 drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f9354e5ee65c..d86900fc2634 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -64,7 +64,8 @@ config AD7476
 	help
 	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
 	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
-	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
+	  AD7495, AD7910, AD7920, AD7920, ADS7866, ADS7867, ADS7868 SPI analog
+	  to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 0549686b9ef8..108c18d64f7d 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -59,6 +59,9 @@ enum ad7476_supported_device_ids {
 	ID_ADC081S,
 	ID_ADC101S,
 	ID_ADC121S,
+	ID_ADS7866,
+	ID_ADS7867,
+	ID_ADS7868,
 };
 
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
@@ -157,6 +160,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
 #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
+#define ADS786X_CHAN(bits) _AD7476_CHAN((bits) + 4, 0, \
+		BIT(IIO_CHAN_INFO_RAW))
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7091R] = {
@@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 		.channel[0] = ADC081S_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
+	[ID_ADS7866] = {
+		.channel[0] = ADS786X_CHAN(8),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADS7867] = {
+		.channel[0] = ADS786X_CHAN(10),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADS7868] = {
+		.channel[0] = ADS786X_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
 };
 
 static const struct iio_info ad7476_info = {
@@ -314,6 +331,9 @@ static const struct spi_device_id ad7476_id[] = {
 	{"adc081s", ID_ADC081S},
 	{"adc101s", ID_ADC101S},
 	{"adc121s", ID_ADC121S},
+	{"ads7866", ID_ADS7866},
+	{"ads7867", ID_ADS7867},
+	{"ads7868", ID_ADS7868},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
-- 
2.20.1

