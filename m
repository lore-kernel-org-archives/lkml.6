Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514797-2-12615756377461976835
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514797; b=LrjpjtXgbussroO/a4PdnMJjFo55wWAJE6p2xXvBJ07e8cs
    qkXl94vppGrlANO1lNFZLxe6f/JpvsVLO30aJoy6o52Z433Zk94FF8wFG8cjz6cc
    Lnrh3EyA7oxR3/2XyLJztrP/QYM4xOtd1J0RQRK0QfJ22EiMKB0QbMegQVeXo2Of
    5fzzQkqb+Vmr3gUeOX+HwN2ZbrnyU5Iq7zzXY+FwHBjnaP3OaRR/9QHXsoipThqm
    04c3DsUsbNrEqxuszb3d+CWlC5ctxjTSKjHkvWzITb/b7gKlpafmgeeWclRXG+RN
    MrKmICB+H9liiYDmAYXcQfM3TXq+4mP6PMnIf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514797;
    bh=3X3gHetx7k854u45bKoDEESbj5Ea2qbMelbzjhUi2qk=; b=on5Z/eNyfu5y
    R7ITN/myDW79F3XLiBB//vQIKKzDF4dh5KdaACuj6h9kHthaE9qj+i5bWGspAiG/
    4eAnSdE1QCAEwV+MWVpXa8FV1Ae+bnEHpXtLTIwDtEtjiXXQBRwSoEo4GDAN+DzC
    ShoslmC02A156zMOcIqriv4dQFWlkzk+U1M8no2OEjLr70FJsuE382R2rX2DhsQg
    /NtrcjcttHMzBHZbNAd7VUEMexW6wfvgM4nyGcNgtAxEaS0s9hytwj5ymV2aXUnE
    rSpil5cvZyVRlGSHy8GkvZbOv2TRgcDgFfjexcj5W1zixzbwV9Z2y74FOMHbpYVD
    6z5TRhKFNA==
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
        id S934352AbeBMJji (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:39:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:27146 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934560AbeBMJgE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:36:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889646"
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
Subject: [PATCH v4 21/24] fpga: dfl: afu: add header sub feature support
Date: Tue, 13 Feb 2018 17:24:50 +0800
Message-Id: <1518513893-4719-22-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
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
* FPGA_PORT_RESET
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
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  7 ++++
 drivers/fpga/dfl-afu-main.c                       | 44 ++++++++++++++++++++++-
 include/uapi/linux/fpga-dfl.h                     | 17 +++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-port

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
new file mode 100644
index 0000000..79e8332
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -0,0 +1,7 @@
+What:		/sys/bus/platform/devices/dfl-port.0/id
+Date:		Februray 2018
+KernelVersion:  4.16
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns id of this port. One DFL FPGA device
+		may have more than one port. Userspace could use this id to
+		distinguish different ports under same FPGA device.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 70db28c..b2f8798 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -16,25 +16,66 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/fpga-dfl.h>
 
 #include "dfl.h"
 
+static ssize_t
+id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int id = fpga_port_id(to_platform_device(dev));
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
 static int port_hdr_init(struct platform_device *pdev, struct feature *feature)
 {
 	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
 
-	return 0;
+	fpga_port_reset(pdev);
+
+	return sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
 }
 
 static void port_hdr_uinit(struct platform_device *pdev,
 			   struct feature *feature)
 {
 	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
+
+	sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
+}
+
+static long
+port_hdr_ioctl(struct platform_device *pdev, struct feature *feature,
+	       unsigned int cmd, unsigned long arg)
+{
+	long ret;
+
+	switch (cmd) {
+	case FPGA_PORT_RESET:
+		if (!arg)
+			ret = fpga_port_reset(pdev);
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
 
 static const struct feature_ops port_hdr_ops = {
 	.init = port_hdr_init,
 	.uinit = port_hdr_uinit,
+	.ioctl = port_hdr_ioctl,
 };
 
 static struct feature_driver port_feature_drvs[] = {
@@ -74,6 +115,7 @@ static int afu_release(struct inode *inode, struct file *filp)
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
+	fpga_port_reset(pdev);
 	feature_dev_use_end(pdata);
 
 	return 0;
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
index 50ee831..727bec2 100644
--- a/include/uapi/linux/fpga-dfl.h
+++ b/include/uapi/linux/fpga-dfl.h
@@ -28,8 +28,11 @@
 #define FPGA_MAGIC 0xB6
 
 #define FPGA_BASE 0
+#define PORT_BASE 0x40
 #define FME_BASE 0x80
 
+/* Common IOCTLs for both FME and AFU file descriptor */
+
 /**
  * FPGA_GET_API_VERSION - _IO(FPGA_MAGIC, FPGA_BASE + 0)
  *
@@ -48,6 +51,20 @@
 
 #define FPGA_CHECK_EXTENSION	_IO(FPGA_MAGIC, FPGA_BASE + 1)
 
+/* IOCTLs for AFU file descriptor */
+
+/**
+ * FPGA_PORT_RESET - _IO(FPGA_MAGIC, PORT_BASE + 0)
+ *
+ * Reset the FPGA Port and its AFU. No parameters are supported.
+ * Userspace can do Port reset at any time, e.g during DMA or PR. But
+ * it should never cause any system level issue, only functional failure
+ * (e.g DMA or PR operation failure) and be recoverable from the failure.
+ * Return: 0 on success, -errno of failure
+ */
+
+#define FPGA_PORT_RESET		_IO(FPGA_MAGIC, PORT_BASE + 0)
+
 /* IOCTLs for FME file descriptor */
 
 /**
-- 
2.7.4

