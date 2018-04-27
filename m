Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AB8JxZpyKYlPAnKut6jHPyrLM49wHW7m9Ep41OKa/tTuNc9QiEq1byx4q7VE7WAyublYbkjHYMnu
ARC-Seal: i=1; a=rsa-sha256; t=1524821075; cv=none;
        d=google.com; s=arc-20160816;
        b=g6wvxizJtfpPEe59jeMWjfCvOgLRxqys5e/f3JRPRT2oIPmiwzQmDuKg9SpOxkptAU
         LrvquV+aOmw8HAwyolKTzLiOydUqV+lv/MGfImqzS0Huzn7eHKZryWe/S70/PVnPOxZU
         tKHF5Xlg4uTonrCKt8VoCujrLcRFk89r8USJXv3wyY6xbbILpH9GfcRVN8XpehrAnEIw
         eprldzJza04+lJuJAPFcM6BRhJAzMQW/PoisvSBWsgwxVgD6jULbY/vxwA2QevgOifpy
         JuRu7ExMWl5sFvgrDrDr3SnZPs2bHI7nefvrTQyClTrlWpuyB8DUhczNC7khk5PfwxGL
         YYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=fK+g+24Y+OYL2r5Ex38iFFJ/iMyFOZaah6v6CF2I0mM=;
        b=pjKx+X8pqpykua8Y0SqoUZqbwvNl04ol/L+Ur3VUMu6j6X25oNfzj+1rzZFDiQ6tTU
         OC+JWqIqQxelUVL4IzQO3MN956bq3T9PMenwznnuE48P4UJ5U2YI6RzktgNobBZQOLXW
         z70ZP25SgjGcShVzOXKbUgiQdywX1dzwOKjbNpVFZshmOEBurVwi2Nv05jRcuYRbSOg8
         jsVpnokXpx6/nsZx4uRnWN1ni8U69L6YwIXg0ALBL6qVCchrIydhky9fKoYfswI2I2Kg
         gf1R/vXTRXJ51JKxuNn1RilI+JxAjmA213/PbhSgT6FIxG0kQapI/iu1QuqeIEzZ/X+V
         quGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853032187E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
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
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v3 03/10] mfd: mtk-mmsys: Add mmsys driver
Date: Fri, 27 Apr 2018 11:23:55 +0200
Message-Id: <e0894c97775e46ce6d9a441dc05e2e2479a4b612.1524820923.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
In-Reply-To: <cover.1524820923.git.mbrugger@suse.com>
References: <cover.1524820923.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890783825363754?=
X-GMAIL-MSGID: =?utf-8?q?1598890783825363754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

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
index b860eb5aa194..d23a3b9a2c58 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
 	help
 	  Select this if your MC13xxx is connected via an I2C bus.
 
+config MFD_MEDIATEK_MMSYS
+	tristate "Mediatek MMSYS interface"
+	select MFD_CORE
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
