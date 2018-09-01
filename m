Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A1C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E1A2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo/GMKhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E1A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIAU7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:59:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36312 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeIAU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:59:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so6788580pgo.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yw/idGED4M9KW7F3mnN92ZYVR39DAeNx2sVIekDHEE4=;
        b=eo/GMKhi9RA2pjudXnNZXg43buENbH6MqILY+pGDe2UJ+n6LV4zyWN4Ms5vRneqQJZ
         oQeEEflHHHC2pgxBg9VKzpWhMtMAk9mzVxqfFcHOeECqtpnmrwwHIk3h0AOTkGIcADvd
         A/i4rZ6tMRMYGfpGYI4+flXPj9+VfU+tCZ8e+Y3By2A7x7BwymAjBflR16UptXsOL6EA
         6G96qYTI1qqELJF7rJLqKj5YRK6l+A5xm2SrIkxNWXwtGtZp4BSknJJt11E9yaH7l0Mq
         azRfGCYE6KXEKsgH07ugjq31JhANEbHcvQZ9ntVPAlYsdd3pulFgut7V7nLHPvAc8Pas
         VaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yw/idGED4M9KW7F3mnN92ZYVR39DAeNx2sVIekDHEE4=;
        b=i+cO8CJ1Hwj5TzL0e1jdkofFzvkrfkMcRKi9++HbO9kYFIZDNXACVnODYpjL3dDxix
         EGgXnUDlKQ125LxuzyxY4Tgn2PpGPxZosPyrtVXtvYEeDaPLMQ0cialInhvdciF9mzHT
         t+pChw7le1cGZUrbKUX7cv+JvZ/NeRsqyZ3ui/ALt/lw8qZWMY4yZ9QrWRf02qfMxqqJ
         ZlxQcsS2IS4/OtE2SkGX0xZ5kHxhQsREseEe+SktunOjPt6tIGWT4NKG4WN7bOIqwou2
         rBHuNZe+yt0Lro2fRrV1pyYey7mjuxHv+nGLNo3a1D8XUHZSNohSr88Hfa2rJZbnvOAe
         /PTg==
X-Gm-Message-State: APzg51Dn7CRhLG4PjYENPH6FRC+NfL5oIvcVRMSZxV3dq9/+B1kbBtks
        X0MiDdP4aVoOsjPNs0rQhw5O+RHx
X-Google-Smtp-Source: ANB0Vdb2DJEyqQQzVs2ASivZ5TSW4rrb5df8IMYd+Ua3BJcMGCx4qCl6ghP8e/yErifno0EcIgMmtQ==
X-Received: by 2002:a62:6948:: with SMTP id e69-v6mr21356992pfc.166.1535820423645;
        Sat, 01 Sep 2018 09:47:03 -0700 (PDT)
Received: from dfrey-debian-linux.sierrawireless.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id x65-v6sm22994095pfk.140.2018.09.01.09.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 09:47:02 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 2/2] regmap: split up regmap_config.use_single_rw
Date:   Sat,  1 Sep 2018 09:50:41 -0700
Message-Id: <20180901165041.25026-3-dpfrey@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180901165041.25026-1-dpfrey@gmail.com>
References: <20180901165041.25026-1-dpfrey@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split regmap_config.use_single_rw into use_single_read and
use_single_write. This change enables drivers of devices which only
support bulk operations in one direction to use the regmap_bulk_*()
functions for both directions and have their bulk operation split into
single operations only when necessary.

