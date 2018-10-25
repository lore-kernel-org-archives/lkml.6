Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF322C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BC720848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BC720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJZAPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:15:07 -0400
Received: from mr33.theemaillaundry.net ([176.9.125.106]:37218 "EHLO
        mr33.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:15:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mr33.theemaillaundry.net (Postfix) with ESMTP id 675FB51C1FF6;
        Thu, 25 Oct 2018 16:41:44 +0100 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr33.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr33.theemaillaundry.net ([127.0.0.1])
        by localhost (mr33.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GwdVFCAvZcVR; Thu, 25 Oct 2018 16:41:43 +0100 (IST)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr33.theemaillaundry.net (Postfix) with ESMTPS id 9180C51C1D25;
        Thu, 25 Oct 2018 16:36:05 +0100 (IST)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gFhg1-0008BR-TS; Thu, 25 Oct 2018 16:36:02 +0100
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
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 1/3] iio: adc128s052: Add pin-compatible IDs
Date:   Thu, 25 Oct 2018 16:35:40 +0100
Message-Id: <1540481742-23596-2-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540481742-23596-1-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Arteaga <javier@emutex.com>

The datasheets for ADC122S021 and ADC124S021 list two more
pin-compatible alternatives for each device.

Add their IDs as compatible strings.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Javier Arteaga <javier@emutex.com>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 .../devicetree/bindings/iio/adc/ti-adc128s052.txt        |  9 ++++++++-
 drivers/iio/adc/ti-adc128s052.c                          | 16 ++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
index daa2b2c..c07ce1a 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
@@ -1,7 +1,14 @@
 * Texas Instruments' ADC128S052, ADC122S021 and ADC124S021 ADC chip
 
 Required properties:
- - compatible: Should be "ti,adc128s052", "ti,adc122s021" or "ti,adc124s021"
+ - compatible: Should be one of:
+   - "ti,adc128s052"
+   - "ti,adc122s021"
+   - "ti,adc122s051"
+   - "ti,adc122s101"
+   - "ti,adc124s021"
+   - "ti,adc124s051"
+   - "ti,adc124s101"
  - reg: spi chip select number for the device
  - vref-supply: The regulator supply for ADC reference voltage
 
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 7cf39b3..e6716c3 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -186,15 +186,23 @@ static int adc128_remove(struct spi_device *spi)
 static const struct of_device_id adc128_of_match[] = {
 	{ .compatible = "ti,adc128s052", },
 	{ .compatible = "ti,adc122s021", },
+	{ .compatible = "ti,adc122s051", },
+	{ .compatible = "ti,adc122s101", },
 	{ .compatible = "ti,adc124s021", },
-	{ /* sentinel */ },
+	{ .compatible = "ti,adc124s051", },
+	{ .compatible = "ti,adc124s101", },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
 static const struct spi_device_id adc128_id[] = {
-	{ "adc128s052", 0},	/* index into adc128_config */
-	{ "adc122s021",	1},
-	{ "adc124s021", 2},
+	{ "adc128s052", 0 },	/* index into adc128_config */
+	{ "adc122s021",	1 },
+	{ "adc122s051",	1 },
+	{ "adc122s101",	1 },
+	{ "adc124s021", 2 },
+	{ "adc124s051", 2 },
+	{ "adc124s101", 2 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

