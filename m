Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754818AbeEHRDU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:03:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeEHRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:03:18 -0400
Subject: Re: [RFC] sched: Distinguish between idle_cpu calls based on desired
 effect
To: Randy Dunlap <rdunlap@infradead.org>, matt@codeblueprint.co.uk,
        peterz@infradead.org
Cc: mingo@kernel.org, dhaval.giani@oracle.com, subhra.mazumdar@oracle.com,
        steven.sistare@oracle.com, linux-kernel@vger.kernel.org
References: <1525736477-8184-1-git-send-email-rohit.k.jain@oracle.com>
 <366af1f5-9837-8a0c-3550-1a3d9a8e9de9@infradead.org>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <d4a570b1-7e27-bb6a-3e47-a94f68b6c88e@oracle.com>
Date: Tue, 8 May 2018 10:03:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <366af1f5-9837-8a0c-3550-1a3d9a8e9de9@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=883
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,


On 05/07/2018 05:15 PM, Randy Dunlap wrote:
> On 05/07/2018 04:41 PM, Rohit Jain wrote:

<snip>

>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 71bdb86..171e160 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4028,6 +4028,20 @@ int idle_cpu(int cpu)
>>   		return 0;
>>   #endif
>>   
>> +	return 1;
>> +}
>> +
>> +/**
>> + * idle_cpu - is a given CPU idle for enqueuing work.
>      * available_idle_cpu -

Thanks for the catch!

Will fix it in the next version.

Thanks,
Rohit

<snip>
