Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755619AbeDWP52 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:57:28 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35558 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756041AbeDWP4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:56:54 -0400
X-Google-Smtp-Source: AIpwx4/Ymp/CLLfivQxT3Wq3VqViegHRUKrZyhf7B8y/v70yYl9DDr58rl3ae1Dqr4c4aCdr8xsGZA==
Date: Mon, 23 Apr 2018 17:56:49 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v7 3/5] cpuset: Add a root-only cpus.isolated v2 control
 file
Message-ID: <20180423155649.GD32341@localhost.localdomain>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
 <1524145624-23655-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524145624-23655-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/18 09:47, Waiman Long wrote:

[...]

> +  cpuset.cpus.isolated
> +	A read-write multiple values file which exists on root cgroup
> +	only.
> +
> +	It lists the CPUs that have been withdrawn from the root cgroup
> +	for load balancing.  These CPUs can still be allocated to child
> +	cpusets with load balancing enabled, if necessary.
> +
> +	If a child cpuset contains only an exclusive set of CPUs that are
> +	a subset of the isolated CPUs and with load balancing enabled,
> +	these CPUs will be load balanced on a separate root domain from
> +	the one in the root cgroup.
> +
> +	Just putting the CPUs into "cpuset.cpus.isolated" will be
> +	enough to disable load balancing on those CPUs as long as they
> +	do not appear in a child cpuset with load balancing enabled.

Tasks that were on those CPUs when they got isolated will stay there
(unless forcibly moved somewhere else). They will also "automatically"
belong to default root domain (or potentially to a new root domain
created for a group using those CPUs). Both things are maybe unavoidable
(as discussed in previous versions some tasks cannot be migrated at
all), but such "side effects" should probably be documented. What do you
think?
