Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3247E20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BIap/PUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfBTXrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:47:06 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54916 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTXrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:47:06 -0500
Received: by mail-it1-f196.google.com with SMTP id f10so19753849ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGog4xZ1DHO64g/kYaAx1TpNYdvTWEPLiAriuQ09bOU=;
        b=BIap/PURNJ4I/RXowTGC29TMJXA01I84LxiIU0H8u2+C4oQcHfL8BsxGDvJ1zp2WTX
         fGic787r1c7CaERBL/E+c7GU9y9NDcJ+Fe3lRf+c54wUAiqpgbUS4B5nqf6wPrtR5uQP
         omLaS3fpbgPGKQfA4MyTDBusx6Ilzx+Rm+4XYSoffWkByw0Uxy9eYYI3uNbWlNOchbcn
         REhqf1rTgK7SKzpHUZk04dK46cHYBeirLedlQomlvUQWA+2NZ6MIfjDBaUqPkcQw9Cep
         a2bTGEdptMH26UBlXeiRCXC3Dno1xhSsEvHlD5qBLdk1EgsQDjtzP78u46xSLDUlJ5XC
         8M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGog4xZ1DHO64g/kYaAx1TpNYdvTWEPLiAriuQ09bOU=;
        b=BcSLmetvbtW9vdCThSQoJUSAhKCHfeCB33Ec0HOwKL4UEZnH15h7BBIPSMekRqFevS
         SKLKDFJ43HYiOp+dEPaHQpm1YxVWMmSRE/9I9PGMfZ2YWX584Rskih8sxqeDLqhS2G1D
         cF+dOBfOalMyHyRkkfPYs1cIgyyNsAQWDA2OdkaOZajOgOh9XDDNi8gkhV8Q/u3bLX1n
         1Cu9ZfoIPUBF+XHpm8jtrIP7z6NzDoDh/oMXD3c19LbjafH72+oGcMyDtAtdkpHqP4ey
         myCiIQWKUTV65A8G/y5+WxL5IK5RmKVWM+Nz3GXLJzr07ehm31h9U7WDwfRaFyvpk5JZ
         nJ6A==
X-Gm-Message-State: AHQUAuYiINRdxJLcTEz89DtFTyZOPaQcxX8bCtrpJFmNqfaL8HBJbQPp
        5iTiZYHPYPuFEmn7+JwW+r7z5IyV9QZ0iiX7Nk3jyg==
X-Google-Smtp-Source: AHgI3IbbDDbVr9+LX+8J9gr9Ayoo9gsE2BqPeQXE/DDli9jCJ5sO9FDzp5hEr76H1fk+xk7+kthAMxBzdoFurRgqH1g=
X-Received: by 2002:a6b:5908:: with SMTP id n8mr6091046iob.206.1550706424232;
 Wed, 20 Feb 2019 15:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
 <20190220184408.GG9878@sirena.org.uk> <CAKwvOdne3aE5bUsQF-2C-L2Xezqq9qb=NqF8FA+B7nvqXKAXFA@mail.gmail.com>
 <CAK8P3a1pop4WqWxV=-R4n1Lh3FYG0mb4iJk4=saq6CgzpsPe4A@mail.gmail.com>
 <CAK8P3a0z7Y-uLgc8pWrdt712ic4R2nLbceg_zTCAC=ctG9LK9Q@mail.gmail.com> <CAN=P9pi1J8fORxyp9H4WiEWWDANj0EmFOVGttDMPthUavToHBQ@mail.gmail.com>
In-Reply-To: <CAN=P9pi1J8fORxyp9H4WiEWWDANj0EmFOVGttDMPthUavToHBQ@mail.gmail.com>
From:   Kostya Serebryany <kcc@google.com>
Date:   Wed, 20 Feb 2019 15:46:51 -0800
Message-ID: <CAN=P9pi08jaq0jbFcDssBfw0QrX7AnJfgwCvP5zO0Zf6atFEag@mail.gmail.com>
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

