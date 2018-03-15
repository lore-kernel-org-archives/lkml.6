Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCOCtq convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:49:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:53899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbeCOCto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:49:44 -0400
Message-ID: <1521082141.7100.1.camel@gmx.de>
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
Date: Thu, 15 Mar 2018 03:49:01 +0100
In-Reply-To: <20180314195711.GD2943022@devbig577.frc2.facebook.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
         <1520613285.12489.36.camel@gmx.de>
         <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
         <1520619426.27998.18.camel@gmx.de>
         <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
         <1520624424.27998.76.camel@gmx.de>
         <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
         <20180309221736.GB5926@hirez.programming.kicks-ass.net>
         <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
         <1520653648.12749.20.camel@gmx.de>
         <20180314195711.GD2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:bu1bdtZjul1T9Z4MDP2qxpGK4DuNLi2fYd62YXG0NdoLzQhA2En
 0gKNPokIrCS4n7StIphsU5x1yyrWso78xvkuadaUiuO14gDWm+rQBKdGAPjYZmbfTTCcKPs
 WcRx1hfJlnPF4z0e2oau3tWRuB29XiCISPtOw100OzC2dsOdbjWjGFP4NKtzBm/JHtsUQvs
 Td0/sS9r74aIJV/fHC5+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pzUq069DAk4=:hk34WS06i8XgUwgnZXo4UC
 1CmzzynJcqtFLSPnmA/nczbbi4HS1vUNqSrXgM1FlrL2fFgMXW24Xgz4RcQkLRxrs5G4NWI9F
 PVVicxrCi5e9xbcfyl63n6hPTzuf0JjD0H0co4b6fe4Ew4+6z6Ss4u/bsonrksVfLaNwa8CMw
 X6EtxVffiPuZDlKEW8h8ofCIvGtDJ3tbPeZUtYq2Gu79n/nP/vep0Xm+hX9cmEz8XxdpAbhyT
 liRR24ct/+ONPxbgWc7TlTmXBoNOJW8WIfIttUZ4Kw2GX980RuIaEVopd0me7AZdKnHMtJjCl
 ulvv1of9viyhP1cSAlRiRXdjRJXQ7r5zgAnEpj6LtvHDqkHkH8V8Q61EzJuOFzo2ZACPNYujr
 NlBNskKfrC/0slJrE3wiEsvuTSBkGp7nzkxooLj0daegVXD7OWXrcwrvooCNowtZY3imX+WOH
 TqVnDycRvWfQ3+KkJkqGC2zD982k7znJtDoANJg3N4WuII3iHBPdM/PqEOf1Ldspj/HfMrg0+
 NsYcCBqZfxMW7mAggjnBZRl0JiDo1usMIeXy9SS4/L68+VqbYyJYN/3cNJyHHB+ivoTMBKy2p
 joxOPNYhBuXt8HdVvm7xctW8mz5IUCvO03OHoZ1tVx5QJB3nF0jS8sIL2piFxCr6Ij36XCkco
 UbbZ2VnZCAGZ51Xlg2LLL/+BIwgxIdAc2eebrGiC7TCtZ2MntCKqg7yKayTZUJCgS1py9jY9U
 a427gcXMnE1/hm0r85PatGF2Bup1OC0Tbnb3KDX9fjM4GupTMuHYmXIlb3GBCMp/khc1DRrNx
 sDqlr5mpOc1jDwER9jtWokXISLGICZhyf7mvmDeX2HUHE1UNvY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-14 at 12:57 -0700, Tejun Heo wrote:
> Hello,
> 
> On Sat, Mar 10, 2018 at 04:47:28AM +0100, Mike Galbraith wrote:
> > Some form of cpu_exclusive (preferably exactly that, but something else
> > could replace it) is needed to define sets that must not overlap any
> > other set at creation time or any time thereafter.  A set with property
> > 'exclusive' is the enabler for fundamentally exclusive (but dynamic!)
> > set properties such as 'isolated' (etc etc).
> 
> I'm not sure cpu_exclusive makes sense.  A controller knob can either
> belong to the parent or the cgroup itself and cpu_exclusive doesn't
> make sense in either case.
> 
> 1. cpu_exclusive is owned by the parent as other usual resource
>    control knobs.  IOW, it's not delegatable.
> 
>    This is weird because it's asking the kernel to protect against its
>    own misconfiguration and there's nothing preventing cpu_exclusive
>    itself being cleared by the same entitya.
> 
> 2. cpu_exclusive is owned by the cgroup itself like memory.oom_group.
>    IOW, it's delegatable.
> 
>    This allows a cgroup to affect what its siblings can or cannot do,
>    which is broken.  Semantically, it doesn't make much sense either.
> 
> I don't think it's a good idea to add a kernel mechanism to prevent
> misconfiguration from a single entity.

Under the hood v2 details are entirely up to you.  My input ends at
please don't leave dynamic partitioning standing at the dock when v2
sails.

	-Mike
