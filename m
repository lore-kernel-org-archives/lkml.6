Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D1C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD4524B1E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 04:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD4524B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeFWEB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 00:01:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:9077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbeFWEB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 00:01:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 21:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,260,1526367600"; 
   d="scan'208";a="51575205"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2018 21:01:55 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fWZkI-000Duj-A9; Sat, 23 Jun 2018 12:01:54 +0800
Date:   Sat, 23 Jun 2018 12:01:04 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     kbuild-all@01.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org,
        jroedel@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH] iommu/amd: amd_iommu_xt_mode can be static
Message-ID: <20180623040104.GA28896@cairo>
References: <1529686927-7665-4-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529686927-7665-4-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: fec2da987eac ("iommu/amd: Add support for IOMMU XT mode")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 amd_iommu_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1c6f813..f6dd63f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -153,7 +153,7 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
-int amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
+static int amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
