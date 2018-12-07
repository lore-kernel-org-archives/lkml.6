Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65047C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200112146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vkxblg++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200112146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLGNFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:05:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52490 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGNFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:05:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so4302159wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fk//bO043RRyjcRyJlk1b4/dYR1NzGmrNld0Pgxy2QY=;
        b=vkxblg++YLMXA5QW81W/49Ei4FsEGNGRNHZu+JkicQZPRpY5EP+vpvvpAwEtTtiRZc
         Z17V91w5Zar66pLGvqlEg34/i/P0MV48NppNAwdhpKpKRYTVFHTVffDPv9PsN12Vx1N4
         /jEh08urmulVcyt4timHrQ/N8iu+HUHk9Dkbt7yIsEiagQR3tm0i86KUZKPCr1D67n68
         brc759ChveSexZomc+oX8Ega+75CZlsx7sNIWmJjVLk41y/aWuCECtM/z6538u/Jq3cT
         RuDNmtLiWM0XOGx0MBJP3GbnsusZfNZZ2rtKJ4sCWw2eJiXCu5oj4exLpv1zXJn+QZoe
         hdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fk//bO043RRyjcRyJlk1b4/dYR1NzGmrNld0Pgxy2QY=;
        b=cGjNuCgusoCEqroVRnjuj/vMhic6U3nL1iRM+9gHfBEJSbhKU/sWGEx7Yc2t224nZL
         SezmdxuXSxJnPuGxfVr4/WdRdaeoBS0DksFfz4J4GDF9HhYeaj0sqaNFeE7j2VvyXpJt
         ymNrBeSsqzSLUguqLxc9okmm5P6R08TriP1CB+LTBX+sRfrmMn82fGudRsqKi+LopN81
         mS4H4G5osBgOVphtaN2QYhKI+5RupBxzFXHvsmBGr7eZhtSoLZAVZuF6kzInTDBn5OfY
         qp9cceUVX3Uo3oLhiBX4Csux7cY4oOGah3FtlXQPq19KGU83v/OXnjIwG4KQOZiogBti
         Fc4Q==
X-Gm-Message-State: AA+aEWbSVm6T52O6MA2bcLZvJUXkmbJz4RCJIp2WP4kRO71B0H8BG4u8
        QRrAynij+CO0xttR71IO1u14sBsyjws=
X-Google-Smtp-Source: AFSGD/XVJR4aHtPv51j3hOurx7KGDH/Dv73pWmhPq1xn+LcKCH6wEL7QGfxqIZgIDrRuNdGbREsOgQ==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr2326781wmh.76.1544187899722;
        Fri, 07 Dec 2018 05:04:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l202sm7940195wma.33.2018.12.07.05.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 05:04:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2] regmap: irq: handle HW using separate rising/falling edge interrupts
Date:   Fri,  7 Dec 2018 14:04:52 +0100
Message-Id: <20181207130452.1910-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some interrupt controllers use separate bits for controlling rising
and falling edge interrupts in the mask register i.e. they have one
interrupt for rising edge and one for falling.

We already handle the case where we have a single interrupt in the
mask register and a separate type configuration register.

Add a new switch to regmap_irq_chip which tells the framework to use
the mask_base address for configuring the edge of the interrupts that
define type_falling/rising_mask values.

For such interrupts we never update the type_base bits. For interrupts
that don't define type masks or their regmap irq chip doesn't set the
type_in_mask to true everything stays the same.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
This is a second try at supporting HW which uses separate interrupts
for rising/falling edge events.

This time we're adding an explicit flag for such chips.

Below is an example of the regmap irq chip configuration that makes
use of this new feature:

static const struct regmap_irq foobar_irqs[] = {
	/*
	 * Make two interrupts into a single virtual irq with
	 * configurable edge.
	 */
	[FOOBAR_INT_EDGE] = {
		.reg_offset		= FOOBAR_INT_GLBL_OFFSET,
		/* mask is two bits here but regmap handles it nicely */
		.mask			= FOOBAR_INT_GPIO_MSK,
		.type_falling_mask	= FOOBAR_INT_GPIO_F_MSK,
		.type_rising_mask	= FOOBAR_INT_GPIO_R_MSK,
	},
	/* Regular interrupt, nothing changes. */
	[FOOBAR_INT_NOEDGE] = {
		.reg_offset		= FOOBAR_INT_GLBL_OFFSET,
		.mask			= FOOBAR_INT_FOO_MSK,
	},

static struct regmap_irq_chip foobar_irq_chip = {
	.name			= "foobar-irq",
	.irqs			= foobar_irqs,
	.num_irqs		= ARRAY_SIZE(foobar_irqs),
	.num_regs		= 2,
	.status_base		= FOOBAR_REG_INT_GLBL,
	.mask_base		= FOOBAR_REG_INTM_GLBL,
	.type_in_mask		= true,
	/* NOTE: we're not defining type_base here. */
};

 drivers/base/regmap/regmap-irq.c | 64 ++++++++++++++++++++++----------
 include/linux/regmap.h           |  4 ++
 2 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8ed7e51..603b1554f81c 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -157,20 +157,23 @@ static void regmap_irq_sync_unlock(struct irq_data *data)
 		}
 	}
 
-	for (i = 0; i < d->chip->num_type_reg; i++) {
-		if (!d->type_buf_def[i])
-			continue;
-		reg = d->chip->type_base +
-			(i * map->reg_stride * d->type_reg_stride);
-		if (d->chip->type_invert)
-			ret = regmap_irq_update_bits(d, reg,
-				d->type_buf_def[i], ~d->type_buf[i]);
-		else
-			ret = regmap_irq_update_bits(d, reg,
-				d->type_buf_def[i], d->type_buf[i]);
-		if (ret != 0)
-			dev_err(d->map->dev, "Failed to sync type in %x\n",
-				reg);
+	/* Don't update the type bits if we're using mask bits for irq type. */
+	if (!d->chip->type_in_mask) {
+		for (i = 0; i < d->chip->num_type_reg; i++) {
+			if (!d->type_buf_def[i])
+				continue;
+			reg = d->chip->type_base +
+				(i * map->reg_stride * d->type_reg_stride);
+			if (d->chip->type_invert)
+				ret = regmap_irq_update_bits(d, reg,
+					d->type_buf_def[i], ~d->type_buf[i]);
+			else
+				ret = regmap_irq_update_bits(d, reg,
+					d->type_buf_def[i], d->type_buf[i]);
+			if (ret != 0)
+				dev_err(d->map->dev, "Failed to sync type in %x\n",
+					reg);
+		}
 	}
 
 	if (d->chip->runtime_pm)
@@ -194,8 +197,27 @@ static void regmap_irq_enable(struct irq_data *data)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
+	unsigned int mask, type;
+
+	type = irq_data->type_falling_mask | irq_data->type_rising_mask;
+
+	/*
+	 * The type_in_mask flag means that the underlying hardware uses
+	 * separate mask bits for rising and falling edge interrupts, but
+	 * we want to make them into a single virtual interrupt with
+	 * configurable edge.
+	 *
+	 * If the interrupt we're enabling defines the falling or rising
+	 * masks then instead of using the regular mask bits for this
+	 * interrupt, use the value previously written to the type buffer
+	 * at the corresponding offset in regmap_irq_set_type().
+	 */
+	if (d->chip->type_in_mask && type)
+		mask = d->type_buf[irq_data->reg_offset / map->reg_stride];
+	else
+		mask = irq_data->mask;
 
-	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~irq_data->mask;
+	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~mask;
 }
 
 static void regmap_irq_disable(struct irq_data *data)
@@ -430,6 +452,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 	struct regmap_irq_chip_data *d;
 	int i;
 	int ret = -ENOMEM;
+	int num_type_reg;
 	u32 reg;
 	u32 unmask_offset;
 
@@ -479,13 +502,14 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 			goto err_alloc;
 	}
 
-	if (chip->num_type_reg) {
-		d->type_buf_def = kcalloc(chip->num_type_reg,
-					sizeof(unsigned int), GFP_KERNEL);
+	num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
+	if (num_type_reg) {
+		d->type_buf_def = kcalloc(num_type_reg,
+					  sizeof(unsigned int), GFP_KERNEL);
 		if (!d->type_buf_def)
 			goto err_alloc;
 
-		d->type_buf = kcalloc(chip->num_type_reg, sizeof(unsigned int),
+		d->type_buf = kcalloc(num_type_reg, sizeof(unsigned int),
 				      GFP_KERNEL);
 		if (!d->type_buf)
 			goto err_alloc;
@@ -600,7 +624,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 		}
 	}
 
-	if (chip->num_type_reg) {
+	if (chip->num_type_reg && !chip->type_in_mask) {
 		for (i = 0; i < chip->num_irqs; i++) {
 			reg = chip->irqs[i].type_reg_offset / map->reg_stride;
 			d->type_buf_def[reg] |= chip->irqs[i].type_rising_mask |
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a367d59c301d..b7aa50cfb306 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1131,6 +1131,9 @@ struct regmap_irq {
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_invert: Invert the type flags.
+ * @type_in_mask: Use the mask registers for controlling irq type. For
+ *                interrupts defining type_rising/falling_mask use mask_base
+ *                for edge configuration and never update bits in type_base.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -1169,6 +1172,7 @@ struct regmap_irq_chip {
 	bool wake_invert:1;
 	bool runtime_pm:1;
 	bool type_invert:1;
+	bool type_in_mask:1;
 
 	int num_regs;
 
-- 
2.19.1

