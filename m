Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeEaQTt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:19:49 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33808 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932710AbeEaQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:19:45 -0400
X-Google-Smtp-Source: ADUXVKJTMohDSqvMI8SwfRnPqYYitonBefnZ7ZlvIFfMsh/H4l15uZ2/1Okdui90kEykr/FN8mtomQ==
Date: Thu, 31 May 2018 09:19:42 -0700
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Zefan Li <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] cpuset: Enforce that a child's cpus must be a subset of
 the parent
Message-ID: <20180531161942.GW1351649@devbig577.frc2.facebook.com>
References: <1527687991-1431-1-git-send-email-longman@redhat.com>
 <5B0F4F09.9050100@huawei.com>
 <5B0FAE72.1090204@huawei.com>
 <20180531082613.GF12180@hirez.programming.kicks-ass.net>
 <5B0FB58C.9030705@huawei.com>
 <4dc718bc-4bd5-4998-853b-9c6ba67b89a0@redhat.com>
 <20180531155807.GU1351649@devbig577.frc2.facebook.com>
 <20180531161645.GN12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531161645.GN12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 31, 2018 at 06:16:45PM +0200, Peter Zijlstra wrote:
> > So, let's please stay away from it even if that means a bit of
> > overhead in terms of interface.
> 
> Urgh, that again :/

Yeah, well, it's pretty important.

> I'm still not convinced by your arguments though. The root container can
> access all the sub-groups anyway and can grub around in them to take
> away resources if it really wants to.

That's really messy and if you delegated away a subtree, you can't
walk the subtree in a race free way, not easily anyway.

> For cpuset in particular randomly restricting on the ancestor level can
> create an unrecoverable trainwreck inside a container. Affinities are
> not recoverable. Once a runnable task ends up with an empty set, its
> affinities are reset and the smaller (empty) set is lost.

Yeah, for cpuset, it's messier, but it isn't different from hotunplug
scenario, right?  I think the best we can do there is putting ancestor
operation on an equal footing as hotplug ops.

Thanks.

-- 
tejun