On Wed, Feb 20, 2019 at 2:12 PM Kostya Serebryany <kcc@google.com> wrote:
>
> On Wed, Feb 20, 2019 at 1:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Feb 20, 2019 at 10:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > In the example in https://bugs.llvm.org/show_bug.cgi?id=38809#c12
> > > (https://godbolt.org/z/ylsGSQ) there is no inlining, yet clang uses
> > > over ten times as much stack space as gcc, for reasons I still
> > > can't explain. My assumption right now is that the underlying bug
> > > causes most of the problems with excessive stack usage in
> > > allmodconfig kernels.
> >
> > Here is an even more minimal example:
> >
> > struct s { int i[5]; } f(void);
> > void g(void) { f(); f();}
>
> On this example I can see some stupidity that clang/asan is doing.
> Let me try fixing it and see if it helps bigger cases.
> Thanks for reducing the case!
>
> This is the input we get in the asan instrumentation:
>
> ; Function Attrs: noinline nounwind optnone sanitize_address uwtable
> define dso_local void @g() #0 {
> entry:
>   %tmp = alloca %struct.s, align 4  <<<<<<<<<<<<<<<<<<<<<<<
>   %tmp1 = alloca %struct.s, align 4
>   %0 = bitcast %struct.s* %tmp to i8*
>   call void @llvm.lifetime.start.p0i8(i64 20, i8* %0) #3
>   call void @f(%struct.s* sret %tmp)
>   %1 = bitcast %struct.s* %tmp to i8* <<<<<<<<<<<<<<<<<<<<<
>   call void @llvm.lifetime.end.p0i8(i64 20, i8* %1) #3
>   %2 = bitcast %struct.s* %tmp1 to i8*
>   call void @llvm.lifetime.start.p0i8(i64 20, i8* %2) #3  <<<<<<<<<<<<<
>   call void @f(%struct.s* sret %tmp1)
>   %3 = bitcast %struct.s* %tmp1 to i8*
>   call void @llvm.lifetime.end.p0i8(i64 20, i8* %3) #3
>   ret void
> }

Err.. taking my words back.
These allocas *are* used other then in lifetime markers, since they
are passed to f() as 'sret'.
And we can not drop instrumentation for such allocas. Example:

static volatile int zero = 0;
typedef struct {
  int ar[5];
} S;
S foo() {
  S s;
  s.ar[zero + 6] = 42;
  return s;
}
int main(int argc, char **argv) {
  S s = foo();
  return s.ar[argc];
}

% clang -g  -O1  -fsanitize=address  sret.c && ./a.out

==5822==ERROR: AddressSanitizer: stack-buffer-overflow on address
0x7ffcad027f78 at pc 0x0000004f878d bp 0x7ffcad027f20 sp
0x7ffcad027f18
WRITE of size 4 at 0x7ffcad027f78 thread T0
    #0 0x4f878c in foo sret.c:7:18
    #1 0x4f8838 in main sret.c:11:9
Address 0x7ffcad027f78 is located in stack of thread T0 at offset 56 in frame
    #0 0x4f879f in main sret.c:10

  This frame has 1 object(s):
    [32, 52) 's' (line 11) <== Memory access at offset 56 overflows
this variable

Here we have a struct return that needs to be instrumented inside main
so that a buffer overflow in foo() is detected.

Now, I am also not confident that the reduced case reflects the real problem.

--kcc









>
> the stack variables are not *really* used, but since they are "used"
> inside the lifetime markers they are not eliminated by asan,
> and so asan instruments them, after which no one can remove them any more...
>
>
>
>
> >
> > https://godbolt.org/z/d_KWkh
> >
> > It's clear that clang does /something/ here when asan-stack=1 is
> > set, but I fail to see what it is, or why that is necessary.
> >
> > The output of clang with asan-stack=0 is the expected
> > code, and basically identical to what gcc produces with or
> > without asan-stack.
> >
> >       Arnd
