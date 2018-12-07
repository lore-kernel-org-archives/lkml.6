Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFE5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FF92082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W009ofsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FF92082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLGSCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:02:06 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38108 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLGSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:02:06 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so8375816ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jLwhnJ9d6Xz2ShK5DOagGRCfl4SzyAXVWDXMe+WzfQ=;
        b=W009ofsd7ZSHOS0m+3RJea5qOVeeH/ewv5Vma0UNZSbYlShdM+JZXBjwlhlIxeEt59
         fW+Go3u54wK6O+JpRT9ccDKfWAp7tiGj/hKPhRJG2v258lrcQaraLUdGkDG1kKlRark5
         4zS4Y7pJEXFTCnTPpvY0EAlyxwDlBRAxK2cZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jLwhnJ9d6Xz2ShK5DOagGRCfl4SzyAXVWDXMe+WzfQ=;
        b=YvkI3fHjqe2TXE12nXFyCrCM0NqRyQZ5EKOMlFaKhEMoXXk823o9oLu3h/s+uw2ivz
         Lpw31v+a7L5N5wGyGI8jiSXYGh31TTJiIgPpWnXPCsLJVETCKpUZRP+qG3b+/H2CUNWd
         ryGdTLM3ZfDRxXATPNcZGuwj/EP7bzZB2wFjeQZ23lC4GXg0I3guRnOuV+HMv0rHP/RE
         Xlx1zWjhGsIVOiAogk/Yk0qkjaVn6l8uQC0fze/8dCN5WWc606VfnsS0BO8c9eZXfjAr
         UEki92QofKRQgzBxyRB6rWX01hM+YR58PExXBc31StXaAzDMnlubMkgGH+OQRi+bDzJP
         fJgA==
X-Gm-Message-State: AA+aEWaEmsKzpNoLJ1njvxFhDl6rvcW+/A09Qmc9rFTLEvDwa+vpu0lT
        K3EcA8mmxF3gzHP+l+/xd7XgNv46GiEcu1gRq2vKsQ==
X-Google-Smtp-Source: AFSGD/WVOH6Tg65ui5G6TRAlopud6iFIzGU0JIdovz3BOxWNXXYsjHSISs1ytke3ijqu4Jbs9vWagScXKzgBu9CVXM8=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr2673415jab.2.1544205724188;
 Fri, 07 Dec 2018 10:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org> <20181207175326.GB11430@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181207175326.GB11430@edgewater-inn.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Dec 2018 19:01:52 +0100
Message-ID: <CAKv+Gu9LJzMm_xGQOZ=wS6Wr=W1hN7cS+GsVAS0mPUFJ3NT0ng@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm64: assorted fixes for dcache_by_line_op
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 at 18:53, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>
> Cheers for looking at this.
>
> On Thu, Dec 06, 2018 at 04:57:34PM +0100, Ard Biesheuvel wrote:
> > This fixes two issues in dcache_by_line_op: patch #4 fixes the logic
> > that is applied when patching DC CVAP instructions, and patch #5 gets
> > rid of some unintended undefined symbols resulting from incorrect use
> > of conditional GAS directives.
> >
> > Patches #1 to #3 are groundwork for #4.
> >
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> > Cc: Dave Martin <Dave.Martin@arm.com>
> >
> > Ard Biesheuvel (5):
> >   arm64/alternative_cb: move callback reference into replacements
> >     section
> >   arm64/alternative_cb: add nr_alts parameter to callback handlers
> >   arm64/alternative_cb: add support for alternative sequences
> >   arm64/assembler: use callback to 3-way alt-patch DC CVAP instructions
> >   arm64/mm: use string comparisons in dcache_by_line_op
> >
> >  arch/arm64/include/asm/alternative.h | 54 +++++++++++---------
> >  arch/arm64/include/asm/assembler.h   | 17 +++---
> >  arch/arm64/include/asm/kvm_mmu.h     |  4 +-
> >  arch/arm64/kernel/alternative.c      | 22 +++++---
> >  arch/arm64/kernel/cpu_errata.c       | 24 ++++++---
> >  arch/arm64/kvm/va_layout.c           |  8 +--
> >  6 files changed, 79 insertions(+), 50 deletions(-)
>
> Whilst I can see that this solves the problem, I do wonder whether the
> additional infrastructure is really worth it. Couldn't we just do something
> really simple like the diff below instead?
>

That looks fine to me, although not as elegant :-) You are in a better
position to assess if the additional infrastructure may see other uses
in the near future.

In any case, I don't feel strongly about it, so pick whatever you feel
is most suitable. (I just spotted the undefined symbols when I was
playing with lld.)


> --->8
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 953208267252..8dea015b6599 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -390,27 +390,38 @@ alternative_endif
>   *     size:           size of the region
>   *     Corrupts:       kaddr, size, tmp1, tmp2
>   */
> +       .macro __dcache_op_workaround_clean_cache, op, kaddr
> +alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> +       dc      \op, \kaddr
> +alternative_else
> +       dc      civac, \kaddr
> +alternative_endif
> +       .endm
> +
>         .macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
>         dcache_line_size \tmp1, \tmp2
>         add     \size, \kaddr, \size
>         sub     \tmp2, \tmp1, #1
>         bic     \kaddr, \kaddr, \tmp2
>  9998:
> -       .if     (\op == cvau || \op == cvac)
> -alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> -       dc      \op, \kaddr
> -alternative_else
> -       dc      civac, \kaddr
> -alternative_endif
> -       .elseif (\op == cvap)
> +       .ifc    \op, cvau
> +       __dcache_op_workaround_clean_cache \op, \kaddr
> +       .else
> +       .ifc    \op, cvac
> +       __dcache_op_workaround_clean_cache \op, \kaddr
> +       .else
> +       .ifc    \op, cvap
>  alternative_if ARM64_HAS_DCPOP
>         sys 3, c7, c12, 1, \kaddr       // dc cvap
> -alternative_else
> -       dc      cvac, \kaddr
> -alternative_endif
> +       b       9996f
> +alternative_else_nop_endif
> +       __dcache_op_workaround_clean_cache cvac, \kaddr
> +9996:
>         .else
>         dc      \op, \kaddr
>         .endif
> +       .endif
> +       .endif
>         add     \kaddr, \kaddr, \tmp1
>         cmp     \kaddr, \size
>         b.lo    9998b
