Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbeBUJo3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:44:29 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:45405 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbeBUJo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:44:28 -0500
X-Google-Smtp-Source: AH8x2246NpuDUgcXeYlbKQKsA6DykzJnQDRj4Yv7Z5gNQ8lzH558R0Eh1m69obUfyM6L+Lb++Muf+MWIbNHTtSL69PY=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1802202213560.31644@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-4-arnd@arndb.de>
 <nycvar.YSQ.7.76.1802202213560.31644@knanqh.ubzr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 10:44:27 +0100
X-Google-Sender-Auth: Qoc1UTWIWgpKZF84vCoRr-fI33c
Message-ID: <CAK8P3a1Tnq=FgkqWhK7FKMSLyBrRxLhbQVP7o3hwBVa-Yx7A3w@mail.gmail.com>
Subject: Re: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 4:15 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 20 Feb 2018, Arnd Bergmann wrote:
>
>> We need some way to pass -mbig-endian to the linker during the
>> LTO link stage, otherwise we get a waning like
>>
>> arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian
>>
>> for each file we link in.
>>
>> There is probably a better method of passing that flag, I'm just
>> adding it to a different hack that I added earlier for x86 LTO
>> here.
>
> Didn't the patch below fix it for you already?

I think the problem here is that -mbig-endian is part of KBUILD_CPPFLAGS,
not KBUILD_CFLAGS. We add the latter to the gcc-ld command line, but not
the former.

      Arnd
