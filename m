Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D888F20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfBAHcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:32:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:57767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfBAHcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:32:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 23:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="114430704"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2019 23:32:36 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/10] platform/x86: intel_pmc_core: Fix PCH IP name
Date:   Fri,  1 Feb 2019 13:02:27 +0530
Message-Id: <20190201073234.13280-4-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Cannonlake and Icelake, the IP name for Res_6 should be SPF i.e.
South Port F. No functional change is intended other than just renaming
the IP appropriately.

Cc: "David E. Box" <david.e.box@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 291101f6a735 ("platform/x86: intel_pmc_core: Add CannonLake PCH support")
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 9f143cdbea05..80936e6bdc61 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -203,7 +203,7 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"CNVI",                BIT(3)},
 	{"UFS0",                BIT(4)},
 	{"EMMC",                BIT(5)},
-	{"Res_6",               BIT(6)},
+	{"SPF",			BIT(6)},
 	{"SBR6",                BIT(7)},
 
 	{"SBR7",                BIT(0)},
-- 
2.17.1

