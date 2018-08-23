Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B96EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C472154C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PDzR6lXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C472154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeHWPaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:30:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36593 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732281AbeHWPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:30:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so5254647wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J14rIL1Ra2+GuM0kzPhpPPGaX1+GE9iEc/QEOXMrQeE=;
        b=PDzR6lXEZ39fYlMPLqXYb9fWwhF649WVVHsw7ssUSZsi92mlO5fPJJN37FG9yMZCCB
         /OOG1GxQW2sWSgajziNtsKDccV5mFE88paGDQ4RfyDZnWW8dkSgD3idRFFxLASUq3JSp
         oPDUmspfx7c1rBhW/m1AoIB7O53CLkqYPnq73GxHqVG+N3YXWAEk/XOuW0qQg0dNgBi7
         BM81HRH6ubDBkpCnOrvRtG4W6RgEbSOfD5wQlPqLlBQwKDnuNg1Wquhb9vKIO8BVWPAl
         BDhK/lnvol/NuQPAwL6Bg4vkqIA1KxaxnJwtwGLbeRdo0fFm4HCqkkeKheNw17NUSPfT
         3j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J14rIL1Ra2+GuM0kzPhpPPGaX1+GE9iEc/QEOXMrQeE=;
        b=gIcXCwk7XKwXScLwUe/PENuoguOBjJ6t2IBL+RMbIOiB7KeJ7o00zQ6N4a1lNocIoQ
         DWxi09oBlGw1kJk8OKCbCAGnKfoVXEgcxqz4d4JjoTuEm6L9Hw+fYsvKiewc+0L7df51
         KdkSI/VOnwuXr52zGGwRe8fCw43i7NhZ5j92phTTRywq+bUJpJ99wYR4QfOZ7GjRQaYM
         TLZVLzAC82bgi5nqJtQQCnVyHHTBW9H7IGAIbfOzhlxESY37ybEPT5ojAMBKkAOPO5eI
         UvyOQjJ7jLFqKH7YikoASM9DQVL7vtLfcc8c8qDzAuB4fcHzSC2bfrCflSdCucQBR2B/
         F9rQ==
X-Gm-Message-State: APzg51ABLoG3MremRhSwF5Vq0DcN0gmuKOZIWTzEJXPMb0oWNvv1V/S7
        IPyEOnnChhhpDQ05XTktzVppfQ==
X-Google-Smtp-Source: ANB0VdYQoyncAaM6fFOXphHsOQvc+i4tYazkX3wH97gcv7J7k6vC0M8eCS9rZwjOsPu6QeLcbbwiug==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202-v6mr5012038wme.148.1535025646948;
        Thu, 23 Aug 2018 05:00:46 -0700 (PDT)
Received: from localhost.localdomain (81-67-76-113.rev.numericable.fr. [81.67.76.113])
        by smtp.gmail.com with ESMTPSA id y10-v6sm2830419wrl.87.2018.08.23.05.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 05:00:46 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] soc: amlogic: add meson-canvas driver
Date:   Thu, 23 Aug 2018 13:49:53 +0200
Message-Id: <20180823114954.30704-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823114954.30704-1-mjourdan@baylibre.com>
References: <20180823114954.30704-1-mjourdan@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic SoCs have a repository of 256 canvas which they use to
describe pixel buffers.

They contain metadata like width, height, block mode, endianness [..]

Many IPs within those SoCs like vdec/vpu rely on those canvas to read/write
pixels.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/soc/amlogic/Kconfig              |   7 +
 drivers/soc/amlogic/Makefile             |   1 +
 drivers/soc/amlogic/meson-canvas.c       | 185 +++++++++++++++++++++++
 include/linux/soc/amlogic/meson-canvas.h |  65 ++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index b04f6e4aedbc..2f282b472912 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -1,5 +1,12 @@
 menu "Amlogic SoC drivers"
 
+config MESON_CANVAS
+	tristate "Amlogic Meson Canvas driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	default n
+	help
+	  Say yes to support the canvas IP for Amlogic SoCs.
+
 config MESON_GX_SOCINFO
 	bool "Amlogic Meson GX SoC Information driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index 8fa321893928..0ab16d35ac36 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
 obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
 obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
