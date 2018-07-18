Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B1EECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D262B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3y3n92Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D262B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbeGRMTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:19:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38028 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbeGRMTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:19:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so1886279pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=urfa6YzxxTo5+QT6b2LrpUKU+NpVfQxBc46XFCNoh5w=;
        b=p3y3n92YzKN1bprwIJyOKbPq/hLlBmsvHqioKyD6BM+qpSldzB6OxMChJjmDGu9+80
         qh+ZYzuFCd07zB83Ef4ua70AOnqs54X5c/djqDyGu9/ATP7rdj++C6FW+HRlLSfUA8+J
         GLSX0bMKXqeiN4xY7UBZ1N3hhFi4f9298JlfvbtXIg7/k1RbmC4M6SP7nzlqPg/cEv4H
         fXliNkIsLfTGqiKUOjKEfG+hYYV+Y7qZD1yHeIMWjOkAcCEb5amoD9KaXoLrXBAGPHgN
         ick/iORmP0qEOq0H4dMiTeATVd1ZBSlTN5bSmll0qlWxoMCPXHO2p9+7yx42CF5v0PmP
         O8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=urfa6YzxxTo5+QT6b2LrpUKU+NpVfQxBc46XFCNoh5w=;
        b=kBS/0d07sZE/kH1/nG23agocTr/qIMbLOypNilwSxSUXT5V/Wa5wnnAyhZgiRCp1AJ
         aoQFPuQMW5QXDua0J8Fxc5RX6WPAWotqmpZBq1Fg9penjHi7MLcu8zWcXqQxa447KuOx
         5se6KtRfXeViNTT61ztIUIjYfMcTYpqHghfKRrV+Ba2D1xdckYE+GeJbxqE6c6kyPm5d
         qwJGDf4OZ96jKvZx4AeEibpW+SDMu5y0bmdwdpyAH5qllNVowwTxAge3GSKP93If6UbK
         kEF2JChyh+a1RBtIcE0E2DgpcJFSvHN6F8DzqNjz30XOTwrNrQPWAw0tyeKfAo4Hcpkc
         nkWQ==
X-Gm-Message-State: AOUpUlEwOybInhSL/QEisC4q06Ivv75uWFli3cSacLOYBLu3xvGMf3rl
        CaZ+bRdEzLmcMjRlyJWTt3/AWgOGAXMAfI+OdxmGkg==
X-Google-Smtp-Source: AAOMgpcKi88RHR07Ri33zVQpJwvopAtWrQBBaOQjh5OKTvKO10HeVyP/7kUjEaF2fnlX6rsPW/vJNLaH1Se7EdI1Ea0=
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr5288174pgf.84.1531914135143;
 Wed, 18 Jul 2018 04:42:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:41:54
 -0700 (PDT)
In-Reply-To: <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
References: <0000000000002f5541057143a85e@google.com> <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
 <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 13:41:54 +0200
