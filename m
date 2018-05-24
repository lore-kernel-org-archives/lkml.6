Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971482AbeEXUwa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:52:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41721 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966499AbeEXUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:52:28 -0400
X-Google-Smtp-Source: AB8JxZo6g1Br/54rvzbdl7CPthrIbw3a67ENXtPLNKeHc7HxAZR7wS32i1r8/SMYL9/oPCs+tAwJpdqOhW8m/w2lRwY=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
In-Reply-To: <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 May 2018 13:52:16 -0700
Message-ID: <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com>
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

On Thu, May 24, 2018 at 1:26 PM Nick Desaulniers <ndesaulniers@google.com>
wrote:
> On Thu, May 24, 2018 at 11:59 AM <hpa@zytor.com> wrote:
> > Issue 3: Let's face it, reading and writing the flags should be
builtins,
> exactly because it has to do stack operations, which really means the
> compiler should be involved.

> I'm happy to propose that as a feature request to llvm+gcc.

Oh, looks like both clang and gcc have:
__builtin_ia32_readeflags_u64()

https://godbolt.org/g/SwPjhq

Maybe native_save_fl() and native_restore_fl() should be replaced in the
kernel with
__builtin_ia32_readeflags_u64() and __builtin_ia32_writeeflags_u64()?
-- 
Thanks,
~Nick Desaulniers
