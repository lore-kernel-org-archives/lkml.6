Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeB0AxQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 19:53:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:26783 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeB0AxP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 19:53:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="20570365"
Subject: Re: [PATCH] perf stat: Ignore error thread when enabling system-wide
 --per-thread
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
References: <1516117388-10120-1-git-send-email-yao.jin@linux.intel.com>
 <20180116125132.GD26643@krava>
 <1189ec53-0d3b-c59c-63f0-4c4ad0d72405@linux.intel.com>
 <20180116131743.GA17752@krava>
 <a1ee430a-34ab-345d-71c5-c03862092aa8@linux.intel.com>
 <20180123141945.GC15155@krava>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d8184ad9-8426-595f-76c2-0c5a6826a493@linux.intel.com>
Date: Tue, 27 Feb 2018 08:53:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180123141945.GC15155@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2018 10:19 PM, Jiri Olsa wrote:
> On Mon, Jan 22, 2018 at 01:10:31PM +0800, Jin, Yao wrote:
>>
>>
>> On 1/16/2018 9:17 PM, Jiri Olsa wrote:
>>> On Tue, Jan 16, 2018 at 09:06:09PM +0800, Jin, Yao wrote:
>>>> Just tested. But looks it's not OK for '--per-thread' case.
>>>
>>> yea, I haven't tested much.. might need soem tweaking,
>>> but my point was that it could be doable on one place
>>> instead of introducing another if possible
>>>
>>> jirka
>>>
>>
>> Hi Jiri,
>>
>> I ever considered to move the operation of removing error thread to
>> perf_evsel__fallback(). The perf_evsel__fallback() is common code and it's
>> shared by perf report, perf stat and perf top.
>>
>> While finally I think it'd better let the caller decide to remove error
>> thread and try again, or just return the warning message.
>> perf_evsel__fallback() probably doesn't know what the caller want to do.
>>
>> That's my current thinking. Maybe there will be a better fix...
> 
> ok, can't think of better fix atm.. looks good ;-)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 

Hi Arnaldo,

Could this fix be accepted?

Thanks
Jin Yao
