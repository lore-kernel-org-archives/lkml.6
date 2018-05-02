Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230452-2-14140936987199844463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230451; b=NjXj9eXi64xNpbxXKlRSI0VfYTcB2k5u25VMHTgATLS06Omyav
    U3hJ1yWDohC6nFYmlwo2PcWdnP1qJ3l7CjOvVLU4jH1ME1h/iMcTcj/9M+AYjb1b
    SBivQp1quJHuBZdQduxd62+Q8BnYggDhQJikRPmSaeI+MAs37feBoC0tk7g06U/f
    9MrFxTjA8NTXmSQ6Gqv909X/Ph5VynEJkVwv2Y8+QnK9UuDiMxNzvMZ3ZeMKdijH
    stU5WHdFW6quov4IUN+7qMlohKyYQLC9msXs7RrtLRvmvmLIuUDZ4Y4YZEjlKy9+
    q3aS2HcnhgfdBpn7OlTVBHC8sLLtHRUHFfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230451; bh=
    zptyfvRHeJajx4QDlBmjQaj24T3IuGIaLEhAgcJ4n7Y=; b=GCznyfXB4ARApIxO
    hHOr74CHd7YJaMQh5z0DuVlLZjpg5MbvvEF+w1awMMLiuRIwbasVZBro0YYyStiG
    WrE5I6TTZSSizNNen0xI4BOF9VoZI34C5RapmbAw4h05oWHl081tOD0jCe/xz8Lr
    coX3zNhRi+fI3P3UQP9AMWkNww5T0YjJ2s3R+5Sk/jmVJ3Z4SnVsn0JqXrZ8LfgN
    IKP72ohDugkvuspIPejUOVM1zUyYclqFCKDdqsKNYsfki7TkQCi8kVD0L0ZvO08j
    /qUfhKc0hnNF8hMq0H7ioItNzB5nohMYiNqCP1oqYa8VT7LP86tAPJ5MWT656If1
    tvQWIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGXrILP/OiZxvdSL/elVqAl0n2Y7iMB0czoSuNvguvzbSVfGGXdv4F620AZAnG4q0Axn70umsY/BUOUHxfjgYbQxIg0ZBAqSpVT7S34BYnywxUpYuzV/
    s1T2/fLbJoJR97wRg6F00FsRre69efPMj1dxzbQmCgXd/mjtWtPcqQWu8g2tJeS4M5Chh5aCQIh7xIBVGqjkW3ZMremIvCEs3p+9w+tSMdIFmaBYhXVbuiKi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=JTlATmAMCTYC0VwvBLUA:9 a=Yc-Yg7Cx14ZT41TE:21
    a=t7KAz4x-NNlwKBMK:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEBDCH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:63837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeEBDCE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058342"
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
Subject: [PATCH v5 09/28] fpga: dfl: add feature device infrastructure
Date: Wed,  2 May 2018 10:50:12 +0800
Message-Id: <1525229431-3087-10-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xiao Guangrong <guangrong.xiao@linux.intel.com>

This patch abstracts the common operations of the sub features, and defines
the feature_ops data structure, including init, uinit and ioctl function
pointers. And this patch adds some common helper functions for FME and AFU
drivers, e.g dfl_feature_dev_use_begin/end which are used to ensure
exclusive usage of the feature device file.

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
v5: remove useless WARN_ON().
    reorder declarations in functions per suggestion from Moritz.
    add "dfl_" prefix to functions and data structure.
---
 drivers/fpga/dfl.c | 57 +++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 1e06efb..c4c47d6 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -74,6 +74,63 @@ static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
 	return DFL_ID_MAX;
 }
 
