Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230275-4-1092885759788669028
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230275; b=VklenjwTRsyTH1wrodBmhImQ7tPBnwkEbta1+f9wGDNXuKvfJf
    hKC7m56EhmRM/FPH+jAY2EB9s2xRyMrikNLTqHTQWaRnWyXtH+qSxuNcRhDbsvge
    kgpIhxX6Ge79x7uovn4rNDlB+2Tbgfl+zBPPBjDaM5Q4EPHxE6JYZ/RMzGesTTuc
    8Ga4wDRqXPqK7SwugpKXcw371Nc7HAdn7AsCvNI4Z3nr3VkT7K1PZUR7PgSV5d3c
    4R1tt6huvPd4bbN+IZvIlvjiWYESTI2WfUVxXsVSzTl+iYtyXu/Sw06Yf+Ydwb+I
    0Pk9ZwMB6FBr81Chfs+PTQ/JhktU6g+LiyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230275; bh=
    nTn3Lif41TOwgWOBoCsYAZkAgkGtkULsVbx0j+d1L1M=; b=ixGMmDF8ONuV4q5u
    yDZipk2LPVD5D0HB+26C8pFhInNa7xFcqCHYTlNScIWDXc8Y14DFhSgfieEq9m+u
    OZ10hb+ytnsav9k8jEVckF0l4CR3c/E77mYqSMtCeZHpjtBE6N3h2SIIxtt3+4Yx
    W6JpVowkiq97KKkxAoCx3VvTFzv9ZaF1roPq7W+FC6F8yIF167764wYF+3Pc3SM+
    T3ePb4vNzf1d/ogekbEkj5GCBol4dUrhNRLGLsyvNNcr4X7bTXJhdu8zvqe4UTxL
    IQGC5eU4FWRMLQBBd4ke0MsQv6iJLCtGTm8g5FT2tgSJpKJvxupXWpymlMukZ/gX
    w1SOLg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfPheVj3QgpLCwx5JV3bqrs2BTuFIU/sSb/zyxXcQ9SVG56W60LNWdGdxEPu20UmWBK9uMDJL/3+G9pCXrZBTt86Ot+i7/dv10BtBx4nW68Q4uZyC2w1p
    /LYeLeHbF28S9zRoQuE6uWvd5Ce4xPzu0ZLz7fs75sfdzXDaX6iCI24E2NZvtV7ql07cQAuyJYyvOvRVUNXDb8SWATyDv6sn/kVfnt93Xn7ijHRFNLFb+S/Q
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=79JVqncWIo8JHLkT62oA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeEBDCq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751566AbeEBDCn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058583"
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
Subject: [PATCH v5 23/28] fpga: dfl: add FPGA Accelerated Function Unit driver basic framework
Date: Wed,  2 May 2018 10:50:26 +0800
Message-Id: <1525229431-3087-24-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On DFL FPGA devices, the Accelerated Function Unit (AFU), can be
reprogrammed for different functions. It connects to the FPGA
infrastructure (static FPGA region) via a Port. Port CSRs are
implemented separately from the AFU CSRs to provide control and
status of the Port. Once valid PR bitstream is programmed into
the AFU, it allows access to the AFU CSRs in the AFU MMIO space.

This patch only implements basic driver framework for AFU, including
device file operation framework.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: rename driver to dfl-afu-main.c
v4: rename to dfl-port and fix SPDX license issue.
v5: rebase, and add Acked-by from Alan.
    fix uinit order in remove function.
---
 drivers/fpga/Kconfig        |   9 +++
 drivers/fpga/Makefile       |   2 +
 drivers/fpga/dfl-afu-main.c | 162 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/fpga/dfl-afu-main.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 65d54a4..4c6b45f 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -168,6 +168,15 @@ config FPGA_DFL_FME_REGION
 	help
 	  Say Y to enable FPGA Region driver for FPGA Management Engine.
 
