Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752460AbeB0HoY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:44:24 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:46563 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeB0HoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:44:22 -0500
X-Google-Smtp-Source: AG47ELv4w3kDGjIHsp/8/XalNoPopwIVBfBHq7t2LE4FH+Xd8V3BIpIV4dLnnx0DiGJNJplGoXD/+s6WNphHL0KR/UY=
MIME-Version: 1.0
In-Reply-To: <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com> <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 27 Feb 2018 08:44:01 +0100
X-Google-Sender-Auth: somiXtw70fVggk9x2KHsR0Utz5U
Message-ID: <CA+7wUsys=J8vkEOtzd26B6MGEhfTBRzaA_myuUWNzf24rMvn+A@mail.gmail.com>
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1R7ib1x026731

On Tue, Feb 27, 2018 at 8:33 AM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 27/02/2018 à 08:25, Mathieu Malaterre a écrit :
>>
>> On Mon, Feb 26, 2018 at 3:45 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>>
>>> On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>>
>>>> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org>
>>>> wrote:
>>>
>>>
>>>>>   static void __init check_cpu_feature_properties(unsigned long node)
>>>>>   {
>>>>> -       unsigned long i;
>>>>>          struct feature_property *fp = feature_properties;
>>>>>          const __be32 *prop;
>>>>>
>>>>
>>>> Much simpler is just add
>>>>
>>>> if (ARRAY_SIZE() == 0)
>>>>   return;
>>>>
>>>>> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>>>>> +       for (; fp != feature_properties +
>>>>> ARRAY_SIZE(feature_properties); ++fp) {
>>>
>>>
>>> ...or convert to while(), which will be more readable.
>>
>>
>> So you'd prefer something like:
>>
>> while (fp < feature_properties + ARRAY_SIZE(feature_properties)) {
>>    ...
>>    ++fp;
>> }
>>
>> right ?
>>
>
>
> Why not do as suggested by Segher, ie just replace < by != in the original
> form ?

I can do that.

> Or add in front:
> if (!ARRAY_SIZE(feature_properties))
>         return;

(not tested) I believe the compiler still go over the for() loop and
will complain about the original unsigned comparison.

> Christophe