+void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature *feature;
+
+	dfl_fpga_dev_for_each_feature(pdata, feature)
+		if (feature->ops) {
+			feature->ops->uinit(pdev, feature);
+			feature->ops = NULL;
+		}
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
+
+static int dfl_feature_instance_init(struct platform_device *pdev,
+				     struct dfl_feature_platform_data *pdata,
+				     struct dfl_feature *feature,
+				     struct dfl_feature_driver *drv)
+{
+	int ret;
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
+int dfl_fpga_dev_feature_init(struct platform_device *pdev,
+			      struct dfl_feature_driver *feature_drvs)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_driver *drv = feature_drvs;
+	struct dfl_feature *feature;
+	int ret;
+
+	while (drv->ops) {
+		dfl_fpga_dev_for_each_feature(pdata, feature) {
+			/* match feature and drv using id */
+			if (feature->id == drv->id) {
+				ret = dfl_feature_instance_init(pdev, pdata,
+								feature, drv);
+				if (ret)
+					goto exit;
+			}
+		}
+		drv++;
+	}
+
+	return 0;
+exit:
+	dfl_fpga_dev_feature_uinit(pdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init);
+
 struct dfl_chardev_info {
 	const char *name;
 	dev_t devt;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2b6aaef..27f7a74 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -132,6 +132,17 @@
 #define PORT_CTRL_SFTRST_ACK	BIT_ULL(4)		/* HW ack for reset */
 
 /**
+ * struct dfl_feature_driver - sub feature's driver
+ *
+ * @id: sub feature id.
+ * @ops: ops of this sub feature.
+ */
+struct dfl_feature_driver {
+	u64 id;
+	const struct dfl_feature_ops *ops;
+};
+
+/**
  * struct dfl_feature - sub feature of the feature devices
  *
  * @id: sub feature id.
@@ -139,13 +150,17 @@
  *		    this index is used to find its mmio resource from the
  *		    feature dev (platform device)'s reources.
  * @ioaddr: mapped mmio resource address.
+ * @ops: ops of this sub feature.
  */
 struct dfl_feature {
 	u64 id;
 	int resource_index;
 	void __iomem *ioaddr;
+	const struct dfl_feature_ops *ops;
 };
 
+#define DEV_STATUS_IN_USE	0
+
 /**
  * struct dfl_feature_platform_data - platform data for feature devices
  *
@@ -156,6 +171,8 @@ struct dfl_feature {
  * @dfl_cdev: ptr to container device.
  * @disable_count: count for port disable.
  * @num: number for sub features.
+ * @dev_status: dev status (e.g DEV_STATUS_IN_USE).
+ * @private: ptr to feature dev private data.
  * @features: sub features of this feature dev.
  */
 struct dfl_feature_platform_data {
@@ -165,11 +182,49 @@ struct dfl_feature_platform_data {
 	struct platform_device *dev;
 	struct dfl_fpga_cdev *dfl_cdev;
 	unsigned int disable_count;
-
+	unsigned long dev_status;
+	void *private;
 	int num;
 	struct dfl_feature features[0];
 };
 
+static inline
+int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata)
+{
+	/* Test and set IN_USE flags to ensure file is exclusively used */
+	if (test_and_set_bit_lock(DEV_STATUS_IN_USE, &pdata->dev_status))
+		return -EBUSY;
+
+	return 0;
+}
+
+static inline
+void dfl_feature_dev_use_end(struct dfl_feature_platform_data *pdata)
+{
+	clear_bit_unlock(DEV_STATUS_IN_USE, &pdata->dev_status);
+}
+
+static inline
+void dfl_fpga_pdata_set_private(struct dfl_feature_platform_data *pdata,
+				void *private)
+{
+	pdata->private = private;
+}
+
+static inline
+void *dfl_fpga_pdata_get_private(struct dfl_feature_platform_data *pdata)
+{
+	return pdata->private;
+}
+
+struct dfl_feature_ops {
+	int (*init)(struct platform_device *pdev, struct dfl_feature *feature);
+	void (*uinit)(struct platform_device *pdev,
+		      struct dfl_feature *feature);
+	long (*ioctl)(struct platform_device *pdev, struct dfl_feature *feature,
+		      unsigned int cmd, unsigned long arg);
+};
+
 #define DFL_FPGA_FEATURE_DEV_FME		"dfl-fme"
 #define DFL_FPGA_FEATURE_DEV_PORT		"dfl-port"
 
@@ -179,6 +234,10 @@ static inline int dfl_feature_platform_data_size(const int num)
 		num * sizeof(struct dfl_feature);
 }
 
+void dfl_fpga_dev_feature_uinit(struct platform_device *pdev);
+int dfl_fpga_dev_feature_init(struct platform_device *pdev,
+			      struct dfl_feature_driver *feature_drvs);
+
 enum dfl_fpga_devt_type {
 	DFL_FPGA_DEVT_FME,
 	DFL_FPGA_DEVT_PORT,
@@ -190,6 +249,16 @@ int dfl_fpga_register_dev_ops(struct platform_device *pdev,
 			      struct module *owner);
 void dfl_fpga_unregister_dev_ops(struct platform_device *pdev);
 
+static inline
+struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
+{
+	struct dfl_feature_platform_data *pdata;
+
+	pdata = container_of(inode->i_cdev, struct dfl_feature_platform_data,
+			     cdev);
+	return pdata->dev;
+}
+
 #define dfl_fpga_dev_for_each_feature(pdata, feature)			    \
 	for ((feature) = (pdata)->features;				    \
 	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
@@ -219,6 +288,17 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
 	return NULL;
 }
 
+static inline bool is_dfl_feature_present(struct device *dev, u64 id)
+{
+	return !!dfl_get_feature_ioaddr_by_id(dev, id);
+}
+
+static inline
+struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
+{
+	return pdata->dev->dev.parent->parent;
+}
+
 static inline bool dfl_feature_is_fme(void __iomem *base)
 {
 	u64 v = readq(base + DFH);
-- 
1.8.3.1

