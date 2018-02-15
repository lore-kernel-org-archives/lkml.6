Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164947AbeBOPdr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:33:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1164931AbeBOPdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:33:43 -0500
Date: Thu, 15 Feb 2018 09:33:41 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 3/3] percpu: Remove inert tracepoint in __init code
Message-ID: <20180215153341.5zlc2opvx2vteoqe@treble>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <42d6bf23a6d151b5d13778be969c7a063d60665a.1518626149.git.jpoimboe@redhat.com>
 <20180215152246.GT695913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180215152246.GT695913@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 07:22:46AM -0800, Tejun Heo wrote:
> On Wed, Feb 14, 2018 at 10:40:43AM -0600, Josh Poimboeuf wrote:
> > The jump_label code doesn't patch init code, so this tracepoint can
> > never be enabled.  Remove it.
> > 
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Applied to percpu/for-4.17.

Actually, I think this patch should be dropped.  As Jason pointed out,
tracepoints *can* be enabled at boot time for __init code, so it's
possible for this tracepoint to be used.

-- 
Josh
