Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8217ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D98220866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 12:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D98220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIOSL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 14:11:58 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:44785 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeIOSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 14:11:57 -0400
Received: by mail-it0-f72.google.com with SMTP id b124-v6so6512417itb.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n5WjnVAZaEvppg/ZQ4by1+IQvcDcuRGF/QYwt2NjxlQ=;
        b=RpmoFzCFK7rpGHPgMzQTcCE6IL4C/RGhCOgNMAS3wW6J/7M+pZ800AK2jzeA6XIIQ/
         Y1+boNpCNGq+szb5+MCzNzlVpKWWG3JhNBLllE5uZ1ATBTHAJ1FxUhBXsF0sXPUaRkMj
         q4n5KsqOiOiE3I4uJTzAlZEmnjufPbEbQUbt6F+bgMPDlCpPwNm1ohim39zMPK8hN/2/
         HUBSXWLM0eVq7fwKQiikqormnNHtF9OV//qwjKjeUyeFUaTVY8yLZkZstihbHiTi1zHS
         YmuJqPykAcY4OCvp6Hi1kkCbBFQAam/GvsCWHPocnKVij4+Vmn/fhYxdDdCLnJJrD2U3
         qyqA==
X-Gm-Message-State: APzg51B9tqFkHTrfxYZweOpbL4BbuA+qgTL1iX32CY3xLQmMA/WQDZ9E
        oQo7BxZvudy7R4QgGyHaZS3lx0mai16wfMbkGAsPPEp5yJYY
X-Google-Smtp-Source: ANB0VdZ0Zd6jU/N8nt/OINtF2zFpQcWUg23rVcRg7maccePXf9MJSX+bAVyrppuioocUfPyl2i2FtgIcQsx1CWxpg7RX3MntF48z
MIME-Version: 1.0
X-Received: by 2002:a6b:8b58:: with SMTP id n85-v6mr12920854iod.138.1537015982804;
 Sat, 15 Sep 2018 05:53:02 -0700 (PDT)
Date:   Sat, 15 Sep 2018 05:53:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab5ff60575e86bb9@google.com>
Subject: KMSAN: uninit-value in bond_start_xmit (2)
From:   syzbot <syzbot+e5be16aa39ad6e755391@syzkaller.appspotmail.com>
To:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vfalico@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    401f0ab26c43 kmsan: unpoison pages in do_read_cache_page()
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=17b808ae400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be230b6f0ad3490
dashboard link: https://syzkaller.appspot.com/bug?extid=e5be16aa39ad6e755391
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124d16da400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175f06be400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e5be16aa39ad6e755391@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in bond_xmit_roundrobin  
drivers/net/bonding/bond_main.c:3858 [inline]
BUG: KMSAN: uninit-value in __bond_start_xmit  
drivers/net/bonding/bond_main.c:4136 [inline]
BUG: KMSAN: uninit-value in bond_start_xmit+0x1ab8/0x2b90  
drivers/net/bonding/bond_main.c:4170
CPU: 0 PID: 4319 Comm: syz-executor658 Not tainted 4.19.0-rc3+ #44
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  bond_xmit_roundrobin drivers/net/bonding/bond_main.c:3858 [inline]
  __bond_start_xmit drivers/net/bonding/bond_main.c:4136 [inline]
  bond_start_xmit+0x1ab8/0x2b90 drivers/net/bonding/bond_main.c:4170
  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
  xmit_one net/core/dev.c:3216 [inline]
  dev_hard_start_xmit+0x5df/0xc20 net/core/dev.c:3232
  __dev_queue_xmit+0x2f35/0x3ab0 net/core/dev.c:3802
  dev_queue_xmit+0x4b/0x60 net/core/dev.c:3835
  packet_snd net/packet/af_packet.c:2925 [inline]
  packet_sendmsg+0x80ff/0x8c60 net/packet/af_packet.c:2950
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x4410f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcc15c2468 EFLAGS: 00000217 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004410f9
RDX: 0000000000000000 RSI: 0000000020001940 RDI: 0000000000000004
RBP: 00000000006cc018 R08: 0000000000000100 R09: 0000000000000100
R10: 0000000000000100 R11: 0000000000000217 R12: 0000000000402060
R13: 00000000004020f0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:256 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:181
  kmsan_kmalloc+0x98/0x100 mm/kmsan/kmsan_hooks.c:91
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan_hooks.c:100
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2718 [inline]
  __kmalloc_node_track_caller+0x9e7/0x1160 mm/slub.c:4351
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2f5/0x9e0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:996 [inline]
  alloc_skb_with_frags+0x1d0/0xac0 net/core/skbuff.c:5276
  sock_alloc_send_pskb+0xb47/0x1170 net/core/sock.c:2082
  packet_alloc_skb net/packet/af_packet.c:2779 [inline]
  packet_snd net/packet/af_packet.c:2870 [inline]
  packet_sendmsg+0x6599/0x8c60 net/packet/af_packet.c:2950
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
  __sys_sendmsg net/socket.c:2152 [inline]
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg+0x2a3/0x3d0 net/socket.c:2159
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2159
  do_syscall_64+0xb8/0x100 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
