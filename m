Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56799ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E3B21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhZI6NQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E3B21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbeITT5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:57:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45417 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbeITT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:57:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id w9-v6so1305615pgc.12;
        Thu, 20 Sep 2018 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1JtLa/hPzw18CLuTQT1vZviWf3qDAnLsnAB2VOYhU6Y=;
        b=lhZI6NQ50jSMGfaPlZ2Eo3rORRm8InvWQKm7uZGDBQn42zbcSv5zynLMNDm1T4f84+
         KcyftXvilYqvmGAsbj+Ahiv0uU+NV+NAzIPD95BxI2gGJoqdmTrWKwTsKS+P5EaEIC6t
         1mlO/U834BaG33Z6Ydx/HCxFxTWIHhJ2XBG+Zq7kg6Jy+7Jwb+J0r4CcZUex0AjrL1Gx
         IFvu+J4gLgG4aV05lUEaVGZj12/yQC17STjgR693s26SPL5k0O+/QHBYjxOs3RWAwwEs
         H8ODNVrjs6E40+ftgO+p7xrDYs+JhHVOBoQNvx8QSTTYrQYWuJmLVqMltuL68X0KpMCI
         s9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1JtLa/hPzw18CLuTQT1vZviWf3qDAnLsnAB2VOYhU6Y=;
        b=r6IQ5bw93v4BsyR553YTTG0CXhP9T40+zxVBDvb6foefprudHfuiNm1+BgJ7D15Ekp
         dwHUOrp9Y9cbzeVQkzSgLGcdjeHCEenlUMOsqvCqaSd0294BxfgXFyoKEnpdOAfoG2l8
         MEPu621bG7iE05fyGcmNnMJtp40bnJbzV+0n09A5o5EOfH3n7yBr4XnAfUhUYyoPHbJ3
         46iqUlDTU1nMBnWqeaaWrjlzrMsMUnF/SyXv70fP6ejK1pDCWLvxDXF0yQSvqyuSb3M7
         zhTJ0HCiQi5U9EfYW5ZjebvCme1e82Er8gyDZIFaPP9VYkcyAkYBtrF3UJIq2MJ5U6gU
         /EeQ==
X-Gm-Message-State: APzg51DNO1QVGsJgVAiCH0nyTBpFxpX8I6qorzWoaiPJM6lqfzOl2iTK
        vE694/aFY82K5kLfG/QH2dY=
X-Google-Smtp-Source: ANB0VdZiQPMC/Z6Z+SyU2wcc3J9FChnlt1bMVGrD9B+DIuqHmKYMWEqrrDJ1rf1TIDbjIsceRivahQ==
X-Received: by 2002:a62:2119:: with SMTP id h25-v6mr42241161pfh.112.1537452807320;
        Thu, 20 Sep 2018 07:13:27 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id m27-v6sm33628100pff.152.2018.09.20.07.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 07:13:26 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, shubhrajyoti@ti.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH] iio: magnetometer: hmc5843: Clean up redundant code.
Date:   Thu, 20 Sep 2018 22:13:21 +0800
Message-Id: <20180920141321.15251-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regmap tables are both defined in hmc5843_spi.c and hmc5843_i2c.c, while
the only difference between these two set of tables is SPI need a read
mask, which is set only in 'regmap_config' structrue. This patch moves
the other structrues into hmc5843_core.c to reduce redundance.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 drivers/iio/magnetometer/hmc5843.h      |  4 ++++
 drivers/iio/magnetometer/hmc5843_core.c | 28 +++++++++++++++++++++++++
 drivers/iio/magnetometer/hmc5843_i2c.c  | 27 ------------------------
 drivers/iio/magnetometer/hmc5843_spi.c  | 27 ------------------------
 4 files changed, 32 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 76a5d7484d8d..0ab400f27c97 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -46,6 +46,10 @@ struct hmc5843_data {
 	__be16 buffer[8];
 };
 
+extern const struct regmap_access_table hmc5843_readable_table;
+extern const struct regmap_access_table hmc5843_writable_table;
+extern const struct regmap_access_table hmc5843_volatile_table;
+
 int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 			 enum hmc5843_ids id, const char *name);
 int hmc5843_common_remove(struct device *dev);
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index ada142fb7aa3..a18e6d89f42a 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -92,6 +92,34 @@ static const char *const hmc5843_meas_conf_modes[] = {"normal", "positivebias",
 static const char *const hmc5983_meas_conf_modes[] = {"normal", "positivebias",
 						      "negativebias",
 						      "disabled"};
+
+static const struct regmap_range hmc5843_readable_ranges[] = {
+		regmap_reg_range(0, HMC5843_ID_END),
+};
+
+const struct regmap_access_table hmc5843_readable_table = {
+		.yes_ranges = hmc5843_readable_ranges,
+		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
+};
+
+static const struct regmap_range hmc5843_writable_ranges[] = {
+		regmap_reg_range(0, HMC5843_MODE_REG),
+};
+
+const struct regmap_access_table hmc5843_writable_table = {
+		.yes_ranges = hmc5843_writable_ranges,
+		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
+};
+
+static const struct regmap_range hmc5843_volatile_ranges[] = {
+		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
+};
+
+const struct regmap_access_table hmc5843_volatile_table = {
+		.yes_ranges = hmc5843_volatile_ranges,
+		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
+};
+
 /* Scaling factors: 10000000/Gain */
 static const int hmc5843_regval_to_nanoscale[] = {
 	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 3de7f4426ac4..a2c45a23e3c9 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -17,33 +17,6 @@
 
 #include "hmc5843.h"
 
-static const struct regmap_range hmc5843_readable_ranges[] = {
-	regmap_reg_range(0, HMC5843_ID_END),
-};
-
-static const struct regmap_access_table hmc5843_readable_table = {
-	.yes_ranges = hmc5843_readable_ranges,
-	.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
-};
-
-static const struct regmap_range hmc5843_writable_ranges[] = {
-	regmap_reg_range(0, HMC5843_MODE_REG),
-};
-
-static const struct regmap_access_table hmc5843_writable_table = {
-	.yes_ranges = hmc5843_writable_ranges,
-	.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
-};
-
-static const struct regmap_range hmc5843_volatile_ranges[] = {
-	regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
-};
-
-static const struct regmap_access_table hmc5843_volatile_table = {
-	.yes_ranges = hmc5843_volatile_ranges,
-	.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
-};
-
 static const struct regmap_config hmc5843_i2c_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 535f03a70d63..19541f5bb38f 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -14,33 +14,6 @@
 
 #include "hmc5843.h"
 
-static const struct regmap_range hmc5843_readable_ranges[] = {
-		regmap_reg_range(0, HMC5843_ID_END),
-};
-
-static const struct regmap_access_table hmc5843_readable_table = {
-		.yes_ranges = hmc5843_readable_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
-};
-
-static const struct regmap_range hmc5843_writable_ranges[] = {
-		regmap_reg_range(0, HMC5843_MODE_REG),
-};
-
-static const struct regmap_access_table hmc5843_writable_table = {
-		.yes_ranges = hmc5843_writable_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
-};
-
-static const struct regmap_range hmc5843_volatile_ranges[] = {
-		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
-};
-
-static const struct regmap_access_table hmc5843_volatile_table = {
-		.yes_ranges = hmc5843_volatile_ranges,
-		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
-};
-
 static const struct regmap_config hmc5843_spi_regmap_config = {
 		.reg_bits = 8,
 		.val_bits = 8,
-- 
2.17.1

