Return-Path: <3UrPdWgkbAA05BCxnyyr4n22vq.t11tyr75r4p106r06.p1z@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524478802; cv=none;
        d=google.com; s=arc-20160816;
        b=YTAnFC9WLFVSnZJO7HM1DCPAw/8wCuiCnjC3Jx6fTfavPtjeLECB/xXzZxtS6+o9pn
         YuVq/0vwpQuV2wW7B3PqLBp+iEALhucVu/C/KhHbvAODV/YZ1VjHFti69rwgW3jpi0Bt
         W+BlDogVTB8P3DG54vH62rAY4mQxUHrsEuy0VOBAkBtoELKVxm+ih4PaNtYkGLI10Qwd
         +BEt632gPAT/TRsU50S3tXI77xzQFzB7p2W9kdDKkFzDolZBzqIB3oNIOjMEbHXYrTDZ
         lDAuqivBGMNjO8E9TYpCQbPEEfTsRHD3ANEnfSfCRsC7IHx88nRUpIaT3R/o1x9bqzsx
         sihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=tdtqhvEjamAC5qoHI0UDbAi7wKersATY1xGkzaaApno=;
        b=nmokl1wQbFN7J6O0BYKhHIYxsaY3sePjxcGMjh0j/hwYcwS5DiH7jC2Z/b02QhNjOo
         gavwo7DbtJPjAN+UQXzpPbBWxmG9AzajOyLD10m0EmcH/LCN+HTkrfrWTk2gNeXC+AYX
         1mojQDMgXgfXlS89lQh8AvtM/LD4ur92CZXI+pDI70xJcS70YmU0Oe5VQo2GpahkyWam
         6yr5xEkJGWYD4UYfAMwRSfc3QSSKeBQZR1G2o6D+zKi9j7C9yK5ZOBiMSMFrgUvm269+
         0pXsEGQ9axXfAg20B4xAfUHpJlTmmPzKzP4omCJPuzLFBmiMGXNK/HQZJvhkO2zdkAxg
         w5+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3urpdwgkbaa05bcxnyyr4n22vq.t11tyr75r4p106r06.p1z@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3UrPdWgkbAA05BCxnyyr4n22vq.t11tyr75r4p106r06.p1z@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3urpdwgkbaa05bcxnyyr4n22vq.t11tyr75r4p106r06.p1z@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3UrPdWgkbAA05BCxnyyr4n22vq.t11tyr75r4p106r06.p1z@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx48bUVIjaEn1ZIdKlRAs3wIbL/WWH6PErtzXIfLbCkqJTRUjJyKW36tEFf2kq/Nal+uflTbfHZlTlNgNV5eJ0JCoIZuZf02c
MIME-Version: 1.0
Date: Mon, 23 Apr 2018 03:20:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cdcf6056a81617f@google.com>
Subject: WARNING: kernel stack regs at         (ptrval) in syz-executor has
 bad 'bp' value         (ptrval)
From: syzbot <syzbot+795f3a2b6f5ad776cc22@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, gregkh@linuxfoundation.org, hmclauchlan@fb.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, pombredanne@nexb.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598531885115159252?=
X-GMAIL-MSGID: =?utf-8?q?1598531885115159252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
5ec83b22a2dd13180762c89698e4e2c2881a423c (Sun Apr 22 19:13:04 2018 +0000)
Merge tag '4.17-rc1-SMB3-CIFS' of git://git.samba.org/sfrench/cifs-2.6
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=795f3a2b6f5ad776cc22

So far this crash happened 2 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5291662095941632
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=1808800213120130118
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+795f3a2b6f5ad776cc22@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

         (ptrval): 0000000000455389 (0x455389)
         (ptrval): 0000000000000033 (0x33)
         (ptrval): 0000000000000246 (0x246)
         (ptrval): 00007f162d156c68 (0x7f162d156c68)
         (ptrval): 000000000000002b (0x2b)
