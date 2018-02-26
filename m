Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeBZRG2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:06:28 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:36509 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeBZRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:06:25 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@mips.com>
Subject: [PATCH 2/4] MIPS: cpu-features.h: Replace __mips_isa_rev with MIPS_ISA_REV
Date: Mon, 26 Feb 2018 17:02:43 +0000
Message-ID: <1519664565-10955-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
References: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1519664770-637139-10619-123029-9
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190443
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the need to check that __mips_isa_rev is defined by using the
newly added MIPS_ISA_REV.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/include/asm/cpu-features.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 721b698bfe3c..5f74590e0bea 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -11,6 +11,7 @@
 
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
+#include <asm/isa-rev.h>
 #include <cpu-feature-overrides.h>
 
 /*
@@ -493,7 +494,7 @@
 # define cpu_has_perf		(cpu_data[0].options & MIPS_CPU_PERF)
 #endif
 
-#if defined(CONFIG_SMP) && defined(__mips_isa_rev) && (__mips_isa_rev >= 6)
+#if defined(CONFIG_SMP) && (MIPS_ISA_REV >= 6)
 /*
  * Some systems share FTLB RAMs between threads within a core (siblings in
  * kernel parlance). This means that FTLB entries may become invalid at almost
@@ -525,7 +526,7 @@
 #  define cpu_has_shared_ftlb_entries \
 	(current_cpu_data.options & MIPS_CPU_SHARED_FTLB_ENTRIES)
 # endif
-#endif /* SMP && __mips_isa_rev >= 6 */
+#endif /* SMP && MIPS_ISA_REV >= 6 */
 
 #ifndef cpu_has_shared_ftlb_ram
 # define cpu_has_shared_ftlb_ram 0
-- 
2.7.4
