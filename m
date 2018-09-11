Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F32C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BE4206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BE4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeIKLJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:09:46 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:58575 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeIKLJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:09:46 -0400
Received: by mail-it0-f71.google.com with SMTP id x15-v6so6019ite.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 23:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rONckUT4Uv0+6WkLOGykl3ETDkZrgJWKyapO3WAD5Xk=;
        b=pp/40JEVx2TQSHqiZ6YI+sKBBKgQozLM0MmhBxk3OYrnrtREaAoPSwiOwgT3spRjTn
         HHT22pXvaUZIhqt8Q5miM6QSE3e6IXL/jOx5YmLUkKnxD8t2DIMPaXzIFc8k5IIhEX6G
         ZbJvaaljf9WlQ7ccc0gV83F06hxsnppwnU58HwcxPOyQ5HFpdH5pdDEIRzXfM0nzzoRv
         BT+9LcHQP2Ilr3vlpGrsyicNNec9h5laGoOyAdz6qg7OUXCE/Jgf49cgltLwIKB7HHvC
         7BIqRsbaNzkZ/eFAqZHP/fh9u1Vsps3wK+xmF6L3EIgATfbSayHepYksxxB9FXQ1OLqg
         wUhg==
X-Gm-Message-State: APzg51Bu7KYxN5kTc/C8q9KROxSWi2oVes8Eo93e0olPoziOaavq6WPs
        EdTr2B/7phVcJhFHxXp4LA8287/oPNrjSd9AR9TJ19ecswU/
X-Google-Smtp-Source: ANB0VdZyb0MvMJIiRxCPFWpDRl6gjPcgtlnvqFBAyry9k/OSkCD2T2BHSR3pnIivqpo+wgmwqZL+93jSVjdNci13xS3odqIs6SXf
MIME-Version: 1.0
X-Received: by 2002:a24:6ecd:: with SMTP id w196-v6mr156617itc.24.1536646324322;
 Mon, 10 Sep 2018 23:12:04 -0700 (PDT)
Date:   Mon, 10 Sep 2018 23:12:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e8a8c0575925aa2@google.com>
Subject: INFO: rcu detected stall in kvm_arch_vcpu_ioctl_run
From:   syzbot <syzbot+b3fdc9590894087f1188@syzkaller.appspotmail.com>
To:     hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d0e7a9e00fd Merge tag 'md/4.19-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12820cd1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=b3fdc9590894087f1188
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16940056400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b3fdc9590894087f1188@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
hrtimer: interrupt took 32920 ns
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=7509, q=466)
rcu: All QSes seen, last rcu_preempt kthread activity 10502  
(4295044073-4295033571), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor7   R  running task    23424  7586   5576 0x00000000
Call Trace:
  <IRQ>
  sched_show_task.cold.83+0x2b6/0x30a kernel/sched/core.c:5296
  print_other_cpu_stall.cold.79+0xa83/0xba5 kernel/rcu/tree.c:1430
  check_cpu_stall kernel/rcu/tree.c:1557 [inline]
  __rcu_pending kernel/rcu/tree.c:3276 [inline]
  rcu_pending kernel/rcu/tree.c:3319 [inline]
  rcu_check_callbacks+0xafc/0x1990 kernel/rcu/tree.c:2665
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
  </IRQ>
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:798 [inline]
RIP: 0010:vcpu_enter_guest+0x12ad/0x62e0 arch/x86/kvm/x86.c:7610
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b7 4a 00 00 48 83 3d bd 8c 43 08  
00 0f 84 b1 3d 00 00 e8 3a 32 70 00 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00  
e8 09 cf 46 00 31 ff 65 44 8b 25 af 50 f3 7e 44 89
RSP: 0018:ffff8801b116f4f0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801cd182680 RBX: ffff8801d97f8080 RCX: 1ffff10039a305e4
RDX: 0000000000000000 RSI: ffffffff810e9d06 RDI: ffffffff895229b8
RBP: ffff8801b116f840 R08: ffff8801cd182f20 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801cd182680 R12: ffff8801cd182680
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  vcpu_run arch/x86/kvm/x86.c:7693 [inline]
  kvm_arch_vcpu_ioctl_run+0x375/0x16e0 arch/x86/kvm/x86.c:7870
  kvm_vcpu_ioctl+0x72b/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdfe480958 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000001598914 RCX: 0000000000457099
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cf730 R14: 00000000004c59b9 R15: 0000000000000000
rcu: rcu_preempt kthread starved for 10502 jiffies! g7509 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    22872    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
  rcu_gp_kthread+0x9d9/0x2310 kernel/rcu/tree.c:2194
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
