Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B4FC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB5321986
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB5321986
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHKLcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 07:32:35 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:33664 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 07:32:35 -0400
Received: by mail-io0-f199.google.com with SMTP id s14-v6so9037924ioc.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=i28oY4LUjc5jmWoDvJ/BmpSuCWDUqLmi+2ahq4UwFNE=;
        b=JbJ62saEXivYywC/80haXDixOAbg+HdxQ0YaAXGQYqQ2a8T6dXVs1pDa/rSi4/rFyJ
         v9Z+SwU0SM6UIiDzPuGxbVOJzErbSHzGogoDKDf6OkOe/vb9cE0AwlpQ/hhWyByJwrVc
         RKjsGW4GXRzeZyQ/zXGxksljI7LqB7TnDgivKM1UwvS4lmyCqbwKyQkG4qyD6oCnJCrn
         D/iOXs30kVU6lcqYuyNQvHcyeRchnipbh7enFmaa5RMd3ZQDn6IZHzWBn80O2BipoOnw
         8PpELc+rwTqOld5+9KLkfqVspn5KK8WGYazJFA1yfLity8t/sZPL3S5xckWZabDRBhFl
         UinQ==
X-Gm-Message-State: AOUpUlGR/3ZSly62h7jecUkjZ/8Id1P2FzzJcjpzWPZzUJahZ+qk+eS+
        vycV9apk+ptlmFldfIREWpzodx5zMgwaF7+EX5T0Vq+FNTGG
X-Google-Smtp-Source: AA+uWPwZScvspYWwavc3jaC+Hfs6JvixKzgemp3/SXGVCRsSLNwIWP3exjpTImhISu2g3EO9aQ1Vb6gDnJzMyCSOazZYhYR4pv21
MIME-Version: 1.0
X-Received: by 2002:a24:d51:: with SMTP id 78-v6mr2649955itx.7.1533977943533;
 Sat, 11 Aug 2018 01:59:03 -0700 (PDT)
Date:   Sat, 11 Aug 2018 01:59:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006af1a90573251240@google.com>
Subject: general protection fault in kvm_lapic_hv_timer_in_use
From:   syzbot <syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com>
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

HEAD commit:    8c8399e0a3fb Add linux-next specific files for 20180806
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1796b8e2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6bc1781e49e93e
dashboard link: https://syzkaller.appspot.com/bug?extid=1c69d94fe42901b029c1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1c69d94fe42901b029c1@syzkaller.appspotmail.com

RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ce2d8 R14: 00000000004c4c6d R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 27598 Comm: syz-executor2 Not tainted 4.18.0-rc8-next-20180806+  
#32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_lapic_hv_timer_in_use+0x56/0xd0 arch/x86/kvm/lapic.c:1569
Code: c1 ea 03 80 3c 02 00 75 7a 48 8b 9b e0 03 00 00 e8 4f ec 64 00 48 8d  
7b 7c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 5b 7c
RSP: 0018:ffff880196037398 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90006a2a000
RDX: 000000000000000f RSI: ffffffff81182bc1 RDI: 000000000000007c
RBP: ffff8801960373a0 R08: ffff8801ae9f0140 R09: ffffed0033772ba4
R10: ffffed0033772ba4 R11: ffff88019bb95d27 R12: 0000000000000001
R13: 1ffff10032c06e7a R14: ffff88019bb90260 R15: 0000000000000000
FS:  00007f9e4c576700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000015447d0 CR3: 00000001b6019000 CR4: 00000000001426e0
Call Trace:
  kvm_arch_vcpu_load+0x4fa/0x940 arch/x86/kvm/x86.c:3103
  kvm_sched_in+0x82/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3975
  __fire_sched_in_preempt_notifiers kernel/sched/core.c:2481 [inline]
  fire_sched_in_preempt_notifiers kernel/sched/core.c:2487 [inline]
  finish_task_switch+0x50d/0x870 kernel/sched/core.c:2679
  context_switch kernel/sched/core.c:2826 [inline]
  __schedule+0x884/0x1ec0 kernel/sched/core.c:3471
  preempt_schedule_common+0x22/0x60 kernel/sched/core.c:3595
  _cond_resched+0x1d/0x30 kernel/sched/core.c:4961
  slab_pre_alloc_hook mm/slab.h:421 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc_trace+0x2c1/0x780 mm/slab.c:3618
  kmalloc include/linux/slab.h:513 [inline]
  kzalloc include/linux/slab.h:707 [inline]
  kvm_create_vm_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:613  
[inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3214  
[inline]
  kvm_dev_ioctl+0xc37/0x1b10 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3241
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456cb9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9e4c575c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9e4c5766d4 RCX: 0000000000456cb9
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000018
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ce2d8 R14: 00000000004c4c6d R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 33ef5bcbdea594e3 ]---
RIP: 0010:kvm_lapic_hv_timer_in_use+0x56/0xd0 arch/x86/kvm/lapic.c:1569
Code: c1 ea 03 80 3c 02 00 75 7a 48 8b 9b e0 03 00 00 e8 4f ec 64 00 48 8d  
7b 7c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 5b 7c
RSP: 0018:ffff880196037398 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90006a2a000
RDX: 000000000000000f RSI: ffffffff81182bc1 RDI: 000000000000007c
RBP: ffff8801960373a0 R08: ffff8801ae9f0140 R09: ffffed0033772ba4
R10: ffffed0033772ba4 R11: ffff88019bb95d27 R12: 0000000000000001
R13: 1ffff10032c06e7a R14: ffff88019bb90260 R15: 0000000000000000
FS:  00007f9e4c576700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000015447d0 CR3: 00000001b6019000 CR4: 00000000001426e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
