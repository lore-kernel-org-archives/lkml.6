Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0272C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A70220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBiB1TTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A70220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeLLPEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:04:33 -0500
Received: from mail-it1-f171.google.com ([209.85.166.171]:51123 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeLLPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:04:32 -0500
Received: by mail-it1-f171.google.com with SMTP id z7so9475453iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpoxLeEWdCe6ZUeKoHp9WMUaj9WSDS7J7D+6g3Uf7k4=;
        b=nBiB1TTFievXIyFZJ1GjOf7BR/ieJpcwr36DtE6EMtni+BLGACt3LH3GWi+q1azY5H
         6ztQpGuF4Z1Ers5PB54/G1UVBEQOxjPYdD+Xl+0yrtTzxJ9X9qH9yFzuyQZExbq22Jj0
         zyp6z+cPo5Td2P3g9Ie2aItdJm+qdepJejDvr1kM3CA26NsXWCZb2F8nVHV8LrKLDlKx
         18+QNZKNBv95T/cjciFi8SHnxO9lereVW+tRg45xAEC5yC4RuYmybEGf4uRNJ+/ma360
         nNHfTc8eQwM6p/MUReWygmFhEYH5Zvl0u85p3Gtr334RfpAyOPk5u1YJjehrpZC4O5EI
         CvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpoxLeEWdCe6ZUeKoHp9WMUaj9WSDS7J7D+6g3Uf7k4=;
        b=LA7yDQALTumUWwCIM6OemBv+Skuez7M6K//WgAasrACyNn8kkRLYEcCwQgyv6I4WuO
         olJM6kvuCeF565sYHnHQ1AgPVg/nJKYNhTrTfR7KuZjYls60fvRJwDaUII1PodEWFJ8A
         8ve5Zbmk6T3BZF1I1jj3XXjck63t3CrsgXa29wmg8999vTySzHJejcg7RFsJyrvbDiat
         meVXcqLFJIwHoA04EorjjrxmbsPSXfFqJwMt49sK/73snR4H2GLh80ASF1Q1Q2GPVw/+
         p5H21szEEgRI8LEoPGkp33n/3O9alTSq0yJnxBg8C/LXaNZefhG/0bHTeabFBCpf/2M5
         rXiw==
X-Gm-Message-State: AA+aEWZ+istPrUBEQtYXItctR7Y69QES5E4XG7q2NF9wK8OGR4neuB5I
        ffkyTWtdmbOldHs6X+j5k2WgvvdCQ5h1/zolsiAX8A==
X-Google-Smtp-Source: AFSGD/VRxxoyIT9Ze9skeIakHn7TDDpkVWcZCqMd8qAXsBEINZB5VGKJRFzWOZ5YA/BSKpSsG8Dbk0jI8ykdYQy6fg8=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr19921762jak.10.1544627071413;
 Wed, 12 Dec 2018 07:04:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com> <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
In-Reply-To: <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 12 Dec 2018 16:04:20 +0100
Message-ID: <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Dec 11, 2018 at 5:22 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrey,
>
> On 06/12/2018 12:24, Andrey Konovalov wrote:
> > This commit adds tag-based KASAN specific hooks implementation and
> > adjusts common generic and tag-based KASAN ones.
> >
> > 1. When a new slab cache is created, tag-based KASAN rounds up the size of
> >    the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
> >
> > 2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
> >    memory, that corresponds to this object to this tag, and embeds this
> >    tag value into the top byte of the returned pointer.
> >
> > 3. On each kfree tag-based KASAN poisons the shadow memory with a random
> >    tag to allow detection of use-after-free bugs.
> >
> > The rest of the logic of the hook implementation is very much similar to
> > the one provided by generic KASAN. Tag-based KASAN saves allocation and
> > free stack metadata to the slab object the same way generic KASAN does.
> >
> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
> >  mm/kasan/kasan.h  |   8 ++++
> >  mm/kasan/tags.c   |  48 +++++++++++++++++++
> >  3 files changed, 153 insertions(+), 19 deletions(-)
> >
>
>
> [...]
>
> > @@ -265,6 +290,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >               return;
> >       }
> >
> > +     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> > +
>
> Did you consider to set ARCH_SLAB_MINALIGN instead of this round up?

I didn't know about this macro. Looks like we can use it to do the
same thing. Do you think it's a better solution to redefine
ARCH_SLAB_MINALIGN to KASAN_SHADOW_SCALE_SIZE for arm64 when tag-based
KASAN is enabled instead of adjusting cache->align in
kasan_cache_create?

>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2bf7415e-2724-b3c3-9571-20c8b6d43b92%40arm.com.
> For more options, visit https://groups.google.com/d/optout.
