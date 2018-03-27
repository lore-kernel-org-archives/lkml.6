Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeC0KzI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:55:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:55489 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeC0KzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:55:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="45648373"
Subject: Re: [PATCH v1] perf stat: avoid 10ms limit for printing event counts
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8f27e33e-355a-e6f3-30d9-c0fc3ff46c4d@linux.intel.com>
 <20180327090642.GP13724@tassilo.jf.intel.com>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2600c74e-e9a2-c381-303d-d5e82012339f@linux.intel.com>
Date: Tue, 27 Mar 2018 13:55:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327090642.GP13724@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.2018 12:06, Andi Kleen wrote:
>> When running perf stat -I for monitoring e.g. PCIe uncore counters and 
>> at the same time profiling some I/O workload by perf record e.g. for 
>> cpu-cycles and context switches, it is then possible to build and 
>> observe good-enough consolidated CPU/OS/IO(Uncore) performance picture 
>> for that workload.
> 
> At some point I still hope we can make uncore measurements in 
> perf record work. Kan tried at some point to allow multiple
> PMUs in a group, but was not successfull. But perhaps we
> can sample them from a software event instead.
> 
>>
>> The warning on possible runtime overhead is still preserved, however 
>> it is only visible when specifying -v option.
> 
> I would print it unconditionally. Very few people use -v.

If there is no objections I will resend the updated version.

Thanks,
Alexey

> 
> BTW better of course would be to occasionally measure the perf stat 
> cpu time and only print the warning if it's above some percentage
> of a CPU. But that would be much more work.
> 
> Rest looks ok.
> 
> 
> -Andi
> 
