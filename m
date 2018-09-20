Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674E0ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F6B214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F6B214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeIUBvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:51:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45997 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbeIUBvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:51:11 -0400
Received: by mail-io1-f71.google.com with SMTP id o4-v6so14093979iob.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0qggMsOmF4DbTmazThoyBnsCsKdoxXdPNe+Rp39G39c=;
        b=FItkfkRiH2DKXqgQiuafMteoiYme8d+l39WFjUer/M/iL3TAL+0RUSG7JhhkbGq+s8
         sWyAtd5y1QO94nomrdq3F92NtrT7LwdfmxzxDceQpvif70QAfEVxz6XPxfT2r/uc5hFr
         QJl+HlBgBttcqv8LVx5tPVs7+AJJBsQ6HIHCFPPu469WxUCu7nSjuiD/y47zxZtV4opK
         XczhzKFF8qNpKntM+j8LF71z6qFxkkjCLjlg3OD0/3vSsLAPoJU9TN6gaVfBVxM/+6hx
         FUE26R+YKOvbTz5nyT8n5vXeBFmshUu2mvYhNuw2O49/uj9K/s5dPKd7ho5j1enmgrIq
         D0FA==
X-Gm-Message-State: APzg51BgCxXPu4zcgXZvCz5dTKssVgMIKlrh9u9Wx2VYFNBLw3asp7bU
        cyqX1lYE+NVjQvbcFY7is7PdPwaUl1h4sRQF45YknyLcm6Vp
X-Google-Smtp-Source: ANB0VdZKmyzYh4biq7t985dN2rpJDnR8eDKUurZpoIFAFMMnt11lo6wcYEH7kF5ChJ1DfKUyu26EklC7tGKWiQjPGb7GLQ+eaj16
MIME-Version: 1.0
X-Received: by 2002:a24:9f84:: with SMTP id c126-v6mr3251128ite.29.1537473961966;
 Thu, 20 Sep 2018 13:06:01 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:06:01 -0700
In-Reply-To: <0000000000002b42040573b8495a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ac54e0576530d24@google.com>
Subject: Re: WARNING: refcount bug in igmp_start_timer
From:   syzbot <syzbot+e28037ac1c96d2a86e89@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ae596de1a0c8 Compiler Attributes: naked can be shared
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bdb156400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
dashboard link: https://syzkaller.appspot.com/bug?extid=e28037ac1c96d2a86e89
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178537da400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e28037ac1c96d2a86e89@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 13494 at lib/refcount.c:153  
refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 13494 Comm: syz-executor0 Not tainted 4.19.0-rc4+ #26
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
RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
Code: 1d a2 83 91 06 31 ff 89 de e8 7f 8e ef fd 84 db 75 df e8 a6 8d ef fd  
48 c7 c7 40 82 44 88 c6 05 82 83 91 06 01 e8 63 74 b9 fd <0f> 0b eb c3 0f  
1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
RSP: 0018:ffff8801c7fdeca0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8164fce5 RDI: 0000000000000005
RBP: ffff8801c7fdeca8 R08: ffff8801c67da1c0 R09: ffffed003b5e3ee2
R10: ffffed003b5e3ee2 R11: ffff8801daf1f717 R12: 0000000000000000
R13: 0000000000000008 R14: ffff8801b465f640 R15: dffffc0000000000
  igmp_start_timer+0xaf/0xe0 net/ipv4/igmp.c:217
  igmp_mod_timer net/ipv4/igmp.c:255 [inline]
  igmp_heard_query net/ipv4/igmp.c:1026 [inline]
  igmp_rcv+0x190e/0x3020 net/ipv4/igmp.c:1061
  ip_local_deliver_finish+0x2e9/0xda0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip_rcv+0xed/0x610 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4891
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5001
  netif_receive_skb_internal+0x12c/0x620 net/core/dev.c:5104
  napi_frags_finish net/core/dev.c:5642 [inline]
  napi_gro_frags+0x75a/0xc90 net/core/dev.c:5715
  tun_get_user+0x31d5/0x42a0 drivers/net/tun.c:1965
  tun_chr_write_iter+0xb9/0x154 drivers/net/tun.c:2010
  call_write_iter include/linux/fs.h:1808 [inline]
  do_iter_readv_writev+0x8b0/0xa80 fs/read_write.c:680
  do_iter_write+0x185/0x5f0 fs/read_write.c:959
  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
  do_writev+0x11a/0x310 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457531
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 54 b5 fb ff c3 48  
83 ec 08 e8 1a 2d 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 63 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f1448a89ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000002a RCX: 0000000000457531
RDX: 0000000000000001 RSI: 00007f1448a89bf0 RDI: 00000000000000f0
RBP: 0000000020000240 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000ffffffff
R13: 00000000004d7938 R14: 00000000004c48b4 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..

