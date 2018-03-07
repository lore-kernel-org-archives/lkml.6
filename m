Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933833AbeCGP0C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:26:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933335AbeCGP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:26:01 -0500
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        William Cohen <wcohen@redhat.com>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
 <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
 <20180307143832.GJ3701@kernel.org>
CC: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <Will.Deacon@arm.com>,
        <mark.rutland@arm.com>, <jnair@caviumnetworks.com>,
        <Robert.Richter@cavium.com>, Linuxarm <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <73a51582-2faa-6a75-6c7e-8888b24a3442@huawei.com>
Date: Wed, 7 Mar 2018 15:25:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180307143832.GJ3701@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 14:38, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 07, 2018 at 09:32:05AM -0500, William Cohen escreveu:
>> On 03/07/2018 06:08 AM, Ganapatrao Kulkarni wrote:
>>> There is MIDR change on ThunderX2 B0, adding an entry to mapfile
>>> to enable JSON events for B0.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>
> Ganapatrao, can you please take this in consideration and if agreeing
> send a v2 patch?
>
> With that I can add an Acked-by: wcohen, Right?
>

JFYI, This patch conflicts with "[PATCH v2 00/11] perf events patches 
for improved ARM64 support". I was planning on sending a v3 quite soon.

> - Arnaldo
>>> ---
>>>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>> index e61c9ca..93c5d14 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>> @@ -13,4 +13,5 @@
>>>  #
>>>  #Family-model,Version,Filename,EventType
>>>  0x00000000420f5160,v1,cavium,core
>>> +0x00000000430f0af0,v1,cavium,core
>>>  0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
>>>
>>
>> Hi,
>> Like the cortex-a53 the last digit '0' of the match for the MIDR should be replaced with [[:xdigit:]] to allow for possible future revisions of chip:
>>
>> 0x00000000430f0af[[:xdigit:]],v1,cavium,core
>>
>>
>> -Will Cohen
>
> .

Thanks,
John

>
