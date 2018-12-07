Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB755C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C8C20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EG2x/bkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C8C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLGL36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:29:58 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:36695 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:29:57 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wB7BTlSH028832;
        Fri, 7 Dec 2018 20:29:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wB7BTlSH028832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544182188;
        bh=iwC6A0NVZNWbnbBOzBmPCo0htFjf2vbG4IkovKJfXtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EG2x/bkNlp/Fiz75DHImk0iw2bsYvbNH92UU3YpmtZ8NcziAeLZE2yGL+1uhh0Exv
         VYe9vcD+Ls3hIWm5QVyda9ppAiS0yNlpfo83NIxC+39Vr3HNLYXwitavKqPqrHyvZS
         A1Q5Emo7prGJ5cr6x9TNm3DVpDm41VPBxC2yHeLDpKE9VXnL9XnlPfB9EbpyKCTUeD
         0/lAb3ro5tvfxQFABM5UBEReeBbIxPS1iJJlRNjLNH2iT4cgyuOaIaOG9C/fdXXoFv
         Nt5wkBAZ0NBeEppXHI6vZN5oOGUOo0gay+efA9dfz83aD+071YvRhM1RlFeC3RM2K8
         YIQhhyaDsGveA==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id p74so2259256vsc.0;
        Fri, 07 Dec 2018 03:29:48 -0800 (PST)
X-Gm-Message-State: AA+aEWZSbJKHFgR/PQ8rekRFgmJ7QRbroSwz5n4w2SUJHVvSbu7I18aX
        KIyn95SoTVXsAvNXvzK038UHpoeHQIaDAtWVY1s=
X-Google-Smtp-Source: AFSGD/V5lED16kGP6dgOr4/nsYbfkVidxotx/Ldbf2khv3z6Mrmy06LwmSJyxYTBHxBwHS8JBlz1wxMiFUIaFJ6hQ4w=
X-Received: by 2002:a67:485:: with SMTP id 127mr758418vse.54.1544182187164;
 Fri, 07 Dec 2018 03:29:47 -0800 (PST)
MIME-Version: 1.0
References: <1543823457-32478-1-git-send-email-yamada.masahiro@socionext.com> <19c7bdab-8df8-f7c6-7921-9a4d43dbca64@monstr.eu>
In-Reply-To: <19c7bdab-8df8-f7c6-7921-9a4d43dbca64@monstr.eu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 7 Dec 2018 20:29:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWSNqZ8uE+teMW+uvDCLXfq6zMTqh_7=ssrPquCLJz8A@mail.gmail.com>
Message-ID: <CAK7LNATWSNqZ8uE+teMW+uvDCLXfq6zMTqh_7=ssrPquCLJz8A@mail.gmail.com>
Subject: Re: [PATCH 0/7] microblaze: fix various problems in building boot images
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:55 PM Michal Simek <monstr@monstr.eu> wrote:
>
> On 03. 12. 18 8:50, Masahiro Yamada wrote:
> > This patch set fixes various issues in microblaze Makefiles.
> >
> > BTW, "simpleImage.<dt>" works like a phony target to generate the
> > following four images, where the first three are just aliases.
> >
> >  - arch/microblaze/boot/simpleImage.<dt>:
> >          identical to arch/microblaze/boot/linux.bin
> >
> >  - arch/microblaze/boot/simpleImage.<dt>.unstrip:
> >          identical to vmlinux
> >
> >  - arch/microblaze/boot/simpleImage.<dt>.ub:
> >          identical to arch/microblaze/boot/linux.bin.ub
> >
> >  - arch/microblaze/boot/simpleImage.<dt>.strip:
> >          stripped vmlinux
> >
> > I am not sure how much useful those copies are,
> > but, I tried my best to keep the same behavior.
> >
> > IMHO, I guess DTB=<dt> would be more sensible,
> > but it is up to Michal.
> >
> >
> >
> > Masahiro Yamada (7):
> >   microblaze: fix cleaning of boot images
> >   microblaze: adjust the help to the real behavior
> >   microblaze: move "... is ready" message to arch/microblaze/Makefile
> >   microblaze: fix multiple bugs in arch/microblaze/boot/Makefile
> >   microblaze: add linux.bin* and simpleImage.* to PHONY
> >   microblaze: fix race condition in building boot images
> >   microblaze: remove the unneeded code just in case file copy fails
> >
> >  arch/microblaze/Makefile          | 14 +++++++++-----
> >  arch/microblaze/boot/Makefile     | 33 +++++++++++++++++----------------
> >  arch/microblaze/boot/dts/Makefile |  5 +----
> >  3 files changed, 27 insertions(+), 25 deletions(-)
> >
>
> One more thing I have in my mind for a while is that will be good to
> configure kernel build flags from DT and completely get rid of these
> symbols.
>
> XILINX_MICROBLAZE0_USE_MSR_INSTR
> XILINX_MICROBLAZE0_USE_PCMP_INSTR
> XILINX_MICROBLAZE0_USE_BARREL
> XILINX_MICROBLAZE0_USE_DIV
> XILINX_MICROBLAZE0_USE_HW_MUL
> XILINX_MICROBLAZE0_USE_FPU
>
> It means setup CPUFLAGS based on extracting that values from DT that it
> all the time match the hardware.
> It will also simplify all the CPUFLAGS logic which is in
> arch/microblaze/Makefile.
>
> Do you have any idea how this can be done?


I have no idea.

Parsing DTS with sed or something would be possible, but ugly.

In my opinion, the kernel should be multi platform image,
in other words, it is the least common denominator
of supported platforms.

So, the kernel should enable all features that may or may not be used
depending on platform.

I do not know if this works for MB.


-- 
Best Regards
Masahiro Yamada
