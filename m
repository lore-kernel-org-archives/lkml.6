Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeCFN3J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:29:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:1506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753385AbeCFN3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:29:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="22369335"
Subject: Re: [PATCH 7/7] perf tools: Refine perf_mmap__read_init
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
 <1520277059-32749-7-git-send-email-kan.liang@linux.intel.com>
 <20180305222502.GA7403@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cf790e3f-9ced-2654-3c05-1ea33ee301e1@linux.intel.com>
Date: Tue, 6 Mar 2018 08:29:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305222502.GA7403@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2018 5:25 PM, Jiri Olsa wrote:
> On Mon, Mar 05, 2018 at 02:10:59PM -0500, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index e3921ed..403c5e6 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -235,16 +235,13 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u6
>>   /*
>>    * Report the start and end of the available data in ringbuffer
>>    */
>> -int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
>> -			 u64 *startp, u64 *endp)
>> +int perf_mmap__read_init(struct perf_mmap *md, bool overwrite)
>>   {
>>   	u64 head = perf_mmap__read_head(md);
>>   	u64 old = md->prev;
>>   	unsigned char *data = md->base + page_size;
>>   	unsigned long size;
>>   
>> -	*startp = overwrite ? head : old;
>> -	*endp = overwrite ? old : head;
>>   	md->overwrite = overwrite;
> 
> hum, can't we set 'overwrite' at the moment we create struct perf_mmap?
> 
> it's not changing during the mmap's lifetime.. maybe we could do it in
> perf_evlist__alloc_mmap function

Yes, we know that the __alloc_mmap() is for mmap or overwrite_mmap.
I think we can set the 'overwrite' there.
I will do the change in V2.

Thanks,
Kan

> 
> really nice cleanup!
> 
> thanks,
> jirka
> 
