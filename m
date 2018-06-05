Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeFEPDH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:03:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36481 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeFEPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:03:06 -0400
X-Google-Smtp-Source: ADUXVKJ3IGnT589lPuiRJzJyU+cJQ8ENsYLlsi6dWkhDM9cnHj5OVnQ21HP0MLTrzk6lYF35AH1zMw==
Date: Tue, 5 Jun 2018 17:03:01 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180605150301.GK16081@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <20180604165047.GU12180@hirez.programming.kicks-ass.net>
 <CAKfTPtDtx72OgxvA3vxnRiCW_UG24HSJ3oE_8j5Rx3-vP0gCeA@mail.gmail.com>
 <20180605141809.GV12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605141809.GV12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/18 16:18, Peter Zijlstra wrote:
> On Mon, Jun 04, 2018 at 08:08:58PM +0200, Vincent Guittot wrote:

[...]

> > As you mentioned, scale_rt_capacity give the remaining capacity for
> > cfs and it will behave like cfs util_avg now that it uses PELT. So as
> > long as cfs util_avg <  scale_rt_capacity(we probably need a margin)
> > we keep using dl bandwidth + cfs util_avg + rt util_avg for selecting
> > OPP because we have remaining spare capacity but if  cfs util_avg ==
> > scale_rt_capacity, we make sure to use max OPP.
> 
> Good point, when cfs-util < cfs-cap then there is idle time and the util
> number is 'right', when cfs-util == cfs-cap we're overcommitted and
> should go max.
> 
> Since the util and cap values are aligned that should track nicely.

Yeah. Makes sense to me as well. :)
