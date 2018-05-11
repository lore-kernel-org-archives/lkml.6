Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEKFR2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 01:17:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40318 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeEKFR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 01:17:26 -0400
X-Google-Smtp-Source: AB8JxZqpEJROcoF1ETohxKAEllX40d/Ai1qaaPBGYqvO++eL/MVK5w3VePUb13yO64jhwS8JK2NhzqT/qLNN9jM20f4=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1xDCS1X-4UETB5WW5txD38hrRUGKAfqU=SUy93o3DH5g@mail.gmail.com>
References: <4ccb747b-fb3b-18c8-8737-2cc02d7b1c34@roeck-us.net>
 <CAEbi=3cr5i3HKLKOacFih9pz00c7UBKrd=o4ER8HAUT1j_oqGg@mail.gmail.com>
 <CAK8P3a2cogDMEdvhNt8CsJwaONWOgBR7zR3sABun4u8pAgTtqQ@mail.gmail.com>
 <CAEbi=3d11ZcxgyoL-ZEruUzj0odDZ2GZXALNTtC7p55nfkkObA@mail.gmail.com> <CAK8P3a1xDCS1X-4UETB5WW5txD38hrRUGKAfqU=SUy93o3DH5g@mail.gmail.com>
From: Kito Cheng <kito.cheng@gmail.com>
Date: Fri, 11 May 2018 13:17:05 +0800
X-Google-Sender-Auth: P5a5bQBqRw8CdZScFkVnFNCnmU8
Message-ID: <CA+yXCZBqrz5Ftmen8wH5uBWGAKQ0cxPiK_nqKS6meUxXCPQ3Og@mail.gmail.com>
Subject: Re: nds32 build failures
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>,
        Guenter Roeck <private@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        =?UTF-8?B?QWxlYyBJLVdlaSBXdSjlkLPlpZXnt68p?= <wuiw@andestech.com>,
        Chung-Ju Wu <jasonwucj@gmail.com>, Kito Cheng <kito@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd:

I am GCC guy from Andes, we've missed the release schedule for GCC 8,
we didn't upstream the Linux support on time.

Our plan is put our GCC 8 on github and continue commit rest patches
to upstream.
And we'll put our source on github after our internal testing done.

Thanks.

On Fri, May 11, 2018 at 10:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Apr 18, 2018 at 3:19 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> 2018-04-17 20:47 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Mon, Apr 16, 2018 at 11:06 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>>> 2018-04-16 11:58 GMT+08:00 Guenter Roeck <private@roeck-us.net>:
>>>>
>>>> This built failure is because the toolchain version you used is not
>>>> supported the latest intrinsic function/macro.
>>>> We are sending the latest patchset now and we expect the whole new
>>>> features will be supported in gcc8.0.0 and binutil2.31+.
>>>>
>>>> If you'd like to get these new features of toolchain, you may use the
>>>> github version.
>>>> This is the built-script repo. https://github.com/andestech/build_script.git
>>>
>>> I've taken the gcc-6.3 sources from there, and updated them to gcc-6.4.0
>>> in order to build a nds32le-linux toolchain based on the same version as
>>> the other ones.
>>>
>>> Unfortunately neither the usual binutils-2.29.1 nor your binutils worked
>>> for me, but I eventually managed to get a build using the binutils-2.30
>>> release.
>>>
>>> With this, I could build a mainline kernel with a couple of warnings,
>>> but an 'allmodconfig' build still failed.
>>>
>>> Guenter, can you try my binary from
>>> www.kernel.org/pub/tools/crosstool/files/bin/x86_64/6.4.0/x86_64-gcc-6.4.0-nolibc-nds32le-linux.tar.xz
>>> ?
>>>
>>> If that works for you, I'll update the front-page and remove the nds32-elf
>>> toolchains.
>>>
>>> Greentime, do you have a patch set for gcc-7.3 as well, or are 6.3 and 8.0 the
>>> only working compilers for nds32le-linux?
>>>
>>
>> Hi, all:
>>
>> I just discuss with our toolchain colleagues. We have only gcc6.3 and
>> gcc8.0 for nds32le-linux.
>> I have the ld segmentation fault issue too when building kernel with
>> 'allmodconfig'. We are dealing with it.
>
> I've tried building the mainline gcc-8.1 sources for nds32le-linux and
> still got a failure with those (building gcc), building a nds32le-elf gcc-8.1.0
> worked fine, but that fails to build the vdso (no support for -fPIC), so
> it's again unusable for building kernels. Any other ideas?
>
>           Arnd
