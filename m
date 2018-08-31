Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F5DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F2E20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F2E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHaFgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:36:01 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:54347 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaFgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:36:01 -0400
Received: by mail-io0-f200.google.com with SMTP id l24-v6so9230004iok.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wgnyQoF5haT4jYZPvq2SBvgAXT0M2DTwyAz/kIAGcm4=;
        b=SWBBfxAm6+qd009+RLPeRQ9XZ9xbUjnylmSijoQ45HoOcUAYDWtswLfzHHpZCGPdXV
         30uRMqIhXeM7gC89HERMmMz2RiRNC0SwTgM77EjoWrJo7YkrogrSZUIkSe8CcgXGbCun
         +ZQwPX3/Dy3pOtP67WGpy2UE2lWa24l8P/+KPYR+tlHb1ATsUGaqyEBhPpsq1AQOlPpS
         yMFvUE3k5EVVhKI96QueBjmWOC13RPE3uBqu6XqBgD9HazF0X+wRPnuWyn5GTsBk91TN
         3iIEyuv8eE1mLtg7cZ5jSHjHukVVP5RRKiOR+cU4Y/Uegj9xkQ2qPdKB2ceuj4dNL/Xe
         h9RQ==
X-Gm-Message-State: APzg51DRSwTWdEtX2uicdBKi+lrp4nc0pWPGIwecxVGx4XMxsj6qY5e/
        Ek+EKOyDYKtTX9Opq9n4f8hJu8Z4NxvrNYWfD8SwrfnCe5vB
X-Google-Smtp-Source: ANB0VdYHNS5zVpQ18ess4VRq6ngUFYxycsB0m37rUYQ6PTgJkFBUqqI6HA87b6g14Z0r/QWg2RVYarNYrWxPhxoK1DIN4Az+2vet
MIME-Version: 1.0
X-Received: by 2002:a02:3d4e:: with SMTP id n75-v6mr5658249jan.51.1535679062724;
 Thu, 30 Aug 2018 18:31:02 -0700 (PDT)
Date:   Thu, 30 Aug 2018 18:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005dc880574b12567@google.com>
Subject: WARNING in enter_vmx_operation
From:   syzbot <syzbot+ab5d7a5d0fc0c7518f6d@syzkaller.appspotmail.com>
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

HEAD commit:    3f16503b7d22 Merge branch 'fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c7df6a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49927b422dcf0b29
dashboard link: https://syzkaller.appspot.com/bug?extid=ab5d7a5d0fc0c7518f6d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132365a6400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ab5d7a5d0fc0c7518f6d@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
WARNING: CPU: 1 PID: 4748 at arch/x86/kvm/vmx.c:8247 alloc_shadow_vmcs  
arch/x86/kvm/vmx.c:8247 [inline]
WARNING: CPU: 1 PID: 4748 at arch/x86/kvm/vmx.c:8247  
enter_vmx_operation+0x391/0x470 arch/x86/kvm/vmx.c:8274
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4748 Comm: syz-executor0 Not tainted 4.19.0-rc1+ #213
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
RIP: 0010:alloc_shadow_vmcs arch/x86/kvm/vmx.c:8247 [inline]
RIP: 0010:enter_vmx_operation+0x391/0x470 arch/x86/kvm/vmx.c:8274
Code: 00 4c 89 ef bb f4 ff ff ff e8 7b ec ff ff e9 f2 fe ff ff e8 71 dc 5f  
00 48 8b 4d d0 48 85 c9 0f 84 08 ff ff ff e8 5f dc 5f 00 <0f> 0b e9 0e fe  
ff ff e8 f3 d9 9e 00 e9 c1 fe ff ff e8 09 da 9e 00
RSP: 0018:ffff8801aa826f48 EFLAGS: 00010293
RAX: ffff8801abbde080 RBX: ffff8801d3668040 RCX: ffff8801c366d000
RDX: 0000000000000000 RSI: ffffffff811ce421 RDI: ffff8801d366d820
RBP: ffff8801aa826f80 R08: ffff8801abbde080 R09: ffffed003b6246de
R10: ffffed003b6246de R11: ffff8801db1236f3 R12: ffff8801d366dba8
R13: ffff8801d366dbb8 R14: ffff8801d366dba0 R15: ffff8801d366d7a8
  vmx_set_nested_state+0x4d6/0xea0 arch/x86/kvm/vmx.c:13944
  kvm_arch_vcpu_ioctl+0x790/0x3ac0 arch/x86/kvm/x86.c:4048
  kvm_vcpu_ioctl+0x286/0x1280 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2742
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
RSP: 002b:00007f0ac2b1cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0ac2b1d6d4 RCX: 0000000000457089
RDX: 0000000020000580 RSI: 000000004080aebf RDI: 0000000000000005
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cf070 R14: 00000000004c56c3 R15: 0000000000000001
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
