Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 46QEOHNHGVu0PQAAmS7hNA
	; Thu, 07 Jun 2018 14:56:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97AF4607E7; Thu,  7 Jun 2018 14:56:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7EDE76074D;
	Thu,  7 Jun 2018 14:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EDE76074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935516AbeFGO4W (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:56:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41092 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932688AbeFGO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:56:19 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zp-Ua; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jU-Lg; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, arjan@linux.intel.com,
        gnomes@lxorguk.ukuu.org.uk, karahmed@amazon.de,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        torvalds@linux-foundation.org, dave.hansen@intel.com,
        ak@linux.intel.com, gregkh@linux-foundation.org,
        ashok.raj@intel.com, "David Woodhouse" <dwmw@amazon.co.uk>,
        bp@alien8.de, peterz@infradead.org, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.870074724@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 042/410] x86/cpufeatures: Add AMD feature bits for
 Speculation Control
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 5d10cbc91d9eb5537998b65608441b592eec65e7 upstream.

AMD exposes the PRED_CMD/SPEC_CTRL MSRs slightly differently to Intel.
See http://lkml.kernel.org/r/2b3e25cc-286d-8bd0-aeaf-9ac4aae39de8@amd.com

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-4-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: This CPUID word wasn't used at all yet, so
 add it as feature word 11]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h | 7 ++++++-
 arch/x86/kernel/cpu/common.c      | 5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -8,7 +8,7 @@
 #include <asm/required-features.h>
 #endif
 
-#define NCAPINTS	11	/* N 32-bit words worth of info */
+#define NCAPINTS	12	/* N 32-bit words worth of info */
 #define NBUGINTS	1	/* N 32-bit bug flags */
 
 /*
@@ -239,6 +239,11 @@
 #define X86_FEATURE_STIBP		(10*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(10*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
 
+/* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 11 */
+#define X86_FEATURE_AMD_PRED_CMD	(11*32+12) /* Prediction Command MSR (AMD) */
+#define X86_FEATURE_AMD_SPEC_CTRL	(11*32+14) /* Speculation Control MSR only (AMD) */
+#define X86_FEATURE_AMD_STIBP		(11*32+15) /* Single Thread Indirect Branch Predictors (AMD) */
+
 /*
  * BUG word(s)
  */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -716,10 +716,13 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	}
 
 	if (c->extended_cpuid_level >= 0x80000008) {
-		u32 eax = cpuid_eax(0x80000008);
+		u32 eax, ebx, ecx, edx;
+
+		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
 
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
+		c->x86_capability[11] = ebx;
 	}
 #ifdef CONFIG_X86_32
 	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
