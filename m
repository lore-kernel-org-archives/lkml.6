Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x2246wGVdBggBrYvYSjkW6ecQUUqOhYVwfX/rWMK2kSRVQFHlh5ketIAMjzP09EuMWm+GJN3h
ARC-Seal: i=1; a=rsa-sha256; t=1518402107; cv=none;
        d=google.com; s=arc-20160816;
        b=WBMfUJtxkpYxXFi4npall7rdqfOJuKG3BEu4n2H8zQ8MyH/CrS4a9LO2e7QB15F2zV
         KBn4Lc+PEi3dwOMoKj1Yw3eIGXfd5OLcL97bvrui/dNzOfLUQF2i0CerXjDvEd/EdMHc
         iI+8zb/JdFmv5nR6L4TzW3Dum0zQvNsaehvtmSSuo3Mxv7bpJ9+E19dfjkP7COiM3yV0
         oDDqaZWFrq8HP4DoGE8eYWobcDnj/FRl/3CI8EkEahi2AovLCHNtv7F0iNZKTap80UJO
         QNnd/Y+hiaQXBU2Yh7KBwUusNyqszI94k5B6wdnFQsvpRGGZbiOWKKrp8+xOMLWDJQjq
         RlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=OXSBy5YZ4ugk6tb8UanmKZR9HmNq63QrZpqhlHNUWkU=;
        b=C1OH37phDvV5Br2ufYZ5VPP4/lVrDqex4vf7DbFPrR7+HPLFs6zQmgmM8RWcjECOaw
         s7jBO67t/MvIghm/ktxZKNvrW36GUzAugyETC9365yk9ddbZQd9Drk72i/e/73P1IJXH
         x1tC7mYk9I+AxPT69QiCM2M7nWz/YOqpvxOU09dZPxyY5sGmo9sayXTo4tnxMvgUFK9l
         dmKnVJzYN6F/ruWKlcd8cA6Txe6CMrO5AOxQ3SRBX/YTfMrpJKjk4yGy8AfSbMDYsHtZ
         /938VJWrvAlsZNBqiesW4MBuDKH08Kjl+tf9wduB9vUFMhwOM+d2u4WJKqQRb4a13L99
         2sTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sun, 11 Feb 2018 04:10:48 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-ff37dc0cd96c266c7700386b7ba48abc32a91b1f@git.kernel.org>
Cc: luto@kernel.org, arjan@linux.intel.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, dwmw@amazon.co.uk,
        rkrcmar@redhat.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, mingo@kernel.org, hpa@zytor.com,
        jpoimboe@redhat.com, tglx@linutronix.de, dan.j.williams@intel.com,
        bp@alien8.de, dwmw2@infradead.org, karahmed@amazon.de,
        pbonzini@redhat.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, jpoimboe@redhat.com,
        dan.j.williams@intel.com, bp@alien8.de, pbonzini@redhat.com,
        dwmw2@infradead.org, karahmed@amazon.de, arjan@linux.intel.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, dwmw@amazon.co.uk,
        rkrcmar@redhat.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        torvalds@linux-foundation.org
In-Reply-To: <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we
 have a valid L02 MSR bitmap
Git-Commit-ID: ff37dc0cd96c266c7700386b7ba48abc32a91b1f
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
X-GMAIL-MSGID: =?utf-8?q?1592160008544950963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  ff37dc0cd96c266c7700386b7ba48abc32a91b1f
Gitweb:     https://git.kernel.org/tip/ff37dc0cd96c266c7700386b7ba48abc32a91b1f
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Sat, 10 Feb 2018 23:39:26 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:24:16 +0100

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
