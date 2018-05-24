Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971564AbeEXVNL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:13:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40098 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969310AbeEXVNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:13:07 -0400
X-Google-Smtp-Source: AB8JxZqRRacTf6JzMfH6tyd1TE2CcSUncAN3MZD9I9AVpopPguxKn2nq9TOQGYEJClvZz0mv94v9ZJ3C7S8HItWZihM=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com>
In-Reply-To: <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 May 2018 14:12:54 -0700
Message-ID: <CAKwvOdkd480hmHduDHnV2ekoAm_dyPnApU9jc7TARyD072KOGA@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 1:52 PM Nick Desaulniers <ndesaulniers@google.com>
wrote:
> On Thu, May 24, 2018 at 1:26 PM Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> > On Thu, May 24, 2018 at 11:59 AM <hpa@zytor.com> wrote:
> > > Issue 3: Let's face it, reading and writing the flags should be
> builtins,
> > exactly because it has to do stack operations, which really means the
> > compiler should be involved.

> > I'm happy to propose that as a feature request to llvm+gcc.

> Oh, looks like both clang and gcc have:
> __builtin_ia32_readeflags_u64()

> https://godbolt.org/g/SwPjhq

> Maybe native_save_fl() and native_restore_fl() should be replaced in the
> kernel with
> __builtin_ia32_readeflags_u64() and __builtin_ia32_writeeflags_u64()?
> --
> Thanks,
> ~Nick Desaulniers

Looks like those builtins got added to GCC around the 4.9 timeframe:
https://godbolt.org/g/9VS2E9

Problematically, it seems that GCC does not have __has_builtin to do
feature detection:
https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
https://godbolt.org/g/oku8ux
-- 
Thanks,
~Nick Desaulniers
