Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeBHScy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:32:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752632AbeBHScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:32:52 -0500
Date: Thu, 8 Feb 2018 12:32:50 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] objtool: Fix switch-table detection
Message-ID: <20180208183250.mtzhxani7u6hr2yy@treble>
References: <20180208130232.GF25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180208130232.GF25235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:02:32PM +0100, Peter Zijlstra wrote:
> 
> Linus reported that GCC-7.3 generated a switch-table construct that
> confused objtool. It turns out that, in particular due to KASAN, it is
> possible to have unrelated .rodata usage in between the .rodata setup
> for the switch-table and the following indirect jump.
> 
> The simple linear reverse search from the indirect jump would hit upon
> the KASAN .rodata usage first and fail to find a switch_table,
> resulting in a spurious 'sibling call with modified stack frame'
> warning.
> 
> Fix this by creating a 'jump-stack' which we can 'unwind' during
> reversal, thereby skipping over much of the in-between code.
> 
> This is not fool proof by any means, but is sufficient to make the
> known cases work. Future work would be to construct more comprehensive
> flow analysis code.
> 
> Also, since Josh keeps asking, add myself to MAINTAINERS.
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks again for helping out with objtool maintainership!

No complaints from the 0-day bot, so:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
