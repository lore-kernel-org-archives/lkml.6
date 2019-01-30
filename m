Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0FDC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B15020989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfA3LcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:32:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53806 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfA3LcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:32:04 -0500
Received: by mail-io1-f70.google.com with SMTP id t133so19189846iof.20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 03:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PMwA05+gU/VKHpDMuGTgK2c6iVWs8AtnF8kUHYaFtCU=;
        b=JZ2xVmbB8qfPsE1aFegAd3CMk1UM7lHYifPdgtLA1c3VhIxH2qCm9rEkGlJVNForer
         q1W6HCFP7eTl9qXWH5ldsJJton7XimpgFl3Pxw5wqawKBl3YN3qMBOhz7E4bLCmUEwdQ
         yyro2riBbl+EFnapXUl4uGElfWC4LQUA75yxPeIr8Ups3mtuCwR521GBqPRIm+gPKSvT
         okq5DjmjLBWPVmBQYHl4l0SYtni4Hco40Ub+sKtR7EtOQOl+8TaCozQl+tFWqoMLCIRw
         piDLw/zJolEWa48ItR6TXg3rNGwuL2WUCRTi1McFIhnQUz7VfX2qidGEBozpY044FNtN
         1PiQ==
X-Gm-Message-State: AHQUAuarAPMU0MI7R/yIDdfBidvi5OS7gcWb5Py9dQBNNfnkS/TTxEUq
        2d8ID8ilMBqOD1i/qE/p4dLmFXlj/E1Bq8g4J3KHgPaI4Dr9
X-Google-Smtp-Source: AHgI3Ia21FbH/6eeuilPd0TMQEWBTPdGSZrnfMckMOJq4bQfsvP6jdzuYgebZCpoZcrMLCBDg0OtYwMbbK5ILYweoXUsYquaYjAE
MIME-Version: 1.0
X-Received: by 2002:a6b:b714:: with SMTP id h20mr5907567iof.2.1548847923464;
 Wed, 30 Jan 2019 03:32:03 -0800 (PST)
Date:   Wed, 30 Jan 2019 03:32:03 -0800
In-Reply-To: <0000000000007e10c50580aa7684@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a10840580ab4277@google.com>
Subject: Re: general protection fault in __dentry_path
From:   syzbot <syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=106161ef400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=7857962b4d45e602b8ad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1182e5b8c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8239 Comm: syz-executor4 Not tainted 5.0.0-rc4-next-20190130 #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__dentry_path+0x2a5/0xaa0 fs/d_path.c:344
Code: 00 00 e8 1e 9d 9f ff 48 c7 c7 68 26 81 89 e8 72 c4 14 06 e8 0d 9d 9f  
ff 48 8b 85 00 ff ff ff 48 8d 78 40 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 b0 07 00 00 48 8b 85 00 ff ff ff 4c 8b 68 40
RSP: 0018:ffff88808ab5f8a8 EFLAGS: 00010207
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffffffff81e27f21
RDX: 0000000000000000 RSI: ffffffff81e27c43 RDI: 000000000000002f
RBP: ffff88808ab5f9d0 R08: ffff88809edd4280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88808ab5f9a8
R13: 0000000000000000 R14: 0000000000000c78 R15: dffffc0000000000
FS:  00007f69a6d18700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000144a008 CR3: 00000000a1190000 CR4: 00000000001426f0
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
RSP: 002b:00007f69a6d17c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458089
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000006
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f69a6d186d4
R13: 00000000004c0bcf R14: 00000000004d2890 R15: 00000000ffffffff
Modules linked in:
---[ end trace c2b508264c762aae ]---
RIP: 0010:__dentry_path+0x2a5/0xaa0 fs/d_path.c:344
Code: 00 00 e8 1e 9d 9f ff 48 c7 c7 68 26 81 89 e8 72 c4 14 06 e8 0d 9d 9f  
ff 48 8b 85 00 ff ff ff 48 8d 78 40 48 89 f8 48 c1 e8 03 <42> 80 3c 38 00  
0f 85 b0 07 00 00 48 8b 85 00 ff ff ff 4c 8b 68 40
RSP: 0018:ffff88808ab5f8a8 EFLAGS: 00010207
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffffffff81e27f21
RDX: 0000000000000000 RSI: ffffffff81e27c43 RDI: 000000000000002f
RBP: ffff88808ab5f9d0 R08: ffff88809edd4280 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88808ab5f9a8
R13: 0000000000000000 R14: 0000000000000c78 R15: dffffc0000000000
FS:  00007f69a6d18700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec12a1fdb8 CR3: 00000000a1190000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

