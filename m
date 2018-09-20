Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B550C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B2221532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B2221532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbeIUCj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:39:27 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50010 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeIUCj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:39:26 -0400
Received: by mail-io1-f72.google.com with SMTP id k9-v6so14567716iob.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oZ8mnwcH49ElscPrL+lxvJPFrjEN7w//K8rwo8Kv+0o=;
        b=GwOsJa69ggK/CemzKvRaJUdouWTuZO6ndRlpEmcmvurz27I5cDZaApryQT89pKotFG
         zMHDOK5DgsrqHpNQW/5MwN7rlrk+lkhautrs15GB14l0iVfmQuY5aDtwcGAIKBzALY7j
         9FqlSvy9jV7BCZlU/quhqcCwfBFqPeQxWCufn1zorwTvTEM/F0z8QC7U0u8vGMpUZL/Q
         FUz4ppw1pqqL16h5OfqcIa23516L8Yq5/KGVqxYL3v7rKub1/M8FSrWvPRZtfhVArDGJ
         FgtGKV8lzWvyD5lPyrHWOsRmz5oFrF706fz51qc1TlCZlJmEmW5yLaA85iKKkH3UTaMd
         mqjQ==
X-Gm-Message-State: APzg51CNNYKhr5Q9XEDQslb7gISjwYIpqKNreA9Ql/i9GUqOBIePTbyd
        38kK/rwcCr9oehnvs0srSlAJvXQd9XN9M0KSpdIKfoiz9OQV
X-Google-Smtp-Source: ANB0VdbHIvxie1aJVSGOr8rUTQJzY4YDGzNs3YsXBYzLUCYPl/Ctk3PZ+pgELEYB6yEsuS1bU2plkbuk275eJw8dUD+bFu0hY2eO
MIME-Version: 1.0
X-Received: by 2002:a24:3344:: with SMTP id k65-v6mr3632146itk.10.1537476844875;
 Thu, 20 Sep 2018 13:54:04 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:54:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000030779c057653b9ef@google.com>
Subject: KMSAN: uninit-value in ip6_parse_tlv
From:   syzbot <syzbot+f08ac29f2ac8aea19826@syzkaller.appspotmail.com>
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

HEAD commit:    74ee2200b89f kmsan: bump .config.example to v4.17-rc3
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=1426fde7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ca1e57bafa8ab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=f08ac29f2ac8aea19826
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15574be7800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1003fc37800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f08ac29f2ac8aea19826@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in ip6_parse_tlv+0x8d5/0xcd0 net/ipv6/exthdrs.c:172
CPU: 1 PID: 4535 Comm: syz-executor786 Not tainted 4.17.0-rc3+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  ip6_parse_tlv+0x8d5/0xcd0 net/ipv6/exthdrs.c:172
  ipv6_destopt_rcv+0x50d/0xd90 net/ipv6/exthdrs.c:310
  ip6_input_finish+0xaac/0x2250 net/ipv6/ip6_input.c:284
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ip6_input net/ipv6/ip6_input.c:327 [inline]
  ip6_mc_input+0xa67/0x1080 net/ipv6/ip6_input.c:404
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x46e/0x6e0 net/ipv6/ip6_input.c:71
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ipv6_rcv+0x1e16/0x2340 net/ipv6/ip6_input.c:208
  __netif_receive_skb_core+0x47df/0x4a90 net/core/dev.c:4592
  __netif_receive_skb net/core/dev.c:4657 [inline]
  process_backlog+0x62d/0xe20 net/core/dev.c:5337
  napi_poll net/core/dev.c:5735 [inline]
  net_rx_action+0x7c1/0x1a70 net/core/dev.c:5801
  __do_softirq+0x56d/0x93d kernel/softirq.c:285
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1046
  </IRQ>
  do_softirq+0xb6/0xf0 kernel/softirq.c:329
  netif_rx_ni net/core/dev.c:4219 [inline]
  dev_loopback_xmit+0x8b0/0x900 net/core/dev.c:3347
  NF_HOOK include/linux/netfilter.h:288 [inline]
  ip6_finish_output2+0x1e24/0x2110 net/ipv6/ip6_output.c:84
  ip6_finish_output+0xae9/0xba0 net/ipv6/ip6_output.c:154
  NF_HOOK_COND include/linux/netfilter.h:277 [inline]
  ip6_output+0x597/0x6c0 net/ipv6/ip6_output.c:171
  dst_output include/net/dst.h:444 [inline]
  ip6_local_out+0x15e/0x1d0 net/ipv6/output_core.c:176
  ip6_send_skb net/ipv6/ip6_output.c:1702 [inline]
  ip6_push_pending_frames+0x218/0x4d0 net/ipv6/ip6_output.c:1722
  rawv6_push_pending_frames net/ipv6/raw.c:616 [inline]
  rawv6_sendmsg+0x4235/0x4fb0 net/ipv6/raw.c:935
  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg net/socket.c:639 [inline]
  __sys_sendto+0x6c0/0x7e0 net/socket.c:1789
  __do_sys_sendto net/socket.c:1801 [inline]
  __se_sys_sendto net/socket.c:1797 [inline]
  __x64_sys_sendto+0x1a1/0x210 net/socket.c:1797
  do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43fe79
RSP: 002b:00007ffc475970d8 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fe79
RDX: 0000000000000000 RSI: 0000000020001ffe RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000020003000 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000216 R12: 00000000004017a0
R13: 0000000000401830 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x10/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2753 [inline]
  __kmalloc_node_track_caller+0xb32/0x11b0 mm/slub.c:4395
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:988 [inline]
  alloc_skb_with_frags+0x1e6/0xb80 net/core/skbuff.c:5254
  sock_alloc_send_pskb+0xb56/0x1190 net/core/sock.c:2088
  sock_alloc_send_skb+0xca/0xe0 net/core/sock.c:2105
  __ip6_append_data+0x33a2/0x4e40 net/ipv6/ip6_output.c:1427
  ip6_append_data+0x40e/0x6b0 net/ipv6/ip6_output.c:1596
  rawv6_sendmsg+0x2740/0x4fb0 net/ipv6/raw.c:928
  inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg net/socket.c:639 [inline]
  __sys_sendto+0x6c0/0x7e0 net/socket.c:1789
  __do_sys_sendto net/socket.c:1801 [inline]
  __se_sys_sendto net/socket.c:1797 [inline]
  __x64_sys_sendto+0x1a1/0x210 net/socket.c:1797
  do_syscall_64+0x154/0x220 arch/x86/entry/common.c:287
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
