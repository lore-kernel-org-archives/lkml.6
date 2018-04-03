Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755346AbeDCJ3F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:29:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755172AbeDCJ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:29:04 -0400
Date: Tue, 3 Apr 2018 11:29:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: syzbot <syzbot+d1fe9b7b917f2715c7d4@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: general protection fault in try_to_wake_up
Message-ID: <20180403092902.i2xg3dmdlcv477aw@pathway.suse.cz>
References: <000000000000f2c42e05688f3ab6@google.com>
 <20180403085002.cq6rjxcmggypo4kh@pathway.suse.cz>
 <20180403091333.GZ4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403091333.GZ4082@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-04-03 11:13:33, Peter Zijlstra wrote:
> On Tue, Apr 03, 2018 at 10:50:03AM +0200, Petr Mladek wrote:
> > raw_spin_lock() succeeded here. Therefore lockdep was still working
> > at this stage.
> 
> What does the success of raw_spin_lock() have to do with lockdep ?

It means that also lockdep succeeded there. Therefore the general
protection fault in __lock_acquire() was specific to the spinlock
taken by try_to_wake_up(). I though that it might had been an useful
information.

Anyway, the other replay from Dmitry suggested that it was a known
bug, see
https://lkml.kernel.org/r/CACT4Y+ZJ2QD7MPy4hB-M=mz2LuVu3bRbLg1QdY=z=+Su1QWMqg@mail.gmail.com

Best Regards,
Petr
