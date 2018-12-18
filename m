Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86D721852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeLRNBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:01:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:55075 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeLRNBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:01:04 -0500
Received: by mail-io1-f70.google.com with SMTP id f24so15272876ioh.21
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VlI+W1c2VGNDNoq7z09SJ54K11Xt99t+9mOgx52kZKw=;
        b=Iku/Zqj2ORe8wrx21Ma7MknDZ9RjV6VcVpQTJ3zCQj05Jzs1FadigHaWsrkPBw6uBg
         MZYIjO15N2oyC4MlTebG4AeOB39R1xUEUtKtvlf890mghzI1EX8YSvLmj9CjNOEotLYD
         t7BigmXhzEBHI3B9WD9Z+nSNPfTcE7+q9cpyBgMftiAcvi6KoEfZp+jhI/F3c2MiZ3eQ
         RWwjbYxKluYwXMvItO+yAcPJ5KdeDUtVh5CYJlbdgk4d8B0YoHywGP+pRE39U5Ybrgan
         8uwPJGx3QZb1a+/96VCrUoVz6rVqAm9S10OiHosOdS5Rw7eZ9Cljmh8McXhj6c0V/Qvq
         o5bA==
X-Gm-Message-State: AA+aEWZhP/mePV5XjSrbS76zXSwKcT0nh8CrB1/ododQrhjDtKCdpyZH
        ox+1tqh5LMu4oZlEY4Rpvh55xuxOWMz/ii2OK0NlcQRU5I2G
X-Google-Smtp-Source: AFSGD/VimN5ZXS4S+f2HCCzoAQ6bTzRjmQpkhPQfxY6Z/ex81SJbbDkbTlac9hmD/ZAzzVRqIse6i3MOPFPzmd/ranvJC4jOgLJt
MIME-Version: 1.0
X-Received: by 2002:a24:6212:: with SMTP id d18mr2250362itc.29.1545138062953;
 Tue, 18 Dec 2018 05:01:02 -0800 (PST)
Date:   Tue, 18 Dec 2018 05:01:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f1f37057d4b7d95@google.com>
Subject: KMSAN: uninit-value in tipc_nl_compat_link_set (2)
From:   syzbot <syzbot+d78b8a29241a195aefb8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jon.maloy@ericsson.com,
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

HEAD commit:    cddc52641fd2 kmsan: use __memmove() in fixup_bad_iret()
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=15d27ad5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2808e34f8becb71
dashboard link: https://syzkaller.appspot.com/bug?extid=d78b8a29241a195aefb8
compiler:       clang version 8.0.0 (trunk 343298)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17682b0b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d78b8a29241a195aefb8@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KMSAN: uninit-value in strlen+0x3b/0xa0 lib/string.c:485
CPU: 0 PID: 8222 Comm: syz-executor5 Not tainted 4.20.0-rc2+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x32d/0x480 lib/dump_stack.c:113
  kmsan_report+0x19f/0x300 mm/kmsan/kmsan.c:911
  __msan_warning+0x76/0xc0 mm/kmsan/kmsan_instr.c:415
  strlen+0x3b/0xa0 lib/string.c:485
  nla_put_string include/net/netlink.h:1154 [inline]
  __tipc_nl_compat_link_set net/tipc/netlink_compat.c:708 [inline]
  tipc_nl_compat_link_set+0xa37/0x18b0 net/tipc/netlink_compat.c:744
  __tipc_nl_compat_doit net/tipc/netlink_compat.c:311 [inline]
  tipc_nl_compat_doit+0x39f/0xae0 net/tipc/netlink_compat.c:344
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1107 [inline]
  tipc_nl_compat_recv+0x148a/0x2770 net/tipc/netlink_compat.c:1210
  genl_family_rcv_msg net/netlink/genetlink.c:601 [inline]
  genl_rcv_msg+0x189e/0x1aa0 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x394/0x640 net/netlink/af_netlink.c:2477
  genl_rcv+0x63/0x80 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x1699/0x1740 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0x13c7/0x1440 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe3b/0x1240 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f933fe2bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f933fe2c6d4
R13: 00000000004c3b79 R14: 00000000004d5d90 R15: 00000000ffffffff

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:252 [inline]
  kmsan_internal_poison_shadow+0xc8/0x1c0 mm/kmsan/kmsan.c:177
  kmsan_kmalloc+0x98/0xf0 mm/kmsan/kmsan_hooks.c:104
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:113
  slab_post_alloc_hook mm/slab.h:446 [inline]
  slab_alloc_node mm/slub.c:2765 [inline]
  __kmalloc_node_track_caller+0xf62/0x14e0 mm/slub.c:4396
  __kmalloc_reserve net/core/skbuff.c:138 [inline]
  __alloc_skb+0x42b/0xeb0 net/core/skbuff.c:206
  alloc_skb include/linux/skbuff.h:998 [inline]
  netlink_alloc_large_skb net/netlink/af_netlink.c:1182 [inline]
  netlink_sendmsg+0xc9e/0x1440 net/netlink/af_netlink.c:1892
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg net/socket.c:631 [inline]
  ___sys_sendmsg+0xe3b/0x1240 net/socket.c:2116
  __sys_sendmsg net/socket.c:2154 [inline]
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg+0x305/0x460 net/socket.c:2161
  __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2161
  do_syscall_64+0xcf/0x110 arch/x86/entry/common.c:291
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
