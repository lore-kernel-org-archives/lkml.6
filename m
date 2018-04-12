Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeDLQfa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:35:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752389AbeDLQf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:35:28 -0400
Subject: Re: [PATCH 1/2] X86/KVM: Properly restore 'tsc_offset' when running
 an L2 guest
To: KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d03d253a-d184-4c95-91b2-45e94659b9bd@redhat.com>
Date: Thu, 12 Apr 2018 18:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2018 17:12, KarimAllah Ahmed wrote:
> When the TSC MSR is captured while an L2 guest is running then restored,
> the 'tsc_offset' ends up capturing the L02 TSC_OFFSET instead of the L01
> TSC_OFFSET. So ensure that this is compensated for when storing the value.
> 
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/x86/kvm/vmx.c | 12 +++++++++---
>  arch/x86/kvm/x86.c |  1 -
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index cff2f50..2f57571 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2900,6 +2900,8 @@ static u64 guest_read_tsc(struct kvm_vcpu *vcpu)
>   */
>  static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
>  {
> +	u64 l1_tsc_offset = 0;
> +
>  	if (is_guest_mode(vcpu)) {
>  		/*
>  		 * We're here if L1 chose not to trap WRMSR to TSC. According
> @@ -2908,16 +2910,20 @@ static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
>  		 * to the newly set TSC to get L2's TSC.
>  		 */
>  		struct vmcs12 *vmcs12;
> +
>  		/* recalculate vmcs02.TSC_OFFSET: */
>  		vmcs12 = get_vmcs12(vcpu);
> -		vmcs_write64(TSC_OFFSET, offset +
> -			(nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING) ?
> -			 vmcs12->tsc_offset : 0));
> +
> +		l1_tsc_offset = nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING) ?
> +					vmcs12->tsc_offset : 0;
> +		vmcs_write64(TSC_OFFSET, offset + l1_tsc_offset);
>  	} else {
>  		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
>  					   vmcs_read64(TSC_OFFSET), offset);
>  		vmcs_write64(TSC_OFFSET, offset);
>  	}
> +
> +	vcpu->arch.tsc_offset = offset - l1_tsc_offset;

Using both "offset + l1_tsc_offset" and "offset - l1_tsc_offset" in this 
function seems wrong to me: if vcpu->arch.tsc_offset must be "offset - 
l1_tsc_offset", then "offset" must be written to TSC_OFFSET.

I think the bug was introduced by commit 3e3f50262.  Before,
vmx_read_tsc_offset returned the L02 offset; now it always contains the
L01 offset.  So the right fix is to adjust vcpu->arch.tsc_offset on
nested vmentry/vmexit.  If is_guest_mode(vcpu), kvm_read_l1_tsc must use
a new kvm_x86_ops callback to subtract the L12 offset from the value it
returns.

Thanks,

Paolo

>  }
>  
>  /*
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ac42c85..1a2ed92 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1539,7 +1539,6 @@ EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
>  static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
>  {
>  	kvm_x86_ops->write_tsc_offset(vcpu, offset);
> -	vcpu->arch.tsc_offset = offset;
>  }
>  
>  static inline bool kvm_check_tsc_unstable(void)
> 
