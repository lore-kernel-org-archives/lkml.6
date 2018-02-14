Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031339AbeBNVRM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:17:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030501AbeBNVRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:17:08 -0500
Date: Wed, 14 Feb 2018 15:17:07 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Baron <jbaron@akamai.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] jump_label: Warn on failed jump_label patch
Message-ID: <20180214211707.hivwfwemghgy62mh@treble>
References: <cover.1518626149.git.jpoimboe@redhat.com>
 <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
 <20180214120112.43821b5e@gandalf.local.home>
 <a4ad6f69-8836-779b-f7e7-0e303885c7f5@akamai.com>
 <20180214173407.guhytdurv4pmhzvk@treble>
 <20180214124034.13d7d833@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214124034.13d7d833@gandalf.local.home>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 12:40:34PM -0500, Steven Rostedt wrote:
> On Wed, 14 Feb 2018 11:34:07 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> 
> > And in patch 1 the warning conditions need to be tweaked a bit to
> > exclude the __init case.
> > 
> 
> Hmm, I wonder if we could simply remove the references from the jump
> label table when init is freed.

Interesting idea.  The static key's entries (i.e. tracepoint sites) are
in a static array.  Maybe we could rewrite the affected arrays when init
memory is freed.  I'm not sure whether that would be overkill though.  I
can tinker with it and see how it compares to the current solution.

-- 
Josh
