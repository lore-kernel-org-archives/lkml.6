Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A417DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782152147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfAGKBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:01:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:60313 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfAGKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:01:04 -0500
Received: by mail-it1-f200.google.com with SMTP id t143so138743itc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TNXwLqjDBn3P29xhDmqyoMsWXnpYFx9u7rQGixt3hiU=;
        b=BYH86XeoLD6THZ766zTXCU/U04Q1SL3mcRorVhrTTf2bclRtOXfxwhUff19vHPBMWP
         A2PbuB+PQ8XYizaRerO/vPg3uR1HuA2qat0rJFTfeQaNUkxkV8t+rTV7HP+aHYbjP/2E
         4Jk+eZxcLwK4CLd7ySdq083qYaj+25WprUJWyDDxwAh1sc+VRJ9gqY5QZGg0P7seTtea
         ZVW7KO4VhNdK1e1DtHNj4vm+d0EcxGUT5LFExYNsd+pbHoSndYxcACcvuhydudESvK+o
         4IaL7N01Ck4NrdcXmkaKtRqPRMcqQ+0nx8k7C9qRqDy8eG7YgbsfhWwZ2OnIh547AhOd
         0j1g==
X-Gm-Message-State: AJcUukfslGQxvxGSn5yGe+SH3L0wOCzd1h/Y9BMjNsYJ9R/Qn/eoCM/4
        LU4yNw8fxv8w37rh8ZfXLSEK/NJyQ00qdv3dhgYCrcV5bHoM
X-Google-Smtp-Source: ALg8bN6ZI+SJnNcSfVaDKF2tFQVZGjiWKORqZhftMaWQZWsSaVi0iO2oYi6zgGxKa3yGXTgSLUOa7fW6+xOyiwdgLDQV1mclp3Dw
MIME-Version: 1.0
X-Received: by 2002:a24:4245:: with SMTP id i66mr8012624itb.35.1546855263201;
 Mon, 07 Jan 2019 02:01:03 -0800 (PST)
Date:   Mon, 07 Jan 2019 02:01:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b7cbf057edb4e33@google.com>
Subject: KASAN: out-of-bounds Read in unwind_next_frame
From:   syzbot <syzbot+2fdf0ed2b3bc8fc51fc6@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b5aef86e089a Merge tag 'docs-5.0-fixes' of git://git.lwn.n..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1034c54b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
dashboard link: https://syzkaller.appspot.com/bug?extid=2fdf0ed2b3bc8fc51fc6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2fdf0ed2b3bc8fc51fc6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in unwind_next_frame.part.0+0x756/0xa90  
arch/x86/kernel/unwind_frame.c:324
Read of size 8 at addr ffff88805082fb68 by task syz-executor2/21500

CPU: 0 PID: 21500 Comm: syz-executor2 Not tainted 4.20.0+ #12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  unwind_next_frame.part.0+0x756/0xa90 arch/x86/kernel/unwind_frame.c:324
  unwind_next_frame+0x3b/0x50 arch/x86/kernel/unwind_frame.c:287
  __save_stack_trace+0x7a/0xf0 arch/x86/kernel/stacktrace.c:44
  save_stack_trace_tsk arch/x86/kernel/stacktrace.c:76 [inline]
  save_stack_trace_tsk+0x9e/0xd0 arch/x86/kernel/stacktrace.c:69
  proc_pid_stack+0x272/0x430 fs/proc/base.c:438
  proc_single_show+0xf6/0x180 fs/proc/base.c:739
  seq_read+0x4db/0x1130 fs/seq_file.c:229
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_loop_readv_writev fs/read_write.c:687 [inline]
  do_iter_read+0x4a9/0x660 fs/read_write.c:921
  vfs_readv+0x175/0x1c0 fs/read_write.c:983
  do_preadv+0x1c4/0x280 fs/read_write.c:1067
  __do_sys_preadv fs/read_write.c:1117 [inline]
  __se_sys_preadv fs/read_write.c:1112 [inline]
  __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1112
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8d6c5e5c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457ec9
RDX: 00000000000001a1 RSI: 00000000200017c0 RDI: 0000000000000005
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8d6c5e66d4
R13: 00000000004c4861 R14: 00000000004d7d20 R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea0001420bc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x1fffc0000000000()
raw: 01fffc0000000000 0000000000000000 ffffffff01420101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88805082fa00: 00 f2 f2 00 f2 f2 f2 00 f2 f2 f2 00 f2 f2 f2 f8
  ffff88805082fa80: f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88805082fb00: f1 f1 f1 f1 00 f2 f2 f2 00 f3 f3 f3 00 00 00 00
                                                           ^
  ffff88805082fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
  ffff88805082fc00: f1 f1 00 f2 f2 f2 00 00 f2 f2 04 f3 f3 f3 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
