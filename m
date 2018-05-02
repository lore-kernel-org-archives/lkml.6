Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230427-2-8457609690186296646
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230427; b=a7j4wV0e6DBIxld7DASvpNAvL4xyW3FFLV1GntypgiDbkbN5Sc
    tP/AN+JhRDCaevDfjdFXcXmvNcR/WqG63HSvvHArfB7XaGVoNFkZMabu/PMDNP19
    qHw9kvjXtu0AXmFRzwfeiX0Ux5m4337lqHbwgtUVvivaicPLTawnJO+OSZa9ClD2
    mVf7qPFfRjmkcYvgBY64gVg3CrwzqWbJtTAyGqNAKCww2QLNOG1qMbJVKUYgLSLQ
    kGoPUfWlDYSTj9U5z03dMZh5FWskNakVS6FkE5pPUMBtoXqpjNzuHA1OwpYzfeUh
    X1ExpvFoMeDVtUKWaXfBVurTsNSEGv1hXOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230427; bh=
    zFKoVYtNBMieoqpvogwnRCCBT/ZJd6bqJkywSTU/ybw=; b=gPVxYwrb/trACG9w
    u50St5YRVWRGAuOGjUSolkgoeCvuOr+tinmEQwDUB3+4DFgUPgvoxnEnIFONTY7O
    YhKVizsolXJKm2fm6nWgnh2O1Fr6N8L1wIyxDkCX7Wr/+1lrwJyBV7VuEGcKj4Xf
    Rjd+WI63k+f68HtnE6rrl04lreOiGikygTeIxVhMTOVx7LKae390yW7Y0scZV0lX
    LWULGXZj2tkCtVm24ElqMcdmKsiAcrh3LFghvjVjgT2h1lGlKAvPJ4mbAdu1CqKL
    XmAj46F6PMh5ePaB5Y4vLqVMVpbUJeNBYCDTmhZhNvlW2kFJNa5nCXnKXxHYsM5f
    XHOc1g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfHaRBqXeej9XNYLH4JcYSVtvfhhyu8aUEKO4bdIgzEGcDuEQLKsTebbmzr3TKA47vWw8X4Oa7o/8qAgaLEdjNYIeNms8YeW92jre9Ki/XPSHtaCForMl
    LNG/URye6hw82ku6D0Qe0c1llIMj0BY3bKHEcgOSvrWzlO3WL/PfoYJilB4tBNXIxPlIZurvk3ILVszkIPUvHjoAyhmM8SC8XcGNvh8CjirFHwb1rlTRAlqB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=79JVqncWIo8JHLkT62oA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeEBDGy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:06:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbeEBDCS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058440"
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
Subject: [PATCH v5 14/28] fpga: dfl: add FPGA Management Engine driver basic framework
Date: Wed,  2 May 2018 10:50:17 +0800
Message-Id: <1525229431-3087-15-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kang Luwei <luwei.kang@intel.com>

The FPGA Management Engine (FME) provides power, thermal management,
performance counters, partial reconfiguration and other functions. For each
function, it is packaged into a private feature linked to the FME feature
device in the 'Device Feature List'. It's a platform device created by
DFL framework.

This patch adds the basic framework of FME platform driver. It defines
sub feature drivers to handle the different sub features, including init,
uinit and ioctl. It also registers the file operations for the device file.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Kang Luwei <luwei.kang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v3: rename driver from intel-fpga-fme to dfl-fme
    rename Kconfig from INTEL_FPGA_FME to FPGA_DFL_FME
v4: fix SPDX license issue, use dfl-fme as module name
v5: rebase, due to DFL framework naming changes on functions and data structures.
    fix uinit order in remove function.
    remove else block in fme_ioctl function per suggestion from Alan.
---
 drivers/fpga/Kconfig        |  10 +++
 drivers/fpga/Makefile       |   3 +
 drivers/fpga/dfl-fme-main.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-main.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 87f3d44..103d5e2 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -140,6 +140,16 @@ config FPGA_DFL
 	  Gate Array (FPGA) solutions which implement Device Feature List.
 	  It provides enumeration APIs, and feature device infrastructure.
 
