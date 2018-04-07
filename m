Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeDGGSP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 02:18:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:34547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbeDGGSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 02:18:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,417,1517904000";
   d="scan'208";a="30213327"
Subject: Re: [PATCH v1]: perf/x86: store user space frame-pointer value on a
 sample
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <086d45fb-a099-4ae9-2854-943447e86010@linux.intel.com>
 <20180406153144.GA9010@tassilo.jf.intel.com>
 <df5f38d8-9b35-0309-527a-c7b7b35c635b@linux.intel.com>
 <20180406195310.GB9010@tassilo.jf.intel.com>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ddb220da-eb32-a9bb-f742-8fe5d5588974@linux.intel.com>
Date: Sat, 7 Apr 2018 09:18:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180406195310.GB9010@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.2018 22:53, Andi Kleen wrote:
> On Fri, Apr 06, 2018 at 10:06:26PM +0300, Alexey Budankov wrote:
>> On 06.04.2018 18:31, Andi Kleen wrote:
>>>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>>>> index e47b2dbbdef3..9284048cf5b0 100644
>>>> --- a/arch/x86/kernel/perf_regs.c
>>>> +++ b/arch/x86/kernel/perf_regs.c
>>>> @@ -157,6 +157,15 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>>>>  	 */
>>>>  	regs_user_copy->bx = -1;
>>>>  	regs_user_copy->bp = -1;
>>>> +	if (user_64bit_mode(user_regs)) {
>>>
>>> Why is it 64bit only? Should work on 32bit too.
>>
>> bp register is a part of i386 syscall ABI 
>> (http://man7.org/linux/man-pages/man2/syscall.2.html) 
>> so not sure if it will make any sense for 32bit processes. 
> 
> Both 32bit and 64bit use the same frame pointer, if they
> use frame pointer.

Well let me check the same scenario for 32bit binary.
If the issue exists for it too and is fixed by the exposing bp
then it is obviously worth this improvement.

-Alexey

> 
> -Andi
> 
