Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD524C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0742083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfBURT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:19:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34070 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBURT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:19:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id w4so32426734qtc.1;
        Thu, 21 Feb 2019 09:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nzwk3rzcY9MLEY2IUQCKGUZSKUHlXsRyoZICIt+3Ik=;
        b=eoBpsrnISMrfKCfjs5LjZIt4rCUS5vOkkuOaqM9y50XIykbIXZh6kCs5ZJMbjVAECl
         460qhUg1GZJQRvqLz4v9p8XeASu4HjXi1LkkLEee79BJhD9UG5rnV4yDSILEIIYddpqD
         P4ut4GldzBbw7A51jl6LIxxegbq/VO6+2gASLp1VLi+gZIpdDkIeketO2zdiSnBJ0B9l
         hXqb4sJZAyT4ve4qlYwRqlmlxCqn/qJIhRWx7tEB2ESSRZPrPE0a8b7GAPOe/V7r9UDT
         lB1CLTzQ1jkyahFX/mv/s7Jniz5DOdHXWrPafGKPVwVriYyzras/jp0FFKCXyu+o7uLp
         QMoA==
X-Gm-Message-State: AHQUAub9T+ZkYP9wzDaKLVV92YhynZx6860tyo8/sc3pG5OS+gXEgqD1
        TScbAauH9R7kJPfBJR+tbTQaB1HYieZEizBT2EE=
X-Google-Smtp-Source: AHgI3IbOr0E66wrlgvii3XrfMGfkcqix/Wu7xjQwycpQQhgXO7NwuoOHi0CcoENPF/xrenh45xPZeCZjAQzo0zIiNi8=
X-Received: by 2002:a0c:98c8:: with SMTP id g8mr31373384qvd.161.1550769566726;
 Thu, 21 Feb 2019 09:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com>
 <20190220184408.GG9878@sirena.org.uk> <CAKwvOdne3aE5bUsQF-2C-L2Xezqq9qb=NqF8FA+B7nvqXKAXFA@mail.gmail.com>
 <CAK8P3a1pop4WqWxV=-R4n1Lh3FYG0mb4iJk4=saq6CgzpsPe4A@mail.gmail.com>
 <CAK8P3a0z7Y-uLgc8pWrdt712ic4R2nLbceg_zTCAC=ctG9LK9Q@mail.gmail.com>
 <CAN=P9pi1J8fORxyp9H4WiEWWDANj0EmFOVGttDMPthUavToHBQ@mail.gmail.com> <CAN=P9pi08jaq0jbFcDssBfw0QrX7AnJfgwCvP5zO0Zf6atFEag@mail.gmail.com>
In-Reply-To: <CAN=P9pi08jaq0jbFcDssBfw0QrX7AnJfgwCvP5zO0Zf6atFEag@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Feb 2019 18:19:09 +0100
Message-ID: <CAK8P3a019PTgJfaZ47MABgtT7ZL+i=UHHjQZ-FovTDsDe8Bt9A@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Kostya Serebryany <kcc@google.com>
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

On Thu, Feb 21, 2019 at 12:47 AM Kostya Serebryany <kcc@google.com> wrote:
>
> On Wed, Feb 20, 2019 at 2:12 PM Kostya Serebryany <kcc@google.com> wrote:
> >
> > On Wed, Feb 20, 2019 at 1:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Feb 20, 2019 at 10:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > In the example in https://bugs.llvm.org/show_bug.cgi?id=38809#c12
> > > > (https://godbolt.org/z/ylsGSQ) there is no inlining, yet clang uses
> > > > over ten times as much stack space as gcc, for reasons I still
> > > > can't explain. My assumption right now is that the underlying bug
> > > > causes most of the problems with excessive stack usage in
> > > > allmodconfig kernels.
> > >
> > > Here is an even more minimal example:
> > >
> > > struct s { int i[5]; } f(void);
> > > void g(void) { f(); f();}
> >
> > On this example I can see some stupidity that clang/asan is doing.
> > Let me try fixing it and see if it helps bigger cases.
> > Thanks for reducing the case!
> >
> > This is the input we get in the asan instrumentation:
> >
> > ; Function Attrs: noinline nounwind optnone sanitize_address uwtable
> > define dso_local void @g() #0 {
> > entry:
> >   %tmp = alloca %struct.s, align 4  <<<<<<<<<<<<<<<<<<<<<<<
> >   %tmp1 = alloca %struct.s, align 4
> >   %0 = bitcast %struct.s* %tmp to i8*
> >   call void @llvm.lifetime.start.p0i8(i64 20, i8* %0) #3
> >   call void @f(%struct.s* sret %tmp)
> >   %1 = bitcast %struct.s* %tmp to i8* <<<<<<<<<<<<<<<<<<<<<
> >   call void @llvm.lifetime.end.p0i8(i64 20, i8* %1) #3
> >   %2 = bitcast %struct.s* %tmp1 to i8*
> >   call void @llvm.lifetime.start.p0i8(i64 20, i8* %2) #3  <<<<<<<<<<<<<
> >   call void @f(%struct.s* sret %tmp1)
> >   %3 = bitcast %struct.s* %tmp1 to i8*
> >   call void @llvm.lifetime.end.p0i8(i64 20, i8* %3) #3
> >   ret void
> > }
>
> Err.. taking my words back.
> These allocas *are* used other then in lifetime markers, since they
> are passed to f() as 'sret'.

