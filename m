Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01323ECDFAC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A1121479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHiTeurX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A1121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJJBFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:05:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34001 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJBFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:05:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id w19-v6so2508789eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Tla7pet3I34OcZVjHR/nVD2DOu8/NEoCygp2kvsRcLk=;
        b=LHiTeurXHw5zBDt9EG9NrrHzNXD5dmN2YHEmWBuy5OZnUZum1M8ykc8jvPRAmNX9+L
         ybYI8sjMhrW0Ky5ar3AuhDN+fEf3Ai29k3qy7INRVsAZ/s4gC17oAP834v3DUMfK+Odm
         FxSjRZ6+RGzM5bcrfaGPkSnjruJJuKZ0H4kjDL/e9usWZAXDn0hfKjFmqHV7QHYqtPzI
         w4+bADXOkAKxGBzDjNL06xStJuMlvJCd14ro/Eac26Rl6rqkiQDtmUDzqw5rWvZt2/AM
         i5c2RkmQVkxBp91ptbP5LH09LVt9uURAHRgAAF3YyXwgMgIGzhd0MVGHZJY17dj+xDf0
         n+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Tla7pet3I34OcZVjHR/nVD2DOu8/NEoCygp2kvsRcLk=;
        b=Aq6w2d9rOwkReYOtGU6edX2vkROw/JhZZ7QJV8gjEDqLo4TqMc/ez2OjJu0uwjYRjT
         n56wZjYjyq2hmBYlXCg5b5OFmsoI1IOVCWmmh+HApWpp9xxuVY9c/5edGdzcSWzwWsM7
         wHLduY1cjn1YpSI8XStf4+Swo8olCePJjLSA/i2i0rIY4gfPt+MiLcLTrmWYdOjhMXgw
         Rt2YS4TsWF/FsTeE4XBk3UWxSYQtGx1q57uPTrsVa1yqmbIdgZenKaZd4+K2aC5/Z9FO
         q2sRqchQuYZkcjVjJcjOdIwravrYMmtZPQN0oHfaPFTz1ysALhRNjJw/7X3Y9Z5I+Pjq
         SgCQ==
X-Gm-Message-State: ABuFfogZOYJh57+YvcQg7JyNcxQkQi8TVbYXLL77Uuiut6SFZzleYf5d
        8WrVgF13SUH+/reaVXCivQfGkKnhEtw=
X-Google-Smtp-Source: ACcGV61NbMLhy1sPZmNQHwPHjSDvvAMJSg4tFYvrZt9geBrbvPn5KEHkPC3J2T7R4qR2AUiXdptgvw==
X-Received: by 2002:aa7:d58a:: with SMTP id r10-v6mr37747457edq.161.1539107266886;
        Tue, 09 Oct 2018 10:47:46 -0700 (PDT)
Received: from [192.168.1.88] ([194.230.158.33])
        by smtp.googlemail.com with ESMTPSA id g13-v6sm2358516edv.48.2018.10.09.10.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 10:47:46 -0700 (PDT)
Subject: [PATCH] IAD Register is yet readable trough iad sys file. Fix
 snprintf (%u for unsigned, count for max size).
References: <af443df9-b919-24ee-70ac-dbc80566f787@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, manio@skyboo.net
From:   Julien Folly <julien.folly@gmail.com>
X-Forwarded-Message-Id: <af443df9-b919-24ee-70ac-dbc80566f787@gmail.com>
Message-ID: <1e173939-d95d-c94f-971d-99ff84eb8eb1@gmail.com>
Date:   Tue, 9 Oct 2018 19:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <af443df9-b919-24ee-70ac-dbc80566f787@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IAD Register is yet readable trough the "iad" sys file.

A write to the "iad" sys file enables or disables the current
measurement, but it was not possible to get the measured value by
reading it.
Fix: %u in snprintf for unsigned values (vdd and vad)
Fix: Avoid possibles overflows (Usage of the 'count' variables)

Signed-off-by: Julien Folly <julien.folly@gmail.com>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
---
  drivers/w1/slaves/w1_ds2438.c | 66 ++++++++++++++++++++++++++++++++++---------
  1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index bf641a1..7c4e33d 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -186,8 +186,8 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
  	return -1;
  }
  
