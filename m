Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF09C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2615D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2615D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbeKGLGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:06:16 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:42500 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbeKGLGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:06:15 -0500
Received: by mail-it1-f199.google.com with SMTP id z195-v6so11721943itb.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nzeduqLufxi0WabRb8ixC8yb/f8MuxIkOpJMeB2MkcM=;
        b=GxOBuNqti+qK7Yi6IsviGBUK/3V7yEQuwJ7fsAEZzd26Fys065qRmYhsE0PDX6qLlV
         wqFUgvL+MG1X30orDMqS3b0Nen9yDG9UPDbMpc0cRJz/dT425pOfZ17h8Y/ptugJsDwF
         ///QtIJGdJ4t+xJAZhGozNIj6iFDwm4W9rHKJJSrCLzQrtO2CGtgez1xLpk0L0rrorVw
         eswSZwq53PuDPcX/AweRZ94ZGDbTqFteiburJDBhADZbpspD9S7U2+y/tScWGaGGQsMM
         x/3/bHOtlzZSczVrwvSjC9BBepyE0RROKlUuKckNXYGoFqGfuHHbOE3IjjWxN1BuuR4X
         ylkA==
X-Gm-Message-State: AGRZ1gJm0crDnPVttiBnrZhTCj46RKZRhBHThniOQjgl0Kg31b1SVdk4
        VpCO0XN8Px99IqOL8fuNin1qFdsiU/AGN8xAXVyN9wjHvwcz
X-Google-Smtp-Source: AJdET5dLCLUhrbuw1G7qxlVaDbOO57fLeyG4ZkRnd43qHbEBD/FxedIhz7Ejv3awduUFaBbcozy6YDp9OrT4byu2ju88ainRymKB
MIME-Version: 1.0
X-Received: by 2002:a24:ac6c:: with SMTP id m44-v6mr161421iti.40.1541554685220;
 Tue, 06 Nov 2018 17:38:05 -0800 (PST)
Date:   Tue, 06 Nov 2018 17:38:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a2474057a092bf7@google.com>
Subject: possible deadlock in static_key_slow_dec
From:   syzbot <syzbot+b011e55d1b4c015100d2@syzkaller.appspotmail.com>
To:     ard.biesheuvel@linaro.org, bp@suse.de, jbaron@akamai.com,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    83650fd58a93 Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15122fcb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9384ecb1c973baed
dashboard link: https://syzkaller.appspot.com/bug?extid=b011e55d1b4c015100d2
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b011e55d1b4c015100d2@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.19.0+ #318 Not tainted
------------------------------------------------------
syz-executor3/25522 is trying to acquire lock:
000000009aed6c7d (cpu_hotplug_lock.rw_sem){++++}, at: __static_key_slow_dec  
kernel/jump_label.c:239 [inline]
000000009aed6c7d (cpu_hotplug_lock.rw_sem){++++}, at:  
static_key_slow_dec+0x57/0xa0 kernel/jump_label.c:254

but task is already holding lock:
00000000d2ffe4a1 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0x1b5/0x2c0  
mm/util.c:348

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&mm->mmap_sem){++++}:
        __might_fault+0x15e/0x1e0 mm/memory.c:4360
        _copy_to_user+0x30/0x110 lib/usercopy.c:25
        copy_to_user include/linux/uaccess.h:155 [inline]
        perf_read_group kernel/events/core.c:4776 [inline]
        __perf_read kernel/events/core.c:4843 [inline]
        perf_read+0x7e3/0xa60 kernel/events/core.c:4858
        __vfs_read+0x117/0x9b0 fs/read_write.c:416
        vfs_read+0x17f/0x3c0 fs/read_write.c:452
        ksys_read+0x101/0x260 fs/read_write.c:578
        __do_sys_read fs/read_write.c:588 [inline]
        __se_sys_read fs/read_write.c:586 [inline]
        __x64_sys_read+0x73/0xb0 fs/read_write.c:586
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&cpuctx_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        perf_event_init_cpu+0xd2/0x180 kernel/events/core.c:11679
        perf_event_init+0x519/0x595 kernel/events/core.c:11726
        start_kernel+0x646/0xa2b init/main.c:652
        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (pmus_lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        perf_event_init_cpu+0x2f/0x180 kernel/events/core.c:11673
        cpuhp_invoke_callback+0x35d/0x2100 kernel/cpu.c:167
        cpuhp_up_callbacks kernel/cpu.c:584 [inline]
        _cpu_up+0x290/0x560 kernel/cpu.c:1139
        do_cpu_up+0x1ca/0x210 kernel/cpu.c:1173
        cpu_up+0x18/0x20 kernel/cpu.c:1181
        smp_init+0x1a3/0x1be kernel/smp.c:578
        kernel_init_freeable+0x431/0x6b9 init/main.c:1146
        kernel_init+0x11/0x1ae init/main.c:1071
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

-> #0 (cpu_hotplug_lock.rw_sem){++++}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        cpus_read_lock+0x3e/0xd0 kernel/cpu.c:287
        __static_key_slow_dec kernel/jump_label.c:239 [inline]
        static_key_slow_dec+0x57/0xa0 kernel/jump_label.c:254
        sw_perf_event_destroy+0x8b/0x140 kernel/events/core.c:8172
        _free_event+0x414/0x1660 kernel/events/core.c:4446
        put_event+0x48/0x60 kernel/events/core.c:4532
        perf_mmap_close+0x62f/0x1220 kernel/events/core.c:5515
        remove_vma+0xb1/0x180 mm/mmap.c:181
        remove_vma_list mm/mmap.c:2574 [inline]
        __do_munmap+0x751/0xf80 mm/mmap.c:2817
        do_munmap mm/mmap.c:2825 [inline]
        mmap_region+0x6a7/0x1cd0 mm/mmap.c:1729
        do_mmap+0xa22/0x1230 mm/mmap.c:1559
        do_mmap_pgoff include/linux/mm.h:2320 [inline]
        vm_mmap_pgoff+0x213/0x2c0 mm/util.c:350
        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1609
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   cpu_hotplug_lock.rw_sem --> &cpuctx_mutex --> &mm->mmap_sem

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&mm->mmap_sem);
                                lock(&cpuctx_mutex);
                                lock(&mm->mmap_sem);
   lock(cpu_hotplug_lock.rw_sem);

  *** DEADLOCK ***

