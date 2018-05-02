Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230279-2-2010553599405511610
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
    1525230278; b=DWGs6tLxROrptvlaYPQxOjjK/64q4np9mSwOiMqKWjLbcq8F2W
    rL9I0A4e1ziJOu7t2TQp8VURrDQGiE16ldVRNTqhmXjZSBBq1ODVaUZwij1RULQL
    YLOZ7aQR2uF0XqM4Eqxk1WA9btNTSEfwPTzHF4NYjPZF+bg58e/jwW6H3JryOvQZ
    iVTVXPGeS64ODFp0ujpunepGEKmEyjS8nmQ7r3QtzS7FE6rN7ThsVBqbOzODtd6A
    YWvlSdqPVCOGUz7+EK3tyUxsh5/t6HYyDeFdyHvjxnA52JI36sIXY0HdvvtTtuXW
    fbYxSDwVozxpRrOXE9RGWPK/qmbK4MxzELww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230278; bh=
    Jv+xd2LcTVJtovKzApaaS5LF21vKD35mm+pjQDq6wS0=; b=VO2PXIkv56PkjI3y
    nwiCtnpVDThJyCd7aTmWzeCS+COwuTofUjFlEKANeBR171z3ElrgqChlmUkXn9p1
    HERW6y2gRn7gj3Kj5f6ITzHe+AVyz+JyOnasoQ6cv5xR94otYkB6FP03ULwPtQV7
    Dshxar1Ywo/Zr/JFEKYEZlWidN7ENnn/7kXxgbjBtCvZMcQiIgQnKfvhcDMuc9EN
    2mNy5jyf92M1F2cxrdZBz3xmXiMJlYNOJKUofz3mWPtuHWVGrU9v5zKHw03Fq/vt
    6bytk3zi3OPyIy6qdpuBSN5VG411NrpmXaE8sbB7/X0wUZKBIHPGr8W8FVx5fbBO
    Qxd/Zg==
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
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDkgY+L99+BRN7M2xBNiOKH0r0VEE/LjHp+NYJX0AWtBKO7nE9bGoi4BUzmgYFTHEeSyD6bwPuz1jwk/iTn1NFW+XWE97P2A134A2qgye35wfsPlRzc
    knqjNYPkkm/q3MYiJkAl6CwoFp0T4cpW01FrpuaE/ZBVE4z2uOpO1SxVHyC5IrX30KRyiud1I8+Ue+vVoaU0p7FHsZtieiFPfaVSvcfU/EGsYxr1awolojgj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=y-Gmv49SbNsKmzXHpHIA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeEBDEh (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:04:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:63852 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbeEBDCp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058595"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 24/28] fpga: dfl: afu: add port ops support
Date: Wed,  2 May 2018 10:50:27 +0800
Message-Id: <1525229431-3087-25-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch registers the port ops into the global list in the DFL
framework, and it allows other modules to use the port ops. And
This patch includes the implementation of the get_id and enable_set
ops too.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-afu-main.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 35bec47..4bdbe3d 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -19,6 +19,83 @@
 
 #include "dfl.h"
 
+/**
+ * port_enable - enable a port
+ * @pdev: port platform device.
+ *
+ * Enable Port by clear the port soft reset bit, which is set by default.
+ * The User AFU is unable to respond to any MMIO access while in reset.
+ * port_enable function should only be used after port_disable
+ * function.
+ */
+static void port_enable(struct platform_device *pdev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	void __iomem *base;
+	u64 v;
+
+	WARN_ON(!pdata->disable_count);
+
+	if (--pdata->disable_count != 0)
+		return;
+
+	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+
+	/* Clear port soft reset */
+	v = readq(base + PORT_HDR_CTRL);
+	v &= ~PORT_CTRL_SFTRST;
+	writeq(v, base + PORT_HDR_CTRL);
+}
+
+#define RST_POLL_INVL 10 /* us */
+#define RST_POLL_TIMEOUT 1000 /* us */
+
+/**
+ * port_disable - disable a port
+ * @pdev: port platform device.
+ *
+ * Disable Port by setting the port soft reset bit, it puts the port into
+ * reset.
+ */
+static int port_disable(struct platform_device *pdev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	void __iomem *base;
+	u64 v;
+
+	if (pdata->disable_count++ != 0)
+		return 0;
+
+	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+
+	/* Set port soft reset */
+	v = readq(base + PORT_HDR_CTRL);
+	v |= PORT_CTRL_SFTRST;
+	writeq(v, base + PORT_HDR_CTRL);
+
+	/*
+	 * HW sets ack bit to 1 when all outstanding requests have been drained
+	 * on this port and minimum soft reset pulse width has elapsed.
+	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
+	 */
+	if (readq_poll_timeout(base + PORT_HDR_CTRL, v, v & PORT_CTRL_SFTRST,
+			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
+		dev_err(&pdev->dev, "timeout, fail to reset device\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int port_get_id(struct platform_device *pdev)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
+
+	return FIELD_GET(PORT_CAP_PORT_NUM, readq(base + PORT_HDR_CAP));
+}
+
 static int port_hdr_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
@@ -119,6 +196,28 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	.unlocked_ioctl = afu_ioctl,
 };
 
+static int port_enable_set(struct platform_device *pdev, bool enable)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	int ret = 0;
+
+	mutex_lock(&pdata->lock);
+	if (enable)
+		port_enable(pdev);
+	else
+		ret = port_disable(pdev);
+	mutex_unlock(&pdata->lock);
+
+	return ret;
+}
+
+static struct dfl_fpga_port_ops afu_port_ops = {
+	.name = DFL_FPGA_FEATURE_DEV_PORT,
+	.owner = THIS_MODULE,
+	.get_id = port_get_id,
+	.enable_set = port_enable_set,
+};
+
 static int afu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -154,7 +253,28 @@ static int afu_remove(struct platform_device *pdev)
 	.remove  = afu_remove,
 };
 
-module_platform_driver(afu_driver);
+static int __init afu_init(void)
+{
+	int ret;
+
+	dfl_fpga_add_port_ops(&afu_port_ops);
+
+	ret = platform_driver_register(&afu_driver);
+	if (ret)
+		dfl_fpga_del_port_ops(&afu_port_ops);
+
+	return ret;
+}
+
+static void __exit afu_exit(void)
+{
+	platform_driver_unregister(&afu_driver);
+
+	dfl_fpga_del_port_ops(&afu_port_ops);
+}
+
+module_init(afu_init);
+module_exit(afu_exit);
 
 MODULE_DESCRIPTION("FPGA Accelerated Function Unit driver");
 MODULE_AUTHOR("Intel Corporation");
-- 
1.8.3.1

