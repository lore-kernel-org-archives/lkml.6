Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx49I1nKPR23pFMC6sO5W4TI5h1/5Bo/coO5sLY9pITnurEO1Av3XBnFKQsmi+8NefIG/qr4g
ARC-Seal: i=1; a=rsa-sha256; t=1524563257; cv=none;
        d=google.com; s=arc-20160816;
        b=C++D2a2m42ovKj1Qku7Uk/hhw1bXr5uRMLcslC1ZKmp5s4Or3rUL0vVyVeT3mpZc8T
         ck8xXY/KgcjHowEBdJ65EOp4ixZEbyPNlaqQwIe0jcGkWwwR0XHu9aNJkbNJvd3G4Hov
         eUanrax2vF4VVbTvEPAVIXB39tweZMCw8AHF0zeBGaegD5OFdXmCWcjeb2xTxssU85Fz
         TIg3N84DSwWP25Tc5i1fhYlJ+82+zkFIbXXK2pnxtRQ1DIcemlaAQHim/RBene5Jriqc
         9Q0qOcg/PXFIeaSl8kZMc8boX8wMcVjVlgbJnTq8nbAedrxLagM726ipwXSdCoIuEx5/
         X0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qW4HDFfmXx6IK2sYRpxIrGa7sf+sp0zwgEHKHX5GmGw=;
        b=oRixiHh7QiNVMnNqCAK6liUkFwsVkIbCQDH2dpccsrI5not+g3hi3975X3zjYLqpLD
         sV7ER8xJndep8/VX+FI970TauR8x5J7tJxRu+ynrU5SLpEEtiNWrSmbtjOYfIX8DJq4s
         xDQN0fuyuLq3tRk2deIPvYBk5Q54AB2x8C4eUMWFiiFV1mf9AMV8ilAfYPfr3F9iUDRW
         JBUwMjTuAVP2h/JhaLG8lsD2vgQZmYy87W0CGXvL/XyB8GOe5xVM/8imwkSlWKyfbT9f
         TxJ7qVFplmIieKkH10LltjQOYRr05YDy9MqlNGvxrl4Na7zhJxkf+x2JgmhltInKuybL
         2m+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FFC21835
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
Subject: [v2 resend 03/10] mfd: mtk-mmsys: Add mmsys driver
Date: Tue, 24 Apr 2018 11:47:00 +0200
Message-Id: <99bef17c57ad60eff6104da780cf59b785bd3e42.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620441795227441?=
X-GMAIL-MSGID: =?utf-8?q?1598620441795227441?=
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
