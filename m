Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeEWLwL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:52:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932629AbeEWLwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:52:10 -0400
Subject: Re: [PATCH v2 2/2] kasan: fix memory hotplug during boot
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>
References: <20180522100756.18478-1-david@redhat.com>
 <20180522100756.18478-3-david@redhat.com>
 <f4378c56-acc2-a5cf-724c-76cffee28235@virtuozzo.com>
 <ff21c6e7-cb32-60d8-abd3-dfc6be3d05f7@redhat.com>
 <09c36096-f8c8-b9e9-0bed-113e494f159a@virtuozzo.com>
 <20180522140735.71dcd92e7b013629a7f15f91@linux-foundation.org>
 <6642e0d8-671c-1c1e-3ae8-99ac34c3b667@virtuozzo.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4ec53da0-bdf6-9db4-b70b-6a05c4d40161@redhat.com>
Date: Wed, 23 May 2018 13:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6642e0d8-671c-1c1e-3ae8-99ac34c3b667@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 11:59, Andrey Ryabinin wrote:
> 
> 
> On 05/23/2018 12:07 AM, Andrew Morton wrote:
>> On Tue, 22 May 2018 22:50:12 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>>>
>>>
>>> On 05/22/2018 07:36 PM, David Hildenbrand wrote:
>>>> On 22.05.2018 18:26, Andrey Ryabinin wrote:
>>>>>
>>>>>
>>>>> On 05/22/2018 01:07 PM, David Hildenbrand wrote:
>>>>>> Using module_init() is wrong. E.g. ACPI adds and onlines memory before
>>>>>> our memory notifier gets registered.
>>>>>>
>>>>>> This makes sure that ACPI memory detected during boot up will not
>>>>>> result in a kernel crash.
>>>>>>
>>>>>> Easily reproducable with QEMU, just specify a DIMM when starting up.
>>>>>
>>>>>          reproducible
>>>>>>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>> ---
>>>>>
>>>>> Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
>>>>> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>>>> Cc: <stable@vger.kernel.org>
>>>>
>>>> Think this even dates back to:
>>>>
>>>> 786a8959912e ("kasan: disable memory hotplug")
>>>>
>>>
>>> Indeed.
>>
>> Is a backport to -stable justified for either of these patches?
>>
> 
> I don't see any reasons to not backport these.
> The first one fixes failure to online memory, why it shouldn't be fixed in -stable?
> The second one is fixes boot crash, it's definitely stable material IMO.
> 

Agreed, at least the second one should be cc stable, as I can reproduce
it with a simple QEMU command.

-- 

Thanks,

David / dhildenb
