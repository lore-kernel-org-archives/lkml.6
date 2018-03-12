Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCLPWT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:22:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:41111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbeCLPWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:22:16 -0400
Message-ID: <1520868085.9178.1.camel@gmx.de>
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
Date: Mon, 12 Mar 2018 16:21:25 +0100
In-Reply-To: <12ef7f60-5b14-8e09-2478-1453a3071f21@redhat.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
         <1520613285.12489.36.camel@gmx.de>
         <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
         <1520619426.27998.18.camel@gmx.de>
         <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
         <1520624424.27998.76.camel@gmx.de>
         <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
         <20180309221736.GB5926@hirez.programming.kicks-ass.net>
         <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
         <20180310131647.GB4043@hirez.programming.kicks-ass.net>
         <12ef7f60-5b14-8e09-2478-1453a3071f21@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2/HXjyC/mjfDYZ9X/UtoBk3EBgO94APmv9w1nSE8x74G2+iyxD+
 6EuFtneYaaoS5tAWwN9hfVlM+tUFAFMsIH9nXAtu72M6onLr86adPQiUMHJnZt5xPcOshaK
 HplXL9gQWGoA2+SOGfcPlb8m/TfhnIAgnMZ+IniVcdYGf8xYd0li0jVyNfJN1OiaEQ6KwUR
 EGsbtXJC4TYRNMY7b3FGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n1xfcJ1/S9c=:mRL0J1PBiI0p5p1mhA0Np3
 hgAVEg9SeEKk60Gkii6s64Wyr06cX52LP8F3/AB7EfjuHrKKsuCYABYIa1YsehnW5le+BOh9u
 FVuO0qcEIlNKg6ebX0YQ9W7isHX4zpmsQcBzZszlF8VTZU5uLXPuvciGvvygjmEclZJE9SY9e
 PUt08YaCnxCYlAQh3T43dpXpuKc8mVTnifr4nqxLy53HoXqFdb/S+wICoiTf/VenZabrGRFHO
 BN6YgaBQ6PZY9KoAj2EdxS6YYjflefXxGutq7SkW4X0/e8vKlP8qDefc74OoCNtTbAST/1+EW
 yzW7xV/CjdhA6EQiOL3c/4pYvpYr1GtziSKJ7zpymldfCuI+WMNNLp5r9wLaZ5xRd2/WYmIpY
 Gj+kQd4zuGgad08cxC7nOyfwPXp1tcUQPAkojO+bQ2riQP1macaq3+hN7z1LZN0Lnvsfj6g3x
 VdO5/wxKTuCOMonRTzHwYxQJ9/xVvplhRD4HwPKLq76KB3F1wxOHSTn6b4PwMHgWIz89Q8oj+
 OYN6apTNwiqftmUuXWS9gfAg0bu49jPQbAmZQVoe9Sn+gervwtFP84dRkUot2BzMztY+IoEBw
 koaatImN4EQn4DAzW/HsBIOqn3CM9H30Z1oo2x9RV790nNMkr/T6I2Uzl5hhnt+kSYh73PYbu
 an20yBxA37Q7cDhB6dQC7DSv6eiMo6vdGVF+P6N6tuHU5zp7H6VlILXbei+Chh+IqMETR9PEB
 Qgf6bDIQDKbyjy5o/zbKPVoAfiXOQ5PrlmnNrU1+6eOkJKa6/pAH5p0dEI8NIdqahcpFm8Bn0
 /xX+Ju7aWl9GFmpF2sT+CdobBm8wL/pB6kSImT/33JokJhsuWM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 10:20 -0400, Waiman Long wrote:
> On 03/10/2018 08:16 AM, Peter Zijlstra wrote:
> 
> > The equivalent of isolcpus=xxx is a cgroup setup like:
> >
> >         root
> > 	/  \
> >   system    other
> >
> > Where other has the @xxx cpus and system the remainder and
> > root.sched_load_balance = 0.
> 
> I saw in the kernel-parameters.txt file that the isolcpus option was
> deprecated - use cpusets instead. However, there doesn't seem to have
> document on the right way to do it.

I use cset shield (cpuset package) in a script to create a set and
migrate everything that's permitted into the system set.

setup:
cset shield --userset=rtcpus --cpu=4-63 --kthread=on
<poke this/that>

teardown:
cset shield --userset=rtcpus --reset
<un-poke this/that>

Non-sexy, but works for simple stuff.

	-Mike
