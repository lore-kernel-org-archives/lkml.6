Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeCOIbr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:31:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeCOIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:31:45 -0400
Date: Thu, 15 Mar 2018 09:31:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        syzbot <syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@redhat.com>, acme <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        syzkaller-bugs@googlegroups.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: WARNING in tracepoint_probe_register_prio (2)
Message-ID: <20180315083125.GU4064@hirez.programming.kicks-ass.net>
References: <001a114465e241a8720567419a72@google.com>
 <539259484.8875.1520954991870.JavaMail.zimbra@efficios.com>
 <20180314173746.3a6ab6eb@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314173746.3a6ab6eb@vmware.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:37:46PM -0400, Steven Rostedt wrote:
> On Tue, 13 Mar 2018 11:29:51 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > Here is a WARN_ON() splat in tracepoint.c, which I suspect is caused
> > by perf trying to register the same probe twice to the tracepoint API.
> > We got another splat on unregister too, which I will forward in a
> > separate email.
> > 
> > Thoughts ?
> 
> Yes, it looks like it's perf not accounting for registered events
> properly.
> 
> Peter?

I've not yet managed to reproduce, but if you look at the provided
repro.c file, you'll see it opens two _different_ events.
