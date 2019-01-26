Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41BDC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAE9218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfAZMHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:07:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:32797 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZMHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:07:05 -0500
Received: by mail-it1-f199.google.com with SMTP id w68so4938024ith.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 04:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CDA20dGJi/6N8+F25zG4Lb+7/+xT9LttKFwIoMoWOh0=;
        b=ng+3W8ACof0OsJKAEdLiyMhCFEevxyaX2XSD+Drhyj8x9rtuDtP2Bzb6PpOHgBUu3P
         x/32p4ENS5yRTLlATpHPcFb9JEqYpGjexVHGFz2w2GTSga+z1Hebemw125elkezHfa87
         68vjo4rMa5QVvSpaYyz4AbLw7ddYA2QOPKFvvrqbq0yhsOaXTtf5viThJ0JIzYn9zDs2
         DhcVhJdBzvUPEfgMrOax5llhYARSywG4fPugwmRpLJi2ORkz0GoYjJc0eYH8tJCezGfX
         K1CLa/hOFM3lNRAUH5f+/M7vLyF/ecQZyrrwrGny7pu3JBcuQ0V4NYGUGCyK9pjKLjOO
         C1Cw==
X-Gm-Message-State: AHQUAuaclusJhwtt+wq/gGMyb4lWxk6D/k4T7mrigKfVKVMXJyyi+BFv
        RyLthJqnB6+KfrNwpupkqtyMGOpX0ayPsS6HP9OA+mruFznV
X-Google-Smtp-Source: AHgI3IZ9Q1t9cfCl83w5S1uEvrrPdxCPnQr+KHOXSoHPtCts4W6zEzDK9dI18UE7tp1QTBgUANX3JBKkeoSh2OdhNBS87KNz6kQw
MIME-Version: 1.0
X-Received: by 2002:a5d:9b81:: with SMTP id r1mr12486026iom.38.1548504423663;
 Sat, 26 Jan 2019 04:07:03 -0800 (PST)
Date:   Sat, 26 Jan 2019 04:07:03 -0800
In-Reply-To: <0000000000007b7cbf057edb4e33@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b122305805b4843@google.com>
Subject: Re: KASAN: out-of-bounds Read in unwind_next_frame
From:   syzbot <syzbot+2fdf0ed2b3bc8fc51fc6@syzkaller.appspotmail.com>
To:     bp@alien8.de, dvyukov@google.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ba6069759381 Merge tag 'mmc-v5.0-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121e935f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=2fdf0ed2b3bc8fc51fc6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6c887400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2fdf0ed2b3bc8fc51fc6@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
8021q: adding VLAN 0 to HW filter on device batadv0
==================================================================
BUG: KASAN: out-of-bounds in unwind_next_frame.part.0+0x756/0xa90  
arch/x86/kernel/unwind_frame.c:324
Read of size 8 at addr ffff88809476fb68 by task syz-executor1/12572

CPU: 1 PID: 12572 Comm: syz-executor1 Not tainted 5.0.0-rc3+ #44
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
RIP: 0033:0x458099
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fedc3d91c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458099
RDX: 1000000000000156 RSI: 0000000020000480 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fedc3d926d4
R13: 00000000004c4b67 R14: 00000000004d82e0 R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea000251dbc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x1fffc0000000000()
raw: 01fffc0000000000 0000000000000000 ffffffff02510101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809476fa00: 00 f2 f2 00 f2 f2 f2 00 f2 f2 f2 00 f2 f2 f2 f8
  ffff88809476fa80: f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88809476fb00: f1 f1 f1 f1 00 f2 f2 f2 00 f3 f3 f3 00 00 00 00
                                                           ^
  ffff88809476fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
  ffff88809476fc00: f1 f1 00 f2 f2 f2 00 00 f2 f2 04 f3 f3 f3 00 00
==================================================================

