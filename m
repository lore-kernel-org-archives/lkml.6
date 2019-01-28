Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DE2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2220811
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jCkIK7qO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390563AbfA1QiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:38:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41798 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390562AbfA1QiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:38:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so18766081wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J7q2ZjQCinm0IA/wotZbsDzW17KZqQK/HytBY9aOmww=;
        b=jCkIK7qOU+oQ1Qf34xBNH44bu15/Eyc78HQubpYXfrNqRhzbGg3DLSspO5WFomgfxQ
         ci7q5n3OMQVcMVv4ouYs3jdw8Bl9a29EfuewI2VUXE+o99WXguBy4COns+R1Jy4pUuPO
         GCAKPLG+EJpDA1hrhDo2vLPv1oWl4fhuwHBI2/qksQuGYUkCa+Z+Fi3Ng1ipN4fh9PPU
         NLIrrFaHrfT0pVMt/FfGAd8c2ldttUAuWPUMA6fYtinkc2rI9D0uSos4KvDod3NPbZIR
         KNNYoff6rjsNQWcGRMxK5grcIt2BEhRZ9c4Q8P+6l6g91fcANuGpSC9G7rDhAd6fFCGb
         IEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J7q2ZjQCinm0IA/wotZbsDzW17KZqQK/HytBY9aOmww=;
        b=V1D/CRzjO5XP/UFsGQCx+WaqOJheRIQhE86Uqh6KiItbB1F1TkgdpgJJ2ElWOSEY0a
         Sp6eER+Ny5cPL3JCXIXF3Rb1ifkLGK/UCfQJ0ZbTER5gPPo9KQKBZi3rMkzofoCnYYo0
         JsDho90u6LdWvm95Ag0zO4+blco5HWgPLn90cX4rKqrUk5OFnA7pIbzAcKMJtTwZdPxP
         H5qFcgqdKV1+NabgYIlciyUl5lBzK8tKBkIl17kakrO8sB081RD8ipraGzEFgNK7M2QK
         fFYFa0xpOYnebBxRecpjm9mlEGVFrm8LXq3us7zPvfj8hLjJO3p82zkVQ8MSPX620rAP
         kngw==
X-Gm-Message-State: AJcUukdkrgSpZ+xVS0l2aV8rTZzV2PBajEmRG1YzVbQr0Fqd15pECu55
        QZu23E+6yzjHWfsGS3dERs4HpQ==
X-Google-Smtp-Source: ALg8bN7blyEvsvwmNr8fUFPB28n210TFW2WoUsaWbisBlgkZPfBc9rYG0fS4DpIKo7pWK/NFlt6Kfw==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr21558974wrd.20.1548693490439;
        Mon, 28 Jan 2019 08:38:10 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:d40b])
        by smtp.googlemail.com with ESMTPSA id s3sm52388982wmj.23.2019.01.28.08.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 08:38:09 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 4/4] gnss: add driver for mediatek receivers
Date:   Mon, 28 Jan 2019 17:38:01 +0100
Message-Id: <1548693481-1162-5-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for serial-connected Mediatek-based GNSS receivers.

These devices typically boot transmitting vendor specific NMEA output
sequences. The serial port bit rate is read from the device tree
"current-speed".

Note that the driver uses the generic GNSS serial implementation and
therefore essentially only manages power abstracted into three power
states: ACTIVE, STANDBY, and OFF.

For mediatek receivers with a main supply and no enable-gpios, this simply
means that the main supply is disabled in STANDBY and OFF (the optional
backup supply is kept enabled while the driver is bound).

Note that the timepulse-support is left unimplemented.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---

v3:
Sorted the Kconfig and Makefile
Retained the original Copyright
Removed "mediatek,mt3339" compatible.

v2: 
Renamed from gtop/Globaltop to mtk/Mediatek.
Added "mediatek,mt3339" compatible.

 drivers/gnss/Kconfig  |  13 +++++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/mtk.c    | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/gnss/mtk.c

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 6abc88514512..6d8c8027e1cd 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -15,6 +15,19 @@ if GNSS
 config GNSS_SERIAL
 	tristate
 
