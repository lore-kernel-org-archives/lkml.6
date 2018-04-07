Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbeDGPjr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 11:39:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeDGPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 11:39:46 -0400
Date: Sat, 7 Apr 2018 17:39:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: mingo@kernel.org, akpm@linux-foundation.org, dvyukov@google.com,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, msb@chromium.org, tglx@linutronix.de,
        vegard.nossum@oracle.com
Subject: Re: [PATCH v2] locking/hung_task: Show all hung tasks before panic
Message-ID: <20180407153937.GR4082@hirez.programming.kicks-ass.net>
References: <1522678324-4855-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180402153530.GN3948@linux.vnet.ibm.com>
 <CACT4Y+Yk0hEDj2EcXTJ5BcTHE0m1Sn0e9RfY=6KC4nWhWOHPmw@mail.gmail.com>
 <201804050705.BHE57833.HVFOFtSOMQJFOL@I-love.SAKURA.ne.jp>
 <201804072131.AEF86988.OFOQLJMVFFtOSH@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804072131.AEF86988.OFOQLJMVFFtOSH@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 09:31:19PM +0900, Tetsuo Handa wrote:
> are for replacing debug_show_all_locks() in check_hung_task() for cases like
> https://syzkaller.appspot.com/bug?id=26aa22915f5e3b7ca2cfca76a939f12c25d624db
> because we are interested in only threads holding locks.
> 
> SysRq-t is too much but SysRq-w is useless for killable/interruptible threads...

Or use a script to process the sysrq-t output? I mean, we can add all
sorts, but where does it end?
