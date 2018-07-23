Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F276ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450D920875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkSKfskW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450D920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbeGWRAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:00:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39699 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbeGWRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:00:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so1724140wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tvUxwhCKq75M5Kj5g6KwaXItwimpitViFd9VBJeELCI=;
        b=VkSKfskWzoJ63aoca2AoE4+hjgoJzJT/YY2fo0/KnbRZdWCaj2InuuYTC4m8I4Z0I5
         sPqbe1slveN2aw64H2/ahXEndcaMLZpK32hjatKeTQkgSScZjrktTzqm6o+Jsa3daRL6
         HMZGR0CJyqBO8/h1yYlPb0pjyP0jD9QI9ocQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tvUxwhCKq75M5Kj5g6KwaXItwimpitViFd9VBJeELCI=;
        b=a9wLPPNSsxlWRGO8w34OFHcs+cn3UqLwerhmJ40hUDfnLf6uAkBH3QM5eMPTGlWfkN
         6yJyuL8SYD/jJj6zp3DDgLU3xmQjY9W4hEBT0gKYWMwAd4W3jnBnQOq3ncHiOASSdh/G
         Dck6bK182AIixax0GTH7d8xOIf8C+puv3MtY9hxYUomYbHCYQNEW8wfOSlSad50Y5KiR
         ua75W8yyyFXufz3UuBQE/b49sMOBdUEN2HulD4HY3WlkOKV0/OKV7Scv7/cPgVNaCepF
         trndyTEi+cmXGzKnrCB5OROga2tCsF+BVQf6htAvmPvkcAd6jNf5fBsG1S5CmSyjrFoJ
         Xr0A==
X-Gm-Message-State: AOUpUlGdlYCn7i/rfsAnmkbf5Qle2/wOxQQvt3OBDZyXcCCCIHW89WWl
        /YINpjls1Ld2y0AqtfjPLSpYIw==
X-Google-Smtp-Source: AAOMgpfPt8Sk0P+zmH3F/RVLa+uupLCPiyx+t0GAGsDI7v/GWtJkFnp4BLfWMqRP8XOZhNPZnV9o2A==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr7740747wmz.79.1532361499379;
        Mon, 23 Jul 2018 08:58:19 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 14-v6sm206385wmt.1.2018.07.23.08.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 08:58:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/12] mfd: wcd9335: add wcd irq support
Date:   Mon, 23 Jul 2018 16:54:01 +0100
Message-Id: <20180723155410.9494-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCD9335 supports two lines of irqs INTR1 and INTR2.
Mutiple interrupts are muxed via these lines.
INTR1 consists of all possible interrupt sources like:
Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mfd/Makefile                |   2 +-
 drivers/mfd/wcd9335-core.c          |   9 ++
 drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
 include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
 include/linux/mfd/wcd9335/wcd9335.h |   3 +
 5 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/wcd9335-irq.c
 create mode 100644 include/dt-bindings/mfd/wcd9335.h

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a4697370640b..210875afe78a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -58,7 +58,7 @@ obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
 endif
 
 obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
-wcd9335-objs			:= wcd9335-core.o
+wcd9335-objs			:= wcd9335-core.o wcd9335-irq.o
 
 obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
 wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
index ccdd27c3a351..7d478d87e16f 100644
--- a/drivers/mfd/wcd9335-core.c
+++ b/drivers/mfd/wcd9335-core.c
@@ -244,12 +244,20 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 		return ret;
 	}
 
+	wcd9335_irq_init(wcd);
 	wcd->slim_ifd = wcd->slim_ifd;
 
 	return mfd_add_devices(wcd->dev, 0, wcd9335_devices,
 			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);
 }
 
+static void wcd9335_slim_remove(struct slim_device *sdev)
+{
+	struct wcd9335 *wcd = dev_get_drvdata(&sdev->dev);
+
+	wcd9335_irq_exit(wcd);
+}
+
 static const struct slim_device_id wcd9335_slim_id[] = {
 	{0x217, 0x1a0, 0x1, 0x0},
 	{}
@@ -260,6 +268,7 @@ static struct slim_driver wcd9335_slim_driver = {
 		.name = "wcd9335-slim",
 	},
 	.probe = wcd9335_slim_probe,
+	.remove = wcd9335_slim_remove,
 	.device_status = wcd9335_slim_status,
 	.id_table = wcd9335_slim_id,
 };
