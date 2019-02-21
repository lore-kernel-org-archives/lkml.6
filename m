Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047922077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bob33HTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfBUQYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:24:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33316 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfBUQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:24:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so1046429pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kQRoPtMOamkgZkyhmGYLC1s9RHzT1SIt4HeXiehVEB4=;
        b=bob33HTxuo1IF9d+wwsH8FC+/tcaYe7Z1NYkeos8o2io9pSu3sS4QszDlWvaDxcQQU
         X+pHdchlDCitbWbcpd/WzV9KFyBWmKYXgu61gBHZH5gjgRLIJDToIppqNyRfpjZHbpz1
         91S9+lnJMtAnmNoan7myseDc3Mq8SbS4rhScDqgSnC52XB24PcMAA29pG8CNOeeq8/Hg
         UhWDoUtKSlVYGTsfaX/hm2aUgT0GWV1uFcToebF4iGkfxo91ypJWjmc6EO95j5f7y4FV
         YVtonvS7ivcAqbZCIvSsKYmwIDF6xt+ChsxHFPFwcTjAo/U056SmsVZzC6itW3che8b8
         vneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kQRoPtMOamkgZkyhmGYLC1s9RHzT1SIt4HeXiehVEB4=;
        b=ZfblzNqu5ylA5BYOKsGWwlwqcQc+9W3d5Lex/8b7oeV4OL5hymV8b/7nQGlud6tjME
         feaUP9Q7g2+WQFd77QJLrUFGt7WAvsInUzFrsy4JBmPLwwtXRaL1MEcom5ku2u/p002H
         4tGTSiWN1rynWJR2iqan5MZEtqgqRtGaw+UJtLlAx7T9bXrG+vxHjFsGQep1R82yx8Fu
         3zYTg1NxXfDtWTwHGUTzGCtZvZF0kMI8Al/5qoA+9wttuNqVo1AtuK5kSivJighNNrak
         meqg+0QQdFA63wtCYdXhvJjKDEzX9RBj4PO50KaYveodEiG00F7y5INrltgWAZcSqjHw
         VXCw==
X-Gm-Message-State: AHQUAub73a77poSos7GixgzJFeENEc1Ojm2eGpMLpx7Y9BHa6d24bs3k
        fbybNTjnItT6cIcgPO8btWsP/g==
X-Google-Smtp-Source: AHgI3IY0WB659lh6/Im2kj/HUTZ3xd/9ANxXX/mkSBMyrn1kOt/SKbkUz7hXCyuoPk9vASzR22YbrA==
X-Received: by 2002:aa7:8847:: with SMTP id k7mr40332576pfo.99.1550766283495;
        Thu, 21 Feb 2019 08:24:43 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id 20sm21382910pfs.182.2019.02.21.08.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:24:43 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v3 4/5] soc: qcom: socinfo: Expose custom attributes
Date:   Thu, 21 Feb 2019 21:54:18 +0530
Message-Id: <20190221162419.32384-5-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
References: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm socinfo provides a number of additional attributes,
add these to the socinfo driver and expose them via debugfs
functionality.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
Changes since v2:
	- None
Changes since v1:
	- Remove unnecessary debugfs dir creation check
        - Align ifdefs to left
        - Fix function signatures for debugfs init/exit
---
 drivers/soc/qcom/socinfo.c | 198 +++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 02078049fac7..5f4bef216ae1 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2017-2019, Linaro Ltd.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -29,6 +30,28 @@
  */
 #define SMEM_HW_SW_BUILD_ID            137
 
