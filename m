Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031776AbeCAPTj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:19:39 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36762 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031631AbeCAPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:19:38 -0500
X-Google-Smtp-Source: AG47ELuOimeDcS6XnpJh/7xwI/P/RjEMAktd50VQUBHYG24Ei+swguVgGvq1SmB8eSUuRb4jwx6xeg==
Date: Fri, 2 Mar 2018 00:19:34 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, kernel test robot <shun.hao@intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>, Tejun Heo <tj@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [lkp-robot] [printk] c162d5b433: BUG:KASAN:use-after-scope_in_c
Message-ID: <20180301151934.GA507@tigerII.localdomain>
References: <20180224053405.ksymb5yurtpwmfs6@shao2-debian>
 <20180228102334.65iqne6lu5faan52@pathway.suse.cz>
 <20180228155941.34z45rjz3bjqde7w@pathway.suse.cz>
 <20180301013722.GA6763@tigerII.localdomain>
 <CACT4Y+ZUDu588gwgCbqru5D1RD5C+s3+E5ydhP7h9RoCjwQWJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZUDu588gwgCbqru5D1RD5C+s3+E5ydhP7h9RoCjwQWJw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/01/18 09:51), Dmitry Vyukov wrote:
> > https://marc.info/?l=linux-kernel&m=151200883525299
> >
> > [..]
> >> I feel lost a bit.
> >
> > Yeah... can't understand what's going on there.
> >
> > The last time kasan didn't like this part
> >
> > [    0.003333]  ? console_unlock+0x605/0xcc0:
> >                               atomic_read at arch/x86/include/asm/atomic.h:27
> >                                (inlined by) static_key_count at include/linux/jump_label.h:191
> >                                (inlined by) static_key_false at include/linux/jump_label.h:201
> >                                (inlined by) trace_console_rcuidle at include/trace/events/printk.h:10
> >                                (inlined by) call_console_drivers at kernel/printk/printk.c:1556
> >                                (inlined by) console_unlock at kernel/printk/printk.c:2233
> >
> > complaining that there was a write of size 4... at atomic_read().
> 
> Hi Sergey,
> 
> Where is that report?
> I doubt that KASAN has instrumented a read as a write (at least there
> are no such known cases), so perhaps it's pointing to some other
> memory access.

Hello Dmitry,

I believe it's this one

https://marc.info/?l=linux-kernel&m=151200883525299


	-ss
