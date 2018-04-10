Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbeDJNEn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:04:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:20593 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbeDJNEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:04:40 -0400
To: dvyukov@google.com, axboe@kernel.dk
Cc: tom.leiming@gmail.com, mingo@redhat.com, peterz@infradead.org,
        bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        osandov@fb.com
Subject: Re: INFO: task hung in __blkdev_get
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <652eab47-81b5-3249-3c78-427eeec45fbc@I-love.SAKURA.ne.jp>
        <2e093801-6d71-6747-42df-52f191811ad0@I-love.SAKURA.ne.jp>
        <87bdec75-3c59-6587-2436-1470263ab11f@kernel.dk>
        <59a08949-7e2f-42ff-edda-f24a6c624551@I-love.SAKURA.ne.jp>
        <CACT4Y+a-_Z69xmLypVi=vrtCEEBGp=zy0Wp8SuLJzYtZ_ShBgw@mail.gmail.com>
In-Reply-To: <CACT4Y+a-_Z69xmLypVi=vrtCEEBGp=zy0Wp8SuLJzYtZ_ShBgw@mail.gmail.com>
Message-Id: <201804102204.BDF48937.LMHJVFOFFOOSQt@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Tue, 10 Apr 2018 22:04:36 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Tue, Apr 10, 2018 at 12:55 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Hello.
> >
> > Since syzbot is reporting so many hung up bug which involves /dev/loopX ,
> > is it possible to "temporarily" apply below patch for testing under syzbot
> 
> Unfortunately it's not possible, for full explanation please see:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches
> 

I mean, sending custom patch to linux.git for -rc and revert the custom patch
before -final is released. It won't take so much period until we get the result.

If syzbot can test arbitrary git tree instead of linux.git, making a branch
which contains custom patches would be possible.

> 
> > ( after "block/loop: fix deadlock after loop_set_status" and
> > "loop: fix LOOP_GET_STATUS lock imbalance" in linux-block.git#for-linus
> > are merged into linux.git )?
