Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654186-1517938448-2-9120946955024158398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517938447; b=PUD2nheqW0Wja9DuHashgU8xrUGR4VQsU06z9wO07nvvxdm
    BGRTXHiRjzkg8rTFGkDCEIolVTkZoLCjpdYQ1gzNI/k4P8UPtFFK/R+BiJYs+KQg
    GTgduG7OQKY1KGqj8AnTSpwm/3QkaPeXmXrnrlQVXTWf1zSkz34bzICu0eNZvRwG
    5ioxrHFAEDO7rhY/KiRt6BoZOSu8RuUthYeTSYihu57B+3aptie/jQucsCZdCuN2
    jHGPBkIFyA7gT/S5WkMRO2DjgLKZTFjd3XjvDWw2W17S/nsgyR0uta6VY8Qamhe3
    6GtmsgKcLNkejmP5yxX6tDx+VQUuDbp8sSWRB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517938447;
    bh=sHuEgu1LoSc4+ey9xLUo+hrSnQw4iRFeJ0GZG442N4s=; b=B5iz5yVAGGh+
    aiD6VyORICGBNrXhzAm1CUrhh1aPKvjRiNfJfKSEgD1JmixsTSU/Wx/QvEP4XTI5
    vNkF/FJsQW+/DaVEOtNywzX8xDUlyKsFy7KimA2LF+5CQ1fGOFXdRVdIjRgMuGxp
    hI3z5/wx5YSfe93bJBd1vNhwTBY34CpOK9exzFrA8Tse+6BMoQTy/gh9ds/bTYpe
    oAJ/mvNWJSs48S2vMmIn5RdPPN49mOzcfkB/195Xa4HY96oPZtmc1672QF+X6iOc
    BhLrFEV9MGNUmsGjTC0j2yfwvUkVCuw2bcuiQTHYbpuBfZdwRwaMu1WxSFmN+vez
    r4Tagl6zRw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=ky7okp98 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=ky7okp98 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeBFRb0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 12:31:26 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11107 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeBFRbQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 12:31:16 -0500
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="718429380"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 7/9] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
Date: Tue,  6 Feb 2018 17:29:39 +0000
Message-Id: <1517938181-15317-8-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: KarimAllah Ahmed <karahmed@amazon.de>

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

(cherry picked from commit 28c1c9fabf48d6ad596273a11c46e0d0da3e14cd)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/cpuid.c |  8 +++++++-
 arch/x86/kvm/cpuid.h |  8 ++++++++
 arch/x86/kvm/vmx.c   | 15 +++++++++++++++
 arch/x86/kvm/x86.c   |  1 +
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6f24483..9c6493f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -380,6 +380,10 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	/* cpuid 7.0.ecx*/
 	const u32 kvm_cpuid_7_0_ecx_x86_features = F(PKU) | 0 /*OSPKE*/;
 
+	/* cpuid 7.0.edx*/
+	const u32 kvm_cpuid_7_0_edx_x86_features =
+		F(ARCH_CAPABILITIES);
+
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
 
@@ -462,12 +466,14 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			/* PKU is not yet implemented for shadow paging. */
 			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
 				entry->ecx &= ~F(PKU);
+			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
+			cpuid_mask(&entry->edx, CPUID_7_EDX);
 		} else {
 			entry->ebx = 0;
 			entry->ecx = 0;
+			entry->edx = 0;
 		}
 		entry->eax = 0;
-		entry->edx = 0;
 		break;
 	}
 	case 9:
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index ec4f9dc..8719997 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -171,6 +171,14 @@ static inline bool guest_cpuid_has_ibpb(struct kvm_vcpu *vcpu)
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
 
 /*
  * NRIPS is provided through cpuidfn 0x8000000a.edx bit 3
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index dd6c831..92bf61f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -551,6 +551,8 @@ struct vcpu_vmx {
 	u64 		      msr_guest_kernel_gs_base;
 #endif
 
+	u64 		      arch_capabilities;
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	/*
@@ -2979,6 +2981,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc(vcpu);
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
@@ -3110,6 +3118,11 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -5200,6 +5213,8 @@ static int vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		++vmx->nmsrs;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
 
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e023ef9..94d1573 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -975,6 +975,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
-- 
2.7.4
