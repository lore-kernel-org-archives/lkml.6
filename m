Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24274C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B324120897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jitoRuGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B324120897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeH2J7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 05:59:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36568 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeH2J7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 05:59:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so1836340plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u5rNulQQzSqP+YIFhXxyPRU7lX/Luw3DBF25RsEiU4Y=;
        b=jitoRuGsNcPWWcCu4rRtM4NvUpeNMziDP+0B69vCiSWNUsQWI0Z+PUJ6CSscMvNKvT
         qsbvMbBeGnFHg/VXXSLprNxpMVX3VIrTTjXrEHTS7h0VtKUSpOg1XOfkkrv7aIjkjlpB
         Fns6gt08XXn7avWYv4fjOkgV+QLdpAosbhrqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u5rNulQQzSqP+YIFhXxyPRU7lX/Luw3DBF25RsEiU4Y=;
        b=rdnEXfqXbuHHRDya6zB3mbtB5lREPjQ8zIp/Lxy9p449mwKjdGARrFUK4kWPvxlMCw
         BgnMQioYJwSqC4MrdpE4GkchQeJx3oEpc2FidcQdjx8v9i4KVFz1QzRB5Xlg/rNtOPJK
         yl5CukSR7DO95UWxFsaAhwjiqiwLRGzwG1uOwvDOVlHsuIQc0ma5u59u6w0ShMp/Q/Wl
         HHbZ85NCtAuTGfCfRvIqGJl1AruCVTt4ZoHzY3JlQS63dmTDg8AWnvIng8N217ebkP0c
         Oj/OKsLObWHvM1kEmZ458q3P6eGeCe/4FkhmHDpfmefFVTQu5LjoZTHcLTy07IJQL1DH
         xw/g==
X-Gm-Message-State: APzg51ABYpHICLMIKLMHWPBSBWYlDN5xqyoyRPIva7j5yqAx/RHlB9zq
        pCr1E1gVSYCwsXjvSxkHmEbrag==
X-Google-Smtp-Source: ANB0VdZiogBKvVlDXXPw0ESfQfq7E9aNHaNz1/y8p1ZbNWDGgtY9e53f3+zaHdze25nAs5YSbg2CaQ==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35-v6mr4539188plg.187.1535522659172;
        Tue, 28 Aug 2018 23:04:19 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c85-v6sm5188729pfd.110.2018.08.28.23.04.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 23:04:18 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@spreadtrum.com, broonie@kernel.org,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: sc27xx: Add raw data support
Date:   Wed, 29 Aug 2018 14:04:04 +0800
Message-Id: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headset device will use channel 20 of ADC controller to detect events,
but it needs the raw ADC data to do conversion according to its own formula.

Thus we should configure the channel mask separately and configure channel
20 as IIO_CHAN_INFO_RAW, as well as adding raw data read support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - None.

---
 drivers/iio/adc/sc27xx_adc.c |   80 ++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 2b60efe..153c311 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -273,6 +273,17 @@ static int sc27xx_adc_read_raw(struct iio_dev *indio_dev,
 	int ret, tmp;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		ret = sc27xx_adc_read(data, chan->channel, scale, &tmp);
+		mutex_unlock(&indio_dev->mlock);
+
+		if (ret)
+			return ret;
+
+		*val = tmp;
+		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_PROCESSED:
 		mutex_lock(&indio_dev->mlock);
 		ret = sc27xx_adc_read_processed(data, chan->channel, scale,
@@ -315,48 +326,47 @@ static int sc27xx_adc_write_raw(struct iio_dev *indio_dev,
 	.write_raw = &sc27xx_adc_write_raw,
 };
 
-#define SC27XX_ADC_CHANNEL(index) {				\
+#define SC27XX_ADC_CHANNEL(index, mask) {			\
 	.type = IIO_VOLTAGE,					\
 	.channel = index,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |	\
-			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate = mask | BIT(IIO_CHAN_INFO_SCALE),	\
 	.datasheet_name = "CH##index",				\
 	.indexed = 1,						\
 }
 
 static const struct iio_chan_spec sc27xx_channels[] = {
-	SC27XX_ADC_CHANNEL(0),
-	SC27XX_ADC_CHANNEL(1),
-	SC27XX_ADC_CHANNEL(2),
-	SC27XX_ADC_CHANNEL(3),
-	SC27XX_ADC_CHANNEL(4),
-	SC27XX_ADC_CHANNEL(5),
-	SC27XX_ADC_CHANNEL(6),
-	SC27XX_ADC_CHANNEL(7),
-	SC27XX_ADC_CHANNEL(8),
-	SC27XX_ADC_CHANNEL(9),
-	SC27XX_ADC_CHANNEL(10),
-	SC27XX_ADC_CHANNEL(11),
-	SC27XX_ADC_CHANNEL(12),
-	SC27XX_ADC_CHANNEL(13),
-	SC27XX_ADC_CHANNEL(14),
-	SC27XX_ADC_CHANNEL(15),
-	SC27XX_ADC_CHANNEL(16),
-	SC27XX_ADC_CHANNEL(17),
-	SC27XX_ADC_CHANNEL(18),
-	SC27XX_ADC_CHANNEL(19),
-	SC27XX_ADC_CHANNEL(20),
-	SC27XX_ADC_CHANNEL(21),
-	SC27XX_ADC_CHANNEL(22),
-	SC27XX_ADC_CHANNEL(23),
-	SC27XX_ADC_CHANNEL(24),
-	SC27XX_ADC_CHANNEL(25),
-	SC27XX_ADC_CHANNEL(26),
-	SC27XX_ADC_CHANNEL(27),
-	SC27XX_ADC_CHANNEL(28),
-	SC27XX_ADC_CHANNEL(29),
-	SC27XX_ADC_CHANNEL(30),
-	SC27XX_ADC_CHANNEL(31),
+	SC27XX_ADC_CHANNEL(0, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(1, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(2, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(3, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(4, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(5, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(6, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(7, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(8, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(9, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(10, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(11, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(12, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(13, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(14, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(15, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(16, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(17, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(18, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(19, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(20, BIT(IIO_CHAN_INFO_RAW)),
+	SC27XX_ADC_CHANNEL(21, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(22, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(23, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(24, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(25, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(26, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(27, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(28, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(29, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(30, BIT(IIO_CHAN_INFO_PROCESSED)),
+	SC27XX_ADC_CHANNEL(31, BIT(IIO_CHAN_INFO_PROCESSED)),
 };
 
 static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
-- 
1.7.9.5

