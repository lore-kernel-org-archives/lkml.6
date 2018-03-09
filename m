Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeCITlF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:41:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:58721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbeCITlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:41:04 -0500
Message-ID: <1520624424.27998.76.camel@gmx.de>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Fri, 09 Mar 2018 20:40:24 +0100
In-Reply-To: <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
         <1520613285.12489.36.camel@gmx.de>
         <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
         <1520619426.27998.18.camel@gmx.de>
         <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:S/17sAf/ZYa9O5GbihCJdHb2BSZbCLtAo+xiI4ouBKp2aurPSx/
 ZJOur7LI89k4V84L3IqMcz9Ex7NW+P2bfUUcW5jxcVAMy3e7P1YbGQIX8nagwt21G2M1d4A
 EF0Ei4wTJDkYbjbryU+CbLlT14T7TAH03lXb2X4mbKDX751OcZ6OG3xllFalYoef7nrQFTv
 gYPd/+dlptAhM3DME7UjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ksESJdvrA04=:8ZzgIdfJnGNW2OTvH4cpSI
 netFB/JjlF2tbZ+5daQbHypr8+KJQz4pPfmPMzfAUYgXBmGL75cWEyW0+LBy32kc4Xc+rGpaL
 LXSJ5LjFSeU2a9Unj83wWFAuYsA8t+NiWhq5kTm3vAPRAhaebqmSAPXN8mIoqgPh4QD8CxYXy
 5xd42jXxrGgGQkJ+efeawdbklqf/NTNfktP54F/aEIQuYW9JrsdtEZiEgSTA9MZbS/rcscClv
 dMcltzxHzGGAwTLL2OYQTwrNpC9/gyWYQ8A3cTSb7WqBpPAkid1vFrCb/B+xLLvnxoMhP2S3K
 H5v6LmdUg4g027KYVCffgwH8Q3h3RhiYxoNlZXhc2uQAgGIrDZBfkuyRoUyOiHNvLCecBhwLs
 uHQZRgS6bKdY2gX/FQhydYNgcPc94pW19GtTQkPz5C1tYCzrgBYkRM4NlyquNg6GORoreC0vv
 ATBOsWLJAloz35R8ZMaD4SGpMYzmtV4Hi7IyYILfxbq4BrZnyWMydsF2CR5cbW/K5xjTUR6km
 v4bUrEYr523XIZGyToDPvoMGYO5exaQf2J/NLJUOv8ueuUzIkeE2DYzh8tsP8x9OjRj9JAq8A
 J0erDJmhb0ilR2LDKKB5O2jBno2G9V+ZxzIjXnQAeeSm1/3kNLxigJBOZ/T49FqixTTifamFy
 8Zq3+F+mV9BhltY9Fv1j/IrNt4h/zP6LyQCce8dqvO0FANAnjaHuAV4BcWv5iijwrAzCzsU2I
 ZwUYRCt2PrJyebz0ca6fRnT/6sfZvN+0m4zD6BnHeMg1PlOgshgy20m8rVrZAyWBhrXs14yYy
 lD3ey66QqHyCITwB30Wi4mM+mnTN0h+5luIhxsQ8pfvAzjq6wE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 13:20 -0500, Waiman Long wrote:
> On 03/09/2018 01:17 PM, Mike Galbraith wrote:
> > On Fri, 2018-03-09 at 12:45 -0500, Waiman Long wrote:
> >> On 03/09/2018 11:34 AM, Mike Galbraith wrote:
> >>> On Fri, 2018-03-09 at 10:35 -0500, Waiman Long wrote:
> >>>> Given the fact that thread mode had been merged into 4.14, it is now
> >>>> time to enable cpuset to be used in the default hierarchy (cgroup v2)
> >>>> as it is clearly threaded.
> >>>>
> >>>> The cpuset controller had experienced feature creep since its
> >>>> introduction more than a decade ago. Besides the core cpus and mems
> >>>> control files to limit cpus and memory nodes, there are a bunch of
> >>>> additional features that can be controlled from the userspace. Some of
> >>>> the features are of doubtful usefulness and may not be actively used.
> >>> One rather important features is the ability to dynamically partition a
> >>> box and isolate critical loads.  How does one do that with v2?
> >>>
> >>> In v1, you create two or more exclusive sets, one for generic
> >>> housekeeping, and one or more for critical load(s), RT in my case,
> >>> turning off load balancing in the critical set(s) for obvious reasons.
> >> This patch just serves as a foundation for cpuset support in v2. I am
> >> not excluding the fact that more v1 features will be added in future
> >> patches. We want to start with a clean slate and add on it after careful
> >> consideration. There are some v1 cpuset features that are not used or
> >> rarely used. We certainly want to get rid of them, if possible.
> > If v2 is to ever supersede v1, as is the normal way of things, core
> > functionality really should be on the v2 boat when it sails.  What you
> > left standing on the dock is critical core cpuset functionality.
> >
> > 	-Mike
> 
> From your perspective, what are core functionality that should be
> included in cpuset v2 other than the ability to restrict cpus and memory
> nodes.

Exclusive sets are essential, no?  How else can you manage set wide
properties such as topology (and hopefully soonish nohz).  You clearly
can't have overlapping sets, one having scheduler topology, the other
having none.  Whatever the form, something as core as the capability to
dynamically partition and isolate should IMO be firmly aboard the v2
boat before it sails.

	-Mike
