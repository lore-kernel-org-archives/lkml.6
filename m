Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934031AbeCGQU3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:20:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933335AbeCGQU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:20:27 -0500
Date: Wed, 7 Mar 2018 17:19:44 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
 HV_X64_MSR_VP_ASSIST_PAGE
Message-ID: <20180307161944.GE12290@flask>
References: <20180226171121.18974-1-vkuznets@redhat.com>
 <20180226171121.18974-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226171121.18974-2-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 18:11+0100, Vitaly Kuznetsov:
> From: Ladi Prosek <lprosek@redhat.com>
> 
> The assist page has been used only for the paravirtual EOI so far, hence
> the "APIC" in the MSR name. Renaming to match the Hyper-V TLFS where it's
> called "Virtual VP Assist MSR".
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/uapi/asm/hyperv.h | 10 +++++-----
>  arch/x86/kvm/hyperv.c              |  8 ++++----
>  arch/x86/kvm/lapic.h               |  2 +-
>  arch/x86/kvm/x86.c                 |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
> index 1c12aaf33915..45cc62352040 100644
> --- a/arch/x86/include/uapi/asm/hyperv.h
> +++ b/arch/x86/include/uapi/asm/hyperv.h
> @@ -189,7 +189,7 @@
>  #define HV_X64_MSR_EOI				0x40000070
>  #define HV_X64_MSR_ICR				0x40000071
>  #define HV_X64_MSR_TPR				0x40000072
> -#define HV_X64_MSR_APIC_ASSIST_PAGE		0x40000073
> +#define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
>  
>  /* Define synthetic interrupt controller model specific registers. */
>  #define HV_X64_MSR_SCONTROL			0x40000080
> @@ -275,10 +275,10 @@ struct hv_tsc_emulation_status {
>  #define HVCALL_POST_MESSAGE			0x005c
>  #define HVCALL_SIGNAL_EVENT			0x005d
>  
> -#define HV_X64_MSR_APIC_ASSIST_PAGE_ENABLE		0x00000001
> -#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT	12
> -#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_MASK	\
> -		(~((1ull << HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT) - 1))

Removing definitions from userspace api isn't a good idea.

I have no idea why hyper.h is a userspace api, though -- Linux doesn't
define any of those, so we could copy the definitions to a private
header, rename, and never look at this file again.
