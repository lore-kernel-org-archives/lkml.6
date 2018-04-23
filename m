Return-Path: <3XrbdWgkbAB8NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524479583; cv=none;
        d=google.com; s=arc-20160816;
        b=dISUzlMzCs82quVAM0m2jH2w+aTTD6YweM1h2mrMsDwt8waFsgqKqXttbWWzu41Bfx
         w3S1GDmmWBIMiL/hyfUDXiqu2WfmXislKD+pmM/onaCOkkstN9YT/pnyU6p1h0iX2iWT
         dGK5tfOwbVRzGiZSch6XXI6Fpx6fGhXXzAMBkiTBEiYkK0CyK8obet+6xJnAiRahEe1U
         e+tvLivPjTok2Nw9QRd5ZsMqb6D5tOgRULykkxfdJRADviRDts4JYRSbYXyF5PIFKh3x
         mceHSACjpImPr5CAGW6M8ABEENfE058Co6v9YFN8GWADXL0wRdLYrALLVWOGqNVt42++
         8qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=hQRq7LtctsWvejMqnKciQRAwOsg6tuTmQs0rBJs+NA0=;
        b=TVF/+V8gxVrJYDbys/99sHqcYuxDr5lujeXXx/ZBPAS/VU+6deT6Ghyk6bJzS+G6k0
         O08WIc0IVBkT7GoCUga2zYRL/tvqyV73RNjIvS5bQmJ2xfMwcOhcAOvb//k7mmG+Bl/G
         BWRIjTNi1j6NIDLlIjrFJ6odBvL/7u86DwR/NHsea9IdUcdfVwKGppezzHMkncPx/2hU
         dnWwVrzPXoZYGdGeM3XGRMGzPP3sAEHX6NFRXGeeb26FMgNTiyZvvD+YA9qxwNRt4aXa
         ZLWJlXzAPkhhvXnGS5LR/LgQAwX2g7Izw9ADYsnaX2qOFwqER8peB/yXt/QSm3+8jJ51
         XhFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3xrbdwgkbab8ntuf5gg9m5kkd8.bjjbg9pn9m7jio9io.7jh@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3XrbdWgkbAB8NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3xrbdwgkbab8ntuf5gg9m5kkd8.bjjbg9pn9m7jio9io.7jh@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3XrbdWgkbAB8NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AB8JxZrivGfVP+AQMM+DioFJhqFYIQ9UsaUpdXb7uAGWI9FMLGdNX0jG3wgYPl+JnmN1kgZDbmQv3eCUfCpmCtI2hI8xryHregER
MIME-Version: 1.0
Date: Mon, 23 Apr 2018 03:33:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbda89056a818f20@google.com>
Subject: KASAN: use-after-free Read in debugfs_remove (2)
From: syzbot <syzbot+db48ce201b524603190a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598532704298959546?=
X-GMAIL-MSGID: =?utf-8?q?1598532704298959546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
83beed7b2b26f232d782127792dd0cd4362fdc41 (Fri Apr 20 17:56:32 2018 +0000)
Merge branch 'fixes' of  
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=db48ce201b524603190a

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4855303350779904
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+db48ce201b524603190a@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

R13: 0000000020000080 R14: 0000000000000000 R15: 0000000000000000
QAT: Invalid ioctl
print_req_error: I/O error, dev loop199, sector 2
hfsplus: unable to find HFS+ superblock
==================================================================
BUG: KASAN: use-after-free in debugfs_remove+0x10b/0x130  
fs/debugfs/inode.c:682
Read of size 8 at addr ffff8801b2be1380 by task syz-executor6/10824

CPU: 1 PID: 10824 Comm: syz-executor6 Not tainted 4.17.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  debugfs_remove+0x10b/0x130 fs/debugfs/inode.c:682
  bdi_debug_unregister mm/backing-dev.c:127 [inline]
  bdi_unregister+0x606/0x8e0 mm/backing-dev.c:934
  release_bdi mm/backing-dev.c:951 [inline]
  kref_put include/linux/kref.h:70 [inline]
  bdi_put+0x153/0x180 mm/backing-dev.c:960
  generic_shutdown_super+0x3c2/0x520 fs/super.c:457
  kill_anon_super+0x3c/0x50 fs/super.c:1036
  fuse_kill_sb_anon+0x90/0xb0 fs/fuse/inode.c:1205
  deactivate_locked_super+0x97/0x100 fs/super.c:316
  deactivate_super+0x188/0x1b0 fs/super.c:347
  cleanup_mnt+0xbf/0x160 fs/namespace.c:1174
  __cleanup_mnt+0x16/0x20 fs/namespace.c:1181
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  __do_sys_exit_group kernel/exit.c:979 [inline]
  __se_sys_exit_group kernel/exit.c:977 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455389
RSP: 002b:00007fff28940e58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000006b RCX: 0000000000455389
RDX: 000000000040f380 RSI: 0000000000a44bd0 RDI: 0000000000000045
RBP: 00000000004b9ed5 R08: 000000000000000d R09: 0000000000000000
R10: 000000000297f940 R11: 0000000000000246 R12: 0000000002980940
R13: 0000000000000000 R14: 00000000000000fe R15: 0000000000094af1

Allocated by task 11096:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  __d_alloc+0xc0/0xd30 fs/dcache.c:1638
  d_alloc+0x8e/0x370 fs/dcache.c:1722
  d_alloc_parallel+0x152/0x1e80 fs/dcache.c:2497
  __lookup_slow+0x1e6/0x540 fs/namei.c:1613
  lookup_one_len+0x1c7/0x210 fs/namei.c:2490
  start_creating+0xc6/0x200 fs/debugfs/inode.c:308
  debugfs_create_dir+0x23/0x3c0 fs/debugfs/inode.c:505
  bdi_debug_register mm/backing-dev.c:110 [inline]
  bdi_register_va.part.10+0x318/0x970 mm/backing-dev.c:875
  bdi_register_va+0x68/0x80 mm/backing-dev.c:884
  super_setup_bdi_name+0x123/0x220 fs/super.c:1319
  fuse_bdi_init fs/fuse/inode.c:987 [inline]
  fuse_fill_super+0xe6e/0x1e20 fs/fuse/inode.c:1110
  mount_nodev+0x6b/0x110 fs/super.c:1210
  fuse_mount+0x2c/0x40 fs/fuse/inode.c:1192
  mount_fs+0xae/0x328 fs/super.c:1267
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11095:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  __d_free+0x20/0x30 fs/dcache.c:257
  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
  rcu_do_batch kernel/rcu/tree.c:2675 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2930 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2897 [inline]
  rcu_process_callbacks+0x941/0x15f0 kernel/rcu/tree.c:2914
  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285

The buggy address belongs to the object at ffff8801b2be1340
  which belongs to the cache dentry(17:syz6) of size 288
The buggy address is located 64 bytes inside of
  288-byte region [ffff8801b2be1340, ffff8801b2be1460)
The buggy address belongs to the page:
page:ffffea0006caf840 count:1 mapcount:0 mapping:ffff8801b2be1080  
index:0xffff8801b2be1a20
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801b2be1080 ffff8801b2be1a20 0000000100000002
raw: ffffea000726f320 ffffea0007267820 ffff8801afc09cc0 ffff8801b1dfab80
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801b1dfab80

Memory state around the buggy address:
  ffff8801b2be1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b2be1300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8801b2be1380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8801b2be1400: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
  ffff8801b2be1480: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

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
