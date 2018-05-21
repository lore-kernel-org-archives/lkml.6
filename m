Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937355-2-2883002564326930130
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937354; b=a2iMAWomrO3BaI2Vg7r/ePPeGRsDvUKXKR+9hmjoyexDKLYPCA
    hAW7XkzHYQzzW272W7sK4IYWhjX2/j42aDc1YoZKggx4UsoBCpWc4ucupNuAHurj
    gmzHsK23VJUDAWtQaviFIhaGAT6/VljBJTcSECwrkjIf8dO36KW2F8E86dUO0K6a
    Yn3tFCKTrcORZ7ctM44IsBIZ7apyLSuxMmBa03ezfIiwXe7eIqAKwo7F7N3mi1Ad
    BLVk1RuBc+MJ6+6R9kkrKseLTOMBU+7EZnehlHcV69VD8A5/YSzPKUIHoUJ3bFhA
    PaQshb35OqeC6mPtMNi9ZNHgFUitFhwqyQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937354; bh=ILuYAxXE5D4GGLG27dUQUNoNuDhO1p
    5xHjNVUhnbBvg=; b=RjLzkLKtq9ouFeNZTJK3lHULjOPGdezK9svKmAIJU95sjM
    BSOxrHqXU84DjnMn3QbM9oaWf6bODRGRWkI9f0JOHpxbjUiQhudb5BciSVwwPOKr
    r0Y5F9xWXMPpS1niNYgqdNnhxFSxMopjgIvE5mQPbabX+ovoqWOYaLdYyRyUwiro
    g6oi6nqIdC9sJ1q1j6nFsZmcFD+aEogvpzDDxXbjKoTqNsJDyhBvqrBxFITxFst/
    xsl1TMoD6yM3GMVXTFmGPWN8OwfesxdjxLnYgfGhGZ2T39zX4QazTTUOnGFMbB0F
    S6PsqQxUeWF74EMk6jfUfRVZCL9V8TtGqOnmM5KQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ShaHoMV6 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ShaHoMV6 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfN9Jjyw7ckmUbxFMxf21iV6Ml5B0t8q2PGB2MH6dTO6cXz0QAp2vIckzIDEK2wrysS5ZiUdvtqk/KUZQ4i2URMWRpBg7STWWh1Ph5jr19j0yRSxCdedZ
    SqHhmFvvXleXWYljyMb/r0t0UHtMS2TH39G4pASiuy9mVHjEGWB8Dq9CWTqIvpUv/M4csfh3nNhGZkV7uLM0aDvvk++TV0tFhVirlmAUsczPFCToy3uLmvxC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pBOR-ozoAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=3YBwCez8VKC7PNCDsb0A:9 a=ZxcDxVLH2Ml4beXb:21 a=NwdB0vOCpFC34ipw:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeEUVPv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752778AbeEUVPo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:15:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 46/87] x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if requested
Date: Mon, 21 May 2018 23:11:22 +0200
Message-Id: <20180521210424.669161710@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
@@ -205,6 +205,7 @@
 #define X86_FEATURE_USE_IBPB	( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW	( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE ( 7*32+23) /* "" Disable Speculative Store Bypass. */
+#define X86_FEATURE_AMD_RDS	(7*32+24)  /* "" AMD RDS implementation */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
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
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/nospec-branch.h>
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
@@ -542,6 +543,26 @@ static void bsp_init_amd(struct cpuinfo_
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
 
 static void early_init_amd(struct cpuinfo_x86 *c)
@@ -827,6 +848,11 @@ static void init_amd(struct cpuinfo_x86
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
@@ -40,6 +40,13 @@ static u64 __ro_after_init x86_spec_ctrl
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
@@ -51,7 +58,8 @@ void __init check_bugs(void)
 
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
-	 * have unknown values.
+	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
+	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
@@ -153,6 +161,14 @@ void x86_spec_ctrl_restore_host(u64 gues
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
 
@@ -442,6 +458,11 @@ static enum ssb_mitigation_cmd __init __
 
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
@@ -468,6 +489,7 @@ static enum ssb_mitigation_cmd __init __
 			x86_spec_ctrl_set(SPEC_CTRL_RDS);
 			break;
 		case X86_VENDOR_AMD:
+			x86_amd_rds_enable();
 			break;
 		}
 	}
@@ -489,6 +511,9 @@ void x86_spec_ctrl_setup_ap(void)
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
@@ -895,6 +895,10 @@ static const __initconst struct x86_cpu_
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
