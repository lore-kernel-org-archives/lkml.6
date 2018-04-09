Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDIK7d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:59:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750759AbeDIK7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:59:30 -0400
Subject: Re: [PATCH] kvm: x86: fix a prototype warning
To: Peng Hao <peng.hao2@zte.com.cn>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523051252-110308-1-git-send-email-peng.hao2@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7055d28b-10f4-eb22-069c-ea6e0a7037f3@redhat.com>
Date: Mon, 9 Apr 2018 12:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1523051252-110308-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.2018 23:47, Peng Hao wrote:
> warning: no previous prototype for ‘vmx_enable_tdp’
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/x86/kvm/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index f0fd50b..86681bc 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -6954,7 +6954,7 @@ static void wakeup_handler(void)
>  	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
>  }
>  
> -void vmx_enable_tdp(void)
> +static void vmx_enable_tdp(void)
>  {
>  	kvm_mmu_set_mask_ptes(VMX_EPT_READABLE_MASK,
>  		enable_ept_ad_bits ? VMX_EPT_ACCESS_BIT : 0ull,
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
