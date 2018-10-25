Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D9ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA41820834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA41820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJZAJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:09:29 -0400
Received: from mr40.theemaillaundry.net ([109.169.43.35]:33206 "EHLO
        mr40.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJZAJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:09:28 -0400
Received: from mr30.theemaillaundry.net (mr30.theemaillaundry.net [78.46.72.43])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mr40.theemaillaundry.net (Postfix) with ESMTPS id 278614054A;
        Thu, 25 Oct 2018 16:36:09 +0100 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mr30.theemaillaundry.net (Postfix) with ESMTP id 902C0241A68;
        Thu, 25 Oct 2018 16:36:07 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr30.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr30.theemaillaundry.net ([127.0.0.1])
        by localhost (mr30.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NZOzfhK2yXq2; Thu, 25 Oct 2018 16:36:06 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr30.theemaillaundry.net (Postfix) with ESMTPS id DE5902418D6;
        Thu, 25 Oct 2018 16:36:05 +0100 (IST)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gFhg2-0008BR-7J; Thu, 25 Oct 2018 16:36:02 +0100
From:   Dan O'Donovan <dan@emutex.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>,
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Date:   Thu, 25 Oct 2018 16:35:41 +0100
Message-Id: <1540481742-23596-3-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540481742-23596-1-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicola Lunghi <nicola.lunghi@emutex.com>

ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
Squared board.

Add it to the driver.

Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
[javier@emutex.com: fix up commit message and one checkpatch warning]
Signed-off-by: Javier Arteaga <javier@emutex.com>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index e6716c3..c2d1453 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -12,10 +12,12 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 struct adc128_configuration {
@@ -135,10 +137,15 @@ static const struct iio_info adc128_info = {
 static int adc128_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
+	unsigned int config;
 	struct adc128 *adc;
-	int config = spi_get_device_id(spi)->driver_data;
 	int ret;
 
+	if (dev_fwnode(&spi->dev))
+		config = (unsigned long) device_get_match_data(&spi->dev);
+	else
+		config = spi_get_device_id(spi)->driver_data;
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -207,10 +214,19 @@ static const struct spi_device_id adc128_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id adc128_acpi_match[] = {
+	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
+#endif
+
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
 		.of_match_table = of_match_ptr(adc128_of_match),
+		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
 	},
 	.probe = adc128_probe,
 	.remove = adc128_remove,
-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

