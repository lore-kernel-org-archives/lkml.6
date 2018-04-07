Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeDGQYb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 12:24:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58527 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbeDGQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 12:24:30 -0400
To: dvyukov@google.com, peterz@infradead.org
Cc: mingo@kernel.org, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, msb@chromium.org, tglx@linutronix.de,
        vegard.nossum@oracle.com
Subject: Re: [PATCH v2] locking/hung_task: Show all hung tasks before panic
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <CACT4Y+Yk0hEDj2EcXTJ5BcTHE0m1Sn0e9RfY=6KC4nWhWOHPmw@mail.gmail.com>
        <201804050705.BHE57833.HVFOFtSOMQJFOL@I-love.SAKURA.ne.jp>
        <201804072131.AEF86988.OFOQLJMVFFtOSH@I-love.SAKURA.ne.jp>
        <20180407153937.GR4082@hirez.programming.kicks-ass.net>
        <CACT4Y+Z6_P9mj2TEE3mtCez1je7dbviftM0rPcgsmQ-yFYYmBg@mail.gmail.com>
In-Reply-To: <CACT4Y+Z6_P9mj2TEE3mtCez1je7dbviftM0rPcgsmQ-yFYYmBg@mail.gmail.com>
Message-Id: <201804080124.GHG87587.SVFOOQFLOHMJtF@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 8 Apr 2018 01:24:24 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Sat, Apr 7, 2018 at 5:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sat, Apr 07, 2018 at 09:31:19PM +0900, Tetsuo Handa wrote:
> >> are for replacing debug_show_all_locks() in check_hung_task() for cases like
> >> https://syzkaller.appspot.com/bug?id=26aa22915f5e3b7ca2cfca76a939f12c25d624db
> >> because we are interested in only threads holding locks.
> >>
> >> SysRq-t is too much but SysRq-w is useless for killable/interruptible threads...
> >
> > Or use a script to process the sysrq-t output? I mean, we can add all
> > sorts, but where does it end?

Maybe allow khungtaskd to call call_usermode_helper() to run arbitrary operations
instead of just calling panic()?

> 
> Good question.
> We are talking about few dozen more stacks, right?
> 
> Not all kernel bugs are well reproducible, so it's not always possible
> to go back and hit sysrq-t. And this come up in the context of syzbot,
> which is an automated system. It reported a bunch of hangs and most of
> them are real bugs, but not all of them are easily actionable.
> Can it be a config or a command line argument, which will make syzbot
> capture more useful context for each such hang?
> 

It will be nice if syzbot testing is done with kdump configured, and the
result of automated scripting on vmcore (such as "foreach bt -s -l") is
available.
