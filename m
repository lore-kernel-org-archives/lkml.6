Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967713AbeBPMwT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:52:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967661AbeBPMwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:52:18 -0500
Date: Fri, 16 Feb 2018 06:52:17 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/3] percpu: Remove inert tracepoint in __init code
Message-ID: <20180216125217.zhhn3j2ar55wchh2@treble>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <42d6bf23a6d151b5d13778be969c7a063d60665a.1518626149.git.jpoimboe@redhat.com>
 <20180215152246.GT695913@devbig577.frc2.facebook.com>
 <20180215153341.5zlc2opvx2vteoqe@treble>
 <20180216090233.lpuqu4z4co6zy5rb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216090233.lpuqu4z4co6zy5rb@gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:02:33AM +0100, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Thu, Feb 15, 2018 at 07:22:46AM -0800, Tejun Heo wrote:
> > > On Wed, Feb 14, 2018 at 10:40:43AM -0600, Josh Poimboeuf wrote:
> > > > The jump_label code doesn't patch init code, so this tracepoint can
> > > > never be enabled.  Remove it.
> > > > 
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > 
> > > Applied to percpu/for-4.17.
> > 
> > Actually, I think this patch should be dropped.  As Jason pointed out,
> > tracepoints *can* be enabled at boot time for __init code, so it's
> > possible for this tracepoint to be used.
> 
> Would it still be useful to have the warning for failed patching?

Yes, I'm working on a v2.

-- 
Josh
