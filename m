Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90920C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5433B222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzmEuAPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395395AbfBNDlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:41:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37593 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395383AbfBNDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:41:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so2380554plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wseL0Pd2SRrAzvi0h0ZOmtAXsIE/vn/nGWi0cl+/f04=;
        b=tzmEuAPltrPH61We14SnlpWuAFrTLoS6wJfu1ov6+XMXz0znQO08OmlqCATdi6idv8
         K17+1JfqwBGy9q0apnCRDnqeMFHb+Fs4pcnnQfyF+u16INF3ZzqEk404bAPBzbzsZzz+
         JffvfiMyMWPsq2KNR0WUzWJiMWVGwIEh09BH2KlkJSzC9bSlE8FA4iyAVXPDrN+46AQI
         qMyou3+J6lVpwrfFu72rRWA1BlDkRsGoPvigtFkIomF2Mr5CN/1/93IonQsfl53Zp3S2
         pMzHmQXOKZIerG3YMZSZjits9aWy7WSr7TIq8vUZEBoiVuIOkSkJ/Mtd37uVPZ6gWXEf
         jZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wseL0Pd2SRrAzvi0h0ZOmtAXsIE/vn/nGWi0cl+/f04=;
        b=mG2kWAS1+rOA5ajjw46xdvgpn/q8Dy20cFaDHIL1wURNVpInpUwq5t7FKE+GUk7GHC
         AdK1xPKmImgYGjq8hg8XgfToqPGa2392PD7i3N8FDhuEHi14aDPia1TLHDuccdrjAyZE
         Wh5cU3KIbYhVUw+jo01HaglLQgqOFy81k6pSbMHpUz+u7dRVXMfUW/aH3foG0VU7rPYo
         22GHADdv8LH+EvjY98KhY0I2ZUn6pPRHpmjnetW/+FadQPmUmcIjFvwxI7+ccNzQayv1
         2c7AfhySS9/2YH3f3Gpf9zvO8FHl45yoNynQbv7IRqCk0AnYry+TY37cvpxuvmdZwvvM
         QMFA==
X-Gm-Message-State: AHQUAuZap48ob4marGhemT0/TY3dNdsFYuKMjt01l3FAcj9Wua8r8zTq
        7WCmu+jGfi9kBZydNd97iLFBcA==
X-Google-Smtp-Source: AHgI3Ib08KW9ZS1A8ImB5xvvTLfHdvLym3JKFOt3Ypv1/mnVns00b9yaM6U4PKTI+Dtqj6kZ85Jpyw==
X-Received: by 2002:a17:902:bb89:: with SMTP id m9mr1839791pls.320.1550115705446;
        Wed, 13 Feb 2019 19:41:45 -0800 (PST)
Received: from localhost.localdomain ([103.240.171.178])
        by smtp.gmail.com with ESMTPSA id y21sm948840pfe.57.2019.02.13.19.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 19:41:44 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Imran Khan <kimran@codeaurora.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH 2/5] soc: qcom: Add socinfo driver
Date:   Thu, 14 Feb 2019 09:11:38 +0530
Message-Id: <925df36b602fab1aba08d4e2b7b58e8080a06a82.1550114271.git.vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550114271.git.vaishali.thakkar@linaro.org>
References: <cover.1550114271.git.vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imran Khan <kimran@codeaurora.org>

The Qualcomm socinfo driver exposes information about the SoC, its
version and its serial number to user space.

Signed-off-by: Imran Khan <kimran@codeaurora.org>
[Bjorn: Extract code to platform_driver, split patch in multiple]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[Vaishali: Simplify declarations, introduce qcom_socinfo struc, Fix
           memory leak, Remove extra code and Misc code refactoring]
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
 drivers/soc/qcom/Kconfig   |   8 ++
 drivers/soc/qcom/Makefile  |   1 +
 drivers/soc/qcom/smem.c    |   8 ++
 drivers/soc/qcom/socinfo.c | 197 +++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 drivers/soc/qcom/socinfo.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index fcbf8a2e4080..1e31eda07934 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -144,6 +144,14 @@ config QCOM_SMSM
 	  Say yes here to support the Qualcomm Shared Memory State Machine.
 	  The state machine is represented by bits in shared memory.
 
