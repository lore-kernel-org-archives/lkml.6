Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B1C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35FB2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeLXPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:24:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:40800 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:24:05 -0500
Received: by mail-it1-f197.google.com with SMTP id 135so14197861itk.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xEAYSWQ1hsP0eXUW4nUkqD+fMEPun0zyo9SHtlEtiDs=;
        b=MDpNJVuszAhJI5zdedUvbSFeDGymMSJHZCTcyGTBH8mogQ24O+Os4eu6tleSrjT1uw
         n43DO3BBZaCqoYcrbJFCdj2/G7KIQGtJ3ZpXmv3y+zjB5XG37swB3kyekS0LxON2wuUF
         /vTdCE3SrkiYImYPhKjQFtnjvIcE95HF8keEg32u7tb2JsVBToZ2l0wE9grUranO1BxK
         84oiLWP2xikEbDz8L0rvl4y8pzPF3I6KFxNPFhwVWSii17E8toUKOsoL/wP2dSdrJh1v
         442QFpMNsJzOTdsRO7+V9XW0bCQzStDsDBbQvCeLpp/JccuiqgckyJvhXormjHQuSWwQ
         qFxw==
X-Gm-Message-State: AJcUukeQ1YvvTkRWDjuCEEkIGXmC0D14qAtwD+BzX3YgtCLJqCGQsOdU
        l3smDtn+hsyayFOemq43fKkCRoB6JEjdtMcDK6jUKtNR/kfa
X-Google-Smtp-Source: ALg8bN44zWrI3tzjLx/Gt/XseS3FcoQmCgJiGD6WlCJztYrxqpZB/4HXztJ6CFwgEcBdnTrkpm6SKNv2lx0scv5P7Ci/juILQALw
MIME-Version: 1.0
X-Received: by 2002:a5e:8913:: with SMTP id k19mr12622488ioj.7.1545665043910;
 Mon, 24 Dec 2018 07:24:03 -0800 (PST)
Date:   Mon, 24 Dec 2018 07:24:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e259a2057dc62f0d@google.com>
Subject: INFO: rcu detected stall in snd_pcm_oss_read
From:   syzbot <syzbot+fbe0496f92a0ce7b786c@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, anna-maria@linutronix.de,
        bigeasy@linutronix.de, chanho.min@lge.com, diwic@ubuntu.com,
        jmiller@neverware.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3c730b1041ae Merge branch 'fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a6cf1b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a3573f4e78ba1
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe0496f92a0ce7b786c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131fdcdd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1647bf7d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fbe0496f92a0ce7b786c@syzkaller.appspotmail.com

hrtimer: interrupt took 35234 ns
audit: type=1400 audit(1545621421.464:37): avc:  denied  { map } for   
pid=6182 comm="sh" path="/bin/dash" dev="sda1" ino=1473  
scontext=system_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (13423 ticks this GP) idle=6c6/1/0x4000000000000002  
softirq=7663/7665 fqs=5214
rcu: 	 (t=10500 jiffies g=5229 q=6)
NMI backtrace for cpu 0
CPU: 0 PID: 6180 Comm: syz-executor053 Not tainted 4.20.0-rc7+ #165
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1c2/0x22c lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1195
  print_cpu_stall.cold.65+0x1f3/0x3c6 kernel/rcu/tree.c:1334
  check_cpu_stall kernel/rcu/tree.c:1408 [inline]
  rcu_pending kernel/rcu/tree.c:2961 [inline]
  rcu_check_callbacks+0xac1/0x1410 kernel/rcu/tree.c:2506
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__raw_read_unlock_irq include/linux/rwlock_api_smp.h:244 [inline]
RIP: 0010:_raw_read_unlock_irq+0x56/0x80 kernel/locking/spinlock.c:264
Code: 52 89 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00  
75 32 48 83 3d 33 94 7a 01 00 74 1f fb 66 0f 1f 44 00 00 <bf> 01 00 00 00  
e8 d0 c2 7d f9 65 8b 05 69 80 2a 78 85 c0 74 05 5b
RSP: 0018:ffff8881be89f660 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: ffffffff89e89e60 RCX: 1ffff11039b689cc
RDX: 1ffffffff12a4030 RSI: 0000000000000000 RDI: ffffffff89520180
RBP: ffff8881be89f668 R08: ffff8881cdb44e60 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8881cdb445c0 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8881be89f828
  __snd_pcm_stream_unlock_mode+0x125/0x150 sound/core/pcm_native.c:145
  snd_pcm_stream_unlock_irq sound/core/pcm_native.c:202 [inline]
  snd_pcm_delay+0x234/0x380 sound/core/pcm_native.c:2698
  snd_pcm_kernel_ioctl+0x1e0/0x220 sound/core/pcm_native.c:2998
  snd_pcm_oss_capture_position_fixup+0x1a1/0x250  
sound/core/oss/pcm_oss.c:1202
  snd_pcm_oss_read3+0x181/0x410 sound/core/oss/pcm_oss.c:1271
  io_capture_transfer+0x27d/0x310 sound/core/oss/io.c:73
  snd_pcm_plug_read_transfer+0x1d7/0x3b0 sound/core/oss/pcm_plugin.c:651
  snd_pcm_oss_read2+0x221/0x450 sound/core/oss/pcm_oss.c:1474
  snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1512 [inline]
  snd_pcm_oss_read+0x4e4/0x820 sound/core/oss/pcm_oss.c:2752
  __vfs_read+0x117/0x9b0 fs/read_write.c:416
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443ef9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffd155a428 EFLAGS: 00000217 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443ef9
RDX: 0000000000000008 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 00000000004002e0 R11: 0000000000000217 R12: 0000000000401c00
R13: 0000000000401c90 R14: 0000000000000000 R15: 0000000000000000
sched: RT throttling activated


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
