Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E464920989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E464920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeLFJBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:01:04 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:58988 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:01:04 -0500
Received: by mail-it1-f199.google.com with SMTP id p21so89500itb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gp6Kv6h1C29qo99ZZ2TftIWME1rlTjDglUO/7eLACZ4=;
        b=gPXa5O08fosgux3puV0hRiOXg9k1nOO8pQZoWaRRRYEifHg+KtrfjyvkObjeUt0uxY
         iR5viFg8KFj4A4F2peoECj9ngvcjUQAoITbz1oOCDvM/W66aubJGr4lKDJOQFDaeWWpP
         Dbo9wemPnZG7R97e7sSCMoV4/XWqbSyPr5Yf3U0cKGHjyK5siedI1G2x3GxFp/dtVQGX
         q3EJgstNBQtPpXHUVeYa1teSv+i/0yV9+xRSncwKr2Ls0A0JDKQFNksTvSbbpYnQg71s
         vz0M1Q9rnuZw37IpGSdHk94B7oaGhwnFUVHtGwXg1gAoDVphdwQjb6kIfLRtvZhv4b3S
         pDmw==
X-Gm-Message-State: AA+aEWaI0nbFWRvDeVH0u84zJ9t6FrmXfkUDCfWj0E1cZB51ZtklTzX2
        IlftemzCKO4OwFJcgM0SoPD7t1aU23WUxF+hcQygLJX5f8Mt
X-Google-Smtp-Source: AFSGD/W2rh7rbsjArrORdT0vF5c7I5cM9qvvPJOtNpp8gPezNniYxyR2T/Za1h1ibwA7aSV7uaQrLNHwHu2VMKrLYr3hmpFApnsi
MIME-Version: 1.0
X-Received: by 2002:a24:a94:: with SMTP id 142mr8827054itw.15.1544086863449;
 Thu, 06 Dec 2018 01:01:03 -0800 (PST)
Date:   Thu, 06 Dec 2018 01:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff9610057c56bcd7@google.com>
Subject: KMSAN: kernel-infoleak in __kvm_write_guest_page
From:   syzbot <syzbot+af22f34edec5361fb143@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6f0597832d81 kmsan: unpoison data passed to skb_put_xxx() ..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=10b6da5d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b071100dcf8e641
dashboard link: https://syzkaller.appspot.com/bug?extid=af22f34edec5361fb143
compiler:       clang version 8.0.0 (trunk 348261)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+af22f34edec5361fb143@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: kernel-infoleak in __copy_to_user include/linux/uaccess.h:121  
[inline]
BUG: KMSAN: kernel-infoleak in __kvm_write_guest_page+0x2cc/0x4a0  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1855
CPU: 1 PID: 17704 Comm: syz-executor1 Not tainted 4.20.0-rc5+ #107
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x32d/0x480 lib/dump_stack.c:113
  kmsan_report+0x12d/0x290 mm/kmsan/kmsan.c:683
  kmsan_internal_check_memory+0x9ce/0xa50 mm/kmsan/kmsan.c:769
  kmsan_copy_to_user+0x8d/0xa0 mm/kmsan/kmsan_hooks.c:634
  __copy_to_user include/linux/uaccess.h:121 [inline]
  __kvm_write_guest_page+0x2cc/0x4a0  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1855
  kvm_vcpu_write_guest_page+0x196/0x1e0  
arch/x86/kvm/../../../virt/kvm/kvm_main.c:1876
  nested_release_vmcs12 arch/x86/kvm/vmx.c:8489 [inline]
  handle_vmptrld+0x1613/0x1750 arch/x86/kvm/vmx.c:9328
  vmx_handle_exit+0x213b/0xb920 arch/x86/kvm/vmx.c:10632
  vcpu_enter_guest arch/x86/kvm/x86.c:7811 [inline]
  vcpu_run arch/x86/kvm/x86.c:7874 [inline]
  kvm_arch_vcpu_ioctl_run+0xa551/0x11150 arch/x86/kvm/x86.c:8074
  kvm_vcpu_ioctl+0x1098/0x1e30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2596
  do_vfs_ioctl+0xf36/0x2d30 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
  do_syscall_64+0xcd/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0d0d3f0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0d0d3f16d4
R13: 00000000004c034e R14: 00000000004d0bc0 R15: 00000000ffffffff

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:246 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:169
  kmsan_kmalloc+0xa1/0x100 mm/kmsan/kmsan_hooks.c:186
  kmem_cache_alloc_trace+0x6b7/0xe20 mm/slub.c:2789
  kmalloc include/linux/slab.h:546 [inline]
  enter_vmx_operation+0x105/0xe10 arch/x86/kvm/vmx.c:8315
  vmx_set_nested_state+0xdc9/0x18a0 arch/x86/kvm/vmx.c:14922
  kvm_arch_vcpu_ioctl+0x4d99/0x7370 arch/x86/kvm/x86.c:4190
  kvm_vcpu_ioctl+0xcf3/0x1e30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2748
  do_vfs_ioctl+0xf36/0x2d30 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
  __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
  do_syscall_64+0xcd/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7

Bytes 1000-4095 of 4096 are uninitialized
Memory access of size 4096 starts at ffff8881147db000
Data copied to user address 0000000020feb000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
