Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 13151C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9669208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDa3Mo7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9669208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeFLDdG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:33:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38017 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbeFLDdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:33:05 -0400
Received: by mail-pl0-f67.google.com with SMTP id b14-v6so13540994pls.5;
        Mon, 11 Jun 2018 20:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ySuK22Ip9p+jnigLvEr6MmgwCVrgakUH52/VhA/xDE0=;
        b=SDa3Mo7CH8jYYJScys7SbBcXjEA2mdNg74rmolInalXi1HOtlVLYaTZAMdOk5ZdOaA
         uXeK8ZFUiwnk1bBG5QE7xCQZ+rMbUnyTeymtcboFWxDi3hmxtMPGcvclrqRTf3K53VSb
         glgs8BEG0hmJZWMDfB2waETwfAbOrjHESj8yTyVotMOdUVXi7KasCbylOjidR11VsEub
         x+72u3yYoscc5noGTWxg655KAIZSU2uXVZxrFC8YEKHGAndH/YFoo6yrlULvxQIs84tS
         T6VD2MIgcsrWJn4LDyz2DhdXvK1jC0x5b32Q7ULqUyjVl8uzFwty/pcAuBPTzMu2Uk2I
         eQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ySuK22Ip9p+jnigLvEr6MmgwCVrgakUH52/VhA/xDE0=;
        b=mBivZT5rGeBIQE3gCXagHHPCMOcsrKstKvfUWqMRwBdjMDOCTJkmx/kL2X8+PDoO8g
         0oXOFycXIrntabONv+dnHiiBQmXEoAWqCOcIKEhAyDPA+RzmZg762e2ELMiTesimMvzv
         I5CzhxuGK/jy4rjY4C2FdDGqC+D3NgM/28bZ6NAg7bSjgVV8swlGvfHM7Nn/rtAsgaB2
         0zTiVGz83Yv/enMGKKhGga5J25mVNY654vL2+Wp3Jm6GIwKVu90Re/DcuwAQRwmHdDoY
         Pb1BgUURXq/RS/EvyqhZfmuODclEKC4uhLt3yXv5ELRAosHHlNB6OsPwlry5TrZkgSo7
         TjhQ==
X-Gm-Message-State: APt69E1Wu3npx0YrOYvnsDUpfCKGNmYrZzG/H8BIXODBr++aJ6Wb+gx2
        f94jnCmT7QN2E2fOxDF3hcQ=
X-Google-Smtp-Source: ADUXVKJt8Hk+9PWExi7IAW+wa6z4MwClAavxf6e8XAnDr++hLCd8GXccJsKx/DV2a5mxxsBwIalO0Q==
X-Received: by 2002:a17:902:23:: with SMTP id 32-v6mr2073000pla.252.1528774384921;
        Mon, 11 Jun 2018 20:33:04 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id c12-v6sm41219970pfi.177.2018.06.11.20.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:33:04 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (w83793) add error handling for i2c_new_dummy
Date:   Tue, 12 Jun 2018 11:32:59 +0800
Message-Id: <1528774379-38587-1-git-send-email-jiazhouyang09@gmail.com>
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
 drivers/hwmon/w83793.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 0af0f62..4aa3a0e 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1603,8 +1603,15 @@ w83793_detect_subclients(struct i2c_client *client)
 	}
 
 	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
-	if (!(tmp & 0x08))
+	if (!(tmp & 0x08)) {
 		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (tmp & 0x7));
+		if (data->lm75[0] == NULL) {
+			dev_err(&client->dev,
+				"Failed to allocate I2C device\n");
+			err = -ENODEV;
+			goto ERROR_SC_1;
+		}
+	}
 	if (!(tmp & 0x80)) {
 		if ((data->lm75[0] != NULL)
 		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
@@ -1616,6 +1623,12 @@ w83793_detect_subclients(struct i2c_client *client)
 		}
 		data->lm75[1] = i2c_new_dummy(adapter,
 					      0x48 + ((tmp >> 4) & 0x7));
+		if (data->lm75[1] == NULL) {
+			dev_err(&client->dev,
+				"Failed to allocate I2C device\n");
+			err = -ENODEV;
+			goto ERROR_SC_1;
+		}
 	}
 
 	return 0;
-- 
2.7.4

