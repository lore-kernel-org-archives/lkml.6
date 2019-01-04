Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32406C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29B021872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfADPlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:41:06 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:49652 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfADPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:41:05 -0500
Received: by mail-io1-f71.google.com with SMTP id c4so16057218ioh.16
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 07:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/lp/Mfz2uM+CQh/WXV6QEagU0ChiR1h+/1QK0izzJos=;
        b=J61dravbXa151wiXb5Qzd5tUQ7IiJSEEkkouRMtMgZRY00dSTQQnI+MuXpsqoWF5vk
         6M4NavbSSP562dRImsu1wnbRLAMNWvQK1i8aFPo+eKhzs/POpPe8nsyNsEkbpoaU7ZK6
         28n6f9w1L+NkPgc+DpnBeqkbdUBds4ZOOo2WIwuoW7Wf+ZnUWpA9KUZwTXxtUMKeY8Qr
         4OKc3g7/DixRoYckKPMnk4x70UNKOHyWu+4wtS22jrgw3FYU0amN0Ab08yDbPClGNEWj
         IoKn1US7LvNmvXPpf8m8o7LIM5NEoqZauRpRgyFWlddEOagHqAXDXsixRLHUP6KsSKA3
         dI2w==
X-Gm-Message-State: AJcUukct8tqNHO8qFyuMmlFUL4e3JqwlosTcNm3vhTPjlFyDwXiIUzys
        24eI0iuwdtJRtvhdR21aOQSCfH5+O9/fKHCMGqPVYmbhly81
X-Google-Smtp-Source: ALg8bN4PghF/NqdkzrSn96AG5jjiXMnUdAGXrAeBCcdZmmoN4A3yzgGWCoVHysFxBQ+BbPXaOj+kITAKd49bkdr/OW89764Vrc/a
MIME-Version: 1.0
X-Received: by 2002:a24:6c93:: with SMTP id w141mr1381816itb.35.1546616464144;
 Fri, 04 Jan 2019 07:41:04 -0800 (PST)
Date:   Fri, 04 Jan 2019 07:41:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f302fc057ea3b499@google.com>
Subject: WARNING in bpf_prog_kallsyms_add
From:   syzbot <syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    645ff1e8e704 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a5c64b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20271e14bc1c87f0
dashboard link: https://syzkaller.appspot.com/bug?extid=987e48d84abddbe2506d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c69d20c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv0
8021q: adding VLAN 0 to HW filter on device batadv0
IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
8021q: adding VLAN 0 to HW filter on device batadv0
WARNING: CPU: 1 PID: 8154 at kernel/bpf/core.c:578 bpf_prog_ksym_node_add  
kernel/bpf/core.c:578 [inline]
WARNING: CPU: 1 PID: 8154 at kernel/bpf/core.c:578  
bpf_prog_kallsyms_add+0x909/0xaf0 kernel/bpf/core.c:610
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8154 Comm: syz-executor0 Not tainted 4.20.0+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x589 kernel/panic.c:189
  __warn.cold+0x20/0x4b kernel/panic.c:544
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:bpf_prog_ksym_node_add kernel/bpf/core.c:578 [inline]
RIP: 0010:bpf_prog_kallsyms_add+0x909/0xaf0 kernel/bpf/core.c:610
Code: 2d d9 36 00 e9 a4 fe ff ff 31 db 48 c7 c0 f0 db 80 89 e9 a0 fb ff ff  
31 db 48 c7 c0 e8 db 80 89 e9 f6 fc ff ff e8 37 06 f3 ff <0f> 0b e9 c6 f8  
ff ff 48 89 85 10 ff ff ff e8 54 d9 36 00 48 8b 85
RSP: 0018:ffff88808de979b8 EFLAGS: 00010293
RAX: ffff8880901a6280 RBX: ffff88809292c628 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff818e9039 RDI: ffffc90001933020
RBP: ffff88808de97ac8 R08: 1ffff11011bd2f24 R09: ffffed1011bd2f25
R10: ffffed1011bd2f24 R11: 0000000000000003 R12: ffff88809292c5c0
R13: 1ffff11011bd2f48 R14: ffff88808de97aa0 R15: ffffffff899f1c80
  bpf_prog_load+0x13a9/0x1d00 kernel/bpf/syscall.c:1556
  __do_sys_bpf+0xc52/0x4410 kernel/bpf/syscall.c:2618
  __se_sys_bpf kernel/bpf/syscall.c:2580 [inline]
  __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:2580
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f94ae545c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000048 RSI: 0000000020000780 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f94ae5466d4
R13: 00000000004be236 R14: 00000000004ce360 R15: 00000000ffffffff
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
