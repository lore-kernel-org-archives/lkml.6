Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F10C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31A0217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Kh8DXy/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbeLUGN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:13:28 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:45238 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeLUGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:13:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id A1DF5CEE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6t9Fn9iJFma3 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 00:13:26 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 771A3181
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:13:26 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id h7so3492585iof.19
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 22:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u88FTJY/1v8GAJsUCbqLzQrxjdlKlV6z9U/6eA7D1cQ=;
        b=Kh8DXy/eZPmI3pI+0rdGUsBcC7F2egsqteyxGqmf+Gz8lVMGUKNKDD2CRwfIuR/qFO
         yO/Io+o6W1So3zc3bf2DD48enqJGD1gOnDp0vXYfbJqd3g5Gb3/XQMjf4KC7ZV2/0Ykk
         6QufFTaGD0cs126KwPQD5i/l7uu+f2poA0pL1oFwFJuJPZ3JNO1vSr9efdUrqT9cOeR+
         TASZ3GUwjl3xFJOx8PxhFEmCq081kVAnfnPkqe+tGEFYQHo655a96pt9Vn043v92GDaS
         HKIOPV2B9wiVozSvee3lB8BNwQhoaEDSCYbpUoRBYjlK8eNW2q5HIwX93YI17WIlS7wt
         cDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u88FTJY/1v8GAJsUCbqLzQrxjdlKlV6z9U/6eA7D1cQ=;
        b=O+0T5PqjnGkhvZZ81UpnHUaKSxxK8dWi+Ed1yHEmKg8OUqEOvnqKcek7xd9+yrXLtz
         qQCJXVxZDY1PimwweK0CDYauqXr5bMCCidjAwuO1kjooajiW7UI4CCWIgfqD9QkvmlEI
         zbMaAy1stOavImRPZZSa6jRVRa3UHLZrbROXb7lXxxp4iNjBcfPy8XOJgL8H0K05CW3c
         UVmI6iYE+iI8/AequgNgTaQqFWoumtyzW7YMwOSAWyZUP1doJWsOURuX3bNhHh0FTPwc
         1r7rVOKilg5EyOnBGLtlQT/LCCY3DpCXcTofEHu3ntcUOXzMKKQ+EtCdIZv82KYRC0ZA
         augQ==
X-Gm-Message-State: AJcUukfG709Cyx9U7FTujGoTaAem3bsy8YbmW9ikWyWmfEewZtzsXqnA
        LXHuMZ2oczNhnj7391Uq9mRegv7Bs0jC2Dovv6zQfOTtCLaiB4YL5QjPo2LuWt27sveKzxNsMvT
        ZTW4mG/oLFmVxRwv4a7erlW3QbaDa
X-Received: by 2002:a5d:94c8:: with SMTP id y8mr274599ior.285.1545372806066;
        Thu, 20 Dec 2018 22:13:26 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6T5h6lhFjSvNzhWY4zSHbX8rUTiOekEMraQIKztngTx73T31KyEf54n7HVXdbhgUVhK8I7Zw==
X-Received: by 2002:a5d:94c8:: with SMTP id y8mr274591ior.285.1545372805722;
        Thu, 20 Dec 2018 22:13:25 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id a16sm10381370ioh.48.2018.12.20.22.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 22:13:24 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: lm80: fix a missing check of return value
Date:   Fri, 21 Dec 2018 00:13:03 -0600
Message-Id: <20181221061304.59684-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If lm80_read_value() fails, it returns a negative number instead of the
correct read data. Therefore, we should avoid using the data if it
fails.

The fix checks if lm80_read_value() fails, and if so, returns with the
error number.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/hwmon/lm80.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 08e3945a6fbf..fca6363cd77f 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -360,9 +360,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = data->client;
 	unsigned long min, val;
 	u8 reg;
-	int err = kstrtoul(buf, 10, &val);
-	if (err < 0)
-		return err;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret < 0)
+		return ret;
 
 	/* Save fan_min */
 	mutex_lock(&data->update_lock);
@@ -390,8 +392,11 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	reg = (lm80_read_value(client, LM80_REG_FANDIV) &
-	       ~(3 << (2 * (nr + 1)))) | (data->fan_div[nr] << (2 * (nr + 1)));
+	ret = lm80_read_value(client, LM80_REG_FANDIV);
+	if (ret < 0)
+		return ret;
+	reg = (ret & ~(3 << (2 * (nr + 1))))
+	      | (data->fan_div[nr] << (2 * (nr + 1)));
 	lm80_write_value(client, LM80_REG_FANDIV, reg);
 
 	/* Restore fan_min */
-- 
2.17.2 (Apple Git-113)

