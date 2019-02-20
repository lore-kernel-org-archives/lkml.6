Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD96C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F6E20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpNHQFA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfBTWM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:12:26 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35562 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfBTWMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:12:25 -0500
Received: by mail-it1-f193.google.com with SMTP id v72so19640559itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tPNGEIDsIfcV4FDJtYuq+z8RJ/zCOWDCU+KMUXAGPNk=;
        b=OpNHQFA1rrT/NK7QUnAK6GeAy+1WnKngmdbetvRhA4kO8LOcYCaPVJUUK/QOY25rGg
         cRUf3efe59QxFTYhh8ipHLoOHXXMFmY49mxHojbFlNQWVYaTVJ5ZVmkR9VijOghfTP1s
         V2yRgwlYjxdqON0Ddoe5i59+UKgv7wLAdlFX1rAd0R9+mmwZCS8r/gzvpnt9lOjuLsga
         AtZyX2adag/1SIsW5/6QX3f8gWhUw/UvllNI9tar6XNIHuSCQck4V3Lh7l5ewbbqZZSV
         Ad4EU7F4K4qHSsaTCWn/0pXSHnIWbCCdNf10GFnvlphaON3sTt34XZAJNNlYtcRAolj0
         i98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPNGEIDsIfcV4FDJtYuq+z8RJ/zCOWDCU+KMUXAGPNk=;
        b=FpkaQXSfPZBnLTjEF4+vkJno/w4NozVVzJqmWqGs4tDIDvkJiuj68c9+GXHdoWhpn2
         SEQlgM4S2PQdo/RX5cz671ysKaYPlv/AExvPl3URKCc+pV8COBL4o74jq6jslZLT/UfT
         xn5yq5ZuvulpntR35biV6RD8mCyVrax4DsDDavPCxqFt7R1m39Ts+lMawbREL9tAp/l6
         HIbInAvXz/QZJad4HTXexSVhhk2Lw8LhxYhY3jnvywAP0jmVFv+idG5tTa0dJzy204mo
         Hbo16hlvhNLwgYLIOnJFCXbZR1Qi6nWO6JuVDnWUSWNdWQOkaVfkga9kiLdP2Ok45UFD
         q5Kw==
X-Gm-Message-State: AHQUAuY2DDpVZt/JpjNbzBsu/9WHeg2vLOsn/xFmkVIHWIlQOwix5U+e
        j5TzmKo6zF2C8qdqH22eAVT0xgdWdqotFJt1KZgO1g==
X-Google-Smtp-Source: AHgI3IZWzydKb1znGxmIl3DryhOTXl7gVFWAIguI179ETB8UFH2Gffx0ILCjcoTL8rmSTeoKEEwGP11K34oqypr3Lxs=
X-Received: by 2002:a02:48c6:: with SMTP id p189mr18408837jaa.89.1550700744134;
 Wed, 20 Feb 2019 14:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
 <20190220184408.GG9878@sirena.org.uk> <CAKwvOdne3aE5bUsQF-2C-L2Xezqq9qb=NqF8FA+B7nvqXKAXFA@mail.gmail.com>
 <CAK8P3a1pop4WqWxV=-R4n1Lh3FYG0mb4iJk4=saq6CgzpsPe4A@mail.gmail.com> <CAK8P3a0z7Y-uLgc8pWrdt712ic4R2nLbceg_zTCAC=ctG9LK9Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0z7Y-uLgc8pWrdt712ic4R2nLbceg_zTCAC=ctG9LK9Q@mail.gmail.com>
From:   Kostya Serebryany <kcc@google.com>
Date:   Wed, 20 Feb 2019 14:12:12 -0800
Message-ID: <CAN=P9pi1J8fORxyp9H4WiEWWDANj0EmFOVGttDMPthUavToHBQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mark Brown <broonie@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 1:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 20, 2019 at 10:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > In the example in https://bugs.llvm.org/show_bug.cgi?id=38809#c12
> > (https://godbolt.org/z/ylsGSQ) there is no inlining, yet clang uses
> > over ten times as much stack space as gcc, for reasons I still
> > can't explain. My assumption right now is that the underlying bug
> > causes most of the problems with excessive stack usage in
> > allmodconfig kernels.
>
> Here is an even more minimal example:
>
> struct s { int i[5]; } f(void);
> void g(void) { f(); f();}

On this example I can see some stupidity that clang/asan is doing.
Let me try fixing it and see if it helps bigger cases.
Thanks for reducing the case!

This is the input we get in the asan instrumentation:

; Function Attrs: noinline nounwind optnone sanitize_address uwtable
define dso_local void @g() #0 {
entry:
  %tmp = alloca %struct.s, align 4  <<<<<<<<<<<<<<<<<<<<<<<
  %tmp1 = alloca %struct.s, align 4
  %0 = bitcast %struct.s* %tmp to i8*
  call void @llvm.lifetime.start.p0i8(i64 20, i8* %0) #3
  call void @f(%struct.s* sret %tmp)
  %1 = bitcast %struct.s* %tmp to i8* <<<<<<<<<<<<<<<<<<<<<
  call void @llvm.lifetime.end.p0i8(i64 20, i8* %1) #3
  %2 = bitcast %struct.s* %tmp1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 20, i8* %2) #3  <<<<<<<<<<<<<
  call void @f(%struct.s* sret %tmp1)
  %3 = bitcast %struct.s* %tmp1 to i8*
  call void @llvm.lifetime.end.p0i8(i64 20, i8* %3) #3
  ret void
}

the stack variables are not *really* used, but since they are "used"
inside the lifetime markers they are not eliminated by asan,
and so asan instruments them, after which no one can remove them any more...




>
> https://godbolt.org/z/d_KWkh
>
> It's clear that clang does /something/ here when asan-stack=1 is
> set, but I fail to see what it is, or why that is necessary.
>
> The output of clang with asan-stack=0 is the expected
> code, and basically identical to what gcc produces with or
> without asan-stack.
>
>       Arnd
