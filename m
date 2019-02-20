Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB538C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982E121848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmwHP26B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfBTSHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:07:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36265 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBTSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:07:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id k2so3265058plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 10:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1VwBqXHSWJTSnVDG5Pr81h+6mvhJHmYXwIgZ1/VFbY=;
        b=MmwHP26B/quFqUqkZwkQVV85laoL1NOvnvJb4DTuwXbket1wjVAV+08AKdAKVbjKtE
         6Ggtud9Eb0ErSJGTplC9aOoNbQSvdArJv9WMz1EGodxRlehDrwBDrCKoHyD2NUSCPAUT
         3/BMT8Gu5pJZnjy2i3WxhI1vhBJ5BEdQ5wJ4bHNQgTxDMQvjXnbq7GkWTKHvQhhEq44S
         Dy+fMscYJGuM/AV3YVQbtTj468CFgIb0FGoUqaOPENl0rHv0xrDSRWJJgfh+Cu9Xc9oo
         mPE9X0o8z5JsU6agx73qmywJhtpd1aHVFJUniDmY83fcBAWJ3cByUPuO3g+H6ZEBoB9e
         lRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1VwBqXHSWJTSnVDG5Pr81h+6mvhJHmYXwIgZ1/VFbY=;
        b=kBO+D8u0/4z9W3HLKbWWckMVkB7QILON1be/7kedyn0/jtfl7BeXZPcGwE63nhYTT4
         C2zje4qZxIjI4ZjOGlr0t9JeKdXp4UCb0W3HnnGWpPEvUPcanB4YiMrdzATP6G7hU9qr
         AEO4xlFPCLbly6OIYYitXbWaR4JH/IIEfhvbexOasoWVkHhOt9vVnIoU0Gfu3+N9WNKV
         GzQaS68BJNoz49jutLAdmNfCXUhNxHSGgKSFAL70QDdFw572EHeRuH2bkU/c1lQcHcyF
         Rs5Atc8Nk+T4e1MuC1VgdOTYiMrFdK4VHA5BS35mHEmvRtsM/nXCJOoiHxuhhs2uLOIb
         ybNA==
X-Gm-Message-State: AHQUAuYqWeKLzKp4Qrpqo/6UMWLug1mY90aX8AUXZrb7zAuFgUEyAXzp
        hAYV+HZfw4RYu7bVIXSZpEQL4hcTdiTupBIFOTo/5A==
X-Google-Smtp-Source: AHgI3IYVVWNyJj3HuY73HLy/Oe1r3JElLxHpTxIxDHhGrNNwq6zYcXqWR1/E/fZGmMkOcGXJ1L71jZ+lfg5A7WEfdXk=
X-Received: by 2002:a17:902:3381:: with SMTP id b1mr38395130plc.13.1550686068299;
 Wed, 20 Feb 2019 10:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
In-Reply-To: <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Feb 2019 10:07:36 -0800
Message-ID: <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Brown <broonie@kernel.org>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Evgenii

On Wed, Feb 20, 2019 at 9:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 20, 2019 at 6:00 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> > On 2/20/19 5:51 PM, Arnd Bergmann wrote:
> > > On Wed, Feb 20, 2019 at 3:45 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > I would have to some more research, but I expect several hundred
> > > patches before we get to a clean randconfig build with a broken
> > > compiler.
> >
> > Manually maintaining asan-stack parameter for the sake of one broken compiler isn't a great idea either.
> >
> > Couple alternative suggestions:
> >
> > 1) If we can't fix the problem or the cost of fixing is too high, maybe just hide it? Disable -Wframe-larger-then on pre clang-9 compilers.
> >
> > 2) Fallback cflags. The idea is to try to compile every the file with "-mllvm -asan-stack=1 -Wframe-larger-than=2048 -Werror" at first,
> >  and fallback to "-mllvm -asan-stack=0" if failed. So it would be something similar to $(call cc-option, -mllvm -asan-stack=1 -Wframe-larger-than=2048 -Werror, -mllvm -asan-stack=0)
> >  except that "cc-option" tries options only once on some code example while  we need to try options on every file that we actually compile.
> >  Honestly, I'm not sure that it's worthy to hack Kbuild engine for that particular use-case.
>
> My original plan was to put this under CONFIG_KASAN_EXTRA to allow you
> to still enable it in older compilers, but you just removed that option ;-)
>
> Maybe bringing it back would be a compromise? That way it's hidden from
> all the build testing bots (because of the !CONFIG_COMPILE_TEST dependency),
> but anyone who really wants it can still have the option, and set
> CONFIG_FRAME_WARN
> to whichever value they like.
>
>      Arnd

I like Evgenii's idea:
https://bugs.llvm.org/show_bug.cgi?id=38809#c10

Even though something like that wouldn't make the clang-8 train, I
think it's ok.

While I myself share Arnd's goal of driving compiler warnings to zero,
in general I'd prefer not to disable warning-producing-features or
disable warnings outright for cases where we have some ideas of
changes we can make to the compiler.  There's probably a list now of
false warnings produced by old versions of Clang from bugs in Clang
that we fixed.  I'm not interested in additionally trying to work
around those somehow in kernel sources.

Qian previously pointed out that most drivers don't produce this
warning under KASAN+Clang.  While 114 is a lot, what are the chances
that someone NEEDS a KASAN+Clang build to compile warning free and
happen to include one of these problematic drivers?  And if there is a
chance they do observe the warning, are we doing a disservice by
disabling the feature (-asan-stack=1) outright for the whole kernel,
or disabling the warning (`-Wstack-frame-larger-than=`) which can flag
issues unrelated to KASAN?

To Evgenii's idea, I vote that the compiler is incorrect here, and we
shouldn't start turning things off.  Evgenii, do you have some sense
of how to tune the inliner as you described?
-- 
Thanks,
~Nick Desaulniers
