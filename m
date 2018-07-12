Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6939D2086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pGPqIszU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6939D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeGLMIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:08:06 -0400
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:30720
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbeGLMIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7df3n1mbinv61XHv0Z3KzlMyp8OtmJ+v9GkrgBqpIwY=;
 b=pGPqIszUR1oNOxAluqTf0RmsGggNTrE8/MJPtzt35Ia1TulmIt19Hg4LzSKsYtY4PH/hOsI8fFjH99kA4jWzKcZG7S5mn+4s+5NkJTxCOV+oGbZp5boTsgvaiaXYg8QPRwW3E4WPTJywNge1WVDThujf7+dQLvsqgiM0FLAHH4I=
Received: from BN7PR07MB4676.namprd07.prod.outlook.com (52.135.249.153) by
 BN7PR07MB4194.namprd07.prod.outlook.com (52.135.244.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 11:58:47 +0000
Received: from BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::dbc:2355:dd0a:fe48]) by BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::dbc:2355:dd0a:fe48%4]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 11:58:47 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 2/2] scsi: ufs: Add UFS platform driver for Cadence UFS
Thread-Topic: [PATCH v2 2/2] scsi: ufs: Add UFS platform driver for Cadence
 UFS
Thread-Index: AQHUGdewHIQjjG9RrEWopjc0Ii36og==
Date:   Thu, 12 Jul 2018 11:58:47 +0000
Message-ID: <4744959B-7757-4FA7-AECD-AE1C1946863B@cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4194;7:jlv41oG5j8uNOzOd/nDKih8IAnpe284SocUPNc4TlYd5CzqdpY4Fr8iVUqOYA6sCS6nVR5Xuo1N9DsZF/iAMncPbua1nfqCaNq6tXDav0D2k1nvLGCOK4uj1c3GQX6qLbPPTmA4J+FxSP90+5igoFnRMvYSiv226xhszVghPCYNpTdoWY6Mwjvhh/tRAW20OFQ/Clinanid7BLqZ7I5IMFb0i0EjQBT9/TNXToTM/vC5OtyiZnbaK4wb2JEPahM4;20:DdpvryxPkm2hXF6HcIJdcZlGwoiNbaR9RwJZueYD8A7o3EC0gUrfT72h2gKjKXrYio0BYfeFeMejg3sfHCmX8/ODTYR1AxuU6p3M89tqTDjEVJFWKjdOAM0dZU65QfhuJB8bm44FJ4HC3cbSeczhkSL2CqmpePNNgKcSfwdoRIc4uNEFXZqDYWq7fAZpZ6srmAooTXmNswH8kQBYOixsonynkv+leJ4kI4b3iX+3YCGoINCQV+251zFLFtoanNrz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc86034b-86fc-45b5-7925-08d5e7eed327
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4194;
x-ms-traffictypediagnostic: BN7PR07MB4194:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jank@cadence.com; 
x-microsoft-antispam-prvs: <BN7PR07MB4194196828C9D4C4BB18E369D0590@BN7PR07MB4194.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4194;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4194;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(36092001)(4326008)(86362001)(486006)(83716003)(6512007)(68736007)(2900100001)(39060400002)(53936002)(476003)(2616005)(82746002)(6486002)(2501003)(5250100002)(105586002)(106356001)(14454004)(2201001)(97736004)(478600001)(36756003)(305945005)(8936002)(3846002)(6116002)(99286004)(33656002)(6436002)(54906003)(7736002)(186003)(26005)(316002)(6506007)(8676002)(81166006)(81156014)(2906002)(66066001)(25786009)(102836004)(110136005)(5660300001)(14444005)(256004)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4194;H:BN7PR07MB4676.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3eVRJdBexOXvFBpVU/dsRVMSl9eHZBRe6eAOBX0yLWvGyZB7IYKhjbABOVfjToYejSoojy6hUCgt6S98ghsmjkbJbJpNGjYQmseZurKevcrUK/f3xdy9gV9yzJT6tRyp2dAy7Ey7JMNFnp3O59a5Aq8EszZDx6x57ZGY+1XuV/QXvWD0DaipueZzetx/+/CpMEVSbIBrCue9loX/KetUKys3o3djb1VyQXQydaxTWEChuOs+YftlT/wiS+WuUzJKGdV2aE3KwzYDUBGJ0JIApqYBe7LHyY9xaN20Z87oaZPsbvT5ADB71HOR2aNm7HYjYQ/SRFFTJhvXTdLAxeB5vI80xNu3zHHVxPw2q2jEYJY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1536E339B75C348AE811F23A2C5C847@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc86034b-86fc-45b5-7925-08d5e7eed327
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 11:58:47.2199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree platform
driver for Cadence UFS Controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/scsi/ufs/Kconfig       |   8 +++
 drivers/scsi/ufs/Makefile      |   1 +
 drivers/scsi/ufs/cdns-pltfrm.c | 149 +++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/scsi/ufs/cdns-pltfrm.c

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index e27b4d4..552f85a 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -80,6 +80,14 @@ config SCSI_UFSHCD_PLATFORM
=20
 	  If unsure, say N.
=20
+config SCSI_UFS_CDNS_PLATFORM
+	tristate "Cadence UFS Controller platform driver"
+	depends on SCSI_UFSHCD_PLATFORM
+	---help---
+	This selects the Cadence specific additions to UFSHCD platform driver.
+
+	  If unsure, say N.
+
 config SCSI_UFS_DWC_TC_PLATFORM
 	tristate "DesignWare platform support using a G210 Test Chip"
 	depends on SCSI_UFSHCD_PLATFORM
diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
index 918f579..dcddc7a 100644
--- a/drivers/scsi/ufs/Makefile
+++ b/drivers/scsi/ufs/Makefile
@@ -2,6 +2,7 @@
 # UFSHCD makefile
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) +=3D tc-dwc-g210-pci.o ufshcd-dwc.o tc-d=
wc-g210.o
 obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) +=3D tc-dwc-g210-pltfrm.o ufshcd-dw=
c.o tc-dwc-g210.o
+obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) +=3D cdns-pltfrm.o
 obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
 obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o
 ufshcd-core-objs :=3D ufshcd.o ufs-sysfs.o
diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.=
c
new file mode 100644
index 0000000..943e26b
--- /dev/null
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Platform UFS Host driver for Cadence controller
+ *
+ * Copyright (C) 2018 Cadence Design Systems, Inc.
+ *
+ * Authors:
+ *	Jan Kotas <jank@cadence.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/time.h>
+
+#include "ufshcd-pltfrm.h"
+
+#define CDNS_UFS_REG_HCLKDIV 0xFC
+
+/**
+ * Sets HCLKDIV register value based on the core_clk
+ * @hba: host controller instance
+ *
+ * Return zero for success and non-zero for failure
+ */
+static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
+{
+	struct ufs_clk_info *clki;
+	struct list_head *head =3D &hba->clk_list_head;
+	unsigned long core_clk_rate =3D 0;
+	u32 core_clk_div =3D 0;
+
+	if (list_empty(head))
+		return 0;
+
+	list_for_each_entry(clki, head, list) {
+		if (IS_ERR_OR_NULL(clki->clk))
+			continue;
+		if (!strcmp(clki->name, "core_clk"))
+			core_clk_rate =3D clk_get_rate(clki->clk);
+	}
+
+	if (!core_clk_rate) {
+		dev_err(hba->dev, "%s: unable to find core_clk rate\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	core_clk_div =3D core_clk_rate / USEC_PER_SEC;
+
+	ufshcd_writel(hba, core_clk_div, CDNS_UFS_REG_HCLKDIV);
+	/* Make sure the register was updated */
+	mb();
+
+	return 0;
+}
+
+/**
+ * Sets clocks used by the controller
+ * @hba: host controller instance
+ * @on: if true, enable clocks, otherwise disable
+ * @status: notify stage (pre, post change)
+ *
+ * Return zero for success and non-zero for failure
+ */
+static int cdns_ufs_setup_clocks(struct ufs_hba *hba, bool on,
+				 enum ufs_notify_change_status status)
+{
+	if ((!on) || (status =3D=3D PRE_CHANGE))
+		return 0;
+
+	return cdns_ufs_set_hclkdiv(hba);
+}
+
+
+static struct ufs_hba_variant_ops cdns_pltfm_hba_vops =3D {
+	.name =3D "cdns-ufs-pltfm",
+	.setup_clocks =3D cdns_ufs_setup_clocks,
+};
+
+/**
+ * cdns_ufs_pltfrm_probe - probe routine of the driver
+ * @pdev: pointer to platform device handle
+ *
+ * Return zero for success and non-zero for failure
+ */
+static int cdns_ufs_pltfrm_probe(struct platform_device *pdev)
+{
+	int err;
+	struct device *dev =3D &pdev->dev;
+
+	/* Perform generic probe */
+	err =3D ufshcd_pltfrm_init(pdev, &cdns_pltfm_hba_vops);
+	if (err)
+		dev_err(dev, "ufshcd_pltfrm_init() failed %d\n", err);
+
+	return err;
+}
+
+/**
+ * cdns_ufs_pltfrm_remove - set driver_data of the device to NULL
+ * @pdev: pointer to platform device handle
+ *
+ * Always returns 0
+ */
+static int cdns_ufs_pltfrm_remove(struct platform_device *pdev)
+{
+	struct ufs_hba *hba =3D  platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(&(pdev)->dev);
+	ufshcd_remove(hba);
+	return 0;
+}
+
+
+static const struct of_device_id cdns_ufs_of_match[] =3D {
+	{ .compatible =3D "cdns,ufshc" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, cdns_ufs_of_match);
+
+static const struct dev_pm_ops cdns_ufs_dev_pm_ops =3D {
+	.suspend         =3D ufshcd_pltfrm_suspend,
+	.resume          =3D ufshcd_pltfrm_resume,
+	.runtime_suspend =3D ufshcd_pltfrm_runtime_suspend,
+	.runtime_resume  =3D ufshcd_pltfrm_runtime_resume,
+	.runtime_idle    =3D ufshcd_pltfrm_runtime_idle,
+};
+
+static struct platform_driver cdns_ufs_pltfrm_driver =3D {
+	.probe	=3D cdns_ufs_pltfrm_probe,
+	.remove	=3D cdns_ufs_pltfrm_remove,
+	.driver	=3D {
+		.name   =3D "cdns-ufshcd",
+		.owner  =3D THIS_MODULE,
+		.pm     =3D &cdns_ufs_dev_pm_ops,
+		.of_match_table =3D cdns_ufs_of_match,
+	},
+};
+
+module_platform_driver(cdns_ufs_pltfrm_driver);
+
+MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
+MODULE_DESCRIPTION("Cadence UFS host controller platform driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(UFSHCD_DRIVER_VERSION);
--=20
1.9.0


