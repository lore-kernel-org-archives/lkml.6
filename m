Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09DBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B33320859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw6J7dYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfAGIDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:03:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39271 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAGIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:03:00 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so9010200itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 00:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1R1S1Kgr3LvlawtNp1GI7nZoikDksPlVREryrxzNsDo=;
        b=Zw6J7dYSV6wy0tY9mQTzhf3Z0PXV1LCOB7HXTZOP9xBk/hR3H5BYVX3ca8md6qI1MQ
         LFQTcUpRnpDsQrn/y4A8KKS0hCElWQ8qB1DbaP5AoPapP9lM6zrtR+WgcO+mVA1Wfurm
         0Pe8WkkQ45hCMFqbMksD8FY3HACdyBaIBO05CCbxS7jYRes2iz0P9mQ9W0HJOntGFznf
         96Hg+uCFcJwk84YZYL/braxkJX9CWBcv2IUsSF/7pVVqKA8KjbRbaEMmTjcUYpKJSFTe
         Ca66wg3+fymvyPsrzcAHi7Tr1ukHRd/HRS6WgLbuyXtU9WjxkCrhfp4KFOHqZzL97Wfr
         6nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1R1S1Kgr3LvlawtNp1GI7nZoikDksPlVREryrxzNsDo=;
        b=TgaKhHjWiVRiUfuEfAgsgD4T3hTa7rfBdgMNx4bhSpfmSFaF8f7UZQp4kPGD54qgd1
         nVcPZ/9lKdV7RE4MMVhmqwFhB5+gkduKyyLaWzc2j8dM7I45PPAUWbJWjL0F628aSdlC
         Ztg2KETudE6F1FRzF017mwu9F/pSo1uleDSpzuU4fpNwbSQ96eFHWUa6zeJIoifLTYjT
         JJlKC+MkSpM8tk+bBqi6ufTCGOINqwL9qgqKVwYwQ2YsToeNMH8vz3lxMeYW9Z8WOblk
         6o0I4NnSj2yZJ+ulu1jF6QPdvZj+dMYuxk2MVh72nckEQSFUdDmW5/lnzBXqVztKdkju
         OXRA==
X-Gm-Message-State: AJcUuke1Zwqk3CVtO3IcTeg7daf/YzZ0r7l8IKdkUp6jgzdl/IUzmoEs
        iclw4xADqGGQeo+B0KlMQTdG4qJQM3NJsHuGJQ==
X-Google-Smtp-Source: ALg8bN4ANAizhWz4UoxXjxwNXqn13HNe2V0N4J9VBT0mqpTv1BxsgAQh6lFRGZBHcUtjfHg8heSgalvxFdcJx4VnePA=
X-Received: by 2002:a24:7a94:: with SMTP id a142mr5271801itc.88.1546848179587;
 Mon, 07 Jan 2019 00:02:59 -0800 (PST)
MIME-Version: 1.0
References: <1546591195-21853-1-git-send-email-kernelfans@gmail.com> <20190104094343.GD30750@MiWiFi-R3L-srv>
In-Reply-To: <20190104094343.GD30750@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 7 Jan 2019 16:02:48 +0800
Message-ID: <CAFgQCTvdCqHgZkdb-=sbGUO_ZQ54yLQs0BnhtwjO07xNsiW6_w@mail.gmail.com>
Subject: Re: [PATCHv4] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 5:43 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 01/04/19 at 04:39pm, Pingfan Liu wrote:
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
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Cc: Daniel Vacek <neelx@redhat.com>
> > Cc: Mathieu Malaterre <malat@debian.org>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: yinghai@kernel.org
> > Cc: vgoyal@redhat.com
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > v3 -> v4:
> >  instead of exporting the stage of parsing mem hotplug info, just using the bottom-up allocation func directly
> >  arch/x86/kernel/setup.c  | 8 ++++----
> >  include/linux/memblock.h | 4 ++++
> >  mm/memblock.c            | 2 +-
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index d494b9b..082aadd 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -546,10 +546,10 @@ static void __init reserve_crashkernel(void)
> >                * as old kexec-tools loads bzImage below that, unless
> >                * "crashkernel=size[KMG],high" is specified.
> >                */
> > -             crash_base = memblock_find_in_range(CRASH_ALIGN,
> > -                                                 high ? CRASH_ADDR_HIGH_MAX
> > -                                                      : CRASH_ADDR_LOW_MAX,
> > -                                                 crash_size, CRASH_ALIGN);
> > +             crash_base = __memblock_find_range_bottom_up(CRASH_ALIGN,
>
> Better make a wrapper function for external invocation. E.g we need
> allocate kernel data in mirrorred memory region if it's available. This
> has been done in memblock_find_in_range(), and the boundary alignment.
>
OK, I will update v5.
Thanks for your kindly review.

Regards,
Pingfan
> > +                     (max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN,
> > +                     NUMA_NO_NODE, MEMBLOCK_NONE);
> > +
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index aee299a..39720bf 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -116,6 +116,10 @@ phys_addr_t memblock_find_in_range_node(phys_addr_t size, phys_addr_t align,
> >                                       int nid, enum memblock_flags flags);
> >  phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
> >                                  phys_addr_t size, phys_addr_t align);
> > +phys_addr_t __init_memblock
> > +__memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
> > +                             phys_addr_t size, phys_addr_t align, int nid,
> > +                             enum memblock_flags flags);
> >  void memblock_allow_resize(void);
> >  int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
> >  int memblock_add(phys_addr_t base, phys_addr_t size);
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 81ae63c..53b1707 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -172,7 +172,7 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
> >   * Return:
> >   * Found address on success, 0 on failure.
> >   */
> > -static phys_addr_t __init_memblock
> > +phys_addr_t __init_memblock
> >  __memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
> >                               phys_addr_t size, phys_addr_t align, int nid,
> >                               enum memblock_flags flags)
> > --
> > 2.7.4
> >
