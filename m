Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754778AbeDPLFB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:05:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754713AbeDPLE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:04:58 -0400
Subject: Re: [PATCH v4] X86/KVM: Properly update 'tsc_offset' to represent the
 running guest
To: KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1523675452-27271-1-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bd6eb51a-584a-91ac-2af9-934cb33d2cbf@redhat.com>
Date: Mon, 16 Apr 2018 13:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523675452-27271-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2018 05:10, KarimAllah Ahmed wrote:
> Update 'tsc_offset' on vmentry/vmexit of L2 guests to ensure that it always
> captures the TSC_OFFSET of the running guest whether it is the L1 or L2
> guest.
> 
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> [AMD changes, fix update_ia32_tsc_adjust_msr. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I think this makes it a little bit more tidy, and also matches svm.c's
placement of the increment in enter_svm_guest_mode:

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 67af4b8c9767..7207e6cc07c1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11435,6 +11435,7 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	u32 msr_entry_idx;
 	u32 exit_qual;
+	int r;
 
 	enter_guest_mode(vcpu);
 
@@ -11444,30 +11445,21 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
 	vmx_switch_vmcs(vcpu, &vmx->nested.vmcs02);
 	vmx_segment_cache_clear(vmx);
 
-	if (prepare_vmcs02(vcpu, vmcs12, from_vmentry, &exit_qual)) {
-		if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
-			vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
-		leave_guest_mode(vcpu);
-		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-		nested_vmx_entry_failure(vcpu, vmcs12,
-					 EXIT_REASON_INVALID_STATE, exit_qual);
-		return 1;
-	}
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
+
+	r = EXIT_REASON_INVALID_STATE;
+	if (prepare_vmcs02(vcpu, vmcs12, from_vmentry, &exit_qual))
+		goto fail;
 
 	nested_get_vmcs12_pages(vcpu, vmcs12);
 
+	r = EXIT_REASON_MSR_LOAD_FAIL;
 	msr_entry_idx = nested_vmx_load_msr(vcpu,
 					    vmcs12->vm_entry_msr_load_addr,
 					    vmcs12->vm_entry_msr_load_count);
-	if (msr_entry_idx) {
-		if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
-			vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
-		leave_guest_mode(vcpu);
-		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-		nested_vmx_entry_failure(vcpu, vmcs12,
-				EXIT_REASON_MSR_LOAD_FAIL, msr_entry_idx);
-		return 1;
-	}
+	if (msr_entry_idx)
+		goto fail;
 
 	/*
 	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
@@ -11476,6 +11468,14 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, bool from_vmentry)
 	 * the success flag) when L2 exits (see nested_vmx_vmexit()).
 	 */
 	return 0;
+
+fail:
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+	leave_guest_mode(vcpu);
+	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+	nested_vmx_entry_failure(vcpu, vmcs12, r, exit_qual);
+	return 1;
 }
 
 /*
@@ -11546,9 +11546,6 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 		return 1;
 	}
 
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
-		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
-
 	/*
 	 * We're finally done with prerequisite checking, and can start with
 	 * the nested entry.

The test case I've sent passes with the above version and fails with v3 indeed.
Thanks Jim. :)

Paolo
