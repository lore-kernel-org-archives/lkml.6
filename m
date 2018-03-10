Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbeCJDsM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:48:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:52905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751371AbeCJDsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 22:48:09 -0500
Message-ID: <1520653648.12749.20.camel@gmx.de>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Sat, 10 Mar 2018 04:47:28 +0100
In-Reply-To: <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
         <1520613285.12489.36.camel@gmx.de>
         <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
         <1520619426.27998.18.camel@gmx.de>
         <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
         <1520624424.27998.76.camel@gmx.de>
         <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
         <20180309221736.GB5926@hirez.programming.kicks-ass.net>
         <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:GaPPl8AnbKDUGY3S2kJsNrzwCOQXsW81uOLavpYeJZKC+mcD7oy
 JH3qJken3VA7+OeSNhcYdxiifm94S6Ft9n0IYpUcORsMoZSGBW23gIydwZHzxdDUurabeOJ
 61pOIG7Nut9J+TgXz+UHk0Yo09Mirg1w5JRSZ8/8NbhvjNLl/ISr72CQolxfpwEW6f+/jRP
 /kDkb+xy3gtdqf7rgtbsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dvy4FYzrnRU=:pmfHFQhesZ0zZ4LYiVJOmk
 9mUyReGYyd61CuPM7qiRA8uO7FqhgIujJ0vjWN++3+1LOCS71xpIdPr8OHi8US0g8btsQMw+i
 uiz3DKndVIvr8D3NE/SIe5CMRasqY8evGjQcm9XIzVqyjh9EAPGItBzQDJqVVTHFMossfBiLR
 w9J12k5xMMA9GIJh2ilManNAhaoC15oK3TRrF9sa8rlqoCpRP8buM7W+fyQC4gngm4/ayzHYt
 BUeudOyjnoMNkfDIVnUl1bFJPkLw/rK69ChLtxJGDuIlSEcb6kJ11ZsKhgHc9oDt3dcYJauVf
 GqwYknxfSfhe/szVOiK4siz7yu+ag5DJjHveB75P/P5SY1O1WUmEA/fozf/yjwd8KGRb+j3mi
 iS55Pz50KaDJ9j4ki68ERjx0uSsM5TuSnopaF9td2hd+dAZjK8QxvIzw6yhvH1L+sxJ+AT+eo
 sbvbK6Fyp+vPQev69PSQEovC2N021Oo6eIONi5Y90jViVYSaXr1Wre83h3Gp3fGHpf7I9LLSt
 JIJE2QBesmPCnaR++U6FvD3rSanaguuqaozdkBdH9KZBH61j9RJvrOzylqL9xhLY/mvc03Mlg
 VosB83mPXCJkA3ShP1swi5g8LvyXc+E8wcHqBFP2WWjpiRZPMXUKpgw060RQQzgjkdNXkF5EU
 0uTIhyrxBHrx11sFCTmb5TmjBIkxmuq8IL778i2684FCTqPlhUX0t6FYR6g/CqbG3id+sz1lS
 kMPlL9amwvYF4+Xw7/m3GXQaHVIXwLUqbvbXJR2W20zgFi6P800nYJGNe33CcaCh4ksBEzf2X
 IpLvGSK6MBam//L9wdCL0k7Jxqwo/PTrmG5XXumN9ddJLbM/0g=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 18:06 -0500, Waiman Long wrote:
> On 03/09/2018 05:17 PM, Peter Zijlstra wrote:
> > On Fri, Mar 09, 2018 at 03:43:34PM -0500, Waiman Long wrote:
> >> The isolcpus= parameter just reduce the cpus available to the rests of
> >> the system. The cpuset controller does look at that value and make
> >> adjustment accordingly, but it has no dependence on exclusive cpu/mem
> >> features of cpuset.
> > The isolcpus= boot param is donkey shit and needs to die. cpuset _used_
> > to be able to fully replace it, but with the advent of cgroup 'feature'
> > this got lost.
> >
> > And instead of fixing it, you're making it _far_ worse. You completely
> > removed all the bits that allow repartitioning the scheduler domains.
> >
> > Mike is completely right, full NAK on any such approach.
> 
> So you are talking about sched_relax_domain_level and
> sched_load_balance. I have not removed any bits. I just haven't exposed
> them yet. It does seem like these 2 control knobs are useful from the
> scheduling perspective. Do we also need cpu_exclusive or just the two
> sched control knobs are enough?

Some form of cpu_exclusive (preferably exactly that, but something else
could replace it) is needed to define sets that must not overlap any
other set at creation time or any time thereafter.  A set with property
'exclusive' is the enabler for fundamentally exclusive (but dynamic!)
set properties such as 'isolated' (etc etc).

	-Mike
