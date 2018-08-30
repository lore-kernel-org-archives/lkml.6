Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A19C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9879A205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9879A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeH3HnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:43:08 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:57353 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbeH3HnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:43:07 -0400
Received: by mail-it0-f72.google.com with SMTP id e6-v6so661522itc.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 20:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D0YebocyT+q/Hqy1AoN8rgZwNbggjG/7LTHm2hTGnJc=;
        b=sEPDqJ3FMPrrlHKOGFtxK0G+ESJmmLV5tmmhNppKCw1SICgy7rU/g4RdGaHTaOBEie
         1RNy+Y0XgigC8WNqN/HUzdoGA9QesJeSBiFbC+bNQe3bPMyhTS+YjkI/9Dk2L6FSW/ni
         hUjSyweFhZeNN51P5Z5UH/8T/8wI+H6+bJC9C8jQP3bb6Mrvz9JqjR5NcAMkII2Qs5yc
         Tx9g70v0hiiYCD4bd13oJT+1lAUt+rmAMGTGXw9UDkA0ySDLzZcvrbqKAl4tttrWnfp+
         g4tTfpFTXrTo+WBEz11JPUzG0T3PxiJOIcW5ilQzW9RcLbk5mfUHQ/zbvkxjl00pxjyN
         Q8MQ==
X-Gm-Message-State: APzg51BV3sxSVPR5lvtFkInBEHqLqxoBO6r117tayFeRPPVnJ8fvuwYK
        kqg7T2te0qXL2Fz0Pdjc2v6djwJyTSOj/Mp7TsTNIe0PkSFU
X-Google-Smtp-Source: ANB0Vdb6jr/vZfOO7YWdFaubdy8d+dS/pC1AiRPzHdsCIM0CarFfcCuogwhzKqEAYA473bsQ9/sNhyD3bEiXvVSQPCzsTYA4RxYV
MIME-Version: 1.0
X-Received: by 2002:a6b:8b58:: with SMTP id n85-v6mr4016604iod.138.1535600583380;
 Wed, 29 Aug 2018 20:43:03 -0700 (PDT)
Date:   Wed, 29 Aug 2018 20:43:03 -0700
In-Reply-To: <000000000000c178e305749daba4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a164f05749edfba@google.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
From:   syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>
To:     dvyukov@google.com, jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16662cb6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f20a96400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10efd7bc400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
------------[ cut here ]------------
AppArmor WARN apparmor_secid_to_secctx: ((!secdata)):
WARNING: CPU: 0 PID: 4682 at security/apparmor/secid.c:82  
apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4682 Comm: syz-executor028 Not tainted 4.19.0-rc1+ #193
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
RSP: 0018:ffff8801ba5a6d10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8801ba5a6ed0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8163ac01 RDI: 0000000000000001
RBP: ffff8801ba5a6d30 R08: ffff8801d9ba2580 R09: ffffed003b603eca
R10: ffffed003b603eca R11: ffff8801db01f657 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801ba5a6ed0
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
RIP: 0033:0x441189
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc388e2108 EFLAGS: 00000217 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441189
RDX: 0000000000000000 RSI: 0000000020d65000 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004020d0
R13: 0000000000402160 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