1 lock held by syz-executor3/25522:
  #0: 00000000d2ffe4a1 (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0x1b5/0x2c0  
mm/util.c:348

stack backtrace:
CPU: 1 PID: 25522 Comm: syz-executor3 Not tainted 4.19.0+ #318
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  cpus_read_lock+0x3e/0xd0 kernel/cpu.c:287
  __static_key_slow_dec kernel/jump_label.c:239 [inline]
  static_key_slow_dec+0x57/0xa0 kernel/jump_label.c:254
  sw_perf_event_destroy+0x8b/0x140 kernel/events/core.c:8172
  _free_event+0x414/0x1660 kernel/events/core.c:4446
  put_event+0x48/0x60 kernel/events/core.c:4532
  perf_mmap_close+0x62f/0x1220 kernel/events/core.c:5515
  remove_vma+0xb1/0x180 mm/mmap.c:181
  remove_vma_list mm/mmap.c:2574 [inline]
  __do_munmap+0x751/0xf80 mm/mmap.c:2817
  do_munmap mm/mmap.c:2825 [inline]
  mmap_region+0x6a7/0x1cd0 mm/mmap.c:1729
  do_mmap+0xa22/0x1230 mm/mmap.c:1559
  do_mmap_pgoff include/linux/mm.h:2320 [inline]
  vm_mmap_pgoff+0x213/0x2c0 mm/util.c:350
  ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1609
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f217cd7fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 000000000072bfa0 R08: 000000000000000a R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 00007f217cd806d4
R13: 00000000004c2a9d R14: 00000000004d40c0 R15: 00000000ffffffff
kobject: 'loop2' (00000000ca2cc98a): kobject_uevent_env
kobject: 'loop2' (00000000ca2cc98a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000812c9751): kobject_uevent_env
kobject: 'loop4' (00000000812c9751): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (00000000fba26143): kobject_uevent_env
kobject: 'loop0' (00000000fba26143): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (0000000099278ded): kobject_uevent_env
kobject: 'loop3' (0000000099278ded): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (0000000032ae37eb): kobject_uevent_env
kobject: 'loop1' (0000000032ae37eb): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (000000001bc15b41): kobject_uevent_env
kobject: 'loop5' (000000001bc15b41): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000001bc15b41): kobject_uevent_env
kobject: 'loop5' (000000001bc15b41): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000fba26143): kobject_uevent_env
kobject: 'loop0' (00000000fba26143): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000001bc15b41): kobject_uevent_env
kobject: 'loop5' (000000001bc15b41): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000001bc15b41): kobject_uevent_env
kobject: 'loop5' (000000001bc15b41): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000001bc15b41): kobject_uevent_env
kobject: 'loop5' (000000001bc15b41): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop5' (000000001bc15b41): kobject_uevent_env
kobject: 'loop5' (000000001bc15b41): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (00000000fba26143): kobject_uevent_env
kobject: 'loop0' (00000000fba26143): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000812c9751): kobject_uevent_env
kobject: 'loop4' (00000000812c9751): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ca2cc98a): kobject_uevent_env
kobject: 'loop2' (00000000ca2cc98a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (00000000fba26143): kobject_uevent_env
kobject: 'loop0' (00000000fba26143): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (0000000032ae37eb): kobject_uevent_env
kobject: 'loop1' (0000000032ae37eb): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (0000000099278ded): kobject_uevent_env
kobject: 'loop3' (0000000099278ded): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (00000000fba26143): kobject_uevent_env
kobject: 'loop0' (00000000fba26143): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (000000001bc15b41): kobject_uevent_env
kobject: 'loop5' (000000001bc15b41): fill_kobj_path: path  
= '/devices/virtual/block/loop5'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
