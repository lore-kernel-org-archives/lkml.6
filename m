Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34AC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3491220842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3491220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeJOLs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 07:48:29 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:34467 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOLs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 07:48:29 -0400
Received: by mail-it1-f199.google.com with SMTP id p20-v6so19098265itg.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xJiC40V0bK84tSaOC1OCqlkTi3RnBuB0gaDonGc29kI=;
        b=TRzwFhGy4o8uSbX0g+/SZtp1biuCfmAJUWfMTLx2ye9Eq1DZYC7SYxurDhDbV0Dx13
         8xOyetiSNcv5QsMRmKydLYaLDhS1/Z5SwqGSf0dg3xuP0flnkA8RARVn59DSX6/eGcJC
         SVwJcF704PUM4TYeqAlRtz7ENKFfwCJ4VwBx/zdEdN9oY5clBLhMr96sL887jK1Llbp6
         7Wxi3yO/mRJEfGpV9tSrUA7oSSHJP1hQPOPGmYQWfKF5T8u8Dr6FFfjBHwLv3epkiJPh
         rZBJUb4W01wXuA/AnvtX+x/4ziX/x6ykySxGOx15zTsoaBmHmQfm81ZI8g4/gyH7s44P
         TMUg==
X-Gm-Message-State: ABuFfohvuSCbwXOmdK1IQsuwvzJ5B70e2XbGxs9SgO/NuMfHNkmM3e9i
        bz+KHPcinFaR83Y6UL8oQpwGgzxaHjEx9A2/Q21iP1owpNI0
X-Google-Smtp-Source: ACcGV62hsn1V+1dYESiECt09rxIHsQrp4Z+CsIBb07pUjCYChJs99WPdodRnf7iRq5WRVPGZyKaDfBbSM6kMo3DK7z9FEk3/mSDf
MIME-Version: 1.0
X-Received: by 2002:a5e:9514:: with SMTP id r20-v6mr12206149ioj.39.1539576304075;
 Sun, 14 Oct 2018 21:05:04 -0700 (PDT)
Date:   Sun, 14 Oct 2018 21:05:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5911105783c8a39@google.com>
Subject: possible deadlock in percpu_down_write
From:   syzbot <syzbot+7bf81a3e18fab8a61966@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ec21823634d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ceda09400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf81a3e18fab8a61966
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7bf81a3e18fab8a61966@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc7+ #282 Not tainted
------------------------------------------------------
syz-executor4/9907 is trying to acquire lock:
000000003db358c5 (&dup_mmap_sem){++++}, at: percpu_down_write+0xaf/0x540  
kernel/locking/percpu-rwsem.c:145

