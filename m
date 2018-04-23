Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755515AbeDWN6J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:58:09 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:42895 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755113AbeDWN6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:58:01 -0400
X-Google-Smtp-Source: AB8JxZoEobyYsaPxVLFJn5xfXzsKBtfLztz4HptkAE9hrBIBbFGcz9gSy32hoxv3dOClkHz3MkfaVw==
Date: Mon, 23 Apr 2018 15:57:56 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v7 0/5] cpuset: Enable cpuset controller in default
 hierarchy
Message-ID: <20180423135756.GC32341@localhost.localdomain>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
 <20180423130715.GA32341@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423130715.GA32341@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/18 15:07, Juri Lelli wrote:
> Hi Waiman,
> 
> On 19/04/18 09:46, Waiman Long wrote:
> > v7:
> >  - Add a root-only cpuset.cpus.isolated control file for CPU isolation.
> >  - Enforce that load_balancing can only be turned off on cpusets with
> >    CPUs from the isolated list.
> >  - Update sched domain generation to allow cpusets with CPUs only
> >    from the isolated CPU list to be in separate root domains.
> 

Guess I'll be adding comments as soon as I stumble on something unclear
(to me :), hope that's OK (shout if I should do it differently).

The below looked unexpected to me:

root@debian-kvm:/sys/fs/cgroup# cat g1/cpuset.cpus
2-3
root@debian-kvm:/sys/fs/cgroup# cat g1/cpuset.mems

root@debian-kvm:~# echo $$ > /sys/fs/cgroup/g1/cgroup.threads
root@debian-kvm:/sys/fs/cgroup# cat g1/cgroup.threads
2312

So I can add tasks to groups with no mems? Or is it this only true in my
case with a single mem node? Or maybe it's inherited from root group
(slightly confusing IMHO if that's the case).
