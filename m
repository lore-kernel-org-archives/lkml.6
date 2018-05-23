Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeEWKHT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:07:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:16728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932264AbeEWKHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:07:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,432,1520924400";
   d="scan'208";a="61010128"
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
 <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
 <20180510101406.GA12217@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <7051f72e-2570-68c8-1488-33ad1b024031@linux.intel.com>
Date: Wed, 23 May 2018 13:06:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510101406.GA12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10.05.2018 13:14, Peter Zijlstra wrote:
> On Thu, May 10, 2018 at 12:42:38PM +0300, Alexey Budankov wrote:
>>> The Changelog needs to state that user_regs->bp is in fact valid and
>>
>> That actually was tested on binaries compiled without and with BP exposed 
>> and in the latter case proved the value of that change.
> 
> Mostly works is not the same as 'always initialized', if there are entry
> paths that do not store that register, then using the value might leak
> values from the kernel stack, which would be bad.
> 
> But like said, I think much of the kernel entry code was sanitized with
> the PTI effort and I suspect things are in fact fine now, but lets wait
> for Andy to confirm.
> 

It looks like Andy confirmed on the questions above.

Is the patch ready to be up streamed now? 

Thanks,
Alexey
