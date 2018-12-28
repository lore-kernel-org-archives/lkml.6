Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7057EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C4A20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aFwiDCyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeL1Kvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:51:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40215 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbeL1Kv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:51:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so17229862edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pN+0H3y7M98gFOz3pfkSQa2FcPvqO1nl4jQ3jTi1QzQ=;
        b=aFwiDCySvFSvTZrm8Ir/JlvumNXzF/UxvhR/BFapRrZXBaldRpztzlW9s0R8SkXb21
         HgwATwjxkaZG5/qQRA3ppFge4e8M26J6ECXYoYijcYGQxwQaCjVNmsDSxffRGruVBHg1
         pxA/MVX6cQPIGw0HSgnbyrbL+sAvzjdCmKITuvEOjtpbZhviZ2lRAV+cvZdzaeR4vm+2
         NIDRyykqdK+rTfLiPzb/8hXgLPTXottM0XllCmpGrwUBMsOtj0mV7qOsGfvOp73WiZ/0
         VMHgl5Wcqsy9Y+B3LLW06NUJqIYFd1Lc7XkTRLc9BHUaWp6Ph5NrwPK8UhdR9PfPtajt
         k+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pN+0H3y7M98gFOz3pfkSQa2FcPvqO1nl4jQ3jTi1QzQ=;
        b=HwzBQbXySmp4UH2V70qtarOsUkdX0m2l6/Dp9FXNutQIFCwkogjLW5EPMKJHgeL39q
         6SMwHT0eZJmv4oVjfl5bucAqnymTNGjvDPQRFdUvVCxO3F2/TzBiegKRXoVrgg7texV0
         ZZMizk+D7UF14GmgcEsWLrwH1HQd7CWPWHqURvdLqJ/OqpaJqPMjFbRfFB/fmXqntq+0
         HRIrGz5cy2eMkF/iWyRVAS8hSygaP3Jqq1p677iwCsTNNeXHQyGUkiMUddP9nikKBZ3P
         hpnJ186y5z9CPxtXtm8Fb3jdq5J9sT2Tjggr6T3RIpKDMkdJKqYN/GZ2ANY410TjXWo6
         nl/A==
X-Gm-Message-State: AA+aEWZflD7aI4AoQ/JTp0U9a8hrrq4khFk/7m/e2xuNEqEP+nU7bMgV
        898kZzHoMjUPO09aGdXHgKSQqw==
X-Google-Smtp-Source: AFSGD/WjvTnSh/NAGr8ZC5gwuY2lQUjlJrvrB15WUgGdHqZ/hiMx46btTXX2yJGIxKdqCY0Ac0YYIQ==
X-Received: by 2002:a17:906:914:: with SMTP id i20-v6mr18483859ejd.225.1545994287118;
        Fri, 28 Dec 2018 02:51:27 -0800 (PST)
Received: from loys-ubuntu-BY1835A49200471.home (anice-157-1-157-17.w83-201.abo.wanadoo.fr. [83.201.132.17])
        by smtp.googlemail.com with ESMTPSA id b45sm12919494eda.34.2018.12.28.02.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Dec 2018 02:51:26 -0800 (PST)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 4/4] gnss: add driver for globaltop receivers
Date:   Fri, 28 Dec 2018 11:50:35 +0100
Message-Id: <1545994235-8309-5-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for serial-connected GlobalTop GNSS receivers.

These devices typically boot transmitting vendor specific NMEA output
sequences. The serial port bit rate is read from the device tree
"current-speed".

Note that the driver uses the generic GNSS serial implementation and
therefore essentially only manages power abstracted into three power
states: ACTIVE, STANDBY, and OFF.

For globaltop receivers with a main supply and no enable-gpios, this simply
means that the main supply is disabled in STANDBY and OFF (the optional
backup supply is kept enabled while the driver is bound).

Note that the timepulse-support is left unimplemented.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
 drivers/gnss/Kconfig  |  13 +++++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/core.c   |   1 +
 drivers/gnss/gtop.c   | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 drivers/gnss/gtop.c

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 6abc88514512..c93ad134656b 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -40,4 +40,17 @@ config GNSS_UBX_SERIAL
 
 	  If unsure, say N.
 
+config GNSS_GTOP_SERIAL
+	tristate "GlobalTop GNSS receiver support"
+	depends on SERIAL_DEV_BUS
+	select GNSS_SERIAL
+	help
+	  Say Y here if you have a GlobalTop GNSS receiver which uses a serial
+	  interface.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gnss-gtop.
+
+	  If unsure, say N.
+
 endif # GNSS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 5cf0ebe0330a..becc45f24b8b 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -14,3 +14,6 @@ gnss-sirf-y := sirf.o
 
 obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
 gnss-ubx-y := ubx.o
+
+obj-$(CONFIG_GNSS_GTOP_SERIAL)		+= gnss-gtop.o
+gnss-gtop-y := gtop.o
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 4291a0dd22aa..0b5cd82b1fb7 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_NMEA]	= "NMEA",
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
+	[GNSS_TYPE_GTOP]	= "GTOP",
 };
 
 static const char *gnss_type_name(struct gnss_device *gdev)
diff --git a/drivers/gnss/gtop.c b/drivers/gnss/gtop.c
new file mode 100644
index 000000000000..6fa7b425d711
--- /dev/null
+++ b/drivers/gnss/gtop.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GlobalTop GNSS receiver driver
+ *
+ * Copyright (C) 2018 Loys Ollivier <loys.ollivier@gmail.com>
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
+struct gtop_data {
+	struct regulator *v_bckp;
+	struct regulator *vcc;
+};
+
+static int gtop_set_active(struct gnss_serial *gserial)
+{
+	struct gtop_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_enable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int gtop_set_standby(struct gnss_serial *gserial)
+{
+	struct gtop_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_disable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int gtop_set_power(struct gnss_serial *gserial,
+				enum gnss_serial_pm_state state)
+{
+	switch (state) {
+	case GNSS_SERIAL_ACTIVE:
+		return gtop_set_active(gserial);
+	case GNSS_SERIAL_OFF:
+	case GNSS_SERIAL_STANDBY:
+		return gtop_set_standby(gserial);
+	}
+
+	return -EINVAL;
+}
+
+static const struct gnss_serial_ops gtop_gserial_ops = {
+	.set_power = gtop_set_power,
+};
+
+static int gtop_probe(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial;
+	struct gtop_data *data;
+	int ret;
+
+	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	if (IS_ERR(gserial)) {
+		ret = PTR_ERR(gserial);
+		return ret;
+	}
+
+	gserial->ops = &gtop_gserial_ops;
+
+	gserial->gdev->type = GNSS_TYPE_GTOP;
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
+static void gtop_remove(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
+	struct gtop_data *data = gnss_serial_get_drvdata(gserial);
+
+	gnss_serial_deregister(gserial);
+	if (data->v_bckp)
+		regulator_disable(data->v_bckp);
+	gnss_serial_free(gserial);
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id gtop_of_match[] = {
+	{ .compatible = "globaltop,pa6h" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gtop_of_match);
+#endif
+
+static struct serdev_device_driver gtop_driver = {
+	.driver	= {
+		.name		= "gnss-gtop",
+		.of_match_table	= of_match_ptr(gtop_of_match),
+		.pm		= &gnss_serial_pm_ops,
+	},
+	.probe	= gtop_probe,
+	.remove	= gtop_remove,
+};
+module_serdev_device_driver(gtop_driver);
+
+MODULE_AUTHOR("Loys Ollivier <loys.ollivier@gmail.com>");
+MODULE_DESCRIPTION("GlobalTop GNSS receiver driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

