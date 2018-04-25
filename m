Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756031AbeDYRzp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:55:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDYRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:55:44 -0400
Date: Wed, 25 Apr 2018 19:55:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [PATCH] sched/rt: Rework for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20180425175535.GC4043@hirez.programming.kicks-ass.net>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 08:29:01PM +0300, Kirill Tkhai wrote:
> tg_rt_schedulable() iterates over all child task groups,
> while tg_has_rt_tasks() iterates over all linked tasks.
> In case of systems with big number of tasks, this may
> take a lot of time.

So you're actually using RT cgroups?

Some of us recently considered removing that thing entirely because most
distro's don't actually use it at all -- and it's broken from a RT POV.

That would then clear the slate to try and implement something new.

But if you're actually using this stuff, that would complicate matters.
