Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RIBTCOzBHFuxdQAAmS7hNA
	; Sun, 10 Jun 2018 06:15:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 015D160795; Sun, 10 Jun 2018 06:15:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEXHASH_WORD,MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 432E5605A5;
	Sun, 10 Jun 2018 06:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 432E5605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeFJGPF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:15:05 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:44095 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbeFJGPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:15:03 -0400
Received: by mail-it0-f72.google.com with SMTP id 202-v6so6261555itw.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 23:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ev+bgdIkRKiqynULoi0QZk4wgozqT6rxIjrRZ+J15SY=;
        b=Ilwgs6wG+LZMn25uBJCkymgwdinWn3iRZNZI1Ec0gsDsbr27V1rpDpxsRynsZYw+Fi
         nrDNSFk+Mxi8myoe1mBWVUp8lvcTUpf+q33DrhalihXDQEUmZgZfFtGl46iEuOq1C5CE
         PAsf9anDS7Gzgu50EwAbuExAs+eHaQmtpHp2M5SMicEpsklteZMhRPigCVhyhFYMQE+C
         dMhMzDMO7qZmDjdAiBoEUJ5WVltdiodvkE9eVo79Z7Wz3kLgZOQyjrbxyEJDoKx38g/a
         7HxqcgSf0Gj+GruFShHyJ18ZvCaWpZZQousohkeU7AV7nQtqRycyUZptWCLj/y2oplE/
         jfAA==
X-Gm-Message-State: APt69E0kcEvfNB6rOjTgMO+7tzuM03xTKvUqGm9kmHiik00xoSZbs1YE
        Q4PHQbZAxbX4G+LC6K5fhjenx0djhyu3sh5wIw/SYrNHHvxn
X-Google-Smtp-Source: ADUXVKJ13CSPkH6Bigrc0b9cKRTd2KM84OIaY/dOgCNZnuGgwvFm0xsTNzpDvyyxghsSh894uVQ9y+OobX+jDHTDQg+u9Ubwoqpb
MIME-Version: 1.0
X-Received: by 2002:a6b:700a:: with SMTP id l10-v6mr5725202ioc.60.1528611302687;
 Sat, 09 Jun 2018 23:15:02 -0700 (PDT)
Date: Sat, 09 Jun 2018 23:15:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b24d0c056e438d2d@google.com>
Subject: KASAN: slab-out-of-bounds Write in tls_push_record
From: syzbot <syzbot+5c74af81c547738e1684@syzkaller.appspotmail.com>
To: aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    410feb75de24 Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1308a0cf800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c0dfd1fff57e223
dashboard link: https://syzkaller.appspot.com/bug?extid=5c74af81c547738e1684
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5c74af81c547738e1684@syzkaller.appspotmail.com

RDX: 00000000fffffdef RSI: 00000000200005c0 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000020000000 R09: 000000000000001c
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000015
R13: 00000000004c0d3b R14: 00000000004d07a8 R15: 0000000000000002
==================================================================
BUG: KASAN: slab-out-of-bounds in tls_fill_prepend include/net/tls.h:339  
[inline]
BUG: KASAN: slab-out-of-bounds in tls_push_record+0x1023/0x13e0  
net/tls/tls_sw.c:240
Write of size 1 at addr ffff8801bae68000 by task syz-executor1/24187

CPU: 1 PID: 24187 Comm: syz-executor1 Not tainted 4.17.0+ #91
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
  __asan_report_store1_noabort+0x17/0x20 mm/kasan/report.c:435
  tls_fill_prepend include/net/tls.h:339 [inline]
  tls_push_record+0x1023/0x13e0 net/tls/tls_sw.c:240
  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
  tls_push_pending_closed_record+0x10c/0x150 net/tls/tls_main.c:211
  tls_complete_pending_work include/net/tls.h:277 [inline]
  tls_sk_proto_close+0x8f2/0xad0 net/tls/tls_main.c:263
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  sock_release+0x96/0x1b0 net/socket.c:598
  sock_close+0x16/0x20 net/socket.c:1174
  __fput+0x353/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2478
  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4559f9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb96babace8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bec8 RCX: 00000000004559f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec8
RBP: 000000000072bec8 R08: 0000000000000033 R09: 000000000072bea0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd163d2bff R14: 00007fb96babb9c0 R15: 0000000000000000

Allocated by task 24192:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  rw_copy_check_uvector+0x31e/0x3a0 fs/read_write.c:781
  import_iovec+0xc3/0x420 lib/iov_iter.c:1459
  vfs_readv+0xe2/0x1a0 fs/read_write.c:984
  do_preadv+0x1ba/0x270 fs/read_write.c:1070
  __do_sys_preadv fs/read_write.c:1120 [inline]
  __se_sys_preadv fs/read_write.c:1115 [inline]
  __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1115
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 24192:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x260 mm/slab.c:3813
  import_iovec+0x32e/0x420 lib/iov_iter.c:1463
  vfs_readv+0xe2/0x1a0 fs/read_write.c:984
  do_preadv+0x1ba/0x270 fs/read_write.c:1070
  __do_sys_preadv fs/read_write.c:1120 [inline]
  __se_sys_preadv fs/read_write.c:1115 [inline]
  __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1115
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801bae69f80
  which belongs to the cache kmalloc-16384 of size 16384
The buggy address is located 8064 bytes to the left of
  16384-byte region [ffff8801bae69f80, ffff8801bae6df80)
The buggy address belongs to the page:
page:ffffea0006eb9a00 count:1 mapcount:0 mapping:ffff8801da802200 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0005e2a408 ffff8801da801c48 ffff8801da802200
raw: 0000000000000000 ffff8801bae69f80 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801bae67f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801bae67f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801bae68000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff8801bae68080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801bae68100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