WARNING: kernel stack regs at         (ptrval) in syz-executor0:7766 has  
bad 'bp' value         (ptrval)
binder: 7815:7817 got transaction to invalid handle
binder: 7815:7817 transaction failed 29201/-22, size 0-0 line 2848
binder: undelivered TRANSACTION_ERROR: 29201
binder: 7941:7942 ioctl c018620b 20000000 returned -14
binder: 7941:7942 ioctl c0306201 20000240 returned -14
binder_alloc: binder_alloc_mmap_handler: 7941 20000000-20002000 already  
mapped failed -16
binder: 7941:7951 ioctl c018620b 20000000 returned -14
binder: 7941:7951 ioctl c0306201 20000240 returned -14
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 1 PID: 8218 Comm: syz-executor2 Not tainted 4.17.0-rc1+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc_trace+0x2cb/0x780 mm/slab.c:3618
  kmalloc include/linux/slab.h:512 [inline]
  kzalloc include/linux/slab.h:701 [inline]
  alloc_pipe_info+0x16d/0x580 fs/pipe.c:633
  splice_direct_to_actor+0x6e7/0x8d0 fs/splice.c:920
  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455389
RSP: 002b:00007fd5ef4adc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd5ef4ae6d4 RCX: 0000000000455389
RDX: 0000000020000140 RSI: 0000000000000013 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000015
R13: 00000000000004cf R14: 00000000006fa408 R15: 0000000000000000
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 8252 Comm: syz-executor2 Not tainted 4.17.0-rc1+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  __do_kmalloc mm/slab.c:3716 [inline]
  __kmalloc+0x2c8/0x760 mm/slab.c:3727
  kmalloc_array include/linux/slab.h:631 [inline]
  kcalloc include/linux/slab.h:642 [inline]
  alloc_pipe_info+0x2a0/0x580 fs/pipe.c:650
  splice_direct_to_actor+0x6e7/0x8d0 fs/splice.c:920
  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455389
RSP: 002b:00007fd5ef4adc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd5ef4ae6d4 RCX: 0000000000455389
RDX: 0000000020000140 RSI: 0000000000000013 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000015
R13: 00000000000004cf R14: 00000000006fa408 R15: 0000000000000001
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 8283 Comm: syz-executor2 Not tainted 4.17.0-rc1+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc_node mm/slab.c:3299 [inline]
  kmem_cache_alloc_node_trace+0x26f/0x770 mm/slab.c:3661
  __do_kmalloc_node mm/slab.c:3681 [inline]
  __kmalloc_node+0x33/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:554 [inline]
  kvmalloc_node+0x6b/0x100 mm/util.c:421
  kvmalloc include/linux/mm.h:550 [inline]
  kvmalloc_array include/linux/mm.h:566 [inline]
  get_pages_array lib/iov_iter.c:1097 [inline]
  pipe_get_pages_alloc lib/iov_iter.c:1123 [inline]
  iov_iter_get_pages_alloc+0x7be/0x14e0 lib/iov_iter.c:1144
  default_file_splice_read+0x1c7/0xad0 fs/splice.c:390
  do_splice_to+0x12e/0x190 fs/splice.c:880
  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455389
