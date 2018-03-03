Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeCCHqC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 02:46:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:64444 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751331AbeCCHqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 02:46:01 -0500
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
To: Mathieu Malaterre <malat@debian.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-6-malat@debian.org>
 <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
 <20180226084602.GR21977@gate.crashing.org>
 <CA+7wUsz7srOXwehLjuSn_SEgCUkGxu9bq6aOw5AeOaiiipBNtg@mail.gmail.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <298c9ecc-831b-4d70-b86c-f586a319a133@c-s.fr>
Date: Sat, 3 Mar 2018 08:45:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUsz7srOXwehLjuSn_SEgCUkGxu9bq6aOw5AeOaiiipBNtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/03/2018 à 20:54, Mathieu Malaterre a écrit :
> On Mon, Feb 26, 2018 at 9:46 AM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
>> On Mon, Feb 26, 2018 at 07:32:03AM +0100, Christophe LEROY wrote:
>>> Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
>>>> -#define pfn_valid(pfn)              ((pfn) >= ARCH_PFN_OFFSET && (pfn) <
>>>> max_mapnr)
>>>> +#define pfn_valid(pfn) \
>>>> +            (((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))
>>>
>>> What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than
>>> ARCH_PFN_OFFSET ?
>>
>> It will work fine.
>>
>> Say you are asking for  a <= x < b  so (in actual integers, no overflow)
>> that is  0 <= x-a < b-a  and you also assume x-a overflows, so that we
>> are actually comparing  x-a+M < b-a  with M = 2**32 or such (the maximum
>> value in the unsigned integer type plus one).  This comparison is
>> obviously always false.
>>
>> (It also works if b < a btw).
>>
>>
> Thanks Segher !
> 
> Christophe does that clarify things or do you want me to update the
> commit message ?
> 

No it is fine for me.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
