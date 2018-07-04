Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11624C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C524A208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C524A208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeGDPJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:09:07 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:54655 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbeGDPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:09:04 -0400
Received: by mail-io0-f197.google.com with SMTP id p12-v6so4428918iog.21
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6/KNVMWVsgu7mSDsRxvOGFJvSOw97q8hgG0BRYcMC6s=;
        b=tx/yGcCmwfsBZYLuV8CGp9vVqGNv03ogfdGAEwxlj8cxSknu77GqRtNPrjhnb9jGWD
         75XIx1JRRQ1ERs8HC//Hqwiqr9lQDoIube3DLFcM5//b7VtEUUNyTAdfD4sGpmgUUW/a
         xu/FAWYXusytAlvMGp8sl0xfSbX4TznhyM5FtwJ1wXlPtDBzYNGnierLeMUZTA1jZCv5
         WlgkLDLXsPG7EKYWPM4ZQ7tJeB4iDYDnvgFpkcmWiX4g1KdhctWV20CSOoHH403Zi5g6
         p7D9919rFbk0LLZouCMB3grPU1yZvl356D19g0XYpaxZHhU2pz+3oNnfb44dcnTjiSrF
         d/Ww==
X-Gm-Message-State: APt69E3SQRMpTU3FiklZvCxgpaL9HlDZJLugOMHYmR+EFj3p3A2eqWzP
        G7j/GTdaIeTOm8kW77Zk/+MV8Ix9BT9aVjCmfVxxv4lqT9Zc
X-Google-Smtp-Source: AAOMgpd/YrUON0RInSIh/HRFtr3bdAe5OFBqnWc4h0wECGIs/WFhbhfJtYvvEQtZKDJTBiF5SvxrcAi/5TSxAfwGf3TH/WkHzoiJ
MIME-Version: 1.0
X-Received: by 2002:a24:6e03:: with SMTP id w3-v6mr1000393itc.55.1530716943866;
 Wed, 04 Jul 2018 08:09:03 -0700 (PDT)
Date:   Wed, 04 Jul 2018 08:09:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0e80905702dcf6f@google.com>
Subject: general protection fault in smap_list_hash_remove
From:   syzbot <syzbot+b912ba691bb508925d72@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=102e5b48400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
dashboard link: https://syzkaller.appspot.com/bug?extid=b912ba691bb508925d72
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=168d1662400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1556a594400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b912ba691bb508925d72@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4454 Comm: syz-executor594 Not tainted 4.18.0-rc3+ #45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54  
53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
RSP: 0018:ffff8801ad3e77c8 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 0000000000000230 RCX: 0000000000000000
RDX: 0000000000000046 RSI: 0000000000000000 RDI: 0000000000000234
RBP: ffff8801ad3e77f0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffed00359b8286 R11: ffff8801acdc1433 R12: dffffc0000000000
R13: ffff8801d8b35540 R14: ffff8801c65bb118 R15: ffff8801c65bb100
FS:  00007f51a93fb700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc4338af60 CR3: 00000001ad3f7000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
  _raw_spin_lock_bh+0x39/0x40 kernel/locking/spinlock.c:168
  spin_lock_bh include/linux/spinlock.h:315 [inline]
  smap_list_hash_remove+0xa3/0x470 kernel/bpf/sockmap.c:1683
  sock_hash_ctx_update_elem.isra.27+0x1140/0x1690 kernel/bpf/sockmap.c:2384
  sock_hash_update_elem+0x157/0x2f0 kernel/bpf/sockmap.c:2418
  map_update_elem+0x5c4/0xc90 kernel/bpf/syscall.c:765
  __do_sys_bpf kernel/bpf/syscall.c:2296 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
  __x64_sys_bpf+0x32d/0x510 kernel/bpf/syscall.c:2267
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445d19
Code: e8 2c b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f51a93face8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000006dac3c RCX: 0000000000445d19
RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
RBP: 00000000006dac38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd36a1e17f R14: 00007f51a93fb9c0 R15: 0000000000000005
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 996d9c1f5fab271a ]---
RIP: 0010:do_raw_spin_lock+0x27/0x200 kernel/locking/spinlock_debug.c:111
Code: 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 41 55 41 54  
53 48 89 fb 48 83 c7 04 48 89 fa 48 c1 ea 03 48 83 ec 08 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7b
RSP: 0018:ffff8801ad3e77c8 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 0000000000000230 RCX: 0000000000000000
RDX: 0000000000000046 RSI: 0000000000000000 RDI: 0000000000000234
RBP: ffff8801ad3e77f0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffed00359b8286 R11: ffff8801acdc1433 R12: dffffc0000000000
R13: ffff8801d8b35540 R14: ffff8801c65bb118 R15: ffff8801c65bb100
FS:  00007f51a93fb700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc4338af60 CR3: 00000001ad3f7000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
