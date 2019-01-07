Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA2EC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CA82089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfAGJzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:55:07 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36220 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfAGJzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:55:05 -0500
Received: by mail-io1-f69.google.com with SMTP id t13so43220636ioi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WewzTaodeZ6WRMD7afEtLWibTSF1aJWzVSBZZ4puyOE=;
        b=kRqMIwgzVSQt5zgwEnboPNuh0jIr8OgzFHqKGdClFU/aSljX1y/lSCZJslIL6ieIa8
         YzQVNt6RoNdojN/p7/6yAR2ZUVMxf/fsGpnS2VsrZ9aSAumjZwvKJUP1AK5hlALMm4ID
         ikGOsCGZCgQgHarkGw49nfklVuGRnhCe1w223FHspv2Si4StDXANxgCKogD0JsnNgUcX
         bTMdNuXuSGlmzHMybjoVG9rn0+4eJcBS127lZN4+ajDDUEeqHbPVR7kt0i2HJwVYsrsU
         3HSViFeaWpCCqihvMqRXcwF9tM6tt8TlgCE89cAdU+h3x07H2xzqt+iZm7OqMQnP5o2f
         MFeA==
X-Gm-Message-State: AJcUukdpe1Rz4ASSKWQRMWKdgX4j+7HV1hkxpAeKG/llyFdxn8Q/DSiq
        l9/oaZVvAaRsUb4yiD6/FIPOyzI700WDkTj4uWrprrkoqvTg
X-Google-Smtp-Source: ALg8bN5LgQB75T+7OqPatorHURTD5jWwqdZzlT0NWfzQel24gjReQm0fkPF+HTv7YkVuuzw5IgrvwTWI3PEcohtUUUtucxRsIh13
MIME-Version: 1.0
X-Received: by 2002:a24:3a14:: with SMTP id m20mr8388409itm.1.1546854904204;
 Mon, 07 Jan 2019 01:55:04 -0800 (PST)
Date:   Mon, 07 Jan 2019 01:55:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015955c057edb3905@google.com>
Subject: WARNING in _cleanup_srcu_struct
From:   syzbot <syzbot+5a1bbe3f318ef61ece61@syzkaller.appspotmail.com>
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

HEAD commit:    574823bfab82 Change mincore() to count "mapped" pages rath..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101b7180c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=5a1bbe3f318ef61ece61
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5a1bbe3f318ef61ece61@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 25571 at kernel/rcu/srcutree.c:381  
_cleanup_srcu_struct+0x3ee/0x600 kernel/rcu/srcutree.c:384
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 25571 Comm: syz-executor4 Not tainted 4.20.0+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:_cleanup_srcu_struct+0x3ee/0x600 kernel/rcu/srcutree.c:381
Code: 00 49 c7 84 24 48 04 00 00 00 00 00 00 e9 b5 fe ff ff e8 05 17 e9 ff  
e9 d2 fd ff ff 0f 0b e9 a4 fe ff ff 0f 0b e9 9d fe ff ff <0f> 0b e9 96 fe  
ff ff 0f 0b 48 8d 9d 58 ff ff ff 48 b8 00 00 00 00
RSP: 0018:ffff888056b97928 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 1ffff1100ad72f3c RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff838e8df7 RDI: 0000000000000006
RBP: ffff888056b97a48 R08: ffff888054192340 R09: 0000000000000040
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90012c987f8
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000000
  cleanup_srcu_struct include/linux/srcu.h:86 [inline]
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:753 [inline]
  kvm_put_kvm+0x9c0/0xff0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:769
  kvm_vm_release+0x44/0x60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:780
  __fput+0x3c5/0xb10 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x1f4/0x2b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x32a/0x3b0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x696/0x800 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411c91
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 94 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:0000000000a4fd90 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000000000000000a RCX: 0000000000411c91
RDX: 0000000000000000 RSI: 00000000007407b0 RDI: 0000000000000009
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000a4fcc0 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00000000000001cb R15: 0000000000000004
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