+#ifdef CONFIG_DEBUG_FS
+/* pmic model info */
+static const char *const pmic_model[] = {
+	[0]  = "Unknown PMIC model",
+	[9]  = "PM8994",
+	[11] = "PM8916",
+	[13] = "PM8058",
+	[14] = "PM8028",
+	[15] = "PM8901",
+	[16] = "PM8027",
+	[17] = "ISL9519",
+	[18] = "PM8921",
+	[19] = "PM8018",
+	[20] = "PM8015",
+	[21] = "PM8014",
+	[22] = "PM8821",
+	[23] = "PM8038",
+	[24] = "PM8922",
+	[25] = "PM8917",
+};
+#endif /* CONFIG_DEBUG_FS */
+
 /* Socinfo SMEM item structure */
 struct socinfo {
 	__le32 fmt;
@@ -70,6 +93,10 @@ struct socinfo {
 struct qcom_socinfo {
 	struct soc_device *soc_dev;
 	struct soc_device_attribute attr;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dbg_root;
+#endif /* CONFIG_DEBUG_FS */
+	struct socinfo *socinfo;
 };
 
 struct soc_of_id {
@@ -133,6 +160,171 @@ static const char *socinfo_machine(struct device *dev, unsigned int id)
 	return NULL;
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+#define UINT_SHOW(name, attr)						\
+static int qcom_show_##name(struct seq_file *seq, void *p)		\
+{									\
+	struct socinfo *socinfo = seq->private;				\
+	seq_printf(seq, "%u\n", le32_to_cpu(socinfo->attr));		\
+	return 0;							\
+}									\
+static int qcom_open_##name(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, qcom_show_##name, inode->i_private);	\
+}									\
+									\
+static const struct file_operations qcom_ ##name## _ops = {		\
+	.open = qcom_open_##name,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEBUGFS_UINT_ADD(name)						\
+	debugfs_create_file(__stringify(name), 0400,			\
+			    qcom_socinfo->dbg_root,			\
+			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
+
+#define HEX_SHOW(name, attr)						\
+static int qcom_show_##name(struct seq_file *seq, void *p)		\
+{									\
+	struct socinfo *socinfo = seq->private;				\
+	seq_printf(seq, "0x%x\n", le32_to_cpu(socinfo->attr));		\
+	return 0;							\
+}									\
+static int qcom_open_##name(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, qcom_show_##name, inode->i_private);	\
+}									\
+									\
+static const struct file_operations qcom_ ##name## _ops = {		\
+	.open = qcom_open_##name,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEBUGFS_HEX_ADD(name)						\
+	debugfs_create_file(__stringify(name), 0400,			\
+			    qcom_socinfo->dbg_root,			\
+			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
+
+
+#define QCOM_OPEN(name, _func)						\
+static int qcom_open_##name(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, _func, inode->i_private);		\
+}									\
+									\
+static const struct file_operations qcom_ ##name## _ops = {		\
+	.open = qcom_open_##name,					\
+	.read = seq_read,						\
+	.llseek = seq_lseek,						\
+	.release = single_release,					\
+}
+
+#define DEBUGFS_ADD(name)						\
+	debugfs_create_file(__stringify(name), 0400,			\
+			    qcom_socinfo->dbg_root,			\
+			    qcom_socinfo->socinfo, &qcom_ ##name## _ops)
+
+
+static int qcom_show_build_id(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+
+	seq_printf(seq, "%s\n", socinfo->build_id);
+
+	return 0;
+}
+
+static int qcom_show_accessory_chip(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+
+	seq_printf(seq, "%d\n", le32_to_cpu(socinfo->accessory_chip));
+
+	return 0;
+}
+
+static int qcom_show_platform_subtype(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+	int subtype = le32_to_cpu(socinfo->hw_plat_subtype);
+
+	if (subtype < 0)
+		return -EINVAL;
+
+	seq_printf(seq, "%u\n", subtype);
+
+	return 0;
+}
+
+static int qcom_show_pmic_model(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+	int model = SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_model));
+
+	if (model < 0)
+		return -EINVAL;
+
+	seq_printf(seq, "%s\n", pmic_model[model]);
+
+	return 0;
+}
+
+static int qcom_show_pmic_die_revision(struct seq_file *seq, void *p)
+{
+	struct socinfo *socinfo = seq->private;
+
+	seq_printf(seq, "%u.%u\n",
+		   SOCINFO_MAJOR(le32_to_cpu(socinfo->pmic_die_rev)),
+		   SOCINFO_MINOR(le32_to_cpu(socinfo->pmic_die_rev)));
+
+	return 0;
+}
+
+UINT_SHOW(raw_version, raw_ver);
+UINT_SHOW(hardware_platform, hw_plat);
+UINT_SHOW(platform_version, plat_ver);
+UINT_SHOW(foundry_id, foundry_id);
+HEX_SHOW(chip_family, chip_family);
+HEX_SHOW(raw_device_family, raw_device_family);
+HEX_SHOW(raw_device_number, raw_device_num);
+QCOM_OPEN(build_id, qcom_show_build_id);
+QCOM_OPEN(accessory_chip, qcom_show_accessory_chip);
+QCOM_OPEN(pmic_model, qcom_show_pmic_model);
+QCOM_OPEN(platform_subtype, qcom_show_platform_subtype);
+QCOM_OPEN(pmic_die_revision, qcom_show_pmic_die_revision);
+
+static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
+{
+	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
+
+	DEBUGFS_UINT_ADD(raw_version);
+	DEBUGFS_UINT_ADD(hardware_platform);
+	DEBUGFS_UINT_ADD(platform_version);
+	DEBUGFS_UINT_ADD(foundry_id);
+	DEBUGFS_HEX_ADD(chip_family);
+	DEBUGFS_HEX_ADD(raw_device_family);
+	DEBUGFS_HEX_ADD(raw_device_number);
+	DEBUGFS_ADD(build_id);
+	DEBUGFS_ADD(accessory_chip);
+	DEBUGFS_ADD(pmic_model);
+	DEBUGFS_ADD(platform_subtype);
+	DEBUGFS_ADD(pmic_die_revision);
+}
+
+static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
+{
+	debugfs_remove_recursive(qcom_socinfo->dbg_root);
+}
+#else
+static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo) { return 0; }
+static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo) {  }
+#endif /* CONFIG_DEBUG_FS */
+
 static int qcom_socinfo_probe(struct platform_device *pdev)
 {
 	struct qcom_socinfo *qs;
@@ -165,6 +357,10 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 	if (IS_ERR(qs->soc_dev))
 		return PTR_ERR(qs->soc_dev);
 
+	qs->socinfo = info;
+
+	socinfo_debugfs_init(qs);
+
 	/* Feed the soc specific unique data into entropy pool */
 	add_device_randomness(info, item_size);
 
@@ -179,6 +375,8 @@ static int qcom_socinfo_remove(struct platform_device *pdev)
 
 	soc_device_unregister(qs->soc_dev);
 
+	socinfo_debugfs_exit(qs);
+
 	return 0;
 }
 
-- 
2.17.1

