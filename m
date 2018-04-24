Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751179AbeDXWlZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:41:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35366 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDXWlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:41:24 -0400
Subject: Re: [PATCH 3/3] sched: limit cpu search and rotate search window for
 scalability
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-4-subhra.mazumdar@oracle.com>
 <20180424124801.GS4082@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <212e5820-a9fe-70fb-90b7-d0503342c742@oracle.com>
Date: Tue, 24 Apr 2018 15:43:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424124801.GS4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=680
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 05:48 AM, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 05:41:16PM -0700, subhra mazumdar wrote:
>> +	if (per_cpu(next_cpu, target) != -1)
>> +		target_tmp = per_cpu(next_cpu, target);
>> +	else
>> +		target_tmp = target;
>> +
> This one; what's the point here?
Want to start search from target first time and from the next_cpu next time
onwards. If this doesn't many any difference in performance I can change
it. Will require re-running all the tests.
