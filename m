Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB22C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A9B21871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WarTCNY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfABGsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:48:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43023 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfABGsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:48:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so25294729eds.10;
        Tue, 01 Jan 2019 22:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLoKSSytsM+0SiOlGYwk8zox7JBE2gbCmO+/LdxPZBI=;
        b=WarTCNY0I1tvz/qfiEaFAMuW+gSYZLk/IB53c0yaTzJ6jqdJ5cDigPe2rx+E3zJWej
         xWJAlhg8wViBTYoWvz5CLfTKR+FvObPsG1SbSSCgxO3s94JCasx9zKnHNE3p+f4j+deZ
         zgnRk4loGqKbwUtFwsqGAKPWi5isaNByOGX3L5gwhDhH24M0HRjFeT7MgsPLFvKKmrtZ
         8CH17sugvG0a1a2v0EtlXPWI3BALSRshQ/kg6pv9viDPF/UIi/BH8LfKs57nLez+vrIg
         9BVGnZ/Akj780RwJ3lqkwBLLg09KMRLsmxK4+IGynwT9fX5UF68WUcKXrzR7Nu7TU2oj
         TV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLoKSSytsM+0SiOlGYwk8zox7JBE2gbCmO+/LdxPZBI=;
        b=GjNhS1CKHzBE14A+Uyl589rKTTXQR4eLIZhKp1DtqNg3CWYV/J5ACg/nBhn6EOx+VQ
         VZxKCkeWLAHqafafDA3f4eWWHPK0ellBp9fEQIRgyRgi5Z8CCM35GrmSotWzIVJCk5d0
         mYVSi+B0rF2UCrL4Y+r2LRxRzv/g7/Mk8ClXsQ0cTnEE9q8euDCu3Xa5G5/W/LgtI5yu
         C6iT3Zig1Dvco80ahnbxn37swvm5qYF5dikjr2/To1oMwTFpCy1y1m5x+kcNwoUQCPCW
         Vt0+lCamhIl0kI8n62leNnCeWinC25akGUprfSn10d66bhLf+jUWrC1hNDtT6VM819O8
         7zrw==
X-Gm-Message-State: AA+aEWbT3fxraV9G+E3AWNoWUgJBedpZnXgIg7olQAy9R/TMRgy0Tnzu
        m2IVibRjioxA+ZfyomDSjcxH+1lGUxzwtkyKNw==
X-Google-Smtp-Source: AFSGD/XZXAXwAjiL4nyx4K9YlpP4K/naYkkbRAKn9Prliikb0aoPOKwano0REdSuS6B+xVBAmgE/eSsWFPh37hKtNpg=
X-Received: by 2002:a50:9feb:: with SMTP id c98mr38053176edf.253.1546411686136;
 Tue, 01 Jan 2019 22:48:06 -0800 (PST)
MIME-Version: 1.0
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
 <1545966002-3075-3-git-send-email-kernelfans@gmail.com> <20181231084608.GB28478@rapoport-lnx>
In-Reply-To: <20181231084608.GB28478@rapoport-lnx>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 2 Jan 2019 14:47:54 +0800
Message-ID: <CAFgQCTs2A-_ZzLAz=wZng=2e3+VURd97wJxLv5UesVUTMaw0hg@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] x86/kdump: bugfix, make the behavior of
 crashkernel=X consistent with kaslr
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 4:46 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Dec 28, 2018 at 11:00:02AM +0800, Pingfan Liu wrote:
> > Customer reported a bug on a high end server with many pcie devices, where
> > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > though we still see much memory under 896 MB, the finding still failed
> > intermittently. Because currently we can only find region under 896 MB,
> > if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > why failure is found. It raises confusion to the end user that sometimes
> > crashkernel=X works while sometimes fails.
> > If want to make it succeed, customer can change kernel option to
> > "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> > limited space to behave even though its grammer looks more generic.
> > And we can't answer questions raised from customer that confidently:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> >
> > This patch simplifies the method suggested in the mail [1]. It just goes
> > bottom-up to find a candidate region for crashkernel. The bottom-up may be
> > better compatible with the old reservation style, i.e. still want to get
> > memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> >
> > There is one trivial thing about the compatibility with old kexec-tools:
> > if the reserved region is above 896M, then old tool will fail to load
> > bzImage. But without this patch, the old tool also fail since there is no
> > memory below 896M can be reserved for crashkernel.
> >
> > [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Tang Chen <tangchen@cn.fujitsu.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Cc: Daniel Vacek <neelx@redhat.com>
> > Cc: Mathieu Malaterre <malat@debian.org>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/x86/kernel/setup.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index d494b9b..165f9c3 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
> >
> >       /* 0 means: find the address automatically */
> >       if (crash_base <= 0) {
> > +             bool bottom_up = memblock_bottom_up();
> > +
> > +             memblock_set_bottom_up(true);
> >
> >               /*
> >                * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> >                * as old kexec-tools loads bzImage below that, unless
> >                * "crashkernel=size[KMG],high" is specified.
> >                */
> >               crash_base = memblock_find_in_range(CRASH_ALIGN,
> > -                                                 high ? CRASH_ADDR_HIGH_MAX
> > -                                                      : CRASH_ADDR_LOW_MAX,
> > -                                                 crash_size, CRASH_ALIGN);
> > +                     (max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
> > +             memblock_set_bottom_up(bottom_up);
>
> Using bottom-up does not guarantee that the allocation won't fall into a
> removable memory, it only makes it highly probable.
>
> I think that the 'max_pfn * PAGE_SIZE' limit should be replaced with the
> end of the non-removable memory node.
>
Since passing MEMBLOCK_NONE, memblock_find_in_range() ->...->
__next_mem_range(), there is a logic to guarantee hotmovable memory
will not be stamped over.
if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
continue;

Thanks,
Pingfan

> > +
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > --
> > 2.7.4
> >
>
> --
> Sincerely yours,
> Mike.
>
