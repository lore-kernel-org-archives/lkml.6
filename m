Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeEKCkX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 22:40:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40373 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeEKCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 22:40:22 -0400
X-Google-Smtp-Source: AB8JxZoie4kOQL7q/cufl5iY9CRMcK4cFEJOTQgM6X5WcP45qxFHMtVvNxrWDdv+N5rBltnSbF0bLZWDb8x6dV5pgcw=
MIME-Version: 1.0
In-Reply-To: <CAEbi=3d11ZcxgyoL-ZEruUzj0odDZ2GZXALNTtC7p55nfkkObA@mail.gmail.com>
References: <4ccb747b-fb3b-18c8-8737-2cc02d7b1c34@roeck-us.net>
 <CAEbi=3cr5i3HKLKOacFih9pz00c7UBKrd=o4ER8HAUT1j_oqGg@mail.gmail.com>
 <CAK8P3a2cogDMEdvhNt8CsJwaONWOgBR7zR3sABun4u8pAgTtqQ@mail.gmail.com> <CAEbi=3d11ZcxgyoL-ZEruUzj0odDZ2GZXALNTtC7p55nfkkObA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 May 2018 22:40:20 -0400
X-Google-Sender-Auth: ehmc4KFkWr6y0-iDusB_nsIiWhs
Message-ID: <CAK8P3a1xDCS1X-4UETB5WW5txD38hrRUGKAfqU=SUy93o3DH5g@mail.gmail.com>
Subject: Re: nds32 build failures
To: Greentime Hu <green.hu@gmail.com>
Cc: Guenter Roeck <private@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>, kito.cheng@gmail.com,
        wuiw@andestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 3:19 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2018-04-17 20:47 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Apr 16, 2018 at 11:06 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> 2018-04-16 11:58 GMT+08:00 Guenter Roeck <private@roeck-us.net>:
>>>
>>> This built failure is because the toolchain version you used is not
>>> supported the latest intrinsic function/macro.
>>> We are sending the latest patchset now and we expect the whole new
>>> features will be supported in gcc8.0.0 and binutil2.31+.
>>>
>>> If you'd like to get these new features of toolchain, you may use the
>>> github version.
>>> This is the built-script repo. https://github.com/andestech/build_script.git
>>
>> I've taken the gcc-6.3 sources from there, and updated them to gcc-6.4.0
>> in order to build a nds32le-linux toolchain based on the same version as
>> the other ones.
>>
>> Unfortunately neither the usual binutils-2.29.1 nor your binutils worked
>> for me, but I eventually managed to get a build using the binutils-2.30
>> release.
>>
>> With this, I could build a mainline kernel with a couple of warnings,
>> but an 'allmodconfig' build still failed.
>>
>> Guenter, can you try my binary from
>> www.kernel.org/pub/tools/crosstool/files/bin/x86_64/6.4.0/x86_64-gcc-6.4.0-nolibc-nds32le-linux.tar.xz
>> ?
>>
>> If that works for you, I'll update the front-page and remove the nds32-elf
>> toolchains.
>>
>> Greentime, do you have a patch set for gcc-7.3 as well, or are 6.3 and 8.0 the
>> only working compilers for nds32le-linux?
>>
>
> Hi, all:
>
> I just discuss with our toolchain colleagues. We have only gcc6.3 and
> gcc8.0 for nds32le-linux.
> I have the ld segmentation fault issue too when building kernel with
> 'allmodconfig'. We are dealing with it.

I've tried building the mainline gcc-8.1 sources for nds32le-linux and
still got a failure with those (building gcc), building a nds32le-elf gcc-8.1.0
worked fine, but that fails to build the vdso (no support for -fPIC), so
it's again unusable for building kernels. Any other ideas?

          Arnd
