Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AC520842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHo3jNtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AC520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeGIPy1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:54:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54242 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeGIPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so21698904wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8uIUM9qc2byXQCDnypSuipDzqL6TYQx7BgUTRX5elc=;
        b=cHo3jNtrA2M6fMuDUd5haEdYlQb/WoPo+UGz0tWDe/+XqMyg02pLM3/PLZRQfJ5tle
         j7ja75Tf7Q7uk3tUtkS8fg520c0Yse+TtPmhdP8SCJFonX6qx2ez0cztVHXDa35mUcZd
         wOsEbbrH3kjSLrapZYNDNwSM32UUZq7EUlBVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z8uIUM9qc2byXQCDnypSuipDzqL6TYQx7BgUTRX5elc=;
        b=d1TtKPH5hSbdzEYmr5Uib23lOsV6R+2mfdEjuen/U2Mgc8IrfjymNuZ9nZWQdbE+QW
         xw18zYaiL/VS6Y9CKPByPPjQ+jjvnDDCrXzuOepjramYXmUjbZScGDaBuN6e/mb+iUUk
         +Rri9VyfM9RFknLk1za3uzi0d34bxnRmYUnqhPAHmoD9LSdwLGtzH9GhbBMCmiZkpqyz
         Ur3KevKkEtRRkyvtRxu6cRFb41jpY0crJFnXNpd7u4EAPURS+NDqkpA5Fj5KdtuZieKZ
         2JuwxbAJ9mnITBkvXA71iNY4olZsPNuo/dFH9UKs6cqe4nbq7VXcxezN3DW7xIXxyiEx
         7fVg==
X-Gm-Message-State: APt69E3gNvzFQhu2C3GFSxRAK2uOyy9aejhp8H0UnF0iViJg7hzIOxCU
        3rFSoRBvuecYMJFDAhWjNOBECA==
X-Google-Smtp-Source: AAOMgpdo9uVibJyG4su5kGDXVyudVwyda8CPGR0j0vr05/O49Sux2gBvY9ZGwCothz4HvxUKcxFc5g==
X-Received: by 2002:a1c:ee94:: with SMTP id j20-v6mr9424234wmi.66.1531151474590;
        Mon, 09 Jul 2018 08:51:14 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o21-v6sm16229202wmg.28.2018.07.09.08.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:51:13 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, abailon@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v6 4/8] interconnect: qcom: Add RPM communication
Date:   Mon,  9 Jul 2018 18:51:00 +0300
Message-Id: <20180709155104.25528-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709155104.25528-1-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm SoCs, there is a remote processor, which controls some of
the Network-On-Chip interconnect resources. Other CPUs express their needs
by communicating with this processor. Add a driver to handle communication
with this remote processor.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
 drivers/interconnect/qcom/Kconfig             | 11 +++
 drivers/interconnect/qcom/Makefile            |  2 +
 drivers/interconnect/qcom/smd-rpm.c           | 91 +++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h           | 15 +++
 5 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
new file mode 100644
index 000000000000..88a5aeb50935
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
@@ -0,0 +1,32 @@
+Qualcomm SMD-RPM interconnect driver binding
+------------------------------------------------
+The RPM (Resource Power Manager) is a dedicated hardware engine
+for managing the shared SoC resources in order to keep the lowest
+power profile. It communicates with other hardware subsystems via
+the shared memory driver (SMD) back-end and accepts requests for
+various resources.
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,interconnect-smd-rpm"
+
+Example:
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <0 168 1>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-msm8916";
+				qcom,smd-channels = "rpm_requests";
+
+				interconnect-smd-rpm {
+					compatible = "qcom,interconnect-smd-rpm";
+				};
+
+			};
+		};
+	};
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
new file mode 100644
index 000000000000..b0c2ff928d88
--- /dev/null
+++ b/drivers/interconnect/qcom/Kconfig
@@ -0,0 +1,11 @@
+config INTERCONNECT_QCOM
+	bool "Qualcomm Network-on-Chip interconnect drivers"
+	depends on INTERCONNECT
+	depends on ARCH_QCOM || COMPILE_TEST
+
+config INTERCONNECT_QCOM_SMD_RPM
+	tristate "Qualcomm SMD RPM interconnect driver"
+	depends on INTERCONNECT_QCOM
+	help
+	  This is a driver for communicating interconnect related configuration
+	  details with a remote processor (RPM) on Qualcomm platforms.
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
new file mode 100644
index 000000000000..5b65e4011b59
--- /dev/null
+++ b/drivers/interconnect/qcom/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += smd-rpm.o
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
new file mode 100644
index 000000000000..48b7a2a6eb84
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPM over SMD communication wrapper for interconnects
+ *
+ * Copyright (C) 2018 Linaro Ltd
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smd-rpm.h>
+#include "smd-rpm.h"
+
+#define	RPM_KEY_BW	0x00007762
+
+static struct qcom_icc_rpm {
+	struct qcom_smd_rpm *rpm;
+} icc_rpm_smd;
+
+struct icc_rpm_smd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+bool qcom_icc_rpm_smd_available(void)
+{
+	if (!icc_rpm_smd.rpm)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_available);
+
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
+{
+	struct icc_rpm_smd_req req = {
+		.key = cpu_to_le32(RPM_KEY_BW),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(val),
+	};
+
+	return qcom_rpm_smd_write(icc_rpm_smd.rpm, ctx, rsc_type, id, &req,
+				  sizeof(req));
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
+
+static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
+{
+	icc_rpm_smd.rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!icc_rpm_smd.rpm) {
+		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id qcom_icc_rpm_smd_dt_match[] = {
+	{ .compatible = "qcom,interconnect-smd-rpm", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, qcom_icc_rpm_smd_dt_match);
+
+static struct platform_driver qcom_interconnect_rpm_smd_driver = {
+	.driver = {
+		.name		= "qcom-interconnect-smd-rpm",
+		.of_match_table	= qcom_icc_rpm_smd_dt_match,
+	},
+	.probe = qcom_icc_rpm_smd_probe,
+};
+
+static int __init rpm_smd_interconnect_init(void)
+{
+	return platform_driver_register(&qcom_interconnect_rpm_smd_driver);
+}
+subsys_initcall(rpm_smd_interconnect_init);
+
+static void __exit rpm_smd_interconnect_exit(void)
+{
+	platform_driver_unregister(&qcom_interconnect_rpm_smd_driver);
+}
+module_exit(rpm_smd_interconnect_exit)
+
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
new file mode 100644
index 000000000000..c33b91a3dd51
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_RPM_H
+#define __DRIVERS_INTERCONNECT_QCOM_RPM_H
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
+#endif
