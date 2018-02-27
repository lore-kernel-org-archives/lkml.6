Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752472AbeB0HdW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:33:22 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28015 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbeB0HdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:33:21 -0500
Subject: Re: [PATCH 01/21] powerpc: Remove warning on array size when empty
To: Mathieu Malaterre <malat@debian.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-2-malat@debian.org>
 <CAHp75Vdpdr-0-vdvo0SBx2XcM=HePrUbbb4SM9+ExT_i-1B69Q@mail.gmail.com>
 <CAHp75Ve_zxp4_N_YzzvJ=H8Qs65G5j7bgGBv_TvsZ6Ye2nuECA@mail.gmail.com>
 <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <603d5335-6220-73f2-d902-b92bc74bc79e@c-s.fr>
Date: Tue, 27 Feb 2018 08:33:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUszK++8Tr9j1=4jQtRSu-36MH=dqgimq-ST9D9hvacrJSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/02/2018 à 08:25, Mathieu Malaterre a écrit :
> On Mon, Feb 26, 2018 at 3:45 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Feb 26, 2018 at 4:44 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Sun, Feb 25, 2018 at 7:22 PM, Mathieu Malaterre <malat@debian.org> wrote:
>>
>>>>   static void __init check_cpu_feature_properties(unsigned long node)
>>>>   {
>>>> -       unsigned long i;
>>>>          struct feature_property *fp = feature_properties;
>>>>          const __be32 *prop;
>>>>
>>>
>>> Much simpler is just add
>>>
>>> if (ARRAY_SIZE() == 0)
>>>   return;
>>>
>>>> -       for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>>>> +       for (; fp != feature_properties + ARRAY_SIZE(feature_properties); ++fp) {
>>
>> ...or convert to while(), which will be more readable.
> 
> So you'd prefer something like:
> 
> while (fp < feature_properties + ARRAY_SIZE(feature_properties)) {
>    ...
>    ++fp;
> }
> 
> right ?
> 


Why not do as suggested by Segher, ie just replace < by != in the 
original form ?
Or add in front:
if (!ARRAY_SIZE(feature_properties))
	return;

Christophe
