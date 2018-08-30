Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04879C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA44E20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA44E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeH3GQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:16:51 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:40533 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3GQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:16:51 -0400
Received: by mail-it0-f69.google.com with SMTP id k143-v6so511386ite.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0TPlcA1JCJ+DTVkCwAFKf8I70BVZ5yKRRRGhVLrwu5c=;
        b=X7+HXGJguKU7rqfags/1Bnq5cDlzB1vCuWe5WzLKefBggST5/hZXd00tWrBLy7da7I
         lN31yoWDFq6AaVk7m8YycuXIzLFwT5/hqcO0Up+m5jaajPSgrkfly7Txr/JE7ev5RR8h
         tlG7WgpAXs8sFVXK2fdD34/jVHs8R42/h3N+jBuaDlGAqlMhbiCbdMm6Lx3qx+FEPUb9
         ak2XNpoFhhVZoASwWkAWZfxN8JD/9JgwxKxXMFMhYa+mJ1bfM3naUlmLKN4gXM2j+c9c
         7bp1dsfX+ogh0VpSmTy7qTHsglw2Mr2yjwieEq/r85tBAapj9mqUAEhqOay1yzdi9u0I
         vWxA==
X-Gm-Message-State: APzg51A4Ct9VS4yvyw9iqeXfULbpIm0D+i0NzPC++PQcKp42/7Yy1C/0
        ER1IQRhYCnjgtxKcJi2L5+4jwnQbbfRqb5s0Zsgb//1Dnuv8
X-Google-Smtp-Source: ANB0VdY7gJgxaWjqSBzb19Akf6UO9KByisCo8qcds3uMpon37eEu82w/oC4SnmFM5OnClwSWre9Lm8sdrCWz9o7RdsoIun6RrQXN
MIME-Version: 1.0
X-Received: by 2002:a6b:9a13:: with SMTP id c19-v6mr3747661ioe.73.1535595423820;
 Wed, 29 Aug 2018 19:17:03 -0700 (PDT)
Date:   Wed, 29 Aug 2018 19:17:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c178e305749daba4@google.com>
Subject: WARNING in apparmor_secid_to_secctx
From:   syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>
To:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com

------------[ cut here ]------------
AppArmor WARN apparmor_secid_to_secctx: ((!secdata)):
WARNING: CPU: 0 PID: 14826 at security/apparmor/secid.c:82  
apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 14826 Comm: syz-executor1 Not tainted 4.19.0-rc1+ #193
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
Code: c7 c7 40 66 58 87 e8 6a 6d 0f fe 0f 0b e9 6c fe ff ff e8 3e aa 44 fe  
48 c7 c6 80 67 58 87 48 c7 c7 a0 65 58 87 e8 4b 6d 0f fe <0f> 0b e9 3f fe  
ff ff 48 89 df e8 fc a7 83 fe e9 ed fe ff ff bb f4
RSP: 0018:ffff8801ba1bed10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8801ba1beed0 RCX: ffffc9000227e000
RDX: 0000000000018482 RSI: ffffffff8163ac01 RDI: 0000000000000001
RBP: ffff8801ba1bed30 R08: ffff8801b80ec080 R09: ffffed003b603eca
R10: ffffed003b603eca R11: ffff8801db01f657 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801ba1beed0
  security_secid_to_secctx+0x63/0xc0 security/security.c:1314
  ctnetlink_secctx_size net/netfilter/nf_conntrack_netlink.c:621 [inline]
  ctnetlink_nlmsg_size net/netfilter/nf_conntrack_netlink.c:659 [inline]
  ctnetlink_conntrack_event+0x303/0x1470  
net/netfilter/nf_conntrack_netlink.c:706
  nf_conntrack_eventmask_report+0x55f/0x930  
net/netfilter/nf_conntrack_ecache.c:151
  nf_conntrack_event_report include/net/netfilter/nf_conntrack_ecache.h:112  
[inline]
  nf_ct_delete+0x33c/0x5d0 net/netfilter/nf_conntrack_core.c:601
  nf_ct_iterate_cleanup+0x48c/0x5e0 net/netfilter/nf_conntrack_core.c:1892
  nf_ct_iterate_cleanup_net+0x23c/0x2d0  
net/netfilter/nf_conntrack_core.c:1974
  ctnetlink_flush_conntrack net/netfilter/nf_conntrack_netlink.c:1226  
[inline]
  ctnetlink_del_conntrack+0x66c/0x850  
net/netfilter/nf_conntrack_netlink.c:1258
  nfnetlink_rcv_msg+0xd88/0x1070 net/netfilter/nfnetlink.c:228
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
  nfnetlink_rcv+0x1c0/0x4d0 net/netfilter/nfnetlink.c:560
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
  __sys_sendmsg+0x11d/0x290 net/socket.c:2152
  __do_sys_sendmsg net/socket.c:2161 [inline]
  __se_sys_sendmsg net/socket.c:2159 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7bc6e03c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7bc6e046d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000020d65000 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4588 R14: 00000000004c8d5c R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
