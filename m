Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60516C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162672070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545244584;
	bh=Ae+VIR6bjbRzEITcTTfN37kvfxCuvYRtNWcYmHa3F5I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TjO0OIphn/folXDtpXReILpDVGFa8XDCbfH7MtVNA5wLheQ8KYOkcv3h573xgKDWX
	 qrp/5ViIPBPpAjXBVybTjvtQoqJjg71Z7iKfBYePaMjXNKWO+IyFDfQ6C+vhZD6GD6
	 GtDfc+9LeCNSSOBKondhHh5P6vFjzpBU/2ClTJQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbeLSSgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:36:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeLSSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DBGr6rRYweCd80Qs8To8DRCtfHhILbyoBP9ZVEXXR08=; b=Xj+76A6dgZZg
        LmiyagLc3WdqlgRStBQLAObxWTdL/+3hXoIckkzPAPJ4jKApczf03FhR5A4KhO1/dhoAGh9k3zxyd
        xgf/TJChD6a5Mos6naKVLaYNnvflXdNJ62fsoKd7hU3FjBZKkjaJuyUx6fP/JDi8Yk4+LL3PONFwT
        6/xEk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZghe-0005LU-BJ; Wed, 19 Dec 2018 18:36:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DF78111259E9; Wed, 19 Dec 2018 18:36:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: regmap-irq/gpio-max77620: add level-irq support" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181219183617.DF78111259E9@debutante.sirena.org.uk>
Date:   Wed, 19 Dec 2018 18:36:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: regmap-irq/gpio-max77620: add level-irq support

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

From 1c2928e3e3212252b505b746ec10951027a95813 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Tue, 18 Dec 2018 13:59:31 +0200
Subject: [PATCH] regmap: regmap-irq/gpio-max77620: add level-irq support

Add level active IRQ support to regmap-irq irqchip. Change breaks
existing regmap-irq type setting. Convert the existing drivers which
use regmap-irq with trigger type setting (gpio-max77620) to work
with this new approach. So we do not magically support level-active
IRQs on gpio-max77620 - but add support to the regmap-irq for chips
which support them =)

We do not support distinguishing situation where HW supports rising
and falling edge detection but not both. Separating this would require
inventing yet another flags for IRQ types.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 35 ++++++++----
 drivers/gpio/gpio-max77620.c     | 96 +++++++++++++++++++++-----------
 include/linux/regmap.h           | 27 +++++++--
 3 files changed, 110 insertions(+), 48 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 8b216b2e2c19..31d23c9a5ae7 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -199,7 +199,7 @@ static void regmap_irq_enable(struct irq_data *data)
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
 	unsigned int mask, type;
 
-	type = irq_data->type_falling_mask | irq_data->type_rising_mask;
+	type = irq_data->type.type_falling_val | irq_data->type.type_rising_val;
 
 	/*
 	 * The type_in_mask flag means that the underlying hardware uses
@@ -234,27 +234,42 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
-	int reg = irq_data->type_reg_offset / map->reg_stride;
+	int reg;
+	const struct regmap_irq_type *t = &irq_data->type;
 
-	if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
-		return 0;
+	if ((t->types_supported & type) != type)
+		return -ENOTSUPP;
+
+	reg = t->type_reg_offset / map->reg_stride;
 
-	d->type_buf[reg] &= ~(irq_data->type_falling_mask |
-					irq_data->type_rising_mask);
+	if (t->type_reg_mask)
+		d->type_buf[reg] &= ~t->type_reg_mask;
+	else
+		d->type_buf[reg] &= ~(t->type_falling_val |
+				      t->type_rising_val |
+				      t->type_level_low_val |
+				      t->type_level_high_val);
 	switch (type) {
 	case IRQ_TYPE_EDGE_FALLING:
-		d->type_buf[reg] |= irq_data->type_falling_mask;
+		d->type_buf[reg] |= t->type_falling_val;
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
-		d->type_buf[reg] |= irq_data->type_rising_mask;
+		d->type_buf[reg] |= t->type_rising_val;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
-		d->type_buf[reg] |= (irq_data->type_falling_mask |
-					irq_data->type_rising_mask);
+		d->type_buf[reg] |= (t->type_falling_val |
+					t->type_rising_val);
 		break;
 
+	case IRQ_TYPE_LEVEL_HIGH:
+		d->type_buf[reg] |= t->type_level_high_val;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		d->type_buf[reg] |= t->type_level_low_val;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index 538bce4b5b42..65fa3a198ebd 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -25,60 +25,92 @@ struct max77620_gpio {
 
 static const struct regmap_irq max77620_gpio_irqs[] = {
 	[0] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE0,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 0,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE0,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 0,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[1] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE1,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 1,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE1,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 1,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[2] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE2,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 2,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE2,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 2,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[3] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE3,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 3,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE3,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 3,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[4] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE4,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 4,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE4,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 4,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[5] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE5,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 5,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE5,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 5,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[6] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE6,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 6,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE6,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 6,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 	[7] = {
-		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE7,
-		.type_rising_mask = MAX77620_CNFG_GPIO_INT_RISING,
-		.type_falling_mask = MAX77620_CNFG_GPIO_INT_FALLING,
 		.reg_offset = 0,
-		.type_reg_offset = 7,
+		.mask = MAX77620_IRQ_LVL2_GPIO_EDGE7,
+		.type = {
+			.type_rising_val = MAX77620_CNFG_GPIO_INT_RISING,
+			.type_falling_val = MAX77620_CNFG_GPIO_INT_FALLING,
+			.type_reg_mask = MAX77620_CNFG_GPIO_INT_MASK,
+			.type_reg_offset = 7,
+			.types_supported = IRQ_TYPE_EDGE_BOTH,
+		},
 	},
 };
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index c54c778f3051..0f1832e4c2c8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1089,22 +1089,37 @@ int regmap_fields_read(struct regmap_field *field, unsigned int id,
 int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
 				   unsigned int mask, unsigned int val,
 				   bool *change, bool async, bool force);
+/**
+ * struct regmap_irq_type - IRQ type definitions.
+ *
+ * @type_reg_offset: Offset register for the irq type setting.
+ * @type_rising_val: Register value to configure RISING type irq.
+ * @type_falling_val: Register value to configure FALLING type irq.
+ * @type_level_low_val: Register value to configure LEVEL_LOW type irq.
+ * @type_level_high_val: Register value to configure LEVEL_HIGH type irq.
+ * @types_supported: logical OR of IRQ_TYPE_* flags indicating supported types.
+ */
+struct regmap_irq_type {
+	unsigned int type_reg_offset;
+	unsigned int type_reg_mask;
+	unsigned int type_rising_val;
+	unsigned int type_falling_val;
+	unsigned int type_level_low_val;
+	unsigned int type_level_high_val;
+	unsigned int types_supported;
+};
 
 /**
  * struct regmap_irq - Description of an IRQ for the generic regmap irq_chip.
  *
  * @reg_offset: Offset of the status/mask register within the bank
  * @mask:       Mask used to flag/control the register.
- * @type_reg_offset: Offset register for the irq type setting.
- * @type_rising_mask: Mask bit to configure RISING type irq.
- * @type_falling_mask: Mask bit to configure FALLING type irq.
+ * @type:	IRQ trigger type setting details if supported.
  */
 struct regmap_irq {
 	unsigned int reg_offset;
 	unsigned int mask;
-	unsigned int type_reg_offset;
-	unsigned int type_rising_mask;
-	unsigned int type_falling_mask;
+	struct regmap_irq_type type;
 };
 
 #define REGMAP_IRQ_REG(_irq, _off, _mask)		\
-- 
2.19.0.rc2

