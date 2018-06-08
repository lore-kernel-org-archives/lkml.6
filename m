Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cxj3L9XiGlt9OgAAmS7hNA
	; Fri, 08 Jun 2018 20:12:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 26261608C9; Fri,  8 Jun 2018 20:12:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AC6236089E;
	Fri,  8 Jun 2018 20:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC6236089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeFHUMl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:12:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:36699 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753115AbeFHUMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:12:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 13:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,491,1520924400";
   d="scan'208";a="65493137"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2018 13:12:25 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fRNkF-0008BA-Mn; Sat, 09 Jun 2018 04:12:23 +0800
Date: Sat, 9 Jun 2018 04:11:26 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH rcu] fixup! EXP iommu: stupid_workaround() can be static
Message-ID: <20180608201126.GA72227@cairo>
References: <201806090402.ONNRpjQE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201806090402.ONNRpjQE%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 814ee31d1f90 ("fixup! EXP iommu: Placeholder for fix in mainline")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 amd_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 46519d0..00dcafe 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3563,7 +3563,7 @@ EXPORT_SYMBOL(amd_iommu_device_info);
 static struct irq_chip amd_ir_chip;
 static DEFINE_SPINLOCK(iommu_table_lock);
 
-void __maybe_unused stupid_workaround(void)
+static void __maybe_unused stupid_workaround(void)
 {
 	spin_lock(&iommu_table_lock);
 	spin_unlock(&iommu_table_lock);
