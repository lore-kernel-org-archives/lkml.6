Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeB0RZ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:25:56 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45942 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeB0RZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:25:53 -0500
X-Google-Smtp-Source: AG47ELsst4iPAPFMhIuhjKAHt+1ecTtHG4r+/ybX3JxZ7WkqEp7GNNo24dJRJ7bULlMvOARe6T0rZ7uUXkUAGsjbuHA=
MIME-Version: 1.0
In-Reply-To: <CAHp75VePco3hNo_vM916CiLzBAd18i=O1TaecD5YEDewvMpYYQ@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
 <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr> <CA+7wUsys=J8vkEOtzd26B6MGEhfTBRzaA_myuUWNzf24rMvn+A@mail.gmail.com>
 <CAHp75VePco3hNo_vM916CiLzBAd18i=O1TaecD5YEDewvMpYYQ@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 27 Feb 2018 18:25:31 +0100
X-Google-Sender-Auth: BRzGXChNLwP3aaeX4TPrIgyXBiM
Message-ID: <CA+7wUsw-ckcgRP8=7GfwpSkEoOc3cs=8NABgBEpDNPbwiss0bg@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1RHQ6C7027119

On Tue, Feb 27, 2018 at 4:52 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 27, 2018 at 9:44 AM, Mathieu Malaterre <malat@debian.org> wrote:
>> On Tue, Feb 27, 2018 at 8:33 AM, Christophe LEROY
>> <christophe.leroy@c-s.fr> wrote:
>
>>>>>> Much simpler is just add
>>>>>>
>>>>>> if (ARRAY_SIZE() == 0)
>>>>>>   return;
>
>>> Or add in front:
>>> if (!ARRAY_SIZE(feature_properties))
>>>         return;
>>
>> (not tested) I believe the compiler still go over the for() loop and
>> will complain about the original unsigned comparison.
>
> Did you run tests? Did you look into object file?

The goal of this series is simply to remove warning treated as error.

I tried from home and I can still see the error using gcc 6.3.0, so
the original for() loop needs to be rewritten.

  CC      arch/powerpc/kernel/prom.o
arch/powerpc/kernel/prom.c: In function ‘check_cpu_feature_properties’:
arch/powerpc/kernel/prom.c:301:16: error: comparison of unsigned
expression < 0 is always false [-Werror=type-limits]
  for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
                ^
cc1: all warnings being treated as errors


> In kernel we much rely on the compiling away the code which is
> deterministically not in use.
> Here I'm pretty sure it will compile away entire function.
>
> --
> With Best Regards,
> Andy Shevchenko
