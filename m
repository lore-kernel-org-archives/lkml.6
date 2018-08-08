Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E1C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D040F2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040F2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeHHOFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:05:41 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:40186 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHHOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:05:41 -0400
Received: by mail-oi0-f46.google.com with SMTP id w126-v6so3151231oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 04:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eJLZxogyX+TlWPQazOYBrQ3keoAMUVZAfHwyaaj72M=;
        b=UUo4lLKx0CzLdC/3XYLe67aFGwDgl16et2AGECzGnXoQlemirNueba9XJdHxPZsSqM
         emS2em356iqizNAGmK66HaXLL9jcsFqytZmZxXwMZipdXAb4n3b482/kNQhuyGjT29yY
         Qh36mwtOd+3HzNijExBLSSy73pBiYkhJ0ErLkbNQq0zNkAQe9haYj4fBU4fOZMkKEiVT
         Fg4NIqlume25KH0WkgYab4nYd3MClBN34wlc/g5j56eHlrTsH4Im9K1nWabzDQKkkZXk
         gegvnSw5bzLCojjheIPx8jqZg3HiJUhR7Z4zMC/xqpYX/tNCizS7iwsUfnvNrix5VpOs
         Ug0Q==
X-Gm-Message-State: AOUpUlGiRn9nzdENUU22YpsgaeYOfOC1G99uIJBi/6OrS/OOJ0/tXdoh
        AWfOXM7egaBlCShV6waVi2lu5cpPuV7Ai0Yd2HA=
X-Google-Smtp-Source: AA+uWPxg3O2aoMEKKFuSrLOGw1GwVCGXsXRfEUHTC84sTfT6dZ8TeQZ7jJ9JK4DmnClyEg4SarnDbUAiJw6BGIMbiFo=
X-Received: by 2002:aca:5e02:: with SMTP id s2-v6mr2592945oib.176.1533728781547;
 Wed, 08 Aug 2018 04:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com>
 <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org> <87lg9hb12y.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lg9hb12y.fsf@concordia.ellerman.id.au>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 8 Aug 2018 13:46:10 +0200
Message-ID: <CA+7wUszFS8n+TBs54ez_5hhESN1J0DS0x200Qp7zYtheWMO34g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 12:34 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Andrew Morton <akpm@linux-foundation.org> writes:
> > On Mon, 6 Aug 2018 12:39:21 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> >> CC Dan, Michael, AKPM, powerpc
> >>
> >> On Mon, Apr 16, 2018 at 3:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> > Below is the list of build error/warning regressions/improvements in
> >> > v4.17-rc1[1] compared to v4.16[2].
> >>
> >> I'd like to point your attention to:
> >>
> >> >   + warning: vmlinux.o(.text+0x376518): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
> >> >   + warning: vmlinux.o(.text+0x376d64): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
> >
> > hm.  Dan isn't around at present so we're on our own with this one.
> >
> > x86 doesn't put arch_add_memory and arch_remove_memory into __meminit.
> > x86 does
> >
> > #ifdef CONFIG_MEMORY_HOTPLUG
> > int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> >               bool want_memblock)
> > {
> >       ...
> >
> >
> > So I guess powerpc should do that as well?
>
> But we only recently added it to fix a section mismatch warning:
>
>   WARNING: vmlinux.o(.text+0x6da88): Section mismatch in reference from the function .arch_add_memory() to the function .meminit.text:.create_section_mapping()
>   The function .arch_add_memory() references
>   the function __meminit .create_section_mapping().
>   This is often because .arch_add_memory lacks a __meminit
>   annotation or the annotation of .create_section_mapping is wrong.
>
>
> I think the problem is that the section mismatch logic isn't able to
> cope with __meminit's changing semantics.
>
> When CONFIG_MEMORY_HOTPLUG=y references from .text to .meminit.text
> should be allowed, because they're just folded in together in the linker
> script.
>
> When CONFIG_MEMORY_HOTPLUG=n references from .text to .meminit.text
> should NOT be allowed, because .meminit.text becomes .init.text and will
> be freed.
>
> I don't see anything in the section mismatch logic to cope with that
> difference.
>
> It looks like __meminit is saving us about 1K on powerpc, so I'm
> strongly inclined to just remove it entirely from arch/powerpc.
>
> Also I haven't been seeing this in my local builds because I have:
>
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
>
> So I guess we need to work out why that's interfering with section
> mismatch analysis.

...

Well that's a good question actually. Section mismatch
analysis is done on the throwaway vmlinux.o which is not linked
with --gc-sections (and is not a final link), so the via_pmu_driver
symbol should exist and be picked up.

I wonder if something about the  -ffunction-sections is breaking
the reference detection.
...



ref:
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg135431.html

>
> cheers
