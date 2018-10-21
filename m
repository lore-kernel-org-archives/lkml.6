Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D412ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278542083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278542083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJUPXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 11:23:24 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38421 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeJUPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 11:23:23 -0400
Received: by mail-io1-f69.google.com with SMTP id n10-v6so23950110iog.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 00:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Tmh8AmXbRvIMVN1wTKekw4TwqzhUYXr/fgd8avL1sdU=;
        b=UVPAJMRYzKupIWG+SLCUCtaSb33lBBQdpZEKdXQriuNqXKJD1/RNA5a5AeRBh+PrRZ
         M7R8W+Y6dWx9LES1CuReXMeBfxQXRV+ymq9Frm65LNUKHWBSUF0VeFo1iBwwcCBKO8QA
         12Lf0gqqI04JoUymvRHQeePzKlnMl7ryYR9Pz53DzMMu9l8zqy0m2TXab/hn7n0i7cEt
         Ubi34NjJP0NDwkwlYG64u6qUTEsOE79vAvYUz1bCwHU75udP2R8aGbuHWcbYGUwzZz80
         9co75NEpb4uFhufiIQGwWDRJBuw00dEJwNepJINejyQJCGJFvwupZLRAAgaFvAxeHd5p
         uxyA==
X-Gm-Message-State: ABuFfoiSUAuwyqV6KTmnov00RNW90MB+K+dktwUGecxjJL56a34T0fIr
        /6wE8TSC2EEPtkvrFAhUOjvVWrfaQuA7/qEIr4uRapIEbMfz
X-Google-Smtp-Source: ACcGV6376N/yaFg8S8FUKyrxs28VMaz+mEpdxvMK0hbpc5V208/L2fkuY28bP1Dz7HpXtqTJhkLd1sECI2G7ZJCp5kCWXTQTHfpU
MIME-Version: 1.0
X-Received: by 2002:a02:58c:: with SMTP id 12-v6mr34251719jal.19.1540105802676;
 Sun, 21 Oct 2018 00:10:02 -0700 (PDT)
Date:   Sun, 21 Oct 2018 00:10:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004904df0578b7d3da@google.com>
Subject: KASAN: use-after-free Read in task_is_descendant
From:   syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>
To:     jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    270b77a0f30e Merge tag 'drm-fixes-2018-10-20-1' of git://a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116f4ad9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3f55cb3dfcc6c33
dashboard link: https://syzkaller.appspot.com/bug?extid=a9ac39bf55329e206219
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com

binder: 12719:12721 got transaction to context manager from process owning  
it
binder: BINDER_SET_CONTEXT_MGR already set
binder: 12719:12724 ioctl 40046207 0 returned -16
binder: 12719:12721 BC_ACQUIRE_DONE u0000000000000000 no match
==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:188  
[inline]
BUG: KASAN: use-after-free in task_is_descendant.part.2+0x610/0x670  
security/yama/yama_lsm.c:295
Read of size 8 at addr ffff8801c4666b20 by task syz-executor3/12722

CPU: 1 PID: 12722 Comm: syz-executor3 Not tainted 4.19.0-rc8+ #70
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:188 [inline]
  task_is_descendant.part.2+0x610/0x670 security/yama/yama_lsm.c:295
  task_is_descendant security/yama/yama_lsm.c:282 [inline]
  yama_ptrace_access_check+0x215/0x10fc security/yama/yama_lsm.c:371
  security_ptrace_access_check+0x54/0xb0 security/security.c:260
  __ptrace_may_access+0x564/0x950 kernel/ptrace.c:331
  ptrace_attach+0x1fa/0x640 kernel/ptrace.c:379
  __do_sys_ptrace kernel/ptrace.c:1130 [inline]
  __se_sys_ptrace kernel/ptrace.c:1110 [inline]
  __x64_sys_ptrace+0x229/0x260 kernel/ptrace.c:1110
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7df12c4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000265 RDI: 0000000000000010
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7df12c56d4
R13: 00000000004c30c5 R14: 00000000004d4ab8 R15: 00000000ffffffff

Allocated by task 8920:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc_node+0x144/0x730 mm/slab.c:3644
  alloc_task_struct_node kernel/fork.c:157 [inline]
  dup_task_struct kernel/fork.c:802 [inline]
  copy_process+0x1ff4/0x8780 kernel/fork.c:1707
  _do_fork+0x1cb/0x11d0 kernel/fork.c:2166
  __do_sys_clone kernel/fork.c:2273 [inline]
  __se_sys_clone kernel/fork.c:2267 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2267
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 18:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3756
  free_task_struct kernel/fork.c:162 [inline]
  free_task+0x16e/0x1f0 kernel/fork.c:416
  __put_task_struct+0x2e6/0x620 kernel/fork.c:689
  put_task_struct include/linux/sched/task.h:96 [inline]
  delayed_put_task_struct+0x2ff/0x4c0 kernel/exit.c:181
  __rcu_reclaim kernel/rcu/rcu.h:236 [inline]
  rcu_do_batch kernel/rcu/tree.c:2576 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2880 [inline]
  __rcu_process_callbacks kernel/rcu/tree.c:2847 [inline]
  rcu_process_callbacks+0xf23/0x2670 kernel/rcu/tree.c:2864
  __do_softirq+0x30b/0xad8 kernel/softirq.c:292

The buggy address belongs to the object at ffff8801c4666640
  which belongs to the cache task_struct(65:syz3) of size 6080
The buggy address is located 1248 bytes inside of
  6080-byte region [ffff8801c4666640, ffff8801c4667e00)
The buggy address belongs to the page:
page:ffffea0007119980 count:1 mapcount:0 mapping:ffff8801c2336800 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea00070a0008 ffffea0006080688 ffff8801c2336800
raw: 0000000000000000 ffff8801c4666640 0000000100000001 ffff8801bdb40c00
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801bdb40c00

Memory state around the buggy address:
  ffff8801c4666a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c4666a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801c4666b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                ^
  ffff8801c4666b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801c4666c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
