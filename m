Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4039C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8D3218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfA3KfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:35:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:59001 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbfA3KfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:35:05 -0500
Received: by mail-it1-f199.google.com with SMTP id p21so18486124itb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8CVKFpzzeIHCAPqNxKHlEmfwxxxTS4D1fzV4Sk20aMY=;
        b=RvohVLYFE+IFqeGob3ZR8YpfZbQ1QouL0rD+8E5soH8rDW3HCDR601yDL0Cv/ZgblV
         WvjqxZAeumYLtB/QnMNQ9NMejvkSEfeIFXFhjYU4WkwpEbsXSVFaXbhDmz+UPNCsDMsj
         VbO5uDXfVncbID3Yd7LJFopES+MNgnAG93+IIWyfxftnNwt5LQTiMfFzqAs6I7NVCaU8
         Znf1a0vLCMmiG+UXMmn+q1oErpkQtomfLO1mgcYOEhRnx37PUAWBl4y724W1re/hrG0M
         Hp2ms5kvs7iRxxctD4BzIPbO0aznQY3zo+CoCGvzFVvPZ0xVDMQ36C4vQGGzPUoqxFB6
         Q7JQ==
X-Gm-Message-State: AHQUAub33u6SecEQNSY43TPmnsvv+H8Y5BIx2H8xTpd3Dc9gqUgAJ4uP
        Eaxx139fPm+67q5SzhU5JVHp3BP0hrYkvArEI0GS6vLr8igP
X-Google-Smtp-Source: AHgI3IaE4q1p55gxMkvbxqGZrU59yz5ggRXf1T4Zc4f/Tuvn8SFYNZidgQYc6iChLUsEsPVBDGSoxrguJwyMI0hMykKgYDsBWDHb
MIME-Version: 1.0
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr5599578ita.8.1548844504318;
 Wed, 30 Jan 2019 02:35:04 -0800 (PST)
Date:   Wed, 30 Jan 2019 02:35:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e10c50580aa7684@google.com>
Subject: general protection fault in __dentry_path
From:   syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e8d80f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=7857962b4d45e602b8ad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 445 Comm: syz-executor3 Not tainted 5.0.0-rc4-next-20190130 #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__dentry_path+0x2a5/0xaa0 fs/d_path.c:344
Code: 00 00 e8 1e 9d 9f ff 48 c7 c7 68 26 81 89 e8 72 c4 14 06 e8 0d 9d 9f  
ff 48 8b 85 00 ff ff ff 48 8d 78 40 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 b0 07 00 00 48 8b 85 00 ff ff ff 4c 8b 68 40
RSP: 0018:ffff8881c21bf8a8 EFLAGS: 00010207
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffffc90005b5c000
RDX: 0000000000002edf RSI: ffffffff81e27c43 RDI: 000000000000002f
RBP: ffff8881c21bf9d0 R08: ffff88806b30a040 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881c21bf9a8
R13: 0000000000000000 R14: 0000000000009674 R15: dffffc0000000000
FS:  00007f27af88b700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f722000 CR3: 0000000218991000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  dentry_path_raw+0x26/0x30 fs/d_path.c:371
  kvm_uevent_notify_change.part.0+0x213/0x440  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:4050
  kvm_uevent_notify_change arch/x86/kvm/../../../virt/kvm/kvm_main.c:4017  
[inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3355  
[inline]
  kvm_dev_ioctl+0x137a/0x1a60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3377
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x107b/0x17d0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458089
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f27af88ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458089
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f27af88b6d4
R13: 00000000004c0bcf R14: 00000000004d2890 R15: 00000000ffffffff
Modules linked in:
---[ end trace 1701fe85f04d676b ]---
RIP: 0010:__dentry_path+0x2a5/0xaa0 fs/d_path.c:344
Code: 00 00 e8 1e 9d 9f ff 48 c7 c7 68 26 81 89 e8 72 c4 14 06 e8 0d 9d 9f  
ff 48 8b 85 00 ff ff ff 48 8d 78 40 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 b0 07 00 00 48 8b 85 00 ff ff ff 4c 8b 68 40
RSP: 0018:ffff8881c21bf8a8 EFLAGS: 00010207
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffffc90005b5c000
RDX: 0000000000002edf RSI: ffffffff81e27c43 RDI: 000000000000002f
RBP: ffff8881c21bf9d0 R08: ffff88806b30a040 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881c21bf9a8
R13: 0000000000000000 R14: 0000000000009674 R15: dffffc0000000000
FS:  00007f27af88b700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001f80f70 CR3: 0000000218991000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
