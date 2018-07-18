Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E80ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DDF20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xTnXJbB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DDF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeGRPzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:55:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49334 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeGRPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hm6IFKkQl2tsX1kJ5xJc9pmlKd86r7gLD99WH+vyeAU=; b=xTnXJbB2iJil
        cB7TEaugO0BxA5CrH+Ya4I6Tmecpds+Wm2F9b9m+OHeD5udcBT2CIR6z9B5HXLnnnTMhUkDhkxPo2
        Yfvvjz79MGGgSHaHFmHNge86psfwA3jhG0UeHI7h4KxEeJ/9KZbifm3WL1KKb9MSj+4FwfOCBhL0P
        GOWuQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffoCM-0003fg-9g; Wed, 18 Jul 2018 15:17:02 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ffoCL-0004Lk-Ls; Wed, 18 Jul 2018 16:17:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: add SCCB support" to the regmap tree
In-Reply-To: 
Message-Id: <E1ffoCL-0004Lk-Ls@debutante>
Date:   Wed, 18 Jul 2018 16:17:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: add SCCB support

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From bcf7eac3d97f49d8400ba52c71bee5934bf20093 Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Tue, 17 Jul 2018 00:47:48 +0900
Subject: [PATCH] regmap: add SCCB support

This adds Serial Camera Control Bus (SCCB) support for regmap API that
is intended to be used by some of Omnivision sensor drivers.

The ov772x and ov9650 drivers are going to use this SCCB regmap API.

The ov772x driver was previously only worked with the i2c controller
drivers that support I2C_FUNC_PROTOCOL_MANGLING, because the ov772x
device doesn't support repeated starts.  After commit 0b964d183cbf
("media: ov772x: allow i2c controllers without
I2C_FUNC_PROTOCOL_MANGLING"), reading ov772x register is replaced with
issuing two separated i2c messages in order to avoid repeated start.
Using this SCCB regmap hides the implementation detail.

The ov9650 driver also issues two separated i2c messages to read the
registers as the device doesn't support repeated start.  So it can
make use of this SCCB regmap.

Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/Kconfig       |   4 +
 drivers/base/regmap/Makefile      |   1 +
 drivers/base/regmap/regmap-sccb.c | 128 ++++++++++++++++++++++++++++++
 include/linux/regmap.h            |  35 ++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/base/regmap/regmap-sccb.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index aff34c0c2a3e..6ad5ef48b61e 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -45,3 +45,7 @@ config REGMAP_IRQ
 config REGMAP_SOUNDWIRE
 	tristate
 	depends on SOUNDWIRE_BUS
+
+config REGMAP_SCCB
+	tristate
+	depends on I2C
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 5ed0023fabda..f5b4e8851d00 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
 obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
 obj-$(CONFIG_REGMAP_SOUNDWIRE) += regmap-sdw.o
+obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
diff --git a/drivers/base/regmap/regmap-sccb.c b/drivers/base/regmap/regmap-sccb.c
new file mode 100644
index 000000000000..b6eb876ea819
--- /dev/null
+++ b/drivers/base/regmap/regmap-sccb.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+// Register map access API - SCCB support
+
+#include <linux/regmap.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "internal.h"
+
+/**
+ * sccb_is_available - Check if the adapter supports SCCB protocol
+ * @adap: I2C adapter
+ *
+ * Return true if the I2C adapter is capable of using SCCB helper functions,
+ * false otherwise.
+ */
+static bool sccb_is_available(struct i2c_adapter *adap)
+{
+	u32 needed_funcs = I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA;
+
+	/*
+	 * If we ever want support for hardware doing SCCB natively, we will
+	 * introduce a sccb_xfer() callback to struct i2c_algorithm and check
+	 * for it here.
+	 */
+
+	return (i2c_get_functionality(adap) & needed_funcs) == needed_funcs;
+}
+
+/**
+ * regmap_sccb_read - Read data from SCCB slave device
+ * @context: Device that will be interacted wit
+ * @reg: Register to be read from
+ * @val: Pointer to store read value
+ *
+ * This executes the 2-phase write transmission cycle that is followed by a
+ * 2-phase read transmission cycle, returning negative errno else zero on
+ * success.
+ */
+static int regmap_sccb_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	int ret;
+	union i2c_smbus_data data;
+
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
+
+	ret = __i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
+			       I2C_SMBUS_WRITE, reg, I2C_SMBUS_BYTE, NULL);
+	if (ret < 0)
+		goto out;
+
+	ret = __i2c_smbus_xfer(i2c->adapter, i2c->addr, i2c->flags,
+			       I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &data);
+	if (ret < 0)
+		goto out;
+
+	*val = data.byte;
+out:
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
+
+	return ret;
+}
+
+/**
+ * regmap_sccb_write - Write data to SCCB slave device
+ * @context: Device that will be interacted wit
+ * @reg: Register to write to
+ * @val: Value to be written
+ *
+ * This executes the SCCB 3-phase write transmission cycle, returning negative
+ * errno else zero on success.
+ */
+static int regmap_sccb_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	return i2c_smbus_write_byte_data(i2c, reg, val);
+}
+
+static struct regmap_bus regmap_sccb_bus = {
+	.reg_write = regmap_sccb_write,
+	.reg_read = regmap_sccb_read,
+};
+
+static const struct regmap_bus *regmap_get_sccb_bus(struct i2c_client *i2c,
+					const struct regmap_config *config)
+{
+	if (config->val_bits == 8 && config->reg_bits == 8 &&
+			sccb_is_available(i2c->adapter))
+		return &regmap_sccb_bus;
+
+	return ERR_PTR(-ENOTSUPP);
+}
+
+struct regmap *__regmap_init_sccb(struct i2c_client *i2c,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_sccb_bus(i2c, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(&i2c->dev, bus, &i2c->dev, config,
+			     lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_sccb);
+
+struct regmap *__devm_regmap_init_sccb(struct i2c_client *i2c,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name)
+{
+	const struct regmap_bus *bus = regmap_get_sccb_bus(i2c, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(&i2c->dev, bus, &i2c->dev, config,
+				  lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_sccb);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068ffb71..52bf358e2c73 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -514,6 +514,10 @@ struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__regmap_init_sccb(struct i2c_client *i2c,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name);
 struct regmap *__regmap_init_slimbus(struct slim_device *slimbus,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
@@ -558,6 +562,10 @@ struct regmap *__devm_regmap_init_i2c(struct i2c_client *i2c,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name);
+struct regmap *__devm_regmap_init_sccb(struct i2c_client *i2c,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name);
 struct regmap *__devm_regmap_init_spi(struct spi_device *dev,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
@@ -645,6 +653,19 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 	__regmap_lockdep_wrapper(__regmap_init_i2c, #config,		\
 				i2c, config)
 
+/**
+ * regmap_init_sccb() - Initialise register map
+ *
+ * @i2c: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_sccb(i2c, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_sccb, #config,		\
+				i2c, config)
+
 /**
  * regmap_init_slimbus() - Initialise register map
  *
@@ -797,6 +818,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_i2c, #config,	\
 				i2c, config)
 
+/**
+ * devm_regmap_init_sccb() - Initialise managed register map
+ *
+ * @i2c: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_sccb(i2c, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_sccb, #config,	\
+				i2c, config)
+
 /**
  * devm_regmap_init_spi() - Initialise register map
  *
-- 
2.18.0

