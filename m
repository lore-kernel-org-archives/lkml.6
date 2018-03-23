Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCWUiL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:38:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:34143 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeCWUiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:38:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="30759518"
Subject: Re: [PATCH v2 0/3] perf/core: expose thread context switch out event
 type to user space
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
 <20180323180534.GD4043@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c727a309-6fe5-22ac-0072-30724127166b@linux.intel.com>
Date: Fri, 23 Mar 2018 23:38:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323180534.GD4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.2018 21:05, Peter Zijlstra wrote:
> On Thu, Mar 22, 2018 at 07:08:25PM +0300, Alexey Budankov wrote:
>>
>> Implementation of exposing context-switch-out type event as a part 
>> of PERF_RECORD_SWITCH[_CPU_WIDE] record.
>>
>> Introduced types of events assumed to be:
>> a) preempt: when task->state == TASK_RUNNING
>> b) yield: !preempt, encoding is done using new bit 
>>    PERF_RECORD_MISC_SWITCH_OUT_YIELD like this:
> 
> A !preempt context switch isn't nessecarily a yield; please don't use
> that name, it means something quite specific and this isn't it.
> 
> Specifically, on Linux yield() doesn't actually change task->state, so
> when task->state is set !0 it _cannot_ have been yield.
> 
> I would invert the thing and call the preempt one SWITCH_OUT_PREEMPT.
> 

Make sense. This way it names the thing exactly what it is. 
Let me take care of that.

Thanks,
Alexey
