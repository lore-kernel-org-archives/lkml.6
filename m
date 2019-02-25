Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0800CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B727C20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWQGMGs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfBYGvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:51:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32979 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfBYGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:51:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so4044740pfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 22:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yTOxTtmZbkPAZtakCDu5P9EEMXa2Aqz4JPWcUR/5qyY=;
        b=FWQGMGs8Y3rXjHw3vuPjZ6ceklbzhJD4NCuM0R6zeCMACOkrt4KBnYvZmuFT1S2Fp/
         DHf0v03Bm6s7h31tGNHo2l1y0g0Inzfwubb6YwUzdU2nf//FBXeblfbfXs0wxjUatOsw
         SJ+ocbSlHNJVCZmO4aOPEF4aZzNz1GGCqJF4K+cqU/qC5x9vCUW9e2l/z+t2Zt+W8l3v
         Jk3+cYF3isx7EcsualKxVnAA+UFGH2KRTpUnwQaBqTQlm9MtQXrr3rnt8vvuNvVzMOKP
         FQdKeqzIVYwt10Hv2iezr3+N6uNY34VfVtqNnHVxB5oVRn5NmBx7i3yjrIyyWZ/pRmBl
         PWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yTOxTtmZbkPAZtakCDu5P9EEMXa2Aqz4JPWcUR/5qyY=;
        b=oy3wKgI6NtvwevPR0jcyqmVhFQgxDZZ+eLXMM4vEychd3nszUNT7Ppa/mE8J0JP+Ob
         PELLqkrVSo0WIjStsljW/q+ip+g5O3eTbQh2Dh8d1ZUPDnbWPVG0MpU4pz/3rBeZMvwW
         /CKJyOKFL7fdEy1cbklPAwUVwZQ2RzX4kmRuq/1zbNng5JxIGK4zQiHALQDtjsqoU9Ov
         kec9jwPITo62a1RCQbkYuQATIALxpV8YbNh9qOJ1j9eE+/pmCFHdGY6S+vtmqizQswSA
         9ls1ROrRHExIeTvKqcNj0bytFLj6Yp9lXyyoZR5MlOuU6swallcHZNRoZyK44aIePjsP
         1WsQ==
X-Gm-Message-State: AHQUAuZ8gbWN+j9fbMtx4f+ErCNNsphb4tybYk6ddI7r6ZAmkAyEABI7
        IudWDkkVRvnkZBOgo336gGjVlw==
X-Google-Smtp-Source: AHgI3Ia4PWr3LR7qnrz3TtOrO085ZSFpAqdTdN5uj/nDbyUe+IxWr2BeqCngr1561iMCmw5CB5MnVg==
X-Received: by 2002:a63:f84d:: with SMTP id v13mr17704887pgj.384.1551077474414;
        Sun, 24 Feb 2019 22:51:14 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id f16sm9990021pgg.20.2019.02.24.22.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 22:51:13 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v4 5/5] soc: qcom: socinfo: Expose image information
Date:   Mon, 25 Feb 2019 12:20:44 +0530
Message-Id: <20190225065044.11023-6-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The socinfo driver provides information about version of the various
images loaded in the system. Expose this to user space for debugging
purpose.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
Changes since v3:
	- Remove extra debugfs directory creation checks
Changes since v2:
        - None
Changes since v1:
        - None
---
 drivers/soc/qcom/socinfo.c | 178 +++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index ccadeba69a81..5d77265054a3 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -31,6 +31,25 @@
 #define SMEM_HW_SW_BUILD_ID            137
 
 #ifdef CONFIG_DEBUG_FS
