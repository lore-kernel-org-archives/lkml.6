Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3845453-1518514878-2-13943570955288448271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514878; b=Is/LuFk+eGXPzFerCeCfBi8X+zV/p3BPNPTA9xzp8QmSzGC
    cJWq5ijBWQ2CYc/iVYAiz5pMHebWZrtoElMuvbZIDBjQligETMmS8q+Lgwyw/qT5
    LgG8o7sWxkrSXd5RTwchauHyiGchQAYQe9zGpqBA64SKqCv+B/sTSqRsZ01F9M1/
    cdHdwflFQeCcxqOrN3EYtbpeJuCBz8q2iRXH3sLPD7kAGXp+ge0BBfhl58Inxasa
    rxivGIHvxD8g9Xba9nDN9Tp21TdGmIkg378Ey3cXtgNusnjwEbDhaDHPB6u39mNZ
    qC+iW5XibUZWwC7AVC9r1pxVJUaMwVerA4XVCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514878;
    bh=8iv+n/mx8neEpDK3627h2vwuagJL6DdtATfTXC8BlnA=; b=I5QsMpVH1Q7q
    idSWMQNuM34UWGLATfgNcBpYKJraYOw8DqfeRSVQVNCk6A2OsVLjtafBjJTliA4y
    7LHd3vOZ2BjAMwRoX4XgJ1T9V/LBCrigqq3A0U5afL0NbIXcrN3r8O3pY4gVL5XU
    eYsuH10rYELfJRhUd11jZYU5RfroWwTIjgVoDZ7Hx++gMbyvp10anKHk73quP+cS
    ls1eopD4qkX1jydSNs0G2UNu55y1a0aGO8S96E+W/psHfH6zALdxu9Q8/q5xTru7
    Oo9fX1bW8KeQf8TR/YswRTzRvDi6O5G29bwF9TtNUU2dbQ5lP9KtUmcsNkDOzMO7
    l9ngH39x/Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934645AbeBMJfs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:35:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:27128 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934508AbeBMJfq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889571"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v4 13/24] fpga: region: add compat_id support
Date: Tue, 13 Feb 2018 17:24:42 +0800
Message-Id: <1518513893-4719-14-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a compat_id member and sysfs interface for each
fpga-region, e.g userspace applications could read the compat_id
from the sysfs interface for compatibility checking before PR.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 Documentation/ABI/testing/sysfs-class-fpga-region |  5 +++++
 drivers/fpga/fpga-region.c                        | 19 +++++++++++++++++++
 include/linux/fpga/fpga-region.h                  | 13 +++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
new file mode 100644
index 0000000..419d930
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-fpga-region
@@ -0,0 +1,5 @@
+What:		/sys/class/fpga_region/<region>/compat_id
+Date:		February 2018
+KernelVersion:	4.16
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	FPGA region id for compatibility check.
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 660a91b..babec96 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -162,6 +162,24 @@ int fpga_region_program_fpga(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
 
+static ssize_t compat_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+
+	return sprintf(buf, "%016llx%016llx\n",
+		       (unsigned long long)region->compat_id.id_h,
+		       (unsigned long long)region->compat_id.id_l);
+}
+
+static DEVICE_ATTR_RO(compat_id);
+
+static struct attribute *fpga_region_attrs[] = {
+	&dev_attr_compat_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(fpga_region);
+
 int fpga_region_register(struct fpga_region *region)
 {
 	struct device *dev = region->parent;
@@ -226,6 +244,7 @@ static int __init fpga_region_init(void)
 	if (IS_ERR(fpga_region_class))
 		return PTR_ERR(fpga_region_class);
 
+	fpga_region_class->dev_groups = fpga_region_groups;
 	fpga_region_class->dev_release = fpga_region_dev_release;
 
 	return 0;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 423c87e..bf97dcc 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -6,6 +6,17 @@
 #include <linux/fpga/fpga-bridge.h>
 
 /**
+ * struct fpga_region_compat_id - FPGA Region id for compatibility check
+ *
+ * @id_h: high 64bit of the compat_id
+ * @id_l: low 64bit of the compat_id
+ */
+struct fpga_region_compat_id {
+	u64 id_h;
+	u64 id_l;
+};
+
+/**
  * struct fpga_region - FPGA Region structure
  * @dev: FPGA Region device
  * @parent: parent device
@@ -13,6 +24,7 @@
  * @bridge_list: list of FPGA bridges specified in region
  * @mgr: FPGA manager
  * @info: FPGA image info
+ * @compat_id: FPGA region id for compatibility check.
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  * @groups: optional attribute groups.
@@ -24,6 +36,7 @@ struct fpga_region {
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
+	struct fpga_region_compat_id compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 	const struct attribute_group **groups;
-- 
2.7.4

