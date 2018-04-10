Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeDJNZL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:25:11 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:37187 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeDJNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:25:07 -0400
X-Google-Smtp-Source: AIpwx4+FHM3QhvckqlqpRJtYy/wLinWne60N1xDzWgm7hn0DPtksfu0HiJm/2VpCPtR8oRsZJKjRmkakJx2MlSVZBXs=
MIME-Version: 1.0
In-Reply-To: <201804102204.BDF48937.LMHJVFOFFOOSQt@I-love.SAKURA.ne.jp>
References: <652eab47-81b5-3249-3c78-427eeec45fbc@I-love.SAKURA.ne.jp>
 <2e093801-6d71-6747-42df-52f191811ad0@I-love.SAKURA.ne.jp>
 <87bdec75-3c59-6587-2436-1470263ab11f@kernel.dk> <59a08949-7e2f-42ff-edda-f24a6c624551@I-love.SAKURA.ne.jp>
 <CACT4Y+a-_Z69xmLypVi=vrtCEEBGp=zy0Wp8SuLJzYtZ_ShBgw@mail.gmail.com> <201804102204.BDF48937.LMHJVFOFFOOSQt@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 10 Apr 2018 15:24:46 +0200
Message-ID: <CACT4Y+Z0+r+JknT3uYWbjQ36XrSWfYnVkGYcj6FZ0RvgiCF0Yg@mail.gmail.com>
Subject: Re: INFO: task hung in __blkdev_get
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        syzbot
        <bot+48594378e9851eab70bcd6f99327c7db58c5a28a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 3:04 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Dmitry Vyukov wrote:
>> On Tue, Apr 10, 2018 at 12:55 PM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> > Hello.
>> >
>> > Since syzbot is reporting so many hung up bug which involves /dev/loopX ,
>> > is it possible to "temporarily" apply below patch for testing under syzbot
>>
>> Unfortunately it's not possible, for full explanation please see:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches
>>
>
> I mean, sending custom patch to linux.git for -rc and revert the custom patch
> before -final is released. It won't take so much period until we get the result.

Ah, I see, then I guess it wasn't a question to me.


> If syzbot can test arbitrary git tree instead of linux.git, making a branch
> which contains custom patches would be possible.

syzbot tests a set of trees (also net-next and bpf-next at the
moment). But see this reply to Takashi re a similar request:
https://groups.google.com/forum/#!msg/syzkaller-bugs/7ucgCkAJKSk/skZjgavRAQAJ
Note that a syzkaller instances will produce several hundreds of
different crashes within a day, and then a big question is what to do
with them.

What's perfectly possible though is running syzkaller locally, and you
can do it on just any tree you want. I've recently put a script that
setups syzkaller end-to-end with config, compiler and image that
syzbot uses:
https://github.com/google/syzkaller/blob/master/tools/demo_setup.sh
(that uses v4.13, but you can change this to any kernel version).
