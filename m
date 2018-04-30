Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbeD3RqG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:46:06 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:53751 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753410AbeD3RqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:46:03 -0400
X-Google-Smtp-Source: AB8JxZoRokepukmveD9gvarOA5wyliF8ZT7F+b3UJs3Kqid+IZF6QzkHltDot4IhbNey0JgcAmScUDXzVbTD96FT9jzBM3sEsXkc
MIME-Version: 1.0
Date: Mon, 30 Apr 2018 10:46:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006de361056b146dbe@google.com>
Subject: INFO: task hung in lock_mount
From: syzbot <syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a27fc14219f2 Merge branch 'parisc-4.17-3' of  
git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?id=5953322812964864
kernel config:   
https://syzkaller.appspot.com/x/.config?id=-5914490758943236750
dashboard link: https://syzkaller.appspot.com/bug?extid=221d75710bde87fa0e97
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com

__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
INFO: task syz-executor0:20276 blocked for more than 120 seconds.
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
       Not tainted 4.17.0-rc1+ #6
b_state=0x00000029, b_size=512
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D24704 20276  23010 0x00000004
device loop0 blocksize: 4096
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
  schedule+0xef/0x430 kernel/sched/core.c:3549
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
  __rwsem_down_write_failed_common+0x919/0x15d0  
kernel/locking/rwsem-xadd.c:566
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
device loop0 blocksize: 4096
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
__find_get_block_slow() failed. block=1, b_blocknr=8
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa2/0x120 kernel/locking/rwsem.c:72
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
  inode_lock include/linux/fs.h:713 [inline]
  lock_mount+0x8c/0x2e0 fs/namespace.c:2087
device loop0 blocksize: 4096
  do_add_mount+0x27/0x370 fs/namespace.c:2464
__find_get_block_slow() failed. block=1, b_blocknr=8
  do_new_mount fs/namespace.c:2531 [inline]
  do_mount+0x18e6/0x3070 fs/namespace.c:2847
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
  ksys_mount+0x12d/0x140 fs/namespace.c:3063
  __do_sys_mount fs/namespace.c:3077 [inline]
  __se_sys_mount fs/namespace.c:3074 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3074
b_state=0x00000029, b_size=512
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455329
device loop0 blocksize: 4096
RSP: 002b:00007f68cf133c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f68cf1346d4 RCX: 0000000000455329
__find_get_block_slow() failed. block=1, b_blocknr=8
RDX: 0000000020000240 RSI: 0000000020000080 RDI: 0000000020000280
RBP: 000000000072bf58 R08: 0000000020000040 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
b_state=0x00000029, b_size=512
R13: 00000000000003fb R14: 00000000006f9028 R15: 0000000000000001

Showing all locks held in the system:
device loop0 blocksize: 4096
2 locks held by khungtaskd/888:
__find_get_block_slow() failed. block=1, b_blocknr=8
  #0: 00000000a9a44477 (
b_state=0x00000029, b_size=512
rcu_read_lock){....}, at: check_hung_uninterruptible_tasks  
kernel/hung_task.c:175 [inline]
rcu_read_lock){....}, at: watchdog+0x1ff/0xf60 kernel/hung_task.c:249
device loop0 blocksize: 4096
  #1: 000000009ff2053f (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4439:
__find_get_block_slow() failed. block=1, b_blocknr=8
  #0: 00000000c9b76b9a (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
  #1:
b_state=0x00000029, b_size=512
000000000e5cb710 (&ldata->atomic_read_lock){+.+.}
device loop0 blocksize: 4096
, at: n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4440:
__find_get_block_slow() failed. block=1, b_blocknr=8
  #0: 000000005b768cd3 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
  #1: 00000000addaef00 (
__find_get_block_slow() failed. block=1, b_blocknr=8
&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x321/0x1cc0  
drivers/tty/n_tty.c:2131
2 locks held by getty/4441:
  #0: 000000000c8a520e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000be9918f7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4442:
  #0: 0000000029e321e8 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000c3a0104f (&ldata->atomic_read_lock
b_state=0x00000029, b_size=512
){+.+.}, at: n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4443:
device loop0 blocksize: 4096
  #0: 00000000b12d6ffd (
__find_get_block_slow() failed. block=1, b_blocknr=8
&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40  
drivers/tty/tty_ldsem.c:365
  #1:
b_state=0x00000029, b_size=512
00000000625407e7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4444:
device loop0 blocksize: 4096
  #0: 0000000019948f4c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:
__find_get_block_slow() failed. block=1, b_blocknr=8
00000000071c1ff8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4445:
b_state=0x00000029, b_size=512
  #0: 00000000fe9e0006 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
device loop0 blocksize: 4096
  #1: 00000000a738c9c9 (
__find_get_block_slow() failed. block=1, b_blocknr=8
&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x321/0x1cc0  
drivers/tty/n_tty.c:2131
1 lock held by syz-executor0/20276:
b_state=0x00000029, b_size=512
  #0: 00000000a1afb949 (&sb->s_type->i_mutex_key#16){++++}
