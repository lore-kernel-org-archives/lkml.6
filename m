Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x226OHYKekj3/Rgp/nfsDS9RRK1x9oJyx0ef6i/kige7WZclS7N2lqw17py4SJfaW4bJdH5tD
ARC-Seal: i=1; a=rsa-sha256; t=1517698464; cv=none;
        d=google.com; s=arc-20160816;
        b=PHHWW0+Q4N6LwdVTJqHrsVHvb6Eb6J50w1MIKNFAI30PcxU/xE+EDG6lTEbYxJaklw
         i/QSusnsc5OY/7GOydJhR+pll79Bs7CzEb/I1/0cOBy/tvqEA1wrdBbDjeQzHD0Lv83K
         4iSqgHhqH6zzNkAF3UuX2yhS69eMrEgMi4AV8Z9+mipbXnPYaMRaf1V7Q8gbxtR3dawV
         ACHGdvoSDbv6T6IUUhbiX0LUQ1jRp45ePxhEPM3YIre88VmkLc83Q/D0RGVKOiWV7sOC
         0MWwIy/brVAf4Q3gshvLN90+3j/gXoDLtxmeNlnw+a4IRFjILDkJU5gB8wWd9GTUSyN7
         vr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=36s8cP3wLIx8epx28EuwxOKzSSDPl8UvF2WTSCmkb0k=;
        b=zybDFGrfSOMn+DoiYM4M5LPTAe1uRA0MmMq+vbUpvd/zq1Uoz7TL30l2Ti8IcrmzDH
         NjjD5n5+x/wqUPkfZhBwmPLZzDH7WFHT21U1pqRFy0Ap/lIqZQFUzQk7Gn/ULSbOmqiG
         kJ9sU9LK7R7joUn0m4lrRT7TjrcmVO0FJ0+JLgAWFTBTm4/GyloDNt915l90fH8Tc8uN
         zFw3LeqogzVm6Ggn7joRw3AR5dAT0avrE3XRS+FNMiyuVNUQPTM59zrhLvu+wpMZP193
         94qo/XS5/c1yLHt8Yk/1Yu4/Nfhh24NUzwIdbVv4BbCwu4OxpkM7rtLWPzXP6XwHUSle
         cKWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 65.50.211.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sat, 3 Feb 2018 14:52:13 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-b2ac58f90540e39324e7a29a7ad471407ae0bf48@git.kernel.org>
Cc: dan.j.williams@intel.com, hpa@zytor.com, gregkh@linuxfoundation.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, tim.c.chen@linux.intel.com,
        aarcange@redhat.com, dwmw@amazon.co.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com,
        jun.nakajima@intel.com, ashok.raj@intel.com, karahmed@amazon.de,
        dave.hansen@intel.com, ak@linux.intel.com, luto@kernel.org,
        darren.kenny@oracle.com
Reply-To: dave.hansen@intel.com, karahmed@amazon.de, ashok.raj@intel.com,
        darren.kenny@oracle.com, ak@linux.intel.com, luto@kernel.org,
        tglx@linutronix.de, aarcange@redhat.com, dwmw@amazon.co.uk,
        tim.c.chen@linux.intel.com, jun.nakajima@intel.com,
        arjan.van.de.ven@intel.com, asit.k.mallick@intel.com,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, mingo@kernel.org,
        torvalds@linux-foundation.org, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, hpa@zytor.com
In-Reply-To: <1517669783-20732-1-git-send-email-karahmed@amazon.de>
References: <1517669783-20732-1-git-send-email-karahmed@amazon.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL
Git-Commit-ID: b2ac58f90540e39324e7a29a7ad471407ae0bf48
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591422185408699926?=
X-GMAIL-MSGID: =?utf-8?q?1591422185408699926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  b2ac58f90540e39324e7a29a7ad471407ae0bf48
Gitweb:     https://git.kernel.org/tip/b2ac58f90540e39324e7a29a7ad471407ae0bf48
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Sat, 3 Feb 2018 15:56:23 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 3 Feb 2018 23:06:52 +0100

KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL

[ Based on a patch from Paolo Bonzini <pbonzini@redhat.com> ]

... basically doing exactly what we do for VMX:

- Passthrough SPEC_CTRL to guests (if enabled in guest CPUID)
- Save and restore SPEC_CTRL around VMExit and VMEntry only if the guest
  actually used it.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: kvm@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Link: https://lkml.kernel.org/r/1517669783-20732-1-git-send-email-karahmed@amazon.de

---
 arch/x86/kvm/svm.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 254eefb..4e3c795 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -184,6 +184,8 @@ struct vcpu_svm {
 		u64 gs_base;
 	} host;
 
+	u64 spec_ctrl;
+
 	u32 *msrpm;
 
 	ulong nmi_iret_rip;
@@ -249,6 +251,7 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_CSTAR,				.always = true  },
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
+	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
@@ -882,6 +885,25 @@ static bool valid_msr_intercept(u32 index)
 	return false;
 }
 
+static bool msr_write_intercepted(struct kvm_vcpu *vcpu, unsigned msr)
+{
+	u8 bit_write;
+	unsigned long tmp;
+	u32 offset;
+	u32 *msrpm;
+
+	msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm:
+				      to_svm(vcpu)->msrpm;
+
+	offset    = svm_msrpm_offset(msr);
+	bit_write = 2 * (msr & 0x0f) + 1;
+	tmp       = msrpm[offset];
+
+	BUG_ON(offset == MSR_INVALID);
+
+	return !!test_bit(bit_write,  &tmp);
+}
+
 static void set_msr_interception(u32 *msrpm, unsigned msr,
 				 int read, int write)
 {
@@ -1584,6 +1606,8 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u32 dummy;
 	u32 eax = 1;
 
+	svm->spec_ctrl = 0;
+
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
 					   MSR_IA32_APICBASE_ENABLE;
@@ -3605,6 +3629,13 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_VM_CR:
 		msr_info->data = svm->nested.vm_cr_msr;
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+			return 1;
+
+		msr_info->data = svm->spec_ctrl;
+		break;
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = 0x01000065;
 		break;
@@ -3696,6 +3727,33 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+			return 1;
+
+		/* The STIBP bit doesn't fault even if it's not advertised */
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+			return 1;
+
+		svm->spec_ctrl = data;
+
+		if (!data)
+			break;
+
+		/*
+		 * For non-nested:
+		 * When it's written (to non-zero) for the first time, pass
+		 * it through.
+		 *
+		 * For nested:
+		 * The handling of the MSR bitmap for L2 guests is done in
+		 * nested_svm_vmrun_msrpm.
+		 * We update the L1 MSR bit as well since it will end up
+		 * touching the MSR anyway now.
+		 */
+		set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
+		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
@@ -4964,6 +5022,15 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	local_irq_enable();
 
+	/*
+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
+	 * is no need to worry about the conditional branch over the wrmsr
+	 * being speculatively taken.
+	 */
+	if (svm->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
 		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
@@ -5056,6 +5123,27 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 		);
 
+	/*
+	 * We do not use IBRS in the kernel. If this vCPU has used the
+	 * SPEC_CTRL MSR it may have left it on; save the value and
+	 * turn it off. This is much more efficient than blindly adding
+	 * it to the atomic save/restore list. Especially as the former
+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
+	 *
+	 * For non-nested case:
+	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
+	 * save it.
+	 *
+	 * For nested case:
+	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
+	 * save it.
+	 */
+	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+
+	if (svm->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
