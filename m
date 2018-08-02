Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE318C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B784214ED
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B784214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeHBKrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:47:24 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42308 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeHBKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:47:24 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so663192vke.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnfuOU09Jho7uAOPmUzxI27oipwwmBPhP36T/yBpbu4=;
        b=IN+h6zW++P0mfTdrTdfslNE1D3If1vbHpSaG13MXxpUp1R58kswcRk8auyD7CoTmpz
         7CWuTF0kMzOv20P3gQxs6DE6RRIoSZaYcEe4dUC0shR75RuR/VRI2MumIeg46RNWlGJt
         Z/VRl/QP3JadkJvsf+bAvWOG2FpHGOwQme3mEbmzM3vZM/2KakjP1qb1+nhqDpPgtrV4
         IBnCH8RtYN0dsd+a6o9CtkAJKqIKdgMDtGZ3e6YLvyrmMT4QUjeyqP1PCUGgvMaKVTtU
         xvWViSo8JDu5e2yCnzsxowhxb5fAzAmMebZGbdySvGwmEukl37KnryRMzzqPnBQeaQ1n
         Vxug==
X-Gm-Message-State: AOUpUlH8DHQGHu49iuc3yj421YTar8qHIaNive3sc3Na6Cu3JiwLQNFo
        JqX64vsT0TKYFHJme+ZXnYlLH7UPkB/K27bu+kY=
X-Google-Smtp-Source: AAOMgpeBVICBroV+RVl/dyuHiz+z9TTLjsLkVu6TtZO+tq93OaASat77u+eAft1P+guYNvDJJTs0CVeXMakLX7HgX0I=
X-Received: by 2002:a1f:8ad3:: with SMTP id m202-v6mr1093776vkd.9.1533200231711;
 Thu, 02 Aug 2018 01:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180731142954.30345-1-acolin@isi.edu> <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org> <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
In-Reply-To: <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Aug 2018 10:57:00 +0200
Message-ID: <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     alex.bou9@gmail.com
Cc:     Christoph Hellwig <hch@infradead.org>, acolin@isi.edu,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jwalters@isi.edu, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wed, Aug 1, 2018 at 3:16 PM Alex Bounine <alex.bou9@gmail.com> wrote:
> On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> > On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
> >> Platforms with a PCI bus will be offered the RapidIO menu since they may
> >> be want support for a RapidIO PCI device. Platforms without a PCI bus
> >> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>
> >> Tested that kernel builds for arm64 with RapidIO subsystem and
> >> switch drivers enabled, also that the modules load successfully
> >> on a custom Aarch64 Qemu model.
> >
> > As said before, please include it from drivers/Kconfig so that _all_
> > architectures supporting PCI (or other Rapidio attachements) get it
> > and not some arbitrary selection of architectures.

+1

> As it was replied earlier this is not a random selection of
> architectures but only ones that implement support for RapidIO as system
> bus. If other architectures choose to adopt RapidIO we will include them
> as well.
>
> On some platforms RapidIO can be the only system bus available replacing
> PCI/PCIe or RapidIO can coexist with PCIe.
>
> As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or
> "Bus Support" (ARMs) sub-menu and from system configuration option it
> should be kept this way.
>
> Current location of RAPIDIO configuration option is familiar to users of
> PowerPC and x86 platforms, and is similarly available in some ARM
> manufacturers kernel code trees.
>
> drivers/Kconfig will be used for configuring drivers for peripheral
> RapidIO devices if/when such device drivers will be published.

Everything in drivers/rapidio/Kconfig depends on RAPIDIO (probably it should
use a big if RAPIDIO/endif instead), so it can just be included from
drivers/Kconfig now.

The sooner you do that, the less treewide changes are needed (currently
limited to mips, powerpc, and x86; your patch adds arm64).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
