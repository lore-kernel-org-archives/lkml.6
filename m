Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981A2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJmuXoxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbfAKNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:49:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37673 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732768AbfAKNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:49:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so6349869pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXKHpApbXWxCHzZIFxDaePnTRIPPkx7fd2gBjWXrl0Q=;
        b=dJmuXoxoR2ebKOkVPfg/NJObqzbDxo0T1be0tynDB7z6tYj7G9hM8VM8rRfre8xL/V
         J+Mhfuo76Dpr63Aw9Nx1khyw6zIEO4MCNMrBfBI4bsC1uKIcpqgsTkXaJiPhA7PU4ypq
         itA0I7fvkdFB1bQqI0Iw+nFS+6FYEUIgYhaWX0RwgO6Yc6h2MLeMR9LWzeKWA1XVbY67
         RJFRIZTQDBGbYvJARugClvD7yC7wXXL3KUNIli7rE4gdOKYyYJjWvTsqAYPH2zkzkYwD
         n/MXITuQcZ+pBj1xyd1fo5wD2Td1v3bOR0R7eMo/k2I8zhFzEHgr2JM8YCmRgIlh0iyd
         4V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXKHpApbXWxCHzZIFxDaePnTRIPPkx7fd2gBjWXrl0Q=;
        b=H9vQg6FTTehSzQ3rWlnYFk5Wd5/Ri0h8GxsVumYwi2Wspojtyj6+OBhV/2fI5fIg9P
         bz8K4em8mj2hS1ChMvXNLjvfgxR+bNqwqjYtUcwdebvcPWh1g+ourQ60lEImQtbZ2QVx
         bI8ltkb+qUjLQqvohTEpAn1Lh3dXfb2HN8pM7/EmbN2Cs7iUj0zhY13z9Qw9hzP0FFEc
         qe/6VTDM9XTDB7ChvhXbfzfK20F3SAhwIMjfc69Caj4RcAWd0gr1oPqW3adVamCAgmba
         /t/rMI9pEN9nc1/AoJcC4oZxUU5tHxPR/8cTeNtOLsR/y5idugBi2/6Du29BZha2uztV
         kMHQ==
X-Gm-Message-State: AJcUukdsHf8CpvwWXwzASriwP83/HF9GQhmQegevvAsOgf24GOT3UxzG
        CB8AfQ5obf618MwB8XaMnqvgwzMWwIONtdb6bNT0kQ==
X-Google-Smtp-Source: ALg8bN79Ji5SFeOBKJt3PLt4o/figJFVOUJpjacA7qTyh0mPZs5n0LFnTClGYX1AY0wZk8bxKDxdW0PBUJ/+g9Pum+o=
X-Received: by 2002:a63:4706:: with SMTP id u6mr3155263pga.95.1547214543132;
 Fri, 11 Jan 2019 05:49:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546540962.git.andreyknvl@google.com> <52ddd881916bcc153a9924c154daacde78522227.1546540962.git.andreyknvl@google.com>
 <fc93e5a4-fa54-98a1-ea5f-4708568d7857@arm.com>
In-Reply-To: <fc93e5a4-fa54-98a1-ea5f-4708568d7857@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 11 Jan 2019 14:48:52 +0100
Message-ID: <CAAeHK+wYo95G3pSoxDWwUs2wf-tBoupwf+0XjO68WXjLzsNWaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
 manual aligning
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 11:10 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 03/01/2019 18:45, Andrey Konovalov wrote:
> > Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
> > in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.
> >
> > Suggested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/cache.h | 6 ++++++
> >  mm/kasan/common.c              | 2 --
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> > index 13dd42c3ad4e..eb43e09c1980 100644
> > --- a/arch/arm64/include/asm/cache.h
> > +++ b/arch/arm64/include/asm/cache.h
> > @@ -58,6 +58,12 @@
> >   */
> >  #define ARCH_DMA_MINALIGN    (128)
> >
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +#define ARCH_SLAB_MINALIGN   (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> > +#else
> > +#define ARCH_SLAB_MINALIGN   __alignof__(unsigned long long)
> > +#endif
> > +
>
> Could you please remove the "#else" case here, because it is redundant (it is
> defined in linux/slab.h as ifndef) and could be misleading in future?

Sure, sent a patch. Thanks!

>
> >  #ifndef __ASSEMBLY__
> >
> >  #include <linux/bitops.h>
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 03d5d1374ca7..44390392d4c9 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -298,8 +298,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> >               return;
> >       }
> >
> > -     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> > -
> >       *flags |= SLAB_KASAN;
> >  }
> >
> >
>
> --
> Regards,
> Vincenzo
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/fc93e5a4-fa54-98a1-ea5f-4708568d7857%40arm.com.
> For more options, visit https://groups.google.com/d/optout.
