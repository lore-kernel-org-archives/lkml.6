Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeEKQ1P (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbeEKQ1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:27:14 -0400
Date: Fri, 11 May 2018 12:27:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Message-ID: <20180511122712.2d67992b@gandalf.local.home>
In-Reply-To: <20180511122528.2a398d24@gandalf.local.home>
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
        <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
        <20180511161746.GX26088@linux.vnet.ibm.com>
        <20180511122321.722a12cc@gandalf.local.home>
        <20180511122528.2a398d24@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 12:25:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I would also say that one should never call schedule() directly without
> changing its state to something other than TASK_RUNNING. Hence, calling
> schedule directly is saying you are ready to sleep. But that is not the
> case with cond_resched() which should always be called with the state
> as TASK_RUNNING.

To continue this, with tracing, when a task is scheduled out in the
RUNNING state, it is considered preempted, otherwise it is not.

-- Steve
