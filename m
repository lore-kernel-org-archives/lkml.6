Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230269-2-11818138847010049603
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
    1525230268; b=DhJK73K2k8MXkK6d65jtr/rbflYifI66kfvOo47pKuQbYL5hOg
    WXpfetuyuUI3j4PkSKbQNTZRVta12IXBU10RHGZ3+ziH2gc6m+2XFKUSrBhI8G1m
    GanB+0c7Wc7bzexE2Nt8rGleWEA4wIBHeDGauO+OjsIx1wwlTYLrS3+0z+px9Lkv
    BXL9414IaGyfjdM4dpc6qn4H2kWeptD7t0bvkCWY9+TUVre/nU83JqvqEtq/vc+q
    SvQIWpE6Yxiw2+/j84v7OP5DXBKBRc2GXv/kOr6eZYy6Sda8ubKwHFMUQ2X5NVNJ
    4qkO55n7wG+5trQBVSz+47dqLDibWtPKBl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230268; bh=
    OCU2z+AX+yZwFXh6Nh4/B955jsfAu7nMZJ5gjIItXDE=; b=ngPYYG6PoT4MUrye
    BMUiDAFK0bfOTufzTKveviFxaZLgIizwYYTLTjwIGfXyzcnpiMfpcZ7z7FG3ah8u
    n7izmZiXAmj4r0ZbirxWdf/XKZdpJKOlhQD351Xi0xB7JldGOz7WcVZ6m3X7/+L8
    st0TXrMNgieZ1qeHqsMcGWwGbY9Di2iK2RrVkqg9wppqJoc+zoNG0xmS+Q7ldZau
    raGGjTTGkmrQmB7ru8RDKD7zEIPcvFV6+JG6a0euZElA9WyPLLRQcrywhgk56WdZ
    NanPlBra+hPLhuw92Le7RCNP7nIFkZd2oq3aoRo95PRzYUW/7FQvb2cqXnVfDSMF
    /VmQFQ==
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
X-CM-Envelope: MS4wfA0aljxdrh9dTJ8RuWd76p1vuZgxS1XvMklxWS40hD2lnsfuGT33Lj9IVWJ/gk8v1cjhXlWnZLKIiKq71DuV5T9g2bbnxVY2+5q1gqYSGIoVCDG9yAk1
    ryqdyVqljKDGuY4hT3rQ9l8q4ZaGbJ2NSD7Dl7UNYoNlUfxU2jHrlZs+Xi6UgOavVOOhV998jB1TFHxPQaYj/H0hOm/eX/cYx7ndQ1lHOQj0Gvtf8LPLVGHL
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=ZGQVYahPIi7ew5MI3R0A:9 a=CRMob9CPfJQA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeEBDEP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:04:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751616AbeEBDCs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058614"
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
Subject: [PATCH v5 25/28] fpga: dfl: afu: add header sub feature support
Date: Wed,  2 May 2018 10:50:28 +0800
Message-Id: <1525229431-3087-26-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The port header register set is always present for port, it is mainly
for capability, control and status of the ports that AFU connected to.

This patch implements header sub feature support. Below user interfaces
are created by this patch.

Sysfs interface:
* /sys/class/fpga_region/<regionX>/<dfl-port.x>/id
  Read-only. Port ID.

Ioctl interface:
* DFL_FPGA_PORT_RESET
  Reset the FPGA Port and its AFU.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: rename driver name to fpga-dfl-afu
    add more description for reset ioctl.
    fix some checkpatch issues.
v4: rebase.
    add Acked-by from Alan.
v5: rebase, and merge port functions from DFL framework code.
    add DFL_ prefix to APIs.
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  7 ++
 drivers/fpga/dfl-afu-main.c                       | 79 ++++++++++++++++++++++-
 include/uapi/linux/fpga-dfl.h                     | 17 +++++
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-port

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
new file mode 100644
index 0000000..eb1f02d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -0,0 +1,7 @@
+What:		/sys/bus/platform/devices/dfl-port.0/id
+Date:		May 2018
+KernelVersion:	4.17
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns id of this port. One DFL FPGA device
+		may have more than one port. Userspace could use this id to
+		distinguish different ports under same FPGA device.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 4bdbe3d..6f846b7 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/fpga-dfl.h>
 
 #include "dfl.h"
 
