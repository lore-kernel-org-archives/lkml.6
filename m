Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2635C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BEB21727
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BEB21727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeHMPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:21:10 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:44460 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbeHMPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:21:10 -0400
Received: by mail-it0-f70.google.com with SMTP id b124-v6so9115524itb.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6ckZOMiFU/H/yrlIEPAj0J9GxpEkn4ePxmoYIpXLiz8=;
        b=G++U/FGP7ZobkeApCF4hEljhryUdPow1TIVNluvArZ4hXAtXu1OoV3wN05ExYJUfwY
         6mkttM4tG9BVv3oa3ZBT5/wqx+diDAff0MaLkcAT+6rlP6VcM7HQEcxWZsMEyiuA7yRr
         XoCbm71PaP+ahNKPB2vZWEhwCc8kzwLCUL5kDziBfQV0CMJvHgQkjPl91nQbjqz1jX/D
         TS1erytVWSUJwHFBBCm1Y47Jo2fcmGeYbc+XmBEvpJBBfBzfmmfwawNjA9oQfSdkRvYv
         L99k3pI9HHhcN6Fm/gCavgo+l4zkbcb6fhsebGpRhQFJlDprtOS5kfHOV/JVuj0n28DI
         woeA==
X-Gm-Message-State: AOUpUlHpf8jhJzogwsutohcOjsCo/qk1eYzXx0Z2wQXqIXaKyaU4Qvru
        Jvn16cc/GeXnHruhhZQE+UcIiTtSgi74Cb6/YCRC+mviNcnK
X-Google-Smtp-Source: AA+uWPxx9YTP4348SjQsUZCcTtZyhDCsJlo2D3HWvXUhfGjzaymNa6OVyTXKtwdpoi9yLfAOdR/L60NRofPNI8lnYPX6j1k081/s
MIME-Version: 1.0
X-Received: by 2002:a6b:c34e:: with SMTP id t75-v6mr7967850iof.115.1534163943307;
 Mon, 13 Aug 2018 05:39:03 -0700 (PDT)
Date:   Mon, 13 Aug 2018 05:39:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de450605735060bd@google.com>
Subject: general protection fault in send_sigio_to_task
From:   syzbot <syzbot+854a638985e121990c4c@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164fecc4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18edf0289d1b5ab
dashboard link: https://syzkaller.appspot.com/bug?extid=854a638985e121990c4c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1306063c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11eaa122400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+854a638985e121990c4c@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4500 Comm: syz-executor081 Not tainted 4.18.0-next-20180813+ #37
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
RIP: 0010:send_sigio_to_task+0x1ad/0x910 fs/fcntl.c:734
Code: 4c 8d b3 00 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d bf 58 06 00  
00 4c 89 f2 48 c1 ea 03 c6 04 02 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 1a 07 00 00 49 8b 87 58 06 00 00 4c 89 f2 48 c1
RSP: 0018:ffff8801d9b5f878 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801d9b5f9f8 RCX: ffffffff81caeb13
RDX: 00000000000000cb RSI: ffffffff81cae4e3 RDI: 0000000000000658
RBP: ffff8801d9b5fa20 R08: ffff8801acfee500 R09: ffffed003b6246d6
R10: ffffed003b6246d6 R11: ffff8801db1236b3 R12: ffff8801d98e3bc8
R13: 0000000000000000 R14: ffff8801d9b5f8f8 R15: 0000000000000000
FS:  00007fcc7bf1e700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc7bf1de78 CR3: 00000001acdbc000 CR4: 00000000001406e0
Call Trace:
  send_sigio+0x36f/0x4a0 fs/fcntl.c:794
  dnotify_handle_event+0x213/0x360 fs/notify/dnotify/dnotify.c:111
  send_to_group fs/notify/fsnotify.c:234 [inline]
  fsnotify+0x97d/0x14e0 fs/notify/fsnotify.c:374
  fsnotify_access include/linux/fsnotify.h:185 [inline]
  iterate_dir+0x4e3/0x5d0 fs/readdir.c:55
  ksys_getdents64+0x228/0x450 fs/readdir.c:314
  __do_sys_getdents64 fs/readdir.c:333 [inline]
  __se_sys_getdents64 fs/readdir.c:330 [inline]
  __x64_sys_getdents64+0x73/0xb0 fs/readdir.c:330
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4456b9
Code: e8 ec b8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcc7bf1dd18 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00000000006dac48 RCX: 00000000004456b9
RDX: 0000000000001000 RSI: 0000000020001380 RDI: 0000000000000003
RBP: 00000000006dac40 R08: 00007fcc7bf1e700 R09: 0000000000000000
R10: 00007fcc7bf1e700 R11: 0000000000000246 R12: 00000000006dac4c
R13: 00007fcc7bf1dd20 R14: 0000000020000180 R15: 00000000006dad2c
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 9542b2f908ce9cfa ]---
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:sigio_perm fs/fcntl.c:715 [inline]
RIP: 0010:send_sigio_to_task+0x1ad/0x910 fs/fcntl.c:734
Code: 4c 8d b3 00 ff ff ff 48 b8 00 00 00 00 00 fc ff df 49 8d bf 58 06 00  
00 4c 89 f2 48 c1 ea 03 c6 04 02 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 1a 07 00 00 49 8b 87 58 06 00 00 4c 89 f2 48 c1
RSP: 0018:ffff8801d9b5f878 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801d9b5f9f8 RCX: ffffffff81caeb13
RDX: 00000000000000cb RSI: ffffffff81cae4e3 RDI: 0000000000000658
RBP: ffff8801d9b5fa20 R08: ffff8801acfee500 R09: ffffed003b6246d6
R10: ffffed003b6246d6 R11: ffff8801db1236b3 R12: ffff8801d98e3bc8
R13: 0000000000000000 R14: ffff8801d9b5f8f8 R15: 0000000000000000
FS:  00007fcc7bf1e700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc7bf1de78 CR3: 00000001acdbc000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