Thanks a lot for the analysis!

> And we can not drop instrumentation for such allocas. Example:
>
> static volatile int zero = 0;
> typedef struct {
>   int ar[5];
> } S;
> S foo() {
>   S s;
>   s.ar[zero + 6] = 42;
>   return s;
> }
> int main(int argc, char **argv) {
>   S s = foo();
>   return s.ar[argc];
> }
>
> % clang -g  -O1  -fsanitize=address  sret.c && ./a.out
>
> ==5822==ERROR: AddressSanitizer: stack-buffer-overflow on address
> 0x7ffcad027f78 at pc 0x0000004f878d bp 0x7ffcad027f20 sp
> 0x7ffcad027f18
> WRITE of size 4 at 0x7ffcad027f78 thread T0
>     #0 0x4f878c in foo sret.c:7:18
>     #1 0x4f8838 in main sret.c:11:9
> Address 0x7ffcad027f78 is located in stack of thread T0 at offset 56 in frame
>     #0 0x4f879f in main sret.c:10
>
>   This frame has 1 object(s):
>     [32, 52) 's' (line 11) <== Memory access at offset 56 overflows
> this variable
>
> Here we have a struct return that needs to be instrumented inside main
> so that a buffer overflow in foo() is detected.

I tried reproducing this with gcc. The example you list above
will generate very similar code on gcc. However, if I change main() to
not assign the return value of foo() to a local variable, I get a trivial
main main function without sanitizer code, but foo() still detects the
overflow:

=================================================================
==3442660==ERROR: AddressSanitizer: stack-buffer-overflow on address
0x7fff5682bd58 at pc 0x0000004009c3 bp 0x7fff5682bd10 sp
0x7fff5682bd00
WRITE of size 4 at 0x7fff5682bd58 thread T0
    #0 0x4009c2 in foo (/tmp/a.out+0x4009c2)
    #1 0x4009dd in main (/tmp/a.out+0x4009dd)
    #2 0x7fc6f0ce482f in __libc_start_main
(/lib/x86_64-linux-gnu/libc.so.6+0x2082f)
    #3 0x400808 in _start (/tmp/a.out+0x400808)

Address 0x7fff5682bd58 is located in stack of thread T0 at offset 56 in frame
    #0 0x4008c6 in foo (/tmp/a.out+0x4008c6)

  This frame has 1 object(s):
    [32, 52) 's' <== Memory access at offset 56 overflows this variable
HINT: this may be a false positive if your program uses some custom
stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow (/tmp/a.out+0x4009c2) in foo

The other difference is that with gcc, we only get one copy of each stack
variable even when it adds code from asan-stack to check it, while clang
generally creates one copy per instance when asan-stack=1 is set
(but doesn't otherwise).

> Now, I am also not confident that the reduced case reflects the real problem.

No, it probably doesn't, but it seems vaguely related. This is a problem
of using creduce, it sometimes reduces the test cases too much and
runs into a different symptom.

The case we frequently see in the kernel is probably more like

void extf(long *);
static inline __attribute__((always_inline)) void f(void)
{
    long i = 7;
    extg(&i);
}
int main(void)
{
     f();
     f();
}

https://godbolt.org/z/ReEQLo

Here, both gcc and clang add sanitizing for 'i', but clang has multiple
copies, while gcc only has one. This happens for both scalars and
structs, and inline functions as well as open-coded blocks or macros
with the same code in them. Using the inline function for illustration
above since that is the most common way it appears in the kernel.

      Arnd
