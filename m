Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1066020867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XheSZURX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1066020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIDOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:52:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53957 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIDOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:52:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so3831154wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tLhsmS/tYLvaeyroShZfcALGFxP0X7g73uUGhVVsmUA=;
        b=XheSZURXybH6gynbO9xFmh1k+HgdvSQZGAHVXn38kSpf5K8HfP8gzSYyQqJVP2x5Sd
         bFuBHiRfn/TdySK5wDfnFvbC2Lw/kcYflQdlZQgsQ77K/PkixeSNsN7I+gRZZ9ULjBHB
         YL0GU9HbDdOgZr+R2mFc07fPQiqle0UUypgsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tLhsmS/tYLvaeyroShZfcALGFxP0X7g73uUGhVVsmUA=;
        b=YGpapWI6oGD7zjtxRKNidNkWV/kgHdT9XaLeiNt+TeSyjuKbKyPo7/zmeuYN/QF7Vh
         83zUn4iQ0rhyPra6eSU+2KUpdeFkxSqvj3L4bxtHLCJ2is4AhCOZTx1OwgkEtjsF03kY
         PCLo1abccEEmWHQImqbte6dCRhMs/7O6oQP+xpNw0PZCAYJf9TJ+OUkmMlAm/j+SgWcr
         jRZzEB7gGm9pTQsk3NeW+WzDnmBT0BSLpw4SJ7aJPN/UTmdauCCbxaS82wE6oE41igQ4
         bfeyXe2M5C0QdIVij5z1RVpUzIkuV8FPu6yAS2uG1tOdcJyNch47aF/ysUVjT+sAYjTw
         7/Ww==
X-Gm-Message-State: APzg51C14f+kTOVJmYD18PwOF/jOXcfeKM0kCGlNfYIekyxoUHpnk24T
        ntPbwU9rT4J8debuXUY8HdeVDw==
X-Google-Smtp-Source: ANB0VdaNoEQaX1/tBLdVDq8LB1zoMqkPFLLxMfycTZgihC+HI94VH9/+IsTrGWwFfqbOOMnI9V8fVw==
X-Received: by 2002:a1c:9b91:: with SMTP id d139-v6mr2104359wme.50.1536056853653;
        Tue, 04 Sep 2018 03:27:33 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g129-v6sm16903325wmf.42.2018.09.04.03.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:27:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 03/13] mfd: wcd9335: add wcd irq support
Date:   Tue,  4 Sep 2018 11:24:50 +0100
Message-Id: <20180904102500.30318-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCD9335 supports two lines of irqs INTR1 and INTR2. Multiple interrupts
are muxed via these lines. INTR1 consists of all possible interrupt
sources like: Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA. INTR2 is a
subset of first interrupt sources like MAD, VBAT, and SVA

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/mfd/wcd9335-core.c          | 78 +++++++++++++++++++++++++++++
 include/linux/mfd/wcd9335/wcd9335.h | 33 ++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
index dbfae50c28b2..e2fc438c1a34 100644
--- a/drivers/mfd/wcd9335-core.c
+++ b/drivers/mfd/wcd9335-core.c
@@ -3,6 +3,7 @@
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/wcd9335/registers.h>
@@ -10,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -84,6 +86,52 @@ static struct regmap_config wcd9335_ifc_regmap_config = {
 	.num_ranges = ARRAY_SIZE(wcd9335_ifc_ranges),
 };
 
+static const struct regmap_irq wcd9335_irqs[] = {
+	/* INTR_REG 0 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_SLIMBUS, 0, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_FLL_LOCK_LOSS, 0, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_OCPL_FAULT, 0, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_OCPR_FAULT, 0, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_EAR_PA_OCP_FAULT, 0, BIT(4)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_CNPL_COMPLETE, 0, BIT(5)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_CNPR_COMPLETE, 0, BIT(6)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_EAR_PA_CNP_COMPLETE, 0, BIT(7)),
+	/* INTR_REG 1 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_SW_DET, 1, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_ELECT_INS_REM_DET, 1, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_BUTTON_PRESS_DET, 1, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET, 1, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_ELECT_INS_REM_LEG_DET, 1, BIT(4)),
+	/* INTR_REG 2 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA1_CNP_COMPLETE, 2, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA2_CNP_COMPLETE, 2, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA3_CNP_COMPLETE, 2, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA4_CNP_COMPLETE, 2, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SOUNDWIRE, 2, BIT(4)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_VDD_DIG_RAMP_COMPLETE, 2, BIT(5)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_RCO_ERROR, 2, BIT(6)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SVA_ERROR, 2, BIT(7)),
+	/* INTR_REG 3 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_MAD_AUDIO, 3, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MAD_BEACON, 3, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MAD_ULTRASOUND, 3, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_VBAT_ATTACK, 3, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_VBAT_RESTORE, 3, BIT(4)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SVA_OUTBOX1, 3, BIT(5)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SVA_OUTBOX2, 3, BIT(6)),
+};
+
+static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
+	.name = "wcd9335_pin1_irq",
+	.status_base = WCD9335_INTR_PIN1_STATUS0,
+	.mask_base = WCD9335_INTR_PIN1_MASK0,
+	.ack_base = WCD9335_INTR_PIN1_CLEAR0,
+	.type_base = WCD9335_INTR_LEVEL0,
+	.num_regs = 4,
+	.irqs = wcd9335_irqs,
+	.num_irqs = ARRAY_SIZE(wcd9335_irqs),
+};
+
 static int wcd9335_parse_dt(struct wcd9335 *wcd)
 {
 	struct device *dev = wcd->dev;
@@ -183,6 +231,32 @@ static int wcd9335_bring_up(struct wcd9335 *wcd)
 	return 0;
 }
 
+static int wcd9335_irq_init(struct wcd9335 *wcd)
+{
+	int ret;
+
+	/*
+	 * INTR1 consists of all possible interrupt sources Ear OCP,
+	 * HPH OCP, MBHC, MAD, VBAT, and SVA
+	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
+	 */
+	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
+	if (wcd->intr1 < 0) {
+		if (wcd->intr1 != -EPROBE_DEFER)
+			dev_err(wcd->dev, "Unable to configure IRQ\n");
+
+		return wcd->intr1;
+	}
+
+	ret = devm_regmap_add_irq_chip(wcd->dev, wcd->regmap, wcd->intr1,
+				 IRQF_TRIGGER_HIGH, 0,
+				 &wcd9335_regmap_irq1_chip, &wcd->irq_data);
+	if (ret)
+		dev_err(wcd->dev, "Failed to register IRQ chip: %d\n", ret);
+
+	return ret;
+}
+
 static int wcd9335_slim_probe(struct slim_device *slim)
 {
 	struct device *dev = &slim->dev;
@@ -264,6 +338,10 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 		return ret;
 	}
 
