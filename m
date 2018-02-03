Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x225x3SjTyehBiLQJJJyjnZfoxRhbtDcazQfM2KektPcTKQ0GZVu9cXEaoRuQmxReQ9bXcbuM
ARC-Seal: i=1; a=rsa-sha256; t=1517698471; cv=none;
        d=google.com; s=arc-20160816;
        b=tEmo/l8BnZIbIaNv6ihjm/Dv6Aw9UnX9Z4zo07o8rqJ7cwaJAIs/bBSDx7Y992kPTh
         Zd8FaNoSGnlzYZ/p1oCsqBqAXHQLuXCPL0tpjc36o/YGrZLk3wy8QB+iflbGpLIeJhpN
         xkrfMRO8K+ZcZaiY6E0yzM5zwcBW50qYnm3Z+Ag1eKL24qLHrZLva9wz4W71G2SAHw8+
         Tirs2V7dVXOFbyE6TKJWQeYUUJNWXmgL+7iY4uyT1ejHP3KyGh0CVUaAz1YFB11KkdV5
         sEzXx+pQFam+AvYWa3Z9erbnp9JM3PElqu6npoHi32ud20tm8PlEOwJdUhNkuEGC89xK
         YgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=VB9qCEu4myWPNrB1q63Mvxsd67IedLBOKSUT+1Pfm8M=;
        b=sbUjE/1Qrq6onjk5zum2PXVHe3b4/AhA1r802fwuGh1W+KwPSMsP5XTKDU3Uld1BQy
         J7JFShB6ddYhhbpaEV3db7ShF8KvOxe8A/81YUr5wJgchrve+hyI5FTk8kcu2hf/hQFc
         W0eO/5aLeROweqdQZS93lGuG1A4DKL2JC1HW0FaAuUXS73hD7E+C61vUDzzkWQ3GAKmG
         RLpMDGFyMhosgWumbS+7wyKq3dWEpaYubEUNMwj1XXvgKFvHV1xVghlV77dtL11o8Yzv
         r6xg0Gu3j2wHaQqKdw4vKUJkMaZBbynLfK7bwgBef//r3mnkcMM2M/9YS3boeZBBzbmv
         yjsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 3 Feb 2018 14:51:20 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-28c1c9fabf48d6ad596273a11c46e0d0da3e14cd@git.kernel.org>
Cc: darren.kenny@oracle.com, jun.nakajima@intel.com, ak@linux.intel.com,
        gregkh@linuxfoundation.org, konrad.wilk@oracle.com,
        jmattson@google.com, ashok.raj@intel.com, tim.c.chen@linux.intel.com,
        aarcange@redhat.com, karahmed@amazon.de, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, dave.hansen@intel.com,
        pbonzini@redhat.com, arjan.van.de.ven@intel.com, mingo@kernel.org,
        asit.k.mallick@intel.com, dan.j.williams@intel.com, dwmw@amazon.co.uk
Reply-To: mingo@kernel.org, arjan.van.de.ven@intel.com,
        dan.j.williams@intel.com, dwmw@amazon.co.uk, asit.k.mallick@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        pbonzini@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        karahmed@amazon.de, aarcange@redhat.com, tglx@linutronix.de,
        ak@linux.intel.com, darren.kenny@oracle.com, jun.nakajima@intel.com,
        ashok.raj@intel.com, tim.c.chen@linux.intel.com,
        gregkh@linuxfoundation.org, konrad.wilk@oracle.com,
        jmattson@google.com
In-Reply-To: <1517522386-18410-4-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-4-git-send-email-karahmed@amazon.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
Git-Commit-ID: 28c1c9fabf48d6ad596273a11c46e0d0da3e14cd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591422191914668564?=
X-GMAIL-MSGID: =?utf-8?q?1591422191914668564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  28c1c9fabf48d6ad596273a11c46e0d0da3e14cd
Gitweb:     https://git.kernel.org/tip/28c1c9fabf48d6ad596273a11c46e0d0da3e14cd
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Thu, 1 Feb 2018 22:59:44 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 3 Feb 2018 23:06:52 +0100

KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES

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

---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/vmx.c   | 15 +++++++++++++++
 arch/x86/kvm/x86.c   |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 033004d..1909635 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -394,7 +394,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 73acdcf..e5f75eb 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -594,6 +594,8 @@ struct vcpu_vmx {
 	u64 		      msr_guest_kernel_gs_base;
 #endif
 
+	u64 		      arch_capabilities;
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	u32 secondary_exec_control;
@@ -3260,6 +3262,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc(vcpu);
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+			return 1;
+		msr_info->data = to_vmx(vcpu)->arch_capabilities;
+		break;
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
@@ -3395,6 +3403,11 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -5657,6 +5670,8 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		++vmx->nmsrs;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
 
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c53298d..4ec142e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1009,6 +1009,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
