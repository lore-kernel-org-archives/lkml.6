Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230475-2-331753930944968584
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230474; b=gxLuX1ooUUR+msQnAz0FkDLcMv0uE7nJU4F5LHHJfiTQdyhYrN
    g4B0bbVj8G58fCmdzmWdLJnEE3L6hJ5d7m5MlcdrwES7EKSzGKCdejOt+cKPzj9T
    M+Emdr2v9elOLRT+R2lVtt/c6wwWDmOgZlLrrUY/nL3fd21LaaY8AbRQR4ZzDdaT
    blz8LBKigvEfHNViaTgshjW8InfiWWUGqQF+Bl16SW9iawbPIUE8EAQSKGx+XC/z
    d2b+EhE9E9FAhPdqQ90UhdN3jU6IWlr9K0ZiedaeNHFiAvYdGQuv+H2JCoShR+Og
    quVPDJrnKjJzrqhPyN8gdij7jTh4DJTrtdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230474; bh=
    yCnsn7E8ZrdcH3P/eizv6pcA+bRiEWQqnfvj74ZcfSQ=; b=hK6H2oZ7LJhaFYZI
    XYKy3rkadKnHifqLiAHfTFs2X70VkRakI5bc88utW6DhW8q2K1JWezHjl4qlw+vf
    29YEQCgVPM1FIId08WHzeRV3Jn1sZoFlOuYc0hkWP03o1fIuXZSl2pi1SV4fvuV2
    1eaoqkLW4mFqNaDMO78Q82AAU0z0yDr/N3d7miWB94cMwwiYHWMj/dpxfHto+54t
    4vP01ibWmNyVaxcFDFGkJ7GEybRfHfZd8gKHUZSccXQrAK9Txp7Gn1hGHAFYpYv1
    8qEknkjVcRJUpku+iZWhRGeHzuNAa3EH4ytVFL3IKK+TdsjLDWvwiWAXqWpgjDsf
    7y81qA==
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
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFRCQRbzIn4weAfE9k9AYlsPwRWf1xwbAQTnrBfYkDAAl5r7ITihtOLyPZB61iMmuicBzxbiNnObz6O4Thom1D3TJca1eiqSiqDi0Qtoqh7bUk/Ev3jQ
    Ei9uY/uv+WX+Xd1lMKUXGUFKqS+Wxx67xi33myaid0gx2we44YcYaqm/2IP+Y8bRKp8bZ0O3neQPHVHTnlBOM/30kYiCersgOOL5qSH3JzzpvquVmmm3y5ID
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=cBxNd_nguQuJ049xiUwA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeEBDHc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:07:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:63837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeEBDCG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058356"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 10/28] fpga: dfl: add dfl_fpga_port_ops support.
Date: Wed,  2 May 2018 10:50:13 +0800
Message-Id: <1525229431-3087-11-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In some cases, other DFL driver modules may need to access some port
operations, e.g disable / enable port for partial reconfiguration in
FME module. In order to avoid dependency between port and FME modules,
this patch introduces the dfl_fpga_port_ops support in DFL framework.
A global dfl_fpga_port_ops list is added in the DFL framework, and
it allows other DFL modules to use these port operations registered
to this list, even in virtualization case, the port platform device
is turned into VF / guest VM and hidden in host, the registered
port_ops is still usable. It resolves the dependency issues between
modules, but once get port ops API returns a valid port ops, that
means related port driver module has been module_get to prevent from
unexpected unload, and put port ops API must be invoked after use.

These APIs introduced by this patch is listed below:
 * dfl_fpga_add_port_ops
   add one port ops to the global list.

 * dfl_fpga_del_port_ops
   del one port ops from the global list.

 * dfl_fpga_get_port_ops / dfl_fpga_put_port_ops
   get/put the port ops before/after use.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h | 21 +++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c4c47d6..b5a14a4 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -14,6 +14,73 @@
 
 #include "dfl.h"
 
+static DEFINE_MUTEX(dfl_port_ops_mutex);
+static LIST_HEAD(dfl_port_ops_list);
+
+/**
+ * dfl_fpga_get_port_ops - get matched port ops from the global list
+ * @pdev: platform device to match with associated port ops.
+ * Return: matched port ops on success, NULL otherwise.
+ *
+ * Please note that must dfl_fpga_put_port_ops after use the port_ops.
+ */
+struct dfl_fpga_port_ops *dfl_fpga_get_port_ops(struct platform_device *pdev)
+{
+	struct dfl_fpga_port_ops *ops = NULL;
+
+	mutex_lock(&dfl_port_ops_mutex);
+	if (list_empty(&dfl_port_ops_list))
+		goto done;
+
+	list_for_each_entry(ops, &dfl_port_ops_list, node) {
+		/* match port_ops using the name of platform device */
+		if (!strcmp(pdev->name, ops->name)) {
+			if (!try_module_get(ops->owner))
+				ops = NULL;
+			goto done;
+		}
+	}
+done:
+	mutex_unlock(&dfl_port_ops_mutex);
+	return ops;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_get_port_ops);
+
+/**
+ * dfl_fpga_put_port_ops - put port ops
+ * @ops: port ops.
+ */
+void dfl_fpga_put_port_ops(struct dfl_fpga_port_ops *ops)
+{
+	if (ops && ops->owner)
+		module_put(ops->owner);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_put_port_ops);
+
+/**
+ * dfl_fpga_add_port_ops - add port_ops to global list
+ * @ops: port ops to add.
+ */
+void dfl_fpga_add_port_ops(struct dfl_fpga_port_ops *ops)
+{
+	mutex_lock(&dfl_port_ops_mutex);
+	list_add_tail(&ops->node, &dfl_port_ops_list);
+	mutex_unlock(&dfl_port_ops_mutex);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_add_port_ops);
+
+/**
+ * dfl_fpga_del_port_ops - remove port_ops from global list
+ * @ops: port ops to del.
+ */
+void dfl_fpga_del_port_ops(struct dfl_fpga_port_ops *ops)
+{
+	mutex_lock(&dfl_port_ops_mutex);
+	list_del(&ops->node);
+	mutex_unlock(&dfl_port_ops_mutex);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_del_port_ops);
+
 static DEFINE_MUTEX(dfl_id_mutex);
 
 enum dfl_id_type {
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 27f7a74..c9d9a01 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -130,6 +130,27 @@
 /* Latency tolerance reporting. '1' >= 40us, '0' < 40us.*/
 #define PORT_CTRL_LATENCY	BIT_ULL(2)
 #define PORT_CTRL_SFTRST_ACK	BIT_ULL(4)		/* HW ack for reset */
+/**
+ * struct dfl_fpga_port_ops - port ops
+ *
+ * @name: name of this port ops, to match with port platform device.
+ * @owner: pointer to the module which owns this port ops.
+ * @node: node to link port ops to global list.
+ * @get_id: get port id from hardware.
+ * @enable_set: enable/disable the port.
+ */
+struct dfl_fpga_port_ops {
+	const char *name;
+	struct module *owner;
+	struct list_head node;
+	int (*get_id)(struct platform_device *pdev);
+	int (*enable_set)(struct platform_device *pdev, bool enable);
+};
+
+void dfl_fpga_add_port_ops(struct dfl_fpga_port_ops *ops);
+void dfl_fpga_del_port_ops(struct dfl_fpga_port_ops *ops);
+struct dfl_fpga_port_ops *dfl_fpga_get_port_ops(struct platform_device *pdev);
+void dfl_fpga_put_port_ops(struct dfl_fpga_port_ops *ops);
 
 /**
  * struct dfl_feature_driver - sub feature's driver
-- 
1.8.3.1