Message-ID: <CACT4Y+bM1tfisT+7=ZChHRZKZkddbWp0kNi5q46EqOYBSptXtg@mail.gmail.com>
Subject: Re: INFO: task hung in grab_super
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net
Cc:     syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 1:02 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Jul 18, 2018 at 12:49 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Dmitry,
>>
>> this is yet another example of stalling inside __bread_gfp().
>>
>> Can you find all reports where NMI backtrace contains __bread_gfp ?
>>
>> I need to wget all reports if I try to do that on my side.
>> If you can locally grep on your side, it will be nice.
>
>
> No, I don't have grep. But here are some of the matches:
>
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/__bread_gfp%7Csort:date
> https://groups.google.com/forum/#!searchin/syzkaller-upstream-moderation/__bread_gfp%7Csort:date
>
>
>
>> On 2018/07/18 19:38, syzbot wrote:
>>> CPU: 1 PID: 19991 Comm: syz-executor1 Not tainted 4.18.0-rc5+ #152
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> RIP: 0010:__lock_is_held+0x76/0x140 kernel/locking/lockdep.c:3741
>>> Code: 00 00 4c 8b 6d c8 4d 8d b4 24 38 08 00 00 45 31 ff 48 b8 00 00 00 00 00 fc ff df 49 c1 ed 03 49 01 c5 41 8b 84 24 30 08 00 00 <85> c0 7f 24 e9 85 00 00 00 41 0f b6 45 00 41 83 c7 01 84 c0 74 08
>>> RSP: 0018:ffff88018ea3eed8 EFLAGS: 00000086
>>> RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffffc9000443f000
>>> RDX: 1ffff10031c245de RSI: 00000000ffffffff RDI: ffffffff88f925e0
>>> RBP: ffff88018ea3ef18 R08: ffff88018e1226c0 R09: ffffed003b5e46d6
>>> R10: 0000000000000003 R11: 0000000000000001 R12: ffff88018e1226c0
>>> R13: ffffed0031c245de R14: ffff88018e122ef8 R15: 0000000000000000
>>> FS:  00007f243a415700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: ffffffffff600400 CR3: 00000001d8749000 CR4: 00000000001406e0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>  lock_is_held_type+0x121/0x210 kernel/locking/lockdep.c:3962
>>>  lock_is_held include/linux/lockdep.h:344 [inline]
>>>  ___might_sleep+0x295/0x330 kernel/sched/core.c:6152
>>>  __might_sleep+0x95/0x190 kernel/sched/core.c:6140
>>>  lock_page include/linux/pagemap.h:481 [inline]
>>>  pagecache_get_page+0x787/0xe40 mm/filemap.c:1554
>>>  find_or_create_page include/linux/pagemap.h:322 [inline]
>>>  grow_dev_page fs/buffer.c:940 [inline]
>>>  grow_buffers fs/buffer.c:1009 [inline]
>>>  __getblk_slow fs/buffer.c:1036 [inline]
>>>  __getblk_gfp+0x3bb/0xb10 fs/buffer.c:1313
>>>  __bread_gfp+0x2d/0x310 fs/buffer.c:1347
>>>  sb_bread_unmovable include/linux/buffer_head.h:313 [inline]
>>>  ext4_fill_super+0x6de/0xda80 fs/ext4/super.c:3541
>>>  mount_bdev+0x30c/0x3e0 fs/super.c:1174
>>>  ext4_mount+0x34/0x40 fs/ext4/super.c:5844
>>>  mount_fs+0xae/0x328 fs/super.c:1277
>>>  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>>>  vfs_kern_mount fs/namespace.c:1027 [inline]
>>>  do_new_mount fs/namespace.c:2518 [inline]
>>>  do_mount+0x581/0x30e0 fs/namespace.c:2848
>>>  ksys_mount+0x12d/0x140 fs/namespace.c:3064
>>>  __do_sys_mount fs/namespace.c:3078 [inline]
>>>  __se_sys_mount fs/namespace.c:3075 [inline]
>>>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
>>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe


This seems to be related to 9p. After rerunning the log I got:

root@syzkaller:~# ps afxu | grep syz
root     18253  0.0  0.0      0     0 ttyS0    Zl   10:16   0:00  \_
[syz-executor] <defunct>
root@syzkaller:~# cat /proc/18253/task/*/stack
[<0>] p9_client_rpc+0x3a2/0x1400
[<0>] p9_client_flush+0x134/0x2a0
[<0>] p9_client_rpc+0x122c/0x1400
[<0>] p9_client_create+0xc56/0x16af
[<0>] v9fs_session_init+0x21a/0x1a80
[<0>] v9fs_mount+0x7c/0x900
[<0>] mount_fs+0xae/0x328
[<0>] vfs_kern_mount.part.34+0xdc/0x4e0
[<0>] do_mount+0x581/0x30e0
[<0>] ksys_mount+0x12d/0x140
[<0>] __x64_sys_mount+0xbe/0x150
[<0>] do_syscall_64+0x1b9/0x820
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
[<0>] 0xffffffffffffffff

There is a bunch of hangs in 9p, so let's do:

#syz dup: INFO: task hung in flush_work
