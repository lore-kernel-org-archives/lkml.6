Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC579222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="un5XnrpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395414AbfBNDmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:42:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36140 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395383AbfBNDmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:42:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so2303500pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xg4rY4c1pb6aq7R6woqQpOZ6vWpXFIcJeuO6fVXJlbw=;
        b=un5XnrpJ8mYshfJn4XXRFgjMIgUdKiybP3k+g0UHyVEeCIWfAjAPEjeppC0TVNQopz
         Rmh34VpvjfyG08nXIFctMPDfYObV1OTDYYCvxvImo4TQj+tgVac7m0/6wkJTE0Be1E8Q
         GlpKud3WssEis03mAJjXobBDLhWTS4ze80bwaBBK3kV3S7NgDyC+gIbfOvUs0nx3yEL/
         93lmtc8xYMp38i2kZAKPnj99+zbjpYSdB9Mlp4d0aHEHKP++gCmeDfH+vSljSZBps7J6
         WW5tl1xUaZeHqyyJCwUogDBl8GB1kEm9UhZDvjPVigXTS5HDeWmt41OM9i8V1RqruyEv
         u0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xg4rY4c1pb6aq7R6woqQpOZ6vWpXFIcJeuO6fVXJlbw=;
        b=V6tnEWIOjLm8w1VkOBE2A9JMex212LYnthgkBYmbV4A89QCjGWr9CdPt96lRq2Hu7m
         AVwQ55lSjoVZXEMC25nfrShUlXAtCzbaMAqdJwaNtOgp05e5hHYDKdwmQPMsATiUcQLV
         yMPOeVaSgsgW6oUNka+9+VT566fD246g5CIJvr0XLy7EqtNTKObvoN4IICJB+fZcbpQd
         StY8f6gXhBv20GZPeMV7gWCoYPjtOYmsVeHcUZIMlVN3n4vrr2qr1J2BnOp1CGJkt6yg
         7l0Alp+aNtNPHqEJ4cP+nYwkw2CBu5Hv3LBzo3X449VhZAw23SrihXT6LXxwSRax3ASx
         qHDw==
X-Gm-Message-State: AHQUAuaWpRSa0akATjKHBquzPjHUmpBDUGO+IJ9lJ4IDENMSbf5waGMJ
        q5ZQNi7yS7dEPqGUUYwasELgXw==
X-Google-Smtp-Source: AHgI3IZQHvXDnMGhdvfdtfoZZycaVOr80X+LrNDxlL7VTHiQv/vBGvBj8GzMWWit/xW//0FANsWV0A==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr1709281pgk.386.1550115732576;
        Wed, 13 Feb 2019 19:42:12 -0800 (PST)
Received: from localhost.localdomain ([103.240.171.178])
        by smtp.gmail.com with ESMTPSA id l81sm1221255pfg.100.2019.02.13.19.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 19:42:12 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH 4/5] soc: qcom: socinfo: Expose image information
Date:   Thu, 14 Feb 2019 09:12:05 +0530
Message-Id: <eb76f276c935088de0853d3f013c1f0692a700cc.1550114271.git.vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550114271.git.vaishali.thakkar@linaro.org>
References: <cover.1550114271.git.vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The socinfo driver provides information about version of the various
images loaded in the system. Expose this to user space for debugging
purpose.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 210 +++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 58665067beb8..fb5a3cabe42a 100644
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
 
 	if (!qcom_socinfo->dbg_root) {
@@ -319,6 +437,98 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
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
+	if (!qcom_socinfo->boot) {
+		pr_err("Cannot create boot image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, boot, SMEM_IMAGE_TABLE_BOOT_INDEX);
+
+	qcom_socinfo->tz = debugfs_create_dir("tz",
+					      qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->tz) {
+		pr_err("Cannot create tz image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, tz, SMEM_IMAGE_TABLE_TZ_INDEX);
+
+	qcom_socinfo->rpm = debugfs_create_dir("rpm",
+					       qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->rpm) {
+		pr_err("Cannot create rpm image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, rpm, SMEM_IMAGE_TABLE_RPM_INDEX);
+
+	qcom_socinfo->apps = debugfs_create_dir("apps",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->apps) {
+		pr_err("Cannot create apps image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, apps, SMEM_IMAGE_TABLE_APPS_INDEX);
+
+	qcom_socinfo->mpss = debugfs_create_dir("mpss",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->mpss) {
+		pr_err("Cannot create mpss image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, mpss, SMEM_IMAGE_TABLE_MPSS_INDEX);
+
+	qcom_socinfo->adsp = debugfs_create_dir("adsp",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->adsp) {
+		pr_err("Cannot create adsp image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, adsp, SMEM_IMAGE_TABLE_ADSP_INDEX);
+
+	qcom_socinfo->cnss = debugfs_create_dir("cnss",
+						qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->cnss) {
+		pr_err("Cannot create cnss image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, cnss, SMEM_IMAGE_TABLE_CNSS_INDEX);
+
+	qcom_socinfo->video = debugfs_create_dir("video",
+						 qcom_socinfo->dbg_root);
+	if (!qcom_socinfo->video) {
+		pr_err("Cannot create video image directory\n");
+		return;
+	}
+
+	DEBUGFS_IMAGE_NAME(name, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
+	DEBUGFS_IMAGE_VARIANT(variant, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
+	DEBUGFS_IMAGE_OEM(oem, video, SMEM_IMAGE_TABLE_VIDEO_INDEX);
 }
 
 static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
-- 
2.17.1

