Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeDYJCp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:02:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44277 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751971AbeDYJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:02:36 -0400
Date: Wed, 25 Apr 2018 02:01:29 -0700
From: tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-ec8c7206b71d46ee50a23697933dfafec8d5c426@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, ashok.raj@intel.com,
        ravi.v.shankar@intel.com, hpa@zytor.com, fenghua.yu@intel.com,
        hpa@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, ravi.v.shankar@intel.com
In-Reply-To: <1524508162-192587-1-git-send-email-fenghua.yu@intel.com>
References: <1524508162-192587-1-git-send-email-fenghua.yu@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpufeatures: Enumerate cldemote instruction
Git-Commit-ID: ec8c7206b71d46ee50a23697933dfafec8d5c426
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ec8c7206b71d46ee50a23697933dfafec8d5c426
Gitweb:     https://git.kernel.org/tip/ec8c7206b71d46ee50a23697933dfafec8d5c426
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Mon, 23 Apr 2018 11:29:22 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 25 Apr 2018 10:56:24 +0200

x86/cpufeatures: Enumerate cldemote instruction

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>
Link: https://lkml.kernel.org/r/1524508162-192587-1-git-send-email-fenghua.yu@intel.com

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
