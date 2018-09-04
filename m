Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B7EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93AD20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93AD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeIDHD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:03:57 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:43866 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:03:56 -0400
Received: by mail-it0-f71.google.com with SMTP id z72-v6so2183496itc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 19:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QkXvNQua4beqURUWRNOn2iPkoeDCNB/wc0cmu86Q/DA=;
        b=MH+8F3NRyQK0bP+C3qDHzoNBMM1aMgUfh8Yy+WVUb+cs2/uoUlECc7Ajwnw0GxZq/s
         A3zeIwYGQADFOoWnv/IW1gFuBxW8i9ndy7577N0FpGrrUFoJdCr5EcImkwik+ufelu2/
         IDw8FDzuc8MVaRgPjEiNEhJYUKlkSLlk4Rch0pWIkRG3nuJhexq0uUbdDCRMzLZGZE9j
         mGwDmOgEd7/qMu3fsL8Y/7cyx2e7VrwAVPbAz4Xz37DSBSnNPKTokQQbblvBnCzL+hcr
         nJ5iR0wZvfQHZjoQIUy4dMemG/+Sx2HC5ZZU56hYnub1P2VY99s9kkA6R6dh/ZTgog3c
         EydA==
X-Gm-Message-State: APzg51AntX8fHhjo6KcNp/It7eqhHJBwLv3PAw6MtiTVeyp3v7dWvQ5g
        cOq0RMcMpDcme1xsAe9vtok3Mo4/VeX5l4A1mOZsSYaZ/jG7
X-Google-Smtp-Source: ANB0Vdb9AiiywHjsNV/lo+JF2/xuBrdO0NQq4BTTECoIa6Pyh/M/d/WNOZtfZdfV3fFk93u2tO6ol1s9qpQWd1QPhyrMcrt16NX5
MIME-Version: 1.0
X-Received: by 2002:a6b:1ecb:: with SMTP id e194-v6mr12567127ioe.93.1536028862879;
 Mon, 03 Sep 2018 19:41:02 -0700 (PDT)
Date:   Mon, 03 Sep 2018 19:41:02 -0700
In-Reply-To: <000000000000b239d705736497a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc9ef905750296a4@google.com>
Subject: Re: WARNING in free_loaded_vmcs (2)
From:   syzbot <syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com>
To:     dvyukov@google.com, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    60c1f89241d4 Merge tag 'dma-mapping-4.19-2' of git://git.i..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15022d5a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=01bc9e7a8a3f138b71cf
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6513e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
WARNING: CPU: 1 PID: 4980 at arch/x86/kvm/vmx.c:4754  
free_loaded_vmcs+0x160/0x1b0 arch/x86/kvm/vmx.c:4754
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4980 Comm: syz-executor0 Not tainted 4.19.0-rc2+ #220
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
RIP: 0010:free_loaded_vmcs+0x160/0x1b0 arch/x86/kvm/vmx.c:4754
Code: 81 e8 44 be 53 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03  
80 3c 02 00 75 49 4c 8b 23 e9 22 ff ff ff e8 80 fc 5f 00 <0f> 0b eb b0 e8  
b7 f9 9e 00 e9 f4 fe ff ff 48 89 df e8 ca f9 9e 00
RSP: 0018:ffff8801d06af748 EFLAGS: 00010293
RAX: ffff8801d068a500 RBX: ffff8801d0ab57a8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff811cd2a0 RDI: ffff8801d0ab57b0
RBP: ffff8801d06af760 R08: ffff8801d068a500 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801c7166000
R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000001
  vmx_free_vcpu+0x204/0x300 arch/x86/kvm/vmx.c:10945
  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8420 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:8870 [inline]
  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8967
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:752 [inline]
  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:773
  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2407
  __fput+0x38a/0xa40 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410c30
Code: 01 f0 ff ff 0f 83 60 19 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d 5d 53 63 00 00 75 14 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 34 19 00 00 c3 48 83 ec 08 e8 0a fc ff ff
RSP: 002b:00007ffeb3e8ae98 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000410c30
RDX: 0000001b32e20000 RSI: 00000000007334f0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004129f0
R13: 0000000000412a80 R14: 0000000000000000 R15: badc0ffeebadface
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

