Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD3FECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083A321532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083A321532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeIUCjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:39:41 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39377 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeIUCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:39:27 -0400
Received: by mail-io1-f72.google.com with SMTP id x5-v6so14573130ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=L9qkR99/BRSpeplLlkK35liIGIWQ8GUgqNyPHl2kDBw=;
        b=X1+MJ+G0vq7Be7DuMG3QdcoiqBAHkxKMScG/l9qY0lKR0nXCnzobXLSosIshn8K0MZ
         zqlIwf1CEsYl3+S3eltUPb/dUYXk5ONUEhcErb6+MMpthNsRWa6TnH9sMXbagsykblP9
         H9XKg5rQdNU06mR0w8NK4/zWQXFWVW5ATZXe/WmbQeScEAPJ4chOb5/vQK+NHL24LOJ6
         tuCXSQiaqTGR5mCLg4cSdm4uwqwInqoNrVJv3riseploZ1yJQBS//np5Le4tkol810LQ
         qfIdkARyj8GBB4TrA6vlkg8VGzs/js8EqHf5AcNMO76A1UL154PLSiVG6G5h/dfM/UjR
         ChcQ==
X-Gm-Message-State: APzg51AWhGzxzblxnA6ndwk9bwls+ZXDeINscuTP+1Ykt/W7NSdfrgiL
        yIFvkw0biOkpR+lu70xVnmVjJ+OzLeQ3NBIdlADj1U+lPfPk
X-Google-Smtp-Source: ANB0VdaiWA1RRIg3bkfbcZOrFlM1cReNmcD7lw6aM/xlBFaq6l6oTUJs5SixI4pIyHS+5Z51s3CF8jMSnY3bZkg5HHbhnuK91ACQ
MIME-Version: 1.0
X-Received: by 2002:a6b:a2d0:: with SMTP id l199-v6mr32700401ioe.129.1537476845066;
 Thu, 20 Sep 2018 13:54:05 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:54:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000336563057653b9aa@google.com>
Subject: KMSAN: uninit-value in IP6_ECN_decapsulate
From:   syzbot <syzbot+bf7e6250c7ce248f3ec9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    88e0e95b30f1 kmsan: add a newline before "Uninit was creat..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=146dfccf800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
dashboard link: https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
compiler:       clang version 7.0.0 (trunk 334104)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a9ce4400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f68bd8400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bf7e6250c7ce248f3ec9@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:189  
[inline]
BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x421/0x970  
include/net/inet_ecn.h:234
CPU: 0 PID: 4515 Comm: syz-executor162 Not tainted 4.17.0+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1122
  __msan_warning_32+0x70/0xc0 mm/kmsan/kmsan_instr.c:620
  INET_ECN_decapsulate include/net/inet_ecn.h:189 [inline]
  IP6_ECN_decapsulate+0x421/0x970 include/net/inet_ecn.h:234
  ip6ip6_dscp_ecn_decapsulate+0x1e0/0x250 net/ipv6/ip6_tunnel.c:719
  __ip6_tnl_rcv+0xff9/0x1a10 net/ipv6/ip6_tunnel.c:829
  ip6_tnl_rcv+0xe6/0x110 net/ipv6/ip6_tunnel.c:868
  gre_rcv+0x1661/0x1a90 net/ipv6/ip6_gre.c:534
  ip6_input_finish+0x1353/0x2260 net/ipv6/ip6_input.c:284
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ip6_input+0x294/0x320 net/ipv6/ip6_input.c:327
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x498/0x6e0 net/ipv6/ip6_input.c:71
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ipv6_rcv+0x1d6b/0x2360 net/ipv6/ip6_input.c:208
  __netif_receive_skb_core+0x47f3/0x4aa0 net/core/dev.c:4592
  __netif_receive_skb net/core/dev.c:4657 [inline]
  process_backlog+0x62d/0xe20 net/core/dev.c:5337
  napi_poll net/core/dev.c:5735 [inline]
  net_rx_action+0x766/0x1a80 net/core/dev.c:5801
  __do_softirq+0x592/0x979 kernel/softirq.c:285
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1046
  </IRQ>
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x114/0x140 kernel/softirq.c:182
  local_bh_enable+0x36/0x40 include/linux/bottom_half.h:32
  rcu_read_unlock_bh include/linux/rcupdate.h:728 [inline]
  ip6_finish_output2+0x1ce8/0x2100 net/ipv6/ip6_output.c:121
  ip6_finish_output+0xaf0/0xbb0 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
  ip6_output+0x597/0x6c0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  ip6_local_out+0x164/0x1d0 net/ipv6/output_core.c:176
  ip6_send_skb net/ipv6/ip6_output.c:1703 [inline]
  ip6_push_pending_frames+0x218/0x4d0 net/ipv6/ip6_output.c:1723
  rawv6_push_pending_frames net/ipv6/raw.c:616 [inline]
  rawv6_sendmsg+0x4254/0x4fc0 net/ipv6/raw.c:935
  inet_sendmsg+0x3fc/0x760 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg net/socket.c:639 [inline]
  sock_write_iter+0x3bc/0x470 net/socket.c:908
  call_write_iter include/linux/fs.h:1784 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x808/0x9f0 fs/read_write.c:487
  vfs_write+0x467/0x8c0 fs/read_write.c:549
  ksys_write fs/read_write.c:598 [inline]
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x1bf/0x3e0 fs/read_write.c:607
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441199
RSP: 002b:00007fff83b55688 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441199
RDX: 0000000000000004 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000006cc018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004020a0
R13: 0000000000402130 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:189
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:315
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan.c:322
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2753 [inline]
  __kmalloc_node_track_caller+0xb35/0x11b0 mm/slub.c:4395
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cb/0x9e0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:988 [inline]
  __ip6_append_data+0x364d/0x4fb0 net/ipv6/ip6_output.c:1434
  ip6_append_data+0x40e/0x6b0 net/ipv6/ip6_output.c:1597
  rawv6_sendmsg+0x2756/0x4fc0 net/ipv6/raw.c:928
  inet_sendmsg+0x3fc/0x760 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg net/socket.c:639 [inline]
  sock_write_iter+0x3bc/0x470 net/socket.c:908
  call_write_iter include/linux/fs.h:1784 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x808/0x9f0 fs/read_write.c:487
  vfs_write+0x467/0x8c0 fs/read_write.c:549
  ksys_write fs/read_write.c:598 [inline]
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x1bf/0x3e0 fs/read_write.c:607
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
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
