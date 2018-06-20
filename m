Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76746C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F1C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F1C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeFTFeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:34:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:51188 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeFTFeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:34:02 -0400
Received: by mail-it0-f69.google.com with SMTP id g125-v6so2041878ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=unsDyOAZyR7h7Ib+1PNxAX+gE5lDiQarTk94RMTYtI4=;
        b=IOVT5QQdjLE6McxCNLo+VU7EKi0QsnEenAzUk+D5x/Joa7p7BeiRejWfiI8pqqCINA
         01zvtsL/jmu/9Iwa22Mxtc3FOTZA8ouGnEwJ3dH5sq35/xcMnNwR8fuVKSgWoqG0/LwH
         XbHG3DwaLPVQL1L0gMyM0jQfPTsr06D5gEC7atWifPITiVkNGSyUnIpu+/E+4cNb7gmC
         uNTSr2ja9Ddm3TNTJdOTF4oLtzoPVYOM9oCkpwhL6XMaPU/FMcl3bmkW7MpUNmRxYWTD
         wmYDF2Od16QjfzfYjOpMYkUoKMocvIWPWx/483dE+X2KGzJOXYeFK7eAB0IE4K1Eyrfy
         6EKQ==
X-Gm-Message-State: APt69E14iXTuCq0sn8VsmCtd4bK5deOiNJlf2O69L5j7c+Mnj9/xcAhp
        7Iv4AWnr9dbTaYnIK8McZvf3sbfd+7jAFKUrWS11gdZka0f6
X-Google-Smtp-Source: ADUXVKJ1W1ui/kiNAaDacpFUbbomLRZ27KsU0API/RlhW5+wQ2a4Z1K6jbgJTE6NOtU7k9fHgWYmEfWqW9BNjTe9mytzozzpKMUu
MIME-Version: 1.0
X-Received: by 2002:a24:534b:: with SMTP id n72-v6mr202704itb.11.1529472841561;
 Tue, 19 Jun 2018 22:34:01 -0700 (PDT)
Date:   Tue, 19 Jun 2018 22:34:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a3ec5056f0c25cb@google.com>
Subject: general protection fault in tls_push_sg
From:   syzbot <syzbot+54bcc120da8da091d609@syzkaller.appspotmail.com>
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

HEAD commit:    ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/klei..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112e9ce4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f390986c4f7cd566
dashboard link: https://syzkaller.appspot.com/bug?extid=54bcc120da8da091d609
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+54bcc120da8da091d609@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor0'.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 27979 Comm: syz-executor6 Not tainted 4.18.0-rc1+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
RIP: 0010:put_page include/linux/mm.h:911 [inline]
RIP: 0010:tls_push_sg+0x2a3/0x880 net/tls/tls_main.c:142
Code: fa 4d 39 e5 75 a2 e8 bc 50 f1 fa 48 8b 85 08 ff ff ff 49 8d 7f 08 48  
b9 00 00 00 00 00 fc ff df c6 00 00 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f  
85 50 05 00 00 48 8b 85 08 ff ff ff 49 8b 5f 08 80
RSP: 0018:ffff8801c5776d90 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff868a59e4 RDI: 0000000000000008
RBP: ffff8801c5776eb0 R08: ffff88018e4fc6c0 R09: ffff8801c5776668
R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f2d08c17700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000001ffffcc0 CR3: 0000000188ce8000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tls_push_record+0xaec/0x1400 net/tls/tls_sw.c:264
  tls_sw_push_pending_record+0x22/0x30 net/tls/tls_sw.c:276
  tls_handle_open_record net/tls/tls_main.c:164 [inline]
  tls_sk_proto_close+0x74c/0xae0 net/tls/tls_main.c:264
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:603
  sock_close+0x19/0x20 net/socket.c:1186
  __fput+0x35b/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1b08/0x2750 kernel/exit.c:865
  do_group_exit+0x177/0x440 kernel/exit.c:968
  get_signal+0x88e/0x1970 kernel/signal.c:2468
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2de/0x370 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455b29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2d08c16ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000072bec8 RCX: 0000000000455b29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec8
RBP: 000000000072bec8 R08: 0000000000000033 R09: 000000000072bea0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000a3e81f R14: 00007f2d08c179c0 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace d9dfd7279b1a9c99 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:142 [inline]
RIP: 0010:put_page include/linux/mm.h:911 [inline]
RIP: 0010:tls_push_sg+0x2a3/0x880 net/tls/tls_main.c:142


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
