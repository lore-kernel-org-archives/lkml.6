Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeDWSll (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:41:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:6136 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeDWSlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:41:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,319,1520924400";
   d="scan'208";a="193753159"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/cpufeatures: Enumerate cldemote instruction
Date: Mon, 23 Apr 2018 11:29:22 -0700
Message-Id: <1524508162-192587-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cldemote is a new instruction in future x86 processors. It hints
to hardware that a specified cache line should be moved ("demoted")
from the cache(s) closest to the processor core to a level more
distant from the processor core. This instruction is faster than
snooping to make the cache line available for other cores.

cldemote instruction is indicated by the presence of the CPUID
feature flag CLDEMOTE (CPUID.(EAX=0x7, ECX=0):ECX[bit25]).

More details on cldemote instruction can be found in the latest
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d554c11e01ff..578793e97431 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -320,6 +320,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
-- 
2.5.0
