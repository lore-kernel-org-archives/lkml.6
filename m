Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C20218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5ZpwQ8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfAYKBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:01:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38713 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfAYKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:01:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so6905896ede.5;
        Fri, 25 Jan 2019 02:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvohXcEKajDUL0TBJ4gjZVmzI1Z8Ns4WdfDOcdvTKgA=;
        b=i5ZpwQ8n1ISDOC9aS/V0ZRjWq+fghG9u/QhKkuYxQrRi4hpexMyulKXmUy2+NQYQq5
         vRCmqt5f93g5IbiHL5F8ufrNItPfJOyvuQ5/MXw/w13XoLcwmwCUIusau/UXL5xMtWsh
         P8xkXAw2Nki00S2Hmnx8yxEdClWgiTA9LWVViSCDfXlKGdrFWkqGMhrofJt5qPBbHMI8
         Y1/GwMKN3XleFYwO+DGth56mdrry0ZdmRj9yrypCWmS5yW+DT1fZp4Jn4LfDHWYO68IZ
         vDJtnS+Qp6CY7ZPM/EO/ftKd+igaqK/7VCNi2zp+XeePESiGykw3fcC4PQEaAw11BgEC
         95vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZvohXcEKajDUL0TBJ4gjZVmzI1Z8Ns4WdfDOcdvTKgA=;
        b=eFf0ZYk8Ah4k1mIWTuT2ilmoUy/KBJAGE0DJgHB5zmWfwC1QJFNP4EIpPJVsny6Tum
         vgTpfmDFWSngczuj0oGtByvhtvSP8IPOPagJhdQZr4paXw/oBBh5dNyuMsNcBQIr4W4J
         PkYghLHqSRlSxF4iP1Mclc/Jez+PX6K6+9A9AsVMCMcEFyLsKVlP3XesIRrMQejA15dm
         5xAcfdwcPalPwwUhPj4zmYRb9Oswj9EFlE3vkYIb1i1njaK53UP2uuewFL6yK+cPyRvX
         YdcwMaeMZwSk4a8W8eLMhM6lSJhGiERPyNFtsQW2ImhUITxMfQs430upr6StpZviGjNS
         dxYw==
X-Gm-Message-State: AJcUukdwiOORIvfrPUgC6lbmi/Q7P4e+Aju46jNstO3MFJhdP32yW8FP
        KKaJQL1Y+rR80DMIfkV8TVo=
X-Google-Smtp-Source: ALg8bN59bmvu8+Uy0VCHlAPIja24TB/pq562MtL2KOlktP+wN9xDpkcxp+1OxO3N+0H/wZ7ct3wTjw==
X-Received: by 2002:a17:906:1c86:: with SMTP id g6-v6mr9240455ejh.195.1548410510763;
        Fri, 25 Jan 2019 02:01:50 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id c26sm503198edb.15.2019.01.25.02.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:01:49 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH] iio: adc: ad7476: Add support for ADS786X ADCs
Date:   Fri, 25 Jan 2019 11:01:47 +0100
Message-Id: <20190125100147.14259-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ADS7866, ADS7867 and ADS7868 8/10/12 bit Single channel
ADC.

Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
v2: I have missnamed the devices
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
index 0549686b9ef8..76747488044b 100644
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
+#define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
+		BIT(IIO_CHAN_INFO_RAW))
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7091R] = {
@@ -209,6 +214,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 		.channel[0] = ADC081S_CHAN(12),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
+	[ID_ADS7866] = {
+		.channel[0] = ADS786X_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADS7867] = {
+		.channel[0] = ADS786X_CHAN(10),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADS7868] = {
+		.channel[0] = ADS786X_CHAN(8),
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

