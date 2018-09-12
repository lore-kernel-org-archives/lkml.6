Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF66C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20C0206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20C0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeILS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:27:33 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33048 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeILS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:27:33 -0400
Received: by mail-io1-f69.google.com with SMTP id s14-v6so206494ioc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FZP3xGEyehchQqY35ERCrSD8xWpIjNzkmerOOx2rw2s=;
        b=h+0dxqbQAivJLSNCkbSurU/8PEwJe/D9XDnEOoZuzHm4HH+WtovD2mm1mJ4NSTvAwP
         v0IsTIgCPAryujRtbthwAL0WUFulSHTJJ9QXQ5HBmw95LOaGWj4xOlJ05SoXiL3b1aKe
         q/Ag23GgiyAA4qaSOPDR6kbO0mQjSCl4mQ0QpCbpM2//B58mpaBotE/qOYFiX4DTc+Tk
         PUIlEZVlmL7TrAEPFNsUe7gkvAR8Qf5n8fGAOMQe/II2MVSvzsFuZW3aO+4pIEq+Y331
         2hbi4q2QExL9juBCtNap2tOFFk4nwgVvQ5yATSpm4zxnobEzTBZ1nntMVPOAyEu8hXaa
         3/Fw==
X-Gm-Message-State: APzg51BYqndh1aQFFdYc6GvyN5Yb7h7Wr8nE4dw6Kqn5AyGhHEJSvEIw
        8Z2cMEu6rnrL4Q89Oazs2AW1Q75lmCMgj/pQ0iBNoKPE3uMe
X-Google-Smtp-Source: ANB0VdYO+gKFRhLfmgDYO1Zlw3NCiJ3begCXfRiInaINBN844mBwAn6MZF54UFy6VYSgjN371ey0aJn6Ju64QszvDTGSY9RULn3q
MIME-Version: 1.0
X-Received: by 2002:a24:9458:: with SMTP id j85-v6mr1824859ite.18.1536758582874;
 Wed, 12 Sep 2018 06:23:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 06:23:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000701dac0575ac7d64@google.com>
Subject: general protection fault in reconfigure_super
From:   syzbot <syzbot+87ccdc710b6af3fff875@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175570c6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=87ccdc710b6af3fff875
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87ccdc710b6af3fff875@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 19487 Comm: syz-executor4 Not tainted 4.19.0-rc3-next-20180912+  
#72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:reconfigure_super+0x48e/0xbb0 fs/super.c:981
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 62 05 00 00 48 ba 00 00 00  
00 00 fc ff df 48 8b 03 48 8d 78 30 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 4d 05 00 00 48 8b 40 30 48 85 c0 48 89 85 20 ff
RSP: 0018:ffff8801c116f8d8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801c116f9f8 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: ffffffff81cd864b RDI: 0000000000000030
kobject: 'loop0' (00000000b8cccb9a): kobject_uevent_env
RBP: ffff8801c116f9c8 R08: ffff8801b75aa540 R09: fffffbfff12c24e5
R10: fffffbfff12c24e5 R11: ffffffff8961272b R12: ffff8801c87eae80
R13: 1ffff1003822df20 R14: 0000000000000000 R15: ffff8801c116fadc
FS:  00007fb276613700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32228000 CR3: 00000001c2282000 CR4: 00000000001406f0
kobject: 'loop0' (00000000b8cccb9a): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
Call Trace:
  do_umount_root+0x2b1/0x320 fs/namespace.c:1435
  do_umount fs/namespace.c:1505 [inline]
  ksys_umount+0x8b6/0x1230 fs/namespace.c:1621
  __do_sys_umount fs/namespace.c:1632 [inline]
  __se_sys_umount fs/namespace.c:1630 [inline]
  __x64_sys_umount+0x54/0x80 fs/namespace.c:1630
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572d9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb276612c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 00007fb2766136d4 RCX: 00000000004572d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7be0 R14: 00000000004caa6b R15: 0000000000000000
Modules linked in:
---[ end trace 95eb19dc6e15b099 ]---
RIP: 0010:reconfigure_super+0x48e/0xbb0 fs/super.c:981
kobject: 'loop2' (00000000c4272b7a): kobject_uevent_env
kobject: 'loop2' (00000000c4272b7a): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 62 05 00 00 48 ba 00 00 00  
00 00 fc ff df 48 8b 03 48 8d 78 30 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 4d 05 00 00 48 8b 40 30 48 85 c0 48 89 85 20 ff
RSP: 0018:ffff8801c116f8d8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801c116f9f8 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: ffffffff81cd864b RDI: 0000000000000030
RBP: ffff8801c116f9c8 R08: ffff8801b75aa540 R09: fffffbfff12c24e5
R10: fffffbfff12c24e5 R11: ffffffff8961272b R12: ffff8801c87eae80
R13: 1ffff1003822df20 R14: 0000000000000000 R15: ffff8801c116fadc
FS:  00007fb276613700(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
sysfs: Unknown parameter './file0/bus'
CR2: 0000001b33822000 CR3: 00000001c2282000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
