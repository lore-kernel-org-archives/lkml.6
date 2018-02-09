Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185414-2-13661688604065746725
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185413; b=Ct9/gop1dM7jGRLfo5UV9MaYa1A3UjwI9+JmwxUsRJP41aa
    K5IvWqYshMN6qJsF89UMEWU2K+rJ+zOCDzyycvQKvNUy6MycBTvW0E6Q3BQ6W4Ik
    uafhJKEbIYPRF5rTZTqNdXx1DB663BWAyhci54SQe3AU9nnpxk1GE7czFTLnuojw
    ONEVwhAYxX8dBR+M8KO8xFw/rxhjIAP3aUtgaTnirNqGhk/Sxu0SuBus+K/488n2
    K1hj2ec3Bl7OItC+j9Np6AxVmJQ26uuCQuhU6d7ygAcVd33+6AMWmTFlM5TiFPgf
    B/B06ghoT4k2Oykfkf2I3X3OKvYp5vX8XTCFLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185413; bh=eT/tZIetHJcnxWAdPH4dmpqnby
    QEFq0Tw0CwUsX2S0c=; b=cri3cIfQ0GuhxNRmdLUc5RdaLlNYkRDgAvf/+H4ZGB
    q76BhlatxuH2nZiqcQEeRCsVxC2/WF1gc5W3g9QHX5Ax9+Rrfviv8WFKnhX4edcj
    fM7ItHgHYLncmKhKPXUeMDsreq6kPfq6RBloyS1/o/5psdYqWRi5/4I4M7NUuHuj
    Jda7VUzvxLSyw9H1lRq4Ns9CrUkT0+oty8A5E4b43I8Djr4465j5cNUUC3DunXND
    Dyz56WWhND+75LoBKQ3f5Ny40Be0AWW1pjHfF+epaOVhbZm75ohPuC7YU/2Tgar6
    yUoco85WjFNBbQeMvuIdpaH6z5lyJZ1ZG1z3ttZDBtfA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbeBINmV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBINmT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, dave.hansen@intel.com, karahmed@amazon.de,
        arjan@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, bp@alien8.de, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com, gregkh@linux-foundation.org
Subject: [PATCH 4.9 44/92] x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes
Date: Fri,  9 Feb 2018 14:39:13 +0100
Message-Id: <20180209133934.338022136@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit a5b2966364538a0e68c9fa29bc0a3a1651799035)

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
---
 arch/x86/include/asm/intel-family.h |    7 ++-
 arch/x86/kernel/cpu/intel.c         |   66 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)

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
@@ -61,6 +61,59 @@ void check_mpx_erratum(struct cpuinfo_x8
 	}
 }
 
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
@@ -87,6 +140,19 @@ static void early_init_intel(struct cpui
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
