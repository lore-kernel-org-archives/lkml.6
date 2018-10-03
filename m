Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B5EC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A13213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbBgO0si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A13213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeJDAHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:35 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48200 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:34 -0400
Received: by mail-pf1-f202.google.com with SMTP id x19-v6so3588813pfh.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CzIcR+qrEEkOtxnuHuiV59VWlstYidEBVqolHP3kHNw=;
        b=pbBgO0siEYggv7syUM0uA4TItkcGQ84DJPlyUIsJBVBBLqonAaz2pnKOnkAJfDfrv+
         imXNtwuyLCuR0aOblj0tHvWPyNISJ+29drnSg1BfMM6bnE+AgD/LPTJQyhWbvON1S0DG
         WFbteQqDByLUww9VkDl3vXlS33Vs7PO25n1SVNqFuxQKrka0vwnAD+OA8ePPlUQJZf69
         rqJcP5EpyIgu8Cxj2tDs9MoYt1IIWIECba94raQXq9NQC50SeBPjsd0jpopT6x+055Si
         nQ5UONqY2ao4rBrVXEnpLFFEbOeX1S7s18DJMbQpo/RWGy6MQXnzpGzdd/d7ZJJM3jKj
         UhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CzIcR+qrEEkOtxnuHuiV59VWlstYidEBVqolHP3kHNw=;
        b=EoevQt3nptUdAXKdCHK15JN4eEXLM/ODQ0IwF2zUZSwdidrZPZT6W3dH28Z7Sr3jlo
         tePMYoIbld8H92lmJycQ+Sn8nnYspY9ygXPiqLsBBSdRjzvUrykle+WEl2NG6PLmfj47
         uExZYD4G5m1YhkKbu7i84K7E4kiluFtVM03KE3qHz5tDkgcLu4Uke+GJBYpm2kKZCROp
         977YtfSoawmxu+bpUlYIVmuDbVfzuRU6s+5NLoDCV6XNkHzcCvKZfMjYNm1XOf+qEM5i
         reC6gsKTiEWUjha1l3fkFR0iJHfZVcJMmLvOF9wppSUipbpYu70kzJUGTUTUTB0O1gmR
         K5Vg==
X-Gm-Message-State: ABuFfogs8zpWTjyor3FhsjKhecozmpdWBJgFEhY8T4leIvdDDPI9tpxW
        FAVtuY6Mxf6NbO0RFr0oa7n9Mc5T
X-Google-Smtp-Source: ACcGV62a+FOLwm/1GPH1aT+IOqCfGiRN6lQqfqCBWrmZBMCaxVzmdBXUNAEtj2Jzy/jkvhyvQkn0GMMK
X-Received: by 2002:a63:2941:: with SMTP id p62-v6mr959976pgp.23.1538587096234;
 Wed, 03 Oct 2018 10:18:16 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:16 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-11-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 11/15] platform: goldfish: pipe: Split the driver to v2
 specific and the rest
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Move probe/remove and other driver stuff to a separate file
to plug v1 there later.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/Makefile           |   3 +-
 drivers/platform/goldfish/goldfish_pipe.c    | 124 +++++++++++++++++++
 drivers/platform/goldfish/goldfish_pipe.h    |  10 ++
 drivers/platform/goldfish/goldfish_pipe_v2.c | 112 +++--------------
 drivers/platform/goldfish/goldfish_pipe_v2.h |  10 ++
 5 files changed, 161 insertions(+), 98 deletions(-)
 create mode 100644 drivers/platform/goldfish/goldfish_pipe.c
 create mode 100644 drivers/platform/goldfish/goldfish_pipe.h
 create mode 100644 drivers/platform/goldfish/goldfish_pipe_v2.h

diff --git a/drivers/platform/goldfish/Makefile b/drivers/platform/goldfish/Makefile
index 81f899a987a2..016769e003d8 100644
--- a/drivers/platform/goldfish/Makefile
+++ b/drivers/platform/goldfish/Makefile
@@ -1,4 +1,5 @@
 #
 # Makefile for Goldfish platform specific drivers
 #
