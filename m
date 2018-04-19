Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDSNGr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:06:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbeDSNGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:06:45 -0400
Date: Thu, 19 Apr 2018 15:06:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tonny Lu <tonnylu@tencent.com>
Subject: Re: [PATCH] KVM: X86: Extend MAX_IRQ_ROUTES to 4096
Message-ID: <20180419150641.5922e7e1.cohuck@redhat.com>
In-Reply-To: <1524141040-50214-1-git-send-email-wanpengli@tencent.com>
References: <1524141040-50214-1-git-send-email-wanpengli@tencent.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 05:30:40 -0700
Wanpeng Li <kernellwp@gmail.com> wrote:

> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Our virtual machines make use of device assignment by configuring
> 12 NVMe disks for high I/O performance. Each NVMe device has 129 
> MSI-X Table entries:
> Capabilities: [50] MSI-X: Enable+ Count=129 Masked-Vector table: BAR=0 offset=00002000
> The windows virtual machines fail to boot since they will map the number of 
> MSI-table entries that the NVMe hardware reported to the bus to msi routing 
> table, this will exceed the 1024. This patch extends MAX_IRQ_ROUTES to 4096,
> In the future this might be extended if needed.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Tonny Lu <tonnylu@tencent.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Tonny Lu <tonnylu@tencent.com>
> ---
>  include/linux/kvm_host.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6930c63..815ae66 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1050,7 +1050,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>  #elif defined(CONFIG_ARM64)
>  #define KVM_MAX_IRQ_ROUTES 4096
>  #else
> -#define KVM_MAX_IRQ_ROUTES 1024
> +#define KVM_MAX_IRQ_ROUTES 4096
>  #endif
>  
>  bool kvm_arch_can_set_irq_routing(struct kvm *kvm);

So, this basically means we have 4096 everywhere, no?
