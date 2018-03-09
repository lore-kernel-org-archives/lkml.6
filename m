Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCIRYc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:24:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:47969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932124AbeCIRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:24:22 -0500
Message-ID: <1520616226.12489.44.camel@gmx.de>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Fri, 09 Mar 2018 18:23:46 +0100
In-Reply-To: <1520613285.12489.36.camel@gmx.de>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
         <1520613285.12489.36.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:hdNzgs/u9uMtBXOsi2WUvF/hfSVDKB/Sbl8VfCTZIhhDaKwnFji
 wQbzOWl4SzC7neUBFLSQqJR86d/zW/88bBHeUkC9ee8eNm+dFZIfFafFas6Y0fwpiVEqWcd
 BRGBP+5Iqo90kEqcttzp50XRMAPFDQXcdTcsJVn3I7QADixpLwAq7J7xpcXu6Q+SPpGk2TA
 M3/pEKkATsRphzUg9yhzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1OToDlp+9NE=:+C7SB3cU9hBeftRF3v2J0z
 jVputzmVVeKgK+Rqf+aexO4/gXVjWmKLUkUtzNKWHZQK3EhPw/RwGaRwJr2n34gS8bRi184zv
 7+uoXpHvac2D1eHBm2OHuoCVf+pWYX8xehFVzmQx827IIrO9/lLEU+R3/SEoS7pSu8EoHZvhL
 3JGco8hghlo1MovGVqtGPFyn9rE+0DPxS/wCX9ARIW5jj5QYRVluH5+4CyzA1M4kChvDw/ZBq
 faDWe2LGpjTMTef/pBGpyzCYEqvA7yATZNABCW39tXUaDmZsz1xlOuTjo/T6wQWpTmoHd0AFK
 dvUu1+p01896oldAMxgG/VbjMDsJkC+LLAxNUyhuiWZ8ugnKS76OD5IGypLoB0FbIZ3c17h4N
 dhbNAI5ZirIeojDRRgJCHgzbKP6NYMoGU1Az8pvpfFoyy/0S9NGZmNjjDAC+r7PmvaEk2TOFd
 ucp9qGOQnMdZI1iMMw0oMlyDYsZh1BNCmsx3k1ZAFrITRpUEULgvUQ8kGNAMlGXCArT+Q0OZj
 7tBlw3yr5Rkpb0nL3hDkuq3bYohv0OpjJczV7dsR0S3y3tnWTiJfknCl9t7W7kMx1LptYtjrA
 N4BCVJnqOhT1xfMICwuKvx3tvlUgONfpGWHDSUhFKaOhgvkHiOJWMTsBXRsPUsfXim/XL9olY
 UqMsdO0s0SUPOK6d+R2039gwfVyWojQ01UL25KKMDdk6q2A1hixW8YEru/PWJmDxv4flJXCKL
 yjAJMy4ho/JyR8ZK/9pQWnts7+cLBhBwyvTKPYP4uWnwZEDv0Na+Mslzm7AxEjRLrWhKpV582
 op0J5imue9ClVs2AI/5ywGGsIZZ8S4PY+Xo5umj/wVl6lHelyI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 17:34 +0100, Mike Galbraith wrote:
> On Fri, 2018-03-09 at 10:35 -0500, Waiman Long wrote:
> > Given the fact that thread mode had been merged into 4.14, it is now
> > time to enable cpuset to be used in the default hierarchy (cgroup v2)
> > as it is clearly threaded.
> > 
> > The cpuset controller had experienced feature creep since its
> > introduction more than a decade ago. Besides the core cpus and mems
> > control files to limit cpus and memory nodes, there are a bunch of
> > additional features that can be controlled from the userspace. Some of
> > the features are of doubtful usefulness and may not be actively used.
> 
> One rather important features is the ability to dynamically partition a
> box and isolate critical loads.  How does one do that with v2?

This still very much in use stuff that started below, not to mention
the nohz_full stuff that Frederic Weisbecker is working on integrating
so it can blossom into a proper dynamic set property.

Author: Dinakar Guniguntala <dino@in.ibm.com>  2005-06-25 23:57:33
Committer: Linus Torvalds <torvalds@ppc970.osdl.org>  2005-06-26 01:24:45
Parent: 37e4ab3f0cba13adf3535d373fd98e5ee47b5410 ([PATCH] Changing RT priority without CAP_SYS_NICE)
Child:  85d7b94981e2e919697bc235aad7367b33c3864b ([PATCH] Dynamic sched domains: cpuset changes)
Branches: master, remotes/origin/master and many more (82)
Follows: v2.6.12
Precedes: v2.6.13-rc1

    [PATCH] Dynamic sched domains: sched changes
    
    The following patches add dynamic sched domains functionality that was
    extensively discussed on lkml and lse-tech.  I would like to see this added to
    -mm
    
    o The main advantage with this feature is that it ensures that the scheduler
      load balacing code only balances against the cpus that are in the sched
      domain as defined by an exclusive cpuset and not all of the cpus in the
      system. This removes any overhead due to load balancing code trying to
      pull tasks outside of the cpu exclusive cpuset only to be prevented by
      the tasks' cpus_allowed mask.
    o cpu exclusive cpusets are useful for servers running orthogonal
      workloads such as RT applications requiring low latency and HPC
      applications that are throughput sensitive
    
    o It provides a new API partition_sched_domains in sched.c
      that makes dynamic sched domains possible.
    o cpu_exclusive cpusets sets are now associated with a sched domain.
      Which means that the users can dynamically modify the sched domains
      through the cpuset file system interface
    o ia64 sched domain code has been updated to support this feature as well
    o Currently, this does not support hotplug. (However some of my tests
      indicate hotplug+preempt is currently broken)
    o I have tested it extensively on x86.
    o This should have very minimal impact on performance as none of
      the fast paths are affected
    
    Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
    Acked-by: Paul Jackson <pj@sgi.com>
    Acked-by: Nick Piggin <nickpiggin@yahoo.com.au>
    Acked-by: Matthew Dobson <colpatch@us.ibm.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
