Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254CCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFDF214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFDF214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeJJPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:18:04 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:34568 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:18:02 -0400
Received: by mail-it1-f200.google.com with SMTP id p20-v6so11190865itg.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ockJ5V7je4x/ugGrZHqutjqK+GHLzDGzkNPA9uNuNGM=;
        b=hH740dxsgfBJZrLwbRp4JBXVwFUMJzkhHqJhBL406QqFCWpYOBTUPqOwhkqeCmRRSa
         hJijgj9yEOVJlA/mmts04HrmmJGh9iUHJqpOHN2+kXSLoV/WcgQbcbGyCI1x4id/DDO+
         O7jAhPYOPNmBj+bJeDxqEbODuMNzrE58cd5FWGsjNZSHpzKj1E34ujLOSjkfo9hQ0UdO
         g3gtXfbSIOPSMM9rlFNwJWruHzdXAsnuIfNcaxi69mGnn7+6fVMLwWM/j0BlSFzkccIA
         siot7MWriX1VKV02cK06u0unrQqZiZsHMhrNz6Eo5BaLxwf5JMPsQYUug222+pJj3/8y
         yv+A==
X-Gm-Message-State: ABuFfoh4fKul1iRfFi8cRcLnWrsHidpohYrhBo5u50VcOM1/4YYyHyyv
        nAFa7k1BlwWYqiPhAp+nD4XMeAihucCrn8GYYFi7UP9LfTfk
X-Google-Smtp-Source: ACcGV60KcCHzdxISkqRM/IOoVmed/IxRYVmF8tNCcigg2Ux5rYEcitXZegZ4MioV7Onn3CmrCCiJZtYTMyOJUlpsTiF07aVuqbJ7
MIME-Version: 1.0
X-Received: by 2002:a24:9192:: with SMTP id i140-v6mr4370319ite.39.1539158224356;
 Wed, 10 Oct 2018 00:57:04 -0700 (PDT)
Date:   Wed, 10 Oct 2018 00:57:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003752860577db332b@google.com>
Subject: BUG: unable to handle kernel paging request in refcount_inc_not_zero_checked
From:   syzbot <syzbot+e593df3bb8f541d497b9@syzkaller.appspotmail.com>
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

HEAD commit:    570b7bdeaf18 Add linux-next specific files for 20181009
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f27959400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b5a60e1381390c4
dashboard link: https://syzkaller.appspot.com/bug?extid=e593df3bb8f541d497b9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e593df3bb8f541d497b9@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at ffffc90001b356b0
PGD 1da948067 P4D 1da948067 PUD 1da949067 PMD 1ce844067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 11542 Comm: syz-executor2 Not tainted 4.19.0-rc7-next-20181009+  
#90
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
kobject: 'queues' (00000000da0a0759): kobject_uevent_env
RIP: 0010:__read_once_size include/linux/compiler.h:179 [inline]
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:22 [inline]
RIP: 0010:refcount_inc_not_zero_checked+0xbb/0x2f0 lib/refcount.c:120
Code: e7 e8 89 4b 30 fe 4c 89 e0 48 c1 e8 03 0f b6 14 18 4c 89 e0 83 e0 07  
83 c0 03 38 d0 7c 08 84 d2 0f 85 0b 02 00 00 49 8d 5d c0 <45> 8b 3c 24 48  
b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 0f
kobject: 'queues' (00000000da0a0759): kobject_uevent_env: filter function  
caused the event to drop!
RSP: 0018:ffff88017cf9f618 EFLAGS: 00010246
RAX: 0000000000000003 RBX: ffff88017cf9f690 RCX: ffffffff83929317
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc90001b356b0
RBP: ffff88017cf9f6f8 R08: fffff52000366ad7 R09: fffff52000366ad6
R10: fffff52000366ad6 R11: ffffc90001b356b3 R12: ffffc90001b356b0
R13: ffff88017cf9f6d0 R14: ffffffff892b6d60 R15: ffff8801d4803400
FS:  00007fb683cfa700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop1' (00000000bc5d5992): kobject_uevent_env
CR2: ffffc90001b356b0 CR3: 00000001d2369000 CR4: 00000000001426e0
netlink: 72 bytes leftover after parsing attributes in process  
`syz-executor3'.
Call Trace:
  refcount_inc_checked+0x15/0x70 lib/refcount.c:153
kobject: 'loop1' (00000000bc5d5992): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  kvm_get_kvm arch/x86/kvm/../../../virt/kvm/kvm_main.c:765 [inline]
  kvm_ioctl_create_device arch/x86/kvm/../../../virt/kvm/kvm_main.c:2923  
[inline]
  kvm_vm_ioctl+0xedf/0x1d60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3113
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb683cf9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 00000000200002c0 RSI: 00000000c00caee0 RDI: 0000000000000008
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb683cfa6d4
R13: 00000000004bfbd1 R14: 00000000004cfc58 R15: 00000000ffffffff
Modules linked in:
CR2: ffffc90001b356b0
---[ end trace 6ee8acb8091e879f ]---
RIP: 0010:__read_once_size include/linux/compiler.h:179 [inline]
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:22 [inline]
RIP: 0010:refcount_inc_not_zero_checked+0xbb/0x2f0 lib/refcount.c:120
Code: e7 e8 89 4b 30 fe 4c 89 e0 48 c1 e8 03 0f b6 14 18 4c 89 e0 83 e0 07  
83 c0 03 38 d0 7c 08 84 d2 0f 85 0b 02 00 00 49 8d 5d c0 <45> 8b 3c 24 48  
b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 0f
RSP: 0018:ffff88017cf9f618 EFLAGS: 00010246
RAX: 0000000000000003 RBX: ffff88017cf9f690 RCX: ffffffff83929317
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc90001b356b0
RBP: ffff88017cf9f6f8 R08: fffff52000366ad7 R09: fffff52000366ad6
R10: fffff52000366ad6 R11: ffffc90001b356b3 R12: ffffc90001b356b0
R13: ffff88017cf9f6d0 R14: ffffffff892b6d60 R15: ffff8801d4803400
FS:  00007fb683cfa700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001b356b0 CR3: 00000001d2369000 CR4: 00000000001426e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
