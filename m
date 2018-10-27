Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C33C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882112082C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882112082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeJ0Tkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 15:40:41 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:42733 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbeJ0Tkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 15:40:40 -0400
Received: by mail-it1-f197.google.com with SMTP id v125-v6so4402601ita.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 04:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jJdLgqaRa44FTeZu/rYhQuTipyKbeBpbdSEdeYq6yYM=;
        b=nHpzRO17cLDGPlOjX4vT3LMLkY+UmNzQA4lNwNPRpBfV8lZiKTmvUfpJP8dKe5Ey6E
         PDIAfd84DOwx1V7VmKolN6eo4DqtuWHglEsoav/yOUNMHgfram7jyNLXo7+JnMePAbU5
         0XQ5QSzAJxIF8lddIVqAZKK8qFfrSSD1xY0Aol1+pz5GrMbeiw5rN5+en0p5ituTUKUo
         UaTL9wawRRGH8pHWvEJIWwJ7n3OHGWfRfeA5EICERpSjL5OQpjGzIUqURQuqr+w60EoC
         c55LeQWQsB0mOnuj2NB3pcKEGQHIChvBCIgBRgi8rMJcDap60nqtmsMzGLnpcDP7OqqG
         Fq/g==
X-Gm-Message-State: AGRZ1gIBsop33gu1Hd2Ktf5grcdcHJMAqZKFvYmTPwWMfjYrHlKqAsSM
        w8t/iqq1OVBXs9TZSo3LNMC7pYA4pZTxfdB/uSyL9dArPOYW
X-Google-Smtp-Source: AJdET5ft2Gv/6LaoCpttjQwcimIFjzKe87vLBe3r4qR9weOJvatjMeCDOaVqKGBerVVksnGgoUxC2kW+WJtvHdYlNA3g506v24Uk
MIME-Version: 1.0
X-Received: by 2002:a24:7f53:: with SMTP id r80-v6mr5339029itc.2.1540638004369;
 Sat, 27 Oct 2018 04:00:04 -0700 (PDT)
Date:   Sat, 27 Oct 2018 04:00:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa881d057933bcf8@google.com>
Subject: INFO: rcu detected stall in sys_openat
From:   syzbot <syzbot+db57ce8dbd6cd08e0883@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    345671ea0f92 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f51e83400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c0a49d2b5210087
dashboard link: https://syzkaller.appspot.com/bug?extid=db57ce8dbd6cd08e0883
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+db57ce8dbd6cd08e0883@syzkaller.appspotmail.com

__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=f06/1/0x4000000000000002  
softirq=74672/74673 fqs=5167
rcu: 	 (t=10500 jiffies g=105321 q=216)
NMI backtrace for cpu 1
CPU: 1 PID: 30622 Comm: syz-executor0 Not tainted 4.19.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.1+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b3/0x1ed lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:162 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1195
  print_cpu_stall.cold.67+0x1f3/0x3c7 kernel/rcu/tree.c:1334
  check_cpu_stall kernel/rcu/tree.c:1408 [inline]
  rcu_pending kernel/rcu/tree.c:2961 [inline]
  rcu_check_callbacks+0xf3b/0x13f0 kernel/rcu/tree.c:2506
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:801
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:761  
[inline]
RIP: 0010:console_unlock+0xf41/0x1190 kernel/printk/printk.c:2423
Code: 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85 54 02 00 00 48 83 3d 8f be  
cc 07 00 74 72 e8 d8 fb 19 00 48 8b bd b0 fe ff ff 57 9d <0f> 1f 44 00 00  
e9 f3 f2 ff ff e8 c0 fb 19 00 0f 0b e8 b9 fb 19 00
RSP: 0018:ffff880194b16870 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000040000 RBX: 0000000000000200 RCX: ffffc90001e72000
RDX: 0000000000040000 RSI: ffffffff81653de8 RDI: 0000000000000246
RBP: ffff880194b169e0 R08: ffff8801893acf58 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801893ac640 R12: 0000000000000000
R13: ffffffff848c61c0 R14: dffffc0000000000 R15: ffffffff89945010
  vprintk_emit+0x391/0x990 kernel/printk/printk.c:1923
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1965
  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
  printk+0xa7/0xcf kernel/printk/printk.c:1998
  __find_get_block_slow fs/buffer.c:235 [inline]
  __find_get_block.cold.57+0x85/0xff fs/buffer.c:1294
  __getblk_slow fs/buffer.c:1039 [inline]
  __getblk_gfp+0x2b3/0xd50 fs/buffer.c:1320
  __bread_gfp+0x2d/0x310 fs/buffer.c:1354
  sb_bread include/linux/buffer_head.h:307 [inline]
  fat__get_entry+0x5a6/0xa40 fs/fat/dir.c:101
  fat_get_entry fs/fat/dir.c:129 [inline]
  fat_search_long+0x33b/0x1570 fs/fat/dir.c:477
  vfat_find+0x16d/0x1a0 fs/fat/namei_vfat.c:697
  vfat_lookup+0x107/0x640 fs/fat/namei_vfat.c:711
  lookup_open+0x72e/0x1b90 fs/namei.c:3213
  do_last fs/namei.c:3324 [inline]
  path_openat+0x2464/0x5150 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f17e251fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457569
RDX: 0000000000000002 RSI: 0000000020000780 RDI: 0000000000000009
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f17e25206d4
R13: 00000000004c2afe R14: 00000000004d4128 R15: 00000000ffffffff
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
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
__find_g

---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