+config GNSS_MTK_SERIAL
+	tristate "Mediatek GNSS receiver support"
+	depends on SERIAL_DEV_BUS
+	select GNSS_SERIAL
+	help
+	  Say Y here if you have a Mediatek-based GNSS receiver which uses a
+	  serial interface.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gnss-mtk.
+
+	  If unsure, say N.
+
 config GNSS_SIRF_SERIAL
 	tristate "SiRFstar GNSS receiver support"
 	depends on SERIAL_DEV_BUS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 5cf0ebe0330a..451f11401ecc 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -9,6 +9,9 @@ gnss-y := core.o
 obj-$(CONFIG_GNSS_SERIAL)		+= gnss-serial.o
 gnss-serial-y := serial.o
 
+obj-$(CONFIG_GNSS_MTK_SERIAL)		+= gnss-mtk.o
+gnss-mtk-y := mtk.o
+
 obj-$(CONFIG_GNSS_SIRF_SERIAL)		+= gnss-sirf.o
 gnss-sirf-y := sirf.o
 
diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
new file mode 100644
index 000000000000..a5aad08fb9d7
--- /dev/null
+++ b/drivers/gnss/mtk.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek GNSS receiver driver
+ *
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/gnss.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+
+#include "serial.h"
+
+struct mtk_data {
+	struct regulator *v_bckp;
+	struct regulator *vcc;
+};
+
+static int mtk_set_active(struct gnss_serial *gserial)
+{
+	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_enable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mtk_set_standby(struct gnss_serial *gserial)
+{
+	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_disable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mtk_set_power(struct gnss_serial *gserial,
+			 enum gnss_serial_pm_state state)
+{
+	switch (state) {
+	case GNSS_SERIAL_ACTIVE:
+		return mtk_set_active(gserial);
+	case GNSS_SERIAL_OFF:
+	case GNSS_SERIAL_STANDBY:
+		return mtk_set_standby(gserial);
+	}
+
+	return -EINVAL;
+}
+
+static const struct gnss_serial_ops mtk_gserial_ops = {
+	.set_power = mtk_set_power,
+};
+
+static int mtk_probe(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial;
+	struct mtk_data *data;
+	int ret;
+
+	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	if (IS_ERR(gserial)) {
+		ret = PTR_ERR(gserial);
+		return ret;
+	}
+
+	gserial->ops = &mtk_gserial_ops;
+
+	gserial->gdev->type = GNSS_TYPE_MTK;
+
+	data = gnss_serial_get_drvdata(gserial);
+
+	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
+	if (IS_ERR(data->vcc)) {
+		ret = PTR_ERR(data->vcc);
+		goto err_free_gserial;
+	}
+
+	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
+	if (IS_ERR(data->v_bckp)) {
+		ret = PTR_ERR(data->v_bckp);
+		if (ret == -ENODEV)
+			data->v_bckp = NULL;
+		else
+			goto err_free_gserial;
+	}
+
+	if (data->v_bckp) {
+		ret = regulator_enable(data->v_bckp);
+		if (ret)
+			goto err_free_gserial;
+	}
+
+	ret = gnss_serial_register(gserial);
+	if (ret)
+		goto err_disable_v_bckp;
+
+	return 0;
+
+err_disable_v_bckp:
+	if (data->v_bckp)
+		regulator_disable(data->v_bckp);
+err_free_gserial:
+	gnss_serial_free(gserial);
+
+	return ret;
+}
+
+static void mtk_remove(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
+	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
+
+	gnss_serial_deregister(gserial);
+	if (data->v_bckp)
+		regulator_disable(data->v_bckp);
+	gnss_serial_free(gserial);
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id mtk_of_match[] = {
+	{ .compatible = "globaltop,pa6h" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_of_match);
+#endif
+
+static struct serdev_device_driver mtk_driver = {
+	.driver	= {
+		.name		= "gnss-mtk",
+		.of_match_table	= of_match_ptr(mtk_of_match),
+		.pm		= &gnss_serial_pm_ops,
+	},
+	.probe	= mtk_probe,
+	.remove	= mtk_remove,
+};
+module_serdev_device_driver(mtk_driver);
+
+MODULE_AUTHOR("Loys Ollivier <lollivier@baylibre.com>");
+MODULE_DESCRIPTION("Mediatek GNSS receiver driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

