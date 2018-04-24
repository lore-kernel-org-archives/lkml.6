Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeDXWqV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:46:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDXWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:46:18 -0400
Subject: Re: [PATCH 3/3] sched: limit cpu search and rotate search window for
 scalability
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-4-subhra.mazumdar@oracle.com>
 <20180424124855.GT4082@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <bdea99d5-a0cd-1f60-e58a-0cc8e4dd6318@oracle.com>
Date: Tue, 24 Apr 2018 15:48:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424124855.GT4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 05:48 AM, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 05:41:16PM -0700, subhra mazumdar wrote:
>> Lower the lower limit of idle cpu search in select_idle_cpu() and also put
>> an upper limit. This helps in scalability of the search by restricting the
>> search window. Also rotating the search window with help of next_cpu
>> ensures any idle cpu is eventually found in case of high load.
> So this patch does 2 (possibly 3) things, that's not good.
During testing I did try with first only restricting the search window.
That alone wasn't enough to give the full benefit, rotating search window
was essential to get best results. I will break this up in next version.
