Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeCIRpZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:45:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932336AbeCIRpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:45:21 -0500
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
To: Mike Galbraith <efault@gmx.de>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
 <1520613285.12489.36.camel@gmx.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
Date: Fri, 9 Mar 2018 12:45:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1520613285.12489.36.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 11:34 AM, Mike Galbraith wrote:
> On Fri, 2018-03-09 at 10:35 -0500, Waiman Long wrote:
>> Given the fact that thread mode had been merged into 4.14, it is now
>> time to enable cpuset to be used in the default hierarchy (cgroup v2)
>> as it is clearly threaded.
>>
>> The cpuset controller had experienced feature creep since its
>> introduction more than a decade ago. Besides the core cpus and mems
>> control files to limit cpus and memory nodes, there are a bunch of
>> additional features that can be controlled from the userspace. Some of
>> the features are of doubtful usefulness and may not be actively used.
> One rather important features is the ability to dynamically partition a
> box and isolate critical loads.  How does one do that with v2?
>
> In v1, you create two or more exclusive sets, one for generic
> housekeeping, and one or more for critical load(s), RT in my case,
> turning off load balancing in the critical set(s) for obvious reasons.

This patch just serves as a foundation for cpuset support in v2. I am
not excluding the fact that more v1 features will be added in future
patches. We want to start with a clean slate and add on it after careful
consideration. There are some v1 cpuset features that are not used or
rarely used. We certainly want to get rid of them, if possible.

Now for the exclusive cpuset, it is certainly something that can be done
in userspace. If there is a valid use case that requires exclusive
cpuset support in the kernel, we can certainly consider putting it into
v2 as well.

Cheers,
Longman
