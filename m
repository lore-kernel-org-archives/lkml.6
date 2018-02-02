Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeBBRoF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:44:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50932 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeBBRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:42:20 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202172153.GO2269@hirez.programming.kicks-ass.net>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <ed78c502-c1f8-43b3-f3d4-e0256e4085ee@oracle.com>
Date: Fri, 2 Feb 2018 12:39:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202172153.GO2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=993
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020216
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2018 12:21 PM, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 11:53:40AM -0500, Steven Sistare wrote:
>> It might be interesting to add a tunable for the number of random choices to
>> make, and clamp it at the max nr computed from avg_cost in select_idle_cpu.
> 
> This needs a fairly complicated PRNG for it would need to visit each
> possible CPU once before looping. A LFSR does that, but requires 2^n-1
> elements and we have topology masks that don't match that.. The trivial
> example is something with 6 cores.

Or keep it simple and accept the possibility of choosing the same candidate
more than once.

>> Or, choose a random starting point and then search for nr sequential 
>> candidates; possibly limited by a tunable.
> 
> And this is basically what we already do. Except with the task-cpu
> instead of a per-cpu rotor.

Righto.  Disregard this suggestion.

- Steve
