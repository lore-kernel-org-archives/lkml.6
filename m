Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeA3Nft convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:35:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:58991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbeA3Nfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:35:48 -0500
Message-ID: <1517319322.6724.4.camel@gmx.de>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Date: Tue, 30 Jan 2018 14:35:22 +0100
In-Reply-To: <20180130132553.GT2249@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
         <20180130104555.4125-5-mgorman@techsingularity.net>
         <20180130115054.GA2269@hirez.programming.kicks-ass.net>
         <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
         <1517318144.10272.6.camel@gmx.de>
         <20180130132553.GT2249@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:P8isAxjkl1jaUfvaVxA37yCMxaSsbxUIcO1hIhnA0F/gflnsAMz
 08sGTfmz+/5c42mp9jjIPWscmPBwiBnhfFVHQN+p7tjyLyOpiDYrOPVM8VsCf9raICSqB9J
 Lo/3sPn4DXmcdDCmgVWkBBde8kk4WAm3Dis2ZYSu0S7F+U0WdybkLAID095oY5KFJg04nkg
 Mu/iiIeLceFPkj7K8rdzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CP+M8XjyIAs=:wDHTnEx4MzH282HyEvWzu1
 g8lCCYyGwS9KKrzhZzQMUbbETtLoKcfqK1XbPSGS0u1w7KB660kcx1JrkhVuqkyNmWjdyq/qs
 T/V68xpUImZ0WyWLeI3ODB/ov35Xn99iti140KCQLqHOTUZdurDnGbKLuEZWAuOyRo50eWVgl
 kk8GxbKTCMCHTCbpG7gwUSKm54/nplZnZpLiHZVVhhFRiQqpnjjHk41gwjOw21w5hN/xypwbn
 Uw5r9LZVee3HdlbDEoZXUFqmSx+s0d96c51LXLUcyAMb1w/2015O+al4/GGI0xPiYQGWV70XW
 tg2IJXw+c8yUdvUcwDxRpcouy7fQZ4MTFzgbJ9hycnT0AGFxakjfmXI/HJMuTQQGGD3ZCPlKj
 FWCmQ17to7vDK8L8tluhxcMnWIalzIDLi/xKuddXA3YRtRQljHu6unQhnTEcuM92V2zl5hmQj
 fikXblWMfD/CHI7XBuR3pXZUxp6x39nwxx3uiC1YZFvVxMj3XPPfdNs0Kr42jE17/E2eA/nFf
 fGjX42NDM0LGK/ud9kvM1GrA2JIOZl48VtSJd0IU3u5rWOfmpD2upl4pPEyhDQBdKvNYIGb5O
 1VtpEVW7v9gjj9DM80nNTc5/y9j0fbJf6hNXKlTUOEPOFFvDsP760N2HXnl2XRGPc6H5qwyoP
 zK/tn7UFd+eT3xiYbOYoGw78GeoDLWJO9y4QpMaEZ8d+TSCUweOGvaX+KhmNpKqVk+T3tJTBl
 xibzFQo8CyzodrqNMV+i9MDGkJRBfGUgkg6jQYta+6uxmH+xCNWJ04d9wYWg61cDEsrqXv2q7
 Q8ozT4x1mgSSCLBvof83QFV5+0XHHimWIDzEFY6lc+Km977D18=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-01-30 at 14:25 +0100, Peter Zijlstra wrote:
> On Tue, Jan 30, 2018 at 02:15:44PM +0100, Mike Galbraith wrote:
> > On Tue, 2018-01-30 at 12:57 +0000, Mel Gorman wrote:
> > > On Tue, Jan 30, 2018 at 12:50:54PM +0100, Peter Zijlstra wrote:
> > > 
> > > > Mel, what hardware are you testing this on?
> > > 
> > > The primary one was a single socket skylake machine with 8 threads (HT
> > > enabled).
> > 
> > I took it for a spin in a 2 x Gold 6152 box.
> 
> Can you translate that marketing speak for a simpleton like me? That's
> what we should've called SKL-EP, right?

Um um.. danged if I know.  It's SKL, w. 22 cores each + SMT.

	-Mike
