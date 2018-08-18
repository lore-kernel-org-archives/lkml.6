Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EEDC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FAD20BF2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FAD20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeHRTeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:34:19 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:39291 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeHRTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:34:19 -0400
Received: by mail-it0-f71.google.com with SMTP id w196-v6so10178914itb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 09:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hll8hmk2OPtJVmffUA4Y4VIt1S//jS6k4robje7okYo=;
        b=Oi2vXXLEBTEiLOzEOAP9+r3BG9yxB95Yh9aawLI4GvSN79kLPGJzaC2mwQLA7AwfBI
         6B16FnIJbeOMikeS5HNrl0XfT4Djufnyg+94N5tNhS+xuurnTSxLy0cQWjL8j2NkUMo5
         o91aBzMnWoTI8/RgZNqPspBpkRem0vFB5XQuG48otw1YRQZoqyvPU6OI8+szMJRzVpQZ
         Gl58RfPabu+X7lYCq32C9Cf3ekirW8KeKN9R+hXoAUs1q6dqjKidkQ7sS/QUWfWs16s0
         btDpbk3bSB/Witq2xMLsQA3jzkArP2PBjBTPS54x58MhWyj3LBRgPLJz8IYUYqEO+zo2
         GVhw==
X-Gm-Message-State: AOUpUlEUTzutjj9If/0OZ7mwp8/dgATWqtME5wG0JLr2Kc8PKpqDdbgW
        krGneeiaQt5RI8+0l04xugVyMJamcdP8tme8xREpVM8qDegZ
X-Google-Smtp-Source: AA+uWPw1cpd8gN4pWe0jIP5USWJ6/rZVzMN1cPeafGXhL0a50rkpPFJ0SbyFF+FUzYkr1rCOvahRfTpt8CGZDYFQlQOQJnkiNTuO
MIME-Version: 1.0
X-Received: by 2002:a24:ca:: with SMTP id 193-v6mr16727181ita.45.1534609562894;
 Sat, 18 Aug 2018 09:26:02 -0700 (PDT)
Date:   Sat, 18 Aug 2018 09:26:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd8b740573b821ec@google.com>
Subject: WARNING in __fsnotify_recalc_mask
From:   syzbot <syzbot+c34692a51b9a6ca93540@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1f7a4c73a739 Merge tag '9p-for-4.19-2' of git://github.com..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cccef2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e80edb3c9718c5
dashboard link: https://syzkaller.appspot.com/bug?extid=c34692a51b9a6ca93540
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11c12e86400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c34692a51b9a6ca93540@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
WARNING: CPU: 1 PID: 12015 at fs/notify/mark.c:139  
__fsnotify_recalc_mask+0x2d7/0x350 fs/notify/mark.c:139
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 12015 Comm: syz-executor0 Not tainted 4.18.0+ #195
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:__fsnotify_recalc_mask+0x2d7/0x350 fs/notify/mark.c:139
Code: 90 00 00 00 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 eb 2d a2  
ff 49 83 ec 04 eb 82 e8 e0 2d a2 ff 0f 0b e8 d9 2d a2 ff <0f> 0b eb a5 e8  
60 24 e1 ff e9 11 ff ff ff 48 89 df e8 f3 24 e1 ff
RSP: 0018:ffff8801b509f5c8 EFLAGS: 00010293
RAX: ffff8801b2c0a180 RBX: 0000000000000002 RCX: ffffffff81dabc96
RDX: 0000000000000000 RSI: ffffffff81dabd67 RDI: 0000000000000005
RBP: ffff8801b509f658 R08: ffff8801b2c0a180 R09: ffffed00398cb796
R10: ffffed00398cb796 R11: ffff8801cc65bcb3 R12: dffffc0000000000
R13: ffff8801cc65bcb0 R14: 0000000000000000 R15: 0000000000000000
  fsnotify_put_mark+0x523/0xab0 fs/notify/mark.c:240
  fsnotify_destroy_marks+0x2d1/0x5c0 fs/notify/mark.c:741
  fsnotify_clear_marks_by_inode fs/notify/fsnotify.h:39 [inline]
  __fsnotify_inode_delete+0x19/0x20 fs/notify/fsnotify.c:35
  fsnotify_inoderemove include/linux/fsnotify.h:136 [inline]
  dentry_unlink_inode+0x48b/0x5e0 fs/dcache.c:370
  __dentry_kill+0x44c/0x7a0 fs/dcache.c:566
  dentry_kill+0xc9/0x5a0 fs/dcache.c:685
  dput.part.26+0x66b/0x7a0 fs/dcache.c:846
  dput+0x15/0x20 fs/dcache.c:828
  __fput+0x4c2/0x860 fs/file_table.c:264
  ____fput+0x15/0x20 fs/file_table.c:282
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcfa3e50c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000021
RAX: 000000000000000a RBX: 00007fcfa3e516d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000008
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cb6d0 R14: 00000000004c31f3 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
