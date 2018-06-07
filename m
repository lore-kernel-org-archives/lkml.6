Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rCIKKoNCGVtofAAAmS7hNA
	; Thu, 07 Jun 2018 14:38:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 23A2F608C1; Thu,  7 Jun 2018 14:38:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A733602FC;
	Thu,  7 Jun 2018 14:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A733602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934219AbeFGOiU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:38:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40466 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934180AbeFGOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:38:01 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbw-0005Zp-Vh; Thu, 07 Jun 2018 15:09:57 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002kd-A2; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, kvm@vger.kernel.org,
        "KarimAllah Ahmed" <karahmed@amazon.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
        "Darren Kenny" <darren.kenny@oracle.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Jun Nakajima" <jun.nakajima@intel.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Asit Mallick" <asit.k.mallick@intel.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.971111777@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 056/410] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
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

From: KarimAllah Ahmed <karahmed@amazon.de>

commit 28c1c9fabf48d6ad596273a11c46e0d0da3e14cd upstream.

Intel processors use MSR_IA32_ARCH_CAPABILITIES MSR to indicate RDCL_NO
(bit 0) and IBRS_ALL (bit 1). This is a read-only MSR. By default the
contents will come directly from the hardware, but user-space can still
override it.

[dwmw2: The bit in kvm_cpuid_7_0_edx_x86_features can be unconditional]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: kvm@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Link: https://lkml.kernel.org/r/1517522386-18410-4-git-send-email-karahmed@amazon.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Add mapping of the relevant CPUID word
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/cpuid.c | 11 +++++++++--
 arch/x86/kvm/cpuid.h |  8 ++++++++
 arch/x86/kvm/vmx.c   | 15 +++++++++++++++
 arch/x86/kvm/x86.c   |  3 ++-
 4 files changed, 34 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -316,6 +316,10 @@ static inline int __do_cpuid_ent(struct
 		F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | f_mpx | F(RDSEED) |
 		F(ADX) | F(SMAP);
 
+	/* cpuid 7.0.edx*/
+	const u32 kvm_cpuid_7_0_edx_x86_features =
+		F(ARCH_CAPABILITIES);
+
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
 
@@ -387,11 +391,14 @@ static inline int __do_cpuid_ent(struct
 			cpuid_mask(&entry->ebx, 9);
 			// TSC_ADJUST is emulated
 			entry->ebx |= F(TSC_ADJUST);
-		} else
+			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
+			cpuid_mask(&entry->edx, 10);
+		} else {
 			entry->ebx = 0;
+			entry->edx = 0;
+		}
 		entry->eax = 0;
 		entry->ecx = 0;
-		entry->edx = 0;
 		break;
 	}
 	case 9:
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -115,5 +115,13 @@ static inline bool guest_cpuid_has_ibpb(
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
 }
 
+static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 7, 0);
+	return best && (best->edx & bit(X86_FEATURE_ARCH_CAPABILITIES));
+}
+
 
 #endif
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -432,6 +432,8 @@ struct vcpu_vmx {
 	u64 		      msr_guest_kernel_gs_base;
 #endif
 
+	u64 		      arch_capabilities;
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	/*
@@ -2522,6 +2524,12 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc();
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_arch_capabilities(vcpu))
+			return 1;
+		msr_info->data = to_vmx(vcpu)->arch_capabilities;
+		break;
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
@@ -2641,6 +2649,11 @@ static int vmx_set_msr(struct kvm_vcpu *
 		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
 					      MSR_TYPE_W);
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated)
+			return 1;
+		vmx->arch_capabilities = data;
+		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
 			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
@@ -4584,6 +4597,8 @@ static int vmx_vcpu_setup(struct vcpu_vm
 		++vmx->nmsrs;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
 
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -893,7 +893,8 @@ static u32 msrs_to_save[] = {
 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
-	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS
+	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS,
+	MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
