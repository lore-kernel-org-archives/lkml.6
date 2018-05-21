Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeEUQwE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:52:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:9881 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752876AbeEUQwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:52:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="52619328"
Subject: Re: [PATCH v2]: perf/x86: store user space frame-pointer value on a
 sample
To: Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
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
 <0594eaea-0cab-ea04-c258-5f4770ffeee6@linux.intel.com>
 <71E4F816-7E0F-4984-B53C-06F8566EAB40@amacapital.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <36a2c137-8342-4ff4-ddcb-3ac1fe092810@linux.intel.com>
Date: Mon, 21 May 2018 19:51:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <71E4F816-7E0F-4984-B53C-06F8566EAB40@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,
On 21.05.2018 17:14, Andy Lutomirski wrote:
> 
>> On May 21, 2018, at 5:44 AM, Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
>>
>> Hi Peter,
>>
>>> On 10.05.2018 13:14, Peter Zijlstra wrote:
>>> On Thu, May 10, 2018 at 12:42:38PM +0300, Alexey Budankov wrote:
>>>>> The Changelog needs to state that user_regs->bp is in fact valid and
>>>>
>>>> That actually was tested on binaries compiled without and with BP exposed 
>>>> and in the latter case proved the value of that change.
>>>
>>> Mostly works is not the same as 'always initialized', if there are entry
>>> paths that do not store that register, then using the value might leak
>>> values from the kernel stack, which would be bad.
>>>
>>> But like said, I think much of the kernel entry code was sanitized with
>>> the PTI effort and I suspect things are in fact fine now, but lets wait
>>> for Andy to confirm.
>>
>> It looks like, these days, all registers are saved on system calls, just 
>> like you anticipated.
>>
>> So BP register value might be stored into the Perf trace on a sample. 
>>
>> Andy?
> 
> Hmm, I thought I replied. Yes, they are indeed all saved, but I’m not very excited about committing to doing so forever. But storing BP should be fine.

Thanks for explicit confirmation regarding BP register.
BTW, do you see any mean to prevent possible unattended regression?
I guess it could be some compile time assertion or regression testing.

Thanks,
Alexey

> 
