Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 59426C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B6208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR+Of7qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5B6208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeFLDbh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:31:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42049 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbeFLDbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:31:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so11320401pfn.9;
        Mon, 11 Jun 2018 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iUn5c6aafdlTZaO1jFoZ5EmuAqZIUkHskaPyuidu2L0=;
        b=gR+Of7qEBtT/VJuEVqqEsimWdBmy7dwFhuunhWUfteQljGLnBaqV3kOSmyFNVNIPLx
         3ukulCkUJsiXWuYa5iuQxXwIQjVZsKGX2U4Dt27hdlEr9kVe7jS7wT+o1q+m7KhaSF0n
         +jGKYtTlgTnnv/zqKx/5n5vwv7Eh3kfpTOrpDagIytoekh13T1mpvNP2YeLcUJkCmyEG
         M04o0wWdb8Cp3bKTSRCIVBpZOWobFP2lcqGFot1o9VXRairGjMENJq3TeQR2TD+hrMba
         0+sOOgdGKx6NIdMF0reHYirISTYrKdcHClOzkUZAKnG1wDhnSaZU2jLlRuL7MNxAirhI
         1PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iUn5c6aafdlTZaO1jFoZ5EmuAqZIUkHskaPyuidu2L0=;
        b=F3Z8qmjf62eOdII9p99+77GBSpNAAhY/mfr46jWP5W67aYi9i8WDPap+UArYMZM8yR
         AB1R4wFOmw0QumslPhHjcnodse2grGwuGx73picX9Lzm5MWKXbbjEjWM3A/eMC1ommDG
         EWSF+S4xPclczI4qYXFxQUKgImNBADb5YJhBjsNPWknzmI03GxIShmUEU0Lfsd4r+35v
         TwL9TzjfPSW7oLVSRS24vgKDiIWPpPo0UjXDYLWVXH/1tNZZlOQQmlfDNpk2o59YoqRB
         PmZ1fnykrg7Yn8nGm+0leGB6ENdbyeLHYsPiy8ozrEwR3KOul5q1vmv/78Wxd6lDkUYr
         +JuQ==
X-Gm-Message-State: APt69E1ENDXX6M55f9BJlM5qDGpKPYmHviD1XuKtp+hSCKZ2lBNjwl+D
        8ASmS/Sn4xIWo8YhRjw0CWSusyICsUA=
X-Google-Smtp-Source: ADUXVKKsHJtnNKvDl+tKEMUJU7n7YPs6Dnp2ur6ZYqUWNVOU+VXaXuPCHez7KgmApfG1u3BHxzZlXQ==
X-Received: by 2002:a65:6101:: with SMTP id z1-v6mr1614989pgu.282.1528774295711;
        Mon, 11 Jun 2018 20:31:35 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id l11-v6sm7280641pgp.56.2018.06.11.20.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:31:35 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (w83792d) add error handling for i2c_new_dummy
Date:   Tue, 12 Jun 2018 11:31:28 +0800
Message-Id: <1528774289-38443-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When i2c_new_dummy fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling i2c_new_dummy.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/hwmon/w83792d.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 76aa39e..2c168c5 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -961,8 +961,15 @@ w83792d_detect_subclients(struct i2c_client *new_client)
 	}
 
 	val = w83792d_read_value(new_client, W83792D_REG_I2C_SUBADDR);
-	if (!(val & 0x08))
+	if (!(val & 0x08)) {
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (val & 0x7));
+		if (data->lm75[0] == NULL) {
+			dev_err(&new_client->dev,
+				"Failed to allocate I2C device\n");
+			err = -ENODEV;
+			goto ERROR_SC_1;
+		}
+	}
 	if (!(val & 0x80)) {
 		if ((data->lm75[0] != NULL) &&
 			((val & 0x7) == ((val >> 4) & 0x7))) {
@@ -974,6 +981,12 @@ w83792d_detect_subclients(struct i2c_client *new_client)
 		}
 		data->lm75[1] = i2c_new_dummy(adapter,
 					      0x48 + ((val >> 4) & 0x7));
+		if (data->lm75[1] == NULL) {
+			dev_err(&new_client->dev,
+				"Failed to allocate I2C device\n");
+			err = -ENODEV;
+			goto ERROR_SC_1;
+		}
 	}
 
 	return 0;
-- 
2.7.4

