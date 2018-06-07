Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QXp6J0xOGVtXdwAAmS7hNA
	; Thu, 07 Jun 2018 15:25:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 90010608B8; Thu,  7 Jun 2018 15:25:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A844C6074D;
	Thu,  7 Jun 2018 15:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A844C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964830AbeFGPYr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:24:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41178 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933575AbeFGO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:15 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvby-0005Zm-4a; Thu, 07 Jun 2018 15:09:58 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jo-T6; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
        pbonzini@redhat.com,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, bp@alien8.de,
        "David Woodhouse" <dwmw@amazon.co.uk>, ashok.raj@intel.com,
        peterz@infradead.org, dave.hansen@intel.com,
        gregkh@linux-foundation.org, ak@linux.intel.com,
        gnomes@lxorguk.ukuu.org.uk, arjan@linux.intel.com,
        torvalds@linux-foundation.org,
        "Thomas Gleixner" <tglx@linutronix.de>, karahmed@amazon.de
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.802504492@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 046/410] x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD
 on early Spectre v2  microcodes
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

commit a5b2966364538a0e68c9fa29bc0a3a1651799035 upstream.

This doesn't refuse to load the affected microcodes; it just refuses to
use the Spectre v2 mitigation features if they're detected, by clearing
the appropriate feature bits.

The AMD CPUID bits are handled here too, because hypervisors *may* have
been exposing those bits even on Intel chips, for fine-grained control
of what's available.

It is non-trivial to use x86_match_cpu() for this table because that
doesn't handle steppings. And the approach taken in commit bd9240a18
almost made me lose my lunch.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Link: https://lkml.kernel.org/r/1516896855-7642-7-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: Add #include <asm/intel-family.h>]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/intel-family.h |  7 ++-
 arch/x86/kernel/cpu/intel.c         | 67 +++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -12,6 +12,7 @@
  */
 
 #define INTEL_FAM6_CORE_YONAH		0x0E
+
 #define INTEL_FAM6_CORE2_MEROM		0x0F
 #define INTEL_FAM6_CORE2_MEROM_L	0x16
 #define INTEL_FAM6_CORE2_PENRYN		0x17
@@ -21,6 +22,7 @@
 #define INTEL_FAM6_NEHALEM_G		0x1F /* Auburndale / Havendale */
 #define INTEL_FAM6_NEHALEM_EP		0x1A
 #define INTEL_FAM6_NEHALEM_EX		0x2E
+
 #define INTEL_FAM6_WESTMERE		0x25
 #define INTEL_FAM6_WESTMERE_EP		0x2C
 #define INTEL_FAM6_WESTMERE_EX		0x2F
@@ -36,9 +38,9 @@
 #define INTEL_FAM6_HASWELL_GT3E		0x46
 
 #define INTEL_FAM6_BROADWELL_CORE	0x3D
-#define INTEL_FAM6_BROADWELL_XEON_D	0x56
 #define INTEL_FAM6_BROADWELL_GT3E	0x47
 #define INTEL_FAM6_BROADWELL_X		0x4F
+#define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
 #define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
 #define INTEL_FAM6_SKYLAKE_DESKTOP	0x5E
@@ -57,9 +59,10 @@
 #define INTEL_FAM6_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* CherryTrail / Braswell */
 #define INTEL_FAM6_ATOM_MERRIFIELD	0x4A /* Tangier */
-#define INTEL_FAM6_ATOM_MOOREFIELD	0x5A /* Annidale */
+#define INTEL_FAM6_ATOM_MOOREFIELD	0x5A /* Anniedale */
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C
 #define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
+#define INTEL_FAM6_ATOM_GEMINI_LAKE	0x7A
 
 /* Xeon Phi */
 
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -13,6 +13,7 @@
 #include <asm/msr.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/intel-family.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -25,6 +26,59 @@
 #include <asm/apic.h>
 #endif
 
+/*
+ * Early microcode releases for the Spectre v2 mitigation were broken.
+ * Information taken from;
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://kb.vmware.com/s/article/52345
+ * - Microcode revisions observed in the wild
+ * - Release note from 20180108 microcode release
+ */
+struct sku_microcode {
+	u8 model;
+	u8 stepping;
+	u32 microcode;
+};
+static const struct sku_microcode spectre_bad_microcodes[] = {
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
+	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
+	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
+	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
+	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
+	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
+	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
+	{ INTEL_FAM6_HASWELL_CORE,	0x03,	0x23 },
+	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
+	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
+	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
+	/* Updated in the 20180108 release; blacklist until we know otherwise */
+	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
+	/* Observed in the wild */
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
+};
+
+static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
+		if (c->x86_model == spectre_bad_microcodes[i].model &&
+		    c->x86_mask == spectre_bad_microcodes[i].stepping)
+			return (c->microcode <= spectre_bad_microcodes[i].microcode);
+	}
+	return false;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -51,6 +105,19 @@ static void early_init_intel(struct cpui
 		rdmsr(MSR_IA32_UCODE_REV, lower_word, c->microcode);
 	}
 
+	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_STIBP) ||
+	     cpu_has(c, X86_FEATURE_AMD_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_AMD_PRED_CMD) ||
+	     cpu_has(c, X86_FEATURE_AMD_STIBP)) && bad_spectre_microcode(c)) {
+		pr_warn("Intel Spectre v2 broken microcode detected; disabling SPEC_CTRL\n");
+		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_STIBP);
+		clear_cpu_cap(c, X86_FEATURE_AMD_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_AMD_PRED_CMD);
+		clear_cpu_cap(c, X86_FEATURE_AMD_STIBP);
+	}
+
 	/*
 	 * Atom erratum AAE44/AAF40/AAG38/AAH41:
 	 *
