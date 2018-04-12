Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDLUbL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:31:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753361AbeDLUax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:30:53 -0400
Subject: Re: [PATCH v4 1/2] X86/KVM: Properly update 'tsc_offset' to represent
 the running guest
To: KarimAllah Ahmed <karahmed@amazon.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1523564347-8896-1-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0f
 UGFvbG8gQm9uemluaSA8Ym9uemluaUBnbnUub3JnPsLBTQQTAQIAIwUCVEJ7AwIbAwcLCQgH
 AwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEH4VEAzNNmmxNcwOniaZVLsuy1lW/ntYCA0Caz0i
 sHpmecK8aWlvL9wpQCk4GlOX9L1emyYXZPmzIYB0IRqmSzAlZxi+A2qm9XOxs5gJ2xqMEXX5
 FMtUH3kpkWWJeLqe7z0EoQdUI4EG988uv/tdZyqjUn2XJE+K01x7r3MkUSFz/HZKZiCvYuze
 VlS0NTYdUt5jBXualvAwNKfxEkrxeHjxgdFHjYWhjflahY7TNRmuqPM/Lx7wAuyoDjlYNE40
 Z+Kun4/KjMbjgpcF4Nf3PJQR8qXI6p3so2qsSn91tY7DFSJO6v2HwFJkC2jU95wxfNmTEUZc
 znXahYbVOwCDJRuPrE5GKFd/XJU9u5hNtr/uYipHij01WXal2cce1S5mn1/HuM1yo1u8xdHy
 IupCd57EWI948e8BlhpujUCU2tzOb2iYS0kpmJ9/oLVZrOcSZCcCl2P0AaCAsj59z2kwQS9D
 du0WxUs8waso0Qq6tDEHo8yLCOJDzSz4oojTtWe4zsulVnWV+wu70AioemAT8S6JOtlu60C5
 dHgQUD1Tp+ReXpDKXmjbASJx4otvW0qah3o6JaqO79tbDqIvncu3tewwp6c85uZd48JnIOh3
 utBAu684nJakbbvZUGikJfxd887ATQRUQnHuAQgAx4dxXO6/Zun0eVYOnr5GRl76+2UrAAem
 Vv9Yfn2PbDIbxXqLff7oyVJIkw4WdhQIIvvtu5zH24iYjmdfbg8iWpP7NqxUQRUZJEWbx2CR
 wkMHtOmzQiQ2tSLjKh/cHeyFH68xjeLcinR7jXMrHQK+UCEw6jqi1oeZzGvfmxarUmS0uRuf
 fAb589AJW50kkQK9VD/9QC2FJISSUDnRC0PawGSZDXhmvITJMdD4TjYrePYhSY4uuIV02v02
 8TVAaYbIhxvDY0hUQE4r8ZbGRLn52bEzaIPgl1p/adKfeOUeMReg/CkyzQpmyB1TSk8lDMxQ
 zCYHXAzwnGi8WU9iuE1P0wARAQABwsEzBBgBAgAJBQJUQnHuAhsMAAoJEH4VEAzNNmmxp1EO
 oJy0uZggJm7gZKeJ7iUpeX4eqUtqelUw6gU2daz2hE/jsxsTbC/w5piHmk1H1VWDKEM4bQBT
 uiJ0bfo55SWsUNN+c9hhIX+Y8LEe22izK3w7mRpvGcg+/ZRG4DEMHLP6JVsv5GMpoYwYOmHn
 plOzCXHvmdlW0i6SrMsBDl9rw4AtIa6bRwWLim1lQ6EM3PWifPrWSUPrPcw4OLSwFk0CPqC4
 HYv/7ZnASVkR5EERFF3+6iaaVi5OgBd81F1TCvCX2BEyIDRZLJNvX3TOd5FEN+lIrl26xecz
 876SvcOb5SL5SKg9/rCBufdPSjojkGFWGziHiFaYhbuI2E+NfWLJtd+ZvWAAV+O0d8vFFSvr
 iy9enJ8kxJwhC0ECbSKFY+W1eTIhMD3aeAKY90drozWEyHhENf4l/V+Ja5vOnW+gCDQkGt2Y
 1lJAPPSIqZKvHzGShdh8DduC0U3xYkfbGAUvbxeepjgzp0uEnBXfPTy09JGpgWbg0w91GyfT
 /ujKaGd4vxG2Ei+MMNDmS1SMx7wu0evvQ5kT9NPzyq8R2GIhVSiAd2jioGuTjX6AZCFv3ToO
 53DliFMkVTecLptsXaesuUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <e8f9a996-37dc-f623-2687-92d32175baf0@redhat.com>
