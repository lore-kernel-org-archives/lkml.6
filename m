Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA2C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1408B20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeILPDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:03:52 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:51901 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeILPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:03:51 -0400
Received: by mail-it0-f69.google.com with SMTP id q5-v6so2617239ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iFoVK46G1bsEUOnv21aHako/+4Nd9ZSIr2phdnTG05c=;
        b=ocawVS0XM+OrIusZIeFecgKPltAa13Bh4paWeVHTXAjeKB66K8ZyLpZme/Gv6Z1u5G
         0x7KuyUPTKc0iM6PNujnNBS4Ze+5H3ze6MjCVbCt8Z6wsSe6lLmckwt+kPJd8QHL6yvE
         o1OsWI07/XivIq07n/wNm/rUzdq1NYBr98NBVRIfxBY+NeN8uSitSYuFSATawHosOO0f
         N+k3+l9dtk1/hHirg/g7Wwo8+RFeDy2XXeilDtvKCRnwKXnr/RGctTsuXOULsAAuyBDO
         WiE8yLhzJ3r8X5VekQwE20STKZxC+vVg6lRBGA0wLWAkf0p1BQSglx7VTpTeFd7LimAz
         9apg==
X-Gm-Message-State: APzg51CjzDxyKpMZwTB8nNAAoVZC7WpICrGUrmAccz1rpebA6pdainiD
        mIzNoDKgIwaOS6wkuKkGDLrQ3SeQ5XYJncz8Ze52/JGYB5M2
X-Google-Smtp-Source: ANB0VdaUJmy/EP7EFp62vWZAXry/cy+t24+CHQBLlyTVDCO0b16/7JPMwAhnVkYWHCoMDwZQJKGQ2a6CatYa8IuXgvrvAWswbUBz
MIME-Version: 1.0
X-Received: by 2002:a02:129c:: with SMTP id 28-v6mr739259jap.10.1536746402644;
 Wed, 12 Sep 2018 03:00:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 03:00:02 -0700
In-Reply-To: <00000000000006602605752ffa1a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000708fdd0575a9a74c@google.com>
Subject: Re: general protection fault in tcp_cleanup_ulp
From:   syzbot <syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=127f5b49400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=0b3ccd4f62dac2cf3a7d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13537269400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b3ccd4f62dac2cf3a7d@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 18627 Comm: syz-executor0 Not tainted 4.19.0-rc2+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:tcp_cleanup_ulp+0xbe/0x140 net/ipv4/tcp_ulp.c:131
Code: 02 00 0f 85 8a 00 00 00 49 8b 9c 24 88 06 00 00 e8 b7 43 ec fa 48 8d  
7b 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
51 48 8b 7b 38 e8 b3 a2 e0 fa 4c 89 ea 48 b8 00 00
RSP: 0018:ffff8801b92f76c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff10037e84da6
RDX: 0000000000000007 RSI: ffffffff86928b79 RDI: 0000000000000038
RBP: ffff8801b92f76e0 R08: 0000000000000000 R09: ffffed003b5c4732
R10: ffffed003b5c4732 R11: ffff8801dae23993 R12: ffff8801be338f40
R13: ffff8801be3395c8 R14: ffffffff81938ae0 R15: ffff8801b92f7800
FS:  0000000001a06940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4d5d4b8db8 CR3: 00000001bc421000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tcp_v4_destroy_sock+0x161/0x990 net/ipv4/tcp_ipv4.c:1978
  tcp_v6_destroy_sock+0x15/0x20 net/ipv6/tcp_ipv6.c:1762
  inet_csk_destroy_sock+0x19f/0x440 net/ipv4/inet_connection_sock.c:835
  tcp_close+0xba7/0x1300 net/ipv4/tcp.c:2477
  bpf_tcp_close+0x93c/0x10c0 kernel/bpf/sockmap.c:384
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:457
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1139
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410e91
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffd70bafde0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000410e91
RDX: 0000000000000000 RSI: 0000000000731160 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffffffffff
R10: 00000000009300a0 R11: 0000000000000293 R12: 0000000000000008
R13: 00000000000dc3fa R14: 0000000000000875 R15: badc0ffeebadface
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace d9e209a7bdcaec58 ]---
RIP: 0010:tcp_cleanup_ulp+0xbe/0x140 net/ipv4/tcp_ulp.c:131
Code: 02 00 0f 85 8a 00 00 00 49 8b 9c 24 88 06 00 00 e8 b7 43 ec fa 48 8d  
7b 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
51 48 8b 7b 38 e8 b3 a2 e0 fa 4c 89 ea 48 b8 00 00
RSP: 0018:ffff8801b92f76c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff10037e84da6
RDX: 0000000000000007 RSI: ffffffff86928b79 RDI: 0000000000000038
RBP: ffff8801b92f76e0 R08: 0000000000000000 R09: ffffed003b5c4732
R10: ffffed003b5c4732 R11: ffff8801dae23993 R12: ffff8801be338f40
R13: ffff8801be3395c8 R14: ffffffff81938ae0 R15: ffff8801b92f7800
FS:  0000000001a06940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4d5d4b8db8 CR3: 00000001bc421000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

