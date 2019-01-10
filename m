Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85B320675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfAJRlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:41:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:42520 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbfAJRlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:41:05 -0500
Received: by mail-it1-f197.google.com with SMTP id g7so11733777itg.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nRtk8w+0oDvIHpE8NGWDlETPglaUAsRlbSgmxbpAtnY=;
        b=lsWVAHyWDDEYQvm8zELtl/l/uyiES1gjJ7YokISojMJEKdiuSWpAh0Anu7eCQPvv+A
         cUWGZUWUIilCkF9eSWyiEwpAt5bW9MArWgpVGIbrGROI2vtcaINlHr4/hVlKnCSnvszh
         DccKitRi7mLgVl+uw25h+n3cRQaPMwHZtGyxRYxfLds7nT7Q2CVox2U76MbfhpLdDC54
         p+wJcuvAGXW0oWxK3LW5N3SUue5X/jYJtNrAyOilhdixbqd319rZgZaZ4twzjKEsZ2mT
         PxERVWIcK2IDMeHmAv5Yr9713HzotKpgkLGRGMC+9CZNqEsWbDGiRAOoq7HMHgD3m5H7
         PP7A==
X-Gm-Message-State: AJcUukc7WAKF1naRxAN6r6rwqN8HU90lAzy74GItLBwU+dqLYE3VA+L+
        vq/kwxm4ftSp/0gkwmbEDn1FGQmIpMFtmYnQshOKuvkP7HJw
X-Google-Smtp-Source: ALg8bN5UALuMCEalr5+t24UcBKiHKEDBNxsmYm/VbRVGNUOIIzf3o7GXAenp/1OETLPYwjotF7Um8a3cIyvfPR1PVYrtjPGFNul+
MIME-Version: 1.0
X-Received: by 2002:a5e:8707:: with SMTP id y7mr5051663ioj.30.1547142064355;
 Thu, 10 Jan 2019 09:41:04 -0800 (PST)
Date:   Thu, 10 Jan 2019 09:41:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029bf02057f1e1596@google.com>
Subject: general protection fault in gro_cells_destroy
From:   syzbot <syzbot+6fe674089f9deb9f7726@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, lorenzo.bianconi@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14314bab400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=6fe674089f9deb9f7726
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6fe674089f9deb9f7726@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 14812 Comm: kworker/u4:8 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:__skb_unlink include/linux/skbuff.h:1924 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:1941 [inline]
RIP: 0010:__skb_queue_purge include/linux/skbuff.h:2655 [inline]
RIP: 0010:gro_cells_destroy net/core/gro_cells.c:89 [inline]
RIP: 0010:gro_cells_destroy+0x19d/0x360 net/core/gro_cells.c:78
Code: 03 42 80 3c 20 00 0f 85 53 01 00 00 48 8d 7a 08 49 8b 47 08 49 c7 07  
00 00 00 00 48 89 f9 49 c7 47 08 00 00 00 00 48 c1 e9 03 <42> 80 3c 21 00  
0f 85 10 01 00 00 48 89 c1 48 89 42 08 48 c1 e9 03
RSP: 0018:ffff888069e674b0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffe8ffffc30a98 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8634f68a RDI: 0000000000000008
RBP: ffff888069e67510 R08: ffff88806a2666c0 R09: fffffbfff1460a79
R10: fffffbfff1460a78 R11: ffffffff8a3053c3 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffe8ffffc30aa8 R15: ffffe8ffffc38a90
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fef1a1b8db8 CR3: 00000000930be000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_tunnel_dev_free+0x19/0x60 net/ipv4/ip_tunnel.c:969
  netdev_run_todo+0x647/0xae0 net/core/dev.c:8885
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  ip_tunnel_delete_nets+0x4df/0x6d0 net/ipv4/ip_tunnel.c:1083
  ipgre_exit_batch_net+0x23/0x30 net/ipv4/ip_gre.c:1062
  ops_exit_list.isra.0+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 2f40089cb2525ccd ]---
RIP: 0010:__skb_unlink include/linux/skbuff.h:1924 [inline]
RIP: 0010:__skb_dequeue include/linux/skbuff.h:1941 [inline]
RIP: 0010:__skb_queue_purge include/linux/skbuff.h:2655 [inline]
RIP: 0010:gro_cells_destroy net/core/gro_cells.c:89 [inline]
RIP: 0010:gro_cells_destroy+0x19d/0x360 net/core/gro_cells.c:78
Code: 03 42 80 3c 20 00 0f 85 53 01 00 00 48 8d 7a 08 49 8b 47 08 49 c7 07  
00 00 00 00 48 89 f9 49 c7 47 08 00 00 00 00 48 c1 e9 03 <42> 80 3c 21 00  
0f 85 10 01 00 00 48 89 c1 48 89 42 08 48 c1 e9 03
RSP: 0018:ffff888069e674b0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffe8ffffc30a98 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8634f68a RDI: 0000000000000008
RBP: ffff888069e67510 R08: ffff88806a2666c0 R09: fffffbfff1460a79
R10: fffffbfff1460a78 R11: ffffffff8a3053c3 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffe8ffffc30aa8 R15: ffffe8ffffc38a90
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fef1a1b8db8 CR3: 00000000930be000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
