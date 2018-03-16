Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeCPRXQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:23:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36990 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeCPRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:23:13 -0400
Subject: Re: [RESEND PATCH v2] sched/fair: Remove check in idle_balance
 against migration_cost
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        steven.sistare@oracle.com, joelaf@google.com, jbacik@fb.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com, efault@gmx.de,
        riel@surriel.com
References: <1521052607-24622-1-git-send-email-rohit.k.jain@oracle.com>
 <20180316143550.GH4064@hirez.programming.kicks-ass.net>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <48b63847-123c-6a28-d558-392b8122cd7e@oracle.com>
Date: Fri, 16 Mar 2018 10:21:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316143550.GH4064@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 03/16/2018 07:35 AM, Peter Zijlstra wrote:
> On Wed, Mar 14, 2018 at 11:36:47AM -0700, Rohit Jain wrote:
>> Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
>>
>> Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
> Surely you only need a single on of those.

Oh wow! I don't know how I missed this :) Thanks!

>> ---
>>   kernel/sched/fair.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 5eb3ffc..569ea83 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8804,8 +8804,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>   	 */
>>   	rq_unpin_lock(this_rq, rf);
>>   
>> -	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>> -	    !this_rq->rd->overload) {
>> +	if (!this_rq->rd->overload) {
>>   		rcu_read_lock();
>>   		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>   		if (sd)
> I don't think that actually works right on the current tree. In
> particular look at commit:
>
>    31e77c93e432 ("sched/fair: Update blocked load when newly idle")

OK. I see from LKML the code has moved.

However, when I clone from 
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/
I cannot see the commit.
