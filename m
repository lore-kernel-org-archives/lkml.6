Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95B3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5052206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfALSLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:11:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39939 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfALSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:11:05 -0500
Received: by mail-io1-f69.google.com with SMTP id u2so15965314iob.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=n9OlPP2y9AhcJSBqHYvIsQy9vPGlapBWfWMbUCEZU6Y=;
        b=CYK5V9QBctjP96MJnkcFKyHFf97RRhHh9KblekBx46IJ9uPodN5g+wzz12QpGUXt8y
         dlcykv24MQDVo6xtv5ZtEMK439xOPVd0EGpzo8aoMMICIShilxSqW7FY0QbvelPJ4y//
         1RU+aMW2W6qpP4N37034xZBG/FGiCU7J+WVKm9+JalX2Z3NyPRW6v0zobUtRMZKCinH3
         uqVMUjegbX4osjo+cMnBiDv6fYBU1WO+os+GpnUGjvqf4woG2QKgxE5OdOL+WUXQPWof
         RRu8NfrFWJ7WzxigQS02VgdKUoeUq6na/j7r1gLA57ZZ2DzT/V93RxjvEb6WuGCsiWar
         8AFw==
X-Gm-Message-State: AJcUuken18ZgvBC+4tVSSNMPbxOtNNDiyBxSECttnq4wx8n/31eUgsX0
        st9UT88a0nby1hDdrybt+/mKeUGJ8bLr/7bpo0G7gfVk7DCe
X-Google-Smtp-Source: ALg8bN5GxV/iLANixJUaWdIZFqb1MB9KGup96Bf1/4dLRkc+LrGcRVONrxdwYRjYNep71WYvBu8JROjiDM5NEFovHV7umzOSKDbC
MIME-Version: 1.0
X-Received: by 2002:a24:4245:: with SMTP id i66mr4410454itb.35.1547316662940;
 Sat, 12 Jan 2019 10:11:02 -0800 (PST)
Date:   Sat, 12 Jan 2019 10:11:02 -0800
In-Reply-To: <000000000000fa4f60057e499989@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cb9e2057f46bcb2@google.com>
Subject: Re: WARNING in batadv_mcast_mla_tt_retract
From:   syzbot <syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    4b3c31c8d4dd Merge branch 'i2c/for-current' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fecc7f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=83f2d54ec6b7e417e13f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139c6408c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83f2d54ec6b7e417e13f@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth1_to_team: link is not ready
WARNING: CPU: 0 PID: 26 at net/batman-adv/multicast.c:337  
batadv_mcast_mla_tt_retract+0x3d7/0x4b0 net/batman-adv/multicast.c:337
kobject: 'lo' (000000007d40203a): kobject_uevent_env
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 26 Comm: kworker/u4:2 Not tainted 5.0.0-rc1+ #21
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: bat_events batadv_mcast_mla_update
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
kobject: 'lo' (000000007d40203a): fill_kobj_path: path  
= '/devices/virtual/net/lo'
kobject: 'queues' (0000000029ca31b3): kobject_add_internal: parent: 'lo',  
set: '<NULL>'
  __warn.cold+0x20/0x48 kernel/panic.c:571
kobject: 'queues' (0000000029ca31b3): kobject_uevent_env
  report_bug+0x263/0x2b0 lib/bug.c:186
