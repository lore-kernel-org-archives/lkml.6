Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230165-2-895049461033397072
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230165; b=kDlH9KsmzGsdnlehEZvW1BkcnaZhAKht1Bgg2E35Zhb/SFvYzD
    SYn1De1+N/6khzTANZge7Zl/kX8SQJszPwjiKBT15uJRMjAkBXX6sHtADgvPNDkY
    MjOfvnOAvmGNwNe1dCYTp52vqwndSRLMGBTlB8BzI+buGMeqLiHMsovbJT5e1NzK
    8rMXjgnFQyzXpF9smJkXIOnlVTIWK9WSFKpjVwdW1qnqomSED2gkMd+tcYzvjNj2
    SfUSvoHhaq/bTDjl9f8o3t2Wggdj/FmCIVKvCyIZvVZAE3TWEtwj7klLmKNr0n6Q
    dCA23ibqLReE4SGq1LHy2iFaCagHFdSjuYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230165; bh=
    GKgEs0Ll1UHMAr7bDayrnCUZhM/PtV1BlwkPLzxiL/U=; b=MlYIOOLXFxel1nZr
    AjpC5m4IXtkUKMRJPwJ5nojFlR0Qwx/fVHakEydnkj2TybfFeUW+goiBPzhUKY4w
    cKpbuKVjzjYOM551xq46fy8LDcFLgYMja+UIaIieBPr1BtFk33WXrvXBG34yRSqn
    kZHn7GGxc4MvAPJ7RS/nsv3U7srPg1n7vsR8ZJp3foCnKRqcbyM2OVAOR7XCesB1
    AsAL7D/WD7jna8XknKwE36auew9wTiovnNDKnJO7Zz0jSbZA9IuYeG3HTwghbOp+
    hbhUKIplDg+rmrsbWBwXqDFaDdkqxCEpBUOqjqIhr6uG/QwCMrQTiftOJWbcJUll
    nlSGzw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfPug3bCg07k9z/7Ksy5WAv+TcmWLppQF5oHWWd/oAj/BnRt+qXqQ0QXbTtUc3O39Mq5dXSn64CVIgRYAXN6Zn923Xl5V2RIFrwWt9HpNzk5m7W2VREE0
    1nh1WDKSY6ylGdIPz4IYdq0o82vRvBFeG1GH+1q0NuZuEOHfwVEXDT3wA+U2evslpq8GZ6aZ6uib1HBuW//ttS56NtcB7qvn+m6VPhuvlBJT/JqaBD/RvhP2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=PtWeXH3RWdnFthV87cIA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeEBDCn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751535AbeEBDCf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058534"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: [PATCH v5 20/28] fpga: dfl: add fpga bridge platform driver for FME
Date: Wed,  2 May 2018 10:50:23 +0800
Message-Id: <1525229431-3087-21-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds fpga bridge platform driver for FPGA Management Engine.
It implements the enable_set callback for fpga bridge.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: rename driver to fpga-dfl-fme-br
    remove useless dev_dbg in probe function.
    rebased due to fpga api change.
v4: rename to dfl-fme-br and fix SPDX license issue
    include dfl-fme-pr.h instead of dfl-fme.h
    add Acked-by from Alan and Moritz
v5: rebase due to API changes.
    defer port and its ops finding when really need.
---
 drivers/fpga/Kconfig      |   6 +++
 drivers/fpga/Makefile     |   1 +
 drivers/fpga/dfl-fme-br.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-br.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 89f76e8..a8f939a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -156,6 +156,12 @@ config FPGA_DFL_FME_MGR
 	help
 	  Say Y to enable FPGA Manager driver for FPGA Management Engine.
 
+config FPGA_DFL_FME_BRIDGE
+	tristate "FPGA DFL FME Bridge Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index f82814a..75096e9 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
 obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
+obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
new file mode 100644
index 0000000..5c51b08
--- /dev/null
+++ b/drivers/fpga/dfl-fme-br.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Bridge Driver for FPGA Management Engine (FME)
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
+#include <linux/fpga/fpga-bridge.h>
+
+#include "dfl.h"
+#include "dfl-fme-pr.h"
+
+struct fme_br_priv {
+	struct dfl_fme_br_pdata *pdata;
+	struct dfl_fpga_port_ops *port_ops;
+	struct platform_device *port_pdev;
+};
+
+static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct fme_br_priv *priv = bridge->priv;
+	struct platform_device *port_pdev;
+	struct dfl_fpga_port_ops *ops;
+
+	if (!priv->port_pdev) {
+		port_pdev = dfl_fpga_cdev_find_port(priv->pdata->cdev,
+						    &priv->pdata->port_id,
+						    dfl_fpga_check_port_id);
+		if (!port_pdev)
+			return -ENODEV;
+
+		priv->port_pdev = port_pdev;
+	}
+
+	if (priv->port_pdev && !priv->port_ops) {
+		ops = dfl_fpga_get_port_ops(priv->port_pdev);
+		if (!ops || !ops->enable_set)
+			return -ENOENT;
+
+		priv->port_ops = ops;
+	}
+
+	return priv->port_ops->enable_set(priv->port_pdev, enable);
+}
+
+static const struct fpga_bridge_ops fme_bridge_ops = {
+	.enable_set = fme_bridge_enable_set,
+};
+
+static int fme_br_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fme_br_priv *priv;
+	struct fpga_bridge *br;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdata = dev_get_platdata(dev);
+
+	br = fpga_bridge_create(dev, "DFL FPGA FME Bridge",
+				&fme_bridge_ops, priv);
+	if (!br)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, br);
+
+	ret = fpga_bridge_register(br);
+	if (ret)
+		fpga_bridge_free(br);
+
+	return ret;
+}
+
+static int fme_br_remove(struct platform_device *pdev)
+{
+	struct fpga_bridge *br = platform_get_drvdata(pdev);
+	struct fme_br_priv *priv = br->priv;
+
+	fpga_bridge_unregister(br);
+
+	if (priv->port_pdev)
+		put_device(&priv->port_pdev->dev);
+	if (priv->port_ops)
+		dfl_fpga_put_port_ops(priv->port_ops);
+
+	return 0;
+}
+
+static struct platform_driver fme_br_driver = {
+	.driver	= {
+		.name    = DFL_FPGA_FME_BRIDGE,
+	},
+	.probe   = fme_br_probe,
+	.remove  = fme_br_remove,
+};
+
+module_platform_driver(fme_br_driver);
+
+MODULE_DESCRIPTION("FPGA Bridge for DFL FPGA Management Engine");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme-bridge");
-- 
1.8.3.1

