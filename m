Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C20C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11442146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11442146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbeIUC3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:29:22 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42496 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUC3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:29:22 -0400
Received: by mail-io1-f70.google.com with SMTP id m13-v6so14604058ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YTa9O3Cjm6T8oiHZTZN3gtTNu3ReekI0Iez2I19EH+E=;
        b=AA6zyYj9pqi7G/tPmM85JusAnBxOYFZtEBFRXceb/+kcOUfmWQddvRAX57sTdqUxl4
         9/wa1G+mqjeDl5sYNQhDXIFqh+WXmLykpRKjKWufal2lPbN1b2i972Y2Y/oc0iluTyr2
         oyANcjRtX6eeu9g28zHykuWHknHBDGq8y4SwJoIDRjMeEOfAuyCl18bjQWnDKbbAZbz6
         bcfOF1bumPlwTRPFfqcgLGLuESNPUwH3kOGTT5cUees2hFNwFmjnKAPUnIaexuHEV5d/
         +iRBgWURmjmK/H0e573aRnPkCZwzARzXSa26e03synE0KLPigeLMDOJr+XoavVPn1VaP
         YydA==
X-Gm-Message-State: APzg51CyWYmRQg7AXMKNWTrvqRig/DHAor+mHSWOHBXu3rk0jafNYooB
        5FnbYXnuPz+Um60uCtDtujsN8faWtVmjMITrbw93VeK8I1Bc
X-Google-Smtp-Source: ANB0VdbCZ/xOazk8/A6D2o+HjQXBz2xFZWBxVSZY+44/iR4HoNzXFhs0L489d+X5V99LFehiBrJaDN+wS1ggfYR8ZEbLqbvZfm9Y
MIME-Version: 1.0
X-Received: by 2002:a02:3b04:: with SMTP id c4-v6mr32906640jaa.22.1537476243701;
 Thu, 20 Sep 2018 13:44:03 -0700 (PDT)
Date:   Thu, 20 Sep 2018 13:44:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b4e6f0576539526@google.com>
Subject: KMSAN: uninit-value in tipc_nl_compat_doit
From:   syzbot <syzbot+bca0dc46634781f08b38@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2d741e5d189 kmsan: add initialization for shmem pages
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=14b18f6b800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48f9de3384bcd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=bca0dc46634781f08b38
compiler:       clang version 7.0.0 (trunk 329391)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cad047800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ceffb800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bca0dc46634781f08b38@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in tipc_nl_compat_doit+0x404/0xa10  
net/tipc/netlink_compat.c:335
CPU: 0 PID: 4514 Comm: syz-executor485 Not tainted 4.16.0+ #87
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:53
  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
  tipc_nl_compat_doit+0x404/0xa10 net/tipc/netlink_compat.c:335
  tipc_nl_compat_recv+0x164b/0x2700 net/tipc/netlink_compat.c:1153
  genl_family_rcv_msg net/netlink/genetlink.c:599 [inline]
  genl_rcv_msg+0x1686/0x1810 net/netlink/genetlink.c:624
  netlink_rcv_skb+0x378/0x600 net/netlink/af_netlink.c:2447
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:635
  netlink_unicast_kernel net/netlink/af_netlink.c:1311 [inline]
  netlink_unicast+0x166b/0x1740 net/netlink/af_netlink.c:1337
  netlink_sendmsg+0x1048/0x1310 net/netlink/af_netlink.c:1900
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmsg net/socket.c:2080 [inline]
  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
  SyS_sendmsg+0x54/0x80 net/socket.c:2087
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43fda9
RSP: 002b:00007ffd0c184ba8 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fda9
RDX: 0000000000000000 RSI: 0000000020023000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 00000000004016d0
R13: 0000000000401760 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
  kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
  kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
  kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2737 [inline]
  __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:984 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1183 [inline]
  netlink_sendmsg+0x9a6/0x1310 net/netlink/af_netlink.c:1875
  sock_sendmsg_nosec net/socket.c:630 [inline]
  sock_sendmsg net/socket.c:640 [inline]
  ___sys_sendmsg+0xec0/0x1310 net/socket.c:2046
  __sys_sendmsg net/socket.c:2080 [inline]
  SYSC_sendmsg+0x2a3/0x3d0 net/socket.c:2091
  SyS_sendmsg+0x54/0x80 net/socket.c:2087
  do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
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
