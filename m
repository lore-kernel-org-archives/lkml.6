Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A58C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A41F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfANGwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:52:04 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:35565 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:52:04 -0500
Received: by mail-it1-f197.google.com with SMTP id v188so8750269ita.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 22:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Sg3jCG61WRo3JOPAdxT3cOPxPNMbvwmtqGYpXlB4v5k=;
        b=mBE6HhpnoPZ//tw8qD8ebwCODCitQWHApxSjNUHsn0Udy1G42dyV9yUGsk+Qz+RZPA
         EiNcbB39Z1g4b270ZZcYKCJocDuwgykEPmMxDbWwhioD/ez5LVpBp/a5R7/RqLXUmcjc
         MQkzgh1/glWswa/KAMpW2pgyA4AN0t7wdIt0oQcyclqOOsvUMySSyLMBh/TWdfb5T6dn
         B+6RYcrAF2xWfaYUZq6m63DB6WZ7tMkSxCrnBKw7XGP9Ycj8m9z+8IqSxDcHCRZsfQfO
         PNUr7bBkq3bH1tZsiSPLjj9sydDmvpSdEXFqj4StRlRzIdeprGqy9kWxdWnkwrUPk8+7
         shug==
X-Gm-Message-State: AJcUukdgRe9fhC197jOKUnXegND5VGm5N9RCqeBWnkOyH9Tz670+LGbB
        fpZ2qcALO3FpftDFenHVvzawW0Ox0n0zvZgUy8DuOu6ahJkV
X-Google-Smtp-Source: ALg8bN50zVhiJCIV2m8fv+5SUCe83M8TQdeF/Rl+DpUXQAdwnBNeOwRVr5ojzBlYkfiipftC55hnLeQfG5tfQqNjRNMl1AwYbEZz
MIME-Version: 1.0
X-Received: by 2002:a5d:9a0b:: with SMTP id s11mr8558038iol.5.1547448723289;
 Sun, 13 Jan 2019 22:52:03 -0800 (PST)
Date:   Sun, 13 Jan 2019 22:52:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075c0ef057f657b8d@google.com>
Subject: KASAN: null-ptr-deref Read in ip6_hold_safe
From:   syzbot <syzbot+8433ca0841e308ef4cc7@syzkaller.appspotmail.com>
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

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1492759f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=8433ca0841e308ef4cc7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8433ca0841e308ef4cc7@syzkaller.appspotmail.com

kernel msg: ebtables bug: please report to author: EBT_ENTRY_OR_ENTRIES  
shouldn't be set in distinguisher
==================================================================
BUG: KASAN: null-ptr-deref in atomic_read  
include/asm-generic/atomic-instrumented.h:21 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_add_unless  
include/linux/atomic.h:575 [inline]
BUG: KASAN: null-ptr-deref in atomic_add_unless include/linux/atomic.h:597  
[inline]
BUG: KASAN: null-ptr-deref in dst_hold_safe include/net/dst.h:308 [inline]
BUG: KASAN: null-ptr-deref in ip6_hold_safe+0xca/0x620 net/ipv6/route.c:1021
Read of size 4 at addr 0000000000000068 by task syz-executor4/21421

CPU: 0 PID: 21421 Comm: syz-executor4 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  kasan_report_error mm/kasan/report.c:352 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x19f/0x2ba mm/kasan/report.c:396
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x123/0x190 mm/kasan/kasan.c:267
  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
  atomic_fetch_add_unless include/linux/atomic.h:575 [inline]
  atomic_add_unless include/linux/atomic.h:597 [inline]
  dst_hold_safe include/net/dst.h:308 [inline]
  ip6_hold_safe+0xca/0x620 net/ipv6/route.c:1021
  rt6_get_pcpu_route net/ipv6/route.c:1241 [inline]
  ip6_pol_route+0x3a3/0x1490 net/ipv6/route.c:1890
  ip6_pol_route_output+0x54/0x70 net/ipv6/route.c:2066
  fib6_rule_lookup+0x277/0x870 net/ipv6/fib6_rules.c:122
  ip6_route_output_flags+0x2c4/0x350 net/ipv6/route.c:2095
  ip6_route_output include/net/ip6_route.h:88 [inline]
  ip6_dst_lookup_tail+0xe18/0x1d50 net/ipv6/ip6_output.c:958
  ip6_dst_lookup_flow+0xca/0x270 net/ipv6/ip6_output.c:1086
  ip6_sk_dst_lookup_flow net/ipv6/ip6_output.c:1124 [inline]
  ip6_sk_dst_lookup_flow+0x5d6/0xbf0 net/ipv6/ip6_output.c:1114
  udpv6_sendmsg+0x20d7/0x3550 net/ipv6/udp.c:1441
  inet_sendmsg+0x1af/0x740 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x7ec/0x910 net/socket.c:2116
  __sys_sendmsg+0x112/0x270 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
protocol 88fb is buggy, dev hsr_slave_0
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
protocol 88fb is buggy, dev hsr_slave_1
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb05ac4ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000000 RSI: 0000000020013000 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb05ac4b6d4
R13: 00000000004c4d2e R14: 00000000004d8650 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
