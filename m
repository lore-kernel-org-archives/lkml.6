Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938010-2-6396560646142665513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938009; b=j8qjPrjlegERzdhPGKDHaGCxwAWk8Jznxb8abZl8Glcj4AgchA
    OC5UxrsNwFPjfV+5ntHoQLI7VTRVatb26MJc9z0S4mLfG6m8Nw72bHTIb7NodXfU
    oOBgJyJOi6dXKy2ErcIzWan67yG4boMzeiH1ITHWyljHtd3ZhIxMw/Pb8lEP8iwi
    A338rITy2izKU+goR4qhgJmzoojUUX5c5gX6C0C/4rVoLZh7u+OZgv/LbH/ZWLhg
    bEi47gz55PKC/0/shFa3kgnuN5AG4Si1+hvrPe7SdtzTIpv+ULeXIzkkkrsIMyd9
    KuyHxKlomMLNVrpzHzkVntYXPgKl3jlaB/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938009; bh=2lIDQ0B5ziFBqev0Jm/qzGl2RSqz3P
    e9Zrbw1Bi50K0=; b=mS1fiN4sNj3iZ8rHe7vimGJE1VJgcPjgBjt2m+7xH/AcFI
    XZufbH0KR6WBX4THgFvTlWquRSw+LN16UqU/Sd1GR455uPOynwyeDvCZmV8LRs/D
    S6duwWE0rLBBexkYrmHddNN3zewHi+rejdoXDHsYg8ajKe46jCn2cvM6Nvx2Zt8i
    CijE9N9VSqzpBfNF9sKqU6pR8R1Oy2t/RO90grvVu+3KpkLX10tLMB5lfst/q1w3
    jDRTvFl+0v7r3NhkIiB0uHEIPYlyPrlpWceXaCXXlfJHU+xGkGWtgTgezNfmUUTC
    MKVbba/pREwjw8abvNGHVpCBEoWDky612PGhfIEg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=c8MAmvmE x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=c8MAmvmE x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHXc+f3rqTZ5MmjDOQgjeZOWCbNhy55UCr+b4+ojIwKne1m9Flx+R9IZSL+H7aoVSQg0GsFk/6jVQ1had+3lVGV6I6cN83eJnw+N4M6ri4yT7HQVi6lZ
    wUz27l+kQEE/yFo6agdPCxFbrHOBly/+ouV0RDL6epUIOhjwbHVP/EwyODIxQPFptoNA76PmjOIOfi8zEmwW6Q3Gv+FJV94xucwyI1HjuySqpZRt+dgm92si
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=3YBwCez8VKC7PNCDsb0A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932615AbeEUV0m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932569AbeEUV0k (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 072/110] x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if requested
Date: Mon, 21 May 2018 23:12:09 +0200
Message-Id: <20180521210512.520180832@linuxfoundation.org>
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

commit 764f3c21588a059cd783c6ba0734d4db2d72822d upstream

AMD does not need the Speculative Store Bypass mitigation to be enabled.

The parameters for this are already available and can be done via MSR
C001_1020. Each family uses a different bit in that MSR for this.

[ tglx: Expose the bit mask via a variable and move the actual MSR fiddling
  	into the bugs code as that's the right thing to do and also required
	to prepare for dynamic enable/disable ]

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h   |    1 +
 arch/x86/include/asm/nospec-branch.h |    4 ++++
 arch/x86/kernel/cpu/amd.c            |   26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   27 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         |    4 ++++
 5 files changed, 61 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -215,6 +215,7 @@
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
+#define X86_FEATURE_AMD_RDS		(7*32+24)  /* "" AMD RDS implementation */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -244,6 +244,10 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_DISABLE,
 };
 
+/* AMD specific Speculative Store Bypass MSR data */
+extern u64 x86_amd_ls_cfg_base;
+extern u64 x86_amd_ls_cfg_rds_mask;
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -10,6 +10,7 @@
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/nospec-branch.h>
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
@@ -554,6 +555,26 @@ static void bsp_init_amd(struct cpuinfo_
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
 		nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
+
+	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
+		unsigned int bit;
+
+		switch (c->x86) {
+		case 0x15: bit = 54; break;
+		case 0x16: bit = 33; break;
+		case 0x17: bit = 10; break;
+		default: return;
+		}
+		/*
+		 * Try to cache the base value so further operations can
+		 * avoid RMW. If that faults, do not enable RDS.
+		 */
+		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_RDS);
+			setup_force_cpu_cap(X86_FEATURE_AMD_RDS);
+			x86_amd_ls_cfg_rds_mask = 1ULL << bit;
+		}
+	}
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -898,6 +919,11 @@ static void init_amd(struct cpuinfo_x86
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+
+	if (boot_cpu_has(X86_FEATURE_AMD_RDS)) {
+		set_cpu_cap(c, X86_FEATURE_RDS);
+		set_cpu_cap(c, X86_FEATURE_AMD_RDS);
+	}
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -41,6 +41,13 @@ static u64 __ro_after_init x86_spec_ctrl
  */
 static u64 __ro_after_init x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
 
+/*
+ * AMD specific MSR info for Speculative Store Bypass control.
+ * x86_amd_ls_cfg_rds_mask is initialized in identify_boot_cpu().
+ */
+u64 __ro_after_init x86_amd_ls_cfg_base;
+u64 __ro_after_init x86_amd_ls_cfg_rds_mask;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -52,7 +59,8 @@ void __init check_bugs(void)
 
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
-	 * have unknown values.
+	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
+	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
@@ -154,6 +162,14 @@ void x86_spec_ctrl_restore_host(u64 gues
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
 
+static void x86_amd_rds_enable(void)
+{
+	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_rds_mask;
+
+	if (boot_cpu_has(X86_FEATURE_AMD_RDS))
+		wrmsrl(MSR_AMD64_LS_CFG, msrval);
+}
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -443,6 +459,11 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
+		/*
+		 * AMD platforms by default don't need SSB mitigation.
+		 */
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+			break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
@@ -469,6 +490,7 @@ static enum ssb_mitigation_cmd __init __
 			x86_spec_ctrl_set(SPEC_CTRL_RDS);
 			break;
 		case X86_VENDOR_AMD:
+			x86_amd_rds_enable();
 			break;
 		}
 	}
@@ -490,6 +512,9 @@ void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
+
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
+		x86_amd_rds_enable();
 }
 
 #ifdef CONFIG_SYSFS
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -934,6 +934,10 @@ static const __initconst struct x86_cpu_
 	{ X86_VENDOR_CENTAUR,	5,					},
 	{ X86_VENDOR_INTEL,	5,					},
 	{ X86_VENDOR_NSC,	5,					},
+	{ X86_VENDOR_AMD,	0x12,					},
+	{ X86_VENDOR_AMD,	0x11,					},
+	{ X86_VENDOR_AMD,	0x10,					},
+	{ X86_VENDOR_AMD,	0xf,					},
 	{ X86_VENDOR_ANY,	4,					},
 	{}
 };
