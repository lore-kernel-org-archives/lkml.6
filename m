Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518514964-2-10159690856429597307
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514963; b=i6TXqPMpF3RHlzmxicEBKRLYEwjgznA5TafUDt4cU9cPeUa
    36AkDvUiJFXDX6Ep29NcuDbbzWCn4fArP3ueOg3w6DOr//O5ao4f0+IBK3fEahOS
    GS7e46wfCd8TyhsM5veWjdrz18t1xmoDcWHKs8wtLte58wFkEfnNl/JyRduhTt//
    AvLJhLys6xHGS9ue00iw4jE7IsKXQu82hcuEw3ulyE+0tCbbC+G/kcvTsOmiNNYG
    DUU9uPog5vlK67/Onsosz9uahlfvAjsi3Rjr/EWlhxt1Wu37485u/hRvBEAuZW0o
    uqFJ8VI3dznPv7j/CT7BXAVva/fWouQoVYwhmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514963;
    bh=NMjkhvidMC176LFRhr7Fs5oM+oYL+ntDdxYanpLX8ZI=; b=Rv7KxPbZVorU
    JF4Gc+hpxBDorM6An3hUr+yFGe8AH9yYv/O41y4XBgks07ED8z8BhWloWsrbXq2p
    9Mpkx6/6nEbxf8Ituzq23gw3CIWpy2jZI6JVQ5239p6QAu+BaV+kFmuotUr4cNej
    PQ6t2wNTXaCj9rmUJS2/co9jWwkU4RPYdmKQkdYDXAO/dHtXJdDmYlgbLrha0oWY
    xR650zzXVGHhue2l+t+zSJAwhgu1MGqDwCCDxG7/2qySmX1DWxT5nXXIFx8ckH6J
    Rx9bVe7DkXd/j32oDcfP9WTPDAu8XoMes9d7Yrg26iV8zd0710E6ZIhMMHTejgbv
    Nko8ZGjLJQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934672AbeBMJfi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:35:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:27115 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934645AbeBMJfb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889522"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: [PATCH v4 07/24] fpga: dfl: add feature device infrastructure
Date: Tue, 13 Feb 2018 17:24:36 +0800
Message-Id: <1518513893-4719-8-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xiao Guangrong <guangrong.xiao@linux.intel.com>

This patch abstracts the common operations of the sub features, and defines
the feature_ops data structure, including init, uinit and ioctl function
pointers. And this patch adds some common helper functions for FME and AFU
drivers, e.g feature_dev_use_begin/end which are used to ensure exclusive
usage of the feature device file.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Kang Luwei <luwei.kang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: rebased
v3: use const for feature_ops.
    replace pci related function.
v4: rebase and add more comments in code.
---
 drivers/fpga/dfl.c | 59 +++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 38dc819..c0aad87 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -74,6 +74,65 @@ static enum fpga_id_type feature_dev_id_type(struct platform_device *pdev)
 	return FPGA_ID_MAX;
 }
 