Date: Thu, 12 Apr 2018 22:30:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1523564347-8896-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2018 22:19, KarimAllah Ahmed wrote:
> Update 'tsc_offset' on vmenty/vmexit of L2 guests to ensure that it always
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
> ---
> v1 -> v2:
> 
> - Rewrote the patch to always update tsc_offset to represent the current
>   guest (pbonzini@)

Yes, this is it, thanks.  I'll test it tomorrow and if I have time look
at AMD.

Paolo

> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/vmx.c              | 25 ++++++++++++++++++++-----
>  arch/x86/kvm/x86.c              |  9 ++++++++-
>  3 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 9fa4f57..3bedfef 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1015,6 +1015,7 @@ struct kvm_x86_ops {
>  
>  	bool (*has_wbinvd_exit)(void);
>  
> +	u64 (*read_l1_tsc_offset)(struct kvm_vcpu *vcpu);
>  	void (*write_tsc_offset)(struct kvm_vcpu *vcpu, u64 offset);
>  
>  	void (*get_exit_info)(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2);
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index cff2f50..9e7dd39 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2895,6 +2895,17 @@ static u64 guest_read_tsc(struct kvm_vcpu *vcpu)
>  	return kvm_scale_tsc(vcpu, host_tsc) + tsc_offset;
>  }
>  
> +static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
> +{
> +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +
> +	if (is_guest_mode(vcpu) &&
> +	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
> +		return vcpu->arch.tsc_offset - vmcs12->tsc_offset;
> +
> +	return vcpu->arch.tsc_offset;
> +}
> +
>  /*
>   * writes 'offset' into guest's timestamp counter offset register
>   */
> @@ -11163,11 +11174,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
>  	}
>  
> -	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> -		vmcs_write64(TSC_OFFSET,
> -			vcpu->arch.tsc_offset + vmcs12->tsc_offset);
> -	else
> -		vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
> +	vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
> +
>  	if (kvm_has_tsc_control)
>  		decache_tsc_multiplier(vmx);
>  
> @@ -11469,6 +11477,9 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  	if (enable_shadow_vmcs)
>  		copy_shadow_to_vmcs12(vmx);
>  
> +	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> +		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
> +
>  	/*
>  	 * The nested entry process starts with enforcing various prerequisites
>  	 * on vmcs12 as required by the Intel SDM, and act appropriately when
> @@ -12015,6 +12026,9 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  
>  	leave_guest_mode(vcpu);
>  
> +	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> +		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
> +
>  	if (likely(!vmx->fail)) {
>  		if (exit_reason == -1)
>  			sync_vmcs12(vcpu, vmcs12);
> @@ -12688,6 +12702,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  
>  	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
>  
> +	.read_l1_tsc_offset = vmx_read_l1_tsc_offset,
>  	.write_tsc_offset = vmx_write_tsc_offset,
>  
>  	.set_tdp_cr3 = vmx_set_cr3,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ac42c85..3fb1353 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1532,7 +1532,14 @@ static u64 kvm_compute_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
>  
>  u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
>  {
> -	return vcpu->arch.tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
> +	u64 tsc_offset;
> +
> +	if (kvm_x86_ops->read_l1_tsc_offset)
> +		tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
> +	else
> +		tsc_offset = vcpu->arch.tsc_offset;
> +
> +	return tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
>  }
>  EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
>  
> 
