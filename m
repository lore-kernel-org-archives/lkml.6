Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514924-2-3528373673448281771
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
    t=1518514923; b=TDMsqia/hEI/0XcXDOmyW2UKbOuJyZXtJ5sKU/IJGB73BFc
    wD5QhL9PPUnM5Oguy0ywEROoeC45o32hNi+XdaBS+Uq0pIgCJ2zs4lBJwXUHHTIg
    P8HnyRVFe6iqZ8ep26vbe0XpG2LsrULyv8MQek3YDN//cbz81J9I8UHYu1mLJxQ3
    UEeNHPBrqFjQr2bNEOOGTP7gr5Iyvn1OH7IEr/C/sMjJhREOYV3CvIGRO5eZ81Mt
    JUNZxTThkdPu/Ky3DikERjeJKtQm/3ukHoQcw9kdLJSmkDmkr9hSqVAxXYcm7GXe
    92PJKcn9YoPfb8Mo342Pt5R0Qo9/VTbjmGawu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514923;
    bh=WAcJO7mYNFs5F15x19zw3ifMCiqTAAiAUbPeeDYDycw=; b=tw0mM7FAdu6/
    DKZMH8Qs1zME0sFf3jy8NJl512Bj0rahiC3yIr8MJxT088tXR72UGAJgWRf8s6Xd
    2iQs5kbefj9SDYDC65Pie+geUn7+Tb1FuA7glKIQU8wHgzB0Ncvb72WPxxBsGRls
    PZ8dBndqwoWlPQwccMWwH0eX05zFyJiJmFaKJdn1ni8wLzYGaLIk3pJZdIJnDAi7
    hGlzxO28xgKM1a0PWt/aI+FmbxBUJbzCdWbFRALbY2o0IjyuGSbgYsfOXoR1MKNK
    d7d7aCprJD5m51hQqs+6N/O3TJA6dkuwc2WZKkEP5F4VaggHdbpj4tHwVnSL8d22
    N4Sj6vihvw==
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
        id S934102AbeBMJll (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:41:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:27130 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934640AbeBMJfl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889557"
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
Subject: [PATCH v4 11/24] fpga: dfl: fme: add header sub feature support
Date: Tue, 13 Feb 2018 17:24:40 +0800
Message-Id: <1518513893-4719-12-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kang Luwei <luwei.kang@intel.com>

The Header Register set is always present for FPGA Management Engine (FME),
this patch implements init and uinit function for header sub feature and
introduce several read-only sysfs interfaces for the capability and status.

Sysfs interfaces:
* /sys/class/fpga_region/<regionX>/<dfl-fme.x>/ports_num
  Read-only. Number of ports implemented

* /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_id
  Read-only. Blue Bitstream (static FPGA region) identifier number. It contains
  the detailed version and other information of this static FPGA region.

* /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_metadata
  Read-only. Blue Bitstream (static FPGA region) meta data. It contains the
  synthesis date, seed and other information of this static FPGA region.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Kang Luwei <luwei.kang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: add sysfs documentation
v3: rename driver to fpga-dfl-fme.
    improve sysfs doc and commit description.
    replace bitfield.
v4: rebase and switch to use id for sub feature matching.
    add more description for bitstream_id/metadata.
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme | 23 ++++++++
 drivers/fpga/dfl-fme-main.c                      | 68 ++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-fme

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
new file mode 100644
index 0000000..23a13a5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -0,0 +1,23 @@
+What:		/sys/bus/platform/devices/dfl-fme.0/ports_num
+Date:		February 2018
+KernelVersion:  4.16
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. One DFL FPGA device may have more than 1
+		port/Accelerator Function Unit (AFU). It returns the
+		number of ports on the FPGA device when read it.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/bitstream_id
+Date:		February 2018
+KernelVersion:  4.16
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns Blue Bitstream (static FPGA region)
+		identifier number, which includes the detailed version
+		and other information of this static FPGA region.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/bitstream_meta
+Date:		February 2018
+KernelVersion:  4.16
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns Blue Bitstream (static FPGA region)
+		meta data, which includes the synthesis date, seed and other
+		information of this static FPGA region.
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index ebe6b52..056ae24 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -19,9 +19,76 @@
 
 #include "dfl.h"
 
+static ssize_t ports_num_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
+}
+static DEVICE_ATTR_RO(ports_num);
+
+/*
+ * Blue Bitstream (static FPGA region) identifier number. It contains the
+ * detailed version and other information of this static FPGA region.
+ */
+static ssize_t bitstream_id_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_BITSTREAM_ID);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+}
+static DEVICE_ATTR_RO(bitstream_id);
+
+/*
+ * Blue Bitstream (static FPGA region) meta data. It contains the synthesis
+ * date, seed and other information of this static FPGA region.
+ */
+static ssize_t bitstream_metadata_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_BITSTREAM_MD);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+}
+static DEVICE_ATTR_RO(bitstream_metadata);
+
+static const struct attribute *fme_hdr_attrs[] = {
+	&dev_attr_ports_num.attr,
+	&dev_attr_bitstream_id.attr,
+	&dev_attr_bitstream_metadata.attr,
+	NULL,
+};
+
 static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
 {
+	void __iomem *base = feature->ioaddr;
+	int ret;
+
 	dev_dbg(&pdev->dev, "FME HDR Init.\n");
+	dev_dbg(&pdev->dev, "FME cap %llx.\n",
+		(unsigned long long)readq(base + FME_HDR_CAP));
+
+	ret = sysfs_create_files(&pdev->dev.kobj, fme_hdr_attrs);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -29,6 +96,7 @@ static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
 static void fme_hdr_uinit(struct platform_device *pdev, struct feature *feature)
 {
 	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
+	sysfs_remove_files(&pdev->dev.kobj, fme_hdr_attrs);
 }
 
 static const struct feature_ops fme_hdr_ops = {
-- 
2.7.4