device loop0 blocksize: 4096
, at: inode_lock include/linux/fs.h:713 [inline]
, at: lock_mount+0x8c/0x2e0 fs/namespace.c:2087
2 locks held by syz-executor0/20277:
__find_get_block_slow() failed. block=1, b_blocknr=8
  #0: 000000008134fa51 (sb_writers#14){.+.+}, at: sb_start_write  
include/linux/fs.h:1550 [inline]
  #0: 000000008134fa51 (sb_writers#14){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1: 00000000a1afb949
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
  (&sb->s_type->i_mutex_key#16/1
__find_get_block_slow() failed. block=1, b_blocknr=8
){+.+.}, at: inode_lock_nested include/linux/fs.h:748 [inline]
){+.+.}, at: filename_create+0x1aa/0x5a0 fs/namei.c:3606
1 lock held by syz-executor0/20279:
  #0:
b_state=0x00000029, b_size=512
00000000a1afb949 (&sb->s_type->i_mutex_key#16){++++}, at: inode_lock  
include/linux/fs.h:713 [inline]
00000000a1afb949 (&sb->s_type->i_mutex_key#16){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2087

device loop0 blocksize: 4096
=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 888 Comm: khungtaskd Not tainted 4.17.0-rc1+ #6
__find_get_block_slow() failed. block=1, b_blocknr=8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
b_state=0x00000029, b_size=512
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 0 to CPUs 1:
b_state=0x00000029, b_size=512
NMI backtrace for cpu 1
CPU: 1 PID: 20216 Comm: syz-executor0 Not tainted 4.17.0-rc1+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x1/0x20 kernel/kcov.c:187
RSP: 0018:ffff8801db107d88 EFLAGS: 00000006
RAX: ffff8801d11bc6c0 RBX: ffff8801db11f0c0 RCX: ffffffff816b3515
RDX: 0000000000010000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: ffff8801db107dc0 R08: ffff8801d11bc6c0 R09: ffffed003b624b80
R10: ffffed003b624b80 R11: ffff8801db125c03 R12: 000000ac0c601b80
R13: 0000000000000000 R14: 0000000000000003 R15: ffff8801db125c00
FS:  00007f68cf155700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001d8a72000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  tick_program_event+0xab/0x130 kernel/time/tick-oneshot.c:48
  hrtimer_interrupt+0x2db/0x650 kernel/time/hrtimer.c:1519
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:1678 [inline]
RIP: 0010:vprintk_emit+0xbd0/0xdd0 kernel/printk/printk.c:1906
RSP: 0018:ffff88018a2df000 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000040000 RBX: 0000000000000200 RCX: ffffc90003ac6000
RDX: 0000000000040000 RSI: ffffffff8160bbb7 RDI: 0000000000000246
RBP: ffff88018a2df190 R08: ffff8801d11bcef8 R09: 0000000000000006
R10: ffff8801d11bc6c0 R11: 0000000000000000 R12: 1ffffffff116312d
R13: 000000000000001e R14: ffffed003145be1d R15: ffffffff8a49a360
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
  printk+0x9e/0xba kernel/printk/printk.c:1980
  __find_get_block_slow fs/buffer.c:235 [inline]
  __find_get_block.cold.58+0x85/0x103 fs/buffer.c:1287
  __getblk_slow fs/buffer.c:1032 [inline]
  __getblk_gfp+0x2a1/0xaf0 fs/buffer.c:1313
  __bread_gfp+0x2d/0x310 fs/buffer.c:1347
  sb_bread include/linux/buffer_head.h:309 [inline]
  fat__get_entry+0x594/0xa20 fs/fat/dir.c:101
  fat_get_entry fs/fat/dir.c:129 [inline]
  fat_search_long+0x33b/0x15d0 fs/fat/dir.c:477
  vfat_find+0x16d/0x1a0 fs/fat/namei_vfat.c:697
  vfat_lookup+0xfc/0x6d0 fs/fat/namei_vfat.c:720
  __lookup_hash+0x12e/0x190 fs/namei.c:1505
  filename_create+0x1dd/0x5a0 fs/namei.c:3607
  user_path_create fs/namei.c:3664 [inline]
  do_mkdirat+0xd2/0x2f0 fs/namei.c:3802
  __do_sys_mkdir fs/namei.c:3826 [inline]
  __se_sys_mkdir fs/namei.c:3824 [inline]
  __x64_sys_mkdir+0x5c/0x80 fs/namei.c:3824
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455329
RSP: 002b:00007f68cf154c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007f68cf1556d4 RCX: 0000000000455329
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000003eb R14: 00000000006f8ea8 R15: 0000000000000000
Code: a6 fe ff ff 5d c3 0f 1f 40 00 55 0f b7 d6 0f b7 f7 bf 03 00 00 00 48  
89 e5 48 8b 4d 08 e8 88 fe ff ff 5d c3 66 0f 1f 44 00 00 55 <89> f2 89 fe  
bf 05 00 00 00 48 89 e5 48 8b 4d 08 e8 6a fe ff ff
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.012  
msecs


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
