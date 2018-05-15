Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeEOQSX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:18:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752102AbeEOQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:18:22 -0400
Date: Tue, 15 May 2018 18:18:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: syzbot <syzbot+30d675e3ca03c1c351e7@syzkaller.appspotmail.com>,
        bp@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, ricardo.neri-calderon@linux.intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org,
        yhs@fb.com
Subject: Re: WARNING in arch_uprobe_analyze_insn
Message-ID: <20180515161818.GA22580@redhat.com>
References: <000000000000b759cf056c2b3c12@google.com>
 <20180515133630.GA20619@redhat.com>
 <20180515234825.d9bea077f296354f3724f736@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515234825.d9bea077f296354f3724f736@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15, Masami Hiramatsu wrote:
>
> On Tue, 15 May 2018 15:36:30 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Unfortunately, insn_get_length() returns void, and I do not see any
> > insn-was-decoded-correctly helper. Perhaps we should simply remove
> > this WARN_ON() ?
>
> Yes, it should just return an error,

OK, I'll send the fix,

> since user can miss the
> probe address on user binary and we can not make sure
> that is on a instruction boundary.

Or this insn is actually invalid.

> > Alternatively, If am right we can move this check down after the "good_insns"
> > checks, but this doesn't look very clean to me.
>
> I think it is enough if arch_uprobe_analyze_insn() returns an error.
> That makes prepare_uprobe() fail and finally leads uprobe_register()
> fail.

I meant that this way we could probably keep WARN_ON(). Nevermind.

Thanks!

Oleg.
