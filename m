Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeEGRCC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:02:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751923AbeEGRB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:01:59 -0400
Subject: Re: [PATCH v2] KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support
To: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc: x86@kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-kernel@vger.kernel.org
References: <20180416105033.28778-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1938dfa0-149d-f1bc-c7bb-c38ddbd477ef@redhat.com>
Date: Mon, 7 May 2018 19:01:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416105033.28778-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 12:50, Vitaly Kuznetsov wrote:
> Enlightened MSR-Bitmap is a natural extension of Enlightened VMCS:
> Hyper-V Top Level Functional Specification states:
> 
> "The L1 hypervisor may collaborate with the L0 hypervisor to make MSR
> accesses more efficient. It can enable enlightened MSR bitmaps by setting
> the corresponding field in the enlightened VMCS to 1. When enabled, the L0
> hypervisor does not monitor the MSR bitmaps for changes. Instead, the L1
> hypervisor must invalidate the corresponding clean field after making
> changes to one of the MSR bitmaps."
> 
> I reached out to Hyper-V team for additional details and I got the
> following information:
> 
> "Current Hyper-V implementation works as following:
> 
> If the enlightened MSR bitmap is not enabled:
> - All MSR accesses of L2 guests cause physical VM-Exits
> 
> If the enlightened MSR bitmap is enabled:
> - Physical VM-Exits for L2 accesses to certain MSRs (currently FS_BASE,
>   GS_BASE and KERNEL_GS_BASE) are avoided, thus making these MSR accesses
>   faster."
> 
> I tested my series with a tight rdmsrl loop in L2, for KERNEL_GS_BASE the
> results are:
> 
> Without Enlightened MSR-Bitmap: 1300 cycles/read
> With Enlightened MSR-Bitmap: 120 cycles/read
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Tested-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> - Changes since 'v1': drop 'enable_emsr_bitmap' static key usage
>   [Paolo Bonzini]
> - Added 'Tested-by' from Lan Tianyu. Hope it stands after the changes.
> ---
>  arch/x86/include/asm/hyperv-tlfs.h |  9 ++++++++-
>  arch/x86/kvm/vmx.c                 | 25 +++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 1c602ad4bda8..26e7e2240066 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -300,6 +300,9 @@ struct ms_hyperv_tsc_page {
>  /* TSC emulation after migration */
>  #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
>  
> +/* Nested features (CPUID 0x4000000A) EAX */
> +#define HV_X64_NESTED_MSR_BITMAP		BIT(19)
> +
>  struct hv_reenlightenment_control {
>  	__u64 vector:8;
>  	__u64 reserved1:8;
> @@ -665,7 +668,11 @@ struct hv_enlightened_vmcs {
>  	u32 hv_clean_fields;
>  	u32 hv_padding_32;
>  	u32 hv_synthetic_controls;
> -	u32 hv_enlightenments_control;
> +	struct {
> +		u32 nested_flush_hypercall:1;
> +		u32 msr_bitmap:1;
> +		u32 reserved:30;
> +	} hv_enlightenments_control;
>  	u32 hv_vp_id;
>  
>  	u64 hv_vm_id;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index b2f8a700aeef..babc9ef121a4 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -1090,6 +1090,16 @@ static inline u16 evmcs_read16(unsigned long field)
>  	return *(u16 *)((char *)current_evmcs + offset);
>  }
>  
> +static inline void evmcs_touch_msr_bitmap(void)
> +{
> +	if (unlikely(!current_evmcs))
> +		return;
> +
> +	if (current_evmcs->hv_enlightenments_control.msr_bitmap)
> +		current_evmcs->hv_clean_fields &=
> +			~HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
> +}
> +
>  static void evmcs_load(u64 phys_addr)
>  {
>  	struct hv_vp_assist_page *vp_ap =
> @@ -1174,6 +1184,7 @@ static inline u32 evmcs_read32(unsigned long field) { return 0; }
>  static inline u16 evmcs_read16(unsigned long field) { return 0; }
>  static inline void evmcs_load(u64 phys_addr) {}
>  static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
> +static inline void evmcs_touch_msr_bitmap(void) {}
>  #endif /* IS_ENABLED(CONFIG_HYPERV) */
>  
>  static inline bool is_exception_n(u32 intr_info, u8 vector)
> @@ -4218,6 +4229,14 @@ static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>  		if (!loaded_vmcs->msr_bitmap)
>  			goto out_vmcs;
>  		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
> +
> +		if (static_branch_unlikely(&enable_evmcs) &&
> +		    (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)) {
> +			struct hv_enlightened_vmcs *evmcs =
> +				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;
> +
> +			evmcs->hv_enlightenments_control.msr_bitmap = 1;
> +		}
>  	}
>  	return 0;
>  
> @@ -5335,6 +5354,9 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
>  	if (!cpu_has_vmx_msr_bitmap())
>  		return;
>  
> +	if (static_branch_unlikely(&enable_evmcs))
> +		evmcs_touch_msr_bitmap();
> +
>  	/*
>  	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
>  	 * have the write-low and read-high bitmap offsets the wrong way round.
> @@ -5370,6 +5392,9 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
>  	if (!cpu_has_vmx_msr_bitmap())
>  		return;
>  
> +	if (static_branch_unlikely(&enable_evmcs))
> +		evmcs_touch_msr_bitmap();
> +
>  	/*
>  	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
>  	 * have the write-low and read-high bitmap offsets the wrong way round.
> 

Queued, thanks.

Paolo
