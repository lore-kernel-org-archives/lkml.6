Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF685C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA6F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZ6FmqqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfBTE6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:58:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34216 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbfBTE6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:58:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so11247897pgd.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=k425mRU+Z5hM/Fx7iH6l24WC7zBNH3HFHJvyc2sDvCA=;
        b=LZ6FmqqKBD0GzYKEzyQ1JAEvl+B4rtrtO03ZenLFZsRqFHN7YeHQNVIfHqJeAGE/BO
         wtuHIMEkVmHTXLTlVTGKbCmC4JkHqhDu0YXybRa3gGxZ+3LqviHaYCM57CWaAMSXY7kP
         3rJMBvYXZnKJ/ct1+LEhYHMW24P/Otwng9sN4F79MqFaQAwkG0aGDeL7YGdK+CcsdIZN
         1MfgC9W3RbU1kGK9weBLEqxEtM2K1VW0vbylxRry/guy3qpi87CHvSu9yD83UPQQmoqR
         6p5UbxH09sHS3IA3yD8KVvDt5CSF/UUtbKLFGldtMZVUbEaHe2syy+SzLbgwnjbH5QkJ
         lAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k425mRU+Z5hM/Fx7iH6l24WC7zBNH3HFHJvyc2sDvCA=;
        b=PFdqZbfWuAxqiMcvchKp2HD1cAxpH2uGpmlR9nUfUEJrLE79C3l9zTYv+ZNKJeELmC
         RcqbweyDxQ9uaxeyxk3UQOO2NipPEkB5b+hBKqzrKOT5GXJqclygtFQbZz9469Hk8HhX
         fb5TZhVBu8QZe1VsMIQLmOfsOB6IpOWC2k8rwFF+S5JcfH03Qc1yN+P+Htc72+UMvMKA
         O1bi35N0ZXSj5hSVJIHlseLrOTzwnm8dJv9MCd0Fg0MmSWrKRzoHNTya38DxA0L5PcHq
         ZUuyWQ6WU88rT0wzLM86/Vod9oAmMNWu/P9H19blOfVjgBgORCof0HRZznzIswGYJrKI
         nIUA==
X-Gm-Message-State: AHQUAuaC1pbpX6t0pkQRKlcqgxuZrjcz4Xuuh7wALgPFnYvu5ZPJZVA5
        9QunmS4ECqBiP6dbcApmiWspEZb0jCk=
X-Google-Smtp-Source: AHgI3IaDl8J+OAXiROhL3J1kK7ffT326YyO0bPVqZW588lX8mXWMztwcgUlvnsAjqlgHuY5HTaymjA==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr33414249pfp.117.1550638715407;
        Tue, 19 Feb 2019 20:58:35 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id t12sm44238958pgq.68.2019.02.19.20.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:58:34 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v2 3/5] soc: qcom: socinfo: Expose custom attributes
Date:   Wed, 20 Feb 2019 10:28:29 +0530
Message-Id: <20190220045829.6852-1-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm socinfo provides a number of additional attributes,
add these to the socinfo driver and expose them via debugfs
functionality.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
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

