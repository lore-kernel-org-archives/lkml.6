Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeELVuT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:50:19 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37244 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbeELVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:50:18 -0400
X-Google-Smtp-Source: AB8JxZot8R8xy5Ix6V4iPqaj2BEG5v03o14pInBZsLgdlNFHvXXcRPTJq0IAFkbaybm/b2R3TSXX7g==
Date: Sat, 12 May 2018 14:52:22 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot
        <bot+e38be687a2450270a3b593bacb6b5795a7a74edb@syzkaller.appspotmail.com>
Cc: dvyukov@google.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penguin-kernel@I-love.SAKURA.ne.jp,
        pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: BUG: workqueue lockup (2)
Message-ID: <20180512215222.GC817@sol.localdomain>
References: <94eb2c03c9bc75aff2055f70734c@google.com>
 <001a113f711a528a3f0560b08e76@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f711a528a3f0560b08e76@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2017 at 04:25:01AM -0800, syzbot wrote:
> syzkaller has found reproducer for the following crash on
> f3b5ad89de16f5d42e8ad36fbdf85f705c1ae051
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
> 
> 
> BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 37s!
> BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=-20 stuck for 32s!
> Showing busy workqueues and worker pools:
> workqueue events: flags=0x0
>   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
>     pending: cache_reap
> workqueue events_power_efficient: flags=0x80
>   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=2/256
>     pending: neigh_periodic_work, do_cache_clean
> workqueue mm_percpu_wq: flags=0x8
>   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
>     pending: vmstat_update
> workqueue kblockd: flags=0x18
>   pwq 3: cpus=1 node=0 flags=0x0 nice=-20 active=1/256
>     pending: blk_timeout_work
> 

The bug that this reproducer reproduces was fixed a while ago by commit
966031f340185e, so I'm marking this bug report fixed by it:

#syz fix: n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)

Note that the error message was not always "BUG: workqueue lockup"; it was also
sometimes like "watchdog: BUG: soft lockup - CPU#5 stuck for 22s!".

syzbot still is hitting the "BUG: workqueue lockup" error sometimes, but it must
be for other reasons.  None has a reproducer currently.

- Eric