diff --git a/drivers/mfd/wcd9335-irq.c b/drivers/mfd/wcd9335-irq.c
new file mode 100644
index 000000000000..84098c89419b
--- /dev/null
+++ b/drivers/mfd/wcd9335-irq.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+//
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/of_irq.h>
+#include <dt-bindings/mfd/wcd9335.h>
+#include <linux/mfd/wcd9335/wcd9335.h>
+#include <linux/mfd/wcd9335/registers.h>
+
+static const struct regmap_irq wcd9335_irqs[] = {
+	/* INTR_REG 0 */
+	[WCD9335_IRQ_SLIMBUS] = {
+		.reg_offset = 0,
+		.mask = BIT(0),
+	},
+	[WCD9335_IRQ_FLL_LOCK_LOSS] = {
+		.reg_offset = 0,
+		.mask = BIT(1),
+	},
+	[WCD9335_IRQ_HPH_PA_OCPL_FAULT] = {
+		.reg_offset = 0,
+		.mask = BIT(2),
+	},
+	[WCD9335_IRQ_HPH_PA_OCPR_FAULT] = {
+		.reg_offset = 0,
+		.mask = BIT(3),
+	},
+	[WCD9335_IRQ_EAR_PA_OCP_FAULT] = {
+		.reg_offset = 0,
+		.mask = BIT(4),
+	},
+	[WCD9335_IRQ_HPH_PA_CNPL_COMPLETE] = {
+		.reg_offset = 0,
+		.mask = BIT(5),
+	},
+	[WCD9335_IRQ_HPH_PA_CNPR_COMPLETE] = {
+		.reg_offset = 0,
+		.mask = BIT(6),
+	},
+	[WCD9335_IRQ_EAR_PA_CNP_COMPLETE] = {
+		.reg_offset = 0,
+		.mask = BIT(7),
+	},
+	/* INTR_REG 1 */
+	[WCD9335_IRQ_MBHC_SW_DET] = {
+		.reg_offset = 1,
+		.mask = BIT(0),
+	},
+	[WCD9335_IRQ_MBHC_ELECT_INS_REM_DET] = {
+		.reg_offset = 1,
+		.mask = BIT(1),
+	},
+	[WCD9335_IRQ_MBHC_BUTTON_PRESS_DET] = {
+		.reg_offset = 1,
+		.mask = BIT(2),
+	},
+	[WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET] = {
+		.reg_offset = 1,
+		.mask = BIT(3),
+	},
+	[WCD9335_IRQ_MBHC_ELECT_INS_REM_LEG_DET] = {
+		.reg_offset = 1,
+		.mask = BIT(4),
+	},
+	/* INTR_REG 2 */
+	[WCD9335_IRQ_LINE_PA1_CNP_COMPLETE] = {
+		.reg_offset = 2,
+		.mask = BIT(0),
+	},
+	[WCD9335_IRQ_LINE_PA2_CNP_COMPLETE] = {
+		.reg_offset = 2,
+		.mask = BIT(1),
+	},
+	[WCD9335_IRQ_LINE_PA3_CNP_COMPLETE] = {
+		.reg_offset = 2,
+		.mask = BIT(2),
+	},
+	[WCD9335_IRQ_LINE_PA4_CNP_COMPLETE] = {
+		.reg_offset = 2,
+		.mask = BIT(3),
+	},
+	[WCD9335_IRQ_SOUNDWIRE] = {
+		.reg_offset = 2,
+		.mask = BIT(4),
+	},
+	[WCD9335_IRQ_VDD_DIG_RAMP_COMPLETE] = {
+		.reg_offset = 2,
+		.mask = BIT(5),
+	},
+	[WCD9335_IRQ_RCO_ERROR] = {
+		.reg_offset = 2,
+		.mask = BIT(6),
+	},
+	[WCD9335_IRQ_SVA_ERROR] = {
+		.reg_offset = 2,
+		.mask = BIT(7),
+	},
+	/* INTR_REG 3 */
+	[WCD9335_IRQ_MAD_AUDIO] = {
+		.reg_offset = 3,
+		.mask = BIT(0),
+	},
+	[WCD9335_IRQ_MAD_BEACON] = {
+		.reg_offset = 3,
+		.mask = BIT(1),
+	},
+	[WCD9335_IRQ_MAD_ULTRASOUND] = {
+		.reg_offset = 3,
+		.mask = BIT(2),
+	},
+	[WCD9335_IRQ_VBAT_ATTACK] = {
+		.reg_offset = 3,
+		.mask = BIT(3),
+	},
+	[WCD9335_IRQ_VBAT_RESTORE] = {
+		.reg_offset = 3,
+		.mask = BIT(4),
+	},
+	[WCD9335_IRQ_SVA_OUTBOX1] = {
+		.reg_offset = 3,
+		.mask = BIT(5),
+	},
+	[WCD9335_IRQ_SVA_OUTBOX2] = {
+		.reg_offset = 3,
+		.mask = BIT(6),
+	},
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
+int wcd9335_irq_init(struct wcd9335 *wcd)
+{
+	int ret;
+	/*
+	 * INTR1 consists of all possible interrupt sources Ear OCP,
+	 * HPH OCP, MBHC, MAD, VBAT, and SVA
+	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
+	 */
+	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
+	if (wcd->intr1 < 0 || wcd->intr1 == -EPROBE_DEFER) {
+		dev_err(wcd->dev, "Unable to configure irq\n");
+		return wcd->intr1;
+	}
+
+	ret = regmap_add_irq_chip(wcd->regmap, wcd->intr1,
+				 IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+				 0, &wcd9335_regmap_irq1_chip,
+				 &wcd->irq_data);
+	if (ret != 0) {
+		dev_err(wcd->dev, "Failed to register IRQ chip: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int wcd9335_irq_exit(struct wcd9335 *wcd)
+{
+	regmap_del_irq_chip(wcd->intr1, wcd->irq_data);
+	return 0;
+}
diff --git a/include/dt-bindings/mfd/wcd9335.h b/include/dt-bindings/mfd/wcd9335.h
new file mode 100644
index 000000000000..17f985be8f52
--- /dev/null
+++ b/include/dt-bindings/mfd/wcd9335.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for WCD9335 device bindings.
+ *
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_MFD_WCD9335_H
+#define _DT_BINDINGS_MFD_WCD9335_H
+
+#define	WCD9335_IRQ_SLIMBUS			1
+#define	WCD9335_IRQ_FLL_LOCK_LOSS		2
+#define	WCD9335_IRQ_HPH_PA_OCPL_FAULT		3
+#define	WCD9335_IRQ_HPH_PA_OCPR_FAULT		4
+#define	WCD9335_IRQ_EAR_PA_OCP_FAULT		5
+#define	WCD9335_IRQ_HPH_PA_CNPL_COMPLETE	6
+#define	WCD9335_IRQ_HPH_PA_CNPR_COMPLETE	7
+#define	WCD9335_IRQ_EAR_PA_CNP_COMPLETE		8
+#define	WCD9335_IRQ_MBHC_SW_DET			9
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_DET	10
+#define	WCD9335_IRQ_MBHC_BUTTON_PRESS_DET	11
+#define	WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET	12
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_LEG_DET	13
+#define	WCD9335_IRQ_RESERVED_0			14
+#define	WCD9335_IRQ_RESERVED_1			15
+#define	WCD9335_IRQ_RESERVED_2			16
+#define	WCD9335_IRQ_LINE_PA1_CNP_COMPLETE	17
+#define	WCD9335_IRQ_LINE_PA2_CNP_COMPLETE	18
+#define	WCD9335_IRQ_LINE_PA3_CNP_COMPLETE	19
+#define	WCD9335_IRQ_LINE_PA4_CNP_COMPLETE	20
+#define	WCD9335_IRQ_SOUNDWIRE			21
+#define	WCD9335_IRQ_VDD_DIG_RAMP_COMPLETE	22
+#define	WCD9335_IRQ_RCO_ERROR			23
+#define	WCD9335_IRQ_SVA_ERROR			24
+#define	WCD9335_IRQ_MAD_AUDIO			25
+#define	WCD9335_IRQ_MAD_BEACON			26
+#define	WCD9335_IRQ_MAD_ULTRASOUND		27
+#define	WCD9335_IRQ_VBAT_ATTACK			28
+#define	WCD9335_IRQ_VBAT_RESTORE		29
+#define	WCD9335_IRQ_SVA_OUTBOX1			30
+#define	WCD9335_IRQ_SVA_OUTBOX2			31
+
+#endif /* _DT_BINDINGS_MFD_WCD9335_H */
diff --git a/include/linux/mfd/wcd9335/wcd9335.h b/include/linux/mfd/wcd9335/wcd9335.h
index 6b7fa6a66d8f..ac0853625c72 100644
--- a/include/linux/mfd/wcd9335/wcd9335.h
+++ b/include/linux/mfd/wcd9335/wcd9335.h
@@ -37,4 +37,7 @@ struct wcd9335 {
 	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 };
 
+extern int wcd9335_irq_init(struct wcd9335 *wcd);
+extern int wcd9335_irq_exit(struct wcd9335 *wcd);
+
 #endif /* __WCD9335_H__ */
-- 
2.16.2

