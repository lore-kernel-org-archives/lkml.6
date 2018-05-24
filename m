Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969749AbeEXVih convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:38:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47165 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161426AbeEXVie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:38:34 -0400
Date: Thu, 24 May 2018 14:38:21 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com> <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com> <CAKwvOdmQER7XtO_uygYDBxGgUr-EruGyjUq9DMbNwQFh11=9gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
CC: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
From: hpa@zytor.com
Message-ID: <EB0D8B9E-0646-4D27-8F3D-750AF09BFAE4@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24, 2018 1:52:16 PM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>On Thu, May 24, 2018 at 1:26 PM Nick Desaulniers
><ndesaulniers@google.com>
>wrote:
>> On Thu, May 24, 2018 at 11:59 AM <hpa@zytor.com> wrote:
>> > Issue 3: Let's face it, reading and writing the flags should be
>builtins,
>> exactly because it has to do stack operations, which really means the
>> compiler should be involved.
>
>> I'm happy to propose that as a feature request to llvm+gcc.
>
>Oh, looks like both clang and gcc have:
>__builtin_ia32_readeflags_u64()
>
>https://godbolt.org/g/SwPjhq
>
>Maybe native_save_fl() and native_restore_fl() should be replaced in
>the
>kernel with
>__builtin_ia32_readeflags_u64() and __builtin_ia32_writeeflags_u64()?

It should, at least when the compiler supports them (we keep support in for old compilers back to about gcc 3.4 or 4.1 or so for x86, but they are intently special cases.)

For the PV case, I think we should create it as an explicit assembly function, meaning it should be an extern inline in C code. That way we're fixing the kernel right.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
