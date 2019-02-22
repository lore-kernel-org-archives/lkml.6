Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A048C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F714207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBVIiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:38:03 -0500
Received: from foss.arm.com ([217.140.101.70]:55812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfBVIiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:38:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C0280D;
        Fri, 22 Feb 2019 00:38:02 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2EE93F703;
        Fri, 22 Feb 2019 00:37:59 -0800 (PST)
Date:   Fri, 22 Feb 2019 08:37:56 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] KVM: arm/arm64: vgic: Improve comment on
 kvm_vgic_inject_irq
Message-ID: <20190222083756.359523ca@why.wild-wind.fr.eu.org>
In-Reply-To: <20190222082327.3312-3-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
        <20190222082327.3312-3-leo.yan@linaro.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 16:23:24 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> The function kvm_vgic_inject_irq() is not only used by PPIs but also can
> be used to inject interrupt for SPIs; this patch improves comment for
> argument @cpuid to reflect support SPIs as well.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  virt/kvm/arm/vgic/vgic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> index 7cfdfbc910e0..79fe64c15051 100644
> --- a/virt/kvm/arm/vgic/vgic.c
> +++ b/virt/kvm/arm/vgic/vgic.c
> @@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
>  /**
>   * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
>   * @kvm:     The VM structure pointer
> - * @cpuid:   The CPU for PPIs
> + * @cpuid:   The CPU for PPIs and SPIs
>   * @intid:   The INTID to inject a new state to.
>   * @level:   Edge-triggered:  true:  to trigger the interrupt
>   *			      false: to ignore the call

What does the CPU mean for SPIs? By definition, the routing of an SPI
is defined by the distributor configuration. And what about LPIs? SGIs?

I'm afraid you've misunderstood what cpuid is for.

	M.
-- 
Without deviation from the norm, progress is not possible.
