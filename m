Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeERMTV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:19:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:19:20 -0400
Date: Fri, 18 May 2018 14:19:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, yuyang.du@intel.com, pjt@google.com,
        bsegall@google.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] sched/fair: update scale invariance of PELT
Message-ID: <20180518121913.GR12235@hirez.programming.kicks-ass.net>
References: <1493389435-2525-1-git-send-email-vincent.guittot@linaro.org>
 <20180518093638.GL12198@hirez.programming.kicks-ass.net>
 <20180518101738.GM30654@e110439-lin>
 <20180518120851.GM12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518120851.GM12198@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 02:08:51PM +0200, Peter Zijlstra wrote:
> However, I think we can shrink util_avg unconditionally, which would
> give us exactly the 4 byte hole we need.

There is of course the problem that we track rq util_avg as a straight
sum of entity util_avg, such that if you migrate/wake a bunch of tasks
into the rq the sum can exceed the natural bounds, although it will
settle down back to it.

If we're really worried we could try and detect overflows on the
summing and clip.
