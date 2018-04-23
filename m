Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx4+AAVy7VsBCfylMC1k6RL+mSAY8B3omPkku1deRQR0kdaRcqI9Ijj6UCxGI8CByi4DowTZ+
ARC-Seal: i=1; a=rsa-sha256; t=1524497547; cv=none;
        d=google.com; s=arc-20160816;
        b=reqpP4K5rgM2M93AJB2l2Ziu9NgVt3MxYr/ha2UTDcOEwf8A/8qs5qGvvseTI2ba6G
         iSehrXCvR96qtyFoS19Hsct3Zh6/GYv3MnKE07Ng1S4JW/qRHmQGoW2iFl4AjH86wwjq
         Ozg19gPye6q5y7MPhTpBUnVO+nRJP6RBiPwt5+nz3dLQJzLrxv+CPYDxZfXZviBgIKLu
         tz7y2d5tQR9NOBLKayWpA8TXDZJKxF0QdaQoT0JIJ2mQ+Ww0svSegq43BY2zEKIIB5oO
         fNlhqtkKn9zTIsfP40cAKyV+TuhDhvTXtQD9J2ru+n7nJE1ZXR86MePUL0kQqMsLx5Fo
         1b7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sCRT9PzTf8/RpmOxlgPRla0esEfjLXhxY2Xqe6BNoxo=;
        b=NHJZLwXsleKG57BG+3hIJ3Pgcij9LcY5q3fiqOK2niR8sg9ftWjuIpwJjT6uNv7PSM
         kLdBMNkun+w2AOzE/iAnbMZT4OlLcFBAnYCTsrRTIIT8LwbriT8CPXLa0ksSu9Bcuetk
         nLoSyRVTCeUARaM2vGqYo4boOtoybLU5MQ0QrqnGXcO3oIhF6L1kVoPKieMl8OiwGyif
         8ByhwiL6dMaM1a/0bowVAvfY+/SyUwSl0wG9RJHAKDD9ZppsBPQY8mrxUnyaRSFlzOw9
         6L4fA3pMUQuSFsNFkhmwpAOGrMBFQY8Sx2Gzs2ZmUbD5aZzdjzdCXZJJw73klCAy9ADw
         Gv4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 03/10] mfd: mtk-mmsys: Add mmsys driver
Date: Mon, 23 Apr 2018 17:32:02 +0200
Message-Id: <99bef17c57ad60eff6104da780cf59b785bd3e42.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551539951377113?=
X-GMAIL-MSGID: =?utf-8?q?1598551539951377113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The MMSYS subsystem includes clocks and drm components.
This patch adds a MFD device to probe both drivers from the same
device tree compatible.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/mfd/Kconfig     |  9 ++++++
 drivers/mfd/Makefile    |  2 ++
 drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/mfd/mtk-mmsys.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..a2c928e26026 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MEDIATEK_MMSYS
+	tristate "Mediatek MMSYS interface"
+	select MDF_CORE
+	select REGMAP_MMIO
+	help
+	  Select this if you have a MMSYS subsystem in your SoC. The
+	  MMSYS subsystem has at least a clock driver part and some
+	  DRM components.
+
 config MFD_MXS_LRADC
 	tristate "Freescale i.MX23/i.MX28 LRADC"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9d2cf0d32ef..b96118bd68d9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -98,6 +98,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
+obj-$(CONFIG_MFD_MEDIATEK_MMSYS) += mtk-mmsys.o
+
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
diff --git a/drivers/mfd/mtk-mmsys.c b/drivers/mfd/mtk-mmsys.c
new file mode 100644
index 000000000000..c802343fb1c6
--- /dev/null
+++ b/drivers/mfd/mtk-mmsys.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * mtk-mmsys.c -- Mediatek MMSYS multi-function driver
+ *
+ * Copyright (c) 2018 Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * Author: Matthias Brugger <matthias.bgg@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mfd/core.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+enum {
+	MMSYS_MT2701 = 1,
+};
+
+static const struct mfd_cell mmsys_mt2701_devs[] = {
+	{ .name = "clk-mt2701-mm", },
+	{ .name = "drm-mt2701-mm", },
+};
+
+static int mmsys_probe(struct platform_device *pdev)
+{
+	const struct mfd_cell *mmsys_cells;
+	int nr_cells;
+	long id;
+	int ret;
+
+	id = (long) of_device_get_match_data(&pdev->dev);
+	if (!id) {
+		dev_err(&pdev->dev, "of_device_get match_data() failed\n");
+		return -EINVAL;
+	}
+
+	switch (id) {
+	case MMSYS_MT2701:
+		mmsys_cells = mmsys_mt2701_devs;
+		nr_cells = ARRAY_SIZE(mmsys_mt2701_devs);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = devm_mfd_add_devices(&pdev->dev, 0, mmsys_cells, nr_cells,
+					NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+};
+
+static const struct of_device_id of_match_mmsys[] = {
+	{ .compatible = "mediatek,mt2701-mmsys",
+	  .data = (void *) MMSYS_MT2701,
+	},
+	{ /* sentinel */ },
+};
+
+static struct platform_driver mmsys_drv = {
+	.probe = mmsys_probe,
+	.driver = {
+		.name = "mediatek-mmysys",
+		.of_match_table = of_match_ptr(of_match_mmsys),
+	},
+};
+
+builtin_platform_driver(mmsys_drv);
+
+MODULE_DESCRIPTION("Mediatek MMSYS multi-function driver");
+MODULE_LICENSE("GPL");
-- 
2.16.3
