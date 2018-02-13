Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518515043-2-11230919487764121823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518515043; b=lS4/ceHGdsFbdVNzFpV1KAuWsvFsEtRTqB7LrN86wdSS4XD
    ReORd/P80Qf6Vb3d6YaWGUlNwmMcQ95OpgNKvwHY1BBGp6wy+RkOTkvHpTZGyS53
    y7kqvrjMiWX5uvxJu/5vcYDTqK4Q2teE3zB5dl7e+FaKYRs3wtXbnyjl6kt3wI6B
    G6vBJkB4UPr9AnO0STeK/iG0LPl5Y76TFzyY/e6IA25Uaq4RaGb87B97zPtzfYX4
    H2cSuW3mUDbYJEmubrc4S+zsTPkux9kCxRfuLM6CaYay5F+LwuQObM9EGLLSLWT9
    gkEgFnyBCGnPLjceJLYip90VKNHe7HPy2aOHdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518515043;
    bh=CzritEh1Symhzz2AH8EyacUepAEZdp9yJKuYjApH0so=; b=NxMAaC5+Tt7P
    ZK5rGA7okpC1V9192RPbywymx3fNFvJNOwU4CDyJU4IX0dnNzuBQOryUuVWyxLZX
    nV5egnZlesgR+aWt4JxisdOgWujFXMdfg6OrVlkMdCxu9EEcsfJPwdaLb6EkksA1
    YURSXp7hLmzYY4Xv3SZ4adOLxyjfWAysaAl90hmApqei8TDkuUcUgt+pak4n0Aap
    hBFL5Pdk1f71UXF6hLaOl05cNJO4DUMTL3EPeBfO80qkSdj2M8LLse9v5ylP86hn
    JXIPNd65XN1NTvEc8QDo+2NDQxCacSNWY0OskHJ4fmexM66Fys3ozVdEBTMd1JN5
    MDP3lTXqzg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934669AbeBMJf0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:35:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:27114 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934645AbeBMJfU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889491"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v4 03/24] fpga: mgr: add status for fpga-manager
Date: Tue, 13 Feb 2018 17:24:32 +0800
Message-Id: <1518513893-4719-4-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds status to fpga-manager data structure, to allow
driver to store full/partial reconfiguration errors and other
status information, and adds one status callback to fpga_manager_ops
to allow fpga_manager to collect latest status when failures are
detected.

The following sysfs file is created:
* /sys/class/fpga_manager/<fpga>/status
  Return status of fpga manager, including reconfiguration errors.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v3: add one line description for status
    add status callback function to fpga_manager_ops
    update fpga-mgr status if any failure or during initialization
    s/INCOMPATIBLE_BS_ERR/INCOMPATIBLE_IMAGE_ERR/
v4: simply code per suggestion from Alan.
    add supported status strings (and descriptions) in sysfs document.
    remove unused error code (SECURE_LOAD_ERR).
---
 Documentation/ABI/testing/sysfs-class-fpga-manager | 24 +++++++++++++++++++
 drivers/fpga/fpga-mgr.c                            | 28 ++++++++++++++++++++++
 include/linux/fpga/fpga-mgr.h                      |  9 +++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-manager b/Documentation/ABI/testing/sysfs-class-fpga-manager
index 23056c5..60db277 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-manager
+++ b/Documentation/ABI/testing/sysfs-class-fpga-manager
@@ -35,3 +35,27 @@ Description:	Read fpga manager state as a string.
 		* write complete	= Doing post programming steps
 		* write complete error	= Error while doing post programming
 		* operating		= FPGA is programmed and operating
+
+What:		/sys/class/fpga_manager/<fpga>/status
+Date:		February 2018
+KernelVersion:	4.16
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read fpga manager status as a string.
+		If FPGA programming operation fails, it could be caused by crc
+		error or incompatible bitstream image. The intent of this
+		interface is to provide more detailed information for FPGA
+		programming errors to userspace. This is a list of strings for
+		the supported status.
+
+		* reconfig operation error 	- invalid operations detected by
+						  reconfiguration hardware.
+						  e.g start reconfiguration
+						  with errors not cleared
+		* reconfig CRC error		- CRC error detected by
+						  reconfiguration hardware.
+		* reconfig incompatible image	- reconfiguration image is
+						  incompatible with hardware
+		* reconfig IP protocol error	- protocol errors detected by
+						  reconfiguration hardware
+		* reconfig fifo overflow error	- FIFO overflow detected by
+						  reconfiguration hardware
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 245e7a6..50b7396 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -397,12 +397,40 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+	u64 status;
+	int len = 0;
+
+	if (!mgr->mops->status)
+		return -ENOENT;
+
+	status = mgr->mops->status(mgr);
+
+	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
+		len += sprintf(buf + len, "reconfig operation error\n");
+	if (status & FPGA_MGR_STATUS_CRC_ERR)
+		len += sprintf(buf + len, "reconfig CRC error\n");
+	if (status & FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR)
+		len += sprintf(buf + len, "reconfig incompatible image\n");
+	if (status & FPGA_MGR_STATUS_IP_PROTOCOL_ERR)
+		len += sprintf(buf + len, "reconfig IP protocol error\n");
+	if (status & FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR)
+		len += sprintf(buf + len, "reconfig fifo overflow error\n");
+
+	return len;
+}
+
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(state);
+static DEVICE_ATTR_RO(status);
 
 static struct attribute *fpga_mgr_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_state.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 6e98b66..6c79183 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -112,6 +112,7 @@ struct fpga_image_info {
  * struct fpga_manager_ops - ops for low level fpga manager drivers
  * @initial_header_size: Maximum number of bytes that should be passed into write_init
  * @state: returns an enum value of the FPGA's state
+ * @status: returns status of the FPGA, including reconfiguration error code
  * @write_init: prepare the FPGA to receive confuration data
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
@@ -126,6 +127,7 @@ struct fpga_image_info {
 struct fpga_manager_ops {
 	size_t initial_header_size;
 	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
+	u64 (*status)(struct fpga_manager *mgr);
 	int (*write_init)(struct fpga_manager *mgr,
 			  struct fpga_image_info *info,
 			  const char *buf, size_t count);
@@ -137,6 +139,13 @@ struct fpga_manager_ops {
 	const struct attribute_group **groups;
 };
 
+/* FPGA manager status: Partial/Full Reconfiguration errors */
+#define FPGA_MGR_STATUS_OPERATION_ERR		BIT(0)
+#define FPGA_MGR_STATUS_CRC_ERR			BIT(1)
+#define FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR	BIT(2)
+#define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
+#define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
+
 /**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
-- 
2.7.4

