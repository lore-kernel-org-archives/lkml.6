Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A513EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B5D21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOeaA4RF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbeLTNC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:02:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38598 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbeLTNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:02:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so867473plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z33AmGyYeTegWwnOqVnqPvq8oZtBrBxpXFU1R2PJCDQ=;
        b=KOeaA4RFW7Vqmg1WmtF7cLRxXmCj5vMgg/OW/MzbZg9l2h0MXNBFsh3zJFRGYNu9DL
         JQNodnslaUNkEMUDlplfn5SNiK72WbiPVGpnNv6NRBHvX6XoGTgY/jZj+W4fZ/MeW/7D
         oTOnVG92FVpJiZ3YMS0mI2x4XmEEitQ36aIsSIqOOzMnvzxdAwV+Nl7IaJ0UgmIOiLOz
         6fPS168dfauNGrXAZW3rlx9zDa++2V2sFumbzrBbc9I2rQvcBCtHZGrqGSW0wn4Fflvx
         fE+uj/0LHKELDJESqQj4LRamOVJ974sekG30+ZoSbG/78as7kjwnRa+y4ifax8qYDwxR
         UCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z33AmGyYeTegWwnOqVnqPvq8oZtBrBxpXFU1R2PJCDQ=;
        b=RLH+2lAgo6V4hDXUdPPEhvgqXD256CJz2Mdg4DBFeI97ic2CjMYOulTVydARl7N3x5
         BqV9zTYeCznGgRXLSkMhhtl0zV55GY6M2LckIYSRQSLdP3tYdC8BVlzXcMogh/AdBh1y
         QSI3LGQyygZUUXvn/NRzgGxfKZLoDvgbHM3577WfivD6PfVYkkMou15dzdBDGuLmsqTC
         36lSzxGjU60r9Cis1/3rHofZL3xxd/2j+iO5dwqy6L0j0qchpc7MQr8JaekCNiGo57AG
         rM+Ffkg549KpEW3hgEpxO1ZYt2lNuiZSFoaxMsV5tSn5yFcZIqe9n30T/lsOeujJX4ND
         +c2Q==
X-Gm-Message-State: AA+aEWaYAKYDHdWcJvmxUPY9pAGLVqYJINlpRNhHdQkguw5FDDsImC7n
        DIbjN/MlX2EGxZ4RNHwHJDuSunqGPkZNnKndawX8IQ==
X-Google-Smtp-Source: AFSGD/WOa83WUlOnQ0njasNEnkyLgn6475HlT3sAOPSTUT2Ym4C/TKTW1I6IgMjTWWIfkk7SKMal+m4GX2ZLl0cvNIQ=
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr24543086plb.10.1545310976746;
 Thu, 20 Dec 2018 05:02:56 -0800 (PST)
MIME-Version: 1.0
References: <706da77adfceb0c324e824d03b52d58a752577ea.1545139710.git.andreyknvl@google.com>
 <20181218125453.4c5e6c056d31ccaa3a73d4a5@linux-foundation.org>
In-Reply-To: <20181218125453.4c5e6c056d31ccaa3a73d4a5@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 20 Dec 2018 14:02:45 +0100
Message-ID: <CAAeHK+yggnKfkycdUdTHG4MvWBMq_XK70m0rQuH873DZU+RnGQ@mail.gmail.com>
Subject: Re: [PATCH mm] kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
To:     Andrew Morton <akpm@linux-foundation.org>
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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

On Tue, Dec 18, 2018 at 9:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 18 Dec 2018 14:30:33 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
>
> > Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
> > in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.
> >
> > ...
> >
> > --- a/arch/arm64/include/asm/kasan.h
> > +++ b/arch/arm64/include/asm/kasan.h
> > @@ -36,6 +36,10 @@
> >  #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
> >                                       (64 - KASAN_SHADOW_SCALE_SHIFT)))
> >
> > +#ifdef CONFIG_KASAN_SW_TAGS
> > +#define ARCH_SLAB_MINALIGN   (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> > +#endif
> > +
> >  void kasan_init(void);
> >  void kasan_copy_shadow(pgd_t *pgdir);
> >  asmlinkage void kasan_early_init(void);
>
> This looks unreliable.  include/linux/slab.h has
>
> /*
>  * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
>  * Intended for arches that get misalignment faults even for 64 bit integer
>  * aligned buffers.
>  */
> #ifndef ARCH_SLAB_MINALIGN
> #define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
> #endif
>
> so if a .c file includes arch/arm64/include/asm/kasan.h after
> include/linux/slab.h, it can get a macro-redefined warning.  If the .c
> file includes those headers in the other order, ARCH_SLAB_MINALIGN will
> get a different value compared to other .c files.
>
> Or something like that.
>
> Different architectures define ARCH_SLAB_MINALIGN in different place:
>
> ./arch/microblaze/include/asm/page.h:#define ARCH_SLAB_MINALIGN L1_CACHE_BYTES
> ./arch/arm/include/asm/cache.h:#define ARCH_SLAB_MINALIGN 8
> ./arch/sh/include/asm/page.h:#define ARCH_SLAB_MINALIGN 8
> ./arch/c6x/include/asm/cache.h:#define ARCH_SLAB_MINALIGN       L1_CACHE_BYTES
> ./arch/sparc/include/asm/cache.h:#define ARCH_SLAB_MINALIGN     __alignof__(unsigned long long)
> ./arch/xtensa/include/asm/processor.h:#define ARCH_SLAB_MINALIGN STACK_ALIGN
>
> which is rather bad of us.
>
> But still.  I think your definition should occur in an arch header file
> which is reliably included from slab.h.  And kasan code should get its
> definition of ARCH_SLAB_MINALIGN by including slab.h.
>

KASAN code doesn't use this macro directly, so I don't think it needs
to get it's definition.

What do you think about adding #include <linux/kasan.h> into
linux/slab.h? Perhaps with a comment that this is needed to get
definition of ARCH_SLAB_MINALIGN?
