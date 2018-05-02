Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230432-2-10306126596341630651
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230431; b=WNUthk3Mm7pnLskHqSJUefyhCH81dSeYI/te4jVk0bzhB8TOPx
    mU+sHOMPeDfDZZILqcOXYmPwoXZnmdKm1l+oNZNSBJAAf34oGw0DtN0+SW2Z3Rm4
    D+TQAydMYxrRJyckUfbNLvj4j7dlL2RPZtgF1V9sYRN0JtDND81wN03dXWIKqFVo
    m15zpG4Z4+xLakJ9sYRvD8SX8eEXTD9I/8yUo/rapJfB6ZrIACO6rZv5WTewLyY/
    P5rfnEubxAfR4fCtMFitWH82vnRqoKc4i2XbhjqI8Vj1QMqc+WQSBSNVAiBM656S
    Th8P/20UywOu4BgIrozhhLpM4Vyq4i/Y3B0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230431; bh=
    9/2hQZUg4ngSvOxx6dgO08n916ZiA1f7s3mR2efdSZ8=; b=W36p3mtJn23PMf0r
    IexXbEDOdtecyiw8SF+4MX5RINmsETVIXBa29GL4LxV6l2JDVTyg/AIR6YWugt93
    YBXVDSD6hBXeR1jYyCA7qRT/gad6vNsZDp35tA/E7RtZ2KHFWg5dgmt5E0VChYFo
    AMgrmIp8aIFAoZthI2wHt+W5I2/6Y7MhuFPOfqD6NtjeNI9lg6d9UUX8DRlnEobi
    hJ1qJ4XyP198y/t8ErY/Lba1VetT4aLSbXsYk1khaSuAQtG7EkjRfkk+UdSIBzXO
    9g/Ex706vbW+3fW30bom27DEUdP/i4OIC/QpjFKVTJZTAakHNC8ThXT7126EVsba
    C/zAVg==
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
X-CM-Envelope: MS4wfMhilPhhc16IPlySMKrIZv2qPZMYH41sROUX6GDAvwe8DdJp26Sjb/Fu0r6DXmKqR99Vs9wixFKA17LjZSxSY0qeOYsybTWT3jfKrMhz9279+aB7BSCm
    YLTI8OM1ifGBDb84M2qTrO07I5TiGKAL/g2AZSq3BmC4Hb8dQxWcOk3NTK5wsYqrxiC5HA3S0wCNC8spuYX0iNUEgXtPTdCrixt1VwzVoNKS2vhgZasBOXig
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=d2c9JiwqbqMh88jMch4A:9 a=_ea90Rf7xdhsJdlc:21
    a=Ro-sgtfrmUHMBQ4g:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbeEBDCR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:02:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:63849 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751419AbeEBDCP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058424"
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
Subject: [PATCH v5 13/28] fpga: dfl-pci: add enumeration for feature devices
Date: Wed,  2 May 2018 10:50:16 +0800
Message-Id: <1525229431-3087-14-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Device Feature List (DFL) is implemented in MMIO, and features
are linked via the DFLs. This patch enables pcie driver to prepare
enumeration information (e.g locations of all device feature lists
in MMIO) and use common APIs provided by the Device Feature List
framework to enumerate each feature device linked.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: split from another patch
    use common functions from DFL framework for enumeration.
v4: rebase
v5: rebase due to naming changes on DFL framework APIs.
    add acked-by from Alan.
---
 drivers/fpga/dfl-pci.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 92e1779..994f09a 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -22,9 +22,52 @@
 #include <linux/errno.h>
 #include <linux/aer.h>
 
+#include "dfl.h"
+
 #define DRV_VERSION	"0.8"
 #define DRV_NAME	"dfl-pci"
 
+struct cci_drvdata {
+	struct dfl_fpga_cdev *cdev;	/* container device */
+	struct list_head regions;	/* list of pci bar mapping region */
+};
+
+/* pci bar mapping info */
+struct cci_region {
+	int bar;
+	void __iomem *ioaddr;	/* pointer to mapped bar region */
+	struct list_head node;
+};
+
+static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct cci_region *region;
+
+	list_for_each_entry(region, &drvdata->regions, node)
+		if (region->bar == bar) {
+			dev_dbg(&pcidev->dev, "BAR %d region exists\n", bar);
+			return region->ioaddr;
+		}
+
+	region = devm_kzalloc(&pcidev->dev, sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	region->bar = bar;
+	region->ioaddr = pci_ioremap_bar(pcidev, bar);
+	if (!region->ioaddr) {
+		dev_err(&pcidev->dev, "can't ioremap memory from BAR %d.\n",
+			bar);
+		devm_kfree(&pcidev->dev, region);
+		return NULL;
+	}
+
+	list_add(&region->node, &drvdata->regions);
+
+	return region->ioaddr;
+}
+
 /* PCI Device ID */
 #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
 #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