kobject: 'queues' (0000000029ca31b3): kobject_uevent_env: filter function  
caused the event to drop!
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
kobject: 'rx-0' (00000000a8654327): kobject_add_internal: parent: 'queues',  
set: 'queues'
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:batadv_mcast_mla_tt_retract+0x3d7/0x4b0  
net/batman-adv/multicast.c:337
kobject: 'rx-0' (00000000a8654327): kobject_uevent_env
Code: 48 8b 45 d0 65 48 33 04 25 28 00 00 00 0f 85 c8 00 00 00 48 81 c4 a0  
00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 29 07 b0 f9 <0f> 0b e9 de fc  
ff ff e8 9d f2 f3 f9 e9 e3 fd ff ff 48 89 df e8 b0
RSP: 0018:ffff8880a96676b0 EFLAGS: 00010293
RAX: ffff8880a96586c0 RBX: 0000000000000001 RCX: ffffffff87d1ed13
RDX: 0000000000000000 RSI: ffffffff87d1f037 RDI: 0000000000000007
kobject: 'rx-0' (00000000a8654327): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/rx-0'
RBP: ffff8880a9667778 R08: ffff8880a96586c0 R09: 0000000000000003
R10: 0000000000000000 R11: ffff8880ae62dc7b R12: ffff8880a9667868
R13: 0000000000000000 R14: 1ffff110152ccf0d R15: ffff88808820dc40
kobject: 'tx-0' (00000000e6698f16): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000e6698f16): kobject_uevent_env
kobject: 'tx-0' (00000000e6698f16): fill_kobj_path: path  
= '/devices/virtual/net/lo/queues/tx-0'
  __batadv_mcast_mla_update net/batman-adv/multicast.c:635 [inline]
  batadv_mcast_mla_update+0x78e/0x2980 net/batman-adv/multicast.c:661
kobject: 'veth1_to_bond' (00000000a8d46f44): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'veth1_to_bond' (00000000a8d46f44): kobject_uevent_env
kobject: 'veth1_to_bond' (00000000a8d46f44): fill_kobj_path: path  
= '/devices/virtual/net/veth1_to_bond'
kobject: 'queues' (000000006228a66d): kobject_add_internal:  
parent: 'veth1_to_bond', set: '<NULL>'
kobject: 'queues' (000000006228a66d): kobject_uevent_env
kobject: 'queues' (000000006228a66d): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000008bc09a3a): kobject_add_internal: parent: 'queues',  
set: 'queues'
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
kobject: 'rx-0' (000000008bc09a3a): kobject_uevent_env
kobject: 'rx-0' (000000008bc09a3a): fill_kobj_path: path  
= '/devices/virtual/net/veth1_to_bond/queues/rx-0'
kobject: 'tx-0' (000000007f0c3f6d): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000007f0c3f6d): kobject_uevent_env
kobject: 'tx-0' (000000007f0c3f6d): fill_kobj_path: path  
= '/devices/virtual/net/veth1_to_bond/queues/tx-0'
kobject: 'batman_adv' (00000000f9be0f83): kobject_add_internal:  
parent: 'veth1_to_bond', set: '<NULL>'
kobject: 'bond_slave_1' (000000003c754cbc): kobject_add_internal:  
parent: 'net', set: 'devices'
kobject: 'bond_slave_1' (000000003c754cbc): kobject_uevent_env
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
kobject: 'bond_slave_1' (000000003c754cbc): fill_kobj_path: path  
= '/devices/virtual/net/bond_slave_1'
kobject: 'queues' (000000002a7c877f): kobject_add_internal:  
parent: 'bond_slave_1', set: '<NULL>'
kobject: 'queues' (000000002a7c877f): kobject_uevent_env
kobject: 'queues' (000000002a7c877f): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000bd1d2cc7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000bd1d2cc7): kobject_uevent_env
kobject: 'rx-0' (00000000bd1d2cc7): fill_kobj_path: path  
= '/devices/virtual/net/bond_slave_1/queues/rx-0'
kobject: 'tx-0' (00000000ccbdecac): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000ccbdecac): kobject_uevent_env
kobject: 'tx-0' (00000000ccbdecac): fill_kobj_path: path  
= '/devices/virtual/net/bond_slave_1/queues/tx-0'
kobject: 'batman_adv' (0000000021ba1ff8): kobject_add_internal:  
parent: 'bond_slave_1', set: '<NULL>'
  kthread+0x357/0x430 kernel/kthread.c:246
kobject: 'ip6gretap0' (0000000011d834fd): kobject_add_internal:  
parent: 'net', set: 'devices'
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kobject: 'ip6gretap0' (0000000011d834fd): kobject_uevent_env
Kernel Offset: disabled
Rebooting in 86400 seconds..

