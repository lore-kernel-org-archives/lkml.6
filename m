Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeEOETV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:19:21 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:37805 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbeEOETU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:19:20 -0400
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.220.135
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH] rcu: Report a quiescent state of TASKS_RCU on a tick from
 user
To: paulmck@linux.vnet.ibm.com
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
References: <1526344426-31836-1-git-send-email-byungchul.park@lge.com>
 <20180515041111.GC26088@linux.vnet.ibm.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <28cb032c-1c44-41b2-4703-e6f942d073de@lge.com>
Date: Tue, 15 May 2018 13:19:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515041111.GC26088@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-15 13:11, Paul E. McKenney wrote:
> On Tue, May 15, 2018 at 09:33:46AM +0900, Byungchul Park wrote:
>> Hello Paul,
>>
>> You removed the reporing while simplifying the commit 508880df6 :)
>> Fold this patch onto the commit or add, whatever you want.
> 
> First, thank you for checking!
> 
> But second, the removal was intentional.  Tiny RCU only exists in
> PREEMPT=n kernels, and in such kernels there can be no RCU-tasks.
> This is the reason for this line in the new commit log:

I see. Thank you.

> [ paulmck: Simplify rcutiny portion given no RCU-tasks for !PREEMPT. ]
> 
> 							Thanx, Paul
> 
>> Thanks,
>> Byungchul
>>
>> ----->8-----
>> >From 18a2d8da3baf79d0edd5ccf94abe6f989da5b1c1 Mon Sep 17 00:00:00 2001
>> From: Byungchul Park <byungchul.park@lge.com>
>> Date: Tue, 15 May 2018 09:21:43 +0900
>> Subject: [PATCH] rcu: Report a quiescent state of TASKS_RCU on a tick from
>>   user
>>
>> The reporting was removed while simplifying the commit 508880df6 (rcu:
>> Improve rcu_note_voluntary_context_switch() reporting). Add it back.
>>
>> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
>> ---
>>   kernel/rcu/tiny.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
>> index befc932..3345596 100644
>> --- a/kernel/rcu/tiny.c
>> +++ b/kernel/rcu/tiny.c
>> @@ -120,8 +120,10 @@ void rcu_bh_qs(void)
>>    */
>>   void rcu_check_callbacks(int user)
>>   {
>> -	if (user)
>> +	if (user) {
>>   		rcu_sched_qs();
>> +		rcu_tasks_qs();
>> +	}
>>   	if (user || !in_softirq())
>>   		rcu_bh_qs();
>>   }
>> -- 
>> 1.9.1
>>
> 
> 

-- 
Thanks,
Byungchul
