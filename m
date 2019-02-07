Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656302190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfBGPHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:07:06 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:38995 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBGPHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:07:06 -0500
Received: by mail-it1-f199.google.com with SMTP id k133so267036ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cCSfg4eNgTTY6CJXC6muoq9RLxe3Recu9IAjM4XX7Ck=;
        b=tWaTPZMhxXT4RnIXtnU65vk8e+/ByEfvWBe0gwY4rhXuGzF3Qn5QHiODYFOS//bRVb
         pDzx2cJYMG/H7K1vXWyTWMDe0MMwsee6NAyHDQtu91771WqbChWwxIB5b3u2/EzyTRhP
         UdRqEvTcrHFh8t+bgv49w+ebV0VqhEm3nWZsEnmQL/WAM0aXExOJaC2oVR9x5YY0c95o
         ohiax9XkibYU+cIGUNRhp62BzZ/PJmpCEIvPPshqZ4qCG6kG7l6NmVqT69jCw4XaCdfZ
         lGOeU/wyCxG0cCySo84GwcYksvYSZXLT4EArZvkZU6QquIlllBIx25Teo5VYdopsIJLk
         X9vg==
X-Gm-Message-State: AHQUAuZVnmoT1ocKSDmTVe2JTyU66FQDpgANJxH2mcRfkk9wa0N9pU7A
        Jc7Nh3ws+DNkL8jbVL9nzOs5scu/THrn52zQRUV0xW8up7+H
X-Google-Smtp-Source: AHgI3IYsCkk9OZHfudi1NrVOef7C8a7+eT3B3+MVGtcGVNcAGjUiZH0pAtMpogUld+cCnyjITzJ0CDChkE5iI/EQYBgvplgNxBDV
MIME-Version: 1.0
X-Received: by 2002:a24:244:: with SMTP id 65mr6552331itu.3.1549552025058;
 Thu, 07 Feb 2019 07:07:05 -0800 (PST)
Date:   Thu, 07 Feb 2019 07:07:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003cadb05814f3284@google.com>
Subject: INFO: rcu detected stall in __perf_sw_event
From:   syzbot <syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com>
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

HEAD commit:    b0314565da2b Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cd5e73400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=a41ac89a0712acde0e84
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1707cd2f400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv0
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (10499 ticks this GP) idle=d02/1/0x4000000000000002  
softirq=13779/13779 fqs=5238
rcu: 	 (t=10500 jiffies g=11657 q=1546)
NMI backtrace for cpu 0
CPU: 0 PID: 9826 Comm: syz-executor0 Not tainted 5.0.0-rc5+ #61
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x183/0x1cf kernel/rcu/tree.c:1211
  print_cpu_stall kernel/rcu/tree.c:1348 [inline]
  check_cpu_stall kernel/rcu/tree.c:1422 [inline]
  rcu_pending kernel/rcu/tree.c:3018 [inline]
  rcu_check_callbacks.cold+0x500/0xa4a kernel/rcu/tree.c:2521
  update_process_times+0x32/0x80 kernel/time/timer.c:1635
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:161
  tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x33e/0xde0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x120/0x570 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:memcpy_erms+0x8/0x10 arch/x86/lib/memcpy_64.S:56
Code: 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5  
89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3 a4 <c3> 0f 1f 80 00  
00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe 7c 35
RSP: 0018:ffff88808fd171b8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff888092eb1798 RBX: 0000000000000868 RCX: 0000000000000000
RDX: 0000000000000010 RSI: ffff88808fd17348 RDI: ffff888092eb17a8
RBP: ffff88808fd171d8 R08: 1ffff110125d62f3 R09: ffffed10125d62f5
R10: ffffed10125d62f4 R11: ffff888092eb17a7 R12: 0000000000000010
R13: ffff888092eb1798 R14: ffff88808fd17338 R15: ffff88808fd17550
  memcpy include/linux/string.h:352 [inline]
  memcpy_common kernel/events/internal.h:172 [inline]
  __output_copy kernel/events/internal.h:176 [inline]
  perf_output_read_group kernel/events/core.c:6114 [inline]
  perf_output_read+0xe16/0x1390 kernel/events/core.c:6147
  perf_output_sample+0x13b9/0x1a90 kernel/events/core.c:6189
  __perf_event_output kernel/events/core.c:6511 [inline]
  perf_event_output_forward+0x150/0x290 kernel/events/core.c:6524
  __perf_event_overflow+0x144/0x360 kernel/events/core.c:7768
  perf_swevent_overflow+0xaa/0x140 kernel/events/core.c:7844
  perf_swevent_event+0x1f7/0x2f0 kernel/events/core.c:7877
  do_perf_sw_event kernel/events/core.c:7985 [inline]
  ___perf_sw_event+0x31c/0x570 kernel/events/core.c:8016
  __perf_sw_event+0x51/0xa0 kernel/events/core.c:8028
  perf_sw_event include/linux/perf_event.h:1054 [inline]
  do_user_addr_fault arch/x86/mm/fault.c:1516 [inline]
  __do_page_fault+0x734/0xd60 arch/x86/mm/fault.c:1541
  do_page_fault+0x71/0x581 arch/x86/mm/fault.c:1572
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20  
arch/x86/lib/copy_user_64.S:181
Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f  
80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f  
1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
RSP: 0018:ffff88808fd17b40 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000340
RDX: 0000000000001000 RSI: 000000002081d000 RDI: ffff88808b047cc0
RBP: ffff88808fd17b78 R08: ffffed1011609000 R09: 0000000000000000
R10: ffffed1011608fff R11: ffff88808b047fff R12: 000000002081c340
R13: ffff88808b047000 R14: 000000002081d340 R15: 00007ffffffff000
  copy_page_from_iter_iovec lib/iov_iter.c:294 [inline]
  copy_page_from_iter+0x324/0x750 lib/iov_iter.c:907
  pipe_write+0x27d/0xfb0 fs/pipe.c:429
  call_write_iter include/linux/fs.h:1863 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x613/0x8e0 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0xea/0x1f0 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f21b6591c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000041395527 RSI: 0000000020000340 RDI: 0000000000000006
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f21b65926d4
R13: 00000000004c3c0e R14: 00000000004dc3a8 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
