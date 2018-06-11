Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9IDVCapiHluoVwAAmS7hNA
	; Mon, 11 Jun 2018 11:53:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2E02607E4; Mon, 11 Jun 2018 11:53:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4C1+ch"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2EDFF601C3;
	Mon, 11 Jun 2018 11:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EDFF601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbeFKLxa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44644 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933193AbeFKLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id 36-v6so30058756lfr.11;
        Mon, 11 Jun 2018 04:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3j8Fs15IS+dl+eVI+x+JnCjz8Ngw6xJEDChdEEgmsc=;
        b=Sa4C1+chrObCBlRMOXQYnUBhBNXe2j1d7+6MpXAYLygojmLwcN8bN639evfPFyXuAU
         bftu4WH+SXCiSI9c4ii3KExgPoQWa0JGihBOxGgVSG+VPcLuZa9LEeUmpGs7xd/7+ugH
         BOb4tQeIor47VezYOKZqBnD2GAY62wTKouKzJ4ZBdNy7pIgIhK2TgjE/lckwmbZJwKxO
         /gEscSI0/pFPYaatdeOSHkh2FtNw0a5itELp74lnHDeN3FhJHX/pSVVflUIK3sh2Uqjc
         tAEmTZjULZHGZZ41GjPVskyCXLFDV+Ik224Q6woEXDGFpbT1nJX+uqYw69EeWiZSY0cC
         1XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3j8Fs15IS+dl+eVI+x+JnCjz8Ngw6xJEDChdEEgmsc=;
        b=GSkU6LGvs4Q/aWsldyF/L6ALfYefzYkryFmL1z+aYcIz0CQCwBsQlUA3UWvlbFHC4F
         NvfIi5zemOK7VeY3JR7wUU/jKXYXL3acncuuzBTw75hSQrPowoP2REiEFoNZCR10YLdn
         yzDyFQLpr/4Vq0J22RNzpAGwhuMbUT9EA9BOMA986DKvWN1byxCd6LN9g/E6eBxzrUB9
         9lpU2E8q9cOgJyWGif6rtfMAjZktcpFq3yseecttAnVKCHxeVn204x+zT1/7XvCowaS0
         CkbjRIcVF0H2zbr0bGL3WC8CEqxf47WSAM6fX4ib6M+pogPe/NTQV3HYM6zX6DSsRWKE
         HznA==
X-Gm-Message-State: APt69E35d5aEsT2mwlrOGD8DkdSZ+tVcYyVbiAqzTZovITd82s00JseQ
        kAqbluJoTsu7sFJs95HrW9m9F1Fa
X-Google-Smtp-Source: ADUXVKK8UQBzp+GxyvgPS+uSvRmlK+fjhPNo3bgH4YtiJn93hBsb5L1Zda777dSZtPLoBEc+m+LdPg==
X-Received: by 2002:a2e:9890:: with SMTP id b16-v6mr11341876ljj.80.1528718005328;
        Mon, 11 Jun 2018 04:53:25 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:24 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 18/24] serdev: ttydev: Serdev driver that creates an standard TTY port
Date: Mon, 11 Jun 2018 13:52:34 +0200
Message-Id: <20180611115240.32606-19-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard TTY port that can be loaded/unloaded via serdev sysfs. This
serdev driver can only be used by serdev controllers that are compatible
with ttyport.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/Kconfig         | 10 +++++
 drivers/tty/serdev/Makefile        |  2 +
 drivers/tty/serdev/serdev-ttydev.c | 60 ++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 drivers/tty/serdev/serdev-ttydev.c

diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index 1dbc8352e027..848692caabd6 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -21,4 +21,14 @@ config SERIAL_DEV_CTRL_TTYPORT
 	depends on SERIAL_DEV_BUS != m
 	default y
 
+config SERIAL_DEV_CTRL_TTYDEV
+	tristate "TTY port dynamically loaded by the Serial Device Bus"
+	help
+	  Say Y here if you want to create a bridge driver between the Serial
+	  device bus and the TTY chardevice. This driver can be dynamically
+	  loaded/unloaded by the Serial Device Bus.
+
+	  If unsure, say N.
+	depends on SERIAL_DEV_CTRL_TTYPORT
+
 endif
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 0cbdb9444d9d..5c807b77d12d 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -3,3 +3,5 @@ serdev-objs := core.o
 obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
 
 obj-$(CONFIG_SERIAL_DEV_CTRL_TTYPORT) += serdev-ttyport.o
+
+obj-$(CONFIG_SERIAL_DEV_CTRL_TTYDEV) += serdev-ttydev.o
diff --git a/drivers/tty/serdev/serdev-ttydev.c b/drivers/tty/serdev/serdev-ttydev.c
new file mode 100644
index 000000000000..180035e101dc
--- /dev/null
+++ b/drivers/tty/serdev/serdev-ttydev.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Ricardo Ribalda <ricardo.ribalda@gmail.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/serdev.h>
+#include <linux/tty.h>
+#include "serport.h"
+
+static int ttydev_serdev_probe(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+	struct serport *serport;
+	struct device *dev;
+
+	if (!ctrl->is_ttyport)
+		return -ENODEV;
+
+	serport = serdev_controller_get_drvdata(ctrl);
+
+	dev = tty_register_device_attr(serport->tty_drv, serport->tty_idx,
+					&serdev->dev, NULL, NULL);
+
+	return dev ? 0 : PTR_ERR(dev);
+}
+
+static void ttydev_serdev_remove(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+	struct serport *serport;
+
+	serport = serdev_controller_get_drvdata(ctrl);
+	tty_unregister_device(serport->tty_drv, serport->tty_idx);
+}
+
+static const struct serdev_device_id ttydev_serdev_id[] = {
+	{ "ttydev", },
+	{ "ttydev_serdev", },
+	{}
+};
+MODULE_DEVICE_TABLE(serdev, ttydev_serdev_id);
+
+static struct serdev_device_driver ttydev_serdev_driver = {
+	.probe = ttydev_serdev_probe,
+	.remove = ttydev_serdev_remove,
+	.driver = {
+		.name = "ttydev_serdev",
+	},
+	.id_table = ttydev_serdev_id,
+};
+
+module_serdev_device_driver(ttydev_serdev_driver);
+
+MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Serdev to ttydev module");
-- 
2.17.1
