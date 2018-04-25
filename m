Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755698AbeDYQt4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:49:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42032 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbeDYQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:49:48 -0400
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
 <20180424123523.GF4064@hirez.programming.kicks-ass.net>
 <CAEi0qN=qnej22F31jM2CMajee2h+ie0+AptFscwa5L8Arp8q3g@mail.gmail.com>
 <CAEi0qNmkkMEvbT+dJJqMwvRkQAw9xqKX65GKDZqtTAXUUxfs7Q@mail.gmail.com>
 <ea7b6d61-4af2-db82-16b8-ee6f25ccc69c@oracle.com>
 <20180425025111.zn6fwkr4o4d3y52c@vireshk-i7>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <e20035ba-8d1f-bee9-f817-d9f514ee0326@oracle.com>
Date: Wed, 25 Apr 2018 09:48:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425025111.zn6fwkr4o4d3y52c@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=737
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 07:51 PM, Viresh Kumar wrote:
> On 24-04-18, 15:34, Rohit Jain wrote:
>> Including the "unlikely" suggestion and the original patch, as expected
>> with a quick hackbench test on a 44 core 2 socket x86 machine causes no
>> change in performance.
> Want me to include your Tested-by in next version ?
>

Please feel free to include it.

I was not sure if this is too small a test to say tested by.
