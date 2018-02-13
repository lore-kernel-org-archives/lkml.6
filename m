Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x224XVoAX4sGT5kXGQXFRBqLNRYreXzjtuqzlHeSKRcPjBsc3OVYbTAXf5s0BBHbQ3vCydULA
ARC-Seal: i=1; a=rsa-sha256; t=1518513279; cv=none;
        d=google.com; s=arc-20160816;
        b=A4aTSYngm9v5vKM8sjdPXWhOQh8j4NtZHstOT8uSLNDhW8e7xGwxuDtmY87AkWnGCn
         oYp6cBEJiN2RaTFxH792Oh+XoVnpVnOxYPhP8OI9TwaAwNYLppdiSQXzvFgJzdO1Uo2f
         6F/kJVahpyYqn1YPkx+Ie57HCX70X2O54qvbuxddT97W9NE5ZLRJSErMKVf3PtXm7N1p
         EllijGKMi2kovC/LHi+SS6nW6fGilfmjyuVCRztT49ROjTnhg3+jgIu//nUTme/c2Y5Z
         sc3yFJ+EVgGiQGnO06nrxyQLn1c9gTQ4nk79RFpL+Y9EBuCeC/5EVD0remP4LcmPLgX0
         GrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=1K39XiC3QZ2TfxMs/RczFLcYrgCfScmvj2qIh61hVsQ=;
        b=twwo9LYhQdCPwD89zZWawxT4vzE/XNnuDZAoiKX+95KQ9o7UY587MIl1BsWNtIotQx
         gsS56CNzejuS0RgV75OBXp52klEFa7N5xTQk4hxG5KVtdQmXu7m9IELpfR3zUNLL0fGH
         rFY/GxMAOVRY8n8oJ5kblJNZF85r3/HNyRK9hyEjk+RP4ezrtUnrjXi5ljzp8BjBT32p
         Dxt21KUIDsaqsXaSQxcqGVmizO18C9PfsdrQAnQxrUe5p3Gg3DlEhX39l2XUb4/JVoFi
         uwaNGwQjV0pkvSQOFZFi/f/R2Wu4RYCFcB2jlwJkg2I9jGFj2XAyHK9S1O339G/rOae+
         es0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 13 Feb 2018 00:59:15 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-206587a9fb764d71f035dc7f6d3b6488f5d5b304@git.kernel.org>
Cc: rkrcmar@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, arjan@linux.intel.com,
        mingo@kernel.org, dwmw2@infradead.org, luto@kernel.org,
        dan.j.williams@intel.com, jmattson@google.com, karahmed@amazon.de,
        bp@alien8.de, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, dwmw@amazon.co.uk, jpoimboe@redhat.com,
        hpa@zytor.com, gregkh@linuxfoundation.org
Reply-To: rkrcmar@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        arjan@linux.intel.com, dwmw2@infradead.org, mingo@kernel.org,
        karahmed@amazon.de, jmattson@google.com, dan.j.williams@intel.com,
        luto@kernel.org, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, bp@alien8.de, dwmw@amazon.co.uk,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com
In-Reply-To: <1518305967-31356-5-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-5-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] X86/nVMX: Properly set spec_ctrl and pred_cmd before
 merging MSRs
Git-Commit-ID: 206587a9fb764d71f035dc7f6d3b6488f5d5b304
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160088873236897?=
X-GMAIL-MSGID: =?utf-8?q?1592276580724759024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  206587a9fb764d71f035dc7f6d3b6488f5d5b304
Gitweb:     https://git.kernel.org/tip/206587a9fb764d71f035dc7f6d3b6488f5d5b304
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Sat, 10 Feb 2018 23:39:25 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:00:06 +0100

X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs

These two variables should check whether SPEC_CTRL and PRED_CMD are
supposed to be passed through to L2 guests or not. While
msr_write_intercepted_l01 would return 'true' if it is not passed through.

So just invert the result of msr_write_intercepted_l01 to implement the
correct semantics.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: kvm@vger.kernel.org
Cc: sironi@amazon.de
Fixes: 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
Link: http://lkml.kernel.org/r/1518305967-31356-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kvm/vmx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bee4c49..599179b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10219,8 +10219,8 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	 *    updated to reflect this when L1 (or its L2s) actually write to
 	 *    the MSR.
 	 */
-	bool pred_cmd = msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
-	bool spec_ctrl = msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
+	bool pred_cmd = !msr_write_intercepted_l01(vcpu, MSR_IA32_PRED_CMD);
+	bool spec_ctrl = !msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL);
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
 	    !pred_cmd && !spec_ctrl)
