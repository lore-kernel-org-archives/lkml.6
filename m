Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeCIXGd convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:06:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932195AbeCIXGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:06:32 -0500
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
 <1520613285.12489.36.camel@gmx.de>
 <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
 <1520619426.27998.18.camel@gmx.de>
 <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
 <1520624424.27998.76.camel@gmx.de>
 <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
 <20180309221736.GB5926@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
Date: Fri, 9 Mar 2018 18:06:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180309221736.GB5926@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 05:17 PM, Peter Zijlstra wrote:
> On Fri, Mar 09, 2018 at 03:43:34PM -0500, Waiman Long wrote:
>> The isolcpus= parameter just reduce the cpus available to the rests of
>> the system. The cpuset controller does look at that value and make
>> adjustment accordingly, but it has no dependence on exclusive cpu/mem
>> features of cpuset.
> The isolcpus= boot param is donkey shit and needs to die. cpuset _used_
> to be able to fully replace it, but with the advent of cgroup 'feature'
> this got lost.
>
> And instead of fixing it, you're making it _far_ worse. You completely
> removed all the bits that allow repartitioning the scheduler domains.
>
> Mike is completely right, full NAK on any such approach.

So you are talking about sched_relax_domain_level and
sched_load_balance. I have not removed any bits. I just haven't exposed
them yet. It does seem like these 2 control knobs are useful from the
scheduling perspective. Do we also need cpu_exclusive or just the two
sched control knobs are enough?

Cheers,
Longman
