Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB7ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C6A2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfWeciy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C6A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJRGYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:24:37 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:36638 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeJRGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:24:36 -0400
Received: by mail-it1-f202.google.com with SMTP id p125-v6so3965187itg.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=p8DLWVPHFdDh+XLJZJQGOyjP3fo46ff91OpQ4glEXl4=;
        b=bfWeciy/6udWJikIHpD/LgP+JWGKXe0ZOriVFNXcXy4bAFPQ3KXUm3Uv+fp6p+LDiq
         ZTqPEvrS/7/S+YJn/oKBkQhKENmairZrPOsrCvTv1yxY24upudsrd/eBy9yMpGdifLm9
         d87MC0BlpB27xSQTMBqK452DLHIFglVSSyWap0TvThozxiBhnVPeeRNlPdfLMtQET0Xh
         sGkC0jiPFqqd6nVHfdKQev2bjuC46Oi7BS4SpntJxmEM9Bn6UkxvxXg/oRY2ijBLLKO9
         8g7rLl9+zh6SOqG1Gj44E9X3PqZZSecBL8gyRg7OP+akcCVSlXFjhjmP+HrkazA4WJbs
         ydPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=p8DLWVPHFdDh+XLJZJQGOyjP3fo46ff91OpQ4glEXl4=;
        b=oR1yNVEPjY3MbwwRjNmK1bONb/UwMJxGjGCYqBhN5VE1STx6AiK9Mv3iEm+uut6ggf
         QRv+TlCUIkunJhig5+zd/Un+5+r3F8Jt2t416Qhe08iCiCHNZdEtk+KLb1GcXMzlgFo6
         EkjBHFaJpEVCz0ugyF+iBml+REtEygGM5hLEUCB5rdbe49sBkrj+DgwcOkI97broSN+H
         KXZIQGGFiV5uHsUNxYSWqnm3L/1eNxwFflG+uhLvPAxP1AzBwaRKZJtNT6JCM3oqvHgw
         u703FXRFFAkH/62n0QGL0FHl7VdQ/m9ZCe3we9I3/GfiZ49CCXLi2PBwHGlU+UYldqyy
         mIvw==
X-Gm-Message-State: ABuFfohxMiyjPLNeSkcnv1tvqcsiu90tRupMwsc7XFuRwiTLpvcWfciv
        URwj4ZHh+99KlfKlWNaUmTj90Uf2wQ==
X-Google-Smtp-Source: ACcGV60Vh6hxtijV8dVp1Z0QoZIdErAIy7LyqiVmuvuBbcDXP95iUA3UyyD7dye7dxVIAExsCdztnwfH1w==
X-Received: by 2002:a05:660c:310:: with SMTP id u16mr3422596itj.1.1539815210606;
 Wed, 17 Oct 2018 15:26:50 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:26:39 -0700
Message-Id: <20181017222639.254434-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [PATCH v3 1/2] hwmon: (adm1275): Allow setting shunt reg value
From:   Kun Yi <kunyi@google.com>
Cc:     openbmc@lists.ozlabs.org, kunyi@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADM series of hotswap controllers support extending
the current measurement range by using a sensing resistor
value other than the typical 1 mOhm. For example, using a 0.5 mOhm
sensing resistor doubles the maximal current can be measured.

Current driver assumes a shunt resistor value of 1 mOhm in calculation,
meaning for other resistor values, hwmon will report scaled
current/power measurements. This patch parses device tree parameter
"shunt-resistor-micro-ohms", if there is one.

Signed-off-by: Kun Yi <kunyi@google.com>
---
Changes in v3:
- splitted hwmon and device tree binding patches

 Documentation/hwmon/adm1275   |  3 +++
 drivers/hwmon/pmbus/adm1275.c | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index 39033538eb03..5e277b0d91ce 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -58,6 +58,9 @@ The ADM1075, unlike many other PMBus devices, does not support internal voltage
 or current scaling. Reported voltages, currents, and power are raw measurements,
 and will typically have to be scaled.
 
+The shunt value in micro-ohms can be set via device tree at compile-time. Please
+refer to the Documentation/devicetree/bindings/hwmon/adm1275.txt for bindings
+if the device tree is used.
 
 Platform data support
 ---------------------
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 13600fa79e7f..f569372c9204 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -373,6 +373,7 @@ static int adm1275_probe(struct i2c_client *client,
 	const struct coefficients *coefficients;
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
+	u32 shunt;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_READ_BYTE_DATA
@@ -421,6 +422,13 @@ static int adm1275_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
+	if (of_property_read_u32(client->dev.of_node,
+				 "shunt-resistor-micro-ohms", &shunt))
+		shunt = 1000; /* 1 mOhm if not set via DT */
+
+	if (shunt == 0)
+		return -EINVAL;
+
 	data->id = mid->driver_data;
 
 	info = &data->info;
@@ -654,12 +662,15 @@ static int adm1275_probe(struct i2c_client *client,
 		info->R[PSC_VOLTAGE_OUT] = coefficients[voindex].R;
 	}
 	if (cindex >= 0) {
-		info->m[PSC_CURRENT_OUT] = coefficients[cindex].m;
+		/* Scale current with sense resistor value */
+		info->m[PSC_CURRENT_OUT] =
+			coefficients[cindex].m * shunt / 1000;
 		info->b[PSC_CURRENT_OUT] = coefficients[cindex].b;
 		info->R[PSC_CURRENT_OUT] = coefficients[cindex].R;
 	}
 	if (pindex >= 0) {
-		info->m[PSC_POWER] = coefficients[pindex].m;
+		info->m[PSC_POWER] =
+			coefficients[pindex].m * shunt / 1000;
 		info->b[PSC_POWER] = coefficients[pindex].b;
 		info->R[PSC_POWER] = coefficients[pindex].R;
 	}
-- 
2.19.1.331.ge82ca0e54c-goog

