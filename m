Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965049AbeFSGtw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:49:52 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35302 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755638AbeFSGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:49:49 -0400
Received: by mail-ua0-f193.google.com with SMTP id s13-v6so12359236uad.2;
        Mon, 18 Jun 2018 23:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m2gDu0XSF/WPMGmedQyekAg5F5c1qY2HsIb0aP3WIZY=;
        b=tDNk95JTCePW4iG7yShtN7gCwbEI1p+Lf6SdyELdN5s2PoRcfcQKJd6AgouEEF8tm7
         lfWEntMxCGXXJ0lk8FX1RrcD+uwFVd+wUtRCM99tMxG7HZhOK+wsLf9ZzOj6dwJpbnAX
         hZ02oBRveKd9yMbsc9scxdGUOCXh80qge4DdVTBzXmwawX8EUibCtb4GgFw2TgtUo+iT
         RLR7LjL32cOoe76+cF46HuJ1dMsWBx7rhYE0ie2M2WQPXkL0JciI5tCTFfvY5i5LutdQ
         EDvNbmANZkJIhA6AVFlMCTqa84VC9uNHczSGMh/EM5RoQJRsdi+HzeIPWvXuqq8LcFNU
         ao6A==
X-Gm-Message-State: APt69E2kQjo44XZDMNi0b3ZE0ZmhiYPTzumkANOl8e7zt9PsCVGjd241
        5/idgZqoKvpuA3OQmL6GFO6wt/MZXjOnFrWaEIAfCQ==
X-Google-Smtp-Source: ADUXVKJ6VDkYvaNJidzLsu9H7IQQCYVAu37cPvCTVS3cBiW2EwjOkWXdKEVsZK8ZV4imov5z0865aJ8Md68802s+X68=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr10488434uas.26.1529390988171;
 Mon, 18 Jun 2018 23:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180618091729.11091-1-geert@linux-m68k.org> <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
 <87vaafxp0k.fsf@concordia.ellerman.id.au>
In-Reply-To: <87vaafxp0k.fsf@concordia.ellerman.id.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jun 2018 08:49:36 +0200
Message-ID: <CAMuHMdUfHJS-ykNr-vPPUDfGLsGr62c4R=EThw33-DFNj9ZQNg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc1
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, Jun 19, 2018 at 8:35 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v4.18-rc1[1] compared to v4.17[2].

> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid':  => 1413:15
> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_nopanic':  => 1377:15
> >>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_raw':  => 1340:15
> >
> > ia64/ia64-defconfig
> > mips/bigsur_defconfig
> > mips/cavium_octeon_defconfig
> > mips/ip22_defconfig
> > mips/ip27_defconfig
> > mips/ip32_defconfig
> > mips/malta_defconfig
> > mips/mips-allmodconfig
> > mips/mips-allnoconfig
> > mips/mips-defconfig
> > mipsel/mips-allmodconfig
> > mipsel/mips-allnoconfig
> > mipsel/mips-defconfig
>
> These are now fixed in Linus' tree by:
>
>   6cc22dc08a24 ("revert "mm/memblock: add missing include <linux/bootmem.h>"")

Good.

> >>   + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >>   + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
> >
> > powerpc/ppc64_defconfig+NO_RADIX
> > ppc64le/powernv_defconfig+NO_RADIX (what's in a name ;-)
>
> Can you tell we don't test that combination very often :/

That's why you have a special config for it? ;-)

> >>   + {standard input}: Error: offset to unaligned destination:  => 2268, 2316, 1691, 1362, 1455, 1598, 2502, 1645, 1988, 1927, 1409, 2615, 1548, 2409, 1268, 2363, 1314, 1208, 1785, 2034, 2222, 2661, 1880, 2552, 1161, 2082, 1833, 2455, 2176, 2129, 1501, 1738
> >
> > sh4/sh-randconfig (doesn't seem to be a new issue, seen before on v4.12-rc3)
>
> I think I'll disable that one, it's been broken more often that not and
> I doubt anyone is that motivated to fix sh4 randconfig breakages?

Probably not. Usually I ignore the commonly seen issues.
This one was more uncommon, so I kept it.

> Relatedly I might move all the randconfig targets from Linus' tree into
> a separate "linus-rand" tree, so that they don't pollute the results, as
> I've done for linux-next.

Sounds look a good thing.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
