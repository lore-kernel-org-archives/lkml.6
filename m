Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x2270LDJuW+x+iVvHfuSAB+XdW3ZWV/yvGtU/MBuEJHPTz48Kxg36I+10Riil8NBgR4G69GTw
ARC-Seal: i=1; a=rsa-sha256; t=1518513313; cv=none;
        d=google.com; s=arc-20160816;
        b=YzAF7nrDPMcyE276vZTuoetBWXzw0jer3qodnv5J1fDTsDT8rpnlTxlXRLA1We6c3J
         BnP0XSG5bA224x8lG9KwlLgYiNT8bTh0E355+WCgdw7xnbnnYSH3n08PwGYo39T3d7NE
         Lbyrc0pLobfBogzka5PG5CDWMWS+JCs6gvGpSwhFPQNmPGI+ebVvtIJ10icW8iuIKxPM
         ARTZRiwld1eib1O6KkrklISrWP2vk+JiICSf6K+iMyTzeWeecUb3EtMsr7J1xZlqhLWj
         ytSMpbRLlfL+HQR2AhUYcT+49fYI+Z5fBg2ZTVeyj8W5HQvh9RuiKEmwULzCF+vkJLvE
         91ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=IIb71Q1McPs28Iljhx1WG1U9GB372io2UOHgnqU6ytg=;
        b=XalASb6PH55VHWr6AF2NMn4FbbakQSArYzhsAGdqWCJbMOS6TLabPA6POwLU7OiRLF
         5eI7GcPIoPVIbRaP5VAEbCFMuE5Cw2gBNmb4JZRkfKxCoSpoQOeYCF77Fvo6W6NqPq0q
         vOMjISXMKkkZkGDmCfqQuT047jIGD7XUZi6EH9gEop+Uutm2vmZPqJ6IO3Z5JvA7OsoH
         YTdHNF6TJMTVuX8e2PniivfwBWboK0oX5pUr/ToK+l2CBl18O3bmqP1f19D50/xaRWh1
         tdEk7AnZ+LikeiNFHSPx1jnjXc0x112jquIjFJgj/qqQUEftlP6lTmo9tzL1o8l8Eopu
         prDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 13 Feb 2018 00:59:43 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-3712caeb14dcb33fb4d5114f14c0beef10aca101@git.kernel.org>
Cc: torvalds@linux-foundation.org, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, rkrcmar@redhat.com, pbonzini@redhat.com,
        mingo@kernel.org, luto@kernel.org, karahmed@amazon.de,
        peterz@infradead.org, arjan@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org, dwmw@amazon.co.uk,
        gregkh@linuxfoundation.org, tglx@linutronix.de, jpoimboe@redhat.com
Reply-To: dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        rkrcmar@redhat.com, pbonzini@redhat.com, torvalds@linux-foundation.org,
        bp@alien8.de, peterz@infradead.org, arjan@linux.intel.com,
        hpa@zytor.com, mingo@kernel.org, karahmed@amazon.de, luto@kernel.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org, dwmw@amazon.co.uk,
        tglx@linutronix.de, jpoimboe@redhat.com, gregkh@linuxfoundation.org
In-Reply-To: <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we
 have a valid L02 MSR bitmap
Git-Commit-ID: 3712caeb14dcb33fb4d5114f14c0beef10aca101
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160008544950963?=
X-GMAIL-MSGID: =?utf-8?q?1592276616380606640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  3712caeb14dcb33fb4d5114f14c0beef10aca101
Gitweb:     https://git.kernel.org/tip/3712caeb14dcb33fb4d5114f14c0beef10aca101
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Sat, 10 Feb 2018 23:39:26 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 09:00:17 +0100

KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MSR bitmap

We either clear the CPU_BASED_USE_MSR_BITMAPS and end up intercepting all
MSR accesses or create a valid L02 MSR bitmap and use that. This decision
has to be made every time we evaluate whether we are going to generate the
L02 MSR bitmap.

Before commit:

  d28b387fb74d ("KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL")

... this was probably OK since the decision was always identical.

This is no longer the case now since the MSR bitmap might actually
change once we decide to not intercept SPEC_CTRL and PRED_CMD.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
Cc: jmattson@google.com
Cc: kvm@vger.kernel.org
Cc: sironi@amazon.de
Link: http://lkml.kernel.org/r/1518305967-31356-6-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kvm/vmx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 599179b..91e3539 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10130,7 +10130,8 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 	if (cpu_has_vmx_msr_bitmap() &&
 	    nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS) &&
 	    nested_vmx_merge_msr_bitmap(vcpu, vmcs12))
-		;
+		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
+			      CPU_BASED_USE_MSR_BITMAPS);
 	else
 		vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
 				CPU_BASED_USE_MSR_BITMAPS);
