Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE623C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA9E217F4
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgFmJGnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfAFIKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:10:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38322 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfAFIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:10:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so19341508pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 00:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AArN6pfZJ3nYYanE1Ys4udiYH6N9W/+ZF3XW4uN58k=;
        b=HgFmJGnPQyrCAo29J2VwlJ05s5BVzFDIrP+RDxJjfDs7Tq7y4X6f5JDSOUGkyBiydY
         vLjgiY/P0Ph7mJ/zitIBh9JzxcSeBKs7FDFX5BFmOWhSF4tzTVOrusJ8Bh2B4Yn19uBe
         iXZVxZHp39dbxZ5G3W7GE3q0+kzOtyCWMcjJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0AArN6pfZJ3nYYanE1Ys4udiYH6N9W/+ZF3XW4uN58k=;
        b=Pzoq7HKJOr0tTmHxqRa7+u6Q4n0STKCKSLQGQs809R65T3A9x2BG1hrRjg3mdUPdVy
         YjBoHApDDRdD8lbl2Y+pnq5zQIHvdcONH4+/wrCLsFhSFP1ML+rkJ3GnwtrLOLUe5APR
         W9CliaHx8S2UGne+YfpSJedTRQWw7/DvKiZ6Z7Sc/R4DtiorSkkVHOJ48AOcMttVURXi
         hR0dF4hrApRQH0LKHYdf0EFHl8aXVD3UtGw/0XY/O1m1KQubttCQUArIh06tVAxh1ry4
         vtgjfU9I43+v/XvlWjWXBpuXkDedvDsUHn+axdQgINEs2jJsESUxAUYggCqRE8ZbKOBo
         LuzA==
X-Gm-Message-State: AJcUukc+aMAayjJTsU9tbdy/zO3SOllKHCd/0Wjd1GvYgDeeWoHU+y0B
        8CwStUtIwzYy6I/bQHYB6vgOnA==
X-Google-Smtp-Source: ALg8bN43hV3PjyIWSsO4i+Pzm4j6Npx3onZ15KWyEE8Zn0jnO8ynWsW6DDUQd3IWkGN8xD5ZNg9nxQ==
X-Received: by 2002:a63:2a4a:: with SMTP id q71mr54029383pgq.374.1546762219313;
        Sun, 06 Jan 2019 00:10:19 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v190sm90763364pfv.26.2019.01.06.00.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 00:10:18 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] soc: qcom: Add AOSS QMP communication driver
Date:   Sun,  6 Jan 2019 00:09:10 -0800
Message-Id: <20190106080915.4493-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190106080915.4493-1-bjorn.andersson@linaro.org>
References: <20190106080915.4493-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP driver is used to communicate with the AOSS for certain
side-channel requests, that are not enabled through the RPMh interface.

The communication is a very simple synchronous mechanism of messages
being written in message RAM and a doorbell in the AOSS is rung. As the
AOSS has processed the message length is cleared and an interrupt is
fired by the AOSS as acknowledgment.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Skip check in send for empty TX buffer
- Don't follow WARN_ON() with dev_err()
- Register platform_device rather than populate based on of-children

 drivers/soc/qcom/Kconfig          |   9 +
 drivers/soc/qcom/Makefile         |   1 +
 drivers/soc/qcom/aoss-qmp.c       | 313 ++++++++++++++++++++++++++++++
 include/linux/soc/qcom/aoss-qmp.h |  12 ++
 4 files changed, 335 insertions(+)
 create mode 100644 drivers/soc/qcom/aoss-qmp.c
 create mode 100644 include/linux/soc/qcom/aoss-qmp.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a51458022d21..dda19471057f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -3,6 +3,15 @@
 #
 menu "Qualcomm SoC drivers"
 
