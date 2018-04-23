Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeDWFfn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:35:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34096 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDWFfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:35:36 -0400
X-Google-Smtp-Source: AIpwx4+6wCrpn+/rStQibRD2+wDWEc9kcUuQIZffH3pTaCUh2zDb5ZkgCYJMUMeUOujt5rtpMiVOtQ==
Date: Mon, 23 Apr 2018 14:35:31 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        rostedt@rostedt.homelinux.com, Byungchul Park <byungchul.park@lge.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] printk: Console owner and waiter logic cleanup
Message-ID: <20180423053531.GB3643@jagdpanzerIV>
References: <20180117134201.0a9cbbbf@gandalf.local.home>
 <20180119132052.02b89626@gandalf.local.home>
 <20180120071402.GB8371@jagdpanzerIV>
 <20180120104931.1942483e@gandalf.local.home>
 <20180121141521.GA429@tigerII.localdomain>
 <20180123064023.GA492@jagdpanzerIV>
 <20180123095652.5e14da85@gandalf.local.home>
 <20180123152130.GB429@tigerII.localdomain>
 <20180123104121.2ef96d81@gandalf.local.home>
 <20180123154347.GE1771050@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123154347.GE1771050@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/23/18 07:43), Tejun Heo wrote:
> > 
> > We can have more. But if printk is causing printks, that's a major bug.
> > And work queues are not going to fix it, it will just spread out the
> > pain. Have it be 100 printks, it needs to be fixed if it is happening.
> > And having all printks just generate more printks is not helpful. Even
> > if we slow them down. They will still never end.
> 
> So, at least in the case that we were seeing, it isn't that black and
> white.  printk keeps causing printks but only because printk buffer
> flushing is preventing the printk'ing context from making forward
> progress.  The key problem there is that a flushing context may get
> pinned flushing indefinitely and using a separate context does solve
> the problem.

Hello Tejun,

I'm willing to take a look at those printk()-s from console drivers.
Any chance you can send me some of the backtraces you see [the most
common/disturbing]?

	-ss
