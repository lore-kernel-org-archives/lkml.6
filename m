Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD6BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912C82154B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912C82154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbeHOSws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:52:48 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:51215 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbeHOSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:52:47 -0400
Received: by mail-it0-f72.google.com with SMTP id q5-v6so1620680ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 09:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IEDhB+IBZG/MNVy7maCMfBXfz36jegRFDsxzazbuBQw=;
        b=ZbMF+eejyWpJE9GYd91VOPJZONPdrLGVW6vMP715WFG5tiOi0gyEdq8SekYMJstEl5
         dNPJHX0zdvH1xqM4t8ZoknR1ZAW5MpFZAfdnvytp8Va42RvseSQUEdty+j+drarzm8be
         0FeJdbLHfDKbQxt6hj3txXapT6CYxiJwFkt2t32U3PF7X/19Z9id1AwNITbuuTQ3vUbi
         e6M5quJsuAAujllliKnfq9o/9waHA78IZF+jBblT6uOnOHNVO9pQkXnTOs+QOGpVQb/Q
         t+xuHW/0FO/mEVv4+Kru4KtFXH3rfRQTk4HeNfqXMMSL/LbisyFLNIMg5SPeUdQx0s0+
         XXFw==
X-Gm-Message-State: AOUpUlFF/iOd6X4dUozPNezyHgb2b1VLSjRFPrIahs5hsn/vGhp7uEuK
        S9k67YrdrfyMopXuPtdK05VXCEIepVQn3CzekmbMbpktHXDB
X-Google-Smtp-Source: AA+uWPydp2ghNp9wagOcxrrplM0RIyZjrPOiNRJjbFrDz8hW4rL9WjCqoesfIJUllGV48DDpzIGeQ2lU+k4ReTZkPdhXmOSVYR0+
MIME-Version: 1.0
X-Received: by 2002:a6b:b513:: with SMTP id e19-v6mr12401312iof.35.1534348804134;
 Wed, 15 Aug 2018 09:00:04 -0700 (PDT)
Date:   Wed, 15 Aug 2018 09:00:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ebad505737b6bf4@google.com>
Subject: WARNING in wiphy_register (2)
From:   syzbot <syzbot+2a12f11c306afe871c1f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ec0c96714e7d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b01274400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=2a12f11c306afe871c1f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10b2a2f8400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff3622400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a12f11c306afe871c1f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
netlink: 'syz-executor064': attribute type 9 has an invalid length.
WARNING: CPU: 0 PID: 4439 at net/wireless/core.c:550  
wiphy_verify_combinations net/wireless/core.c:550 [inline]
WARNING: CPU: 0 PID: 4439 at net/wireless/core.c:550  
wiphy_register+0x12c1/0x2510 net/wireless/core.c:741
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4439 Comm: syz-executor064 Not tainted 4.18.0-rc8+ #184
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
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:wiphy_verify_combinations net/wireless/core.c:550 [inline]
RIP: 0010:wiphy_register+0x12c1/0x2510 net/wireless/core.c:741
Code: 74 08 3c 01 0f 8e c5 10 00 00 66 45 89 67 30 e9 18 f9 ff ff e8 40 00  
4c fb 0f 0b bb ea ff ff ff e9 f5 f3 ff ff e8 2f 00 4c fb <0f> 0b bb ea ff  
ff ff e9 e4 f3 ff ff e8 1e 00 4c fb 0f 0b bb ea ff
RSP: 0018:ffff8801ac51ee60 EFLAGS: 00010293
RAX: ffff8801af3fc700 RBX: 0000000000000000 RCX: ffffffff86301238
RDX: 0000000000000000 RSI: ffffffff86301821 RDI: 0000000000000005
RBP: ffff8801ac51f000 R08: ffff8801af3fc700 R09: ffffed00358d6114
R10: ffffed00358d6114 R11: ffff8801ac6b08a5 R12: ffff8801ac6b327c
R13: ffffffff87838ae0 R14: dffffc0000000000 R15: ffff8801ac6b08a0
  ieee80211_register_hw+0x13d5/0x35e0 net/mac80211/main.c:1050
  mac80211_hwsim_new_radio+0x1db8/0x33b0  
drivers/net/wireless/mac80211_hwsim.c:2772
  hwsim_new_radio_nl+0x7c0/0xa80 drivers/net/wireless/mac80211_hwsim.c:3247
  genl_family_rcv_msg+0x8a3/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2455
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
  netlink_sendmsg+0xa18/0xfd0 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:642 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:652
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2126
  __sys_sendmsg+0x11d/0x290 net/socket.c:2164
  __do_sys_sendmsg net/socket.c:2173 [inline]
  __se_sys_sendmsg net/socket.c:2171 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4402c9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcf9426d68 EFLAGS: 00000213 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402c9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401b50
R13: 0000000000401be0 R14: 0000000000000000 R15: 0000000000000000
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
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
