Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeBEWdb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:33:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:33:22 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com, tim.c.chen@linux.intel.com
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202195943.GR2269@hirez.programming.kicks-ass.net>
 <25d67bd2-cbe7-2c2a-e89a-13a7ca5adc10@oracle.com>
 <20180205124854.GX2269@hirez.programming.kicks-ass.net>
 <20180205170358.GT2295@hirez.programming.kicks-ass.net>
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <24df5e07-8a6b-26d9-6024-d6caa90c18de@oracle.com>
Date: Mon, 5 Feb 2018 14:32:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180205170358.GT2295@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050277
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2018 09:03 AM, Peter Zijlstra wrote:
> On Mon, Feb 05, 2018 at 01:48:54PM +0100, Peter Zijlstra wrote:
>> So while I see the point of tracking these numbers (for SMT>2), I don't
>> think its worth doing outside of the core, and then we still need some
>> powerpc (or any other architecture with abysmal atomics) tested.
> FWIW Power has another 'fun' feature, their cores have asymmetric SMT.
>
> Their cores have a static power level, based on _which_ SMT sibling is
> running, not how many. A single SMT2 runs (much) slower than a single
> SMT0.
>
> So that random selection stuff really doesn't work well for them. Now
> 'sadly' x86 can also have ASYM_PACKING set on its SMT domain, so I'm
> going to have to figure out what to do about all that.
Even the existing code doesn't handle that. The SMT balancing compares 
the remaining SMT capacity so even with asymmetric cores should work OK.

Thanks,
Subhra
