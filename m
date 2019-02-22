Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F760C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA05206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBVLny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:43:54 -0500
Received: from foss.arm.com ([217.140.101.70]:58332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfBVLnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:43:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A19B15AB;
        Fri, 22 Feb 2019 03:43:53 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86A843F5C1;
        Fri, 22 Feb 2019 03:43:51 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:43:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] KVM: arm/arm64: Define TCR_EL2_T0SZ_MASK as
 TCR_T0SZ_MASK
Message-ID: <20190222114348.GC42419@lakrids.cambridge.arm.com>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222082327.3312-4-leo.yan@linaro.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:23:25PM +0800, Leo Yan wrote:
> Define macro TCR_EL2_T0SZ_MASK as TCR_T0SZ_MASK, so can remove the hard
> number 0x3f.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Given we do this for the other TCR fields, and the value is correct
AFAICT, this makes sense to me. FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/kvm_arm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 6f602af5263c..d945a787f36e 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -99,7 +99,7 @@
>  #define TCR_EL2_SH0_MASK	TCR_SH0_MASK
>  #define TCR_EL2_ORGN0_MASK	TCR_ORGN0_MASK
>  #define TCR_EL2_IRGN0_MASK	TCR_IRGN0_MASK
> -#define TCR_EL2_T0SZ_MASK	0x3f
> +#define TCR_EL2_T0SZ_MASK	TCR_T0SZ_MASK
>  #define TCR_EL2_MASK	(TCR_EL2_TG0_MASK | TCR_EL2_SH0_MASK | \
>  			 TCR_EL2_ORGN0_MASK | TCR_EL2_IRGN0_MASK | TCR_EL2_T0SZ_MASK)
>  
> -- 
> 2.17.1
> 