+	ret = wcd9335_irq_init(wcd);
+	if (ret)
+		return ret;
+
 	ret = devm_mfd_add_devices(wcd->dev, 0, wcd9335_devices,
 			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);
 	if (ret < 0)
diff --git a/include/linux/mfd/wcd9335/wcd9335.h b/include/linux/mfd/wcd9335/wcd9335.h
index b16d730aa1a4..82a18d08433f 100644
--- a/include/linux/mfd/wcd9335/wcd9335.h
+++ b/include/linux/mfd/wcd9335/wcd9335.h
@@ -9,6 +9,38 @@
 #define WCD9335_VERSION_2_0     2
 #define WCD9335_MAX_SUPPLY	5
 
+#define	WCD9335_IRQ_SLIMBUS			0
+#define	WCD9335_IRQ_FLL_LOCK_LOSS		1
+#define	WCD9335_IRQ_HPH_PA_OCPL_FAULT		2
+#define	WCD9335_IRQ_HPH_PA_OCPR_FAULT		3
+#define	WCD9335_IRQ_EAR_PA_OCP_FAULT		4
+#define	WCD9335_IRQ_HPH_PA_CNPL_COMPLETE	5
+#define	WCD9335_IRQ_HPH_PA_CNPR_COMPLETE	6
+#define	WCD9335_IRQ_EAR_PA_CNP_COMPLETE		7
+#define	WCD9335_IRQ_MBHC_SW_DET			8
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_DET	9
+#define	WCD9335_IRQ_MBHC_BUTTON_PRESS_DET	10
+#define	WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET	11
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_LEG_DET	12
+#define	WCD9335_IRQ_RESERVED_0			13
+#define	WCD9335_IRQ_RESERVED_1			14
+#define	WCD9335_IRQ_RESERVED_2			15
+#define	WCD9335_IRQ_LINE_PA1_CNP_COMPLETE	16
+#define	WCD9335_IRQ_LINE_PA2_CNP_COMPLETE	17
+#define	WCD9335_IRQ_LINE_PA3_CNP_COMPLETE	18
+#define	WCD9335_IRQ_LINE_PA4_CNP_COMPLETE	19
+#define	WCD9335_IRQ_SOUNDWIRE			20
+#define	WCD9335_IRQ_VDD_DIG_RAMP_COMPLETE	21
+#define	WCD9335_IRQ_RCO_ERROR			22
+#define	WCD9335_IRQ_SVA_ERROR			23
+#define	WCD9335_IRQ_MAD_AUDIO			24
+#define	WCD9335_IRQ_MAD_BEACON			25
+#define	WCD9335_IRQ_MAD_ULTRASOUND		26
+#define	WCD9335_IRQ_VBAT_ATTACK			27
+#define	WCD9335_IRQ_VBAT_RESTORE		28
+#define	WCD9335_IRQ_SVA_OUTBOX1			29
+#define	WCD9335_IRQ_SVA_OUTBOX2			30
+
 enum wcd_interface_type {
 	WCD9335_INTERFACE_TYPE_SLIMBUS = 1,
 	WCD9335_INTERFACE_TYPE_I2C,
@@ -26,6 +58,7 @@ struct wcd9335 {
 	struct slim_device *slim_ifc_dev;
 	struct regmap *regmap;
 	struct regmap *ifc_dev_regmap;
+	struct regmap_irq_chip_data *irq_data;
 	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 };
 
-- 
2.18.0