@@ -87,6 +88,41 @@ static int port_disable(struct platform_device *pdev)
 	return 0;
 }
 
+/*
+ * This function resets the FPGA Port and its accelerator (AFU) by function
+ * __port_disable and __port_enable (set port soft reset bit and then clear
+ * it). Userspace can do Port reset at any time, e.g during DMA or Partial
+ * Reconfiguration. But it should never cause any system level issue, only
+ * functional failure (e.g DMA or PR operation failure) and be recoverable
+ * from the failure.
+ *
+ * Note: the accelerator (AFU) is not accessible when its port is in reset
+ * (disabled). Any attempts on MMIO access to AFU while in reset, will
+ * result errors reported via port error reporting sub feature (if present).
+ */
+static int __port_reset(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = port_disable(pdev);
+	if (!ret)
+		port_enable(pdev);
+
+	return ret;
+}
+
+static int port_reset(struct platform_device *pdev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	int ret;
+
+	mutex_lock(&pdata->lock);
+	ret = __port_reset(pdev);
+	mutex_unlock(&pdata->lock);
+
+	return ret;
+}
+
 static int port_get_id(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -96,23 +132,63 @@ static int port_get_id(struct platform_device *pdev)
 	return FIELD_GET(PORT_CAP_PORT_NUM, readq(base + PORT_HDR_CAP));
 }
 
+static ssize_t
+id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int id = port_get_id(to_platform_device(dev));
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
+}
+static DEVICE_ATTR_RO(id);
+
+static const struct attribute *port_hdr_attrs[] = {
+	&dev_attr_id.attr,
+	NULL,
+};
+
 static int port_hdr_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
 	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
 
-	return 0;
+	port_reset(pdev);
+
+	return sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
 }
 
 static void port_hdr_uinit(struct platform_device *pdev,
 			   struct dfl_feature *feature)
 {
 	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
+
+	sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
+}
+
+static long
+port_hdr_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
+	       unsigned int cmd, unsigned long arg)
+{
+	long ret;
+
+	switch (cmd) {
+	case DFL_FPGA_PORT_RESET:
+		if (!arg)
+			ret = port_reset(pdev);
+		else
+			ret = -EINVAL;
+		break;
+	default:
+		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
+		ret = -ENODEV;
+	}
+
+	return ret;
 }
 
 static const struct dfl_feature_ops port_hdr_ops = {
 	.init = port_hdr_init,
 	.uinit = port_hdr_uinit,
+	.ioctl = port_hdr_ioctl,
 };
 
 static struct dfl_feature_driver port_feature_drvs[] = {
@@ -154,6 +230,7 @@ static int afu_release(struct inode *inode, struct file *filp)
 
 	pdata = dev_get_platdata(&pdev->dev);
 
+	port_reset(pdev);
 	dfl_feature_dev_use_end(pdata);
 
 	return 0;
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index 1c8bb2d..777d6ac 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -28,8 +28,11 @@
 #define DFL_FPGA_MAGIC 0xB6
 
 #define DFL_FPGA_BASE 0
+#define DFL_PORT_BASE 0x40
 #define DFL_FME_BASE 0x80
 
+/* Common IOCTLs for both FME and AFU file descriptor */
+
 /**
  * DFL_FPGA_GET_API_VERSION - _IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 0)
  *
@@ -48,6 +51,20 @@
 
 #define DFL_FPGA_CHECK_EXTENSION	_IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 1)
 
+/* IOCTLs for AFU file descriptor */
+
+/**
+ * DFL_FPGA_PORT_RESET - _IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 0)
+ *
+ * Reset the FPGA Port and its AFU. No parameters are supported.
+ * Userspace can do Port reset at any time, e.g during DMA or PR. But
+ * it should never cause any system level issue, only functional failure
+ * (e.g DMA or PR operation failure) and be recoverable from the failure.
+ * Return: 0 on success, -errno of failure
+ */
+
+#define DFL_FPGA_PORT_RESET		_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 0)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
1.8.3.1

