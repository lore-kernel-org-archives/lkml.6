Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A474207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBcp3uyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfBVIyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:54:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37860 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:54:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id q3so810754pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uxO3rqEEADR3WQe9mC23xHQlYHLfbl+k4Gnzt0xgl1s=;
        b=CBcp3uyBljJ6HBaL6r0erUswx+Juy+YXQUsxbzuGqQZNmHfax5Nk1Vj9ehos+Eh9nP
         kIl84Bn6ksRbzpusJeMGqb1UXw/ltx2tCT/l+FYSYy0iDTQ5LvA1CICmx5XgdGOce1fM
         Uwi2sY7aA10Z8DPgzA/9Aq0Q5bEXl48y/IXIZAYctF8TaPz5X297QFetghLHeEgiCOvR
         jx05wvqYlgeU5Tx/EFJymHHVhJ2Y7GItfGqcsuoSKc02qmuN3ohVnL/378IclnGiCU6m
         IKsunOHjMW86EBDeaM+tdKsFGPVdjU8d1zzs+yH3XgnQZ1wbIrkepgCWnDVrSo4WwBXE
         Hytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uxO3rqEEADR3WQe9mC23xHQlYHLfbl+k4Gnzt0xgl1s=;
        b=uhHCAyd9QUMGiQH/u37Qr/KIilW+QzbmNQCKkA/NXLR1geaBI9zu1m5yWc3BKeBXih
         QLR2ZuiEDb3nMiw9T6qiMs9v33RwcX4DttMmEAn2K8nB58hIZ+yLrfAN4AKaqNUKdUlr
         fo3r4XzN5xjyI0ZQfY1M4blmAX/3PcPzuka+SALp84MGqPvVMOsB+WO5lMBkmPc6oWtb
         GMrAhmqOuci6JlIDrlai+MCE6RBVSMgM1jslMosQQhe4lxjnyyIBWKVTDADWZ9YsOobY
         6nKfZ9fZwzNZywV2XAerj/kInq8QCox0JdAYUwZ0FWT71iDoPNPoNIg00mJKlB35FTUj
         S5CA==
X-Gm-Message-State: AHQUAuakTdAvCn4g1f0LmKYfggUK/OGWyH3oHbUv8PPBVU/GHFSY+FzU
        YjuaERTt9l3zUVZIcO+Lo43pgg==
X-Google-Smtp-Source: AHgI3IbnIdFmrM5jYh7c3WzXuTNCBWnd2jz6+trum+1vQ3ICgTnMHOPqSVHFEnf+FQ7cxNYdNQvXCw==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13mr3067953plr.293.1550825686445;
        Fri, 22 Feb 2019 00:54:46 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1195-158.members.linode.com. [45.79.96.158])
        by smtp.gmail.com with ESMTPSA id d188sm1738482pfg.98.2019.02.22.00.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 00:54:45 -0800 (PST)
Date:   Fri, 22 Feb 2019 16:54:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
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
Message-ID: <20190222085439.GA845@leoy-ThinkPad-X240s>
References: <20190222082327.3312-1-leo.yan@linaro.org>
 <20190222082327.3312-3-leo.yan@linaro.org>
 <20190222083756.359523ca@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222083756.359523ca@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Fri, Feb 22, 2019 at 08:37:56AM +0000, Marc Zyngier wrote:
> On Fri, 22 Feb 2019 16:23:24 +0800
> Leo Yan <leo.yan@linaro.org> wrote:
> 
> > The function kvm_vgic_inject_irq() is not only used by PPIs but also can
> > be used to inject interrupt for SPIs; this patch improves comment for
> > argument @cpuid to reflect support SPIs as well.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  virt/kvm/arm/vgic/vgic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > index 7cfdfbc910e0..79fe64c15051 100644
> > --- a/virt/kvm/arm/vgic/vgic.c
> > +++ b/virt/kvm/arm/vgic/vgic.c
> > @@ -394,7 +394,7 @@ bool vgic_queue_irq_unlock(struct kvm *kvm, struct vgic_irq *irq,
> >  /**
> >   * kvm_vgic_inject_irq - Inject an IRQ from a device to the vgic
> >   * @kvm:     The VM structure pointer
> > - * @cpuid:   The CPU for PPIs
> > + * @cpuid:   The CPU for PPIs and SPIs
> >   * @intid:   The INTID to inject a new state to.
> >   * @level:   Edge-triggered:  true:  to trigger the interrupt
> >   *			      false: to ignore the call
> 
> What does the CPU mean for SPIs? By definition, the routing of an SPI
> is defined by the distributor configuration.

In the code, KVM injects PPIs by specifying CPU id, so that every PPI
is bound to specific target CPU.  But for SPIs, it always pass '0' for
cpuid, from my understanding this means VM will set interrupt affinity
to VCPU0 by default; in theory we also can set different cpuid for
SPIs so that the SPIs also can be handled by other secondary VCPUs;
this is why I think @cpuid also can be used by SPIs.

> And what about LPIs? SGIs?

TBH, I don't know LPIs and didn't use it before.

For SGIs, I read the code, it uses different path to handle SGI in KVM
so kvm_vgic_inject_irq() is not used for SGIs.

> I'm afraid you've misunderstood what cpuid is for.

Thanks for guidance.

Thanks,
Leo Yan
