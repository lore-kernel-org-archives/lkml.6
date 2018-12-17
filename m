Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B615C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFF8206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vb6I7xDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389277AbeLQTd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:33:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34324 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbeLQTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:33:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so5383284pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqAJ7CpVrClj01fc/bQYKz6q7wMWGbGap3pF5MFiebg=;
        b=Vb6I7xDD+N84CKMrD7JqBKLThyRzVJstMpfI88sWi3C/amzPJqd++0eAjzjxfSGZ5p
         owoD9N9R8WxLP4KxFs670QbqMIUxys3LisKdvQQvPxDlpMliFOTnEFQQcf47kHzDZuIQ
         rERc8yBDh5MrMar07ymNZJvCxhAEKbYgH3GJqYmnBMcWQEg4r3NdJeEHc49AlzPM+U9F
         ln2jrtI/nxmIoBuaTB64cLW7lttBtPNESWQjnywIyeiO1IC0YaJcInXINJK4YTyrUT5k
         SKpUoB+RmGiwHonpgoXMWhSOjdhX8l4A0KPTOygwYVbEbsfq2kXKcJEDj4Ee9iYxXmeP
         x2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqAJ7CpVrClj01fc/bQYKz6q7wMWGbGap3pF5MFiebg=;
        b=UpsHvhJjpbV8B7ff6vuEURQjkfARGGRXr9j4e1fFoNILbmbBgieSMlsyQ/Gds+j+3e
         sRwjeWYqRaA2FweaS8/OG6mzPqpLNfUyuSz5YDCy0egeqQPlKxF03QxojSaDMND9RnuU
         Z2rcFfoGxxDB+U6nA9F8F0cWHQ8CLuZntrEe7Kumh3y3abrCykJH9uyiyZ9GKbQAMMgF
         EgzhvehuNbUZ7KkdykMbnecstadBQQj//UA1cGa7QbAIzLIh7WsklvBH8t10HRJpfugg
         Ox3ZCaJJYjyOG3qRDiSw7cwNEy1nX6/UAZLXcx55VW8aZ5A0kKcrsnk256a46hOzHhHB
         c+fQ==
X-Gm-Message-State: AA+aEWaDtv7ptxcDa8snaCMwWIxUEmuicDvVQ7wxOlzoW1qcyIjNzb8h
        3KwOa3jnj7BdMgrk1jwEx1fnshq+ue1uQ83/T1XtQQ==
X-Google-Smtp-Source: AFSGD/Xd0N9kSPdtbqHt/fg4ep3w/r7nr4OCd0w90Ake1b8L6P3PKf9tZwx1pfsuvpi4AzjAyra5gqpyLz3prTpDllI=
X-Received: by 2002:a63:7044:: with SMTP id a4mr12916378pgn.359.1545075233957;
 Mon, 17 Dec 2018 11:33:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com> <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com> <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
 <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
In-Reply-To: <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 17 Dec 2018 20:33:42 +0100
Message-ID: <CAAeHK+w2jppKbb26bBk6uP9ydZeHrtNc6b2CVv4xbvt6ecVooA@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Vishwath Mohan <vishwath@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 1:34 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 12/12/18 3:04 PM, Andrey Konovalov wrote:
> > On Tue, Dec 11, 2018 at 5:22 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> Hi Andrey,
> >>
> >> On 06/12/2018 12:24, Andrey Konovalov wrote:
> >>> This commit adds tag-based KASAN specific hooks implementation and
> >>> adjusts common generic and tag-based KASAN ones.
> >>>
> >>> 1. When a new slab cache is created, tag-based KASAN rounds up the size of
> >>>    the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
> >>>
> >>> 2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
> >>>    memory, that corresponds to this object to this tag, and embeds this
> >>>    tag value into the top byte of the returned pointer.
> >>>
> >>> 3. On each kfree tag-based KASAN poisons the shadow memory with a random
> >>>    tag to allow detection of use-after-free bugs.
> >>>
> >>> The rest of the logic of the hook implementation is very much similar to
> >>> the one provided by generic KASAN. Tag-based KASAN saves allocation and
> >>> free stack metadata to the slab object the same way generic KASAN does.
> >>>
> >>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> >>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >>> ---
> >>>  mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
> >>>  mm/kasan/kasan.h  |   8 ++++
> >>>  mm/kasan/tags.c   |  48 +++++++++++++++++++
> >>>  3 files changed, 153 insertions(+), 19 deletions(-)
> >>>
> >>
> >>
> >> [...]
> >>
> >>> @@ -265,6 +290,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >>>               return;
> >>>       }
> >>>
> >>> +     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> >>> +
> >>
> >> Did you consider to set ARCH_SLAB_MINALIGN instead of this round up?
> >
> > I didn't know about this macro. Looks like we can use it to do the
> > same thing. Do you think it's a better solution to redefine
> > ARCH_SLAB_MINALIGN to KASAN_SHADOW_SCALE_SIZE for arm64 when tag-based
> > KASAN is enabled instead of adjusting cache->align in
> > kasan_cache_create?
> >
>
> Yes, I think it is better because in this way we do not need to add extra code
> to do the rounding.
>
> Curiosity, did you try your patches with SLUB red zoning enabled?
> Since the area used for the Redzone is just after the payload, aligning the
> object_size independently from the allocator could have side effects, at least
> if I understand well how the mechanism works.
>
> Setting ARCH_SLAB_MINALIGN should avoid this as well.
>
> What do you think?

Sounds good to me.

Andrew, how should proceed with this? Send another fixup patch or
resend the whole series?

>
> >>
> >> --
> >> Regards,
> >> Vincenzo
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> >> To post to this group, send email to kasan-dev@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2bf7415e-2724-b3c3-9571-20c8b6d43b92%40arm.com.
> >> For more options, visit https://groups.google.com/d/optout.
>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/b99b331d-22ca-b9db-8677-4896c427ef10%40arm.com.
> For more options, visit https://groups.google.com/d/optout.
