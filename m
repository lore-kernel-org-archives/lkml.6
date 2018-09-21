Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1339ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A6421568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A6421568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390966AbeIUXNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:13:55 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47614 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390395AbeIUXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:13:54 -0400
Received: by mail-io1-f70.google.com with SMTP id v20-v6so23329118iom.14
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Rr1IflITrDoO5M9kER5aRqmHpY5qAo2msvf2WNFxyrs=;
        b=Tq34aRxF87WrCJ9+Ttfx+/VyDsH2fauXeI59CMTKYcSNp9YASzCp54OCSCDdRhHk3d
         N4P1Qxr7wiyqXDx2DuN78F0nF0yIh7tR5HuWi/hN60fNjT6AFhjgL8Wc6CEnoVlQAFlv
         1pbwbdSruxQoG7x14BM8WpCA2fG1sViobPDGrv7M/K+vo9dszMDnva4pqDOyN388lDyY
         hVjhJHJ87osEKzY21YBh91digqyxTNl2FeFkhsLD9ktSei0m99FI3iMck8hhimcpJqF2
         JmYgHcfx+UuvW6zimHCToJTa1dEAzF2vSI6GL1EEJZikA807YKFRnfPBrUGFE0xZgdcU
         af3A==
X-Gm-Message-State: APzg51CecqJMUB6cmfCYEzIylp3W4Ofd5Av+avP6dxEGCHurQoWcuwOH
        27bE9Ty27WXImpsOmM3qsXbVFryeftfUtj4RAYdkOwFbfEHR
X-Google-Smtp-Source: ANB0VdZOEXxBDjV7Hwak1KWz65g1OFEIELZuki86rTteu5QVvvvQm0T3P+0w8ADJ6Qgn1I/Ak31uSXPjoUQDnB0axXTjfwL5HTba
MIME-Version: 1.0
X-Received: by 2002:a6b:c786:: with SMTP id x128-v6mr35468449iof.1.1537550642800;
 Fri, 21 Sep 2018 10:24:02 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e36e81057664e7c5@google.com>
Subject: WARNING in clear_standby
From:   syzbot <syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com>
To:     ceph-devel@vger.kernel.org, davem@davemloft.net,
        idryomov@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, sage@redhat.com,
        syzkaller-bugs@googlegroups.com, zyan@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    46c163a036b4 Add linux-next specific files for 20180921
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e32b9e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ea07a946ad19d7
dashboard link: https://syzkaller.appspot.com/bug?extid=acdeb633f6211ccdf886
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ffa12a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1668561a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+acdeb633f6211ccdf886@syzkaller.appspotmail.com

libceph: mon0 [::1]:6789 socket error on write
libceph: mon0 [::1]:6789 socket error on write
libceph: mon0 [::1]:6789 socket error on write
libceph: mon0 [::1]:6789 socket error on write
libceph: mon0 [::1]:6789 socket error on write
WARNING: CPU: 1 PID: 5595 at net/ceph/messenger.c:3101  
clear_standby+0x174/0x1b0 net/ceph/messenger.c:3101
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 5595 Comm: syz-executor575 Not tainted  
4.19.0-rc4-next-20180921+ #77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:clear_standby+0x174/0x1b0 net/ceph/messenger.c:3101
Code: 48 89 da 48 c7 c6 00 99 e3 88 48 c7 c7 e0 d3 4f 8a e8 a0 ee 02 fc e9  
fe fe ff ff e8 06 e4 21 fa e9 47 ff ff ff e8 7c 6a de f9 <0f> 0b eb 85 4c  
89 ef e8 10 e4 21 fa e9 ae fe ff ff 4c 89 ef e8 03
RSP: 0018:ffff8801bfb67710 EFLAGS: 00010293
RAX: ffff8801d928e5c0 RBX: ffff8801cbca2028 RCX: ffffffff879ee638
RDX: 0000000000000000 RSI: ffffffff879ee6b4 RDI: 0000000000000007
RBP: ffff8801bfb67728 R08: ffff8801d928e5c0 R09: ffffed0039794435
R10: ffff8801bfb67728 R11: ffff8801cbca21af R12: 0000000000000001
R13: ffff8801cbca2160 R14: ffff8801c878fb90 R15: ffff8801bfb67808
  ceph_con_send+0x471/0x930 net/ceph/messenger.c:3136
  __send_prepared_auth_request+0x155/0x1b0 net/ceph/mon_client.c:111
  __open_session+0x3df/0x640 net/ceph/mon_client.c:199
  ceph_monc_open_session+0x47/0x60 net/ceph/mon_client.c:448
  __ceph_open_session+0xe2/0x830 net/ceph/ceph_common.c:705
  ceph_real_mount fs/ceph/super.c:900 [inline]
  ceph_mount+0x1410/0x1ea0 fs/ceph/super.c:1085
  legacy_get_tree+0x131/0x460 fs/fs_context.c:718
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1795
  do_new_mount fs/namespace.c:2648 [inline]
  do_mount+0x70c/0x1d90 fs/namespace.c:2974
  ksys_mount+0x12d/0x140 fs/namespace.c:3190
  __do_sys_mount fs/namespace.c:3204 [inline]
  __se_sys_mount fs/namespace.c:3201 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3201
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440d39
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdf06babe8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440d39
RDX: 00000000200001c0 RSI: 0000000020000180 RDI: 0000000020000240
RBP: 0000000000000000 R08: 0000000000000000 R09: 00000009004002c8
R10: 0000000000000000 R11: 0000000000000286 R12: 000000000000956a
R13: 0000000000401d10 R14: 0000000000000000 R15: 0000000000000000
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
