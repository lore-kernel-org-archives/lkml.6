Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2865AC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10FB20833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="O13BlvRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfAaWHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:07:00 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36696 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbfAaWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:06:57 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so6885531itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XzbzY8HNj9z/jCN5u+k80meW/EpkfANG1HbnilXst1M=;
        b=O13BlvRITFJPUFKq8jtf3R6uL/Sm9/uWZo7Va7pfImWv9cao5NbE7fMJQ92YnPwHsM
         NucVSdYL72Bek2odDFcaQElYlAMWji87j1/Hk2ZNyLjK7BkyRFYqEDTVR5Ul3F1JZOI+
         2HWqqBZqgGt0xUf4pDxl82lKF0gG62Y6XpD3M5drAM9hGpDm9yXqHLl1TPRgIOzdoqN3
         RdoQFgHSRRTd7uhlzOcKmonOlW9sg46tUxgqBlZHWTcdJjGYgOruLvQHU16epqFdhK8x
         VLy118EKrZik2Bj7Rg/kS6wpP2iApIrMCyShxsXe9SMtoEwDA48Cg0E6PNSGltaJT5EI
         OJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XzbzY8HNj9z/jCN5u+k80meW/EpkfANG1HbnilXst1M=;
        b=bCl18mMP9s5LjB1EtyToUo6zCVjgj81GPMVCd/kiYkoCaPc0Ofw1c/1Gxyo9W9vJcj
         7bThmeEd4N9VzbXOcsubntIXm72J/UZNRo0MMDWUMGBuzb+1pWmeS0y82VwwsOkN6T5H
         x4cj9ESWRoWkCSEEh/ninuzy43b/zcKTbhU3rl3UXmtxIm3iRnvrVmAnVNZpyyudbi0I
         vxb64VEL2EKxcRHv5y+0TKcwtnAUnBAOpqknzpVGlfXImnORNsE9+e74iZkGJRX3FuGh
         ffnt5u1JkVuNkkpvD42Ir+blNhC114gtb/v/2dS1QRwhOIBYxSYEqP8OPzkKAd5COdNF
         y5aw==
X-Gm-Message-State: AJcUukeReNTlxip71KIqE+TUYIZgpXzM9bHsU2xcoaZb6H4uD1Z/l8OF
        OdEdAvvN2Uho5IYrA3Ga/H9rLjN6rpw=
X-Google-Smtp-Source: ALg8bN7FoCGIiZGVTUBg7cI/dUb73yOki1jwZa0MXgxBI2rI5wKBAvTTnROwMpzn2zFYDbLxdTLy6Q==
X-Received: by 2002:a02:4c55:: with SMTP id a82mr23173612jab.29.1548972416832;
        Thu, 31 Jan 2019 14:06:56 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id l186sm286439itl.22.2019.01.31.14.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 14:06:56 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: (lm85) remove freq_map size hardcodes
Date:   Thu, 31 Jan 2019 15:06:15 -0700
Message-Id: <20190131220617.15223-2-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131220617.15223-1-jgebben@sweptlaser.com>
References: <20190131220617.15223-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow support for chips that support more than 8 frequencies.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 drivers/hwmon/lm85.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 0a325878e..4b15193d1 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -198,13 +198,13 @@ static int RANGE_TO_REG(long range)
 #define RANGE_FROM_REG(val)	lm85_range_map[(val) & 0x0f]
 
 /* These are the PWM frequency encodings */
-static const int lm85_freq_map[8] = { /* 1 Hz */
+static const int lm85_freq_map[] = { /* 1 Hz */
 	10, 15, 23, 30, 38, 47, 61, 94
 };
-static const int adm1027_freq_map[8] = { /* 1 Hz */
+
+static const int adm1027_freq_map[] = { /* 1 Hz */
 	11, 15, 22, 29, 35, 44, 59, 88
 };
-#define FREQ_MAP_LEN	8
 
 static int FREQ_TO_REG(const int *map,
 		       unsigned int map_size, unsigned long freq)
@@ -212,9 +212,9 @@ static int FREQ_TO_REG(const int *map,
 	return find_closest(freq, map, map_size);
 }
 
-static int FREQ_FROM_REG(const int *map, u8 reg)
+static int FREQ_FROM_REG(const int *map, unsigned int map_size, u8 reg)
 {
-	return map[reg & 0x07];
+	return map[reg % map_size];
 }
 
 /*
@@ -296,6 +296,8 @@ struct lm85_data {
 	struct i2c_client *client;
 	const struct attribute_group *groups[6];
 	const int *freq_map;
+	unsigned int freq_map_size;
+
 	enum chips type;
 
 	bool has_vid5;	/* true if VID5 is configured for ADT7463 or ADT7468 */
@@ -514,7 +516,7 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			data->autofan[i].config =
 			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
 			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
-			data->pwm_freq[i] = val & 0x07;
+			data->pwm_freq[i] = val % data->freq_map_size;
 			data->zone[i].range = val >> 4;
 			data->autofan[i].min_pwm =
 			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
@@ -791,7 +793,8 @@ static ssize_t show_pwm_freq(struct device *dev,
 	if (IS_ADT7468_HFPWM(data))
 		freq = 22500;
 	else
-		freq = FREQ_FROM_REG(data->freq_map, data->pwm_freq[nr]);
+		freq = FREQ_FROM_REG(data->freq_map, data->freq_map_size,
+				     data->pwm_freq[nr]);
 
 	return sprintf(buf, "%d\n", freq);
 }
@@ -820,7 +823,7 @@ static ssize_t set_pwm_freq(struct device *dev,
 		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
 	} else {					/* Low freq. mode */
 		data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map,
-						 FREQ_MAP_LEN, val);
+						 data->freq_map_size, val);
 		lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 				 (data->zone[nr].range << 4)
 				 | data->pwm_freq[nr]);
@@ -1196,7 +1199,7 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
 		TEMP_FROM_REG(data->zone[nr].limit));
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		((data->zone[nr].range & 0x0f) << 4)
-		| (data->pwm_freq[nr] & 0x07));
+		| data->pwm_freq[nr]);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1232,7 +1235,7 @@ static ssize_t set_temp_auto_temp_max(struct device *dev,
 		val - min);
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		((data->zone[nr].range & 0x0f) << 4)
-		| (data->pwm_freq[nr] & 0x07));
+		| data->pwm_freq[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1569,9 +1572,11 @@ static int lm85_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	case emc6d103:
 	case emc6d103s:
 		data->freq_map = adm1027_freq_map;
+		data->freq_map_size = ARRAY_SIZE(adm1027_freq_map);
 		break;
 	default:
 		data->freq_map = lm85_freq_map;
+		data->freq_map_size = ARRAY_SIZE(lm85_freq_map);
 	}
 
 	/* Set the VRM version */
-- 
2.17.1

