Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031605AbeEZJ3D (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:29:03 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:35739 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031362AbeEZJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:29:02 -0400
X-Google-Smtp-Source: ADUXVKIKeEO+p6JZmDy31GoSCD2jrMSSyY3qhcoS1xa2zR1uWBvtQqBfJHKTDaDmR2A9+sXomtcjKgfNUcorvnjcVNxP0BoBizmO
MIME-Version: 1.0
Date: Sat, 26 May 2018 02:29:01 -0700
In-Reply-To: <0000000000003cdd01056d184e6e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d29a1c056d188355@google.com>
Subject: Re: WARNING in bpf_int_jit_compile
From: syzbot <syzbot+9e762b52dd17e616a7a5@syzkaller.appspotmail.com>
To: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hpa@zytor.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    62d18ecfa641 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c6bf57800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
dashboard link: https://syzkaller.appspot.com/bug?extid=9e762b52dd17e616a7a5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=130e42b7800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9e762b52dd17e616a7a5@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 0000000002542914 RCX: 0000000000455a09
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000046 R14: 00000000006f4730 R15: 0000000000000023
WARNING: CPU: 0 PID: 4752 at include/linux/filter.h:667  
bpf_jit_binary_lock_ro include/linux/filter.h:667 [inline]
WARNING: CPU: 0 PID: 4752 at include/linux/filter.h:667  
bpf_int_jit_compile+0xbf7/0xef7 arch/x86/net/bpf_jit_comp.c:1271
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4752 Comm: syz-executor0 Not tainted 4.17.0-rc6+ #67
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1de/0x490 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:bpf_jit_binary_lock_ro include/linux/filter.h:667 [inline]
RIP: 0010:bpf_int_jit_compile+0xbf7/0xef7 arch/x86/net/bpf_jit_comp.c:1271
RSP: 0018:ffff8801d85ff920 EFLAGS: 00010293
RAX: ffff8801d78c40c0 RBX: 0000000000000046 RCX: ffffffff81445d89
RDX: 0000000000000000 RSI: ffffffff81445d97 RDI: 0000000000000005
RBP: ffff8801d85ffa40 R08: ffff8801d78c40c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000194e002
R13: ffff8801d85ffa18 R14: 00000000fffffff4 R15: 0000000000000003
  bpf_prog_select_runtime+0x131/0x640 kernel/bpf/core.c:1541
  bpf_prog_load+0x16c2/0x2070 kernel/bpf/syscall.c:1333
  __do_sys_bpf kernel/bpf/syscall.c:2073 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2035 [inline]
  __x64_sys_bpf+0x389/0x4c0 kernel/bpf/syscall.c:2035
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a09
RSP: 002b:00007ffec3da2868 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000002542914 RCX: 0000000000455a09
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000046 R14: 00000000006f4730 R15: 0000000000000023
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..
