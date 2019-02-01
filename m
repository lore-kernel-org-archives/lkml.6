Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD37C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FCA20870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfBAHcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:32:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:57767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfBAHcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:32:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 23:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="114430725"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2019 23:32:47 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH 07/10] platform/x86: intel_pmc_core: Convert to INTEL_CPU_FAM6 macro
Date:   Fri,  1 Feb 2019 13:02:31 +0530
Message-Id: <20190201073234.13280-8-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INTEL_CPU_FAM6() macro provides better abstraction and reduces code size so use
it instead of custom grown ICPU().

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