+void fpga_dev_feature_uinit(struct platform_device *pdev)
+{
+	struct feature *feature;
+	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	fpga_dev_for_each_feature(pdata, feature)
+		if (feature->ops) {
+			feature->ops->uinit(pdev, feature);
+			feature->ops = NULL;
+		}
+}
+EXPORT_SYMBOL_GPL(fpga_dev_feature_uinit);
+
+static int
+feature_instance_init(struct platform_device *pdev,
+		      struct feature_platform_data *pdata,
+		      struct feature *feature, struct feature_driver *drv)
+{
+	int ret;
+
+	WARN_ON(!feature->ioaddr);
+
+	ret = drv->ops->init(pdev, feature);
+	if (ret)
+		return ret;
+
+	feature->ops = drv->ops;
+
+	return ret;
+}
+
+int fpga_dev_feature_init(struct platform_device *pdev,
+			  struct feature_driver *feature_drvs)
+{
+	struct feature *feature;
+	struct feature_driver *drv = feature_drvs;
+	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	int ret;
+
+	while (drv->ops) {
+		fpga_dev_for_each_feature(pdata, feature) {
+			/* match feature and drv using id */
+			if (feature->id == drv->id) {
+				ret = feature_instance_init(pdev, pdata,
+							    feature, drv);
+				if (ret)
+					goto exit;
+			}
+		}
+		drv++;
+	}
+
+	return 0;
+exit:
+	fpga_dev_feature_uinit(pdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fpga_dev_feature_init);
+
 struct fpga_chardev_info {
 	const char *name;
 	dev_t devt;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index d6ecda1..ede1e95 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -132,6 +132,17 @@
 #define PORT_CTRL_SFTRST_ACK	BIT(4)			/* HW ack for reset */
 
 /**
+ * struct feature_driver - sub feature's driver
+ *
+ * @id:	sub feature id.
+ * @ops: ops of this sub feature.
+ */
+struct feature_driver {
+	u64 id;
+	const struct feature_ops *ops;
+};
+
+/**
  * struct feature - sub feature of the feature devices
  *
  * @id:	sub feature id.
@@ -139,13 +150,17 @@
  *		    this index is used to find its mmio resource from the
  *		    feature dev (platform device)'s reources.
  * @ioaddr: mapped mmio resource address.
+ * @ops: ops of this sub feature.
  */
 struct feature {
 	u64 id;
 	int resource_index;
 	void __iomem *ioaddr;
+	const struct feature_ops *ops;
 };
 
+#define DEV_STATUS_IN_USE	0
+
 /**
  * struct feature_platform_data - platform data for feature devices
  *
@@ -155,6 +170,8 @@ struct feature {
  * @dev: ptr to platform device linked with this platform data.
  * @disable_count: count for port disable.
  * @num: number for sub features.
+ * @dev_status: dev status (e.g DEV_STATUS_IN_USE).
+ * @private: ptr to feature dev private data.
  * @features: sub features of this feature dev.
  */
 struct feature_platform_data {
@@ -163,11 +180,44 @@ struct feature_platform_data {
 	struct cdev cdev;
 	struct platform_device *dev;
 	unsigned int disable_count;
-
+	unsigned long dev_status;
+	void *private;
 	int num;
 	struct feature features[0];
 };
 
+static inline int feature_dev_use_begin(struct feature_platform_data *pdata)
+{
+	/* Test and set IN_USE flags to ensure file is exclusively used */
+	if (test_and_set_bit_lock(DEV_STATUS_IN_USE, &pdata->dev_status))
+		return -EBUSY;
+
+	return 0;
+}
+
+static inline void feature_dev_use_end(struct feature_platform_data *pdata)
+{
+	clear_bit_unlock(DEV_STATUS_IN_USE, &pdata->dev_status);
+}
+
+static inline void
+fpga_pdata_set_private(struct feature_platform_data *pdata, void *private)
+{
+	pdata->private = private;
+}
+
+static inline void *fpga_pdata_get_private(struct feature_platform_data *pdata)
+{
+	return pdata->private;
+}
+
+struct feature_ops {
+	int (*init)(struct platform_device *pdev, struct feature *feature);
+	void (*uinit)(struct platform_device *pdev, struct feature *feature);
+	long (*ioctl)(struct platform_device *pdev, struct feature *feature,
+		      unsigned int cmd, unsigned long arg);
+};
+
 #define FPGA_FEATURE_DEV_FME		"dfl-fme"
 #define FPGA_FEATURE_DEV_PORT		"dfl-port"
 
@@ -177,6 +227,10 @@ static inline int feature_platform_data_size(const int num)
 		num * sizeof(struct feature);
 }
 
+void fpga_dev_feature_uinit(struct platform_device *pdev);
+int fpga_dev_feature_init(struct platform_device *pdev,
+			  struct feature_driver *feature_drvs);
+
 enum fpga_devt_type {
 	FPGA_DEVT_FME,
 	FPGA_DEVT_PORT,
@@ -257,6 +311,15 @@ static inline int fpga_port_reset(struct platform_device *pdev)
 	return ret;
 }
 
+static inline
+struct platform_device *fpga_inode_to_feature_dev(struct inode *inode)
+{
+	struct feature_platform_data *pdata;
+
+	pdata = container_of(inode->i_cdev, struct feature_platform_data, cdev);
+	return pdata->dev;
+}
+
 #define fpga_dev_for_each_feature(pdata, feature)			    \
 	for ((feature) = (pdata)->features;				    \
 	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
@@ -284,6 +347,17 @@ static inline void __iomem *get_feature_ioaddr_by_id(struct device *dev, u64 id)
 	return NULL;
 }
 
+static inline bool is_feature_present(struct device *dev, u64 id)
+{
+	return !!get_feature_ioaddr_by_id(dev, id);
+}
+
+static inline struct device *
+fpga_pdata_to_parent(struct feature_platform_data *pdata)
+{
+	return pdata->dev->dev.parent->parent;
+}
+
 static inline bool feature_is_fme(void __iomem *base)
 {
 	u64 v = readq(base + DFH);
@@ -376,4 +450,13 @@ fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
 
 	return pdev;
 }
+
+static inline struct fpga_cdev *
+fpga_pdata_to_fpga_cdev(struct feature_platform_data *pdata)
+{
+	struct device *dev = pdata->dev->dev.parent;
+	struct fpga_region *region = to_fpga_region(dev);
+
+	return container_of(region, struct fpga_cdev, region);
+}
 #endif /* __FPGA_DFL_H */
-- 
2.7.4

