Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD6B208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD6B208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHTOat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:30:49 -0400
Received: from foss.arm.com ([217.140.101.70]:36268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeHTOat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:30:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC1C80D;
        Mon, 20 Aug 2018 04:15:37 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E40D3F2EA;
        Mon, 20 Aug 2018 04:15:36 -0700 (PDT)
Subject: Re: [PATCH] arm64: KVM: rename the capability to set guest SError
 syndrome
To:     Dongjiu Geng <gengdongjiu@huawei.com>, christoffer.dall@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1534790251-15847-1-git-send-email-gengdongjiu@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <07f6c4c9-0397-7e03-ba36-1b8086dc1ccf@arm.com>
Date:   Mon, 20 Aug 2018 12:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534790251-15847-1-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu,

On 20/08/18 19:37, Dongjiu Geng wrote:
> In the documentation description, this capability's name is
> KVM_CAP_ARM_SET_SERROR_ESR, but in the header file this
> capability's name is KVM_CAP_ARM_INJECT_SERROR_ESR, so it
> is better to use a same name.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> In the Documentation/virtual/kvm/api.txt:
> 
> +8.19 KVM_CAP_ARM_SET_SERROR_ESR
> 
> In the include/uapi/linux/kvm.h:
> +#define KVM_CAP_ARM_INJECT_SERROR_ESR 156
> 
> So in above two files, the capability's name is not same, it
> is better to use a same name.
> ---
>  arch/arm64/kvm/reset.c   | 2 +-
>  include/uapi/linux/kvm.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index e37c78b..57dc6be 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -77,7 +77,7 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_PMU_V3:
>  		r = kvm_arm_support_pmu_v3();
>  		break;
> -	case KVM_CAP_ARM_INJECT_SERROR_ESR:
> +	case KVM_CAP_ARM_SET_SERROR_ESR:
>  		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
>  		break;
>  	case KVM_CAP_SET_GUEST_DEBUG:
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 07548de..fab7525 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -951,7 +951,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_HYPERV_TLBFLUSH 155
>  #define KVM_CAP_S390_HPAGE_1M 156
>  #define KVM_CAP_NESTED_STATE 157
> -#define KVM_CAP_ARM_INJECT_SERROR_ESR 158
> +#define KVM_CAP_ARM_SET_SERROR_ESR 158
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> 

I'd prefer you fix the documentation rather than the code, as this would
pointlessly break existing code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
