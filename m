Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230477-2-9501734708277397408
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
    1525230477; b=O4vtA36b2/bsumX/F6v3BozgpQx8CikN27uYzZ62l0IRGUNoDy
    puAQeQV8Ep/zXVlhoSM6NTND6MwogHy3jQlg1Vl5j86swzeiCv2hP5nuvVXiXbfj
    rUWRIVtCNOqx7xp4XoJQ48OoPp3ui7N4kghNt7dI5poG74Puklh/I7B1aZKg1kKL
    ZnSyvdfXZcNtjzm9/BzJDaxRzS6RRIf6roAAJNGnkMw25AcuSumu6ZiZrRftLV2K
    +k81XQNUKieVQG0zsvHwQoRNezgODp2T7+AdpPuAZ9nTve1Az1YIrtpS+UkvKTTe
    UVqEYBVCvl1PCISZ8WHk9R4U+iCWyH7cNbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230477; bh=
    JTTk1SlxZZFd0VNvIt4hGdKLUZMOYFoNrX30rx9MwKk=; b=Z9D7j6rEy9RedTTU
    RBzipR8xgpa/vAxNPv7b1PtcoMMK7Tand6CiyfdkUYOjqQCcSv5cqPuVg2VYQstl
    jhgu3L+77QZxgPIwviO6HK2rN2LUiXNBJPBpyzpHCgPv+8AKguKZ6bbOLqKPom0p
    zzr2sZEOQpeX63U0OGpSgZ3j0lrZJrC+09k2gmjHbRhAYUaqSGyp+o7YA5iJICAL
    H4A0YPduyCP54q8AzgUG+kp0MVMTRGdsy4CPbY5TNRPLtLCVm86Vw/wJ0vyEHY81
    eWKv484/V+QSldjBqkY0XQMTvh0WqGtByuouMW+xBJPAyqJDru1ILPweo2YeGX/j
    2Z3T+Q==
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
    x-vs=clean score=-100 state=0
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDeuAcun9dNDQZoxg8ioJ+DAqFsP6MfdDaI0TQ062wsfgcwPcOKHsK1PgjNHvdAJx9AipxwzVxdYe7Wr0hP+ipeZ1Xb0ph4TGEFixt0OHp5CO4lbd89e
    oU8YieNAEM+biT8f5zrYXM6/Uy1d+YX/zcAR1u3de6r+Lb1+32xkxkB3J8fPnZIbhfmDvbe1ECKQ++jqJSrGwOYtfbFivv1F1pGmj+F46kosi6P8O6uV936Z
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=7mDuTfA3LRDM-GoIaDYA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeEBDHb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:07:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:63837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751359AbeEBDCB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058318"
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
Subject: [PATCH v5 08/28] fpga: dfl: add dfl_fpga_cdev_find_port
Date: Wed,  2 May 2018 10:50:11 +0800
Message-Id: <1525229431-3087-9-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For feature devices, we need a method to find the port dedicated
to the device. This patch adds a function dfl_fpga_cdev_find_port
for this purpose. e.g FPGA Management Engine (FME) Partial
Reconfiguration sub feature, it uses this function to find
dedicated port on the device for PR function implementation.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: s/fpga_for_each_port/fpga_cdev_find_port/
    move fpga_cdev_find_port to fpga-dfl module.
v4: improve description in commit message.
    add comments to remind user to put_device after use this function.
v5: add "dfl_" prefix to functions.
    improve function comments per suggestion from Alan Tull.
    add Acked-by from Alan and Moritz.
---
 drivers/fpga/dfl.c | 32 ++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h | 21 +++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 18aba02..1e06efb 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -795,6 +795,38 @@ void dfl_fpga_remove_feature_devs(struct dfl_fpga_cdev *cdev)
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_remove_feature_devs);
 
+/**
+ * __dfl_fpga_cdev_find_port - find a port under given container device
+ *
+ * @cdev: container device
+ * @data: data passed to match function
+ * @match: match function used to find specific port from the port device list
+ *
+ * Find a port device under container device. This function needs to be
+ * invoked with lock held.
+ *
+ * Return: pointer to port's platform device if successful, NULL otherwise.
+ *
+ * NOTE: you will need to drop the device reference with put_device() after use.
+ */
+struct platform_device *
+__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
+			  int (*match)(struct platform_device *, void *))
+{
+	struct dfl_feature_platform_data *pdata;
+	struct platform_device *port_dev;
+
+	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
+		port_dev = pdata->dev;
+
+		if (match(port_dev, data) && get_device(&port_dev->dev))
+			return port_dev;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(__dfl_fpga_cdev_find_port);
+
 static int __init dfl_fpga_init(void)
 {
 	int ret;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 5fcb1a1..2b6aaef 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -290,4 +290,25 @@ struct dfl_fpga_cdev *
 dfl_fpga_enumerate_feature_devs(struct dfl_fpga_enum_info *info);
 void dfl_fpga_remove_feature_devs(struct dfl_fpga_cdev *cdev);
 
+/*
+ * need to drop the device reference with put_device() after use port platform
+ * device returned by __dfl_fpga_cdev_find_port and dfl_fpga_cdev_find_port
+ * functions.
+ */
+struct platform_device *
+__dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
+			  int (*match)(struct platform_device *, void *));
+
+static inline struct platform_device *
+dfl_fpga_cdev_find_port(struct dfl_fpga_cdev *cdev, void *data,
+			int (*match)(struct platform_device *, void *))
+{
+	struct platform_device *pdev;
+
+	mutex_lock(&cdev->lock);
+	pdev = __dfl_fpga_cdev_find_port(cdev, data, match);
+	mutex_unlock(&cdev->lock);
+
+	return pdev;
+}
 #endif /* __FPGA_DFL_H */
-- 
1.8.3.1

