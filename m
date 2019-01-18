Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3404C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7278A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EooudYQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfARODp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:03:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50281 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfARODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so4631504wmd.0;
        Fri, 18 Jan 2019 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52hWXrVesE9hsYVcvtF6fWpIkVgqCxxIYdkUhzqrpz8=;
        b=EooudYQjYAyQVnH01dtyFpFmvjNbyz5EvGFVvYLY2VvATnvqjEY01XCZ1/PHkmq60T
         QUJOoHTJt1i2OPCZY1HELOGT1zMHL8Rq7uJO04W60uPo8soxOXurj27qP/ft7/xOsCVK
         2m33r5yQfb2cisVOxJeAdyQG01mF9iaollNmF2ZTNFpGMAzxv0DAacaUI1Hl3yjYYT9P
         5teW7gk/TBZevv7h6mPHeukCTwj0aUTQYxIX3BK54iJ8ufSlmLpjVOjp9jPO5yEtsvYo
         KKnPEcRiwNllQygPHuJRja4IHRRqNcvYowloif1boMaajzcx7WW82vGu/g56RH1Ed4Ej
         JxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52hWXrVesE9hsYVcvtF6fWpIkVgqCxxIYdkUhzqrpz8=;
        b=fq1frvln0LetXNV/1pqR/Gf71CTLy1+UAWBg/TXTmUoKVw9Nlx9xp85kwK/dMXxaFr
         cMxLYMMKv/K5sQvfdIw8+HgCaOJ7GUw1lF1yqcnotU+O2PRiWJSejHBQp9hJ6GfRiF+k
         77CQ9ODvBTrSqMQsCpRv23xxXGzHmZ00PL5traKFewtYCsDXAWPPUaeKbSJr8/EfDGV5
         cU3vtFyYuisQ67PA+mEsRyF27lZF+e1EfRR1w8PL3L+YLNFxSb2DhTp0q/kpTdI0a1tr
         xCW/IKjzSb9tjx1aD4EWRZAnprtIl3noOfBMugpUwibHUf69YZuvTSYsaCimwDAsNTG2
         f/+Q==
X-Gm-Message-State: AJcUukf8zTV9nvc60Q8ZuSh0alZr4tzrr1aVFdMvZlphEAcSWREAkzCa
        PUV9Ky1+RY1kAQggO4F0FwM=
X-Google-Smtp-Source: ALg8bN4ZpocWfDxw4K8mJso8mLxXVLfgDK3T6BJUwS3dX+JelgVMkM1ikufi55+U9o4Fbgn1Vzrzig==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr15832227wmq.151.1547820221550;
        Fri, 18 Jan 2019 06:03:41 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:41 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 5/7] hwmon: adm1029: Fix Logical continuations should be on the previous line checkpatch warning
Date:   Fri, 18 Jan 2019 15:03:27 +0100
Message-Id: <20190118140329.18970-6-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs fix the "Logical continuations should be on the previous line" checkpatch warning.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index f9f4f1f4a4c7..4339f6b864a1 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -131,8 +131,7 @@ static struct adm1029_data *adm1029_update_device(struct device *dev)
 	 * Use the "cache" Luke, don't recheck values
 	 * if there are already checked not a long time later
 	 */
-	if (time_after(jiffies, data->last_updated + HZ * 2)
-	 || !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
 		int nr;
 
 		dev_dbg(&client->dev, "Updating adm1029 data\n");
@@ -182,9 +181,9 @@ show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
 	struct adm1029_data *data = adm1029_update_device(dev);
 	u16 val;
 
-	if (data->fan[attr->index] == 0
-	    || (data->fan_div[attr->index] & 0xC0) == 0
-	    || data->fan[attr->index] == 255) {
+	if (data->fan[attr->index] == 0 ||
+	    (data->fan_div[attr->index] & 0xC0) == 0 ||
+	    data->fan[attr->index] == 255) {
 		return sprintf(buf, "0\n");
 	}
 
@@ -325,8 +324,8 @@ static int adm1029_detect(struct i2c_client *client,
 	nb_fan_support = i2c_smbus_read_byte_data(client,
 						ADM1029_REG_NB_FAN_SUPPORT);
 	/* 0x41 is Analog Devices */
-	if (man_id != 0x41 || (temp_devices_installed & 0xf9) != 0x01
-	    || nb_fan_support != 0x03)
+	if (man_id != 0x41 || (temp_devices_installed & 0xf9) != 0x01 ||
+	    nb_fan_support != 0x03)
 		return -ENODEV;
 
 	if ((chip_id & 0xF0) != 0x00) {
-- 
2.19.2

