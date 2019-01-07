Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6218FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C30520859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfAGLOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:14:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:44171 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfAGLOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:14:05 -0500
Received: by mail-io1-f70.google.com with SMTP id v8so47807007ioh.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 03:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=T5dnsuSgZeq0RfI05RxHXFAgE0NHADoHZWudVNSShLc=;
        b=mwcNHI9ppr7kjhCO7SGVIVJ0YdcVTBT95LSMqCwxxtV775spMDhIzFfivUOhb7Dzro
         f4T8UdIDgj+u09Cuo6MwaBlI6KG2VW/XGyuNNi49W7oxcBFASMF7yyjud08bmGx2XNCW
         R60/sfiVdF6nyM96Kinq8HHLSbf7YO1J1wAJW/YnXZb0EeWz3pEbU/kjiDCeoiS1HiX5
         D3ZzK1YO23LcJRlJ8QGCVfzU1zqYjYr6TzqIdDdv5gnPjXA5CsubhMjh222XRzBcpRla
         cVNmJJLsA9nSmRKXAypvCtnS9bik1a411Bw9HQIYJEv25NKWuVZr+75MDx1mxE4wxbt6
         N6xg==
X-Gm-Message-State: AA+aEWYk6FTmxYqNOAz4SgEI/qIAyQWsmKippaavPqHBrzUi0bMeHK8s
        sCgiYHtjt4n3+yUhf48bU3Hefh0v1vGt0JV6fEzNfhBen03Y
X-Google-Smtp-Source: AFSGD/X4YWWD+Rk2cQc8j7eeHkwaMzkEovmwbEzPoKmr/FZkyDd2AQMMcmdHv6xtq4SElmS4ATMhLgWFPljuyfiq39k6i1zhL24p
MIME-Version: 1.0
X-Received: by 2002:a02:6006:: with SMTP id i6mr47465932jac.6.1546859644478;
 Mon, 07 Jan 2019 03:14:04 -0800 (PST)
Date:   Mon, 07 Jan 2019 03:14:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a06f21057edc53c0@google.com>
Subject: KASAN: user-memory-access Write in dst_release
From:   syzbot <syzbot+29ffc731816e0995ad54@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6544f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=29ffc731816e0995ad54
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29ffc731816e0995ad54@syzkaller.appspotmail.com

bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
==================================================================
BUG: KASAN: user-memory-access in atomic_sub_return  
include/asm-generic/atomic-instrumented.h:305 [inline]
BUG: KASAN: user-memory-access in dst_release net/core/dst.c:186 [inline]
BUG: KASAN: user-memory-access in dst_release+0x2a/0xb0 net/core/dst.c:181
Write of size 4 at addr 00000000000054e8 by task kworker/u4:2/55

CPU: 1 PID: 55 Comm: kworker/u4:2 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
IPv6: ADDRCONF(NETDEV_UP): team_slave_0: link is not ready
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
team0: Port device team_slave_0 added
  kasan_report_error mm/kasan/report.c:352 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x19f/0x2ba mm/kasan/report.c:396
IPv6: ADDRCONF(NETDEV_UP): team_slave_1: link is not ready
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x123/0x190 mm/kasan/kasan.c:267
team0: Port device team_slave_1 added
  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_0: link is not ready
  atomic_sub_return include/asm-generic/atomic-instrumented.h:305 [inline]
  dst_release net/core/dst.c:186 [inline]
  dst_release+0x2a/0xb0 net/core/dst.c:181
IPv6: ADDRCONF(NETDEV_UP): bridge_slave_1: link is not ready
  dst_cache_destroy net/core/dst_cache.c:164 [inline]
  dst_cache_destroy+0xd3/0x1b0 net/core/dst_cache.c:156
  ip_tunnel_dev_free+0x25/0x60 net/ipv4/ip_tunnel.c:970
  netdev_run_todo+0x647/0xae0 net/core/dev.c:8885
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:117
  ip_tunnel_delete_nets+0x4df/0x6d0 net/ipv4/ip_tunnel.c:1083
  ipip_exit_batch_net+0x23/0x30 net/ipv4/ipip.c:663
  ops_exit_list.isra.0+0x105/0x160 net/core/net_namespace.c:156
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
kobject: 'batman_adv' (0000000005425111): kobject_add_internal:  
parent: 'veth0_to_hsr', set: '<NULL>'
kobject: 'hsr_slave_0' (000000005dd69dfa): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'hsr_slave_0' (000000005dd69dfa): kobject_uevent_env
kobject: 'hsr_slave_0' (000000005dd69dfa): fill_kobj_path: path  
= '/devices/virtual/net/hsr_slave_0'
kobject: 'queues' (000000008eea68f9): kobject_add_internal:  
parent: 'hsr_slave_0', set: '<NULL>'
kobject: 'queues' (000000008eea68f9): kobject_uevent_env
kobject: 'queues' (000000008eea68f9): kobject_uevent_env: filter function  
caused the event to drop!
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