+#define SMEM_IMAGE_VERSION_BLOCKS_COUNT        32
+#define SMEM_IMAGE_VERSION_SIZE                4096
+#define SMEM_IMAGE_VERSION_NAME_SIZE           75
+#define SMEM_IMAGE_VERSION_VARIANT_SIZE        20
+#define SMEM_IMAGE_VERSION_OEM_SIZE            32
+
+/*
+ * SMEM Image table indices
+ */
+#define SMEM_IMAGE_TABLE_BOOT_INDEX     0
+#define SMEM_IMAGE_TABLE_TZ_INDEX       1
+#define SMEM_IMAGE_TABLE_RPM_INDEX      3
+#define SMEM_IMAGE_TABLE_APPS_INDEX     10
+#define SMEM_IMAGE_TABLE_MPSS_INDEX     11
+#define SMEM_IMAGE_TABLE_ADSP_INDEX     12
+#define SMEM_IMAGE_TABLE_CNSS_INDEX     13
+#define SMEM_IMAGE_TABLE_VIDEO_INDEX    14
+#define SMEM_IMAGE_VERSION_TABLE       469
+
 /* pmic model info */
 static const char *const pmic_model[] = {
 	[0]  = "Unknown PMIC model",
@@ -90,11 +109,21 @@ struct socinfo {
 	__le32 raw_device_num;
 };
 
+#ifdef CONFIG_DEBUG_FS
+struct smem_image_version {
+	char name[SMEM_IMAGE_VERSION_NAME_SIZE];
+	char variant[SMEM_IMAGE_VERSION_VARIANT_SIZE];
+	char pad;
+	char oem[SMEM_IMAGE_VERSION_OEM_SIZE];
+};
+#endif /* CONFIG_DEBUG_FS */
+
 struct qcom_socinfo {
 	struct soc_device *soc_dev;
 	struct soc_device_attribute attr;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbg_root;
+	struct dentry *boot, *tz, *rpm, *apps, *mpss, *adsp, *cnss, *video;
 #endif /* CONFIG_DEBUG_FS */
 	struct socinfo *socinfo;
 };
@@ -298,8 +327,97 @@ QCOM_OPEN(pmic_model, qcom_show_pmic_model);
 QCOM_OPEN(platform_subtype, qcom_show_platform_subtype);
 QCOM_OPEN(pmic_die_revision, qcom_show_pmic_die_revision);
 
+#define IMAGE_SHOW_NAME(attr)						  \
+static int show_ ##attr## _name(struct seq_file *seq, void *p)		  \
+{									  \
+	struct smem_image_version *image_version = seq->private;	  \
+	seq_puts(seq, image_version->name);				  \
+	seq_puts(seq, "\n");						  \
+	return 0;							  \
+}									  \
+static int open_ ##attr## _name(struct inode *inode, struct file *file)	  \
+{									  \
+	return single_open(file, show_ ##attr## _name, inode->i_private); \
+}									  \
+									  \
+static const struct file_operations qcom_ ##attr## _name_ops = {	  \
+	.open = open_ ##attr## _name,					  \
+	.read = seq_read,						  \
+	.llseek = seq_lseek,						  \
+	.release = single_release,					  \
+}									  \
+
+#define DEBUGFS_IMAGE_NAME(fname, attr, index)				  \
+debugfs_create_file(__stringify(fname), 0400, qcom_socinfo->attr,	  \
+		    &smem_image_version[index], &qcom_ ##attr## _name_ops)
+
+#define IMAGE_SHOW_VARIANT(attr)					     \
+static int show_ ##attr## _variant(struct seq_file *seq, void *p)	     \
+{									     \
+	struct smem_image_version *image_version = seq->private;	     \
+	seq_puts(seq, image_version->variant);				     \
+	seq_puts(seq, "\n");						     \
+	return 0;							     \
+}									     \
+static int open_ ##attr## _variant(struct inode *inode, struct file *file)   \
+{                                                                            \
+	return single_open(file, show_ ##attr## _variant, inode->i_private); \
+}									     \
+									     \
+static const struct file_operations qcom_ ##attr## _variant_ops = {	     \
+	.open = open_ ##attr## _variant,				     \
+	.read = seq_read,						     \
+	.llseek = seq_lseek,						     \
+	.release = single_release,					     \
+}
+
+#define DEBUGFS_IMAGE_VARIANT(fname, attr, index)			    \
+debugfs_create_file(__stringify(fname), 0400, qcom_socinfo->attr,	    \
+		    &smem_image_version[index], &qcom_ ##attr## _variant_ops)
+
+#define IMAGE_SHOW_OEM(attr)						 \
+static int show_ ##attr## _oem(struct seq_file *seq, void *p)		 \
+{									 \
+	struct smem_image_version *image_version = seq->private;	 \
+	seq_puts(seq, image_version->oem);				 \
+	seq_puts(seq, "\n");						 \
+	return 0;							 \
+}									 \
+static int open_ ##attr## _oem(struct inode *inode, struct file *file)	 \
+{									 \
+	return single_open(file, show_ ##attr## _oem, inode->i_private); \
+}									 \
+									 \
+static const struct file_operations qcom_ ##attr## _oem_ops = {		 \
+	.open = open_ ##attr## _oem,					 \
+	.read = seq_read,						 \
+	.llseek = seq_lseek,						 \
+	.release = single_release,					 \
+}
+
+#define DEBUGFS_IMAGE_OEM(fname, attr, index)				 \
+debugfs_create_file(__stringify(fname), 0400, qcom_socinfo->attr,	 \
+		    &smem_image_version[index], &qcom_ ##attr## _oem_ops)
+
+#define IMAGE_SHOW(name)	  \
+	IMAGE_SHOW_NAME(name);    \
+	IMAGE_SHOW_VARIANT(name); \
+	IMAGE_SHOW_OEM(name)	  \
+
+IMAGE_SHOW(boot);
+IMAGE_SHOW(tz);
+IMAGE_SHOW(rpm);
+IMAGE_SHOW(apps);
+IMAGE_SHOW(mpss);
+IMAGE_SHOW(adsp);
+IMAGE_SHOW(cnss);
+IMAGE_SHOW(video);
+
 static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
 {
+	struct smem_image_version *smem_image_version;
+	size_t size;
+
 	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
 
 	DEBUGFS_UINT_ADD(raw_version);
@@ -314,6 +432,66 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
 	DEBUGFS_ADD(pmic_model);
 	DEBUGFS_ADD(platform_subtype);
 	DEBUGFS_ADD(pmic_die_revision);
+
+	smem_image_version = qcom_smem_get(QCOM_SMEM_HOST_ANY,
+					   SMEM_IMAGE_VERSION_TABLE,
+					   &size);
+
+	qcom_socinfo->boot = debugfs_create_dir("boot",
+						qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+
+	qcom_socinfo->tz = debugfs_create_dir("tz",
+					      qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+
+	qcom_socinfo->rpm = debugfs_create_dir("rpm",
+					       qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+
+	qcom_socinfo->apps = debugfs_create_dir("apps",
+						qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+
+	qcom_socinfo->mpss = debugfs_create_dir("mpss",
+						qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+
+	qcom_socinfo->adsp = debugfs_create_dir("adsp",
+						qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+
+	qcom_socinfo->cnss = debugfs_create_dir("cnss",
+						qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+
+	qcom_socinfo->video = debugfs_create_dir("video",
+						 qcom_socinfo->dbg_root);
+
+	DEBUGFS_IMAGE_NAME(name, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
 }
 
 static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
-- 
2.17.1

