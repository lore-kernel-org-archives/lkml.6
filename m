Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B95218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 01:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="DvutV3Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfB0BbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 20:31:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46975 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfB0BbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 20:31:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so7072820pgf.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3hvmuOtYMYt0aHFdzWWIFnb9WuzxaGLoOuap9tRVyMc=;
        b=DvutV3TcYqUPWFyS0Rf2jdS2QNGMYZvYPer8xGBggrKKz0ljEQePG6JKYG8RCXQ+hs
         XaffTlk18pjjuwsubK4mk4RwGCinsz0Vb/wP9pqculXfrX1aT9sdltYsDlEO9v7QC0vY
         GV4oN/pOSTMDWm8n7FZu3Ti3Iv+J4fVf3Vi3H2ToiK8BY2K22JPNTeLdRTUre8/ltuwP
         bAc9Ex5kmVwhRfeqWI7/mgPwbhQ2k6lucgtVvMgeyPOh32vwNehBhePnUqmW1vRe18lT
         /K2DhlqnuDNT2/gEx3/U0s4A2NdhZ7psRwcW8kFX2iG9ePHpo6gQl6vkdMhcILo+Uh/L
         wRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3hvmuOtYMYt0aHFdzWWIFnb9WuzxaGLoOuap9tRVyMc=;
        b=Xmc4BVeEcrkePp8gowsNgpe76GBqfojkDcRHxGfBAwdL6SV7qjt5qFiE73LWsuFg4z
         ej9GplV4ZzBy0H8x6CvF5d7s48BdNVY8p6o6Py7srplPHUaX8s7jROF81/eAXqTRTxJG
         0i76JDBPZ9W7QR6uEjMA1kdLHWseKW6MYsq63AyfORj8kAj8YkfNJYKHGGQf4A84G7fT
         scJnwzBSmvqAWivlPo/rW6qzXUiy9AmdxiMEtFrkJV/rPvi6UgMM6dKahupj77NB1oSx
         d/QHkEFHsfPSckUdh2zpIYAG0IGauwN4u+tzHtHFq/IN81aXWLMugI4GWMTinLQVVYjK
         89EQ==
X-Gm-Message-State: AHQUAuZJj0rPWFPwwKvYeB1GZyfIsJ6YdDw2pbwd1scyD5F+Ftbe8mgm
        DmpzVYbUTaEosMaeMrIf5Q6DaQ==
X-Google-Smtp-Source: AHgI3IbM8Ij4HRk9uD/L5sy8xYHhJbwSXR4DplGNO2JUxDUXdy1qwUjSn9LS2QTURjrSr/a/qKTjVw==
X-Received: by 2002:a63:fa48:: with SMTP id g8mr402105pgk.203.1551231066941;
        Tue, 26 Feb 2019 17:31:06 -0800 (PST)
Received: from localhost.localdomain (36-239-237-193.dynamic-ip.hinet.net. [36.239.237.193])
        by smtp.gmail.com with ESMTPSA id y14sm22614831pgc.17.2019.02.26.17.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 17:31:06 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, patches@opensource.cirrus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: wm8400: Get rid of wm8400_block_read/wm8400_set_bits functions
Date:   Wed, 27 Feb 2019 09:30:53 +0800
Message-Id: <20190227013053.9517-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of wm8400_block_read/wm8400_set_bits functions is the
wm8400 regulator driver. At the context of all the callers, we can
use regmap_bulk_read/regmap_update_bits directly.
Thus remove wm8400_block_read/wm8400_set_bits functions.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/wm8400-core.c            |  6 ------
 drivers/regulator/wm8400-regulator.c | 17 ++++++++---------
 include/linux/mfd/wm8400-private.h   |  8 --------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 79756c83f5f0..cf067424a156 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -35,12 +35,6 @@ static bool wm8400_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-int wm8400_block_read(struct wm8400 *wm8400, u8 reg, int count, u16 *data)