Update all struct regmap_config instances where use_single_rw==true to
instead set both use_single_read and use_single_write. No attempt was
made to evaluate whether it is possible to set only one of
use_single_read or use_single_write.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/base/regmap/regmap.c             |  4 ++--
 drivers/edac/altera_edac.c               |  3 ++-
 drivers/hwmon/lm75.c                     |  3 ++-
 drivers/hwmon/lm95245.c                  |  3 ++-
 drivers/hwmon/tmp102.c                   |  3 ++-
 drivers/hwmon/tmp108.c                   |  3 ++-
 drivers/iio/light/apds9960.c             |  3 ++-
 drivers/iio/light/max44000.c             | 23 ++++++++++++-----------
 drivers/iio/temperature/mlx90632.c       |  3 ++-
 drivers/input/touchscreen/tsc200x-core.c |  3 ++-
 drivers/mfd/altera-a10sr.c               |  3 ++-
 drivers/mfd/da9052-spi.c                 |  3 ++-
 drivers/mfd/mc13xxx-spi.c                |  3 ++-
 drivers/mfd/twl6040.c                    |  3 ++-
 drivers/regulator/ltc3589.c              |  3 ++-
 drivers/regulator/ltc3676.c              |  3 ++-
 include/linux/regmap.h                   | 12 ++++++++----
 sound/hda/hdac_regmap.c                  |  3 ++-
 sound/soc/codecs/cs35l33.c               |  3 ++-
 sound/soc/codecs/cs35l35.c               |  3 ++-
 sound/soc/codecs/cs43130.c               |  4 +++-
 sound/soc/codecs/es8328.c                |  3 ++-
 sound/soc/codecs/rt1305.c                |  3 ++-
 sound/soc/codecs/rt5514.c                |  3 ++-
 sound/soc/codecs/rt5616.c                |  3 ++-
 sound/soc/codecs/rt5640.c                |  3 ++-
 sound/soc/codecs/rt5645.c                |  9 ++++++---
 sound/soc/codecs/rt5651.c                |  3 ++-
 sound/soc/codecs/rt5660.c                |  3 ++-
 sound/soc/codecs/rt5663.c                |  9 ++++++---
 sound/soc/codecs/rt5665.c                |  3 ++-
 sound/soc/codecs/rt5668.c                |  3 ++-
 sound/soc/codecs/rt5670.c                |  3 ++-
 sound/soc/codecs/rt5682.c                |  3 ++-
 34 files changed, 93 insertions(+), 52 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 0360a90ad6b6..78a778c08f92 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -762,8 +762,8 @@ struct regmap *__regmap_init(struct device *dev,
 		map->reg_stride_order = ilog2(map->reg_stride);
 	else
 		map->reg_stride_order = -1;
-	map->use_single_read = config->use_single_rw || !bus || !bus->read;
-	map->use_single_write = config->use_single_rw || !bus || !bus->write;
+	map->use_single_read = config->use_single_read || !bus || !bus->read;
+	map->use_single_write = config->use_single_write || !bus || !bus->write;
 	map->can_multi_write = config->can_multi_write && bus && bus->write;
 	if (bus) {
 		map->max_raw_read = bus->max_raw_read;
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5762c3c383f2..ab7c5a937ab0 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -599,7 +599,8 @@ static const struct regmap_config s10_sdram_regmap_cfg = {
 	.volatile_reg = s10_sdram_volatile_reg,
 	.reg_read = s10_protected_reg_read,
 	.reg_write = s10_protected_reg_write,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static int altr_s10_sdram_probe(struct platform_device *pdev)
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 49f4b33a5685..542dc4058831 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -254,7 +254,8 @@ static const struct regmap_config lm75_regmap_config = {
 	.volatile_reg = lm75_is_volatile_reg,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 	.cache_type = REGCACHE_RBTREE,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static void lm75_remove(void *data)
diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index 27cb06d65594..996b50246175 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -541,7 +541,8 @@ static const struct regmap_config lm95245_regmap_config = {
 	.writeable_reg = lm95245_is_writeable_reg,
 	.volatile_reg = lm95245_is_volatile_reg,
 	.cache_type = REGCACHE_RBTREE,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static const u32 lm95245_chip_config[] = {
diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index dfc40c740d07..6778283e36f9 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -212,7 +212,8 @@ static const struct regmap_config tmp102_regmap_config = {
 	.volatile_reg = tmp102_is_volatile_reg,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 	.cache_type = REGCACHE_RBTREE,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static int tmp102_probe(struct i2c_client *client,
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 91bb94639286..429bfeae4ca8 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -345,7 +345,8 @@ static const struct regmap_config tmp108_regmap_config = {
 	.volatile_reg = tmp108_is_volatile_reg,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 	.cache_type = REGCACHE_RBTREE,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static int tmp108_probe(struct i2c_client *client,
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 1f112ae15f3c..b09b8b60bd83 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -206,7 +206,8 @@ static const struct regmap_config apds9960_regmap_config = {
 	.name = APDS9960_REGMAP_NAME,
 	.reg_bits = 8,
 	.val_bits = 8,
-	.use_single_rw = 1,
+	.use_single_read = true,
+	.use_single_write = true,
 
 	.volatile_table = &apds9960_volatile_table,
 	.precious_table = &apds9960_precious_table,
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index bcdb0eb9e537..4067dff2ff6a 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -473,17 +473,18 @@ static bool max44000_precious_reg(struct device *dev, unsigned int reg)
 }
 
 static const struct regmap_config max44000_regmap_config = {
-	.reg_bits	= 8,
-	.val_bits	= 8,
-
-	.max_register	= MAX44000_REG_PRX_DATA,
-	.readable_reg	= max44000_readable_reg,
-	.writeable_reg	= max44000_writeable_reg,
-	.volatile_reg	= max44000_volatile_reg,
-	.precious_reg	= max44000_precious_reg,
-
-	.use_single_rw	= 1,
-	.cache_type	= REGCACHE_RBTREE,
+	.reg_bits		= 8,
+	.val_bits		= 8,
+
+	.max_register		= MAX44000_REG_PRX_DATA,
+	.readable_reg		= max44000_readable_reg,
+	.writeable_reg		= max44000_writeable_reg,
+	.volatile_reg		= max44000_volatile_reg,
+	.precious_reg		= max44000_precious_reg,
+
+	.use_single_read	= true,
+	.use_single_write	= true,
+	.cache_type		= REGCACHE_RBTREE,
 };
 
 static irqreturn_t max44000_trigger_handler(int irq, void *p)
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 9851311aa3fd..be03be719efe 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -140,7 +140,8 @@ static const struct regmap_config mlx90632_regmap = {
 	.rd_table = &mlx90632_readable_regs_tbl,
 	.wr_table = &mlx90632_writeable_regs_tbl,
 
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.reg_format_endian = REGMAP_ENDIAN_BIG,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 	.cache_type = REGCACHE_RBTREE,
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index e0fde590df8e..62973ac01381 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -68,7 +68,8 @@ const struct regmap_config tsc200x_regmap_config = {
 	.read_flag_mask = TSC200X_REG_READ,
 	.write_flag_mask = TSC200X_REG_PND0,
 	.wr_table = &tsc200x_writable_table,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 EXPORT_SYMBOL_GPL(tsc200x_regmap_config);
 
diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
index 96e7d2cb7b89..400e0b51844b 100644
--- a/drivers/mfd/altera-a10sr.c
+++ b/drivers/mfd/altera-a10sr.c
@@ -108,7 +108,8 @@ static const struct regmap_config altr_a10sr_regmap_config = {
 
 	.cache_type = REGCACHE_NONE,
 
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.read_flag_mask = 1,
 	.write_flag_mask = 0,
 
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index abfb11818fdc..fdae1288bc6d 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -46,7 +46,8 @@ static int da9052_spi_probe(struct spi_device *spi)
 	config.reg_bits = 7;
 	config.pad_bits = 1;
 	config.val_bits = 8;
-	config.use_single_rw = 1;
+	config.use_single_read = true;
+	config.use_single_write = true;
 
 	da9052->regmap = devm_regmap_init_spi(spi, &config);
 	if (IS_ERR(da9052->regmap)) {
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index cbc1e5ed599c..ee3411cc5ce4 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -57,7 +57,8 @@ static const struct regmap_config mc13xxx_regmap_spi_config = {
 	.max_register = MC13XXX_NUMREGS,
 
 	.cache_type = REGCACHE_NONE,
-	.use_single_rw = 1,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static int mc13xxx_spi_read(void *context, const void *reg, size_t reg_size,
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index dd19f17a1b63..7c3c5fd5fcd0 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -613,7 +613,8 @@ static const struct regmap_config twl6040_regmap_config = {
 	.writeable_reg = twl6040_writeable_reg,
 
 	.cache_type = REGCACHE_RBTREE,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static const struct regmap_irq twl6040_irqs[] = {
diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 18d5b01ddcb2..63f724f260ef 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -404,7 +404,8 @@ static const struct regmap_config ltc3589_regmap_config = {
 	.max_register = LTC3589_L2DTV2,
 	.reg_defaults = ltc3589_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(ltc3589_reg_defaults),
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.cache_type = REGCACHE_RBTREE,
 };
 
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index 9dec1609ff66..71fd0f2a4b76 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -321,7 +321,8 @@ static const struct regmap_config ltc3676_regmap_config = {
 	.readable_reg = ltc3676_readable_reg,
 	.volatile_reg = ltc3676_volatile_reg,
 	.max_register = LTC3676_CLIRQ,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.cache_type = REGCACHE_RBTREE,
 };
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 379505a53722..6ea9bf9377cb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -315,9 +315,12 @@ typedef void (*regmap_unlock)(void *);
  *                   masks are used.
  * @zero_flag_mask: If set, read_flag_mask and write_flag_mask are used even
  *                   if they are both empty.
- * @use_single_rw: If set, converts the bulk read and write operations into
- *		    a series of single read and write operations. This is useful
- *		    for device that does not support bulk read and write.
+ * @use_single_read: If set, converts the bulk read operation into a series of
+ *                   single read operations. This is useful for a device that
+ *                   does not support  bulk read.
+ * @use_single_write: If set, converts the bulk write operation into a series of
+ *                    single write operations. This is useful for a device that
+ *                    does not support bulk write.
  * @can_multi_write: If set, the device supports the multi write mode of bulk
  *                   write operations, if clear multi write requests will be
  *                   split into individual write operations
@@ -380,7 +383,8 @@ struct regmap_config {
 	unsigned long write_flag_mask;
 	bool zero_flag_mask;
 
-	bool use_single_rw;
+	bool use_single_read;
+	bool use_single_write;
 	bool can_multi_write;
 
 	enum regmap_endian reg_format_endian;
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 419e285e0226..996dbc850224 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -359,7 +359,8 @@ static const struct regmap_config hda_regmap_cfg = {
 	.cache_type = REGCACHE_RBTREE,
 	.reg_read = hda_reg_read,
 	.reg_write = hda_reg_write,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 /**
diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 668cd3754209..e9b7f72d880b 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -857,7 +857,8 @@ static const struct regmap_config cs35l33_regmap = {
 	.readable_reg = cs35l33_readable_register,
 	.writeable_reg = cs35l33_writeable_register,
 	.cache_type = REGCACHE_RBTREE,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static int __maybe_unused cs35l33_runtime_resume(struct device *dev)
diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index bd6226bde45f..9f4a59871cee 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1105,7 +1105,8 @@ static struct regmap_config cs35l35_regmap = {
 	.readable_reg = cs35l35_readable_register,
 	.precious_reg = cs35l35_precious_register,
 	.cache_type = REGCACHE_RBTREE,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static irqreturn_t cs35l35_irq(int irq, void *data)
diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 80dc42197154..3f7b255587e6 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2362,7 +2362,9 @@ static const struct regmap_config cs43130_regmap = {
 	.precious_reg		= cs43130_precious_register,
 	.volatile_reg		= cs43130_volatile_register,
 	.cache_type		= REGCACHE_RBTREE,
-	.use_single_rw		= true, /* needed for regcache_sync */
+	/* needed for regcache_sync */
+	.use_single_read	= true,
+	.use_single_write	= true,
 };
 
 static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index e9fc2fd97d2f..4b5827dc23aa 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -824,7 +824,8 @@ const struct regmap_config es8328_regmap_config = {
 	.val_bits	= 8,
 	.max_register	= ES8328_REG_MAX,
 	.cache_type	= REGCACHE_RBTREE,
-	.use_single_rw	= true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 EXPORT_SYMBOL_GPL(es8328_regmap_config);
 
diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index c4452efc7970..c2c8a68cec97 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -963,7 +963,8 @@ static const struct regmap_config rt1305_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(rt1305_reg),
 	.ranges = rt1305_ranges,
 	.num_ranges = ARRAY_SIZE(rt1305_ranges),
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 #if defined(CONFIG_OF)
diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index dca82dd6e3bf..f78183a6e80d 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1201,7 +1201,8 @@ static const struct regmap_config rt5514_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = rt5514_reg,
 	.num_reg_defaults = ARRAY_SIZE(rt5514_reg),
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static const struct i2c_device_id rt5514_i2c_id[] = {
diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 3dc795f444ce..36a9f1c56c8d 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1313,7 +1313,8 @@ static const struct snd_soc_component_driver soc_component_dev_rt5616 = {
 static const struct regmap_config rt5616_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = RT5616_DEVICE_ID + 1 + (ARRAY_SIZE(rt5616_ranges) *
 					       RT5616_PR_SPACING),
 	.volatile_reg = rt5616_volatile_register,
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 27770143ae8f..fc530481a6e4 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2704,7 +2704,8 @@ static const struct snd_soc_component_driver soc_component_dev_rt5640 = {
 static const struct regmap_config rt5640_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 
 	.max_register = RT5640_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5640_ranges) *
 					       RT5640_PR_SPACING),
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1dc70f452c1b..be674688dc40 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3559,7 +3559,8 @@ static const struct snd_soc_component_driver soc_component_dev_rt5645 = {
 static const struct regmap_config rt5645_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = RT5645_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5645_ranges) *
 					       RT5645_PR_SPACING),
 	.volatile_reg = rt5645_volatile_register,
@@ -3575,7 +3576,8 @@ static const struct regmap_config rt5645_regmap = {
 static const struct regmap_config rt5650_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = RT5645_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5645_ranges) *
 					       RT5645_PR_SPACING),
 	.volatile_reg = rt5645_volatile_register,
@@ -3592,7 +3594,8 @@ static const struct regmap_config temp_regmap = {
 	.name="nocache",
 	.reg_bits = 8,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = RT5645_VENDOR_ID2 + 1,
 	.cache_type = REGCACHE_NONE,
 };
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 985852fd9723..5bcedbc7eb4a 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -2124,7 +2124,8 @@ static const struct regmap_config rt5651_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(rt5651_reg),
 	.ranges = rt5651_ranges,
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 #if defined(CONFIG_OF)
diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 20a755137e63..27f7445b2432 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1217,7 +1217,8 @@ static const struct snd_soc_component_driver soc_component_dev_rt5660 = {
 static const struct regmap_config rt5660_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 
 	.max_register = RT5660_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5660_ranges) *
 					       RT5660_PR_SPACING),
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 9bd24ad42240..70441661ea4a 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3252,7 +3252,8 @@ static const struct snd_soc_component_driver soc_component_dev_rt5663 = {
 static const struct regmap_config rt5663_v2_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = 0x07fa,
 	.volatile_reg = rt5663_v2_volatile_register,
 	.readable_reg = rt5663_v2_readable_register,
@@ -3264,7 +3265,8 @@ static const struct regmap_config rt5663_v2_regmap = {
 static const struct regmap_config rt5663_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = 0x03f3,
 	.volatile_reg = rt5663_volatile_register,
 	.readable_reg = rt5663_readable_register,
@@ -3277,7 +3279,8 @@ static const struct regmap_config temp_regmap = {
 	.name = "nocache",
 	.reg_bits = 16,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = 0x03f3,
 	.cache_type = REGCACHE_NONE,
 };
diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 6ba99f5ed3f4..f2ad3a4c3b7f 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4633,7 +4633,8 @@ static const struct regmap_config rt5665_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = rt5665_reg,
 	.num_reg_defaults = ARRAY_SIZE(rt5665_reg),
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static const struct i2c_device_id rt5665_i2c_id[] = {
diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index 3c19d03f2446..3f6046a66b56 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2375,7 +2375,8 @@ static const struct regmap_config rt5668_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = rt5668_reg,
 	.num_reg_defaults = ARRAY_SIZE(rt5668_reg),
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static const struct i2c_device_id rt5668_i2c_id[] = {
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 732ef928b25d..f0f8debc2829 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2814,7 +2814,8 @@ static const struct snd_soc_component_driver soc_component_dev_rt5670 = {
 static const struct regmap_config rt5670_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 	.max_register = RT5670_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5670_ranges) *
 					       RT5670_PR_SPACING),
 	.volatile_reg = rt5670_volatile_register,
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 640d400ca013..23515bfef257 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2419,7 +2419,8 @@ static const struct regmap_config rt5682_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = rt5682_reg,
 	.num_reg_defaults = ARRAY_SIZE(rt5682_reg),
-	.use_single_rw = true,
+	.use_single_read = true,
+	.use_single_write = true,
 };
 
 static const struct i2c_device_id rt5682_i2c_id[] = {
-- 
2.11.0

