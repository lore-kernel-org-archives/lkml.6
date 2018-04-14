Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbeDNP1A (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 11:27:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55301 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeDNP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 11:26:59 -0400
To: dvyukov@google.com
Cc: axboe@kernel.dk, tom.leiming@gmail.com, mingo@redhat.com,
        peterz@infradead.org,
        bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        osandov@fb.com
Subject: Re: INFO: task hung in __blkdev_get
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <87bdec75-3c59-6587-2436-1470263ab11f@kernel.dk>
        <59a08949-7e2f-42ff-edda-f24a6c624551@I-love.SAKURA.ne.jp>
        <CACT4Y+a-_Z69xmLypVi=vrtCEEBGp=zy0Wp8SuLJzYtZ_ShBgw@mail.gmail.com>
        <201804102204.BDF48937.LMHJVFOFFOOSQt@I-love.SAKURA.ne.jp>
        <CACT4Y+Z0+r+JknT3uYWbjQ36XrSWfYnVkGYcj6FZ0RvgiCF0Yg@mail.gmail.com>
In-Reply-To: <CACT4Y+Z0+r+JknT3uYWbjQ36XrSWfYnVkGYcj6FZ0RvgiCF0Yg@mail.gmail.com>
Message-Id: <201804150026.CFD57853.tHJOFLOSFOMVFQ@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 15 Apr 2018 00:26:54 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. The patch was sent to linux.git as commit 1e047eaab3bb5564.

#syz fix: block/loop: fix deadlock after loop_set_status

Dmitry Vyukov <dvyukov@google.com>" wrote:
> On Tue, Apr 10, 2018 at 3:04 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Dmitry Vyukov wrote:
> >> On Tue, Apr 10, 2018 at 12:55 PM, Tetsuo Handa
> >> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> > Hello.
> >> >
> >> > Since syzbot is reporting so many hung up bug which involves /dev/loopX ,
> >> > is it possible to "temporarily" apply below patch for testing under syzbot
> >>
> >> Unfortunately it's not possible, for full explanation please see:
> >> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches
> >>
> >
> > I mean, sending custom patch to linux.git for -rc and revert the custom patch
> > before -final is released. It won't take so much period until we get the result.
> 
> Ah, I see, then I guess it wasn't a question to me.
> 
I noticed that there already is the lockdep report at

  possible deadlock in blkdev_reread_part
  https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

entry, and no patch is proposed yet:

  https://groups.google.com/forum/#!msg/syzkaller-bugs/2Rw8-OM6IbM/SI4DyK-1AQAJ
