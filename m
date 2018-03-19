Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967222AbeCSQdV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:33:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935330AbeCSQdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:33:18 -0400
Subject: Re: [PATCH v5 2/2] cpuset: Add cpuset.flags control knob to v2
To: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
References: <1521148842-15486-1-git-send-email-longman@redhat.com>
 <1521148842-15486-3-git-send-email-longman@redhat.com>
 <20180319162654.GR2943022@devbig577.frc2.facebook.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8e553b7e-cab6-1b5d-9110-cc5770ae16c4@redhat.com>
Date: Mon, 19 Mar 2018 12:33:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180319162654.GR2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 12:26 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Thu, Mar 15, 2018 at 05:20:42PM -0400, Waiman Long wrote:
>> +	The currently supported flag is:
>> +
>> +	  sched_load_balance
>> +		When it is not set, there will be no load balancing
>> +		among CPUs on this cpuset.  Tasks will stay in the
>> +		CPUs they are running on and will not be moved to
>> +		other CPUs.
>> +
>> +		When it is set, tasks within this cpuset will be
>> +		load-balanced by the kernel scheduler.  Tasks will be
>> +		moved from CPUs with high load to other CPUs within
>> +		the same cpuset with less load periodically.
> Hmm... looks like this is something which can be decided by the cgroup
> itself and should be made delegatable.  Given that different flags
> might need different delegation settings and the precedence of
> memory.oom_group, I think it'd be better to make the flags separate
> bool files - ie. cpuset.sched_load_balance which contains 0/1 and
> marked delegatable.
>
> Thanks.
>
Sure. Will do that.

-Longman
