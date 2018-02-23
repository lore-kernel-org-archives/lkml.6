Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeBWSG4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:06:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751587AbeBWSGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:06:55 -0500
Subject: Re: [PATCH] kvm: fix warning for non-x86 builds
To: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.LFD.2.21.1802221301580.1603@schleppi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7825efa7-da58-ad95-1d41-71eefb9784c3@redhat.com>
Date: Fri, 23 Feb 2018 19:06:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1802221301580.1603@schleppi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2018 13:04, Sebastian Ott wrote:
> Fix the following sparse warning by moving the prototype
> of kvm_arch_mmu_notifier_invalidate_range() to linux/kvm_host.h .
> 
>   CHECK   arch/s390/kvm/../../../virt/kvm/kvm_main.c
> arch/s390/kvm/../../../virt/kvm/kvm_main.c:138:13: warning: symbol 'kvm_arch_mmu_notifier_invalidate_range' was not declared. Should it be static?
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 3 ---
>  include/linux/kvm_host.h        | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index dd6f57a54a26..0a9e330b34f0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1464,7 +1464,4 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
>  #define put_smstate(type, buf, offset, val)                      \
>  	*(type *)((buf) + (offset) - 0x7e00) = val
>  
> -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> -		unsigned long start, unsigned long end);
> -
>  #endif /* _ASM_X86_KVM_HOST_H */
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ac0062b74aed..ed3d4ddbaff3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1272,4 +1272,7 @@ static inline long kvm_arch_vcpu_async_ioctl(struct file *filp,
>  }
>  #endif /* CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL */
>  
> +void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +		unsigned long start, unsigned long end);
> +
>  #endif
> 

Queued, thanks.

Paolo