new file mode 100644
index 000000000000..fce33ca76bb6
--- /dev/null
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 BayLibre, SAS
+ * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
+ * Copyright (C) 2014 Endless Mobile
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/soc/amlogic/meson-canvas.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+
+#define NUM_CANVAS 256
+
+/* DMC Registers */
+#define DMC_CAV_LUT_DATAL	0x00
+	#define CANVAS_WIDTH_LBIT	29
+	#define CANVAS_WIDTH_LWID	3
+#define DMC_CAV_LUT_DATAH	0x04
+	#define CANVAS_WIDTH_HBIT	0
+	#define CANVAS_HEIGHT_BIT	9
+	#define CANVAS_WRAP_BIT		22
+	#define CANVAS_BLKMODE_BIT	24
+	#define CANVAS_ENDIAN_BIT	26
+#define DMC_CAV_LUT_ADDR	0x08
+	#define CANVAS_LUT_WR_EN	BIT(9)
+	#define CANVAS_LUT_RD_EN	BIT(8)
+
+struct meson_canvas {
+	struct device *dev;
+	void __iomem *reg_base;
+	spinlock_t lock; /* canvas device lock */
+	u8 used[NUM_CANVAS];
+};
+
+static void canvas_write(struct meson_canvas *canvas, u32 reg, u32 val)
+{
+	writel_relaxed(val, canvas->reg_base + reg);
+}
+
+static u32 canvas_read(struct meson_canvas *canvas, u32 reg)
+{
+	return readl_relaxed(canvas->reg_base + reg);
+}
+
+struct meson_canvas *meson_canvas_get(struct device *dev)
+{
+	struct device_node *canvas_node;
+	struct platform_device *canvas_pdev;
+
+	canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
+	if (!canvas_node)
+		return ERR_PTR(-ENODEV);
+
+	canvas_pdev = of_find_device_by_node(canvas_node);
+	if (!canvas_pdev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return dev_get_drvdata(&canvas_pdev->dev);
+}
+EXPORT_SYMBOL_GPL(meson_canvas_get);
+
+int meson_canvas_config(struct meson_canvas *canvas, u8 canvas_index,
+			u32 addr, u32 stride, u32 height,
+			unsigned int wrap,
+			unsigned int blkmode,
+			unsigned int endian)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&canvas->lock, flags);
+	if (!canvas->used[canvas_index]) {
+		dev_err(canvas->dev,
+			"Trying to setup non allocated canvas %u\n",
+			canvas_index);
+		spin_unlock_irqrestore(&canvas->lock, flags);
+		return -EINVAL;
+	}
+
+	canvas_write(canvas, DMC_CAV_LUT_DATAL,
+		     ((addr + 7) >> 3) |
+		     (((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
+
+	canvas_write(canvas, DMC_CAV_LUT_DATAH,
+		     ((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
+						CANVAS_WIDTH_HBIT) |
+		     (height << CANVAS_HEIGHT_BIT) |
+		     (wrap << CANVAS_WRAP_BIT) |
+		     (blkmode << CANVAS_BLKMODE_BIT) |
+		     (endian << CANVAS_ENDIAN_BIT));
+
+	canvas_write(canvas, DMC_CAV_LUT_ADDR,
+		     CANVAS_LUT_WR_EN | canvas_index);
+
+	/* Force a read-back to make sure everything is flushed. */
+	canvas_read(canvas, DMC_CAV_LUT_DATAH);
+	spin_unlock_irqrestore(&canvas->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_canvas_config);
+
+int meson_canvas_alloc(struct meson_canvas *canvas, u8 *canvas_index)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&canvas->lock, flags);
+	for (i = 0; i < NUM_CANVAS; ++i) {
+		if (!canvas->used[i]) {
+			canvas->used[i] = 1;
+			spin_unlock_irqrestore(&canvas->lock, flags);
+			*canvas_index = i;
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&canvas->lock, flags);
+
+	dev_err(canvas->dev, "No more canvas available\n");
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(meson_canvas_alloc);
+
+int meson_canvas_free(struct meson_canvas *canvas, u8 canvas_index)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&canvas->lock, flags);
+	if (!canvas->used[canvas_index]) {
+		dev_err(canvas->dev,
+			"Trying to free unused canvas %u\n", canvas_index);
+		spin_unlock_irqrestore(&canvas->lock, flags);
+		return -EINVAL;
+	}
+	canvas->used[canvas_index] = 0;
+	spin_unlock_irqrestore(&canvas->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(meson_canvas_free);
+
+static int meson_canvas_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct meson_canvas *canvas;
+	struct device *dev = &pdev->dev;
+
+	canvas = devm_kzalloc(dev, sizeof(*canvas), GFP_KERNEL);
+	if (!canvas)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	canvas->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(canvas->reg_base))
+		return PTR_ERR(canvas->reg_base);
+
+	canvas->dev = dev;
+	spin_lock_init(&canvas->lock);
+	dev_set_drvdata(dev, canvas);
+
+	return 0;
+}
+
+static const struct of_device_id canvas_dt_match[] = {
+	{ .compatible = "amlogic,canvas" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, canvas_dt_match);
+
+static struct platform_driver meson_canvas_driver = {
+	.probe = meson_canvas_probe,
+	.driver = {
+		.name = "amlogic-canvas",
+		.of_match_table = canvas_dt_match,
+	},
+};
+module_platform_driver(meson_canvas_driver);
+
+MODULE_DESCRIPTION("Amlogic Canvas driver");
+MODULE_AUTHOR("Maxime Jourdan <mjourdan@baylibre.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/amlogic/meson-canvas.h b/include/linux/soc/amlogic/meson-canvas.h
new file mode 100644
index 000000000000..3dcfdabbef74
--- /dev/null
+++ b/include/linux/soc/amlogic/meson-canvas.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 BayLibre, SAS
+ */
+#ifndef __SOC_MESON_CANVAS_H
+#define __SOC_MESON_CANVAS_H
+
+#include <linux/kernel.h>
+
+#define MESON_CANVAS_WRAP_NONE	0x00
+#define MESON_CANVAS_WRAP_X	0x01
+#define MESON_CANVAS_WRAP_Y	0x02
+
+#define MESON_CANVAS_BLKMODE_LINEAR	0x00
+#define MESON_CANVAS_BLKMODE_32x32	0x01
+#define MESON_CANVAS_BLKMODE_64x64	0x02
+
+#define MESON_CANVAS_ENDIAN_SWAP16	0x1
+#define MESON_CANVAS_ENDIAN_SWAP32	0x3
+#define MESON_CANVAS_ENDIAN_SWAP64	0x7
+#define MESON_CANVAS_ENDIAN_SWAP128	0xf
+
+struct meson_canvas;
+
+/**
+ * meson_canvas_get() - get a canvas provider instance
+ *
+ * @dev: consumer device pointer
+ */
+struct meson_canvas *meson_canvas_get(struct device *dev);
+
+/**
+ * meson_canvas_alloc() - take ownership of a canvas
+ *
+ * @canvas: canvas provider instance retrieved from meson_canvas_get()
+ * @canvas_index: will be filled with the canvas ID
+ */
+int meson_canvas_alloc(struct meson_canvas *canvas, u8 *canvas_index);
+
+/**
+ * meson_canvas_free() - remove ownership from a canvas
+ *
+ * @canvas: canvas provider instance retrieved from meson_canvas_get()
+ * @canvas_index: canvas ID that was obtained via meson_canvas_alloc()
+ */
+int meson_canvas_free(struct meson_canvas *canvas, u8 canvas_index);
+
+/**
+ * meson_canvas_config() - configure a canvas
+ *
+ * @canvas: canvas provider instance retrieved from meson_canvas_get()
+ * @canvas_index: canvas ID that was obtained via meson_canvas_alloc()
+ * @addr: physical address to the pixel buffer
+ * @stride: width of the buffer
+ * @height: height of the buffer
+ * @wrap: undocumented
+ * @blkmode: block mode (linear, 32x32, 64x64)
+ * @endian: byte swapping (swap16, swap32, swap64, swap128)
+ */
+int meson_canvas_config(struct meson_canvas *canvas, u8 canvas_index,
+			u32 addr, u32 stride, u32 height,
+			unsigned int wrap, unsigned int blkmode,
+			unsigned int endian);
+
+#endif
-- 
2.18.0

