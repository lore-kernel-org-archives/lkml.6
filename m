Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 36650C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06DA208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06DA208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755326AbeFNNFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:05:08 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:44251 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755280AbeFNNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:05:03 -0400
Received: by mail-io0-f200.google.com with SMTP id f12-v6so4726713iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 06:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gtP5/BC+CN26wZothmNH/ewIOFALtufUsW/y8b5JZe8=;
        b=TYFkwkB8Kaj25JFP+UX+WnqBAZD5ZruSfaxzKA6QORIZIEM4bQ0r3d94+cJQtLCIK7
         mjRucMQnTDGVuvFbhVRcmHfznkHvFjKDjCYys9sZsKZoVCHwpsvQ4ILaWgxCMhcyhS1y
         ymy9IzsomLIS23libMf1VVGfS+VyAMRIpDMHCGgkGxuTA8PhGxs2eUV6uYVqLYpUx/FA
         H1oju6+R25YDELFMPBqiy44edLE1VO8Hh/PK6TOrIxnPA9UoVpT7X0uJoKDtrk0mZ/Lr
         YKze4k6x+e6gGcHHIKCN2tHpBCrTjOj4Xrpf5+dcXJ9sVW4q2cwwqTPAVac6QzAYFXqs
         0+BQ==
X-Gm-Message-State: APt69E3/XukebAZvscfx+ukYplsZpT3nuXqbAYo1ceNz18901bY655CE
        4u0+i85Y6y1+WWU5/uDjn6HE/4OxDDRiR4QehoVNINdGeH4Y
X-Google-Smtp-Source: ADUXVKIje6sj+TtJswLoc9nAgXSk8WNx+9/Rjp9fGG2tLvniEvpAUhZ7tKmnDEzlqh3bYX4LeG9su2pqEi2Z/6b7eqWjrJwHhI0E
MIME-Version: 1.0
X-Received: by 2002:a24:d354:: with SMTP id n81-v6mr1021551itg.2.1528981502569;
 Thu, 14 Jun 2018 06:05:02 -0700 (PDT)
Date:   Thu, 14 Jun 2018 06:05:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000544690056e99bfee@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in vmx_set_msr
From:   syzbot <syzbot+405a50b23dd790f609b1@syzkaller.appspotmail.com>
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

HEAD commit:    be779f03d563 Merge tag 'kbuild-v4.18-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f9185f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=855fb54e1e019da2
dashboard link: https://syzkaller.appspot.com/bug?extid=405a50b23dd790f609b1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+405a50b23dd790f609b1@syzkaller.appspotmail.com

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 1890f1067 P4D 1890f1067 PUD 1890f2067 PMD 0
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor0'.
Oops: 0010 [#1] SMP KASAN
CPU: 0 PID: 12381 Comm: syz-executor7 Not tainted 4.17.0+ #101
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code:
unchecked MSR access error: WRMSR to 0x49 (tried to write  
0x0000000000000001) at rIP: 0xffffffff81347e18 (native_write_msr+0x8/0x30)
Bad RIP value.
RSP: 0018:ffff88019151f4c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801d2dca800 RCX: 1ffffffff10eac7d
RDX: ffff88019151f9e0 RSI: ffff8801c922da40 RDI: ffff8801c4a5a540
RBP: ffff88019151f630 R08: 0000000000000001 R09: 0000000000000000
Call Trace:
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff100322a3e9d
R13: ffff88019151f9e0 R14: ffff8801d2dca812 R15: ffff8801d2dcac58
FS:  00007f5039c16700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  paravirt_write_msr arch/x86/include/asm/paravirt.h:117 [inline]
  wrmsrl arch/x86/include/asm/paravirt.h:150 [inline]
  vmx_set_msr+0x19b/0x2010 arch/x86/kvm/vmx.c:3901
CR2: ffffffffffffffd6 CR3: 00000001890f0000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kvm_set_msr+0x18a/0x370 arch/x86/kvm/x86.c:1208
  do_set_msr+0x106/0x190 arch/x86/kvm/x86.c:1237
  sock_poll+0x1d1/0x710 net/socket.c:1168
  vfs_poll+0x77/0x2a0 fs/select.c:40
  do_pollfd fs/select.c:848 [inline]
  do_poll fs/select.c:896 [inline]
  do_sys_poll+0x6fd/0x1100 fs/select.c:990
  __msr_io arch/x86/kvm/x86.c:2784 [inline]
  msr_io+0x21a/0x360 arch/x86/kvm/x86.c:2820
  kvm_arch_vcpu_ioctl+0x14cb/0x36f0 arch/x86/kvm/x86.c:3782
  __do_sys_ppoll fs/select.c:1098 [inline]
  __se_sys_ppoll fs/select.c:1070 [inline]
  __x64_sys_ppoll+0x2fa/0x5f0 fs/select.c:1070
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455b29
Code: 1d
ba fb ff c3 66 2e
0f 1f 84 00 00
00 00 00 66 90
48 89 f8 48 89 f7
48 89 d6 48 89 ca
4d 89 c2 4d 89 c8
4c 8b 4c 24 08
0f 05 <48> 3d 01
f0 ff ff 0f 83 eb
b9 fb ff c3 66 2e
0f 1f 84 00 00 00
00
RSP: 002b:00007f5039c15c68 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00007f5039c166d4 RCX: 0000000000455b29
RDX: 0000000020000140 RSI: 0000000000000001 RDI: 00000000200000c0
RBP: 000000000072bea0 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c05f3 R14: 00000000004cfb20 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace 2f889d9e79d87fbd ]---
RIP: 0010:          (null)
Code:
Bad RIP value.
RSP: 0018:ffff88019151f4c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801d2dca800 RCX: 1ffffffff10eac7d
RDX: ffff88019151f9e0 RSI: ffff8801c922da40 RDI: ffff8801c4a5a540
RBP: ffff88019151f630 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff100322a3e9d
R13: ffff88019151f9e0 R14: ffff8801d2dca812 R15: ffff8801d2dcac58
FS:  00007f5039c16700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001890f0000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