but task is already holding lock:
000000003d2ff532 (&uprobe->register_rwsem){+.+.}, at: __uprobe_register  
kernel/events/uprobes.c:922 [inline]
000000003d2ff532 (&uprobe->register_rwsem){+.+.}, at:  
uprobe_register+0x3dd/0x7c0 kernel/events/uprobes.c:941

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&uprobe->register_rwsem){+.+.}:
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        __uprobe_register kernel/events/uprobes.c:922 [inline]
        uprobe_register+0x3dd/0x7c0 kernel/events/uprobes.c:941
        probe_event_enable+0x5f5/0xf30 kernel/trace/trace_uprobe.c:908
        trace_uprobe_register+0x4c9/0xcf0 kernel/trace/trace_uprobe.c:1193
        perf_trace_event_reg kernel/trace/trace_event_perf.c:124 [inline]
        perf_trace_event_init+0x50b/0x990 kernel/trace/trace_event_perf.c:199
        perf_uprobe_init+0x1e5/0x280 kernel/trace/trace_event_perf.c:328
        perf_uprobe_event_init+0xff/0x190 kernel/events/core.c:8474
        perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9741
        perf_init_event kernel/events/core.c:9772 [inline]
        perf_event_alloc.part.93+0x23e6/0x35f0 kernel/events/core.c:10045
        perf_event_alloc kernel/events/core.c:10401 [inline]
        __do_sys_perf_event_open+0xa9c/0x2f30 kernel/events/core.c:10502
        __se_sys_perf_event_open kernel/events/core.c:10391 [inline]
        __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10391
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (event_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:236
        tp_perf_event_destroy+0x15/0x20 kernel/events/core.c:8336
        _free_event+0x414/0x1610 kernel/events/core.c:4446
        put_event+0x48/0x60 kernel/events/core.c:4532
        perf_mmap_close+0x62f/0x1220 kernel/events/core.c:5515
        remove_vma+0xb1/0x180 mm/mmap.c:181
        remove_vma_list mm/mmap.c:2550 [inline]
        do_munmap+0x72d/0xf50 mm/mmap.c:2786
        mmap_region+0x6a4/0x1cd0 mm/mmap.c:1705
        do_mmap+0xa22/0x1230 mm/mmap.c:1535
        do_mmap_pgoff include/linux/mm.h:2298 [inline]
        vm_mmap_pgoff+0x213/0x2c0 mm/util.c:357
        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&mm->mmap_sem){++++}:
        down_write_killable+0x8d/0x150 kernel/locking/rwsem.c:84
        dup_mmap kernel/fork.c:431 [inline]
        dup_mm kernel/fork.c:1274 [inline]
        copy_mm kernel/fork.c:1329 [inline]
        copy_process+0x3648/0x8780 kernel/fork.c:1869
        _do_fork+0x1cb/0x11d0 kernel/fork.c:2166
        __do_sys_clone kernel/fork.c:2273 [inline]
        __se_sys_clone kernel/fork.c:2267 [inline]
        __x64_sys_clone+0xbf/0x150 kernel/fork.c:2267
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&dup_mmap_sem){++++}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        percpu_down_write+0xaf/0x540 kernel/locking/percpu-rwsem.c:145
        register_for_each_vma+0xa0/0xee0 kernel/events/uprobes.c:797
        __uprobe_register kernel/events/uprobes.c:926 [inline]
        uprobe_register+0x47c/0x7c0 kernel/events/uprobes.c:941
        probe_event_enable+0x5f5/0xf30 kernel/trace/trace_uprobe.c:908
        trace_uprobe_register+0x4c9/0xcf0 kernel/trace/trace_uprobe.c:1193
        perf_trace_event_reg kernel/trace/trace_event_perf.c:124 [inline]
        perf_trace_event_init+0x50b/0x990 kernel/trace/trace_event_perf.c:199
        perf_uprobe_init+0x1e5/0x280 kernel/trace/trace_event_perf.c:328
        perf_uprobe_event_init+0xff/0x190 kernel/events/core.c:8474
        perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9741
        perf_init_event kernel/events/core.c:9772 [inline]
        perf_event_alloc.part.93+0x23e6/0x35f0 kernel/events/core.c:10045
        perf_event_alloc kernel/events/core.c:10401 [inline]
        __do_sys_perf_event_open+0xa9c/0x2f30 kernel/events/core.c:10502
        __se_sys_perf_event_open kernel/events/core.c:10391 [inline]
        __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10391
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &dup_mmap_sem --> event_mutex --> &uprobe->register_rwsem

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&uprobe->register_rwsem);
                                lock(event_mutex);
                                lock(&uprobe->register_rwsem);
   lock(&dup_mmap_sem);

  *** DEADLOCK ***

4 locks held by syz-executor4/9907:
  #0: 000000006bd41ed2 (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0x12fe/0x2f30 kernel/events/core.c:10482
  #1: 00000000c3cef6b0 (&pmus_srcu){....}, at: fdput include/linux/file.h:42  
[inline]
  #1: 00000000c3cef6b0 (&pmus_srcu){....}, at: perf_cgroup_connect  
kernel/events/core.c:925 [inline]
  #1: 00000000c3cef6b0 (&pmus_srcu){....}, at:  
perf_event_alloc.part.93+0x18a1/0x35f0 kernel/events/core.c:10040
  #2: 000000005feb8cff (event_mutex){+.+.}, at: perf_uprobe_init+0x1da/0x280  
kernel/trace/trace_event_perf.c:327
  #3: 000000003d2ff532 (&uprobe->register_rwsem){+.+.}, at:  
__uprobe_register kernel/events/uprobes.c:922 [inline]
  #3: 000000003d2ff532 (&uprobe->register_rwsem){+.+.}, at:  
uprobe_register+0x3dd/0x7c0 kernel/events/uprobes.c:941

