Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeEJTRR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:17:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752082AbeEJTRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:17:11 -0400
Date: Thu, 10 May 2018 21:17:07 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] x86/hyper-v: move struct hv_flush_pcpu{,ex}
 definitions to common header
Message-ID: <20180510191706.GA3885@flask>
References: <20180416110806.4896-1-vkuznets@redhat.com>
 <20180416110806.4896-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416110806.4896-2-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-16 13:08+0200, Vitaly Kuznetsov:
> Hyper-V TLB flush hypercalls definitions will be required for KVM so move
> them hyperv-tlfs.h. Structures also need to be renamed as '_pcpu' suffix is
> invalid for a general-purpose definition.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/hyperv/mmu.c              | 40 ++++++++++----------------------------
>  arch/x86/include/asm/hyperv-tlfs.h | 20 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -703,4 +703,24 @@ struct hv_enlightened_vmcs {
>  #define HV_STIMER_AUTOENABLE		(1ULL << 3)
>  #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
>  
> +/* HvFlushVirtualAddressSpace, HvFlushVirtualAddressList hypercalls */
> +struct hv_tlb_flush {
> +	u64 address_space;
> +	u64 flags;
> +	u64 processor_mask;
> +	u64 gva_list[];
> +};
> +
> +/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls */
> +struct hv_tlb_flush_ex {
> +	u64 address_space;
> +	u64 flags;
> +	struct {
> +		u64 format;
> +		u64 valid_bank_mask;
> +		u64 bank_contents[];
> +	} hv_vp_set;
> +	u64 gva_list[];

Why is the gva_list there?