+config FPGA_DFL_AFU
+	tristate "FPGA DFL AFU Driver"
+	depends on FPGA_DFL
+	help
+	  This is the driver for FPGA Accelerated Function Unit (AFU) which
+	  implements AFU and Port management features. A User AFU connects
+	  to the FPGA infrastructure via a Port. There may be more than 1
+	  Port/AFU per DFL based FPGA device.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 163894e..5c9607b 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -34,8 +34,10 @@ obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
 obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
 obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
+obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
+dfl-afu-objs := dfl-afu-main.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
new file mode 100644
index 0000000..35bec47
--- /dev/null
+++ b/drivers/fpga/dfl-afu-main.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Accelerated Function Unit (AFU)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
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
+static int port_hdr_init(struct platform_device *pdev,
+			 struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
+
+	return 0;
+}
+
+static void port_hdr_uinit(struct platform_device *pdev,
+			   struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
+}
+
+static const struct dfl_feature_ops port_hdr_ops = {
+	.init = port_hdr_init,
+	.uinit = port_hdr_uinit,
+};
+
+static struct dfl_feature_driver port_feature_drvs[] = {
+	{
+		.id = PORT_FEATURE_ID_HEADER,
+		.ops = &port_hdr_ops,
+	},
+	{
+		.ops = NULL,
+	}
+};
+
+static int afu_open(struct inode *inode, struct file *filp)
+{
+	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
+	struct dfl_feature_platform_data *pdata;
+	int ret;
+
+	pdata = dev_get_platdata(&fdev->dev);
+	if (WARN_ON(!pdata))
+		return -ENODEV;
+
+	ret = dfl_feature_dev_use_begin(pdata);
+	if (ret)
+		return ret;
+
+	dev_dbg(&fdev->dev, "Device File Open\n");
+	filp->private_data = fdev;
+
+	return 0;
+}
+
+static int afu_release(struct inode *inode, struct file *filp)
+{
+	struct platform_device *pdev = filp->private_data;
+	struct dfl_feature_platform_data *pdata;
+
+	dev_dbg(&pdev->dev, "Device File Release\n");
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	dfl_feature_dev_use_end(pdata);
+
+	return 0;
+}
+
+static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct platform_device *pdev = filp->private_data;
+	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature *f;
+	long ret;
+
+	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
+
+	pdata = dev_get_platdata(&pdev->dev);
+
+	switch (cmd) {
+	default:
+		/*
+		 * Let sub-feature's ioctl function to handle the cmd
+		 * Sub-feature's ioctl returns -ENODEV when cmd is not
+		 * handled in this sub feature, and returns 0 and other
+		 * error code if cmd is handled.
+		 */
+		dfl_fpga_dev_for_each_feature(pdata, f)
+			if (f->ops && f->ops->ioctl) {
+				ret = f->ops->ioctl(pdev, f, cmd, arg);
+				if (ret != -ENODEV)
+					return ret;
+			}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations afu_fops = {
+	.owner = THIS_MODULE,
+	.open = afu_open,
+	.release = afu_release,
+	.unlocked_ioctl = afu_ioctl,
+};
+
+static int afu_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	ret = dfl_fpga_dev_feature_init(pdev, port_feature_drvs);
+	if (ret)
+		return ret;
+
+	ret = dfl_fpga_register_dev_ops(pdev, &afu_fops, THIS_MODULE);
+	if (ret)
+		dfl_fpga_dev_feature_uinit(pdev);
+
+	return ret;
+}
+
+static int afu_remove(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	dfl_fpga_unregister_dev_ops(pdev);
+	dfl_fpga_dev_feature_uinit(pdev);
+
+	return 0;
+}
+
+static struct platform_driver afu_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FEATURE_DEV_PORT,
+	},
+	.probe   = afu_probe,
+	.remove  = afu_remove,
+};
+
+module_platform_driver(afu_driver);
+
+MODULE_DESCRIPTION("FPGA Accelerated Function Unit driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-port");
-- 
1.8.3.1