stack backtrace:
CPU: 0 PID: 9907 Comm: syz-executor4 Not tainted 4.19.0-rc7+ #282
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.33.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1861 [inline]
  check_prevs_add kernel/locking/lockdep.c:1974 [inline]
  validate_chain kernel/locking/lockdep.c:2415 [inline]
  __lock_acquire+0x33e4/0x4ec0 kernel/locking/lockdep.c:3411
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  down_write+0x8a/0x130 kernel/locking/rwsem.c:70
  percpu_down_write+0xaf/0x540 kernel/locking/percpu-rwsem.c:145
  register_for_each_vma+0xa0/0xee0 kernel/events/uprobes.c:797
  __uprobe_register kernel/events/uprobes.c:926 [inline]
  uprobe_register+0x47c/0x7c0 kernel/events/uprobes.c:941
  probe_event_enable+0x5f5/0xf30 kernel/trace/trace_uprobe.c:908
  trace_uprobe_register+0x4c9/0xcf0 kernel/trace/trace_uprobe.c:1193
  perf_trace_event_reg kernel/trace/trace_event_perf.c:124 [inline]
  perf_trace_event_init+0x50b/0x990 kernel/trace/trace_event_perf.c:199
  perf_uprobe_init+0x1e5/0x280 kernel/trace/trace_event_perf.c:328
  perf_uprobe_event_init+0xff/0x190 kernel/events/core.c:8474
  perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9741
  perf_init_event kernel/events/core.c:9772 [inline]
  perf_event_alloc.part.93+0x23e6/0x35f0 kernel/events/core.c:10045
  perf_event_alloc kernel/events/core.c:10401 [inline]
  __do_sys_perf_event_open+0xa9c/0x2f30 kernel/events/core.c:10502
  __se_sys_perf_event_open kernel/events/core.c:10391 [inline]
  __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10391
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbbcbb44c78 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 00007fbbcbb456d4
R13: 00000000004c2f7c R14: 00000000004d4818 R15: 00000000ffffffff
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'input16' (00000000b196811a): kobject_cleanup, parent            
(null)
kobject: 'input16' (00000000b196811a): calling ktype release
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'input16': free name
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'serio3' (0000000052b87646): kobject_add_internal:  
parent: 'devices', set: 'devices'
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'serio3' (0000000052b87646): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'serio3' (0000000052b87646): fill_kobj_path: path  
= '/devices/serio3'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'input17' (0000000039d05571): kobject_cleanup, parent            
(null)
kobject: 'input17' (0000000039d05571): calling ktype release
kobject: 'input17': free name
kobject: 'input18' (00000000a9a434f8): kobject_cleanup, parent            
(null)
kobject: 'input18' (00000000a9a434f8): calling ktype release
kobject: 'input18': free name
kobject: 'serio2' (000000005b4912c2): kobject_uevent_env
kobject: 'serio2' (000000005b4912c2): fill_kobj_path: path  
= '/devices/serio2'
kobject: 'serio2' (000000005b4912c2): kobject_cleanup, parent            
(null)
kobject: 'serio2' (000000005b4912c2): calling ktype release
kobject: 'serio2': free name
kobject: 'serio3' (0000000052b87646): kobject_uevent_env
kobject: 'serio3' (0000000052b87646): fill_kobj_path: path  
= '/devices/serio3'
kobject: 'serio3' (0000000052b87646): kobject_cleanup, parent            
(null)
kobject: 'serio3' (0000000052b87646): calling ktype release
kobject: 'serio3': free name
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'nullb0' (00000000a448ce71): kobject_uevent_env
kobject: 'nullb0' (00000000a448ce71): fill_kobj_path: path  
= '/devices/virtual/block/nullb0'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop0' (000000009a170905): kobject_uevent_env
kobject: 'loop0' (000000009a170905): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000761a47af): kobject_uevent_env
kobject: 'loop1' (00000000761a47af): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000f1a88a52): kobject_uevent_env
kobject: 'loop3' (00000000f1a88a52): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop2' (00000000ebdc5361): kobject_uevent_env
kobject: 'loop2' (00000000ebdc5361): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop4' (00000000423f8963): kobject_uevent_env
kobject: 'loop4' (00000000423f8963): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (0000000061b48517): kobject_uevent_env
kobject: 'loop5' (0000000061b48517): fill_kobj_path: path  
= '/devices/virtual/block/loop5'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
