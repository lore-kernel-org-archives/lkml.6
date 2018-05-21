Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938001-2-15484710585745375460
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938000; b=Rninod2zj1m6nN5hMexBJNubCxYM3Y6te7ME9Vz9fd1jUuNdZ4
    PnVIH6726rp2I1iTYsJW/OWtgvKWVxJV+fhdoJAmoFk8daXABi3zIu0h2zHHOIIr
    5nzrBKzuBMdmAMgANquQ6C4lVJQ0R06gJbTRZNTJ/nMb8MFrU4HLpi+vNxyADc6u
    A9wZ4RP2gGJIDjtApa+P/mtHa2b146RLTNaQ1IcyBZtFKud1sJQt/+XzZv9ex710
    8IJF6G9VMR3k2EFM3Q+imagCWITgJUHiSUR8m88mruisLMHnhkdl235GwQXDQAiT
    VeAZBDT2HT800WsbLe06uySN8UbQtNQEworg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938000; bh=tlZi1C0iJWLh48R61rGHktC4zWm2TN
    99fAWcCZ6hP1g=; b=gd2f4iqXR3XPtW28dI0bUvZRGQqtv5uGeQQ34X3tcn1Jya
    uXphlWDxA5WIATu9D5iTpxUr/RUV46Kz054sH6KLYqoWansvTYQ6Qv/lILZpPDwC
    B25Q1Y/aytJl7HnbFj+pPNgNbEZCWjIsfPVdxzvYVaSkbF7DPjpy3pEmhcIGYHhn
    7hflCloiT7Y+lxcwFtbTSwLqaOZQOv0wy8Q2byHzChPfoUls91pB7dNejxGtBC5n
    HncobD4oyF/rkOsikJ4G8GAk5QV0Z4RxoJhlnGxdxtvbMIyFSfbgfYOG9XZswNu9
    l+E291GaBRSdJ7JlCOX0nyDqIJ1+3ZrTEK6ZtLjA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=GI5Ivlgi x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=GI5Ivlgi x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNI/0jQwYWriyFqMqjsKAB3Bqeb7Ei0NaiJAn4NhdGLqc9I92QTuEF3t8XDagsVvgVnAR7a9Q8kDGKVR9D71iey/+QmCwRB1lU+0CqWDQS/7VF0O6KyI
    WaXt8k0QMAdDfBoYeUS5Nz9RftgsgMm4qFTAUJ1/Q+w6Hes2wEmt3JZgLCq3JcKn9sZbdieNcqOw82pz7COCjdf3tUERguBhfD7kqbiZ7NYWrrMvgtdpEV77
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=GUy_7o7z5A3psqLLQQkA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeEUV0i (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932580AbeEUV0e (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 070/110] x86/bugs/intel: Set proper CPU features and setup RDS
Date: Mon, 21 May 2018 23:12:07 +0200
Message-Id: <20180521210512.370348797@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 772439717dbf703b39990be58d8d4e3e4ad0598a upstream

Intel CPUs expose methods to:

 - Detect whether RDS capability is available via CPUID.7.0.EDX[31],

 - The SPEC_CTRL MSR(0x48), bit 2 set to enable RDS.

 - MSR_IA32_ARCH_CAPABILITIES, Bit(4) no need to enable RRS.

With that in mind if spec_store_bypass_disable=[auto,on] is selected set at
boot-time the SPEC_CTRL MSR to enable RDS if the platform requires it.

Note that this does not fix the KVM case where the SPEC_CTRL is exposed to
guests which can muck with it, see patch titled :
 KVM/SVM/VMX/x86/spectre_v2: Support the combination of guest and host IBRS.

And for the firmware (IBRS to be set), see patch titled:
 x86/spectre_v2: Read SPEC_CTRL MSR during boot and re-use reserved bits

[ tglx: Distangled it from the intel implementation and kept the call order ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    6 ++++++
 arch/x86/kernel/cpu/bugs.c       |   30 ++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c     |   10 ++++++----
 arch/x86/kernel/cpu/cpu.h        |    2 ++
 arch/x86/kernel/cpu/intel.c      |    1 +
 5 files changed, 43 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -42,6 +42,7 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
@@ -68,6 +69,11 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+#define ARCH_CAP_RDS_NO			(1 << 4)   /*
+						    * Not susceptible to Speculative Store Bypass
+						    * attack, so no Reduced Data Speculation control
+						    * required.
+						    */
 
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -117,7 +117,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~SPEC_CTRL_IBRS)
+	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -444,8 +444,28 @@ static enum ssb_mitigation_cmd __init __
 		break;
 	}
 
-	if (mode != SPEC_STORE_BYPASS_NONE)
+	/*
+	 * We have three CPU feature flags that are in play here:
+	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
+	 *  - X86_FEATURE_RDS - CPU is able to turn off speculative store bypass
+	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
+	 */
+	if (mode != SPEC_STORE_BYPASS_NONE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
+		/*
+		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
+		 * a completely different MSR and bit dependent on family.
+		 */
+		switch (boot_cpu_data.x86_vendor) {
+		case X86_VENDOR_INTEL:
+			x86_spec_ctrl_base |= SPEC_CTRL_RDS;
+			x86_spec_ctrl_set(SPEC_CTRL_RDS);
+			break;
+		case X86_VENDOR_AMD:
+			break;
+		}
+	}
+
 	return mode;
 }
 
@@ -459,6 +479,12 @@ static void ssb_select_mitigation()
 
 #undef pr_fmt
 
+void x86_spec_ctrl_setup_ap(void)
+{
+	if (boot_cpu_has(X86_FEATURE_IBRS))
+		x86_spec_ctrl_set(x86_spec_ctrl_base & (SPEC_CTRL_IBRS | SPEC_CTRL_RDS));
+}
+
 #ifdef CONFIG_SYSFS
 
 ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -942,7 +942,11 @@ static void __init cpu_set_bug_bits(stru
 {
 	u64 ia32_cap = 0;
 
-	if (!x86_match_cpu(cpu_no_spec_store_bypass))
+	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
+	   !(ia32_cap & ARCH_CAP_RDS_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
@@ -954,9 +958,6 @@ static void __init cpu_set_bug_bits(stru
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
-	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
-
 	/* Rogue Data Cache Load? No! */
 	if (ia32_cap & ARCH_CAP_RDCL_NO)
 		return;
@@ -1371,6 +1372,7 @@ void identify_secondary_cpu(struct cpuin
 #endif
 	mtrr_ap_init();
 	validate_apic_and_package_id(c);
+	x86_spec_ctrl_setup_ap();
 }
 
 static __init int setup_noclflush(char *arg)
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -50,4 +50,6 @@ extern void cpu_detect_cache_sizes(struc
 
 unsigned int aperfmperf_get_khz(int cpu);
 
+extern void x86_spec_ctrl_setup_ap(void);
+
 #endif /* ARCH_X86_CPU_H */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -189,6 +189,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_RDS);
 	}
 
 	/*
