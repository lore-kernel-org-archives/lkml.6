Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FBCC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BE62082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upjF35iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BE62082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeLFKTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:19:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35178 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeLFKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:19:17 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so564936itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8E9PbE8KN4ACuzYfCxgB7Qnel5iCJrJXGdqLgrAraZs=;
        b=upjF35iYD3/uGdNNZCfP2U5fqUW4lGBU094scjynoWN24nJtSnzyCQqcxaHybWVzTh
         N7OgaX+UfENuRID4VRbgfPpcQ05YxW/GrXX7KSfwHvgsxXk9r2GrrDY4aLYQCQVJ0kUU
         8fYkkUxjwlHn2HmF6nNqAzHdGXlJFCh1hl/+X29kSZfPHToJyc0fP0es/GufFNCHXI0k
         dQommNJoqgPlcdZVHypT9FoOksl1wBVsNfqws9WrDxqG4GMb1RlcISoT2fD1aRQFOr2G
         fxXmsxtpUjaz06HCMwqJHoHFG/6thVs2Ar/RV4WKGYensUIUeX6CPLjCG6/demjq4LZu
         d7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8E9PbE8KN4ACuzYfCxgB7Qnel5iCJrJXGdqLgrAraZs=;
        b=ENzOAlcdUZKNIe1+90Aasq9DyBJz7IAi2eR9n7WT8FqhAdyJqVadxT6CcMbooTyPsv
         caSeYyzlK4KILQ5fTkXK2Xp5/yJyRmDgiwT+9xFc2zz14qD39gMGAZi/6SawzY+0L9wV
         FZTpdAEbcXTNuPsQXTRM7GpwC0C7ZGMSuhdq3iNxPvOg3jE/k7AljCNjRRQPV9ze77+H
         3ZARyc4z449q0D/O1vXAOSq1g9MN4I1Whzcdk+tn/PchQlGoGdy00MLPbSjGFD0ceLON
         D1xAp8VuGb2yyRD9W/iXGoO6MYOD30DAiVGU1OTHRxaCdqrbVO1d+0hSN6vtPKLw342x
         r0ww==
X-Gm-Message-State: AA+aEWbx2NKJIVRAMaJMgCF+61/9G7uUefrVQ6Cz0i+6k86fJGT4Ui0X
        HQvnP0fQMseoie2rwSYMnAbnKu0VCcYq3rrcUJy1ow==
X-Google-Smtp-Source: AFSGD/UlXjTp0eoz8N48OkTtlNnBxX8SmW0cQOYEM9DQprpIXPKQHJY+yksBfJAv3tL7v8D5cexmCQZLv1b9UiGEGNE=
X-Received: by 2002:a24:2716:: with SMTP id g22mr16771301ita.40.1544091555752;
 Thu, 06 Dec 2018 02:19:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com> <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
 <CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a=Om5Q@mail.gmail.com>
In-Reply-To: <CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a=Om5Q@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Dec 2018 11:19:04 +0100
Message-ID: <CAAeHK+zprEaJMexWRZj1QbuygL0dOC5LqJRok8cairfLw=VVvw@mail.gmail.com>
Subject: Re: [PATCH v12 05/25] kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS
To:     Max Filippov <jcmvbkbc@gmail.com>
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
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

On Tue, Dec 4, 2018 at 11:24 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hello,
>
> On Tue, Nov 27, 2018 at 9:00 AM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This commit splits the current CONFIG_KASAN config option into two:
> > 1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
> >    that exists now);
> > 2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.
>
> [...]
>
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -1,35 +1,95 @@
> > +# This config refers to the generic KASAN mode.
> >  config HAVE_ARCH_KASAN
> >         bool
> >
> > +config HAVE_ARCH_KASAN_SW_TAGS
> > +       bool
> > +
> > +config CC_HAS_KASAN_GENERIC
> > +       def_bool $(cc-option, -fsanitize=kernel-address)
> > +
> > +config CC_HAS_KASAN_SW_TAGS
> > +       def_bool $(cc-option, -fsanitize=kernel-hwaddress)
> > +
> >  if HAVE_ARCH_KASAN
> >
> >  config KASAN
> > -       bool "KASan: runtime memory debugger"
> > +       bool "KASAN: runtime memory debugger"
> > +       help
> > +         Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
> > +         designed to find out-of-bounds accesses and use-after-free bugs.
> > +         See Documentation/dev-tools/kasan.rst for details.
>
> Perhaps KASAN should depend on
> CC_HAS_KASAN_GENERIC || CC_HAS_KASAN_SW_TAGS,
> otherwise make all*config may enable KASAN
> for a compiler that does not have any -fsanitize=kernel-*address
> support, resulting in build failures like this:
>   http://kisskb.ellerman.id.au/kisskb/buildresult/13606170/log/

Will fix in v13, thanks!

>
> --
> Thanks.
> -- Max
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a%3DOm5Q%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
