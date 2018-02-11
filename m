Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227/KeGv+mqUryX9JPnBV8XnKAgJGWdgk1AAukb3/LTtxdgFuiAZP4r/UhjtaeaeUB7SgAM3
ARC-Seal: i=1; a=rsa-sha256; t=1518402184; cv=none;
        d=google.com; s=arc-20160816;
        b=m9A1BNYvMrj8jylf99fvIxxwK8iindRd50Hv3vGUAS1Cy5wlJIMiWE3dE9TITPlZx8
         Qmxr8E+emgl+pHYOvS+pe/aqwLudW/LCzbqC3qp5vUZJAZqdSTIbe6xMNoMfB9gZl92D
         4jn7IUeHN0czEyhmVkno7JwoHZMeGDdaEz0SSQRhGCxgiFqPAtNeqjOzgEg8v1uzfI/n
         NjFuNiabQDKrTTyM3z/z+whsCzw0kbQ4qbASJFNpBWbcc0Vef9k3Q4Yg4XcR1nQaGcyq
         92qhV83/j6kDSmf3V6bV5M5IQYpzNV7MKZM8MwmuVtPBF1ithHArTSychWoooOmw1T/I
         5gxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=STmFPGpeWrYW9bt656jpayBxR2fBVtm1kElcVTy2Gio=;
        b=SCAm/qFVZ8wg8KyGyR4PQ5YpDpDakp11sThN50xori8yzftQ5LOICLA3yDNeG3Qq9G
         EpXo4ZQNdjGRhh7j4RLFze+mBPddAnK7YWA99+n1oF2JgpZXn7YK+7IXMwtym/HWwHpD
         al3Exdj9Ju24Tx/fLSUYEL+PLjq390YbY/nVcqA7Z0gUJvYpcUtrHxDfs9WrQ/JE33wN
         i1zUiuEUI71SO1hamWsJJJhdUteQEGV+Y9gh49Kr7ZfeaBaraLthcUKoLbuHbjJRgFx2
         Y196I6NCEglsVfvH7KLuLOEFGhkknn2ql9yQ06om1BqytTAfgkLZW8k/p1W/QsgEDQMT
         CcQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sun, 11 Feb 2018 04:10:21 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-fb5b90b795c76e9c10c520fcdb7fe0d7b8334833@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, karahmed@amazon.de, dwmw@amazon.co.uk,
        dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
        arjan@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        pbonzini@redhat.com, dan.j.williams@intel.com, mingo@kernel.org,
        hpa@zytor.com, jmattson@google.com, rkrcmar@redhat.com,
        dwmw2@infradead.org, gregkh@linuxfoundation.org, luto@kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org
Reply-To: peterz@infradead.org, luto@kernel.org, jpoimboe@redhat.com,
        gregkh@linuxfoundation.org, rkrcmar@redhat.com, jmattson@google.com,
        dwmw2@infradead.org, mingo@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, dan.j.williams@intel.com, bp@alien8.de,
        torvalds@linux-foundation.org, arjan@linux.intel.com,
        tglx@linutronix.de, dave.hansen@linux.intel.com, dwmw@amazon.co.uk,
        karahmed@amazon.de, linux-kernel@vger.kernel.org
In-Reply-To: <1518305967-31356-5-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-5-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] X86/nVMX: Properly set spec_ctrl and pred_cmd before
 merging MSRs
Git-Commit-ID: fb5b90b795c76e9c10c520fcdb7fe0d7b8334833
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
X-GMAIL-MSGID: =?utf-8?q?1592160088873236897?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  fb5b90b795c76e9c10c520fcdb7fe0d7b8334833
Gitweb:     https://git.kernel.org/tip/fb5b90b795c76e9c10c520fcdb7fe0d7b8334833
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Sat, 10 Feb 2018 23:39:25 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:24:16 +0100

X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs

These two variables should check whether SPEC_CTRL and PRED_CMD are
supposed to be passed through to L2 guests or not. While
msr_write_intercepted_l01 would return 'true' if it is not passed through.

So just invert the result of msr_write_intercepted_l01 to implement the
correct semantics.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
