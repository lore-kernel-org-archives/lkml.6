Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230156-2-1874639548460040772
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230155; b=bq4M48Mdh/npNTm5lrD9UOseoWtYK89YNOxVjAT0CPB2mBbfT7
    bjzI/wiK/aYys5iAzLAZFcSE1J3ZCmJBtHLAFyIcOjDgV6jOnoHGoIPPQdMzGxuZ
    hfDkmPuTxK3cT+49JZfRd30sOU73cW82QdS1SNmr2lVByD4HCu5tfDmL19G3NZgJ
    WH+L9zKb8XeVAT7bcDDIz5CLSS1Fwe465oeNRpL1MZr4DZ/+tyjAgY1Pw9SzqVVq
    HOA8vqg84NhlYpI6zCGkSeGPnhtIgwVzBJw/dRslUqfTdN3e8VY27V1TpRlFDznW
    hTfONVUr4aDpNadOxOvlxL8Q5eSyevXVGm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230155; bh=
    qXSrC0CXMYUaft6lG0HKVIp98n3qQ+xLOrT0TEVtij8=; b=FQdsb8jCQNYE7TFO
    sDe7s74fFO90umRISiH/c+aAODrp5EGgWcE8E2bzJLxgDHBVPQxwDdQ51NQ/Pkkg
    eo64VnXTW1x3jgOgN68Ug4Sc4lXxhuVFtJ2VRzmTMZgVUTI336xEpLf5TWQ9kSiZ
    MKdmd24Tm7o4RYvTH7nPttyne3qCKYFaMaPtJnsLaS9eovl+Kp7HypPQwrOn7L9H
    TCklK7klWTqUbpaZGnW8In1MmIWRDaqIdL7q8QzamuMtDCqEreya5J58LuDWuWkk
    wFpjwLQtNaRL+4X2e8IS+P9jGS5IlKwyVVDHqdeJ12FSRI4wEpbY7FYip1qTf5Bc
    8Buvng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfMw5rfzd4UFTVeCNu5QsodriKjgzvbhU2/qsfhvU0VB1GtEnUyU6DpmzZG1zBRBWV/eXrTjBFqg4XYjS5RNoYw3WXk9do8fRCqI2LKYBd2Gq+qCxlK39
    FzH8T9zl3pVaUxqt+cwkVopYTSUm2PQE3D6dCFe7AwTZ3bEW0H3PsHS4OEPiGTkak5JnsuXg3YtRIFbTioHNZkXH2z3Mxv5x0lXEEZ15dR0k7+rVHotiYMHE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=lJpfL41uxGJThJ7ETXwA:9 a=_2obfiPFyAn6aJBV:21
    a=sSaer8ibiOj1ens4:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeEBDCc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbeEBDCa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058508"
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
Subject: [PATCH v5 18/28] fpga: dfl: add fpga manager platform driver for FME
Date: Wed,  2 May 2018 10:50:21 +0800
Message-Id: <1525229431-3087-19-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds fpga manager driver for FPGA Management Engine (FME). It
implements fpga_manager_ops for FPGA Partial Reconfiguration function.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Kang Luwei <luwei.kang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v3: rename driver to dfl-fpga-fme-mgr
    implemented status callback for fpga manager
    rebased due to fpga api changes
v4: rename to dfl-fme-mgr, and fix SPDX license issue
    add pr_credit comments and improve dev_err message
    remove interface_id sysfs interface
    include dfl-fme-pr.h instead of dfl.h
v5: move related register definition from dfl-fme-pr.h to dfl-fme-mgr.c
    use mapped ioaddr passed via pdata for register access.
    rebase due to fpga manager API changes.
    include header file for readq/writeq.
---
 drivers/fpga/Kconfig       |   6 +
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/dfl-fme-mgr.c | 334 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-mgr.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 103d5e2..89f76e8 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -150,6 +150,12 @@ config FPGA_DFL_FME
 	  FPGA platform level management features. There shall be 1 FME
 	  per DFL based FPGA device.
 