@@ -45,6 +88,144 @@
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
 
+static int cci_init_drvdata(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata;
+
+	drvdata = devm_kzalloc(&pcidev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&drvdata->regions);
+
+	pci_set_drvdata(pcidev, drvdata);
+
+	return 0;
+}
+
+static void cci_pci_release_regions(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct cci_region *tmp, *region;
+
+	list_for_each_entry_safe(region, tmp, &drvdata->regions, node) {
+		list_del(&region->node);
+		if (region->ioaddr)
+			pci_iounmap(pcidev, region->ioaddr);
+		devm_kfree(&pcidev->dev, region);
+	}
+}
+
+static void cci_remove_drvdata(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+
+	cci_pci_release_regions(pcidev);
+	pci_set_drvdata(pcidev, NULL);
+	devm_kfree(&pcidev->dev, drvdata);
+}
+
+static void cci_remove_feature_devs(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+
+	/* remove all children feature devices */
+	dfl_fpga_remove_feature_devs(drvdata->cdev);
+}
+
+/* enumerate feature devices under pci device */
+static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_enum_info *info;
+	struct dfl_fpga_cdev *cdev;
+	resource_size_t start, len;
+	int port_num, bar, i, ret = 0;
+	void __iomem *base;
+	u32 offset;
+	u64 v;
+
+	/* allocate enumeration info via pci_dev */
+	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	/* start to find Device Feature List from Bar 0 */
+	base = cci_pci_ioremap_bar(pcidev, 0);
+	if (!base) {
+		ret = -ENOMEM;
+		goto enum_info_free_exit;
+	}
+
+	/*
+	 * PF device has FME and Ports/AFUs, and VF device only has 1 Port/AFU.
+	 * check them and add related "Device Feature List" info for the next
+	 * step enumeration.
+	 */
+	if (dfl_feature_is_fme(base)) {
+		start = pci_resource_start(pcidev, 0);
+		len = pci_resource_len(pcidev, 0);
+
+		dfl_fpga_enum_info_add_dfl(info, start, len, base);
+
+		/*
+		 * find more Device Feature Lists (e.g Ports) per information
+		 * indicated by FME module.
+		 */
+		v = readq(base + FME_HDR_CAP);
+		port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
+
+		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
+
+		for (i = 0; i < port_num; i++) {
+			v = readq(base + FME_HDR_PORT_OFST(i));
+
+			/* skip ports which are not implemented. */
+			if (!(v & FME_PORT_OFST_IMP))
+				continue;
+
+			/*
+			 * add Port's Device Feature List information for next
+			 * step enumeration.
+			 */
+			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
+			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			base = cci_pci_ioremap_bar(pcidev, bar);
+			if (!base)
+				continue;
+
+			start = pci_resource_start(pcidev, bar) + offset;
+			len = pci_resource_len(pcidev, bar) - offset;
+
+			dfl_fpga_enum_info_add_dfl(info, start, len,
+						   base + offset);
+		}
+	} else if (dfl_feature_is_port(base)) {
+		start = pci_resource_start(pcidev, 0);
+		len = pci_resource_len(pcidev, 0);
+
+		dfl_fpga_enum_info_add_dfl(info, start, len, base);
+	} else {
+		ret = -ENODEV;
+		goto enum_info_free_exit;
+	}
+
+	/* start enumeration with prepared enumeration information */
+	cdev = dfl_fpga_enumerate_feature_devs(info);
+	if (IS_ERR(cdev)) {
+		dev_err(&pcidev->dev, "Enumeration failure\n");
+		ret = PTR_ERR(cdev);
+		goto enum_info_free_exit;
+	}
+
+	drvdata->cdev = cdev;
+
+enum_info_free_exit:
+	dfl_fpga_enum_info_free(info);
+
+	return ret;
+}
+
 static
 int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 {
@@ -82,9 +263,22 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 		goto release_region_exit;
 	}
 
-	/* TODO: create and add the platform device per feature list */
-	return 0;
+	ret = cci_init_drvdata(pcidev);
+	if (ret) {
+		dev_err(&pcidev->dev, "Fail to init drvdata %d.\n", ret);
+		goto release_region_exit;
+	}
+
+	ret = cci_enumerate_feature_devs(pcidev);
+	if (ret) {
+		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
+		goto remove_drvdata_exit;
+	}
+
+	return ret;
 
+remove_drvdata_exit:
+	cci_remove_drvdata(pcidev);
 release_region_exit:
 	pci_release_regions(pcidev);
 disable_error_report_exit:
@@ -95,6 +289,8 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 
 static void cci_pci_remove(struct pci_dev *pcidev)
 {
+	cci_remove_feature_devs(pcidev);
+	cci_remove_drvdata(pcidev);
 	pci_release_regions(pcidev);
 	pci_disable_pcie_error_reporting(pcidev);
 	pci_disable_device(pcidev);
-- 
1.8.3.1

