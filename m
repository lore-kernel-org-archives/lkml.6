Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75511C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA3217F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGKbY5G5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfAEDGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:06:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35932 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAEDGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:06:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so19136967pfc.3;
        Fri, 04 Jan 2019 19:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iu5iw3f6Uux/rlSWpYqHTjRFiDmi23zK/1X6/Aiiw60=;
        b=dGKbY5G5UhvsYbUW6KBiGnxEvkMbKvMJ48TAMpaYzGxfaUaWphTOT2/3l5lo/iyS78
         rnSsiYXJX3iRDUX41oqw0ZUbcoeke4m6F7MznHicFXE4EiNqYiqvjvRy4L2ZAAvz5vcK
         mGgNaKLqfUusDDTBvhjMOcahDH/R4IKriFBK/JWCnTE5ZrCGpJNNyXdsIE4E7fl0ZfHR
         czVwrY29AVuubzjTBhmd2bwQDxls1afiLih/yOYjCrBnBBHz69vnAQvrwN1qrrcaF2TB
         Cr+Q14w6w8CDizI/c+UAkRjFv8G6YkQuND5KeI2whQbrc145wa7tj0CYiuTIMWeO1yKO
         fyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iu5iw3f6Uux/rlSWpYqHTjRFiDmi23zK/1X6/Aiiw60=;
        b=L0Uh94IdWMHB8s4vMMYiC1IjRmmm+zJFO4S70FyBhdDcswwTSP0v6XEA7j3wm7jpAD
         LyjT1odwGT/k2x2Wv8O88Re/8xoHyAgpQxsfX5i8A2Dd77PpTHrTPBSG5igRhAtLNIFX
         vU3truW8edpAsxzDdG3YT/L73JJM9hcB5tX2QtyYQEvlhKsLm8QTA3cxh11GHqUjsSJk
         K+PotI1zff57PKy4WqRIGhRGR7X3yEcfxHzZd9fkNEd4WkqfdZJ913JPq4gMaUrVwXgq
         Wi+wqt7xDOYMEGaRv4ypdOH1eIZH2/Ac/xzHBobpK7D0iCZrdcZh3r5tzWmEt0+j4tcN
         65yQ==
X-Gm-Message-State: AJcUukeBddwI4zHi9meBOIKzx/T2TQxkoR5kAvbr05+UEIs73YHrw6n2
        RfmBaDNsts8jYdCyInxrYnW68Rrp
X-Google-Smtp-Source: ALg8bN5sDqWPbaZf6OuQ18i1aaGiNQI2OGaKCA9kqWXTj75kTiaexInIIM8RU3qq+A0Rye/qd8Ep8g==
X-Received: by 2002:a63:7c41:: with SMTP id l1mr50179642pgn.45.1546657603583;
        Fri, 04 Jan 2019 19:06:43 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id h82sm102885099pfa.105.2019.01.04.19.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 19:06:42 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (ina3221) Implement ti,single-shot DT property
Date:   Fri,  4 Jan 2019 19:06:36 -0800
Message-Id: <20190105030636.533-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105030636.533-1-nicoleotsuka@gmail.com>
References: <20190105030636.533-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, ina3221, as a hardware monitor, continuously measures
the inputs and generates corresponding data. However, for battery
powered devices, this mode might be power consuming.

The DT binding doc is updated with a new boolean type property to
allow changing the default operating mode from consuming mode to
single-shot mode, which will measure input on demand and then shut
down to save power.

So this patch implements the DT property accordingly.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Replaced the useless mode defines with a boolean variable.

 drivers/hwmon/ina3221.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e90ccac8bebb..4258a6ebe195 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -111,6 +111,7 @@ struct ina3221_input {
  * @inputs: Array of channel input source specific structures
  * @lock: mutex lock to serialize sysfs attribute accesses
  * @reg_config: Register value of INA3221_CONFIG
+ * @single_shot: running in single-shot operating mode
  */
 struct ina3221_data {
 	struct device *pm_dev;
@@ -119,6 +120,8 @@ struct ina3221_data {
 	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 	struct mutex lock;
 	u32 reg_config;
+
+	bool single_shot;
 };
 
 static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
@@ -188,6 +191,11 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina->single_shot)
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -232,6 +240,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		/* Write CONFIG register to trigger a single-shot measurement */
+		if (ina->single_shot)
+			regmap_write(ina->regmap, INA3221_CONFIG,
+				     ina->reg_config);
+
 		ret = ina3221_wait_for_data(ina);
 		if (ret)
 			return ret;
@@ -617,6 +630,9 @@ static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
 	if (!np)
 		return 0;
 
+	if (of_property_read_bool(np, "ti,single-shot"))
+		ina->single_shot = true;
+
 	for_each_child_of_node(np, child) {
 		ret = ina3221_probe_child_from_dt(dev, child, ina);
 		if (ret)
@@ -666,6 +682,10 @@ static int ina3221_probe(struct i2c_client *client,
 	/* The driver will be reset, so use reset value */
 	ina->reg_config = INA3221_CONFIG_DEFAULT;
 
+	/* Clear continuous bit to use single-shot mode */
+	if (ina->single_shot)
+		ina->reg_config &= ~INA3221_CONFIG_MODE_CONTINUOUS;
+
 	/* Disable channels if their inputs are disconnected */
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
 		if (ina->inputs[i].disconnected)
-- 
2.17.1

