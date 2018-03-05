Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934602AbeCELb3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:31:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:53105 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933589AbeCELb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:31:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="22125194"
Subject: Re: [RFC] perf: a different approach to perf_rotate_context()
To: Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
References: <20180301195321.2608515-1-songliubraving@fb.com>
 <20180303152631.GF25201@hirez.programming.kicks-ass.net>
 <E3827285-28C6-4CFD-9990-1FA922CC792C@fb.com>
 <20180303174808.GJ25201@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9ad03edb-7dc2-6fc8-7978-6257a7746aec@linux.intel.com>
Date: Mon, 5 Mar 2018 14:31:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303174808.GJ25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.2018 20:48, Peter Zijlstra wrote:
> On Sat, Mar 03, 2018 at 04:43:16PM +0000, Song Liu wrote:
>>> In any case, there's a ton of conflict against the patches here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/testing
>>>
>>> And with those the idea was to move to a virtual time based scheduler
>>> (basically schedule those flexible events that have the biggest lag --
>>> that also solves 1).
>>
>> Thanks for these information. I will study this approach. Maybe that is 
>> our path to PMU sharing. 
> 
> So I'm really not convinced on that whole PMU sharing.
> 
>> What's is the status of this work? Would it 
>> land in 4.17? 
> 
> These patches might make 4.17, they got held up because of the whole
> meltdown/spectre crap and I need to get back to them.
> 

That work is long desired and would bring performance boost, specifically on 
server systems in per-process profiling mode, accompanied by good speedup on 
context switches. Undoubtedly meltdown/spectre related activity 
substituted it at some point but that improvements would still bring 
significant value and is still awaited.

BR,
Alexey
