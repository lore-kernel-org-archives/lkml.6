Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBWP6e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:58:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:55969 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbeBWP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:58:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="19896995"
Subject: Re: [Intel-gfx] [RFC] perf: Allow fine-grained PMU access control
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <20180118184007.1300-1-tvrtko.ursulin@linux.intel.com>
 <20180119164540.GT2228@hirez.programming.kicks-ass.net>
 <1074f5d5-dab4-dd62-6894-38676721491d@linux.intel.com>
Message-ID: <5e7d376d-5204-099c-8313-e5aae8adea91@linux.intel.com>
Date: Fri, 23 Feb 2018 15:58:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1074f5d5-dab4-dd62-6894-38676721491d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 19/01/2018 17:10, Tvrtko Ursulin wrote:
> 
> Hi,
> 
> On 19/01/2018 16:45, Peter Zijlstra wrote:
>> On Thu, Jan 18, 2018 at 06:40:07PM +0000, Tvrtko Ursulin wrote:
>>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>
>>> For situations where sysadmins might want to allow different level of
>>> of access control for different PMUs, we start creating per-PMU
>>> perf_event_paranoid controls in sysfs.
>>
>> You've completely and utterly failed to explain why.
> 
> On an abstract level, if there is a desire to decrease the security knob 
> on one particular PMU provider, it is better to be able to do it just 
> for the one, rather for the whole system.
> 
> On a more concrete level, we have customers who want to look at certain 
> i915 metrics, most probably engine utilization or queue depth, in order 
> to make load-balancing decisions. (The two would be roughly analogous to 
> CPU usage and load.)
> 
> This data needs to be available to their userspaces dynamically and 
> would be used to pick a best GPU engine (mostly analogous to a CPU core) 
> to run a particular packet of work.
> 
> It would be impossible to run their product as root, and while one 
> option could be to write a proxy daemon which would allow unprivileged 
> queries, it is also a significant complication which introduces a time 
> shift problem on the PMU data as well.
> 
> So my thinking was that a per-PMU paranoid control should not be a 
> problematic concept in general. And my gut feeling anyway was that not 
> all PMU providers are the same class data, security wise, which was 
> another reason I thought per-PMU controls would be fine.
> 
> There is one more way of thinking about it, and that is that the access 
> control could even be extended to be per-event, and not just per-PMU. 
> That would allow registered PMUs to let the core know which counters are 
> potentially security sensitive, and which are not.
> 
> I've sent another RFC along those lines some time ago, but afterwards 
> I've changed my mind and thought the approach from this patch should be 
> less controversial since it retains all control fully in the perf core 
> and in the hands of sysadmins.

Any thoughts on this one? Is the approach acceptable?

Regards,

Tvrtko
