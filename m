Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFB8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AB12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AB12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeH2N4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:56:10 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:59490 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeH2N4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:56:10 -0400
Received: by mail-it0-f69.google.com with SMTP id a10-v6so4415405itc.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vyqBAD9tnzC/WJ7apqYN0n88vF5fj0OayIheYaOjyAk=;
        b=i1yJD6tmwfCGWfrbrhCNqIhw1qAccBarqgkRNkhZA2ZjSvs9jSgAjcK+Xd9xbt8s61
         iTlkq1mrNsu7RlTVIHq7IzQXIhovruG8hE4TRfoZPUOx5bBkpPbYfHKjdODK0b2babGr
         /4vQDAyHnrDjeFaqR/fBjxiRwsb1LGAqcPCPb46GJUBqxBcwLjtcBPn2Ivhiims1g++M
         JiDlrDmjcJcLzn4lEr5/Mp4/+OTpMXyI9q6w5OgheV7xZuX7S5AuatcustqFiQTpxD4c
         w5efwxOXuLTUm41ETPghCY/lGQok0/UXzltZ55wFvjkJfBoNX7cH4C13J7G8hqGP71qk
         lFYQ==
X-Gm-Message-State: APzg51CEzzTjSN4Xu24gQveRWI48evDFFxB9pEmOlad/4SMhvgNxTx2f
        oYQG1YE96tZIJY1mObbtSZfG0ZlCBguJgc1Ocf7MCevZwM8G
X-Google-Smtp-Source: ANB0VdbjA57vpTpxCbrGBjjqOaeJLQd6DG1n1quEybT4dDstQbPNZSWxxzAWd0fuk9r8AFoM3v5bXsO/0Qkaq+x1vOGy1Xqgqygr
MIME-Version: 1.0
X-Received: by 2002:a24:74cd:: with SMTP id o196-v6mr2431542itc.46.1535536802566;
 Wed, 29 Aug 2018 03:00:02 -0700 (PDT)
Date:   Wed, 29 Aug 2018 03:00:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a819440574900515@google.com>
Subject: general protection fault in kvm_pv_send_ipi
From:   syzbot <syzbot+86c0a866f80d88349f1f@syzkaller.appspotmail.com>
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

HEAD commit:    051935978432 Merge branch 'for-4.19' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15561712400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b576e333ca31bb2
dashboard link: https://syzkaller.appspot.com/bug?extid=86c0a866f80d88349f1f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137d861e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+86c0a866f80d88349f1f@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4743 Comm: syz-executor0 Not tainted 4.18.0+ #207
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kvm_pv_send_ipi+0x582/0xaf0 arch/x86/kvm/lapic.c:582
Code: e0 07 83 c0 01 88 85 97 fe ff ff e8 48 0d 64 00 8b 85 b0 fe ff ff 44  
01 e0 48 98 49 8d bc c7 18 02 00 00 48 89 fa 48 c1 ea 03 <42> 80 3c 32 00  
0f 85 ed 03 00 00 49 8b 84 c7 18 02 00 00 48 8d b8
RSP: 0018:ffff8801d8bff028 EFLAGS: 00010206
RAX: 000000000000002f RBX: ffff8801d8bff190 RCX: ffffffff8118b074
RDX: 0000000000000072 RSI: ffffffff8118b0b8 RDI: 0000000000000390
RBP: ffff8801d8bff1b8 R08: ffff8801d8952640 R09: ffffed003b6046d6
R10: ffffed003b6046d6 R11: ffff8801db0236b3 R12: 000000000000000f
R13: ffff8801d8bff110 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000fc0940(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001bed89000 CR4: 00000000001426f0
Call Trace:
  kvm_emulate_hypercall+0x9d7/0xea0 arch/x86/kvm/x86.c:6838
  handle_vmcall+0x15/0x20 arch/x86/kvm/vmx.c:7478
  vmx_handle_exit+0x2dd/0x1760 arch/x86/kvm/vmx.c:10115
  vcpu_enter_guest+0x143c/0x61a0 arch/x86/kvm/x86.c:7630
  vcpu_run arch/x86/kvm/x86.c:7693 [inline]
  kvm_arch_vcpu_ioctl_run+0x373/0x16d0 arch/x86/kvm/x86.c:7870
  kvm_vcpu_ioctl+0x7b8/0x1280 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2590
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
RSP: 002b:00007fff3ceb8998 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000fc0914 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cedf0 R14: 00000000004c54c9 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace c38044fa919274d9 ]---
RIP: 0010:kvm_pv_send_ipi+0x582/0xaf0 arch/x86/kvm/lapic.c:582
Code: e0 07 83 c0 01 88 85 97 fe ff ff e8 48 0d 64 00 8b 85 b0 fe ff ff 44  
01 e0 48 98 49 8d bc c7 18 02 00 00 48 89 fa 48 c1 ea 03 <42> 80 3c 32 00  
0f 85 ed 03 00 00 49 8b 84 c7 18 02 00 00 48 8d b8
RSP: 0018:ffff8801d8bff028 EFLAGS: 00010206
RAX: 000000000000002f RBX: ffff8801d8bff190 RCX: ffffffff8118b074
RDX: 0000000000000072 RSI: ffffffff8118b0b8 RDI: 0000000000000390
RBP: ffff8801d8bff1b8 R08: ffff8801d8952640 R09: ffffed003b6046d6
R10: ffffed003b6046d6 R11: ffff8801db0236b3 R12: 000000000000000f
R13: ffff8801d8bff110 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000fc0940(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001bed89000 CR4: 00000000001426f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
