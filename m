Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBWLPJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:15:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeBWLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:15:08 -0500
Date: Fri, 23 Feb 2018 12:15:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180223111505.GU25181@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
 <20180222151210.jwxjchywk4jfecyf@tardis>
 <20180222153034.GO25181@hirez.programming.kicks-ass.net>
 <20180222155143.GV25235@hirez.programming.kicks-ass.net>
 <20180222163120.zhytq7yezny4e7mj@tardis>
 <20180223050209.qy46njbj7phvuxqy@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223050209.qy46njbj7phvuxqy@tardis>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 01:02:09PM +0800, Boqun Feng wrote:
> > 	entry->have_xr = !(has_nn(entry->dep) || (!is_rr && has_rn(entry->dep)));
> > 	              := !has_nn(entry->dep) && (is_rr || !has_rn(entry->dep))
> > 
> 
> so it seems that we have to introduce is_{nn,rn,nx}(), I'm not sure
> introducing three one-off helpers is a good direction to go. One benefit
> of using pick_dep() is that we can keep the whole logic in one function.
> Thoughts?

Urgh, I see...

Damn this is confusing, I'm sure there's something simple we're missing.
Let me go stare at the earlier patches again.
