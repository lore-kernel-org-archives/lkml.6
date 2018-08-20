Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456DCC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03985216FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03985216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeHTRpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:45:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbeHTRpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:45:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 081EC402B032;
        Mon, 20 Aug 2018 14:29:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B70D763F56;
        Mon, 20 Aug 2018 14:29:27 +0000 (UTC)
Date:   Mon, 20 Aug 2018 16:29:25 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: Documentation: rename the capability of
 KVM_CAP_ARM_SET_SERROR_ESR
Message-ID: <20180820142925.zw2vgplbutfcvvos@kamzik.brq.redhat.com>
References: <1534801165-41525-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534801165-41525-1-git-send-email-gengdongjiu@huawei.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 20 Aug 2018 14:29:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 20 Aug 2018 14:29:29 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'drjones@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 05:39:25PM -0400, Dongjiu Geng wrote:
> In the documentation description, this capability's name is
> KVM_CAP_ARM_SET_SERROR_ESR, but in the header file this
> capability's name is KVM_CAP_ARM_INJECT_SERROR_ESR, so change
> the documentation description to make it same.
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
>  Documentation/virtual/kvm/api.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 0acdbac..c664064 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -909,10 +909,10 @@ Serviceability (RAS) Specification").
>  
>  SError exceptions always have an ESR value. Some CPUs have the ability to
>  specify what the virtual SError's ESR value should be. These systems will
> -advertise KVM_CAP_ARM_SET_SERROR_ESR. In this case exception.has_esr will
> +advertise KVM_CAP_ARM_INJECT_SERROR_ESR. In this case exception.has_esr will
>  always have a non-zero value when read, and the agent making an SError pending
>  should specify the ISS field in the lower 24 bits of exception.serror_esr. If
> -the system supports KVM_CAP_ARM_SET_SERROR_ESR, but user-space sets the events
> +the system supports KVM_CAP_ARM_INJECT_SERROR_ESR, but user-space sets the events
>  with exception.has_esr as zero, KVM will choose an ESR.
>  
>  Specifying exception.has_esr on a system that does not support it will return
> @@ -4749,7 +4749,7 @@ hypercalls:
>  HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
>  HvFlushVirtualAddressList, HvFlushVirtualAddressListEx.
>  
> -8.19 KVM_CAP_ARM_SET_SERROR_ESR
> +8.19 KVM_CAP_ARM_INJECT_SERROR_ESR
>  
>  Architectures: arm, arm64
>  
> -- 
> 2.7.4
>

Reported-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew
