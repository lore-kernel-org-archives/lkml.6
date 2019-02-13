Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFFDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CBC20700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkIIaBmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392397AbfBMPkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:40:13 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52130 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388510AbfBMPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:40:13 -0500
Received: by mail-it1-f194.google.com with SMTP id y184so7033487itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjUh/RPJXFSZkOu4T3ovEOKI1CsJMOpqZVHtBrSU2Ns=;
        b=kkIIaBmx2y4B9EcB/lPv8BnQHC6avN+NikW/G4A66Jd7jjeI2mMdXCcgj3r1JG7mZH
         Uk2XEvdTnzQxtVRe4PLKbV15q4BB4Ih/crBUXa/FHjBYaf1QjF+4rY3AfmdMBnV5XDvt
         2IPRJceB6Yqa2HMgGjqlIRROCYbECplT1nOBeh1t9lKDctEqtCfdAVAoAVlYKjrYC+z+
         Ls6jjz6JGABEropnEhjyzGMr8H57lo7aCjDun7dFq6FHb8Zyd/uMCMMy514QqFMbwK8T
         P7ufXb6fQQBOpYj1Grg5KtQk8Af+xvMChrVtr43RVcpGxuDd1PN5LZNOteyS2MLXSTGt
         Ug9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjUh/RPJXFSZkOu4T3ovEOKI1CsJMOpqZVHtBrSU2Ns=;
        b=M1wcQEM0lVK/sGBTY+QifBraiZ0PNyGvrLmdPoKyiaa15qte/YEvhAIl9CDW5+8cOK
         tVp3dYshTDDObHFIUxyRE7SSxMEiZDX13lveBqFc783atIpBPnPUfZZlWrxs8Vqo1IhT
         NmwxzvsFpbjHrez0/gj1/Rp+BpnzPFRhEMgLA16Be0DUrjPnDKpvF0gbLX6+dAWwTjMs
         CHLSfj3oyQK/vFYSx9ETg7Y3PPD8HMLMSWZZk6Z8KPawyQ8tSJPqIkcu7TfpzolrqwYi
         OQL6DKzJuvvpN8+YzxP9/+EwzOTorhO6sCe76d0DZ6ahElJHU3j1J37FiCMYLZro3r32
         /c+w==
X-Gm-Message-State: AHQUAuZQ8xcW/FLXLioiCn3/EtjngW+2OSPaI00mgAUL8Uhh4eF+JvHs
        jD2dNJZtSem0V4Nsv9DXvi+RuBvQ1vuhvsOYkPKVww==
X-Google-Smtp-Source: AHgI3IZbk4HaLOoPIZqBJtVcuLNExj4uh5fsqJjlcpjnetOZuEj/HX00w3TfNN7QD18t0eE99oRzhs3rAIP6oYhuJcM=
X-Received: by 2002:a24:710:: with SMTP id f16mr507316itf.121.1550072412073;
 Wed, 13 Feb 2019 07:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20190208165513.8435-1-julien.grall@arm.com> <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
In-Reply-To: <20190213153630.GK3567@e103592.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Feb 2019 16:40:00 +0100
Message-ID: <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 16:36, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Wed, Feb 13, 2019 at 03:30:29PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-02-08 16:55:13 [+0000], Julien Grall wrote:
> > > When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
> > > the kernel may be able to use FPSIMD/SVE. This is for instance the case
> > > for crypto code.
> > >
> > > Any use of FPSIMD/SVE in the kernel are clearly marked by using the
> > > function kernel_neon_{begin, end}. Furthermore, this can only be used
> > > when may_use_simd() returns true.
> >
> > This is equal what x86 is currently doing. The naming is slightly
> > different, there is irq_fpu_usable().
>
> Yes, I think it's basically the same idea.
>
> It's been evolving a bit on both sides, but is quite similar now.
>

may_use_simd() only exists because we have a generic crypto SIMD
helper, and so we needed something arch agnostic to wrap around
irq_fpu_usable()

> > > The current implementation of may_use_simd() allows softirq to use
> > > FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
> > > When in used, softirqs usually fallback to a software method.
> > >
> > > At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
> > > when touching the FPSIMD/SVE context. This has the drawback to disable
> > > all softirqs even if they are not using FPSIMD/SVE.
> >
> > Is this bad? This means also that your crypto code will not be
> > interrupted by a softirq. Also if you would get rid of it, you could
> > avoid the software fallback in case may_use_simd() says false.
>
> Masking softirqs during kernel_neon_begin()..._end() is unlikely to be a
> huge problem, but currently we block softirq during all context switch
> operations that act on the CPU vector registers.
>
> The reasons for this are somewhat historical, and IIRC predated the
> requirement for softirq users of kernel-mode NEON to include the
> may_use_simd() check and implement a fallback path on arm64.
>
> Now that softirq code is required to work around kernel-mode NEON being
> temporarily unusable, masking softirqs completely during context switch
> etc. should no longer be necessary.
>
> > > As a softirq should not rely on been able to use simd at a given time,
> > > there are limited reason to keep softirq disabled when touching the
> > > FPSIMD/SVE context. Instead, we can only disable preemption and tell
> > > the NEON unit is currently in use.
> > >
> > > This patch introduces two new helpers kernel_neon_{disable, enable} to
> > > mark the area using FPSIMD/SVE context and use them in replacement of
> > > local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
> > > also re-implemented to use the new helpers.
> > >
> > > Signed-off-by: Julien Grall <julien.grall@arm.com>
> > >
> > > ---
> > >
> > > I have been exploring this solution as an alternative approach to the RT
> > > patch "arm64: fpsimd: use preemp_disable in addition to local_bh_disable()".
> > >
> > > So far, the patch has only been lightly tested.
> > >
> > > For RT-linux, it might be possible to use migrate_{enable, disable}. I
> > > am quite new with RT and have some trouble to understand the semantics
> > > of migrate_{enable, disable}. So far, I am still unsure if it is possible
> > > to run another userspace task on the same CPU while getting preempted
> > > when the migration is disabled.
> >
> > In RT:
> > - preemt_disable() is the same as !RT. A thread can not be suspend. An
> >   interrupt may interrupt. However on RT we have threaded interrupts so
> >   the interrupt is limited to the first-level handler (not the threaded
> >   handler).
> >
> > - migrate_disable() means that the thread can not be moved to another
> >   CPU. It can be suspended.
> >
> > - local_bh_disable() disables the BH: No softirq can run. In RT
> >   local_bh_disable() does not inherit preempt_disable(). Two different
> >   softirqs can be executed in parallel.
> >   The BH is usually invoked at the end of the threaded interrupt
> >   (because the threaded interrupt handler raises the softirq). It can
> >   also run in the ksoftirqd.
> >
> > Usually you should not get preempted in a migrate_disable() section. A
> > SCHED_OTHER task should not interrupt another SCHED_OTHER task in a
> > migrate_disable() section. A task with a higher priority (a RT/DL task)
> > will. Since threaded interrupts run with a RT priority of 50, they will
> > interrupt your task in a migrate_disable() section.
>
> "Usually" is probably not good enough if another task can run: if the
> preempting task enters userspace then the vector registers are needed
> for its use, which is tricky to arrange if the registers are currently
> in use by context switch logic running in the first task.
>
> My current feeling is that we probably have to stick with
> preempt_disable() here, but hopefully we can get rid of
> local_bh_disable() (as proposed) with no ill effects...
>
> Does that sound sensible?
>
> Cheers
> ---Dave
