Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230149-5-2371780544769966433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230149; b=hK8440YO2YEzv6izaB+zQvLFxvS6zcPC2GbgsECbMQmFR7Dg3B
    ZlaKJEXjqWJJEzVZVborkJeg/uOCwzE6I+ai9LojyboZjba4UBP+w/ZmROSW++XS
    4NfhqMALf+/9k7qKZsSHGp3Cj833hmn84eJXck3Fw+4tWieD83haOY5K/4pw+QA4
    7F+bpT4ghA8xkNflIWYeqtKzUOZ36UvYhDDrDKesdZ7k8bRYJBmX37D48IfxsacR
    9oLOj8OKpVPds1pmU+4dOtjNtPisVdAgLv2yYefSegT3jji9plv0OTia/CZQ8X9Z
    ZRik8MHcvgwA4n4Z63KaPiDirbdbmWtl8BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230149; bh=
    409XUNzk9bsQv+RJtqvpsYZu8NofKUFVg0X0yIMPIHw=; b=iZ5dNJxarv2mSjtY
    bvTxiW8H6Fs+6CI3VTtu3vV/BYfTIh+UUFsDwxeJC3M51RGPpPFvZTrV9C/U0YcG
    /aQlr1wE1TRxdds8mLB+pK4Yjsi3WN2bsq1yWm+TBMuEtcuQIYjOoBNLd87qxKm2
    vVayPUr2KUkp8yD7ybXElRoswKOkCDJ9d2ArdBJ+OpFBJoOATHm41L7w/gKlGsth
    t9jDFcln1B2/1MeLZ8If/Nm8CBvoA1SWFPqaxQF8YLKXZ2hk+sqGTlxTShrANrki
    CnRpINAr4QybsM28NKp9bvvzr4QPgVHiHJBhLKp1JequasQv2AM1uYGOIJPWY5zU
    6ZOyeA==
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
X-CM-Envelope: MS4wfGtZORuqnYU24Ky/NQqaxdZlkN/t8/0zxNJHbuWiCpxS1G9j7pf07nR6eNy0qxews9TDgK/x+B/BJElX58R6BdJej6VBAkPxZICqAVlwtWjluQ8mqKrl
    E5PoLVq2XzY9mMN6C4YcSQ+spy5A2YQggV6PN8xSE1EK6kzvd7mgt07mpDUDEUnTFjJES5pZCAaQJQjLYNBk88XCNs7iyUmq1e8pC1orNFYDZsTVRJ0qr3ao
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=OAdBydhNmXb_cLMsVe4A:9 a=6Lfd2efKMs-A8yxQ:21
    a=1FayRrpWGRKSmuNc:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeEBDC0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbeEBDCY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058477"
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
Subject: [PATCH v5 16/28] fpga: dfl: fme: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Date: Wed,  2 May 2018 10:50:19 +0800
Message-Id: <1525229431-3087-17-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DFL_FPGA_GET_API_VERSION and DFL_FPGA_CHECK_EXTENSION ioctls are common
ones which need to be supported by all feature devices drivers including
FME and AFU. Userspace application can use these ioctl interfaces to get
the API info and check if specific extension is supported or not in
current driver.

This patch implements above 2 ioctls in FPGA Management Engine (FME)
driver.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: switched to GPLv2 license.
v3: rename intel-fpga.h to fpga-dfl.h and rebased.
v4: fix SPDX license issue.
    add Acked-by from Alan and Moritz.
v5: rebase due to DFL framework API naming changes.
    add DFL_ prefix to IOCTL APIs.
---
 Documentation/ioctl/ioctl-number.txt |  1 +
 drivers/fpga/dfl-fme-main.c          | 12 +++++++++
 include/uapi/linux/fpga-dfl.h        | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 include/uapi/linux/fpga-dfl.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 84bb74d..9105755 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -323,6 +323,7 @@ Code  Seq#(hex)	Include File		Comments
 0xB3	00	linux/mmc/ioctl.h
 0xB4	00-0F	linux/gpio.h		<mailto:linux-gpio@vger.kernel.org>
 0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
+0xB6	all	linux/fpga-dfl.h
 0xC0	00-0F	linux/usb/iowarrior.h
 0xCA	00-0F	uapi/misc/cxl.h
 0xCA	10-2F	uapi/misc/ocxl.h
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 368f1fc..6a59c07 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/fpga-dfl.h>
 
 #include "dfl.h"
 
@@ -116,6 +117,13 @@ static ssize_t bitstream_metadata_show(struct device *dev,
 	},
 };
 
+static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
+				      unsigned long arg)
+{
+	/* No extension support for now */
+	return 0;
+}
+
 static int fme_open(struct inode *inode, struct file *filp)
 {
 	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
@@ -156,6 +164,10 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
 
 	switch (cmd) {
+	case DFL_FPGA_GET_API_VERSION:
+		return DFL_FPGA_API_VERSION;
+	case DFL_FPGA_CHECK_EXTENSION:
+		return fme_ioctl_check_extension(pdata, arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
new file mode 100644
index 0000000..7585de0
--- /dev/null
+++ b/include/uapi/linux/fpga-dfl.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Header File for FPGA DFL User API
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Zhang Yi <yi.z.zhang@intel.com>
+ *   Wu Hao <hao.wu@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ */
+
+#ifndef _UAPI_LINUX_FPGA_DFL_H
+#define _UAPI_LINUX_FPGA_DFL_H
+
+#define DFL_FPGA_API_VERSION 0
+
+/*
+ * The IOCTL interface for DFL based FPGA is designed for extensibility by
+ * embedding the structure length (argsz) and flags into structures passed
+ * between kernel and userspace. This design referenced the VFIO IOCTL
+ * interface (include/uapi/linux/vfio.h).
+ */
+
+#define DFL_FPGA_MAGIC 0xB6
+
+#define DFL_FPGA_BASE 0
+
+/**
+ * DFL_FPGA_GET_API_VERSION - _IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 0)
+ *
+ * Report the version of the driver API.
+ * Return: Driver API Version.
+ */
+
+#define DFL_FPGA_GET_API_VERSION	_IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 0)
+
+/**
+ * DFL_FPGA_CHECK_EXTENSION - _IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 1)
+ *
+ * Check whether an extension is supported.
+ * Return: 0 if not supported, otherwise the extension is supported.
+ */
+
+#define DFL_FPGA_CHECK_EXTENSION	_IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 1)
+
+#endif /* _UAPI_LINUX_FPGA_DFL_H */
-- 
1.8.3.1

