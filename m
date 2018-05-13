Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeEMCUE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 22:20:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23340 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeEMCUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 22:20:03 -0400
Subject: Re: general protection fault in kernfs_kill_sb (2)
To: syzbot <syzbot+481ad819c717f6b78df9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <0000000000008fa9d3056c053291@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <14892403-d680-dc5d-1927-bc4a279514fb@I-love.SAKURA.ne.jp>
Date: Sun, 13 May 2018 11:19:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0000000000008fa9d3056c053291@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/05/13 2:01, syzbot wrote:
> Call Trace:
>  __list_del_entry include/linux/list.h:117 [inline]
>  list_del include/linux/list.h:125 [inline]
>  kernfs_kill_sb+0xa0/0x350 fs/kernfs/mount.c:361
>  sysfs_kill_sb+0x22/0x40 fs/sysfs/mount.c:50
>  deactivate_locked_super+0x97/0x100 fs/super.c:316
>  kernfs_mount_ns+0x753/0x8e0 fs/kernfs/mount.c:335
>  sysfs_mount+0xdf/0x200 fs/sysfs/mount.c:36
>  mount_fs+0xae/0x328 fs/super.c:1267
>  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:1027 [inline]
>  do_new_mount fs/namespace.c:2518 [inline]
>  do_mount+0x564/0x3070 fs/namespace.c:2848
>  ksys_mount+0x12d/0x140 fs/namespace.c:3064
>  __do_sys_mount fs/namespace.c:3078 [inline]
>  __se_sys_mount fs/namespace.c:3075 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4426a9
> RSP: 002b:00007ffc558bd1b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004426a9
> RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000020000040
> RBP: 00007ffc558bda60 R08: 0000000000000000 R09: 0000000300000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000004 R14: 0000000000001380 R15: 00007ffc558bd2f8
> Code: c5 0f 84 cc 00 00 00 48 b8 00 02 00 00 00 00 ad de 49 39 c4 0f 84 a5 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 5f 49 8b 14 24 48 39 da 0f 85 ba 00 00 00 48 b8
> RIP: __list_del_entry_valid+0x84/0xf3 lib/list_debug.c:51 RSP: ffff8801aca6f860
> ---[ end trace d148f307a34e229f ]---

This is what I reported at
https://groups.google.com/d/msg/syzkaller-bugs/ISOJlV2I2QM/qHslGMi3AwAJ .

We are currently waiting for comments from Al Viro.
