Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB644C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E7C2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E7C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJJPTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:19:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34411 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeJJPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:19:02 -0400
Received: by mail-io1-f69.google.com with SMTP id y3-v6so3867666iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DPPYNhmB5q6BVDnyCfKmhrv0WrQhIXCBtfX9GpkLkM4=;
        b=HEkr6asd/50X4xHgdm0F5py9uRcElA+5VO9vEoSXNia7s5zObQLlCmXjw8SL3/fLR1
         R2umuIuc7aCcITj2XWYpZc/ikTk185h+k4HT8RJDJ5aVhQU94RY1jsA9elGOCcOdmWB5
         IiGELUd6SH1fqEoCaOyMwi4CC1VYRTB8YLGEygU8jEuxgkJ32AuysVilGoaTBd/hC6it
         P8DRLnzIfnQ5Ii5uwsez+I9ReYgJ719WipBsLc2F8ha3yEFLVeAJMEMqXF314uEgrOiw
         GzQpNmhalnBg5s746wpIlSlNndX83x33hqHPlp7AXKpr12vULO/spPJ2lTJ7alLfkorw
         Tkkg==
X-Gm-Message-State: ABuFfoh5N9K4g5TLV9UPj1szgi5HPyTgg3lL2h6YAv9/k2dDcwtvlbtQ
        /LwEjbGlatCgfR4cYjO4g2ETlHmCS2yv1mfWOpYVHPpV9TKl
X-Google-Smtp-Source: ACcGV63KlC8MN/dj74bu0nKQ7oIye3MW6DQG3pARIfTVOGzcqaPCdTx2chSXPlBEJSqZtgsFoEyxfRjjpnYDLONVI8G0efMM9JVf
MIME-Version: 1.0
X-Received: by 2002:a24:d49:: with SMTP id 70-v6mr4448279itx.5.1539158283727;
 Wed, 10 Oct 2018 00:58:03 -0700 (PDT)
Date:   Wed, 10 Oct 2018 00:58:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c13ce50577db36cc@google.com>
Subject: WARNING: refcount bug in kvm_vm_ioctl
From:   syzbot <syzbot+6df4d24a0a50fd5d1a08@syzkaller.appspotmail.com>
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

HEAD commit:    64c5e530ac2c Merge tag 'arc-4.19-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16343ea1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=6df4d24a0a50fd5d1a08
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133eb685400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6df4d24a0a50fd5d1a08@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
hrtimer: interrupt took 30857 ns
------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 8299 at lib/refcount.c:153  
refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 8299 Comm: syz-executor2 Not tainted 4.19.0-rc7+ #275
kobject: 'kvm' (00000000705acfae): kobject_uevent_env
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
kobject: 'kvm' (00000000705acfae): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
kobject: 'kvm' (00000000705acfae): kobject_uevent_env
kobject: 'kvm' (00000000705acfae): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000705acfae): kobject_uevent_env
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
kobject: 'kvm' (00000000705acfae): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
Code: 1d 2b 7d 62 06 31 ff 89 de e8 1f bc f2 fd 84 db 75 df e8 46 bb f2 fd  
48 c7 c7 80 72 40 88 c6 05 0b 7d 62 06 01 e8 23 8e bc fd <0f> 0b eb c3 0f  
1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
RSP: 0018:ffff8801c1647708 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81650405 RDI: 0000000000000005
RBP: ffff8801c1647710 R08: ffff8801c2b98300 R09: ffffed003b5e4fe8
R10: ffffed003b5e4fe8 R11: ffff8801daf27f47 R12: ffff8801c16477c0
R13: ffff8801c4225800 R14: ffffffff892b6ec0 R15: ffffc9000497b000
  kvm_get_kvm arch/x86/kvm/../../../virt/kvm/kvm_main.c:766 [inline]
  kvm_ioctl_create_device arch/x86/kvm/../../../virt/kvm/kvm_main.c:2924  
[inline]
  kvm_vm_ioctl+0xed7/0x1d40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3114
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
RSP: 002b:00007f5511e6bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
RDX: 00000000200002c0 RSI: 00000000c00caee0 RDI: 0000000000000009
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5511e6c6d4
R13: 00000000004bfbd1 R14: 00000000004cfc58 R15: 00000000ffffffff
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