-static uint16_t w1_ds2438_get_voltage(struct w1_slave *sl,
-				      int adc_input, uint16_t *voltage)
+static int w1_ds2438_get_voltage(struct w1_slave *sl,
+				 int adc_input, uint16_t *voltage)
  {
  	unsigned int retries = W1_DS2438_RETRIES;
  	u8 w1_buf[DS2438_PAGE_SIZE + 1 /*for CRC*/];
@@ -235,6 +235,25 @@ static uint16_t w1_ds2438_get_voltage(struct w1_slave *sl,
  	return ret;
  }
  
+static int w1_ds2438_get_current(struct w1_slave *sl, int16_t *voltage)
+{
+	u8 w1_buf[DS2438_PAGE_SIZE + 1 /*for CRC*/];
+	int ret;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	if (w1_ds2438_get_page(sl, 0, w1_buf) == 0) {
+		/* The voltage measured across current sense resistor RSENS. */
+		*voltage = (((int16_t) w1_buf[DS2438_CURRENT_MSB]) << 8) | ((int16_t) w1_buf[DS2438_CURRENT_LSB]);
+		ret = 0;
+	} else
+		ret = -1;
+
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
  static ssize_t iad_write(struct file *filp, struct kobject *kobj,
  			 struct bin_attribute *bin_attr, char *buf,
  			 loff_t off, size_t count)
@@ -257,6 +276,27 @@ static ssize_t iad_write(struct file *filp, struct kobject *kobj,
  	return ret;
  }
  
+static ssize_t iad_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	int ret;
+	int16_t voltage;
+
+	if (off != 0)
+		return 0;
+	if (!buf)
+		return -EINVAL;
+
+	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+		ret = snprintf(buf, count, "%i\n", voltage);
+	} else
+		ret = -EIO;
+
+	return ret;
+}
+
  static ssize_t page0_read(struct file *filp, struct kobject *kobj,
  			  struct bin_attribute *bin_attr, char *buf,
  			  loff_t off, size_t count)
@@ -272,9 +312,13 @@ static ssize_t page0_read(struct file *filp, struct kobject *kobj,
  
  	mutex_lock(&sl->master->bus_mutex);
  
+	/* Read no more than page0 size */
+	if (count > DS2438_PAGE_SIZE)
+		count = DS2438_PAGE_SIZE;
+
  	if (w1_ds2438_get_page(sl, 0, w1_buf) == 0) {
-		memcpy(buf, &w1_buf, DS2438_PAGE_SIZE);
-		ret = DS2438_PAGE_SIZE;
+		memcpy(buf, &w1_buf, count);
+		ret = count;
  	} else
  		ret = -EIO;
  
@@ -289,7 +333,6 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
  {
  	struct w1_slave *sl = kobj_to_w1_slave(kobj);
  	int ret;
-	ssize_t c = PAGE_SIZE;
  	int16_t temp;
  
  	if (off != 0)
@@ -298,8 +341,7 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
  		return -EINVAL;
  
  	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
-		c -= snprintf(buf + PAGE_SIZE - c, c, "%d\n", temp);
-		ret = PAGE_SIZE - c;
+		ret = snprintf(buf, count, "%i\n", temp);
  	} else
  		ret = -EIO;
  
@@ -312,7 +354,6 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
  {
  	struct w1_slave *sl = kobj_to_w1_slave(kobj);
  	int ret;
-	ssize_t c = PAGE_SIZE;
  	uint16_t voltage;
  
  	if (off != 0)
@@ -321,8 +362,7 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
  		return -EINVAL;
  
  	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
-		c -= snprintf(buf + PAGE_SIZE - c, c, "%d\n", voltage);
-		ret = PAGE_SIZE - c;
+		ret = snprintf(buf, count, "%u\n", voltage);
  	} else
  		ret = -EIO;
  
@@ -335,7 +375,6 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
  {
  	struct w1_slave *sl = kobj_to_w1_slave(kobj);
  	int ret;
-	ssize_t c = PAGE_SIZE;
  	uint16_t voltage;
  
  	if (off != 0)
@@ -344,15 +383,14 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
  		return -EINVAL;
  
  	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
-		c -= snprintf(buf + PAGE_SIZE - c, c, "%d\n", voltage);
-		ret = PAGE_SIZE - c;
+		ret = snprintf(buf, count, "%u\n", voltage);
  	} else
  		ret = -EIO;
  
  	return ret;
  }
  
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, NULL, iad_write, 1);
+static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
  static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
  static BIN_ATTR_RO(temperature, 0/* real length varies */);
  static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.7.4

