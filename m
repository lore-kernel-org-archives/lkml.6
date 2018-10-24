Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA6FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8937B2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8937B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJYGbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:31:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:10462 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbeJYGbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:31:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 15:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="100417544"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2018 15:01:20 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH 2/2] x86/cpufeatures: Enumerate MOVDIR64B instruction
Date:   Wed, 24 Oct 2018 14:57:17 -0700
Message-Id: <1540418237-125817-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1540418237-125817-1-git-send-email-fenghua.yu@intel.com>
References: <1540418237-125817-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.
Direct store is implemented by using write combining (WC) for writing
data directly into memory without caching the data.

In low latency offload (e.g. Non-Volatile Memory, etc), MOVDIR64B writes
work descriptors (and data in some cases) to device-hosted work-queues
atomically without cache pollution.

Availability of the MOVDIR64B instruction is indicated by the
presence of the CPUID feature flag MOVDIR64B (CPUID.0x07.0x0:ECX[bit 28]).

Please check the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference for more details on the CPUID
feature MOVDIR64B flag.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 90934ee7b79a..28c4a502b419 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -332,6 +332,7 @@
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
+#define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
-- 
2.5.0

