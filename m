Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571B52084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tS66kPRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571B52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeLKQC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:02:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52785 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeLKQCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:02:55 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so4302530itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lDXo7875JvpNdIIVM85W2LwkMrgyNvSCv8MEHJ7j3k=;
        b=tS66kPRg4T6a6sS3sCR8zxd6jJehHiIxUakWflPr5JBabcgJNYs/9EXBlKW/nn/cjS
         8hiuTHeetM9Z6fjYktYVpqCqOgioXJJH40Kut411yYAQ5Sg7FsuXHZyS1cZcXcal3RUQ
         1fxKxyiPEgqlARKdyP+QLzED8jm5S2YHBV3trOwG705At6V1sOrYIZ4N6TpORwF38vaO
         4mNwGg+o8jgncxjb+Z6S5I2oySkLj8UWXWIJehk4yw62OPMSEnvRUmrkhrp6b9pgD4R9
         G3PMqrp5qTOXRWC08JbCfJi6hymkWk2uIhjCQrJP9f9sRUtvhVS2snCjgwH2TZJi0s7l
         NlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lDXo7875JvpNdIIVM85W2LwkMrgyNvSCv8MEHJ7j3k=;
        b=s09daaDx9IKIdTphJ+suRbvGm009O2FVUJ42RiuP+VFG4nyGc3B/gxCHg4+TKZQjsk
         rghmT5d/bpkTRcnwaMeoe6DzqbcYnToDXozKhr6QmmM0NdCqqth3Mn+BhELi+N+Cqbsx
         xsNxyEDJYJ1n732R7tUbu6dvSFC/uXyk6zalebvKpVeFHw4sJdv6Xz3+K659EOPXxtYv
         7yvHRszBwMSVOmiE5LsusY5ASrH9BMTKARXEbbzt7CGAf8qtoDjm+eqbKXjO9XJp0hwv
         wz8SATT0vlZjPgw1MNjFJwrNQjvtYUQ8Km/XRLFfkg0tnp/wlwOhgTM1IDcytxW9HV2y
         Xr8Q==
X-Gm-Message-State: AA+aEWajz4RWoE2elhFeW5770oH8bZb0IynYWCW7ugzR07ILgld7Xy6U
        bqch6mdfbAAZsAbHiDW7w0IZTv4B/qe8Hs54NsluKw==
X-Google-Smtp-Source: AFSGD/U6BIMWUwS3xtHV5rNSN2HKjNYFekO3qmjT25rL0Od6qoFKALCSF3wVHgir1HaFI5iW36y7+D5gI8TVCF3PLbk=
X-Received: by 2002:a24:2716:: with SMTP id g22mr2447702ita.40.1544544174164;
 Tue, 11 Dec 2018 08:02:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544099024.git.andreyknvl@google.com> <b2550106eb8a68b10fefbabce820910b115aa853.1544099024.git.andreyknvl@google.com>
 <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
In-Reply-To: <20181211152840.ezjujzpyz5z6fd2d@ltop.local>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 11 Dec 2018 17:02:42 +0100
Message-ID: <CAAeHK+y0AzO8r21L=9HftHuoTXMuTjkZYJOZ6hKZqCEQOjygHQ@mail.gmail.com>
Subject: Re: [PATCH v13 05/25] kasan: add CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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

On Tue, Dec 11, 2018 at 4:28 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, Dec 06, 2018 at 01:24:23PM +0100, Andrey Konovalov wrote:
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index 3e7dafb3ea80..39f668d5066b 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -16,9 +16,13 @@
> >  /* all clang versions usable with the kernel support KASAN ABI version 5 */
> >  #define KASAN_ABI_VERSION 5
> >
> > +#if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
> >  /* emulate gcc's __SANITIZE_ADDRESS__ flag */
> > -#if __has_feature(address_sanitizer)
> >  #define __SANITIZE_ADDRESS__
> > +#define __no_sanitize_address \
> > +             __attribute__((no_sanitize("address", "hwaddress")))
> > +#else
> > +#define __no_sanitize_address
> >  #endif
> >
> >  /*
> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> > index 2010493e1040..5776da43da97 100644
> > --- a/include/linux/compiler-gcc.h
> > +++ b/include/linux/compiler-gcc.h
> > @@ -143,6 +143,12 @@
> >  #define KASAN_ABI_VERSION 3
> >  #endif
> >
> > +#if __has_attribute(__no_sanitize_address__)
> > +#define __no_sanitize_address __attribute__((no_sanitize_address))
> > +#else
> > +#define __no_sanitize_address
> > +#endif
>
> Not really important but it's the name with leading and trailing
> underscores that is tested with __has_attribute() but then it's
> the naked 'no_sanitize_address' that is used in the attribute.

Hi Luc,

You're right. This shouldn't be important though, since "__" in
attribute names are optional AFAIK. It might make sense to fix it as a
separate patch when this series is merged.

Thanks!
