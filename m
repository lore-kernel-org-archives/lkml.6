Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55A42086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+UZkc7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55A42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeIJWcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:32:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41992 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:32:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so17155289edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=c6Yq4mmjBI+HUcB7ikkW5uotP9DrYI+Gdl7GygbWCL8=;
        b=j+UZkc7miI9MnQ3MCvur5eQmCk7HS6W+TEiOj3l/PLLQwTNpb1jY/MtUJcyrAXYrcR
         GfjrplwC1c/NiLfjsvJIUhI3AGpgRyWboAvUlgiXM4s5/BOafSaCJ+QL1IlVLcY5WKE6
         SAA+ITyrOIg6UwvxBurdRQBZigZsXtGuNBwaEU+nhPaTGtU5bEpkOQAvBBW6VMOUnHR+
         NifvbfYciw7HOAq5LoVuBph1KdIsIrPqM1Jdvs88OZ5aIOglqnNBz6oiCdD7cfQl8tPn
         2j6BvK+o+rfiLEHre6er9YkihtWXZJ1EcEnVpE6DoL1g/vgmxrVM8R+6qDQVtAu1qgTW
         d4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:from:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=c6Yq4mmjBI+HUcB7ikkW5uotP9DrYI+Gdl7GygbWCL8=;
        b=gH1iz1ZkzB/m9J2avYCUb0EYNhhUZyzah72gLAARdsH7SGD87tOd0awNoA5M9EzaGJ
         ael6/Mk/hnSwY1815QQldFtvROrXw14Cm0UWlkhVWKi0pG6g0dXxeEQWq1xhBZxfLq61
         lYLrmmeCX69asjgbpV7RRmFSXz/LQgDVAfC1CPjvsNgIndAgRecIAqGv+FPAP9OiukBv
         yWqEzMRnG9CUNSZ7Kbwl1O1e0Ja+JO0KcVMYT/Rhzx/XWfKy7dxTDNuusRAvD06WW2aQ
         WNo2wkr5T7/XRDjogZaT4abYuOsAyrHwpgNXs0JLXmHHv5Z/P/qBkrab+z+V22zm8i9T
         JYSQ==
X-Gm-Message-State: APzg51BBIJID6iLRcQJio0s6B4Ftz+iZrAm/IKy6DO58zzT0h/a2sL1J
        7T5HRqdhTp081cLL/9DGg4s=
X-Google-Smtp-Source: ANB0VdY8c/BbeUXf5ZZEmAeiScJJoEPV4/YAxsxPtzfHcpVimKgSTpcxo4ZVMbL2baT0+dTFmr/tnw==
X-Received: by 2002:a50:b53a:: with SMTP id y55-v6mr25357290edd.191.1536601013663;
        Mon, 10 Sep 2018 10:36:53 -0700 (PDT)
Received: from [192.168.1.88] ([194.230.155.198])
        by smtp.googlemail.com with ESMTPSA id g20-v6sm7471875edm.36.2018.09.10.10.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 10:36:52 -0700 (PDT)
Subject: [PATCH] IAD Register is yet readable trough iad sys file. Fix
 snprintf (%u for unsigned, count for max size).
To:     linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, manio@skyboo.net
From:   Julien Folly <julien.folly@gmail.com>
X-Forwarded-Message-Id: 
Message-ID: <54c2ec84-8057-3ee2-0f68-684d6b589e64@gmail.com>
Date:   Mon, 10 Sep 2018 19:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

