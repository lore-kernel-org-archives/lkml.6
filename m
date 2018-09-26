Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE01C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E23B20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E23B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeIZOAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:00:43 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:52428 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeIZOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:00:41 -0400
Received: by mail-it1-f197.google.com with SMTP id e9-v6so2111573itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=K3w9qSZxaKB4Z/XRI9rADPLf7exWPkmmorsjYnJ/yYI=;
        b=G15opQxD9RLDliY4M+k7VByD7qg2k4IcFS24kGHTPDnsAqU0OKP+iTaBTc/nDvCdaO
         ew3gJX+4i8UozaIvTeFD95O08iVKHNrtImHcEL81XKZfDKzRUC2HmV6h/z7oAHaRCqv1
         FiaM+8lE9m+fgQDaGNoCAILejKIQrOZcRv6ou5oYGBToI3uxS6Qv3k5N/lym8LlpeK+P
         CAHXaAj0t0DxH66p0F4pFt7jEq2KAJFC5yszzAFhuAmKGz7nVjtiJfm6fkNGd/rRYV+x
         Y+jJsM8ctGnRRmQHRQajmviKigzc4MMpsYz56ux0gMWZy7zHD3oaLmSmAGi49IwZV1LY
         otNw==
X-Gm-Message-State: ABuFfojnxijsH2+NEZpmD737pVuHe6rQpUT6V1avADvKuye72tnUH5/X
        vsz9oa7myQ4QQKWrSgwe+r8E1tERy6vw8Zj474mnMX05KG+d
X-Google-Smtp-Source: ACcGV61YopYHZIQcOlvbn5KU/fJNBH0HoM//OTL8KFAY8OzZhYoy/CB543MAKjM7/CkHlv8Y7gEJp6pZBkm38OFiHD7cTQllrNxw
MIME-Version: 1.0
X-Received: by 2002:a24:68c6:: with SMTP id v189-v6mr3298253itb.11.1537948143887;
 Wed, 26 Sep 2018 00:49:03 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:49:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ccb25d0576c17446@google.com>
Subject: KASAN: slab-out-of-bounds Read in tls_push_record
From:   syzbot <syzbot+942a1909765f0413329b@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, davejwatson@fb.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    739d0def85ca Merge branch 'hv_netvsc-Support-LRO-RSC-in-th..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13aa179e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79b9299baeb2298
dashboard link: https://syzkaller.appspot.com/bug?extid=942a1909765f0413329b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+942a1909765f0413329b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in sg_mark_end  
include/linux/scatterlist.h:195 [inline]
BUG: KASAN: slab-out-of-bounds in tls_push_record+0x1243/0x1330  
net/tls/tls_sw.c:521
Read of size 8 at addr ffff8801a4d235f8 by task syz-executor1/7668

CPU: 1 PID: 7668 Comm: syz-executor1 Not tainted 4.19.0-rc4+ #228
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  sg_mark_end include/linux/scatterlist.h:195 [inline]
  tls_push_record+0x1243/0x1330 net/tls/tls_sw.c:521
  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:558
  tls_handle_open_record net/tls/tls_main.c:155 [inline]
  tls_sk_proto_close+0x439/0x750 net/tls/tls_main.c:272
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411151
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff8ba9e200 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411151
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 00007fff8ba9e130 R11: 0000000000000293 R12: 000000000000000f
R13: 0000000000086e3d R14: 0000000000000412 R15: badc0ffeebadface

Allocated by task 0:
(stack is not available)

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8801a4d22d80
  which belongs to the cache kmalloc-2048 of size 2048
The buggy address is located 120 bytes to the right of
  2048-byte region [ffff8801a4d22d80, ffff8801a4d23580)
The buggy address belongs to the page:
page:ffffea0006934880 count:1 mapcount:0 mapping:ffff8801da800c40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea000717fd08 ffff8801da801948 ffff8801da800c40
raw: 0000000000000000 ffff8801a4d22500 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801a4d23480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801a4d23500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8801a4d23580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                                 ^
  ffff8801a4d23600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801a4d23680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
