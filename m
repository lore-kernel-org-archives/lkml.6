Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA718C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7856B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFTqonkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfARODq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:03:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51462 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfARODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4618462wmj.1;
        Fri, 18 Jan 2019 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7Ai0hltg2jalPdM8DZ6LIbqR1s61sezTuxMf4F3h7I=;
        b=VFTqonkvdFADx/zms1yRuBIFRbi79hFhXVsaEYJbVAkJWYqlTgDLYefVjgziLNb0P8
         w1Ngu+7kXmZOoh//mKJQjG16H7DsWZwj2kbsCP6o9U8l9dCzwFzNt1Po4QaShTYja1bg
         lKJjHw/93AjrUTgdLb3+plwvo1qv3l2RsaSSbzYhnS5KYs5SVlc23D8CSbzyiQPRMsZ9
         kOHI5oT5kyIoZfGG56NMDuhJEhbdSswcm4ZTWtIPFrOcP1TBidNYhDANZJbG0YsfR0rn
         TrS2V5pnK3EFGIGQR/hydt4IyO6SaKQjT6aVV5IlHMXX/T/TMylS4rTB8pD8FHUfMy7g
         y/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7Ai0hltg2jalPdM8DZ6LIbqR1s61sezTuxMf4F3h7I=;
        b=rJviwlOVK5SCunIMniwKZpQSaPiGhbOJcYKf78HpzkR4vKXYT1e8VYy4+I1msda/xk
         WXtV5buTlrdLYa32AhYs8gX6GDeSK/NoK7udK5Zv9apQxpl+kMXeV8jd9dX0K83hqk+e
         BosWVkclbio4fCjQniZHKR7a3N+hPG1KCckdcnjHB2Dw1CF7RqOdnRDj/qlL3juuxoWo
         pef8c/iq3F9xTk4Tvo34k9t9e4+kDMjiG3cpMfQuZoqrMVdeZkilw627X1dTXT1/xDwq
         uNgK4Kk5GF3D+DGHCCqjc7XRZ25Q7zP6oV7HdTQbWPLO95ErfDzBbYmi7cYtznCPAVN4
         MY/Q==
X-Gm-Message-State: AJcUukfcAJn/mJuOc3hKnxwhZI8e0j4RQ15gfJCi1eV7qv6VeOvOQ2Xu
        XH+j7mVNhkC15qxjDSPgMps=
X-Google-Smtp-Source: ALg8bN61yhfhaVfJZB5OHdnPNJtooAJF3HS3D61o39/mudIqtH5joxBW5n45rul7F23Wn10eDdFLpg==
X-Received: by 2002:a1c:8548:: with SMTP id h69mr14987483wmd.11.1547820222613;
        Fri, 18 Jan 2019 06:03:42 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:42 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 6/7] hwmon: adm1029: Fix function alignment
Date:   Fri, 18 Jan 2019 15:03:28 +0100
Message-Id: <20190118140329.18970-7-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the "Alignment should match open parenthesis" checkpatch
warning.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 4339f6b864a1..e9fe4fc3489e 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -203,8 +203,8 @@ show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
 }
 
-static ssize_t set_fan_div(struct device *dev,
-	    struct device_attribute *devattr, const char *buf, size_t count)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *devattr,
+			   const char *buf, size_t count)
 {
 	struct adm1029_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -322,7 +322,7 @@ static int adm1029_detect(struct i2c_client *client,
 	temp_devices_installed = i2c_smbus_read_byte_data(client,
 					ADM1029_REG_TEMP_DEVICES_INSTALLED);
 	nb_fan_support = i2c_smbus_read_byte_data(client,
-						ADM1029_REG_NB_FAN_SUPPORT);
+						  ADM1029_REG_NB_FAN_SUPPORT);
 	/* 0x41 is Analog Devices */
 	if (man_id != 0x41 || (temp_devices_installed & 0xf9) != 0x01 ||
 	    nb_fan_support != 0x03)
-- 
2.19.2

