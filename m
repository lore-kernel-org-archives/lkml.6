Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeCEWCQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:02:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45250 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbeCEWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:02:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDBF8601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A9DBE64.3060209@codeaurora.org>
Date: Mon, 05 Mar 2018 14:02:12 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: suzuki.poulose@arm.com, Peter Zijlstra <peterz@infradead.org>,
        rananta@codeaurora.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        avilaj@codeaurora.org, Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/core: Add support for PMUs that can be read from
 more than 1 CPU
References: <1520039693-30914-1-git-send-email-skannan@codeaurora.org> <20180305121702.l64rzrckog6d7jop@lakrids.cambridge.arm.com> <20180305122140.wwwu4hvhssouuzcp@lakrids.cambridge.arm.com>
In-Reply-To: <20180305122140.wwwu4hvhssouuzcp@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 04:21 AM, Mark Rutland wrote:
> On Mon, Mar 05, 2018 at 12:17:02PM +0000, Mark Rutland wrote:
>> On Fri, Mar 02, 2018 at 05:14:53PM -0800, Saravana Kannan wrote:
>
>>> @@ -629,6 +629,7 @@ struct perf_event {
>>>
>>>   	int				oncpu;
>>>   	int				cpu;
>>> +	cpumask_t			readable_on_cpus;
>>
>> For most PMUs, this will be emptry, and it's potentially *very* large
>> (e.g. on systems where NR_CPUS is 4096). Please use a poitner to a mask,
>> as I suggested in [1], e.g.
>
>> [1] https://lkml.kernel.org/r/20171128124534.3jvuala525wvn64r@wfg-t540p.sh.intel.com
>
> Whoops, that should've been:
>
> [1] https://lkml.kernel.org/r/20180225143802.denbkubqjg2dc7af@salmiak
>

I didn't notice you mentioned the use of pointers, but I was planning on 
doing that anyway. But then I realize people will complain about 
cacheline bouncing across 4096 CPUs if I use a cpu mask pointer.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
