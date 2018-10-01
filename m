Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1102089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1102089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeJBAxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:53:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43572 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJBAxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:53:06 -0400
Received: by mail-io1-f70.google.com with SMTP id w19-v6so14236048ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MBaykFfwVzMGjhS67y5CPFFKBMEsjgJ//y7GZHgoMTs=;
        b=pvNNWjoZ5pqD3keQXslsGuNb7ZWFewueWOHes/ESyCj7cOb7nANUz3VB0VUnJKrAkx
         EmkOTYoSZ5ndXVEw1EfWHtOZqpw+9QAylPD06NjWg/9V5px+BoTaY8ZvDFK7k60RHcRM
         JrMxIUcakcV9gA6sb3lWhtm6IGsx0i39rpmcHpSVgGcxcts1Hdcz2pfaVFEO186cHuuH
         v4orrEmNRzcqrKLHJTgWRGE0kWqQTMiln16o+hLhV7Mk5on/9LBbSnjwPrjwMYsEtMI9
         pEeQ26mylz4FOlk8Do7EQwrjuZzZVWb72SgRs5ZvugL11SAdeWPR7AjoLibMXnNLJm0d
         zpOw==
X-Gm-Message-State: ABuFfogfvgN/+05P1sEdyarXeE/k/3uGumSEpgcnsk9DmCUbZ2oQUe1G
        wOpb+6Zq9srvz8Le6mmExn9pnYl8aYzbxs/dbwCUVPr+/WaT
X-Google-Smtp-Source: ACcGV624TWZEKid9KCSkR8RXF2zZcyoGYr2lidwmM/vZBtXEoLu3k58HOY34Zltax/0VuEtQ99/aMwZ1lB0+0eEqYPjgCJbkZ+qw
MIME-Version: 1.0
X-Received: by 2002:a24:2752:: with SMTP id g79-v6mr10857275ita.4.1538417644368;
 Mon, 01 Oct 2018 11:14:04 -0700 (PDT)
Date:   Mon, 01 Oct 2018 11:14:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000357da505772ec5ad@google.com>
Subject: WARNING in pcpu_alloc
From:   syzbot <syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c5a9f9817ba5 Merge branch 'bpf-per-cpu-cgroup-local-storage'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175f98e6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=443816db871edd66
dashboard link: https://syzkaller.appspot.com/bug?extid=18628320d3b14a5c459c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129cbd1a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16685ac9400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18628320d3b14a5c459c@syzkaller.appspotmail.com

------------[ cut here ]------------
illegal size (0) or align (8) for percpu allocation
WARNING: CPU: 0 PID: 5355 at mm/percpu.c:1382 pcpu_alloc+0x1359/0x15e0  
mm/percpu.c:1381
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 5355 Comm: syz-executor747 Not tainted 4.19.0-rc5+ #105
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:pcpu_alloc+0x1359/0x15e0 mm/percpu.c:1381
Code: ff e8 2b 9f ff ff e9 70 f4 ff ff e8 01 ee d0 ff 48 8b 95 c8 fd ff ff  
48 c7 c7 40 51 33 88 48 8b b5 e8 fd ff ff e8 87 d4 9a ff <0f> 0b 31 db e9  
29 ee ff ff e8 d9 ed d0 ff e8 04 f8 b9 ff 31 ff 41
RSP: 0018:ffff8801d8fef840 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81650cb5 RDI: 0000000000000005
RBP: ffff8801d8fefab8 R08: ffff8801d8ec23c0 R09: ffffed003b584fe8
R10: ffffed003b584fe8 R11: ffff8801dac27f47 R12: 00000000006280c0
R13: ffffffffffffffff R14: 0000000000000008 R15: ffff8801bfc70034
  __alloc_percpu_gfp+0x27/0x30 mm/percpu.c:1545
  bpf_cgroup_storage_alloc+0x2d6/0x380 kernel/bpf/local_storage.c:393
  bpf_test_run+0xd1/0x780 net/bpf/test_run.c:37
  bpf_prog_test_run_skb+0x634/0xb40 net/bpf/test_run.c:155
  bpf_prog_test_run+0x130/0x1a0 kernel/bpf/syscall.c:1772
  __do_sys_bpf kernel/bpf/syscall.c:2409 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2353 [inline]
  __x64_sys_bpf+0x3d8/0x510 kernel/bpf/syscall.c:2353
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440379
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd94681f78 EFLAGS: 00000217 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440379
RDX: 0000000000000028 RSI: 0000000020000180 RDI: 000000000000000a
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000401c00
R13: 0000000000401c90 R14: 0000000000000000 R15: 0000000000000000
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
