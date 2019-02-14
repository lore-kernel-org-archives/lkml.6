Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E958C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1972218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394393AbfBNL5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:57:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:51463 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391608AbfBNL5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:57:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 03:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="122400493"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by fmsmga007.fm.intel.com with ESMTP; 14 Feb 2019 03:56:58 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH v3 2/5] platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
Date:   Thu, 14 Feb 2019 17:27:09 +0530
Message-Id: <20190214115712.19642-3-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190214115712.19642-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INTEL_CPU_FAM6() macro provides better abstraction and reduces code size
so use it instead of custom grown ICPU().

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 835ed6d333bf..d3752d75075b 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -25,9 +25,6 @@
 
 #include "intel_pmc_core.h"
 
-#define ICPU(model, data) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (kernel_ulong_t)data }
-
 static struct pmc_dev pmc;
 
 static const struct pmc_bit_map spt_pll_map[] = {
@@ -738,11 +735,11 @@ static inline void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 #endif /* CONFIG_DEBUG_FS */
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_MOBILE, &spt_reg_map),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, &spt_reg_map),
-	ICPU(INTEL_FAM6_KABYLAKE_MOBILE, &spt_reg_map),
-	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, &spt_reg_map),
-	ICPU(INTEL_FAM6_CANNONLAKE_MOBILE, &cnp_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE_MOBILE, spt_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
+	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
 	{}
 };
 
-- 
2.17.1

