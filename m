Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeC1G55 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:57:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:51617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeC1G5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:57:55 -0400
Message-ID: <1522220235.24311.1.camel@gmx.de>
Subject: Re: [PATCH v6 2/2] cpuset: Add cpuset.sched_load_balance to v2
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Wed, 28 Mar 2018 08:57:15 +0200
In-Reply-To: <e20484c9-e901-9737-d856-783a6eba1604@redhat.com>
References: <1521649309-26690-1-git-send-email-longman@redhat.com>
         <1521649309-26690-3-git-send-email-longman@redhat.com>
         <20180322084120.GE7231@localhost.localdomain>
         <e754e128-0a93-800e-e71b-2c8dc316ba8a@redhat.com>
         <20180323075952.GA4763@localhost.localdomain>
         <a8860a42-31b5-4620-7b23-b7515ee11d7d@redhat.com>
         <20180326124711.GE5942@localhost.localdomain>
         <bf79b45e-7716-65af-03ca-7112dc367371@redhat.com>
         <20180327140259.GN1840639@devbig577.frc2.facebook.com>
         <e20484c9-e901-9737-d856-783a6eba1604@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:NXgdVDtOt+x1WrZji20Xh8UPBc9TjfjC2h+YWRv1FhTcCMDmSDl
 2AP1/83Vop9T65PumDT+dMwHSgbS8bl8bFhQHg37pOM3SXj5sHjnyfRj3og7dEP1pKhfrTQ
 o57D1MhoJUS+M+xAa2R8lkMqhMH6FW1+tFSsGxgEzeIDvBi1LY6WHHovHAPVqaP0wcz0rHt
 NNAV6XTj0moOFicbN35Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YCoy1Hwqpv8=:Q8mHzXLTphMuAnm3Stz/an
 1YxfCy2on/KaNs4kfvGZknROgu8K5lW22XrhhpsSxJZcR+Dj+Kqq/VzJqQLXN9/jz7yvsOtTK
 jFnBBMFFdNb3gaLFNSHKeahOkISpCJOBKOOt/YybWXpElCaVoVpbuquDwQ34lyqDtLDN9l9av
 e75iiTHDXEZLEj6bsrWTqc7l32RowsVMvH7mqKH9mFexjRZhpF73YCXjFtarK3YvegRH77/U+
 52UVh6+00LdaGGLEkvBSp3IypyTyLPHMpeSQ6zXr57IQp0BMXOoDb6d3TyMGoWgAKjtnkzO5C
 WhRD5EhJTNeW4ZCeCCELhlaY9rms4UeOBo7rkqm8crTCQyr9KZ0mwYoXbVDgWGIRsFZ93LOVA
 ZSNKIo2pVdrR4k8HIShWUFE8Lw4kMJXo7Tcjj5FWBE4GpBl87FEWsf32GypkxRciZNw2Afzkq
 TaMm7np+FlGoEoY56YpB3PRBykTiIdfeDtSQt5TzBm2KrxhLn0Fyz6rLdmpvA/nYAL20lqvTg
 RJly3+S1vfyjkoTHSHDc4WdGwkmXQuh5yJM7LjT377AQQI2OLlWosM6T+XXXwFQOEGFYBrj3v
 FTDLMqHpMMQNR3rzaNScnE/hZ2RlhKF3WCs7L9SfQajQaoHjNjzobCbrzUryZy0WOaCzwVHA5
 /7/qNQQSDpJuzyf4+xfh9o63eO9trgDGBmhFuI3aP7QbHpFJNfUGJWj7UzG7i6lLhF+Ki1QBl
 amDOObVOpwGsgk4PXZpY/w+Dzs85Wav8q5m2pjxz6XM27mBnxcF8SKVz6jdK63ELqUY6NXCp3
 +Ka039Y5RPTZAV9nRHUi52gTJP1QxFyhv28cpX9eLg5ZHtRg6U=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-27 at 10:23 -0400, Waiman Long wrote:
> On 03/27/2018 10:02 AM, Tejun Heo wrote:
> > Hello,
> >
> > On Mon, Mar 26, 2018 at 04:28:49PM -0400, Waiman Long wrote:
> >> Maybe we can have a different root level flag, say,
> >> sched_partition_domain that is equivalent to !sched_load_balnace.
> >> However, I am still not sure if we should enforce that no task should be
> >> in the root cgroup when the flag is set.
> >>
> >> Tejun and Peter, what are your thoughts on this?
> > I haven't looked into the other issues too much but we for sure cannot
> > empty the root cgroup.
> >
> > Thanks.
> >
> Now, I have a different idea. How about we add a special root-only knob,
> say, "cpuset.cpus.isolated" that contains the list of CPUs that are
> still owned by root, but not participated in load balancing. All the
> tasks in the root are load-balanced among the remaining CPUs.
> 
> A child can then be created that hold some or all the CPUs in the
> isolated set. It will then have a separate root domain if load balancing
> is on, or an isolated cpuset if load balancing is off.
> 
> Will that idea work?

Hrm.  Sounds very much like the typical v1 setup today..

              root
               /\
          peons  vips

...with v2 root effectively shrinking to become the v1 "peons" set
*rd/sd/sd_llc wise only* when you poke /cpuset.cpus.isolated, but still
actually spanning all CPUs.  True?

If so, a user would also still have to create a real "peons" subset as
in v1 and migrate everything not nailed to the floor into it for
containment, else any task can be placed or place itself anywhere in
the box, or merely wake to find itself sitting on it's previous, but
now vip turf CPU.

	-Mike
