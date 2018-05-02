Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230296-2-6635849139460282217
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230295; b=H1r3/O+TA2Y2VpibFaDo3dqkpkoMgLR00/+OaJJzLoon1UxW3G
    wAIwScdliqELQgh5OS4X2y81aAHedmiDgt+zWHC89fntvRczVQvlW/sZcRNZzkmd
    tsncBNaANVmDAUil+4o2AXPlTRP80kei6Y3ED/qhhxrwZKBnAqOmWikua1da/Tn8
    BbuKU/t4uyxpNDooBy1r2iJtfxMFsOkIyhQQi/DXSgmrAhgN+FomLUCFvJ1sdbua
    uxF/qUr6mu5rUQNtywQuaj7apJIBdfjwnUCRdDhrC8g4PmcEf82Dxwcwb1pIjYKk
    VjzlcpT4jt1xv183F5PtS0fZLo7pTlRDHEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230295; bh=
    1EuM4Gmp/ipVZeFLrmIK/FiVEmZa0DCnwpClgmADpGw=; b=NFANqZO3Ug8J5XMl
    qiBLBqor8usbPcIviOClifFX4CLzHxpnakebL4MPSUoL4C+nBUizi2qziBsMfg/1
    PlIAS2cyBq3vYh5YfWZycrRXW0bRWSINiFfsNgPnMgo2/UGAwezjQj1bp6gqHwWJ
    rUb/pCGzbsfaoU1dKbp//sHxp8Q/+nxpCqHDFUoJv+7xFoQ2TEehT2DuWWVub2ko
    XS9B09bCtkAQqWat3/uLcWciQbAqB7C15nHSO70Pma2+GzK/mgLFJ6Pd6M1gNqh9
    F9Opuk3LrgYe7fNoBvWxgbVfvBb2cGMIZxEN5CZ5FYYVabFyJj8A8FgpdbJ2nzU2
    KxLq6g==
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
X-CM-Envelope: MS4wfEiVyr00hV5FP4AUix75iNARkDinQ6NnWxwXAkt5ajwOc3tu8X3bQWNePz2yQH6VywT3/3HJcCs1o7rwYaRhlwOnLQj/JcYTPRYIEwRGb0m+SJB8xfvq
    E8maoyi2BP8wfByH7HOdJ2ntrRA2ZZszyQs89Rrhbh3SdSySuxxIXSPOtdfJl1/bF+lAs92HxyXpmd2Y+KqkqJk6ueeprjuZ2xHFj8bdgt99mL3ktu6pqm9v
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=B3Yxh08CrRpNUvMKeOkA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeEBDCm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbeEBDCi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058551"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: [PATCH v5 21/28] fpga: dfl: add fpga region platform driver for FME
Date: Wed,  2 May 2018 10:50:24 +0800
Message-Id: <1525229431-3087-22-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds fpga region platform driver for FPGA Management Engine.
It register an fpga region with given fpga manager / bridge device.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: rename driver to fpga-dfl-fme-region
    fix fpga_mgr_put order problem in remove function.
    rebased due to fpga api changes.
v4: rename to dfl-fme-region, fix SPDX license issue
    include dfl-fme-pr.h instead of dfl-fme.h and dfl.h
    add Acked-by from Alan and Moritz
v5: rebase, due to fpga region api changes.
---
 drivers/fpga/Kconfig          |  6 +++
 drivers/fpga/Makefile         |  1 +
 drivers/fpga/dfl-fme-region.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-region.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index a8f939a..65d54a4 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -162,6 +162,12 @@ config FPGA_DFL_FME_BRIDGE
 	help
 	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
 
+config FPGA_DFL_FME_REGION
+	tristate "FPGA DFL FME Region Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Region driver for FPGA Management Engine.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 75096e9..163894e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_FPGA_DFL)			+= dfl.o
 obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
 obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
+obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
new file mode 100644
index 0000000..696b313
--- /dev/null
+++ b/drivers/fpga/dfl-fme-region.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Region Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fpga/fpga-region.h>
+
+#include "dfl-fme-pr.h"
+
+static int fme_region_get_bridges(struct fpga_region *region)
+{
+	struct dfl_fme_region_pdata *pdata = region->priv;
+	struct device *dev = &pdata->br->dev;
+
+	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
+}
+
+static int fme_region_probe(struct platform_device *pdev)
+{
+	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct fpga_region *region;
+	struct fpga_manager *mgr;
+	int ret;
+
+	mgr = fpga_mgr_get(&pdata->mgr->dev);
+	if (IS_ERR(mgr))
+		return -EPROBE_DEFER;
+
+	region = fpga_region_create(dev, mgr, fme_region_get_bridges);
+	if (!region) {
+		ret = -ENOMEM;
+		goto eprobe_mgr_put;
+	}
+
+	region->priv = pdata;
+	platform_set_drvdata(pdev, region);
+
+	ret = fpga_region_register(region);
+	if (ret)
+		goto region_free;
+
+	dev_dbg(dev, "DFL FME FPGA Region probed\n");
+
+	return 0;
+
+region_free:
+	fpga_region_free(region);
+eprobe_mgr_put:
+	fpga_mgr_put(mgr);
+	return ret;
+}
+
+static int fme_region_remove(struct platform_device *pdev)
+{
+	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+
+	fpga_region_unregister(region);
+	fpga_mgr_put(region->mgr);
+
+	return 0;
+}
+
+static struct platform_driver fme_region_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FME_REGION,
+	},
+	.probe   = fme_region_probe,
+	.remove  = fme_region_remove,
+};
+
+module_platform_driver(fme_region_driver);
+
+MODULE_DESCRIPTION("FPGA Region for DFL FPGA Management Engine");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme-region");
-- 
1.8.3.1

