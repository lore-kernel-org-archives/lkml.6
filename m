Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BC2C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F8B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="N2WHyfGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfA3QPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:15:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51498 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfA3QPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:15:02 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so139383ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yrq93au3oJ2dDM7QTKg4qsC2yIDdT7nuUkBxd+KI7Ck=;
        b=N2WHyfGnz0FXfh9XYdxqt5P55gq8ixYlS5bBxzI18t56btVqdiw48LD8CamOF+xv/9
         1UqOiiBSQGxByk/5Nn81AECQkzksMrwyH0m618LIbq6e7E3Vu35s+T2idZnWBZLPGUMY
         jIZ9+E8dxoHkxq3g3OisSXCursJLvhnJjI5OfS+9QnnbgiOa7DEtGzSqNxvxEwLYgzPx
         XEklNAcaot9HPnNKRqxDJuAonKtuB82ySmJFMq1xqm/tOjfihFlg/N/CSZ3zW4n6w+nM
         i4+Ac61u/octZWczU6UK9CFSA4XssjXP1P95mzgetrAv/RTrE7iPGrg2y37R18r9jpIa
         RdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yrq93au3oJ2dDM7QTKg4qsC2yIDdT7nuUkBxd+KI7Ck=;
        b=VoHMsydjQ2GQ+sA0Rz07sQpSoEFmIP4RfATWQhmLgxjyoveHbAb16/UbpNtRStZqsh
         /HEL1IQY93JUu5JcV096cS0tWrPupYx6JQ+ga6c1c0V2nZRKWZa6zR4UO3KWVz0SEmcy
         YSi9CqZ6aeZCfajBF8qqCWpImnxtCzWbHC5S4aCLeLALXk78bWos8YU7ZpFSPZPTv4dV
         0wOj34Vx6JB4BFyVBSjVSArOOaJVFCjhMEgyPT0pqlGIBdhDo8+OqCEwIA5Xejl2WH9s
         zvG3MVQsDeGpfuAeCU8Ve+E4tdNKqL0vj23rE2BvyJbhJIHJywQJoR0j+vXSMGJ9MGYY
         BXsA==
X-Gm-Message-State: AJcUukcMVR3BTmr8K8ffbJeVF2R91fh3KVQhe3UOcdFJenLRAfIWTLkA
        o8OfyUfmsfQzzoshEHhqnojhUQ==
X-Google-Smtp-Source: ALg8bN7tQLMuCew9n4iSOOWyqdnYoMWjvEC1dFlpH33Rr5cpmNErLq1pd62L//HM/hM5OHH04pKLEQ==
X-Received: by 2002:a05:660c:3c7:: with SMTP id c7mr13602440itl.131.1548864900873;
        Wed, 30 Jan 2019 08:15:00 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id 15sm838678iog.59.2019.01.30.08.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 08:15:00 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 1/3] hwmon: (lm85) remove freq_map size hardcodes
Date:   Wed, 30 Jan 2019 09:14:45 -0700
Message-Id: <20190130161447.19946-1-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129212920.27921-1-jgebben@sweptlaser.com>
References: <20190129212920.27921-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Allow support for chips that support more than 8 frequencies.
The size still must be a power of two.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 drivers/hwmon/lm85.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 0a325878e8f5..48f59667a88c 100644
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
+	return map[reg & (map_size - 1)];
 }
 
 /*
@@ -296,6 +296,8 @@ struct lm85_data {
 	struct i2c_client *client;
 	const struct attribute_group *groups[6];
 	const int *freq_map;
+	unsigned int freq_map_mask;
+
 	enum chips type;
 
 	bool has_vid5;	/* true if VID5 is configured for ADT7463 or ADT7468 */
@@ -514,7 +516,7 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			data->autofan[i].config =
 			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
 			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
-			data->pwm_freq[i] = val & 0x07;
+			data->pwm_freq[i] = val & data->freq_map_mask;
 			data->zone[i].range = val >> 4;
 			data->autofan[i].min_pwm =
 			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
@@ -791,7 +793,8 @@ static ssize_t show_pwm_freq(struct device *dev,
 	if (IS_ADT7468_HFPWM(data))
 		freq = 22500;
 	else
-		freq = FREQ_FROM_REG(data->freq_map, data->pwm_freq[nr]);
+		freq = FREQ_FROM_REG(data->freq_map, data->freq_map_mask + 1,
+				     data->pwm_freq[nr]);
 
 	return sprintf(buf, "%d\n", freq);
 }
@@ -820,7 +823,7 @@ static ssize_t set_pwm_freq(struct device *dev,
 		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
 	} else {					/* Low freq. mode */
 		data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map,
-						 FREQ_MAP_LEN, val);
+						 data->freq_map_mask + 1, val);
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
+		data->freq_map_mask = ARRAY_SIZE(adm1027_freq_map) - 1;
 		break;
 	default:
 		data->freq_map = lm85_freq_map;
+		data->freq_map_mask = ARRAY_SIZE(lm85_freq_map) - 1;
 	}
 
 	/* Set the VRM version */
-- 
2.17.1

