Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754103AbeBGM75 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:59:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:14495 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbeBGM7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:59:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="28863169"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 3/5] x86/cpufeatures: Add Intel PCONFIG cpufeature
Date: Wed,  7 Feb 2018 15:59:44 +0300
Message-Id: <20180207125946.5906-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
References: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUID.0x7.0x0:EDX[18] indicates whether Intel CPU support PCONFIG instruction.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d3702d9ac012..b9b46b593938 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -328,6 +328,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-- 
2.15.1
