Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeCUK7E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 06:59:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751405AbeCUK7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 06:59:02 -0400
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
To: William Cohen <wcohen@redhat.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
 <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
 <20180307143832.GJ3701@kernel.org>
 <CAKTKpr4zMcRLykw8xwWJKf2eiuCrf2RuJ7kexGRQNN7_OdJ=uQ@mail.gmail.com>
 <52328144-3a2a-af03-273b-3a2f3bdadda6@redhat.com>
 <CAKTKpr7HgsdZ90k0_evSq_aZW-uGSKwLndHOQ2Jahajj3Gkc0Q@mail.gmail.com>
 <2a84ec0e-dc8c-7e2e-64e5-4ea48ba6da49@redhat.com>
 <5b918449-b7b1-dbe1-e6e2-46486116dc65@huawei.com>
 <6bfce413-0fb8-e89c-7400-0704f29f236e@redhat.com>
CC: <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <Will.Deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <Robert.Richter@cavium.com>,
        Ingo Molnar <mingo@redhat.com>, <jnair@caviumnetworks.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>, <linux-arm-kernel@lists.infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <7b85a13a-b9e9-a6d7-ec8f-75630eb7c537@huawei.com>
Date: Wed, 21 Mar 2018 10:58:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <6bfce413-0fb8-e89c-7400-0704f29f236e@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2018 02:37, William Cohen wrote:
> On 03/15/2018 12:47 PM, John Garry wrote:
>> On 15/03/2018 15:53, William Cohen wrote:
>>> On 03/07/2018 11:14 PM, Ganapatrao Kulkarni wrote:
>>>> On Thu, Mar 8, 2018 at 12:01 AM, William Cohen <wcohen@redhat.com> wrote:
>>>>> On 03/07/2018 12:35 PM, Ganapatrao Kulkarni wrote:
>>>>>> Hi Will Cohen,
>>>>>>
>>>>>> On Wed, Mar 7, 2018 at 8:08 PM, Arnaldo Carvalho de Melo
>>>>>> <acme@kernel.org> wrote:
>>>>>>> Em Wed, Mar 07, 2018 at 09:32:05AM -0500, William Cohen escreveu:
>>>>>>>> On 03/07/2018 06:08 AM, Ganapatrao Kulkarni wrote:
>>>>>>>>> There is MIDR change on ThunderX2 B0, adding an entry to mapfile
>>>>>>>>> to enable JSON events for B0.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>>>>>
>>>>>>> Ganapatrao, can you please take this in consideration and if agreeing
>>>>>>> send a v2 patch?
>>>>>>>
>>>>>>> With that I can add an Acked-by: wcohen, Right?
>>>>>>>
>>>>>>> - Arnaldo
>>>>>>>>> ---
>>>>>>>>>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>>>>>>> index e61c9ca..93c5d14 100644
>>>>>>>>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>>>>>>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>>>>>>> @@ -13,4 +13,5 @@
>>>>>>>>>  #
>>>>>>>>>  #Family-model,Version,Filename,EventType
>>>>>>>>>  0x00000000420f5160,v1,cavium,core
>>>>>>>>> +0x00000000430f0af0,v1,cavium,core
>>>>>>>>>  0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>> Like the cortex-a53 the last digit '0' of the match for the MIDR should be replaced with [[:xdigit:]] to allow for possible future revisions of chip:
>>>>>>
>>>>>> for arm64 implementation,  bits 3:0(Revision) and bits 23:20(Variant)
>>>>>> are ignored/dont-care.
>>>>>
>>>>> Thanks for pointing that out.  See the code masking out those bits in linux/toos/perf/arch/util/header.c. For the ppc64 it just copies the equivalent of the MIDR including the revision bits. Thus, the need for regular expression matching to avoid having to create a new entry for each revision.
>>>>
>>>> It is same for arm64 too, there is no need to add an entry for every
>>>> revision change,  need to add when part number changes.
>>>> This patch is not intended to add entry for revision change, the fact
>>>> of the matter is that, there  is complete MIDR change (vulcan to
>>>> thunderx2) in B0.
>>>> as per current arm64
>>>> implementation(.tools/perf/arch/arm64/util/header.c), it is not
>>>> required to have any dontcare marking in mapfile for revision/variant
>>>> bits.
>>>>
>>>> thanks
>>>> Ganapat
>>>
>>> Hi Ganapat,
>>>
>>> Would it make more sense to pass the MIDR value unmodified and then use regular expressions in mapfile.csv to match the values?  If an event on a particular processor revision is broken or unusable it can be excluded from the list of events with a corrected list of events.  There certainly have been errata listing events that do not work on specific revisions of armv8 processor implementations.
>>>
>>
>> Then there are vendors who do not always properly implemenent MIDR or IIDRs (people who live in glass houses...).
>>
>> Btw, topic originally discussed here:
>> https://lkml.org/lkml/2017/5/2/113
>>
>> Thanks,
>> John
>>
>>> -Will
>
> Hi John,
>
> Attached is a patch that leaves the MIDR value unmodified and uses regular expressions in the mapfile.csv instead to ignore those bits.  I have verified that the changes work on ARM Cortex a53 processor.  Does it look reasonable?
>

Hi Will,

This looks ok.

Personally I find the regular expression in the cpuid slightly difficult 
to read. I mean, for example, for the revision digit we are using a 
12-char regular expression in place, which warps the cpuid string length.

BTW, can you also update the pmu events README to mention that posix 
regular expressions in the CPUID are acceptable?

Thanks,
John

> -Will Cohen
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
