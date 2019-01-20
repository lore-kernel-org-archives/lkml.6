Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0129DC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 07:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB74E2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 07:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="zGnYsX1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfATHeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 02:34:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35537 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfATHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 02:34:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so8680293pfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 23:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7Lj+fRCAAyeVkoJyjP3FfszmJEhZXQQAKnTgDNY13jc=;
        b=zGnYsX1zeg/g3bxsu2jPZweQX/AySchsNnQ9URcLRg7lpiwksly6IMYNtzMUaouWza
         qP1g/2xOLmcCsix9ZrQ+lsKyiKvofFJK7elFX5zznWhfLsW6pHItxG+9/uh9IKrJO6QL
         7hQpdPtiTi8rBKO8kmrIxUWT3EC5vBwgcOSa1IMDx/McXzOCb9dNKPBk65G1UHJdkHv4
         DZ4x/YeDflGE8qg/5y2FNp3WPw4BZUPH4Rv4MzXroKe/ZcIwamtR/uPuoG+vNArAgB9N
         E121gDHzxXxgqtbLtX+YwmiwcncWOzWHrvD+ae7DVDuhDBWhs7MdoXghMfHXMdLgJwkb
         MRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Lj+fRCAAyeVkoJyjP3FfszmJEhZXQQAKnTgDNY13jc=;
        b=ZjLvHSIscaiDQiHujaU52PVt2ADTR6eCCoeNlgYGrdTZfHeSWLQUfMTKy+j4U8YAl9
         zq9djMlAzP1pCSdkSylqp0Wv3hbxXNqvp6KAzeAD/rscSKEltULZBX/EsHfADrGP8KZJ
         tbSjpae2rbJSvvtGq6Hzko+/zLL3G75BJ5Hb6TX4ERqe2fmcEYqYGEgVtbNAiF3JpFrE
         reuc8TywNkFSqmnTxW4CDtHrbYK5R0vgDJOCFb9c1aqWDD3FIxDhQDgClbxlj+Ba3KpQ
         TJAl1l9TQKFajyO4AmWjWmcRJYnn8gEEqjA6bQ2+mOHD5brWhqKsxWmKu/2hAvMfoaTr
         MQMg==
X-Gm-Message-State: AJcUukdUGA1nlbjOE68xuX2dWcqv6oAIs3f7/P2mltqC00byhFcNz+Ww
        uvY1hEBQ4w5vT0LAP5P+KTbHNIPxtT8=
X-Google-Smtp-Source: ALg8bN6jIpoIBDqTE/gx0v25FR9PjW0zRgFVAu4tYM1sbP9PZ5buYxcMqWxiN6oMdsDj5CxI9rA8GA==
X-Received: by 2002:a63:9501:: with SMTP id p1mr23919790pgd.149.1547969653385;
        Sat, 19 Jan 2019 23:34:13 -0800 (PST)
Received: from localhost.localdomain (36-239-240-12.dynamic-ip.hinet.net. [36.239.240.12])
        by smtp.gmail.com with ESMTPSA id f32sm13321975pgf.80.2019.01.19.23.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 23:34:12 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: wm831x-dcdc: Convert to use regulator_linear_range for wm831x_buckv
Date:   Sun, 20 Jan 2019 15:33:56 +0800
Message-Id: <20190120073356.20523-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm831x-dcdc.c | 39 ++++++++-------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 5a5bc4bb08d2..4a573eea284a 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -205,33 +205,10 @@ static irqreturn_t wm831x_dcdc_oc_irq(int irq, void *data)
  * BUCKV specifics
  */
 
-static int wm831x_buckv_list_voltage(struct regulator_dev *rdev,
-				      unsigned selector)
-{
-	if (selector <= 0x8)
-		return 600000;
-	if (selector <= WM831X_BUCKV_MAX_SELECTOR)
-		return 600000 + ((selector - 0x8) * 12500);
-	return -EINVAL;
-}
-
-static int wm831x_buckv_map_voltage(struct regulator_dev *rdev,
-				   int min_uV, int max_uV)
-{
-	u16 vsel;
-
-	if (min_uV < 600000)
-		vsel = 0;
-	else if (min_uV <= 1800000)
-		vsel = DIV_ROUND_UP(min_uV - 600000, 12500) + 8;
-	else
-		return -EINVAL;
-
-	if (wm831x_buckv_list_voltage(rdev, vsel) > max_uV)
-		return -EINVAL;
-
-	return vsel;
-}
+static const struct regulator_linear_range wm831x_buckv_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 0x7, 0),
+	REGULATOR_LINEAR_RANGE(600000, 0x8, 0x68, 12500),
+};
 
 static int wm831x_buckv_set_dvs(struct regulator_dev *rdev, int state)
 {
@@ -309,7 +286,7 @@ static int wm831x_buckv_set_suspend_voltage(struct regulator_dev *rdev,
 	u16 reg = dcdc->base + WM831X_DCDC_SLEEP_CONTROL;
 	int vsel;
 
-	vsel = wm831x_buckv_map_voltage(rdev, uV, uV);
+	vsel = regulator_map_voltage_linear_range(rdev, uV, uV);
 	if (vsel < 0)
 		return vsel;
 
@@ -368,8 +345,8 @@ static int wm831x_buckv_get_current_limit(struct regulator_dev *rdev)
 static const struct regulator_ops wm831x_buckv_ops = {
 	.set_voltage_sel = wm831x_buckv_set_voltage_sel,
 	.get_voltage_sel = wm831x_buckv_get_voltage_sel,
-	.list_voltage = wm831x_buckv_list_voltage,
-	.map_voltage = wm831x_buckv_map_voltage,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.set_suspend_voltage = wm831x_buckv_set_suspend_voltage,
 	.set_current_limit = wm831x_buckv_set_current_limit,
 	.get_current_limit = wm831x_buckv_get_current_limit,
@@ -492,6 +469,8 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 	dcdc->desc.id = id;
 	dcdc->desc.type = REGULATOR_VOLTAGE;
 	dcdc->desc.n_voltages = WM831X_BUCKV_MAX_SELECTOR + 1;
+	dcdc->desc.linear_ranges = wm831x_buckv_ranges;
+	dcdc->desc.n_linear_ranges = ARRAY_SIZE(wm831x_buckv_ranges);
 	dcdc->desc.ops = &wm831x_buckv_ops;
 	dcdc->desc.owner = THIS_MODULE;
 	dcdc->desc.enable_reg = WM831X_DCDC_ENABLE;
-- 
2.17.1

