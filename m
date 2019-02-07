Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5054BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC52084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfBGJjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:39:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44229 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:39:09 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1grg98-0002wD-LA; Thu, 07 Feb 2019 09:39:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ads124s08: fix spelling mistake "converions" -> "conversions"
Date:   Thu,  7 Feb 2019 09:39:02 +0000
Message-Id: <20190207093902.7081-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in several dev_err messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/ti-ads124s08.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index c2cf58908fc8..53f17e4f2f23 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -232,7 +232,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
 
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
 		if (ret) {
-			dev_err(&priv->spi->dev, "Start converions failed\n");
+			dev_err(&priv->spi->dev, "Start conversions failed\n");
 			goto out;
 		}
 
@@ -246,7 +246,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
 
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
 		if (ret) {
-			dev_err(&priv->spi->dev, "Stop converions failed\n");
+			dev_err(&priv->spi->dev, "Stop conversions failed\n");
 			goto out;
 		}
 
@@ -283,12 +283,12 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
 		if (ret)
-			dev_err(&priv->spi->dev, "Start ADC converions failed\n");
+			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
 
 		buffer[j] = ads124s_read(indio_dev, scan_index);
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
 		if (ret)
-			dev_err(&priv->spi->dev, "Stop ADC converions failed\n");
+			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
 
 		j++;
 	}
-- 
2.20.1

