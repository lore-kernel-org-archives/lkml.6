Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeBZRMG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:12:06 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:45426 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBZRMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:12:05 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] MIPS: VDSO: Replace __mips_isa_rev with MIPS_ISA_REV
Date: Mon, 26 Feb 2018 17:02:45 +0000
Message-ID: <1519664565-10955-5-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
References: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1519665043-321457-2236-2367-4
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

 arch/mips/vdso/elf.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/vdso/elf.S b/arch/mips/vdso/elf.S
index be37bbb1f061..428a1917afc6 100644
--- a/arch/mips/vdso/elf.S
+++ b/arch/mips/vdso/elf.S
@@ -10,6 +10,8 @@
 
 #include "vdso.h"
 
+#include <asm/isa-rev.h>
+
 #include <linux/elfnote.h>
 #include <linux/version.h>
 
@@ -40,11 +42,7 @@ __mips_abiflags:
 	.byte	__mips		/* isa_level */
 
 	/* isa_rev */
-#ifdef __mips_isa_rev
-	.byte	__mips_isa_rev
-#else
-	.byte	0
-#endif
+	.byte	MIPS_ISA_REV
 
 	/* gpr_size */
 #ifdef __mips64
@@ -54,7 +52,7 @@ __mips_abiflags:
 #endif
 
 	/* cpr1_size */
-#if (defined(__mips_isa_rev) && __mips_isa_rev >= 6) || defined(__mips64)
+#if (MIPS_ISA_REV >= 6) || defined(__mips64)
 	.byte	2		/* AFL_REG_64 */
 #else
 	.byte	1		/* AFL_REG_32 */
-- 
2.7.4