+config QCOM_AOSS_QMP
+	tristate "Qualcomm AOSS Messaging Driver"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on MAILBOX
+	help
+	  This driver provides the means for communicating with the
+	  micro-controller in the AOSS, using QMP, to control certain resource
+	  that are not exposed through RPMh.
+
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 67cb85d0373c..d0d7fdc94d9a 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_rpmh-rsc.o := -I$(src)
+obj-$(CONFIG_QCOM_AOSS_QMP) +=	aoss-qmp.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
diff --git a/drivers/soc/qcom/aoss-qmp.c b/drivers/soc/qcom/aoss-qmp.c
new file mode 100644
index 000000000000..de52703b96b6
--- /dev/null
+++ b/drivers/soc/qcom/aoss-qmp.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Ltd
+ */
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/aoss-qmp.h>
+
+#define QMP_DESC_MAGIC			0x0
+#define QMP_DESC_VERSION		0x4
+#define QMP_DESC_FEATURES		0x8
+
+#define QMP_DESC_UCORE_LINK_STATE	0xc
+#define QMP_DESC_UCORE_LINK_STATE_ACK	0x10
+#define QMP_DESC_UCORE_CH_STATE		0x14
+#define QMP_DESC_UCORE_CH_STATE_ACK	0x18
+#define QMP_DESC_UCORE_MBOX_SIZE	0x1c
+#define QMP_DESC_UCORE_MBOX_OFFSET	0x20
+
+#define QMP_DESC_MCORE_LINK_STATE	0x24
+#define QMP_DESC_MCORE_LINK_STATE_ACK	0x28
+#define QMP_DESC_MCORE_CH_STATE		0x2c
+#define QMP_DESC_MCORE_CH_STATE_ACK	0x30
+#define QMP_DESC_MCORE_MBOX_SIZE	0x34
+#define QMP_DESC_MCORE_MBOX_OFFSET	0x38
+
+#define QMP_STATE_UP	0x0000ffff
+#define QMP_STATE_DOWN	0xffff0000
+
+#define QMP_MAGIC	0x4d41494c
+#define QMP_VERSION	1
+
+/**
+ * struct qmp - driver state for QMP implementation
+ * @msgram: iomem referencing the message RAM used for communication
+ * @dev: reference to QMP device
+ * @mbox_client: mailbox client used to ring the doorbell on transmit
+ * @mbox_chan: mailbox channel used to ring the doorbell on transmit
+ * @offset: offset within @msgram where messages should be written
+ * @size: maximum size of the messages to be transmitted
+ * @event: wait_queue for synchronization with the IRQ
+ * @tx_lock: provides syncrhonization between multiple callers of qmp_send()
+ * @pd_pdev: platform device for the power-domain child device
+ */
+struct qmp {
+	void __iomem *msgram;
+	struct device *dev;
+
+	struct mbox_client mbox_client;
+	struct mbox_chan *mbox_chan;
+
+	size_t offset;
+	size_t size;
+
+	wait_queue_head_t event;
+
+	struct mutex tx_lock;
+
+	struct platform_device *pd_pdev;
+};
+
+static void qmp_kick(struct qmp *qmp)
+{
+	mbox_send_message(qmp->mbox_chan, NULL);
+	mbox_client_txdone(qmp->mbox_chan, 0);
+}
+
+static bool qmp_magic_valid(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_MAGIC) == QMP_MAGIC;
+}
+
+static bool qmp_link_acked(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_MCORE_LINK_STATE_ACK) == QMP_STATE_UP;
+}
+
+static bool qmp_mcore_channel_acked(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_MCORE_CH_STATE_ACK) == QMP_STATE_UP;
+}
+
+static bool qmp_ucore_channel_up(struct qmp *qmp)
+{
+	return readl(qmp->msgram + QMP_DESC_UCORE_CH_STATE) == QMP_STATE_UP;
+}
+
+static int qmp_open(struct qmp *qmp)
+{
+	int ret;
+	u32 val;
+
+	ret = wait_event_timeout(qmp->event, qmp_magic_valid(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "QMP magic doesn't match\n");
+		return -ETIMEDOUT;
+	}
+
+	val = readl(qmp->msgram + QMP_DESC_VERSION);
+	if (val != QMP_VERSION) {
+		dev_err(qmp->dev, "unsupported QMP version %d\n", val);
+		return -EINVAL;
+	}
+
+	qmp->offset = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_OFFSET);
+	qmp->size = readl(qmp->msgram + QMP_DESC_MCORE_MBOX_SIZE);
+	if (!qmp->size) {
+		dev_err(qmp->dev, "invalid mailbox size 0x%zx\n", qmp->size);
+		return -EINVAL;
+	}
+
+	/* Ack remote core's link state */
+	val = readl(qmp->msgram + QMP_DESC_UCORE_LINK_STATE);
+	writel(val, qmp->msgram + QMP_DESC_UCORE_LINK_STATE_ACK);
+
+	/* Set local core's link state to up */
+	writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
+
+	qmp_kick(qmp);
+
+	ret = wait_event_timeout(qmp->event, qmp_link_acked(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "ucore didn't ack link\n");
+		goto timeout_close_link;
+	}
+
+	writel(QMP_STATE_UP, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
+
+	ret = wait_event_timeout(qmp->event, qmp_ucore_channel_up(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "ucore didn't open channel\n");
+		goto timeout_close_channel;
+	}
+
+	/* Ack remote core's channel state */
+	val = readl(qmp->msgram + QMP_DESC_UCORE_CH_STATE);
+	writel(val, qmp->msgram + QMP_DESC_UCORE_CH_STATE_ACK);
+
+	qmp_kick(qmp);
+
+	ret = wait_event_timeout(qmp->event, qmp_mcore_channel_acked(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "ucore didn't ack channel\n");
+		goto timeout_close_channel;
+	}
+
+	return 0;
+
+timeout_close_channel:
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
+
+timeout_close_link:
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
+	qmp_kick(qmp);
+
+	return -ETIMEDOUT;
+}
+
+static void qmp_close(struct qmp *qmp)
+{
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_CH_STATE);
+	writel(QMP_STATE_DOWN, qmp->msgram + QMP_DESC_MCORE_LINK_STATE);
+	qmp_kick(qmp);
+}
+
+static irqreturn_t qmp_intr(int irq, void *data)
+{
+	struct qmp *qmp = data;
+
+	wake_up_interruptible_all(&qmp->event);
+
+	return IRQ_HANDLED;
+}
+
+static bool qmp_message_empty(struct qmp *qmp)
+{
+	return readl(qmp->msgram + qmp->offset) == 0;
+}
+
+/**
+ * qmp_send() - send a message to the AOSS
+ * @qmp: qmp context
+ * @data: message to be sent
+ * @len: length of the message
+ *
+ * Transmit @data to AOSS and wait for the AOSS to acknowledge the message.
+ * @len must be a multiple of 4 and not longer than the mailbox size. Access is
+ * synchronized by this implementation.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int qmp_send(struct qmp *qmp, const void *data, size_t len)
+{
+	int ret;
+
+	if (WARN_ON(len + sizeof(u32) > qmp->size))
+		return -EINVAL;
+
+	if (WARN_ON(len % sizeof(u32)))
+		return -EINVAL;
+
+	mutex_lock(&qmp->tx_lock);
+
+	/* The message RAM only implements 32-bit accesses */
+	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
+			 data, len / sizeof(u32));
+	writel(len, qmp->msgram + qmp->offset);
+	qmp_kick(qmp);
+
+	ret = wait_event_interruptible_timeout(qmp->event,
+					       qmp_message_empty(qmp), HZ);
+	if (!ret) {
+		dev_err(qmp->dev, "ucore did not ack channel\n");
+		ret = -ETIMEDOUT;
+
+		/* Clear message from buffer */
+		writel(0, qmp->msgram + qmp->offset);
+	} else {
+		ret = 0;
+	}
+
+	mutex_unlock(&qmp->tx_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(qmp_send);
+
+static int qmp_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct qmp *qmp;
+	int irq;
+	int ret;
+
+	qmp = devm_kzalloc(&pdev->dev, sizeof(*qmp), GFP_KERNEL);
+	if (!qmp)
+		return -ENOMEM;
+
+	qmp->dev = &pdev->dev;
+	init_waitqueue_head(&qmp->event);
+	mutex_init(&qmp->tx_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	qmp->msgram = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(qmp->msgram))
+		return PTR_ERR(qmp->msgram);
+
+	qmp->mbox_client.dev = &pdev->dev;
+	qmp->mbox_client.knows_txdone = true;
+	qmp->mbox_chan = mbox_request_channel(&qmp->mbox_client, 0);
+	if (IS_ERR(qmp->mbox_chan)) {
+		dev_err(&pdev->dev, "failed to acquire ipc mailbox\n");
+		return PTR_ERR(qmp->mbox_chan);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(&pdev->dev, irq, qmp_intr, IRQF_ONESHOT,
+			       "aoss-qmp", qmp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request interrupt\n");
+		return ret;
+	}
+
+	ret = qmp_open(qmp);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, qmp);
+
+	if (of_property_read_bool(pdev->dev.of_node, "#power-domain-cells")) {
+		qmp->pd_pdev = platform_device_register_data(&pdev->dev,
+							     "aoss_qmp_pd",
+							     PLATFORM_DEVID_NONE,
+							     NULL, 0);
+		if (IS_ERR(qmp->pd_pdev))
+			dev_err(&pdev->dev, "failed to register AOSS PD\n");
+	}
+
+	return 0;
+}
+
+static int qmp_remove(struct platform_device *pdev)
+{
+	struct qmp *qmp = platform_get_drvdata(pdev);
+
+	platform_device_unregister(qmp->pd_pdev);
+
+	qmp_close(qmp);
+
+	return 0;
+}
+
+static const struct of_device_id qmp_dt_match[] = {
+	{ .compatible = "qcom,sdm845-aoss-qmp", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qmp_dt_match);
+
+static struct platform_driver qmp_driver = {
+	.driver = {
+		.name		= "aoss_qmp",
+		.of_match_table	= qmp_dt_match,
+	},
+	.probe = qmp_probe,
+	.remove	= qmp_remove,
+};
+module_platform_driver(qmp_driver);
+
+MODULE_DESCRIPTION("Qualcomm AOSS QMP driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/qcom/aoss-qmp.h b/include/linux/soc/qcom/aoss-qmp.h
new file mode 100644
index 000000000000..32ccaa091a9f
--- /dev/null
+++ b/include/linux/soc/qcom/aoss-qmp.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd
+ */
+#ifndef __AOP_QMP_H__
+#define __AOP_QMP_H__
+
+struct qmp;
+
+int qmp_send(struct qmp *qmp, const void *data, size_t len);
+
+#endif
-- 
2.18.0

