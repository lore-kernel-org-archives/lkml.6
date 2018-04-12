Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeDLOjX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:39:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752668AbeDLOjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:39:21 -0400
Subject: Re: [PATCH 07/10] KVM/nVMX: Use kvm_vcpu_map when mapping the posted
 interrupt descriptor table
To: KarimAllah Ahmed <karahmed@amazon.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
 <1519235241-6500-8-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5b3e7e52-6353-3fe9-f5e4-ecb1d8e2ac6f@redhat.com>
Date: Thu, 12 Apr 2018 16:39:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519235241-6500-8-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2018 18:47, KarimAllah Ahmed wrote:
> ... since using kvm_vcpu_gpa_to_page() and kmap() will only work for guest
> memory that has a "struct page".
> 
> The life-cycle of the mapping also changes to avoid doing map and unmap on
> every single exit (which becomes very expesive once we use memremap).  Now
> the memory is mapped and only unmapped when a new VMCS12 is loaded into the
> vCPU (or when the vCPU is freed!).
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Same here, let's change the lifecycle separately.

Paolo

> ---
>  arch/x86/kvm/vmx.c | 45 +++++++++++++--------------------------------
>  1 file changed, 13 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index a700338..7b29419 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -461,7 +461,7 @@ struct nested_vmx {
>  	 */
>  	struct page *apic_access_page;
>  	struct kvm_host_map virtual_apic_map;
> -	struct page *pi_desc_page;
> +	struct kvm_host_map pi_desc_map;
>  	struct kvm_host_map msr_bitmap_map;
>  
>  	struct pi_desc *pi_desc;
> @@ -7666,6 +7666,7 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
>  				  vmx->nested.cached_vmcs12, 0, VMCS12_SIZE);
>  
>  	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
> +	kvm_vcpu_unmap(&vmx->nested.pi_desc_map);
>  	kvm_vcpu_unmap(&vmx->nested.msr_bitmap_map);
>  
>  	vmx->nested.current_vmptr = -1ull;
> @@ -7698,14 +7699,9 @@ static void free_nested(struct vcpu_vmx *vmx)
>  		vmx->nested.apic_access_page = NULL;
>  	}
>  	kvm_vcpu_unmap(&vmx->nested.virtual_apic_map);
> -	if (vmx->nested.pi_desc_page) {
> -		kunmap(vmx->nested.pi_desc_page);
> -		kvm_release_page_dirty(vmx->nested.pi_desc_page);
> -		vmx->nested.pi_desc_page = NULL;
> -		vmx->nested.pi_desc = NULL;
> -	}
> -
> +	kvm_vcpu_unmap(&vmx->nested.pi_desc_map);
>  	kvm_vcpu_unmap(&vmx->nested.msr_bitmap_map);
> +	vmx->nested.pi_desc = NULL;
>  
>  	free_loaded_vmcs(&vmx->nested.vmcs02);
>  }
> @@ -10278,24 +10274,16 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
>  	}
>  
>  	if (nested_cpu_has_posted_intr(vmcs12)) {
> -		if (vmx->nested.pi_desc_page) { /* shouldn't happen */
> -			kunmap(vmx->nested.pi_desc_page);
> -			kvm_release_page_dirty(vmx->nested.pi_desc_page);
> -			vmx->nested.pi_desc_page = NULL;
> +		map = &vmx->nested.pi_desc_map;
> +
> +		if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr), map)) {
> +			vmx->nested.pi_desc =
> +				(struct pi_desc *)(((void *)map->kaddr) +
> +				offset_in_page(vmcs12->posted_intr_desc_addr));
> +			vmcs_write64(POSTED_INTR_DESC_ADDR, pfn_to_hpa(map->pfn) +
> +							    offset_in_page(vmcs12->posted_intr_desc_addr));
>  		}
> -		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->posted_intr_desc_addr);
> -		if (is_error_page(page))
> -			return;
> -		vmx->nested.pi_desc_page = page;
> -		vmx->nested.pi_desc = kmap(vmx->nested.pi_desc_page);
> -		vmx->nested.pi_desc =
> -			(struct pi_desc *)((void *)vmx->nested.pi_desc +
> -			(unsigned long)(vmcs12->posted_intr_desc_addr &
> -			(PAGE_SIZE - 1)));
> -		vmcs_write64(POSTED_INTR_DESC_ADDR,
> -			page_to_phys(vmx->nested.pi_desc_page) +
> -			(unsigned long)(vmcs12->posted_intr_desc_addr &
> -			(PAGE_SIZE - 1)));
> +
>  	}
>  	if (nested_vmx_prepare_msr_bitmap(vcpu, vmcs12))
>  		vmcs_set_bits(CPU_BASED_VM_EXEC_CONTROL,
> @@ -11893,13 +11881,6 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  		kvm_release_page_dirty(vmx->nested.apic_access_page);
>  		vmx->nested.apic_access_page = NULL;
>  	}
> -	if (vmx->nested.pi_desc_page) {
> -		kunmap(vmx->nested.pi_desc_page);
> -		kvm_release_page_dirty(vmx->nested.pi_desc_page);
> -		vmx->nested.pi_desc_page = NULL;
> -		vmx->nested.pi_desc = NULL;
> -	}
> -
>  	/*
>  	 * We are now running in L2, mmu_notifier will force to reload the
>  	 * page's hpa for L2 vmcs. Need to reload it for L1 before entering L1.
> 
