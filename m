Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C6C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59557205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59557205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeKBBlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:41:47 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41547 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBBlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:41:46 -0400
Received: by mail-io1-f71.google.com with SMTP id k3-v6so7991147ioq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iwx04Y64soGjaZrxJ2yxkFmJ8Ysh6GrlEEI1FL2WH98=;
        b=ggmrpFYNt7steoau51mAKz/T8KG60CNKp+ZwSRMjzXe5Gkq4DZIR0o4s6Ngozu4hfL
         /zbD5WQqbirfiXv28TkiNhlWMJXk6AZmMaQppOxavCYser0jDFrAC3QVU0T2oY5Dg4f4
         C3/ZvLxjK8pMJSu5kkptxQAEQaUItLPP6bM/GfAjSVe0sdMiHT4wVxZ10yOmrR3RRsUx
         /7V97XYXx9Kogav53CDsjheFydeZBpzIRhdVIGyzsWkIhpskD5nrLNTPNMFqOcjaKkzk
         E8663KauedOAOdQ1j/j/RuZZct/9wb+9pOc5SZJqLE9lyjSVs81i0OzfXnF5fouQFoha
         WZQw==
X-Gm-Message-State: AGRZ1gJcO8q3dEduXUDPrn65m+7pa2t+08soYDSv7jwejpkdF3PGnIIe
        6LWnfkPXNcw4Q8XNrlJ92IIZeW52peuGNI6lm30Rs577pOm5
X-Google-Smtp-Source: AJdET5fHEQuIanblypFWNlP4PSmEttJR4HNcHdRUvsHbht/lMrpl6s99DpxAjv76uckKyWIyn2ZDudSJto1Jr4fNVxgrhWBfRRSS
MIME-Version: 1.0
X-Received: by 2002:a24:610e:: with SMTP id s14-v6mr1862428itc.38.1541090283621;
 Thu, 01 Nov 2018 09:38:03 -0700 (PDT)
Date:   Thu, 01 Nov 2018 09:38:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec1b3805799d0a56@google.com>
Subject: general protection fault in delayed_uprobe_remove
From:   syzbot <syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5b7449810ae6 Merge tag 'tag-chrome-platform-for-v4.20' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15805e33400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e8e3fa31e0cc680
dashboard link: https://syzkaller.appspot.com/bug?extid=eab6e18f95a9fe69005e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1756fca3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8497 Comm: syz-executor3 Not tainted 4.19.0+ #91
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:delayed_uprobe_remove+0x6f/0x140 kernel/events/uprobes.c:339
Code: 00 00 00 48 81 fb 80 f0 5f 89 4c 8b 23 49 bd 00 00 00 00 00 fc ff df  
75 2f e9 98 00 00 00 e8 e8 1d e5 ff 4c 89 e0 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 91 00 00 00 49 81 fc 80 f0 5f 89 49 8b 04 24
RSP: 0018:ffff8801abd97380 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: ffff8801cb304800 RCX: 1ffff100357b5d54
RDX: 0000000000000000 RSI: ffffffff819a5b18 RDI: ffff8801cb304810
RBP: ffff8801abd973a8 R08: ffff8801abdaeaa0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801abdae200 R12: dead000000000100
R13: dffffc0000000000 R14: ffff8801cefeb540 R15: 0000000000000000
FS:  0000000001283940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cc6e0 CR3: 00000001d16cf000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  put_uprobe+0x4d/0x60 kernel/events/uprobes.c:575
  uprobe_unregister+0x56/0x70 kernel/events/uprobes.c:1088
  probe_event_disable.part.16+0x16a/0x2c0 kernel/trace/trace_uprobe.c:990
  probe_event_disable kernel/trace/trace_uprobe.c:1224 [inline]
  trace_uprobe_register+0x52c/0xcf0 kernel/trace/trace_uprobe.c:1223
  perf_trace_event_unreg.isra.3+0xbb/0x220  
kernel/trace/trace_event_perf.c:157
  perf_uprobe_destroy+0xc3/0x130 kernel/trace/trace_event_perf.c:342
  _free_event+0x414/0x1660 kernel/events/core.c:4446
  put_event+0x48/0x60 kernel/events/core.c:4532
  perf_event_release_kernel+0x8d0/0x10e0 kernel/events/core.c:4638
  perf_release+0x37/0x50 kernel/events/core.c:4648
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffda00105b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000730b80 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000730b70 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000033 R15: 0000000000000003
Modules linked in:
---[ end trace 0f8af665f1aa3802 ]---
RIP: 0010:delayed_uprobe_remove+0x6f/0x140 kernel/events/uprobes.c:339
Code: 00 00 00 48 81 fb 80 f0 5f 89 4c 8b 23 49 bd 00 00 00 00 00 fc ff df  
75 2f e9 98 00 00 00 e8 e8 1d e5 ff 4c 89 e0 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 91 00 00 00 49 81 fc 80 f0 5f 89 49 8b 04 24
RSP: 0018:ffff8801abd97380 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: ffff8801cb304800 RCX: 1ffff100357b5d54
RDX: 0000000000000000 RSI: ffffffff819a5b18 RDI: ffff8801cb304810
RBP: ffff8801abd973a8 R08: ffff8801abdaeaa0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801abdae200 R12: dead000000000100
R13: dffffc0000000000 R14: ffff8801cefeb540 R15: 0000000000000000
FS:  0000000001283940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cc6e0 CR3: 00000001d16cf000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