+config QCOM_SOCINFO
+	tristate "Qualcomm socinfo driver"
+	depends on QCOM_SMEM
+	select SOC_BUS
+	help
+	 Say yes here to support the Qualcomm socinfo driver, providing
+	 information about the SoC to user space.
+
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index f25b54cd6cf8..c817da4f4140 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -14,6 +14,7 @@ qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
+obj-$(CONFIG_QCOM_SOCINFO)     += socinfo.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index f80d040601fd..efe0b053ef82 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -276,6 +276,7 @@ struct qcom_smem {
 	struct smem_partition_header *partitions[SMEM_HOST_COUNT];
 	size_t cacheline[SMEM_HOST_COUNT];
 	u32 item_count;
+	struct platform_device *socinfo;
 
 	unsigned num_regions;
 	struct smem_region regions[];
@@ -971,11 +972,18 @@ static int qcom_smem_probe(struct platform_device *pdev)
 
 	__smem = smem;
 
+	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
+						      PLATFORM_DEVID_NONE, NULL,
+						      0);
+	if (IS_ERR(smem->socinfo))
+		dev_err(&pdev->dev, "failed to register socinfo device\n");
+
 	return 0;
 }
 
 static int qcom_smem_remove(struct platform_device *pdev)
 {
+
 	hwspin_lock_free(__smem->hwlock);
 	__smem = NULL;
 
diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
new file mode 100644
index 000000000000..02078049fac7
--- /dev/null
+++ b/drivers/soc/qcom/socinfo.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2009-2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017-2019, Linaro Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+#include <linux/types.h>
+
+/*
+ * SoC version type with major number in the upper 16 bits and minor
+ * number in the lower 16 bits.
+ */
+#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
+#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
+
+#define SMEM_SOCINFO_BUILD_ID_LENGTH           32
+
+/*
+ * SMEM item ids, used to acquire handles to respective
+ * SMEM region.
+ */
+#define SMEM_HW_SW_BUILD_ID            137
+
+/* Socinfo SMEM item structure */
+struct socinfo {
+	__le32 fmt;
+	__le32 id;
+	__le32 ver;
+	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
+	/* Version 2 */
+	__le32 raw_id;
+	__le32 raw_ver;
+	/* Version 3 */
+	__le32 hw_plat;
+	/* Version 4 */
+	__le32 plat_ver;
+	/* Version 5 */
+	__le32 accessory_chip;
+	/* Version 6 */
+	__le32 hw_plat_subtype;
+	/* Version 7 */
+	__le32 pmic_model;
+	__le32 pmic_die_rev;
+	/* Version 8 */
+	__le32 pmic_model_1;
+	__le32 pmic_die_rev_1;
+	__le32 pmic_model_2;
+	__le32 pmic_die_rev_2;
+	/* Version 9 */
+	__le32 foundry_id;
+	/* Version 10 */
+	__le32 serial_num;
+	/* Version 11 */
+	__le32 num_pmics;
+	__le32 pmic_array_offset;
+	/* Version 12 */
+	__le32 chip_family;
+	__le32 raw_device_family;
+	__le32 raw_device_num;
+};
+
+struct qcom_socinfo {
+	struct soc_device *soc_dev;
+	struct soc_device_attribute attr;
+};
+
+struct soc_of_id {
+	unsigned int id;
+	const char *name;
+};
+
+static const struct soc_of_id soc_of_id[] = {
+	{87, "MSM8960"},
+	{109, "APQ8064"},
+	{122, "MSM8660A"},
+	{123, "MSM8260A"},
+	{124, "APQ8060A"},
+	{126, "MSM8974"},
+	{130, "MPQ8064"},
+	{138, "MSM8960AB"},
+	{139, "APQ8060AB"},
+	{140, "MSM8260AB"},
+	{141, "MSM8660AB"},
+	{178, "APQ8084"},
+	{184, "APQ8074"},
+	{185, "MSM8274"},
+	{186, "MSM8674"},
+	{194, "MSM8974PRO"},
+	{206, "MSM8916"},
+	{208, "APQ8074-AA"},
+	{209, "APQ8074-AB"},
+	{210, "APQ8074PRO"},
+	{211, "MSM8274-AA"},
+	{212, "MSM8274-AB"},
+	{213, "MSM8274PRO"},
+	{214, "MSM8674-AA"},
+	{215, "MSM8674-AB"},
+	{216, "MSM8674PRO"},
+	{217, "MSM8974-AA"},
+	{218, "MSM8974-AB"},
+	{246, "MSM8996"},
+	{247, "APQ8016"},
+	{248, "MSM8216"},
+	{249, "MSM8116"},
+	{250, "MSM8616"},
+	{291, "APQ8096"},
+	{305, "MSM8996SG"},
+	{310, "MSM8996AU"},
+	{311, "APQ8096AU"},
+	{312, "APQ8096SG"},
+};
+
+static const char *socinfo_machine(struct device *dev, unsigned int id)
+{
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(soc_of_id); idx++) {
+		if (soc_of_id[idx].id == id)
+			return soc_of_id[idx].name;
+	}
+
+	if (IS_ERR(soc_of_id[idx].name))
+		dev_err(dev, "Unknown soc id\n");
+
+	return NULL;
+}
+
+static int qcom_socinfo_probe(struct platform_device *pdev)
+{
+	struct qcom_socinfo *qs;
+	struct socinfo *info;
+	size_t item_size;
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
+			      &item_size);
+	if (IS_ERR(info)) {
+		dev_err(&pdev->dev, "Couldn't find socinfo\n");
+		return -EINVAL;
+	}
+
+	qs = devm_kzalloc(&pdev->dev, sizeof(*qs), GFP_KERNEL);
+	if (!qs)
+		return -ENOMEM;
+
+	qs->attr.family = "Snapdragon";
+	qs->attr.machine = socinfo_machine(&pdev->dev,
+					   le32_to_cpu(info->id));
+	qs->attr.revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.%u",
+					   SOCINFO_MAJOR(le32_to_cpu(info->ver)),
+					   SOCINFO_MINOR(le32_to_cpu(info->ver)));
+	if (le32_to_cpu(info->fmt) >= 10)
+		qs->attr.serial_number = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"%u",
+							le32_to_cpu(info->serial_num));
+
+	qs->soc_dev = soc_device_register(&qs->attr);
+	if (IS_ERR(qs->soc_dev))
+		return PTR_ERR(qs->soc_dev);
+
+	/* Feed the soc specific unique data into entropy pool */
+	add_device_randomness(info, item_size);
+
+	platform_set_drvdata(pdev, qs->soc_dev);
+
+	return 0;
+}
+
+static int qcom_socinfo_remove(struct platform_device *pdev)
+{
+	struct qcom_socinfo *qs = platform_get_drvdata(pdev);
+
+	soc_device_unregister(qs->soc_dev);
+
+	return 0;
+}
+
+static struct platform_driver qcom_socinfo_driver = {
+	.probe = qcom_socinfo_probe,
+	.remove = qcom_socinfo_remove,
+	.driver  = {
+		.name = "qcom-socinfo",
+	},
+};
+
+module_platform_driver(qcom_socinfo_driver);
+
+MODULE_DESCRIPTION("Qualcomm socinfo driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-socinfo");
-- 
2.17.1

