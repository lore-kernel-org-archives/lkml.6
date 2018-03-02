Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeCBFKx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:10:53 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:39389 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeCBFKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:10:51 -0500
X-Google-Smtp-Source: AG47ELvWQNAf2TmJsyeuSbT0Q2eTbPSjUYYJmklP+HvI6e5cZvYcW/KGXXReLFoQ3e3SCWFwlm+2LA==
Date: Fri, 2 Mar 2018 14:10:46 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
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
Message-ID: <20180302051046.GA899@jagdpanzerIV>
References: <20180224053405.ksymb5yurtpwmfs6@shao2-debian>
 <20180228102334.65iqne6lu5faan52@pathway.suse.cz>
 <20180228155941.34z45rjz3bjqde7w@pathway.suse.cz>
 <20180301013722.GA6763@tigerII.localdomain>
 <CACT4Y+ZUDu588gwgCbqru5D1RD5C+s3+E5ydhP7h9RoCjwQWJw@mail.gmail.com>
 <20180301151934.GA507@tigerII.localdomain>
 <CACT4Y+byVgvjzTush=Zft_iQmZ3e46QS8X6ooZ15CmAxvPu-oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+byVgvjzTush=Zft_iQmZ3e46QS8X6ooZ15CmAxvPu-oA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/01/18 16:53), Dmitry Vyukov wrote:
[..]
> > Hello Dmitry,
> >
> > I believe it's this one
> >
> > https://marc.info/?l=linux-kernel&m=151200883525299
> 
> 
> Thanks, but now that I debugged this one, I think that one is the same issue.
> Amusingly a write in READ_ONCE is actually legitimate because
> GCC_PLUGIN_STRUCTLEAK emits an initializing write for __u variable in
> READ_ONCE implementation.

Thanks. It's great to have you in Cc ;)

	-ss
