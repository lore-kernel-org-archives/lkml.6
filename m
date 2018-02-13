Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845453-1518515094-2-6803005467633455355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518515093; b=IZb6gSzHsOdq1O/MV1J2O4ar+cFkGpZufjbsPZclT3dJHGI
    cCqE0AuKS7OGFGX5sUAh+CcvOXOFt5qeAiuDHrIwMVh6xj3jurrNpmjwnpx1g5kq
    xE6QjpBDVQOUNw40sKNs2sYnX1nQdc7pkgLLgO6+StnK01ana1TWTBsrHyLiuNBn
    HmyzdNyKN60sPYsKyzPx7kuXWtq0qWQWh/MZks77b2VoCnkh1yf+MckKAV4VDkKJ
    2v9amUinc+PmrOGNOL0qi2fHKTZNC3sCa9WJRZdO3mF3Iy7RcAfPlVT7eZm7nW91
    gRGcxu+7XfWspgyg3JnNr3NC5V75niYGPSaK97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518515093;
    bh=HOCJh99u/KW0D2rwcBH4ZJh74ZLZtlnIS9kJcJ36vqA=; b=BHUErdLGRPlY
    NMQDPCRwg++jifgfY0HDv3Khw/y2mFF7vDCylyX2dUXqlqe2YulUpxmB/2RbAl2b
    HfFbLAYKhs1nfxPM5rXU55GHmR3ETnvmZHXl05zZMM7Kcc7rXz5QdTe4VjYMH4uM
    Z3UN7kSQd+H4l6tQeWWAGIaCCNJ8ybNuc1D57iFYJNjR/7NLwm8TusItFyPYLmuP
    SxIvtD0EYJRYX1zFUuSu/58hAQkztQWVX5aim4JEMakIyiF/wow0ll4nXGOLxRcK
    S5KTMrF5PXnI1oNZU//jMCfebF03nJaYTAZawGPHY3FbqrRZ1PGMq/DMnR7aUUoh
    xK+WNfMHSg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeBMJoA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:44:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:27121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934582AbeBMJf0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889507"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v4 05/24] fpga: dfl: add chardev support for feature devices
Date: Tue, 13 Feb 2018 17:24:34 +0800
Message-Id: <1518513893-4719-6-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For feature devices drivers, both the FPGA Management Engine (FME) and
Accelerated Function Unit (AFU) driver need to expose user interfaces via
the device file, for example, mmap and ioctls.

This patch adds chardev support in the dfl driver for feature devices,
FME and AFU. It reserves the chardev regions for FME and AFU, and provide
interfaces for FME and AFU driver to register their device file operations.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: rebased
v3: move chardev support to fpga-dfl framework
v4: rebase, and add more comments in code.
---
 drivers/fpga/dfl.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/fpga/dfl.h |  14 ++++++++
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index f50694e..dcfe5ab 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -74,6 +74,96 @@ static enum fpga_id_type feature_dev_id_type(struct platform_device *pdev)
 	return FPGA_ID_MAX;
 }
 
