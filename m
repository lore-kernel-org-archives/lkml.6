Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971536AbeCSUt6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:49:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:48169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968556AbeCSUtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:49:52 -0400
Message-ID: <1521492550.16869.1.camel@gmx.de>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Mon, 19 Mar 2018 21:49:10 +0100
In-Reply-To: <20180319153413.GO2943022@devbig577.frc2.facebook.com>
References: <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
         <1520619426.27998.18.camel@gmx.de>
         <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
         <1520624424.27998.76.camel@gmx.de>
         <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
         <20180309221736.GB5926@hirez.programming.kicks-ass.net>
         <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
         <1520653648.12749.20.camel@gmx.de>
         <20180314195711.GD2943022@devbig577.frc2.facebook.com>
         <1521082141.7100.1.camel@gmx.de>
         <20180319153413.GO2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yDkKTQ08n5X5d6zlFU9Nrsc4Ue1WQlte78XR7M1azl/fiuVJXbY
 KxL2H4I6riUuM+fiJExAfyTKun7gqHj2RGgylh9khRMHtpEr6rjf7q/U1oPdt2LMz0qOoFj
 liYNFw1iGl+X8AP2tDUxZ/gJHdHEas1mOIZ+hjxGkfY5fyR+4pgL/ZTqSTJHE8sxUq9KH9h
 5PrAZgaL4GnjnNWUQZHwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tV+d0y6sZD0=:Xgby/XFG4CWVrwQnc2MY31
 0ivSnSalP1rzbpc3ZYiTH7Kk1QCURYwQ3VMgNlser4BKDp3/UprZ49H+zdZilofVfUNPyXkJb
 4nkd29wip1FF+Rlx9HXdQmia39vQTTNxSTzhXIXbpsE/eGRcjI3pJ+t2LHNW1nbpOM2UA7YtL
 aC6yVfqe1s3vyXBGp2hq3Lg84t4mkHjUy+ks1SX2OmY/Eu+pUi88dPfPo4XvgogCYx0I1w6ED
 xtavVUjloTz5RcmWM5eHHeP5mTkyDbCkp3t8NkX/eRlufq5WxJ25Y2CsBhhUcoXol1ZqFdKaI
 PTQoRvO8PypuV/+f/pL33a2h4+MojZpKLUgoY/ikd3R26xybZ/mjGvetZ03DIWiKx0HGYFW/9
 TCEmEcjnK44zi1zieW/5yAgptyi4kHDzvN2FmPOaOL5MLp37JaRWcTtn4GX4pdgko46+UCGxY
 pkFy4dbJB51kAbzspZKjGKDJ2QiN7BiPfkXFCkxtzqyA0n9eZP3UkiwzwqNDmWa1TSS23U+42
 OZ654tK910EtSv6EDwtJNMLPwzLv95Epi49JbcfXICM4kc9jyEsSzELzfq6TzWMDMDUDhg84k
 Edfu81kAM96Pc/xKpJBFGxaP7RajO8PhkjeogRVInm7wjWpU7kuQqLOTC5BMbLGzbhBVf0lIA
 Ni3WhKwCPIDC/enPHAgxGLAzx3WAcBsACH+GJdTc3ADdd9q0B1LyQIJt+njL0QXm502vUtbG9
 SrIV9/nNgtLvN9iso0UTLVcRZEp02x5vpJGLSyQqcVsZhI4IuK+9OsaubGLCC+IHOiP68YxyU
 s6tdOBV/FwY5YOgkKIsMlZTqGndDhovG75cbUPWa3zigADc9U4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 08:34 -0700, Tejun Heo wrote:
> Hello, Mike.
> 
> On Thu, Mar 15, 2018 at 03:49:01AM +0100, Mike Galbraith wrote:
> > Under the hood v2 details are entirely up to you.  My input ends at
> > please don't leave dynamic partitioning standing at the dock when v2
> > sails.
> 
> So, this isn't about implementation details but about what the
> interface achieves - ie, what's the actual function?  The only thing I
> can see is blocking the entity which is configuring the hierarchy from
> making certain configs.  While that might be useful in some specific
> use cases, it seems to miss the bar for becoming its own kernel
> feature.  After all, nothing prevents the same entity from clearing
> the exlusive bit and making the said changes.

Yes, privileged contexts can maliciously or stupidly step all over one
other no matter what you do (finite resource), but oxymoron creation
(CPUs simultaneously balanced and isolated) should be handled.  If one
context can allocate a set overlapping a set another context intends to
or already has detached from scheduler domains, both are screwed.

	-Mike
