Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230119-2-15859732886683305636
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
    1525230118; b=Xta1zRG0uxLXAsaWeIgwTW/9F+K0R7LKhlw/B4r56Wolkv1G8v
    WAnxT2TnqJgOjgVnzLZOgIncB+BYBuU9XSwywY7U/1qsdAIuOh0550w7cCUKKv5z
    YvmXtxoi+/KnhBLCQkNz7Mg/IHZ0wJZ/AKGsm8qmc5p4OfyWvs0CMUgvlCHPHoZY
    ZXx7PjJ3pqZAVN4nwU5zcY2/Ggn96X1PoInIIHOgfHwjKpgY2tGMNM9I5pZYAQqa
    smcspb2VJ2FYLO2oV2TQo6fqKlVjNSpQ3eyeDi2elFIXYmIyJkOPZXqr5SHDodjw
    1eHZe9Qcvu1dtiTp3HpvdBDGQhqcVbmTpw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230118; bh=
    sQ0oAs9yC3gAJNPlex8lkyijDn9gfHU8f8vAlz9jQkA=; b=NeukDZujJTi+ISGr
    qxJ2MpZCB6kcn0QJGd13nUB9zSfJADbaQlrcR7pcH6eU4ClJCqdG9G9/ZkEBUEg8
    TR2WyzkQVKg19PQ3VQkyhCfS6jMVUjuuFgWckDhIwAa7X1+uvnZjMc3Dl7LRl6l4
    CXGmwedKQAtyNQ/TXzu6DAHQzzZrEj4UdWDn9LhEuQL7IE2M86FHnsv5oAYD4BLI
    gmBYm0ZbaRiCx+uTKPAl1n97JNR90c/za60A3WSYYmYjmWt9jRXb90dnunMCOE7Y
    NzZDbuYklH5hPO7FkHKoxq5oDQ2Wn6sIcXZCiUzAkM0OGq/OzVnlgp9M5UZ+Jsc9
    vcAHxg==
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
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD8wwkshQFKyJS/TtaH1f41mbKeO4SOR/kDlaZEqHo30LB8x89liT9InHsG+B25a24zs11fv27ycghBqJI3iN81XU2AgtqWwPQJdqnlw/6jjSuG6JY5Y
    DaNxlHYOIvO6mfaGC0Cq1xH1mZZIDYeWuU0V2M7o6ZVemcmCIFLV0vjy58N44DTjrOaX8An+d3p8t/7nqH6+mEkrqU4E83PIOH/7wDY5zuWogpCFi/LrgdJS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=183dIq8lBJTFDgD2-7MA:9 a=CRMob9CPfJQA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeEBDB4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:01:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:63823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751240AbeEBDBs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:01:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058227"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 03/28] fpga: mgr: add status for fpga-manager
Date: Wed,  2 May 2018 10:50:06 +0800
Message-Id: <1525229431-3087-4-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds status sysfs interface for fpga manager, it's a
read only interface which allows user to get fpga manager status,
including full/partial reconfiguration error and other status
information. It adds a status callback to fpga_manager_ops too,
allows each fpga_manager driver to define its own method to
collect latest status from hardware.

The following sysfs file is created:
* /sys/class/fpga_manager/<fpga>/status
  Return status of fpga manager, including reconfiguration errors.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: add one line description for status
    add status callback function to fpga_manager_ops
    update fpga-mgr status if any failure or during initialization
    s/INCOMPATIBLE_BS_ERR/INCOMPATIBLE_IMAGE_ERR/
v4: simply code per suggestion from Alan.
    add supported status strings (and descriptions) in sysfs document.
    remove unused error code (SECURE_LOAD_ERR).
v5: fix the wrong commit message and add Acked-by from Alan and Moritz.
---
 Documentation/ABI/testing/sysfs-class-fpga-manager | 24 +++++++++++++++++++
 drivers/fpga/fpga-mgr.c                            | 28 ++++++++++++++++++++++
 include/linux/fpga/fpga-mgr.h                      |  9 +++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-manager b/Documentation/ABI/testing/sysfs-class-fpga-manager
index 23056c5..a54450d 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-manager
+++ b/Documentation/ABI/testing/sysfs-class-fpga-manager
@@ -35,3 +35,27 @@ Description:	Read fpga manager state as a string.
 		* write complete	= Doing post programming steps
 		* write complete error	= Error while doing post programming
 		* operating		= FPGA is programmed and operating
+
+What:		/sys/class/fpga_manager/<fpga>/status
+Date:		May 2018
+KernelVersion:	4.17
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
index 0a5181d..6479fb9 100644
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
index eecfca5..802eac8 100644
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
1.8.3.1

