Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA78CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA682075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA682075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeGRL0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:26:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51277 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:26:53 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6IAnL5l048750;
        Wed, 18 Jul 2018 19:49:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Wed, 18 Jul 2018 19:49:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6IAnLKi048747
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Jul 2018 19:49:21 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: INFO: task hung in grab_super
To:     Dmitry Vyukov <dvyukov@google.com>
References: <0000000000002f5541057143a85e@google.com>
Cc:     syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
Date:   Wed, 18 Jul 2018 19:49:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000002f5541057143a85e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

this is yet another example of stalling inside __bread_gfp().

Can you find all reports where NMI backtrace contains __bread_gfp ?

I need to wget all reports if I try to do that on my side.
If you can locally grep on your side, it will be nice.

On 2018/07/18 19:38, syzbot wrote:
> CPU: 1 PID: 19991 Comm: syz-executor1 Not tainted 4.18.0-rc5+ #152
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__lock_is_held+0x76/0x140 kernel/locking/lockdep.c:3741
> Code: 00 00 4c 8b 6d c8 4d 8d b4 24 38 08 00 00 45 31 ff 48 b8 00 00 00 00 00 fc ff df 49 c1 ed 03 49 01 c5 41 8b 84 24 30 08 00 00 <85> c0 7f 24 e9 85 00 00 00 41 0f b6 45 00 41 83 c7 01 84 c0 74 08
> RSP: 0018:ffff88018ea3eed8 EFLAGS: 00000086
> RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffffc9000443f000
> RDX: 1ffff10031c245de RSI: 00000000ffffffff RDI: ffffffff88f925e0
> RBP: ffff88018ea3ef18 R08: ffff88018e1226c0 R09: ffffed003b5e46d6
> R10: 0000000000000003 R11: 0000000000000001 R12: ffff88018e1226c0
> R13: ffffed0031c245de R14: ffff88018e122ef8 R15: 0000000000000000
> FS:  00007f243a415700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600400 CR3: 00000001d8749000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  lock_is_held_type+0x121/0x210 kernel/locking/lockdep.c:3962
>  lock_is_held include/linux/lockdep.h:344 [inline]
>  ___might_sleep+0x295/0x330 kernel/sched/core.c:6152
>  __might_sleep+0x95/0x190 kernel/sched/core.c:6140
>  lock_page include/linux/pagemap.h:481 [inline]
>  pagecache_get_page+0x787/0xe40 mm/filemap.c:1554
>  find_or_create_page include/linux/pagemap.h:322 [inline]
>  grow_dev_page fs/buffer.c:940 [inline]
>  grow_buffers fs/buffer.c:1009 [inline]
>  __getblk_slow fs/buffer.c:1036 [inline]
>  __getblk_gfp+0x3bb/0xb10 fs/buffer.c:1313
>  __bread_gfp+0x2d/0x310 fs/buffer.c:1347
>  sb_bread_unmovable include/linux/buffer_head.h:313 [inline]
>  ext4_fill_super+0x6de/0xda80 fs/ext4/super.c:3541
>  mount_bdev+0x30c/0x3e0 fs/super.c:1174
>  ext4_mount+0x34/0x40 fs/ext4/super.c:5844
>  mount_fs+0xae/0x328 fs/super.c:1277
>  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:1027 [inline]
>  do_new_mount fs/namespace.c:2518 [inline]
>  do_mount+0x581/0x30e0 fs/namespace.c:2848
>  ksys_mount+0x12d/0x140 fs/namespace.c:3064
>  __do_sys_mount fs/namespace.c:3078 [inline]
>  __se_sys_mount fs/namespace.c:3075 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
