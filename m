Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCLOIO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:08:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:6517 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932203AbeCLOIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:08:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="23927061"
Subject: Re: [tip:perf/core] perf/x86/intel: Disable userspace RDPMC usage for
 large PEBS
To: Vince Weaver <vincent.weaver@maine.edu>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, eranian@google.com, acme@redhat.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com, linux-tip-commits@vger.kernel.org
References: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
 <tip-1af22eba248efe2de25658041a80a3d40fb3e92e@git.kernel.org>
 <alpine.DEB.2.21.1803090929380.4834@macbook-air>
 <20180309174218.GB4064@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1803091407080.4834@macbook-air>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c346074e-111f-da65-68c9-b24253a1f5fa@linux.intel.com>
Date: Mon, 12 Mar 2018 10:08:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803091407080.4834@macbook-air>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2018 2:10 PM, Vince Weaver wrote:
> On Fri, 9 Mar 2018, Peter Zijlstra wrote:
> 
>> On Fri, Mar 09, 2018 at 09:31:11AM -0500, Vince Weaver wrote:
>>> On Fri, 9 Mar 2018, tip-bot for Kan Liang wrote:
>>>
>>>> Commit-ID:  1af22eba248efe2de25658041a80a3d40fb3e92e
>>>> Gitweb:     https://git.kernel.org/tip/1af22eba248efe2de25658041a80a3d40fb3e92e
>>>> Author:     Kan Liang <kan.liang@linux.intel.com>
>>>> AuthorDate: Mon, 12 Feb 2018 14:20:35 -0800
>>>> Committer:  Ingo Molnar <mingo@kernel.org>
>>>> CommitDate: Fri, 9 Mar 2018 08:22:23 +0100
>>>>
>>>> perf/x86/intel: Disable userspace RDPMC usage for large PEBS
>>>>
>>>
>>>
>>> So this whole commit log is about disabling RDPMC usage for "large PEBS"
>>> but the actual change disables RDPMC if "PERF_X86_EVENT_FREERUNNING"
>>>
>>> Either the commit log is really misleading, or else a poor name was chosen
>>> for this feature.
>>
>> Its the same thing, and yes that might want renaming I suppose.
> 
> I apologize for noticing these things so late in the game, but I haven't
> had time to keep up with a full lkml feed recently so I only see these
> things once I'm CC'd on them.
> 
> So to summarize this: rdpmc is only disabled on a per-event basis, and
> only if that event is doing multi-pebs sampling?
>

If the event can do multi-pebs sampling, the rdpmc will be disabled. 
Other events which cannot do multi-pebs will not be impacted.

To enable multi-pebs sampling for event, it requires a fixed period.
It doesn't support callgraph. For older platform (before SKL), it 
doesn't support time stamp.

Thanks,
Kan

> If that's true, then I don't think I have an issue with this.
> 
> We finally got rdpmc support in a released PAPI, and it is a massive
> improvement when self-monitoring (even moreso if KPTI is enabled) so I was
> just trying to make sure this wouldn't suddenly disable rdpmc out from
> under us.
> 
> Vince
> 
