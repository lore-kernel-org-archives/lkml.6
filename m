Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E235C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7A21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8q8bwP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1JtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:49:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38320 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfA1JtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:49:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so11338214lfk.5;
        Mon, 28 Jan 2019 01:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iNO+hRc2nyhdf52DZb2efa0vSpNQFfrKIW0l9F3tbeE=;
        b=n8q8bwP7kUh109c415BTyHf0pSBFB0czEC4pZv/XcTgLb9SfvpvqKb94g9cDX7bz+m
         EJ1yNJSTFBKObYSAJtcraRwUgGbB47bSKLyziXzdaOp9GRChakPTMju2RS6Xi5f+fi4K
         umcpYFuMiinV2BTaIinvg0Rvrj7SBjhO0aWvd+xYkFXK7YPMIPJj4PggwL0NFsaj21a3
         AJbOM8KyIy68uPRz6OJsovN9BC6avWtY53vXpG9mWx2jcKXmpdKdTA111Gx238knLZK8
         4/lMiQCyp9Bl7Ugt2azbI+TbfodS0XamBY67+YtoLABfmigLjL1iNkkv3FIdbHsCB8vR
         DOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=iNO+hRc2nyhdf52DZb2efa0vSpNQFfrKIW0l9F3tbeE=;
        b=qIaBdniLlnCBddLkpHQdHLAm/f0J9J1kFlEGLbM/FrtcMl70M+xethv2X9noAaadN2
         /xCFQ4YYqf+u/ALOOrKODcnLzEKqmdiopNYrnveLXOCvRjWGpfPtgqnkDUDiFS7QF960
         kCUEbnhkbxFismFLpUC3ixS50n70miCgNaPv3H3l44mcvuR9Xb/DIFAuBKI3HJ2uhiJQ
         vzb9elYvN3MB9hpyc8+ThW3OL4AWUZsKef3CAQHuAL2FWFOdODcQe8td4PPSP27J0oAI
         DdrIgUHauKelj7mjk7LYsDhfrr0D96lVTZDgpqg4Wuv5Bbl7eT8AzaxiJQGjXTFegJTd
         ORxw==
X-Gm-Message-State: AJcUukfcUjDLiHAlZNysTJvcnt3Q0OzNx6lQUijRRnUBo1JgSgqr7CJ9
        /P48Imp+06+XY3YLQLJIm87Ahd+d
X-Google-Smtp-Source: ALg8bN6sDFWb8yhM7JHT5cK3Ztf7q86BUm0704nL4cPXfmBEJxquma2XZM7gtS8T1ZElVOpcJzWOPw==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr15945112lfb.72.1548668940871;
        Mon, 28 Jan 2019 01:49:00 -0800 (PST)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a20-v6sm2936346ljf.28.2019.01.28.01.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:49:00 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v3] iio: adc: ad7476: Add support for TI ADS786X ADCs
Date:   Mon, 28 Jan 2019 10:48:51 +0100
Message-Id: <20190128094851.3975-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Texas Instruments ADS7866, ADS7867 and ADS7868
8/10/12 bit Single channel ADC.

Datasheet: http://www.ti.com/lit/ds/symlink/ads7868.pdf

Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
v3: Changes by Alexandru Ardelean <ardeleanalex@gmail.com>

- Modify Kconfig to clarify that the chip is not from AD, but from TI

 drivers/iio/adc/Kconfig  |  6 ++++--
 drivers/iio/adc/ad7476.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f9354e5ee65c..2d3442252e32 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -57,14 +57,16 @@ config AD7298
 	  module will be called ad7298.
 
 config AD7476
-	tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
+	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD an TI"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD7273, AD7274, AD7276,
 	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
-	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
+	  AD7495, AD7910, AD7920, AD7920. SPI analog to digital converters (ADC).
+	  And for Texas Instrumments ADS7866, ADS7867, ADS7868. SPI analog to
+	  digital converters (ADC).
 
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