RSP: 002b:00007fd5ef4adc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd5ef4ae6d4 RCX: 0000000000455389
RDX: 0000000020000140 RSI: 0000000000000013 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000015
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
R13: 00000000000004cf R14: 00000000006fa408 R15: 0000000000000002
CPU: 1 PID: 8308 Comm: syz-executor1 Not tainted 4.17.0-rc1+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc_node mm/slab.c:3299 [inline]
  kmem_cache_alloc_node+0x272/0x780 mm/slab.c:3642
  __alloc_skb+0x111/0x780 net/core/skbuff.c:193
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  alloc_skb include/linux/skbuff.h:987 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0xb01/0xfa0 net/netlink/af_netlink.c:1876
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  ___sys_sendmsg+0x805/0x940 net/socket.c:2117
  __sys_sendmsg+0x115/0x270 net/socket.c:2155
  __do_sys_sendmsg net/socket.c:2164 [inline]
  __se_sys_sendmsg net/socket.c:2162 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2162
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455389
RSP: 002b:00007fd1bb0a4c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fd1bb0a56d4 RCX: 0000000000455389
RDX: 0000000000000000 RSI: 0000000020023000 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000014
R13: 00000000000004f8 R14: 00000000006fa7e0 R15: 0000000000000000
CPU: 0 PID: 8314 Comm: syz-executor2 Not tainted 4.17.0-rc1+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc_node mm/slab.c:3299 [inline]
  kmem_cache_alloc_node_trace+0x26f/0x770 mm/slab.c:3661
  __do_kmalloc_node mm/slab.c:3681 [inline]
  __kmalloc_node+0x33/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:554 [inline]
  kvmalloc_node+0x6b/0x100 mm/util.c:421
  kvmalloc include/linux/mm.h:550 [inline]
  seq_buf_alloc fs/seq_file.c:32 [inline]
  seq_read+0xa33/0x1520 fs/seq_file.c:211
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_iter_read+0x4a3/0x660 fs/read_write.c:924
  vfs_readv+0x14f/0x1a0 fs/read_write.c:986
  kernel_readv fs/splice.c:361 [inline]
  default_file_splice_read+0x514/0xad0 fs/splice.c:416
  do_splice_to+0x12e/0x190 fs/splice.c:880
  splice_direct_to_actor+0x268/0x8d0 fs/splice.c:952
  do_splice_direct+0x2cc/0x400 fs/splice.c:1061
  do_sendfile+0x60f/0xe00 fs/read_write.c:1440
  __do_sys_sendfile64 fs/read_write.c:1495 [inline]
  __se_sys_sendfile64 fs/read_write.c:1487 [inline]
  __x64_sys_sendfile64+0x155/0x240 fs/read_write.c:1487
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455389
RSP: 002b:00007fd5ef4adc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fd5ef4ae6d4 RCX: 0000000000455389
RDX: 0000000020000140 RSI: 0000000000000013 RDI: 0000000000000014
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000015
R13: 00000000000004cf R14: 00000000006fa408 R15: 0000000000000003
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 8340 Comm: syz-executor2 Not tainted 4.17.0-rc1+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x1a lib/fault-inject.c:149
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1522
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc_trace+0x4b/0x780 mm/slab.c:3618
  kmalloc include/linux/slab.h:512 [inline]
  __memcg_schedule_kmem_cache_create mm/memcontrol.c:2195 [inline]
  memcg_schedule_kmem_cache_create mm/memcontrol.c:2223 [inline]
  memcg_kmem_get_cache+0x474/0x870 mm/memcontrol.c:2285
  slab_pre_alloc_hook mm/slab.h:428 [inline]
  slab_alloc_node mm/slab.c:3299 [inline]
  kmem_cache_alloc_node_trace+0x1a4/0x770 mm/slab.c:3661
  __do_kmalloc_node mm/slab.c:3681 [inline]
  __kmalloc_node+0x33/0x70 mm/slab.c:3689
  kmalloc_node include/linux/slab.h:554 [inline]
  kvmalloc_node+0x6b/0x100 mm/util.c:421
  kvmalloc include/linux/mm.h:550 [inline]
  seq_buf_alloc fs/seq_file.c:32 [inline]
  seq_read+0xa33/0x1520 fs/seq_file.c:211
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_iter_read+0x4a3/0x660 fs/read_write.c:924
  vfs_readv+0x14f/0x1a0 fs/read_write.c:986
  kernel_readv fs/splice.c:361 [inline]
  default_file_splice_read+0x514/0xad0 fs/splice.c:416
  do_splice_to+0x12e/0x190 fs/splice.c:880


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
