Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514863-2-17036894913812447615
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
    t=1518514863; b=Svw0RtU9aURUUfNIT4+X3UKraPjwsiQNVaWxyqsDiOU/v5J
    ONx6s5/bzeZFn/2faRpuXilmVmr/DoU7tP0xzcU2aP30Kda2bG6ol7GNve0TtWHt
    Pssq+Hxlnl8nuhNy68bG1HjmjE2a2tWjGmzFGFD8cbr/jnQo07hz2Bm03iPx0WaM
    6bq4l02AJlko7iG31DbKL4mLNQYGGLjXo2HFWQB1XiLlbGpzEb058DonizyJcDGL
    UX66xloRM4JCIFaMnQ/5ikl6QdCHsuZDxIMYDdQLbpulZO4yExwytoxUcIAUBuTI
    xZnz5r2K7mXD7XHqkCu2G+Fpws8OoOw8YdQwtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514863;
    bh=XVJiOCcAhbp4+Fkk1NpfhlMfJN3BiG/FfwbrH5zGtDM=; b=sAhXuL2Nw0Qz
    Gfy2Y6UfkLtU8ttTZIzUJxoZGxzZsUDhe4TySSYsZN4POwIofwm85kyjYJNUJkK0
    UBPd89zXyBBCOb0e0GHWsBWRtmT03EnxUpq1k37ikZgmM0LMwRSuRUiyIUkNtf3Y
    ec54Nvs64J+HqSMKXfs5gRrZunvR6y56drpcstzN+Z3xyGQE9wzALitJXeLQzsS8
    4yS2Uiri7xJrKbsE/sw3FbqbP9q0gi5rUxqZQyPrRkKYqP/5X7FXLKWq5PbZ6ApL
    qSS5K+szqDn0TZyffzzsdUJCj6lvw8kGrSubbwI1vi9RwannU2yABltoEByQD/Rl
    U8nrBj9JFA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933975AbeBMJkj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:40:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:27128 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934775AbeBMJft (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889588"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v4 15/24] fpga: dfl-fme-pr: add compat_id support for dfl-fme-region platform device.
Date: Tue, 13 Feb 2018 17:24:44 +0800
Message-Id: <1518513893-4719-16-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds compat_id support when driver creates the platform
device for dfl-fme-region. It allows dfl-fme-region platform driver
to create fpga-region with correct compat_id.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-fme-pr.c | 20 ++++++++++++++++++++
 drivers/fpga/dfl-fme-pr.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 526e90b..c17170b 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -314,6 +314,25 @@ static void fpga_fme_destroy_bridges(struct feature_platform_data *pdata)
 }
 
 /**
+ * fpga_fme_get_region_compat_id - read region compat_id from hardware
+ *
+ * @dev: fme device.
+ */
+static struct fpga_region_compat_id
+fpga_fme_get_region_compat_id(struct device *dev)
+{
+	struct fpga_region_compat_id compat_id;
+	void __iomem *fme_pr;
+
+	fme_pr = get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_PR_MGMT);
+
+	compat_id.id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
+	compat_id.id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
+
+	return compat_id;
+}
+
+/**
  * fpga_fme_create_region - create fpga region platform device as child
  *
  * @pdata: fme platform device's pdata
@@ -339,6 +358,7 @@ fpga_fme_create_region(struct feature_platform_data *pdata,
 
 	region_pdata.mgr = mgr;
 	region_pdata.br = br;
+	region_pdata.compat_id = fpga_fme_get_region_compat_id(dev);
 
 	/*
 	 * Each FPGA device may have more than one port, so allocate platform
diff --git a/drivers/fpga/dfl-fme-pr.h b/drivers/fpga/dfl-fme-pr.h
index 11bd001..ef6c95a 100644
--- a/drivers/fpga/dfl-fme-pr.h
+++ b/drivers/fpga/dfl-fme-pr.h
@@ -19,6 +19,7 @@
 #define __DFL_FME_PR_H
 
 #include <linux/platform_device.h>
+#include <linux/fpga/fpga-region.h>
 
 /**
  * struct fme_region - FME fpga region data structure
@@ -39,11 +40,13 @@ struct fme_region {
  * @mgr: platform device of the FPGA manager.
  * @br: platform device of the FPGA bridge.
  * @region_id: region id (same as port_id).
+ * @compat_id: compat id of the FPGA region.
  */
 struct fme_region_pdata {
 	struct platform_device *mgr;
 	struct platform_device *br;
 	int region_id;
+	struct fpga_region_compat_id compat_id;
 };
 
 /**
-- 
2.7.4

