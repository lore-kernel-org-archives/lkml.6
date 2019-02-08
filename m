Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80AD21929
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549663580;
	bh=Zac3uuXI+EZAa0ZMnATQm08w+nPsyRKuynkrrwcsQlY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=yiBmYMxwcBT/uqbCD4497mylNcx6sMOuejghvilYNXqWmx+y/CZxdkVkM1KlBgaoU
	 Hg7rV7rKhpQRta366jebdo/tlz1QUlavRj9cMoLbjOr/t/7e1YFUJO45ZeVHIzlfZ7
	 gpTrls5VMfuAeomWY1lvKaljc82FOa48o/MXzxmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfBHWGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfBHWGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:06:18 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7233F21908;
        Fri,  8 Feb 2019 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549663576;
        bh=Zac3uuXI+EZAa0ZMnATQm08w+nPsyRKuynkrrwcsQlY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L3ut5wX9xDT3ft4eNDshV7WuiaWKSGm9jPYooSl3qfCz0vcryFt52nXShRUKi9+x4
         uZWoVe01GoPJBjFaS6tMH7wiKdOhHore3Ppr5DTLna+Aeah5r4Txr9g3Sq/qXthyZm
         6CHIomhqq7EffbRn7LSWve3/+/gUZ/QXPRGIGY5E=
Subject: [PATCH v1 5/7] iommu/vt-d: Remove unused dmar_remove_one_dev_info()
 argument
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:06:15 -0600
Message-ID: <154966357527.132359.18243836332587849601.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

domain_remove_dev_info() takes a struct dmar_domain * argument, but doesn't
use it.  Remove it.  No functional change intended.

The last use of this argument was removed by 127c761598f7 ("iommu/vt-d:
Pass device_domain_info to __dmar_remove_one_dev_info").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2acd08c82cdc..6e9f277bfd6d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -343,8 +343,7 @@ static int g_num_of_iommus;
 
 static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
-static void dmar_remove_one_dev_info(struct dmar_domain *domain,
-				     struct device *dev);
+static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 static void domain_context_clear(struct intel_iommu *iommu,
 				 struct device *dev);
@@ -2546,7 +2545,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(domain, dev);
+			dmar_remove_one_dev_info(dev);
 			return NULL;
 		}
 
@@ -2561,14 +2560,14 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		spin_unlock(&iommu->lock);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(domain, dev);
+			dmar_remove_one_dev_info(dev);
 			return NULL;
 		}
 	}
 
 	if (dev && domain_context_mapping(domain, dev)) {
 		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(domain, dev);
+		dmar_remove_one_dev_info(dev);
 		return NULL;
 	}
 
@@ -3621,7 +3620,7 @@ static int iommu_no_mapping(struct device *dev)
 			 * 32 bit DMA is removed from si_domain and fall back
 			 * to non-identity mapping.
 			 */
-			dmar_remove_one_dev_info(si_domain, dev);
+			dmar_remove_one_dev_info(dev);
 			dev_info(dev, "32bit DMA uses non-identity mapping\n");
 			return 0;
 		}
@@ -4567,7 +4566,7 @@ static int device_notifier(struct notifier_block *nb,
 	if (!domain)
 		return 0;
 
-	dmar_remove_one_dev_info(domain, dev);
+	dmar_remove_one_dev_info(dev);
 	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
 		domain_exit(domain);
 
@@ -4980,8 +4979,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	free_devinfo_mem(info);
 }
 
-static void dmar_remove_one_dev_info(struct dmar_domain *domain,
-				     struct device *dev)
+static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info;
 	unsigned long flags;
@@ -5070,7 +5068,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		old_domain = find_domain(dev);
 		if (old_domain) {
 			rcu_read_lock();
-			dmar_remove_one_dev_info(old_domain, dev);
+			dmar_remove_one_dev_info(dev);
 			rcu_read_unlock();
 
 			if (!domain_type_is_vm_or_si(old_domain) &&
@@ -5117,7 +5115,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static void intel_iommu_detach_device(struct iommu_domain *domain,
 				      struct device *dev)
 {
-	dmar_remove_one_dev_info(to_dmar_domain(domain), dev);
+	dmar_remove_one_dev_info(dev);
 }
 
 static int intel_iommu_map(struct iommu_domain *domain,