-obj-$(CONFIG_GOLDFISH_PIPE)	+= goldfish_pipe_v2.o
+obj-$(CONFIG_GOLDFISH_PIPE)    += goldfish_pipe_all.o
+goldfish_pipe_all-objs := goldfish_pipe.o goldfish_pipe_v2.o
diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
new file mode 100644
index 000000000000..792b20bdf76c
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* This source file contains the implementation of a special device driver
+ * that intends to provide a *very* fast communication channel between the
+ * guest system and the QEMU emulator.
+ *
+ * Usage from the guest is simply the following (error handling simplified):
+ *
+ *    int  fd = open("/dev/qemu_pipe",O_RDWR);
+ *    .... write() or read() through the pipe.
+ *
+ * This driver doesn't deal with the exact protocol used during the session.
+ * It is intended to be as simple as something like:
+ *
+ *    // do this _just_ after opening the fd to connect to a specific
+ *    // emulator service.
+ *    const char*  msg = "<pipename>";
+ *    if (write(fd, msg, strlen(msg)+1) < 0) {
+ *       ... could not connect to <pipename> service
+ *       close(fd);
+ *    }
+ *
+ *    // after this, simply read() and write() to communicate with the
+ *    // service. Exact protocol details left as an exercise to the reader.
+ *
+ * This driver is very fast because it doesn't copy any data through
+ * intermediate buffers, since the emulator is capable of translating
+ * guest user addresses into host ones.
+ *
+ * Note that we must however ensure that each user page involved in the
+ * exchange is properly mapped during a transfer.
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/acpi.h>
+#include "goldfish_pipe_qemu.h"
+#include "goldfish_pipe.h"
+#include "goldfish_pipe_v2.h"
+
+/*
+ * Update this when something changes in the driver's behavior so the host
+ * can benefit from knowing it
+ */
+enum {
+	PIPE_DRIVER_VERSION = 2,
+	PIPE_CURRENT_DEVICE_VERSION = 2
+};
+
+static int goldfish_pipe_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	char __iomem *base;
+	int irq;
+	int version;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r || resource_size(r) < PAGE_SIZE) {
+		dev_err(&pdev->dev, "can't allocate i/o page\n");
+		return -EINVAL;
+	}
+	base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+	if (!base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		return -EINVAL;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!r)
+		return -EINVAL;
+
+	irq = r->start;
+
+	/*
+	 * Exchange the versions with the host device
+	 *
+	 * Note: v1 driver used to not report its version, so we write it before
+	 *  reading device version back: this allows the host implementation to
+	 *  detect the old driver (if there was no version write before read).
+	 */
+	writel(PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
+	version = readl(base + PIPE_REG_VERSION);
+
+	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
+		return -EINVAL;
+
+	return goldfish_pipe_device_init(pdev, base, irq);
+}
+
+static int goldfish_pipe_remove(struct platform_device *pdev)
+{
+	struct goldfish_pipe_dev_base *dev = platform_get_drvdata(pdev);
+
+	return dev->deinit(dev, pdev);
+}
+
+static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
+	{ "GFSH0003", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
+
+static const struct of_device_id goldfish_pipe_of_match[] = {
+	{ .compatible = "google,android-pipe", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, goldfish_pipe_of_match);
+
+static struct platform_driver goldfish_pipe_driver = {
+	.probe = goldfish_pipe_probe,
+	.remove = goldfish_pipe_remove,
+	.driver = {
+		.name = "goldfish_pipe",
+		.of_match_table = goldfish_pipe_of_match,
+		.acpi_match_table = ACPI_PTR(goldfish_pipe_acpi_match),
+	}
+};
+
+module_platform_driver(goldfish_pipe_driver);
+MODULE_AUTHOR("David Turner <digit@google.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/goldfish/goldfish_pipe.h b/drivers/platform/goldfish/goldfish_pipe.h
new file mode 100644
index 000000000000..ee0b54bcb165
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_pipe.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef GOLDFISH_PIPE_H
+#define GOLDFISH_PIPE_H
+
+struct goldfish_pipe_dev_base {
+	/* the destructor, the pointer is set in init */
+	int (*deinit)(void *pipe_dev, struct platform_device *pdev);
+};
+
+#endif /* GOLDFISH_PIPE_H */
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index ff5d88e7959a..641dfdcc3ffd 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -30,8 +30,6 @@
  * exchange is properly mapped during a transfer.
  */
 
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
@@ -44,18 +42,9 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
-#include <linux/acpi.h>
 #include <linux/bug.h>
 #include "goldfish_pipe_qemu.h"
-
-/*
- * Update this when something changes in the driver's behavior so the host
- * can benefit from knowing it
- */
-enum {
-	PIPE_DRIVER_VERSION = 2,
-	PIPE_CURRENT_DEVICE_VERSION = 2
-};
+#include "goldfish_pipe.h"
 
 enum {
 	MAX_BUFFERS_PER_COMMAND = 336,
@@ -65,6 +54,9 @@ enum {
 
 struct goldfish_pipe_dev;
 
+static int goldfish_pipe_device_deinit(void *raw_dev,
+				       struct platform_device *pdev);
+
 /* A per-pipe command structure, shared with the host */
 struct goldfish_pipe_command {
 	s32 cmd;	/* PipeCmdCode, guest -> host */
@@ -152,8 +144,8 @@ struct goldfish_pipe {
  * waiting to be awoken.
  */
 struct goldfish_pipe_dev {
-	/* A magic number to check if this is an instance of this struct */
-	void *magic;
+	/* Needed for 'remove' */
+	struct goldfish_pipe_dev_base super;
 
 	/*
 	 * Global device spinlock. Protects the following members:
@@ -593,9 +585,6 @@ static void goldfish_interrupt_task(unsigned long dev_addr)
 	}
 }
 
-static void goldfish_pipe_device_deinit(struct platform_device *pdev,
-					struct goldfish_pipe_dev *dev);
-
 /*
  * The general idea of the interrupt handling:
  *
@@ -616,7 +605,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	struct goldfish_pipe_dev *dev = dev_id;
 
-	if (dev->magic != &goldfish_pipe_device_deinit)
+	if (dev->super.deinit != &goldfish_pipe_device_deinit)
 		return IRQ_NONE;
 
 	/* Request the signalled pipes from the device */
@@ -798,9 +787,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 	writel(lower_32_bits(paddr), portl);
 }
 
-static int goldfish_pipe_device_init(struct platform_device *pdev,
-				     char __iomem *base,
-				     int irq)
+int goldfish_pipe_device_init(struct platform_device *pdev,
+			      char __iomem *base,
+			      int irq)
 {
 	struct goldfish_pipe_dev *dev;
 	int err;
@@ -809,7 +798,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	if (!dev)
 		return -ENOMEM;
 
-	dev->magic = &goldfish_pipe_device_deinit;
+	dev->super.deinit = &goldfish_pipe_device_deinit;
 	spin_lock_init(&dev->lock);
 
 	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
@@ -872,9 +861,11 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	return 0;
 }
 
-static int goldfish_pipe_device_deinit(struct platform_device *pdev,
-				       struct goldfish_pipe_dev *dev)
+static int goldfish_pipe_device_deinit(void *raw_dev,
+				       struct platform_device *pdev)
 {
+	struct goldfish_pipe_dev *dev = raw_dev;
+
 	misc_deregister(&dev->miscdev);
 	tasklet_kill(&dev->irq_tasklet);
 	kfree(dev->pipes);
@@ -882,76 +873,3 @@ static int goldfish_pipe_device_deinit(struct platform_device *pdev,
 
 	return 0;
 }
-
-static int goldfish_pipe_probe(struct platform_device *pdev)
-{
-	struct resource *r;
-	char __iomem *base;
-	int irq;
-	int version;
-
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r || resource_size(r) < PAGE_SIZE) {
-		dev_err(&pdev->dev, "can't allocate i/o page\n");
-		return -EINVAL;
-	}
-
-	base = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
-	if (!base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		return -EINVAL;
-	}
-
-	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r)
-		return -EINVAL;
-
-	irq = r->start;
-
-	/*
-	 * Exchange the versions with the host device
-	 *
-	 * Note: v1 driver used to not report its version, so we write it before
-	 *  reading device version back: this allows the host implementation to
-	 *  detect the old driver (if there was no version write before read).
-	 */
-	writel(PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
-	version = readl(base + PIPE_REG_VERSION);
-	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
-		return -EINVAL;
-
-	return goldfish_pipe_device_init(pdev, base, irq);
-}
-
-static int goldfish_pipe_remove(struct platform_device *pdev)
-{
-	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
-
-	return goldfish_pipe_device_deinit(pdev, dev);
-}
-
-static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
-	{ "GFSH0003", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
-
-static const struct of_device_id goldfish_pipe_of_match[] = {
-	{ .compatible = "google,android-pipe", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, goldfish_pipe_of_match);
-
-static struct platform_driver goldfish_pipe_driver = {
-	.probe = goldfish_pipe_probe,
-	.remove = goldfish_pipe_remove,
-	.driver = {
-		.name = "goldfish_pipe",
-		.of_match_table = goldfish_pipe_of_match,
-		.acpi_match_table = ACPI_PTR(goldfish_pipe_acpi_match),
-	}
-};
-
-module_platform_driver(goldfish_pipe_driver);
-MODULE_AUTHOR("David Turner <digit@google.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.h b/drivers/platform/goldfish/goldfish_pipe_v2.h
new file mode 100644
index 000000000000..03b476fb9978
--- /dev/null
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef GOLDFISH_PIPE_V2_H
+#define GOLDFISH_PIPE_V2_H
+
+/* The entry point to the pipe v2 driver */
+int goldfish_pipe_device_init(struct platform_device *pdev,
+			      char __iomem *base,
+			      int irq);
+
+#endif /* #define GOLDFISH_PIPE_V2_H */
-- 
2.19.0.605.g01d371f741-goog