+config FPGA_DFL_FME_MGR
+	tristate "FPGA DFL FME Manager Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Manager driver for FPGA Management Engine.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 3c44fc9..f82814a 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 # FPGA Device Feature List Support
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
 obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
+obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
new file mode 100644
index 0000000..1c5bc5a
--- /dev/null
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Manager Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Wu Hao <hao.wu@intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Christopher Rauer <christopher.rauer@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/iopoll.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/fpga/fpga-mgr.h>
+
+#include "dfl-fme-pr.h"
+
+/* FME Partial Reconfiguration Sub Feature Register Set */
+#define FME_PR_DFH		0x0
+#define FME_PR_CTRL		0x8
+#define FME_PR_STS		0x10
+#define FME_PR_DATA		0x18
+#define FME_PR_ERR		0x20
+#define FME_PR_INTFC_ID_H	0xA8
+#define FME_PR_INTFC_ID_L	0xB0
+
+/* FME PR Control Register Bitfield */
+#define FME_PR_CTRL_PR_RST	BIT_ULL(0)  /* Reset PR engine */
+#define FME_PR_CTRL_PR_RSTACK	BIT_ULL(4)  /* Ack for PR engine reset */
+#define FME_PR_CTRL_PR_RGN_ID	GENMASK_ULL(9, 7)       /* PR Region ID */
+#define FME_PR_CTRL_PR_START	BIT_ULL(12) /* Start to request PR service */
+#define FME_PR_CTRL_PR_COMPLETE	BIT_ULL(13) /* PR data push completion */
+
+/* FME PR Status Register Bitfield */
+/* Number of available entries in HW queue inside the PR engine. */
+#define FME_PR_STS_PR_CREDIT	GENMASK_ULL(8, 0)
+#define FME_PR_STS_PR_STS	BIT_ULL(16) /* PR operation status */
+#define FME_PR_STS_PR_STS_IDLE	0
+#define FME_PR_STS_PR_CTRLR_STS	GENMASK_ULL(22, 20)     /* Controller status */
+#define FME_PR_STS_PR_HOST_STS	GENMASK_ULL(27, 24)     /* PR host status */
+
+/* FME PR Data Register Bitfield */
+/* PR data from the raw-binary file. */
+#define FME_PR_DATA_PR_DATA_RAW	GENMASK_ULL(32, 0)
+
+/* FME PR Error Register */
+/* PR Operation errors detected. */
+#define FME_PR_ERR_OPERATION_ERR	BIT_ULL(0)
+/* CRC error detected. */
+#define FME_PR_ERR_CRC_ERR		BIT_ULL(1)
+/* Incompatible PR bitstream detected. */
+#define FME_PR_ERR_INCOMPATIBLE_BS	BIT_ULL(2)
+/* PR data push protocol violated. */
+#define FME_PR_ERR_PROTOCOL_ERR		BIT_ULL(3)
+/* PR data fifo overflow error detected */
+#define FME_PR_ERR_FIFO_OVERFLOW	BIT_ULL(4)
+
+#define PR_WAIT_TIMEOUT   8000000
+#define PR_HOST_STATUS_IDLE	0
+
+struct fme_mgr_priv {
+	void __iomem *ioaddr;
+	u64 pr_error;
+};
+
+static u64 pr_error_to_mgr_status(u64 err)
+{
+	u64 status = 0;
+
+	if (err & FME_PR_ERR_OPERATION_ERR)
+		status |= FPGA_MGR_STATUS_OPERATION_ERR;
+	if (err & FME_PR_ERR_CRC_ERR)
+		status |= FPGA_MGR_STATUS_CRC_ERR;
+	if (err & FME_PR_ERR_INCOMPATIBLE_BS)
+		status |= FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR;
+	if (err & FME_PR_ERR_PROTOCOL_ERR)
+		status |= FPGA_MGR_STATUS_IP_PROTOCOL_ERR;
+	if (err & FME_PR_ERR_FIFO_OVERFLOW)
+		status |= FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR;
+
+	return status;
+}
+
+static u64 fme_mgr_pr_error_handle(void __iomem *fme_pr)
+{
+	u64 pr_status, pr_error;
+
+	pr_status = readq(fme_pr + FME_PR_STS);
+	if (!(pr_status & FME_PR_STS_PR_STS))
+		return 0;
+
+	pr_error = readq(fme_pr + FME_PR_ERR);
+	writeq(pr_error, fme_pr + FME_PR_ERR);
+
+	return pr_error;
+}
+
+static int fme_mgr_write_init(struct fpga_manager *mgr,
+			      struct fpga_image_info *info,
+			      const char *buf, size_t count)
+{
+	struct device *dev = &mgr->dev;
+	struct fme_mgr_priv *priv = mgr->priv;
+	void __iomem *fme_pr = priv->ioaddr;
+	u64 pr_ctrl, pr_status;
+
+	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		dev_err(dev, "only supports partial reconfiguration.\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "resetting PR before initiated PR\n");
+
+	pr_ctrl = readq(fme_pr + FME_PR_CTRL);
+	pr_ctrl |= FME_PR_CTRL_PR_RST;
+	writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
+
+	if (readq_poll_timeout(fme_pr + FME_PR_CTRL, pr_ctrl,
+			       pr_ctrl & FME_PR_CTRL_PR_RSTACK, 1,
+			       PR_WAIT_TIMEOUT)) {
+		dev_err(dev, "PR Reset ACK timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	pr_ctrl = readq(fme_pr + FME_PR_CTRL);
+	pr_ctrl &= ~FME_PR_CTRL_PR_RST;
+	writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
+
+	dev_dbg(dev,
+		"waiting for PR resource in HW to be initialized and ready\n");
+
+	if (readq_poll_timeout(fme_pr + FME_PR_STS, pr_status,
+			       (pr_status & FME_PR_STS_PR_STS) ==
+			       FME_PR_STS_PR_STS_IDLE, 1, PR_WAIT_TIMEOUT)) {
+		dev_err(dev, "PR Status timeout\n");
+		priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dev, "check and clear previous PR error\n");
+	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
+	if (priv->pr_error)
+		dev_dbg(dev, "previous PR error detected %llx\n",
+			(unsigned long long)priv->pr_error);
+
+	dev_dbg(dev, "set PR port ID\n");
+
+	pr_ctrl = readq(fme_pr + FME_PR_CTRL);
+	pr_ctrl &= ~FME_PR_CTRL_PR_RGN_ID;
+	pr_ctrl |= FIELD_PREP(FME_PR_CTRL_PR_RGN_ID, info->region_id);
+	writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
+
+	return 0;
+}
+
+static int fme_mgr_write(struct fpga_manager *mgr,
+			 const char *buf, size_t count)
+{
+	struct device *dev = &mgr->dev;
+	struct fme_mgr_priv *priv = mgr->priv;
+	void __iomem *fme_pr = priv->ioaddr;
+	u64 pr_ctrl, pr_status, pr_data;
+	int delay = 0, pr_credit, i = 0;
+
+	dev_dbg(dev, "start request\n");
+
+	pr_ctrl = readq(fme_pr + FME_PR_CTRL);
+	pr_ctrl |= FME_PR_CTRL_PR_START;
+	writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
+
+	dev_dbg(dev, "pushing data from bitstream to HW\n");
+
+	/*
+	 * driver can push data to PR hardware using PR_DATA register once HW
+	 * has enough pr_credit (> 1), pr_credit reduces one for every 32bit
+	 * pr data write to PR_DATA register. If pr_credit <= 1, driver needs
+	 * to wait for enough pr_credit from hardware by polling.
+	 */
+	pr_status = readq(fme_pr + FME_PR_STS);
+	pr_credit = FIELD_GET(FME_PR_STS_PR_CREDIT, pr_status);
+
+	while (count > 0) {
+		while (pr_credit <= 1) {
+			if (delay++ > PR_WAIT_TIMEOUT) {
+				dev_err(dev, "PR_CREDIT timeout\n");
+				return -ETIMEDOUT;
+			}
+			udelay(1);
+
+			pr_status = readq(fme_pr + FME_PR_STS);
+			pr_credit = FIELD_GET(FME_PR_STS_PR_CREDIT, pr_status);
+		}
+
+		if (count < 4) {
+			WARN_ON(1);
+			return -EINVAL;
+		}
+
+		pr_data = 0;
+		pr_data |= FIELD_PREP(FME_PR_DATA_PR_DATA_RAW,
+				      *(((u32 *)buf) + i));
+		writeq(pr_data, fme_pr + FME_PR_DATA);
+		count -= 4;
+		pr_credit--;
+		i++;
+	}
+
+	return 0;
+}
+
+static int fme_mgr_write_complete(struct fpga_manager *mgr,
+				  struct fpga_image_info *info)
+{
+	struct device *dev = &mgr->dev;
+	struct fme_mgr_priv *priv = mgr->priv;
+	void __iomem *fme_pr = priv->ioaddr;
+	u64 pr_ctrl;
+
+	pr_ctrl = readq(fme_pr + FME_PR_CTRL);
+	pr_ctrl |= FME_PR_CTRL_PR_COMPLETE;
+	writeq(pr_ctrl, fme_pr + FME_PR_CTRL);
+
+	dev_dbg(dev, "green bitstream push complete\n");
+	dev_dbg(dev, "waiting for HW to release PR resource\n");
+
+	if (readq_poll_timeout(fme_pr + FME_PR_CTRL, pr_ctrl,
+			       !(pr_ctrl & FME_PR_CTRL_PR_START), 1,
+			       PR_WAIT_TIMEOUT)) {
+		dev_err(dev, "PR Completion ACK timeout.\n");
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dev, "PR operation complete, checking status\n");
+	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
+	if (priv->pr_error) {
+		dev_dbg(dev, "PR error detected %llx\n",
+			(unsigned long long)priv->pr_error);
+		return -EIO;
+	}
+
+	dev_dbg(dev, "PR done successfully\n");
+
+	return 0;
+}
+
+static enum fpga_mgr_states fme_mgr_state(struct fpga_manager *mgr)
+{
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static u64 fme_mgr_status(struct fpga_manager *mgr)
+{
+	struct fme_mgr_priv *priv = mgr->priv;
+
+	return pr_error_to_mgr_status(priv->pr_error);
+}
+
+static const struct fpga_manager_ops fme_mgr_ops = {
+	.write_init = fme_mgr_write_init,
+	.write = fme_mgr_write,
+	.write_complete = fme_mgr_write_complete,
+	.state = fme_mgr_state,
+	.status = fme_mgr_status,
+};
+
+static int fme_mgr_probe(struct platform_device *pdev)
+{
+	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct fme_mgr_priv *priv;
+	struct fpga_manager *mgr;
+	struct resource *res;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (pdata->ioaddr)
+		priv->ioaddr = pdata->ioaddr;
+
+	if (!priv->ioaddr) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		priv->ioaddr = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->ioaddr))
+			return PTR_ERR(priv->ioaddr);
+	}
+
+	mgr = fpga_mgr_create(dev, "DFL FME FPGA Manager",
+			      &fme_mgr_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret)
+		fpga_mgr_free(mgr);
+
+	return ret;
+}
+
+static int fme_mgr_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
+
+	return 0;
+}
+
+static struct platform_driver fme_mgr_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FME_MGR,
+	},
+	.probe   = fme_mgr_probe,
+	.remove  = fme_mgr_remove,
+};
+
+module_platform_driver(fme_mgr_driver);
+
+MODULE_DESCRIPTION("FPGA Manager for DFL FPGA Management Engine");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme-mgr");
-- 
1.8.3.1