+config FPGA_DFL_FME
+	tristate "FPGA DFL FME Driver"
+	depends on FPGA_DFL
+	help
+	  The FPGA Management Engine (FME) is a feature device implemented
+	  under Device Feature List (DFL) framework. Select this option to
+	  enable the platform device driver for FME which implements all
+	  FPGA platform level management features. There shall be 1 FME
+	  per DFL based FPGA device.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 4375630..fbd1c85 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -30,6 +30,9 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 
 # FPGA Device Feature List Support
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
+obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
+
+dfl-fme-objs := dfl-fme-main.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
new file mode 100644
index 0000000..000651f
--- /dev/null
+++ b/drivers/fpga/dfl-fme-main.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "dfl.h"
+
+static int
+fme_hdr_init(struct platform_device *pdev, struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "FME HDR Init.\n");
+
+	return 0;
+}
+
+static void
+fme_hdr_uinit(struct platform_device *pdev, struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
+}
+
+static const struct dfl_feature_ops fme_hdr_ops = {
+	.init = fme_hdr_init,
+	.uinit = fme_hdr_uinit,
+};
+
+static struct dfl_feature_driver fme_feature_drvs[] = {
+	{
+		.id = FME_FEATURE_ID_HEADER,
+		.ops = &fme_hdr_ops,
+	},
+	{
+		.ops = NULL,
+	},
+};
+
+static int fme_open(struct inode *inode, struct file *filp)
+{
+	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
+	int ret;
+
+	if (WARN_ON(!pdata))
+		return -ENODEV;
+
+	ret = dfl_feature_dev_use_begin(pdata);
+	if (ret)
+		return ret;
+
+	dev_dbg(&fdev->dev, "Device File Open\n");
+	filp->private_data = pdata;
+
+	return 0;
+}
+
+static int fme_release(struct inode *inode, struct file *filp)
+{
+	struct dfl_feature_platform_data *pdata = filp->private_data;
+	struct platform_device *pdev = pdata->dev;
+
+	dev_dbg(&pdev->dev, "Device File Release\n");
+	dfl_feature_dev_use_end(pdata);
+
+	return 0;
+}
+
+static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct dfl_feature_platform_data *pdata = filp->private_data;
+	struct platform_device *pdev = pdata->dev;
+	struct dfl_feature *f;
+	long ret;
+
+	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
+
+	switch (cmd) {
+	default:
+		/*
+		 * Let sub-feature's ioctl function to handle the cmd
+		 * Sub-feature's ioctl returns -ENODEV when cmd is not
+		 * handled in this sub feature, and returns 0 and other
+		 * error code if cmd is handled.
+		 */
+		dfl_fpga_dev_for_each_feature(pdata, f) {
+			if (f->ops && f->ops->ioctl) {
+				ret = f->ops->ioctl(pdev, f, cmd, arg);
+				if (ret != -ENODEV)
+					return ret;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations fme_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fme_open,
+	.release	= fme_release,
+	.unlocked_ioctl = fme_ioctl,
+};
+
+static int fme_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = dfl_fpga_dev_feature_init(pdev, fme_feature_drvs);
+	if (ret)
+		goto exit;
+
+	ret = dfl_fpga_register_dev_ops(pdev, &fme_fops, THIS_MODULE);
+	if (ret)
+		goto feature_uinit;
+
+	return 0;
+
+feature_uinit:
+	dfl_fpga_dev_feature_uinit(pdev);
+exit:
+	return ret;
+}
+
+static int fme_remove(struct platform_device *pdev)
+{
+	dfl_fpga_unregister_dev_ops(pdev);
+	dfl_fpga_dev_feature_uinit(pdev);
+
+	return 0;
+}
+
+static struct platform_driver fme_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FEATURE_DEV_FME,
+	},
+	.probe   = fme_probe,
+	.remove  = fme_remove,
+};
+
+module_platform_driver(fme_driver);
+
+MODULE_DESCRIPTION("FPGA Management Engine driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme");
-- 
1.8.3.1

