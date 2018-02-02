Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754266AbeBBR3w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:29:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:63138 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753873AbeBBRTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:19:07 -0500
Message-ID: <1517591925.8368.58.camel@gmx.de>
Subject: Re: [RFC PATCH] sched/fair: Optionally restrict SMT scheduling
 ("restrict_smt")
From: Mike Galbraith <efault@gmx.de>
To: Sergio Lopez <slp@sinrega.org>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org
Date: Fri, 02 Feb 2018 18:18:45 +0100
In-Reply-To: <1517584441.10356.21.camel@sinrega.org>
References: <20180201123748.32596-1-slp@sinrega.org>
         <1517495872.23787.20.camel@gmx.de> <1517584441.10356.21.camel@sinrega.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qk34Jo//ilg6nUMq/XPbTXD3GiJUEWupdaQg0YgcRU2fmSrZbtW
 qw9QQt/M47tb9W4Yt9Fp5CpssBCG+Clqe5EMqOjVEPSPo8gnwB3/wBEvQ1vr5YhAgKY9LZQ
 z3jX66vYzl5mauBhpIYi2+9rHG8Dn0icoUsznGJMg5mtGgvPz261O1fYOV50CKsBKFwOsrP
 MeJzXD4XRZKjrDxXBU8hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qM/1mKpF7U8=:CUtAz17HmQbU4oiQkwk+eP
 sb7RknmHuJ+8tPqQ3ktRWvluJ5Oiom2HKVSoISnuaYnz4w7qH236iapkiN6RvUoIu5cIPUx0V
 OAPvQZuotYqz9MnnJLU8E8goDRxikhONakEhaM+WJzBvmNNyK0JXIoP3pRT6UZsCUxAE7Nik+
 r0er2JIAroS2WzdRXeG50oJuxgAcamWdz+AP29npY6YaLAmoy5CfZw0JD8FeZA3oKenFWUGQO
 mQ9S4jzfm/9ITXsTPM2xY6dizm5QJZldS79JElwQB1IliLCUXZsUaFxA0EnWvC/wp51y5wUxV
 1AImZCEeq6vGgIpdK7LwHg5jk9FFgNOIPcM8zJrvyWk7XesYU986XgbhqdqBnpZpGSMqrt8nS
 LJ5jvLwD6P3FgSFVZlZVGHrMoVpn/yOwt1u9mMgymcimLwHKaNy042stns38ZfNCn3n+ERb0I
 NdMab455ttJ/4mDf9jU+iLSWamSNmlakf/O95ZUOy770ua/MfWIi2mQoLkDmZOLJv2YbfCjKq
 BirnVXqmWiRLjH+Hg6PAh+n5+H61fut+BwCcHx5KczfwF4JxHRVccrHsJMZM7nua2mdjZR9ki
 SIt7CojpSwMSb4UvNKFAQ1HGkyYbgQX5e1BDBT03F6yIakg5feDiohtKYAcVsgLBFG54fTFML
 LcVj2RA5giupCwJ7mKlm57RIp4Wc2qBpZMPVTKM5qYG089naQ/265HaJQ5hnf4Zg/hijhqrur
 DroAf5hjdbNXxM8BtMd6Yp7Q6odFj2d7vBui7/V8TKDwVZyvlIWjYszuPsXvSKzb1EbG7Hmh3
 tukjPCzxgomWEbrqyLqRFPip5CvGoKUvV50Bd6YBTkpkVxEAW4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 16:14 +0100, Sergio Lopez wrote:
> On Thu, 2018-02-01 at 15:37 +0100, Mike Galbraith wrote:
> > On Thu, 2018-02-01 at 13:37 +0100, Sergio Lopez wrote:
> > > Compared against "isolcpus", "restrict_smt" presents the following
> > > advantages:
> > >  - Doesn't require prior knowledge of the CPU topology, making it
> > > more friendly to both end users and automation tools.
> > >  - Load balancing is still active for tasks pinned to multiple
> > > secondary SMT threads.
> > 
> > This says that everybody and everything in the box is way smarter
> > than the admin.
> 
> If that's an argument in favor of manual pinning and isolation, I have
> to disagree with you. That's an unnecessary burden put on the shoulders
> of the admin.

Give the admin job to one of those users you mentioned who knows which
threads are "secondary" threads, he/she won't be burdened at all.

	-Mike
