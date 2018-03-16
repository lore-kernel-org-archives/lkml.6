Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeCPKxO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:53:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:56884 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752969AbeCPKxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:53:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="25784041"
Subject: Re: [PATCH] perf: Fix sibling iteration
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, Dmitry.Prohorov@intel.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        jolsa@redhat.com, torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.weaver@maine.edu, kan.liang@intel.com, eranian@google.com,
        davidcc@google.com, valery.cherepennikov@intel.com,
        linux-tip-commits@vger.kernel.org
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
 <20180315170129.GX4043@hirez.programming.kicks-ass.net>
 <0be54adb-a7be-cd2f-dfcb-4166dfe432ea@linux.intel.com>
 <20180316103129.GC4064@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <50dd4160-63ea-2ec6-ae00-241632fb4998@linux.intel.com>
Date: Fri, 16 Mar 2018 13:53:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316103129.GC4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.2018 13:31, Peter Zijlstra wrote:
> On Fri, Mar 16, 2018 at 12:59:34PM +0300, Alexey Budankov wrote:
>> Hi,
>> On 15.03.2018 20:01, Peter Zijlstra wrote:
>>> Subject: perf: Fix sibling iteration
>>> From: Peter Zijlstra <peterz@infradead.org>
>>> Date: Thu Mar 15 17:36:56 CET 2018
>>>
>>> Mark noticed that the change to sibling_list changed some iteration
>>> semantics; because previously we used group_list as list entry,
>>> sibling events would always have an empty sibling_list.
>>>
>>> But because we now use sibling_list for both list head and list entry,
>>> siblings will report as having siblings.
>>>
>>> Fix this with a custom for_each_sibling_event() iterator.
>>>
>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>>> Reported-by: Mark Rutland <mark.rutland@arm.com>
>>> Fixes: 8343aae66167 ("perf/core: Remove perf_event::group_entry")
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>
>> Applied to tip repo and run testing on Fedora 27/x86_64 (client skylake 8 cores):
> 
> There is at least one more known issue with that patch, but neither Mark
> nor me could reproduce so far, so we don't know if we're right about the
> cause.

Please share more information regarding the issue. I am ready to help.

Thanks,
Alexey