-{
-	return regmap_bulk_read(wm8400->regmap, reg, data, count);
-}
-EXPORT_SYMBOL_GPL(wm8400_block_read);
-
 static int wm8400_register_codec(struct wm8400 *wm8400)
 {
 	const struct mfd_cell cell = {
diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index fb1837657b64..40c4e6628471 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -36,13 +36,12 @@ static const struct regulator_ops wm8400_ldo_ops = {
 
 static unsigned int wm8400_dcdc_get_mode(struct regulator_dev *dev)
 {
-	struct wm8400 *wm8400 = rdev_get_drvdata(dev);
+	struct regmap *rmap = rdev_get_regmap(dev);
 	int offset = (rdev_get_id(dev) - WM8400_DCDC1) * 2;
 	u16 data[2];
 	int ret;
 
-	ret = wm8400_block_read(wm8400, WM8400_DCDC1_CONTROL_1 + offset, 2,
-				data);
+	ret = regmap_bulk_read(rmap, WM8400_DCDC1_CONTROL_1 + offset, data, 2);
 	if (ret != 0)
 		return 0;
 
@@ -63,36 +62,36 @@ static unsigned int wm8400_dcdc_get_mode(struct regulator_dev *dev)
 
 static int wm8400_dcdc_set_mode(struct regulator_dev *dev, unsigned int mode)
 {
-	struct wm8400 *wm8400 = rdev_get_drvdata(dev);
+	struct regmap *rmap = rdev_get_regmap(dev);
 	int offset = (rdev_get_id(dev) - WM8400_DCDC1) * 2;
 	int ret;
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
 		/* Datasheet: active with force PWM */
-		ret = wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_2 + offset,
+		ret = regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_2 + offset,
 				      WM8400_DC1_FRC_PWM, WM8400_DC1_FRC_PWM);
 		if (ret != 0)
 			return ret;
 
-		return wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_1 + offset,
+		return regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_1 + offset,
 				       WM8400_DC1_ACTIVE | WM8400_DC1_SLEEP,
 				       WM8400_DC1_ACTIVE);
 
 	case REGULATOR_MODE_NORMAL:
 		/* Datasheet: active */
-		ret = wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_2 + offset,
+		ret = regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_2 + offset,
 				      WM8400_DC1_FRC_PWM, 0);
 		if (ret != 0)
 			return ret;
 
-		return wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_1 + offset,
+		return regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_1 + offset,
 				       WM8400_DC1_ACTIVE | WM8400_DC1_SLEEP,
 				       WM8400_DC1_ACTIVE);
 
 	case REGULATOR_MODE_IDLE:
 		/* Datasheet: standby */
-		return wm8400_set_bits(wm8400, WM8400_DCDC1_CONTROL_1 + offset,
+		return regmap_update_bits(rmap, WM8400_DCDC1_CONTROL_1 + offset,
 				       WM8400_DC1_ACTIVE | WM8400_DC1_SLEEP, 0);
 	default:
 		return -EINVAL;
diff --git a/include/linux/mfd/wm8400-private.h b/include/linux/mfd/wm8400-private.h
index 4ee908f5b834..43d0d307e2e3 100644
--- a/include/linux/mfd/wm8400-private.h
+++ b/include/linux/mfd/wm8400-private.h
@@ -923,12 +923,4 @@ struct wm8400 {
 #define WM8400_LINE_CMP_VTHD_SHIFT                   0  /* LINE_CMP_VTHD - [3:0] */
 #define WM8400_LINE_CMP_VTHD_WIDTH                   4  /* LINE_CMP_VTHD - [3:0] */
 
-int wm8400_block_read(struct wm8400 *wm8400, u8 reg, int count, u16 *data);
-
-static inline int wm8400_set_bits(struct wm8400 *wm8400, u8 reg,
-				  u16 mask, u16 val)
-{
-	return regmap_update_bits(wm8400->regmap, reg, mask, val);
-}
-
 #endif
-- 
2.17.1

