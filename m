Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0180C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CDD20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4BhEUmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CDD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeLLA4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:56:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39752 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeLLAzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:55:55 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so13460611iob.6;
        Tue, 11 Dec 2018 16:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TPkjkn4TiJ7mp9DhGzQAAKMsgbvt73YionGsm/gSjY4=;
        b=R4BhEUmK6ZviloqxhFxozlbCP7iAwAVvHN7kvWcqq3m24OtBxNuxS6vYZkvTVj4XOh
         n+sNJpu0QImgOe/b+lZYFS9+V+npCAII6yn9NjvmfeldowfKOylKTZmHohdwxgMHJs/Q
         VdGEdLm/ymO+DFdmQttDtgB/TSZ0ORmwZX9foMkpUxwjIQAj7PPyIHlAzVdPDTOZe6RM
         rH1jYtD/aZAtW67iJ1C0hwf+nO1FGt6nGhfBHlCkfGye7o3Tgs3fE7IfCTEL/3DVOQ15
         PY7sII97JfOk8unTA7C4iP1vq0R2A1146H2A4qzqObAvYICjsiEeNrbFW6HH4eXoaJ6b
         LV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TPkjkn4TiJ7mp9DhGzQAAKMsgbvt73YionGsm/gSjY4=;
        b=Lv/2nSWY7xbrBYoDKGEllL0SrP3oncZHJZ1MqFPeVgp1P+DI0qYYZYtdXwwimKUqSg
         hPBIeEmI7+o7CzAnj/0I4wqSSS5Ruz8bdn7St9IhhnStNzaNbblLpznZsgw6jJ3rWcYz
         /PCJIjBqSO9bvOlB8i/iuidPLKcH5gIats9Fl8mOFBqJWMsN8IEPUpirwgLvQ8qZetH4
         Q/NGjmJboJTXaa3lI8RTE/4r0OSfzbD1UROAD5QeoMtUbY68Km1Rr4r3k26E5ITN4tN9
         AhmkRb8hDtoJrEoCqEDpnFoWeLaMlDmcXf+1PXapTxk0un4BTLsP5Uwe82XWIdB+Ggyi
         W8HA==
X-Gm-Message-State: AA+aEWbI2OYL8aQgYPrfJ+WsBZdcTu4qNCYLWxz8PJhw9ycaYx9taIZk
        ctpHCd4SNs4LqW5Xq6cqTKY=
X-Google-Smtp-Source: AFSGD/U85FP8yW06Gpays7eYyLSdl3+J/nNGtrs8TRb6qbpA1f0F8xFbR1gWjVWPyUshtaHS7yNPHA==
X-Received: by 2002:a5d:8b0b:: with SMTP id k11mr14074813ion.213.1544576153694;
        Tue, 11 Dec 2018 16:55:53 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id l186sm1952445itl.22.2018.12.11.16.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:55:53 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH 11/11] staging: iio: adt7316: correct spelling of ADT7316_DA_EN_VIA_DAC_LDCA
Date:   Tue, 11 Dec 2018 17:55:03 -0700
Message-Id: <20181212005503.28054-12-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212005503.28054-1-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change LDCA to LDAC.

Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 58b462ad0c83..020d695ded97 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -119,7 +119,7 @@
  */
 #define ADT7316_ADCLK_22_5		0x1
 #define ADT7316_DA_HIGH_RESOLUTION	0x2
-#define ADT7316_DA_EN_VIA_DAC_LDCA	0x8
+#define ADT7316_DA_EN_VIA_DAC_LDAC	0x8
 #define ADT7516_AIN_IN_VREF		0x10
 #define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
 #define ADT7316_EN_EX_TEMP_PROP_DACB	0x40
@@ -847,7 +847,7 @@ static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
+	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC))
 		return sprintf(buf, "manual\n");
 
 	switch (chip->dac_config & ADT7316_DA_EN_MODE_MASK) {
@@ -876,7 +876,7 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 	u8 data;
 	int ret;
 
-	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
+	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC))
 		return -EPERM;
 
 	ret = kstrtou8(buf, 10, &data);
@@ -907,7 +907,7 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA)
+	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC)
 		return sprintf(buf, "0 - auto at any MSB DAC writing\n"
 				"1 - auto at MSB DAC AB and CD writing\n"
 				"2 - auto at MSB DAC ABCD writing\n"
@@ -929,7 +929,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 	u8 data;
 	int ret;
 
-	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA) {
+	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC) {
 		if ((chip->dac_config & ADT7316_DA_EN_MODE_MASK) !=
 			ADT7316_DA_EN_MODE_LDAC)
 			return -EPERM;
@@ -2128,7 +2128,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	}
 
 	if (!chip->ldac_pin) {
-		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
+		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDAC;
 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 			chip->config1 |= ADT7516_SEL_AIN3;
 	}
-- 
2.19.1

