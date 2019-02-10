Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEBDC282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9204F217D8
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="1O0t1X+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBJCti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 21:49:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44824 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfBJCth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 21:49:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id p4so3578402plq.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 18:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mEhoN9b4j186tQMb1sXwn7pHKZnKhJYsf7okKF7chnA=;
        b=1O0t1X+oVxCHgefwCJqqmGg5/EMRcIU2xR2CRehlGoaEpcWcorvywtA8BFwnAKeO/E
         kWzxoBEQ/Fzfk5HdfCcUtvDS5fu6lB/ZbUQwKcsMdy+PDmo8p4BHntmmJ2oSKcxNGik8
         aSFmmOqvLnEIHrYT0Txryfx0Xgi5PfJR48fSquKheRDKjV/gnuHnnH5wr9n6CpLmJuoj
         lbwqIH1ZYkxKWQp4hzc+o9EWkMHi2vZnbjcCF+7WbzdCnaDGa9FbPhkF8RFFDfQBcqxC
         8AhPHQuhsrJ7Dz7fB7VAFEY2cwc9twSKRWegTPp2wUmAQ5HUr9FuPMQxjaUDg7n9Xyo5
         0xUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mEhoN9b4j186tQMb1sXwn7pHKZnKhJYsf7okKF7chnA=;
        b=Cx1pP19NyY9IVjJH+4meo9SMmMGFX3HIJmN41tiVmlfB6BXIXXhhe24IYw77Np/st+
         pQWdt5nXeJ9aXWiczmNYb+6raQO3oQgnZpoJkJMDHdyGiuLNe8pd7piSgBYEKYw4WpIh
         uA3ez1P9ukGTkRcK7JVkAgh5EN8xcbc6/pD0UVoo1sCkIS4XR8+/bHikbDFUgetpwcBJ
         aBsjykEVnVHqzltMTLkaSPX2CQbHnXkxWXLs0oPwjypdSqQPiqz9JuuBuMmB6necR8wL
         kqfHq7B8QIqqowDQJ3GAriHJsdQiIgPX1/1ajawtGgOO/IwDn9wslP+UeEVLPE4iYyht
         j2pA==
X-Gm-Message-State: AHQUAubgzN6X4JVCFVtABg1c7bqsldEglhm9QlctdlvvfGt7E7BsCyxT
        wzBwyHRQCLhJG+X66Httz+qaIQ==
X-Google-Smtp-Source: AHgI3IY8rpsNogU5dXzfsYOZ7s6HgRrP2Wok6dz96xasFzn6F6N9Ks3Jc3HD2kzWK7idmOcOQ8Qvfg==
X-Received: by 2002:a17:902:c85:: with SMTP id 5mr31422285plt.339.1549766976671;
        Sat, 09 Feb 2019 18:49:36 -0800 (PST)
Received: from localhost.localdomain (36-239-237-75.dynamic-ip.hinet.net. [36.239.237.75])
        by smtp.gmail.com with ESMTPSA id e86sm10066013pfb.6.2019.02.09.18.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 18:49:35 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lp8788-buck: Convert to linear range
Date:   Sun, 10 Feb 2019 10:48:45 +0800
Message-Id: <20190210024845.12698-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linear range is suitable for this driver, let's convert it to linear range.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8788-buck.c | 38 +++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 30de784d8e30..a7d30550bb5f 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -95,12 +95,10 @@ struct lp8788_buck {
 	void *dvs;
 };
 
-/* BUCK 1 ~ 4 voltage table */
-static const int lp8788_buck_vtbl[] = {
-	 500000,  800000,  850000,  900000,  950000, 1000000, 1050000, 1100000,
-	1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000,
-	1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000,
-	1950000, 2000000,
+/* BUCK 1 ~ 4 voltage ranges */
+static const struct regulator_linear_range buck_volt_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0, 0, 0),
+	REGULATOR_LINEAR_RANGE(800000, 1, 25, 50000),
 };
 
 static void lp8788_buck1_set_dvs(struct lp8788_buck *buck)
@@ -345,8 +343,8 @@ static unsigned int lp8788_buck_get_mode(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops lp8788_buck12_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_ascend,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.set_voltage_sel = lp8788_buck12_set_voltage_sel,
 	.get_voltage_sel = lp8788_buck12_get_voltage_sel,
 	.enable = regulator_enable_regmap,
@@ -358,8 +356,8 @@ static const struct regulator_ops lp8788_buck12_ops = {
 };
 
 static const struct regulator_ops lp8788_buck34_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.map_voltage = regulator_map_voltage_ascend,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.enable = regulator_enable_regmap,
@@ -375,8 +373,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck1",
 		.id = BUCK1,
 		.ops = &lp8788_buck12_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.enable_reg = LP8788_EN_BUCK,
@@ -386,8 +385,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck2",
 		.id = BUCK2,
 		.ops = &lp8788_buck12_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.enable_reg = LP8788_EN_BUCK,
@@ -397,8 +397,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck3",
 		.id = BUCK3,
 		.ops = &lp8788_buck34_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.vsel_reg = LP8788_BUCK3_VOUT,
@@ -410,8 +411,9 @@ static const struct regulator_desc lp8788_buck_desc[] = {
 		.name = "buck4",
 		.id = BUCK4,
 		.ops = &lp8788_buck34_ops,
-		.n_voltages = ARRAY_SIZE(lp8788_buck_vtbl),
-		.volt_table = lp8788_buck_vtbl,
+		.n_voltages = 26,
+		.linear_ranges = buck_volt_ranges,
+		.n_linear_ranges = ARRAY_SIZE(buck_volt_ranges),
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
 		.vsel_reg = LP8788_BUCK4_VOUT,
-- 
2.17.1

