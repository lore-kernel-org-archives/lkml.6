Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E899DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA63120C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA63120C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeHOT1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:27:54 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:57677 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbeHOT1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:27:54 -0400
Received: by mail-it0-f69.google.com with SMTP id e6-v6so1695873itc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xj5lCQzakuy74kPQ79r5WVk3J3O8sl5Dv3W5si3grpg=;
        b=tncXORYFjz0RcFkXsrBaxDufQ/UVEau9AdTXEZiknSzwl7AZ91y32rBXEKqZUUQmVH
         NkdU7uFWZZFA5KfywlxWBsljRteqQGlT+92G9oznV5LZCwIHCrIP93ulv2tKY2GsGa4p
         Cu8oqvTnCadjzbZMxwCOy5XNyYB64VUXyv0kuAG5xk089K6agigdWlDk1XEcT+Sx/AST
         Ru6aBFVd+/X9ImDw+3Pp5PwVo/8tOrSt4hm9Y6wboe62Ua8+KbmDhhGIOkmohKjU3Mvv
         B9N02dz9RGRZnJFyNIgnzV67Lia8hTpGiUoJYPeT4Ojdgk2XoDwB/OEXOLngf8IYr97Q
         blnw==
X-Gm-Message-State: AOUpUlEwhBflhquaYXRQyigApplgDFRlQZpbXxQnq+DTUX6SnLshtJ0f
        Azz+H3y8poI0Q/RAd01JYzzPf4P3/D9Ii8JykyZNlshdeIxl
X-Google-Smtp-Source: AA+uWPz5vfP4owo4/6hM5n9WsGLqz3xh17Xn2/1C6D6vMZ4qCMVfvz/b3R8rGpIMfnfCryWOI5nnZehGKejrlb9VltFwRL0IINiy
MIME-Version: 1.0
X-Received: by 2002:a02:ac06:: with SMTP id a6-v6mr12233797jao.62.1534350903239;
 Wed, 15 Aug 2018 09:35:03 -0700 (PDT)
Date:   Wed, 15 Aug 2018 09:35:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c6a4305737be8a4@google.com>
Subject: general protection fault in vcpu_enter_guest
From:   syzbot <syzbot+a7d2d21d5cbb86bfd129@syzkaller.appspotmail.com>
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

HEAD commit:    4110b42356f3 Add linux-next specific files for 20180810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=158a6f54400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d80606e3795a4f5
dashboard link: https://syzkaller.appspot.com/bug?extid=a7d2d21d5cbb86bfd129
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a7d2d21d5cbb86bfd129@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 12684 Comm: syz-executor6 Not tainted 4.18.0-rc8-next-20180810+  
#36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_apic_hw_enabled arch/x86/kvm/lapic.h:169 [inline]
RIP: 0010:vcpu_scan_ioapic arch/x86/kvm/x86.c:7243 [inline]
RIP: 0010:vcpu_enter_guest+0x51f9/0x6360 arch/x86/kvm/x86.c:7389
Code: 80 3c 02 00 0f 85 79 11 00 00 4c 8b a3 e0 03 00 00 48 b8 00 00 00 00  
00 fc ff df 49 8d bc 24 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 45 11 00 00 4d 8b a4 24 88 00 00 00 48 b8 00 00
RSP: 0018:ffff88019465f4f0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88018fb40200 RCX: ffffc90004417000
RDX: 0000000000000011 RSI: ffffffff810eb6b7 RDI: 0000000000000088
RBP: ffff88019465f840 R08: ffff8801b2b2c6c0 R09: 0000000000000001
R10: ffff88019465f860 R11: 97ac495aab52485c R12: 0000000000000000
R13: 0000000002814001 R14: dffffc0000000000 R15: ffff88018fb40230
FS:  00007f75b27a9700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001b8e7d0 CR3: 00000001aebfc000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vcpu_run arch/x86/kvm/x86.c:7660 [inline]
  kvm_arch_vcpu_ioctl_run+0x33e/0x1690 arch/x86/kvm/x86.c:7837
  kvm_vcpu_ioctl+0x7b8/0x1300 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f75b27a8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f75b27a96d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ceb90 R14: 00000000004c54c9 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace e6eaa75019e681cb ]---
RIP: 0010:kvm_apic_hw_enabled arch/x86/kvm/lapic.h:169 [inline]
RIP: 0010:vcpu_scan_ioapic arch/x86/kvm/x86.c:7243 [inline]
RIP: 0010:vcpu_enter_guest+0x51f9/0x6360 arch/x86/kvm/x86.c:7389
Code: 80 3c 02 00 0f 85 79 11 00 00 4c 8b a3 e0 03 00 00 48 b8 00 00 00 00  
00 fc ff df 49 8d bc 24 88 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 45 11 00 00 4d 8b a4 24 88 00 00 00 48 b8 00 00
RSP: 0018:ffff88019465f4f0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88018fb40200 RCX: ffffc90004417000
RDX: 0000000000000011 RSI: ffffffff810eb6b7 RDI: 0000000000000088
RBP: ffff88019465f840 R08: ffff8801b2b2c6c0 R09: 0000000000000001
R10: ffff88019465f860 R11: 97ac495aab52485c R12: 0000000000000000
netlink: 28 bytes leftover after parsing attributes in process  
`syz-executor5'.
R13: 0000000002814001 R14: dffffc0000000000 R15: ffff88018fb40230
FS:  00007f75b27a9700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001b8e7d0 CR3: 00000001aebfc000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
IPVS: set_ctl: invalid protocol: 59 172.20.20.20:20003
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
