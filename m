Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeFAGas (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:30:48 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:37754 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750821AbeFAGar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:30:47 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [RESEND PATCH v3 1/2] sched/deadline: Add cpudl_maximum_dl() for
 clean-up
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, raistlin@linux.it,
        linux-kernel@vger.kernel.org, juri.lelli@gmail.com, bristot@redhat.com,
        kernel-team@lge.com
References: <1515392081-32320-1-git-send-email-byungchul.park@lge.com>
 <20180111090716.GV6176@hirez.programming.kicks-ass.net>
 <20180509063322.GA29160@X58A-UD3R>
 <536cd801-03e5-a1de-605b-a6ed0f95b4a9@lge.com>
 <6617f569-6c2f-509c-328e-fad3db73f5df@lge.com>
 <20180601060243.GA184458@joelaf.mtv.corp.google.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <26632e11-a1dd-5cf5-914b-1ba697c8620d@lge.com>
Date: Fri, 1 Jun 2018 15:30:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601060243.GA184458@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-01 15:02, Joel Fernandes wrote:
> On Fri, Jun 01, 2018 at 12:07:48PM +0900, Byungchul Park wrote:
>>
>>
>> On 2018-05-25 14:13, Byungchul Park wrote:
>>>
>>>
>>> On 2018-05-09 15:33, Byungchul Park wrote:
>>>> On Thu, Jan 11, 2018 at 10:07:16AM +0100, Peter Zijlstra wrote:
>>>>>
>>>>>
>>>>> Sorry for the huge delay on this, but I'll have to postpone further.
>>>>> Still busy with meltdown/spectre stuff.
>>>>
>>>> Please consider this. Even though it's not a big bug, anyway leading
>>>> mis-behavior in certain situaions.
>>>
>>> Could you see this patches, it's been too long since the start tho?
>>
>> Please, any opinion.
> 
> Just my opinion: this patch [1] is just a cosmetic change. I would argue that
> there's no readability improvement by wrapping up elements[0].dl. Infact I
> even feel that the elements[0].cpu should directly be accessed since both
> .cpu and .dl for the 0th element are directly accessed only from one place
> (cpudl_find) and only one time, and explicitly accessing index 0 makes it
> more clear that this is the root of the max-heap.
> 
> IOW I don't see any benefit in hiding it behind a wrapper which hides the
> fact that we're accessing the root of the max heap, but I don't terribly hate
> this patch and I'm Ok if maintainers and other reviewers think its worth it.

Hi Joel,

Talking about the *1st patch*, no matter whether denied or not, even
though I think it looks weird to abstract only p->elements[0].cpu with
a function, but not cp->elements[0].dl.

> thanks,
> 
>   - Joel
> 
> [1] https://patchwork.kernel.org/patch/10149099/
> 
> 

-- 
Thanks,
Byungchul