+struct fpga_chardev_info {
+	const char *name;
+	dev_t devt;
+};
+
+/* indexed by enum fpga_devt_type */
+struct fpga_chardev_info fpga_chrdevs[] = {
+	{.name = FPGA_FEATURE_DEV_FME},		/* FPGA_DEVT_FME */
+	{.name = FPGA_FEATURE_DEV_PORT},	/* FPGA_DEVT_AFU */
+};
+
+static void fpga_chardev_uinit(void)
+{
+	int i;
+
+	for (i = 0; i < FPGA_DEVT_MAX; i++)
+		if (MAJOR(fpga_chrdevs[i].devt)) {
+			unregister_chrdev_region(fpga_chrdevs[i].devt,
+						 MINORMASK);
+			fpga_chrdevs[i].devt = MKDEV(0, 0);
+		}
+}
+
+static int fpga_chardev_init(void)
+{
+	int i, ret;
+
+	for (i = 0; i < FPGA_DEVT_MAX; i++) {
+		ret = alloc_chrdev_region(&fpga_chrdevs[i].devt, 0, MINORMASK,
+					  fpga_chrdevs[i].name);
+		if (ret)
+			goto exit;
+	}
+
+	return 0;
+
+exit:
+	fpga_chardev_uinit();
+	return ret;
+}
+
+static dev_t fpga_get_devt(enum fpga_devt_type type, int id)
+{
+	WARN_ON(type >= FPGA_DEVT_MAX);
+
+	return MKDEV(MAJOR(fpga_chrdevs[type].devt), id);
+}
+
+/**
+ * fpga_register_dev_ops - register cdev ops for feature dev
+ *
+ * @pdev: feature dev.
+ * @fops: file operations for feature dev's cdev.
+ * @owner: owning module/driver.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int fpga_register_dev_ops(struct platform_device *pdev,
+			  const struct file_operations *fops,
+			  struct module *owner)
+{
+	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	cdev_init(&pdata->cdev, fops);
+	pdata->cdev.owner = owner;
+
+	/*
+	 * set parent to the feature device so that its refcount is
+	 * decreased after the last refcount of cdev is gone, that
+	 * makes sure the feature device is valid during device
+	 * file's life-cycle.
+	 */
+	pdata->cdev.kobj.parent = &pdev->dev.kobj;
+
+	return cdev_add(&pdata->cdev, pdev->dev.devt, 1);
+}
+EXPORT_SYMBOL_GPL(fpga_register_dev_ops);
+
+/**
+ * fpga_unregister_dev_ops - unregister cdev ops for feature dev
+ * @pdev: feature dev.
+ */
+void fpga_unregister_dev_ops(struct platform_device *pdev)
+{
+	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	cdev_del(&pdata->cdev);
+}
+EXPORT_SYMBOL_GPL(fpga_unregister_dev_ops);
+
 /**
  * struct build_feature_devs_info - info collected during feature dev build.
  *
@@ -207,8 +297,12 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
 		      void __iomem *ioaddr)
 {
 	struct platform_device *fdev;
+	enum fpga_devt_type devt_type = FPGA_DEVT_FME;
 	int ret;
 
+	if (type == PORT_ID)
+		devt_type = FPGA_DEVT_PORT;
+
 	/* we will create a new device, commit current device first */
 	ret = build_info_commit_dev(binfo);
 	if (ret)
@@ -232,6 +326,7 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
 		return fdev->id;
 
 	fdev->dev.parent = &binfo->cdev->region.dev;
+	fdev->dev.devt = fpga_get_devt(devt_type, fdev->id);
 
 	return 0;
 }
@@ -769,13 +864,20 @@ EXPORT_SYMBOL_GPL(__fpga_port_disable);
 
 static int __init dfl_fpga_init(void)
 {
+	int ret;
+
 	fpga_ids_init();
 
-	return 0;
+	ret = fpga_chardev_init();
+	if (ret)
+		fpga_ids_destroy();
+
+	return ret;
 }
 
 static void __exit dfl_fpga_exit(void)
 {
+	fpga_chardev_uinit();
 	fpga_ids_destroy();
 }
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 22dcf73..9b19399 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -15,6 +15,7 @@
 #define __FPGA_DFL_H
 
 #include <linux/bitfield.h>
+#include <linux/cdev.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/iopoll.h>
@@ -150,6 +151,7 @@ struct feature {
  *
  * @node: node to link feature devs to container device's port_dev_list.
  * @lock: mutex to protect platform data.
+ * @cdev: cdev of feature dev.
  * @dev: ptr to platform device linked with this platform data.
  * @disable_count: count for port disable.
  * @num: number for sub features.
@@ -158,6 +160,7 @@ struct feature {
 struct feature_platform_data {
 	struct list_head node;
 	struct mutex lock;
+	struct cdev cdev;
 	struct platform_device *dev;
 	unsigned int disable_count;
 
@@ -174,6 +177,17 @@ static inline int feature_platform_data_size(const int num)
 		num * sizeof(struct feature);
 }
 
+enum fpga_devt_type {
+	FPGA_DEVT_FME,
+	FPGA_DEVT_PORT,
+	FPGA_DEVT_MAX,
+};
+
+int fpga_register_dev_ops(struct platform_device *pdev,
+			  const struct file_operations *fops,
+			  struct module *owner);
+void fpga_unregister_dev_ops(struct platform_device *pdev);
+
 int fpga_port_id(struct platform_device *pdev);
 
 static inline int fpga_port_check_id(struct platform_device *pdev,
-- 
2.7.4

