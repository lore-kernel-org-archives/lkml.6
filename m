Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230505-2-2930102704723871096
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
    1525230504; b=bGTOm5e1HOIfAp2Ma/eM7OLuwG3wvWdHuRJKLW06GtiP61+DLl
    +pd9/KrftPX41JApo76pIDkIPrAG3OGGKMZVoaCH9C/sc8Q75uZv3shyRqLp/isB
    gQFBc28WM35z4T5vXsnzQYyUT3zDJkeSwRhz+KjiMbDr5Vi5XvSpuhuYJ1u7AHO/
    7QvhInh8O8QPAJ9tgW2fHnIVhQKvGenybL4kMYdDReYcBHDLZQu73zHXNRmQhoC4
    S2vnVQEI3CCbU4iGtVQAo0t7x6NoQM7HPfZ2Oaf0NEeB2PVj4c9AdwcsnIbvath7
    t4Us7wnGZQOT3txXcry9ip2siabpQ8XRj8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230504; bh=
    yW76xP3TSSkvGz53sYwncvstILQj35AwlkukmOfPCs0=; b=RHEowjOx6TRvzwDH
    h4x5cKp1DN6AZ9lrxnJmrSJWXxoFMHrpgB67fuhVQBpxRepLMaYiaN2G2NteyFSZ
    68GG9qQZTc7SNvPnCUlp9LEaTRr+VMCeK/wgv4EoSk9wshXE1szHrx94pz75Bc/C
    jmPS3BeaydjuugEg4YOEyC0hFuyANVhdvMf64sTLGmISwEp0cLz0Td5dykW741eq
    h9NElNdd0TfBEPcxFdbpMVD4qn877Ve7RFgoCfUqxnquc5T5h83RAs/Mxo6r9GpE
    W6dyoZSw1gEv7COAiamtMaHurL9usZ9Xg4I1S70HNQvN/+gqfiJVNrUgDHutz6g1
    zpt3Vg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHY4sj3UvuscTyCvRd2bIJgI0nAhEBFVi8DcouBgNEvUSvxVoohcVq2APHUUbt3WWgEhf3xwfJwPR3qge6TpLgg8eyh/o8qNOSA1m49ctOB2JteWwGgK
    +3FPlsn5YpWbBG99QbYg2tgWmPUvWPnYohsWyzgfpMeOxYjMo22UzdhdZEOWKFKLoEFnVSJdsFliKpbBWWkbQhXMd4aK2r0Yn6xPuyNDIGeLv9TPCpsRkM+q
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=ORLigIeDGzOt-AVRv0kA:9 a=CRMob9CPfJQA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEBDB6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:01:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:63823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbeEBDBw (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:01:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058257"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 05/28] fpga: region: add compat_id support
Date: Wed,  2 May 2018 10:50:08 +0800
Message-Id: <1525229431-3087-6-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a compat_id pointer member and sysfs interface
for each fpga region, similar as compat_id for fpga manager, it allows
applications to read the per region compat_id for compatibility
checking before other actions on this fpga-region (e.g PR).

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v5: use pointer for compat_id as it's optional to implement.
---
 Documentation/ABI/testing/sysfs-class-fpga-region |  9 +++++++++
 drivers/fpga/fpga-region.c                        | 22 ++++++++++++++++++++++
 include/linux/fpga/fpga-region.h                  |  2 ++
 3 files changed, 33 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
new file mode 100644
index 0000000..9618f74
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-fpga-region
@@ -0,0 +1,9 @@
+What:		/sys/class/fpga_region/<region>/compat_id
+Date:		May 2018
+KernelVersion:	4.17
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	FPGA region id for compatibility check, e.g compatibility
+		of the FPGA reconfiguration hardware and image. This value
+		is defined or calculated by the layer that is creating the
+		FPGA region. This interface returns the compat_id value or
+		just error code -ENOENT in case compat_id is not used.
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index d6a9dd2..6929178 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -162,6 +162,27 @@ int fpga_region_program_fpga(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
 
+static ssize_t compat_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+
+	if (!region->compat_id)
+		return -ENOENT;
+
+	return sprintf(buf, "%016llx%016llx\n",
+		       (unsigned long long)region->compat_id->id_h,
+		       (unsigned long long)region->compat_id->id_l);
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
 /**
  * fpga_region_create - alloc and init a struct fpga_region
  * @dev: device parent
@@ -262,6 +283,7 @@ static int __init fpga_region_init(void)
 	if (IS_ERR(fpga_region_class))
 		return PTR_ERR(fpga_region_class);
 
+	fpga_region_class->dev_groups = fpga_region_groups;
 	fpga_region_class->dev_release = fpga_region_dev_release;
 
 	return 0;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index f2e215b..e8ad979 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -12,6 +12,7 @@
  * @bridge_list: list of FPGA bridges specified in region
  * @mgr: FPGA manager
  * @info: FPGA image info
+ * @compat_id: FPGA region id for compatibility check.
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -21,6 +22,7 @@ struct fpga_region {
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
+	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
-- 
1.8.3.1

