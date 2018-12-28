Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD927C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C9E20873
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeL1MvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:51:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:57958 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbeL1MvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:51:04 -0500
Received: by mail-it1-f200.google.com with SMTP id n124so23750356itb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 04:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iBxUiGlVYBdysE0CRhi379EMXjPXiuzCjd8Gysu+gzQ=;
        b=T3XQGFCVhDM0TftDklQV2FxD4Dh3k/oLBFwlfcm/kYItVkrSmndZ1xmOVGvVDZIr2Y
         oDhPeryZYoIqONLGL+WxIzgkDwNj6fk0hZfuXnMMC26/Xx5hRjMW41oqLf40s+jOThGn
         Hfv4Kt8vnwKAl/mv7yYvcECEpfd2xvviktGlDcG3txF32gsI3aDv3B3OvjGzq+Kx1cV7
         DmBGEgdP04Bunym2X3j6iyroO+c5Vv/JrSsaVcn6+ob4wR313q8JBpSavy6V0ttfMNeK
         ltVaWz9ryTs0QtdTomphdAn66gN34XtjdFI8jf4DAM5D6S2if3EYdxbakISn2TfbTnFS
         5UPw==
X-Gm-Message-State: AA+aEWbslGcqeA/Qv2n2/PY/+WkxigTDMJkOqYBhAnNb5RWBpDY0WTwk
        jZ2Qm5oBAbvyKEwkQHk2+1O6GNOe7GmcKRFn1QzQ/cvSzGSM
X-Google-Smtp-Source: AFSGD/UWyaQbLDe5WfNpnRU4EYbDp6ZQP8or7HbCy8uTPEd+wtIsCGXUqYI0MzGhhR/IMYtnYHFpC8j9IQnAZqeYyXRP/vEiYgnS
MIME-Version: 1.0
X-Received: by 2002:a24:a945:: with SMTP id x5mr21141661iti.26.1546001463801;
 Fri, 28 Dec 2018 04:51:03 -0800 (PST)
Date:   Fri, 28 Dec 2018 04:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001282e1057e14848e@google.com>
Subject: WARNING in perf_group_attach
From:   syzbot <syzbot+23fe48cbe532abffa52e@syzkaller.appspotmail.com>
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

HEAD commit:    0072a0c14d5b Merge tag 'media/v4.20-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e6d12b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
dashboard link: https://syzkaller.appspot.com/bug?extid=23fe48cbe532abffa52e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135e93eb400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13189415400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+23fe48cbe532abffa52e@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 6607 at kernel/events/core.c:1833  
perf_group_attach+0x4c1/0x5a0 kernel/events/core.c:1833
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6607 Comm: syz-executor062 Not tainted 4.20.0-rc5+ #141
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:perf_group_attach+0x4c1/0x5a0 kernel/events/core.c:1833
Code: 8d 7c 24 10 48 89 f8 48 c1 e8 03 42 80 3c 30 00 75 51 4d 8b 64 24 10  
49 83 ec 10 4c 39 e3 75 d2 e9 f8 fe ff ff e8 7f ad e9 ff <0f> 0b e9 e0 fc  
ff ff e8 73 06 2d 00 e9 ea fb ff ff e8 69 06 2d 00
RSP: 0018:ffff8881cbf8f5f8 EFLAGS: 00010093
RAX: ffff8881bb87c440 RBX: ffff8881bb6db240 RCX: ffffffff8195eaa6
RDX: 0000000000000000 RSI: ffffffff8195ee41 RDI: ffff8881bb10e398
RBP: ffff8881cbf8f690 R08: ffff8881bb87c440 R09: 0000000000000006
R10: fffffbfff14a7201 R11: 0000000000000001 R12: ffff8881bb10e180
R13: 1ffff110397f1ec1 R14: ffffe8ffffc13098 R15: 0000000000000000
  add_event_to_ctx kernel/events/core.c:2390 [inline]
  __perf_install_in_context+0x5bd/0xb70 kernel/events/core.c:2531
  remote_function+0x12b/0x1a0 kernel/events/core.c:87
  generic_exec_single+0x379/0x5f0 kernel/smp.c:153
  smp_call_function_single+0x25a/0x660 kernel/smp.c:299
  cpu_function_call kernel/events/core.c:141 [inline]
  perf_install_in_context+0x46c/0x510 kernel/events/core.c:2567
  __do_sys_perf_event_open+0x1fa5/0x3020 kernel/events/core.c:10791
  __se_sys_perf_event_open kernel/events/core.c:10420 [inline]
  __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10420
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446619
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fef7efd3db8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446619
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020000000
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffca90267df R14: 00007fef7efd49c0 R15: 00000000006dbc20
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
