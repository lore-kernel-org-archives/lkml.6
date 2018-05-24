Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033416AbeEXOhS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:37:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:12967 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965673AbeEXOhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:37:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="51864259"
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
To: Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <31205dc8-b756-e12b-0249-2ed06c2db9c9@linux.intel.com>
 <20180509145436.GV12217@hirez.programming.kicks-ass.net>
 <3ecedd91-1c01-6fc5-4648-89eaf5ff0930@linux.intel.com>
 <20180510101406.GA12217@hirez.programming.kicks-ass.net>
 <7051f72e-2570-68c8-1488-33ad1b024031@linux.intel.com>
 <20180523130950.GB12217@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <137eab54-86df-cc7d-4618-bce49dfbc2d2@linux.intel.com>
Date: Thu, 24 May 2018 17:37:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523130950.GB12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23.05.2018 16:09, Peter Zijlstra wrote:
> On Wed, May 23, 2018 at 01:06:58PM +0300, Alexey Budankov wrote:
> 
>> Is the patch ready to be up streamed now? 
> 
> Please post a new one where you modify the comment about the syscalls
> not saving registers and ideally find the commit that made it so.

Sent v3 with adjusted comment.
As far comments become outdated quickly tried to be terse.

> 
> Also; I think Andy would appreciate a comment near the syscall code that
> refers back to this code and states what registers we rely upon being
> there (+BP for this patch).

Not sure if I can find all proper places to put comments there.
However there is PUSH_AND_CLEAR_REGS macro that is employed at system 
call implementation so it is possible to put something like this there:

.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
	/*
	 ...
	 * perf/core subsystem relies on bp register value stored 
	 * at pt_regs->bp; see arch/x86/kernel/perf_regs.c: perf_get_regs_user() 
         * for more details;
         ...
	 */

Thanks,
Alexey
> 
> 
