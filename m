Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E5EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD5D20685
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD5D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeHRTpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:45:20 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:59037 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeHRTpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:45:20 -0400
Received: by mail-it0-f70.google.com with SMTP id y13-v6so10289334ita.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 09:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Sz08YEUrv4gQTJouJ6wiQdpwuGPj3wyM3pg8XPOqe9g=;
        b=FKOj5LxHDPfZv0OGJfrqPBUF7VNlnrvYjqjIEaAIdMoKVcHjA8UCNtYhTqYGObZAHC
         2koKkKsxsKaB2h0oAiOMK2rk9LlxcTbh6btGfBEx/sdTxJxjShChruOhkN2wa6lMIsoh
         I3ulK7VzpzeyuyedTDHOyl5sKoRrWR316vgCicFFlaKZ4A8j8McOW+NOQT+2RPI6rOXf
         lv0Wy6O4e416H3ak0kOUaNQ1dnNTG3LDtH9YfU1kiD+jhTiny4EPj7FqkZ8QT83XMOGZ
         OnIjgvwp56QAUxdv1ABlAhJyAiHSN+YGgXxqsIj7pggYxs+hb94/2UIDIDWgeyto98nL
         mu9A==
X-Gm-Message-State: AOUpUlEzdXaS6h85lRUzU81/hce91Yy5wcIfhMTyDaYaF3G72fzOBJyg
        H5r2yNiJxuKZn07ygBYeKLdnpvd/mxCO86crh3m0xF5Xb/wj
X-Google-Smtp-Source: AA+uWPyXGF/OeTnVNG4a3tCek4aY5g/AXx97A4zvVSyVRMZhsRiCFuyXllCbP7gyD/cp6WIsLgMHE6chC3qbb8LAEF/Sre+a1Cr4
MIME-Version: 1.0
X-Received: by 2002:a02:b886:: with SMTP id p6-v6mr18727641jam.42.1534610222299;
 Sat, 18 Aug 2018 09:37:02 -0700 (PDT)
Date:   Sat, 18 Aug 2018 09:37:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b42040573b8495a@google.com>
Subject: WARNING: refcount bug in igmp_start_timer
From:   syzbot <syzbot+e28037ac1c96d2a86e89@syzkaller.appspotmail.com>
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

HEAD commit:    edb0a2000936 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1749ebce400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fd89f99c889a184
dashboard link: https://syzkaller.appspot.com/bug?extid=e28037ac1c96d2a86e89
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e28037ac1c96d2a86e89@syzkaller.appspotmail.com

binder: 17097:17099 Acquire 1 refcount change on invalid ref 0 ret -22
binder: 17097:17099 BC_REQUEST_DEATH_NOTIFICATION invalid ref 0
------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 0 PID: 17119 at lib/refcount.c:153  
refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 17119 Comm: syz-executor2 Not tainted 4.18.0+ #194
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
binder: 17097:17122 unknown command 1074553618
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:refcount_inc_checked+0x5d/0x70 lib/refcount.c:153
Code: 1d 7d f5 24 05 31 ff 89 de e8 7f be 1b fe 84 db 75 df e8 a6 bd 1b fe  
48 c7 c7 00 72 3a 87 c6 05 5d f5 24 05 01 e8 43 4e e6 fd <0f> 0b eb c3 0f  
1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
binder: 17097:17122 ioctl c0306201 20000040 returned -22
RSP: 0018:ffff88019521ebd8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000200d000
RDX: 0000000000003667 RSI: ffffffff8163ac21 RDI: ffff88019521e8c8
RBP: ffff88019521ebe0 R08: ffff880199d10080 R09: 0000000000000002
R10: ffff880199d10080 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000008 R14: ffff8801d7aaa2c0 R15: dffffc0000000000
  igmp_start_timer+0xaf/0xe0 net/ipv4/igmp.c:217
  igmp_mod_timer net/ipv4/igmp.c:255 [inline]
  igmp_heard_query net/ipv4/igmp.c:1027 [inline]
  igmp_rcv+0x1920/0x3060 net/ipv4/igmp.c:1062
  ip_local_deliver_finish+0x2eb/0xda0 net/ipv4/ip_input.c:215
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip_local_deliver+0x1e9/0x750 net/ipv4/ip_input.c:256
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1f9/0x300 net/ipv4/ip_input.c:415
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip_rcv+0xed/0x610 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4892
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5002
  netif_receive_skb_internal+0x12e/0x680 net/core/dev.c:5105
  netif_receive_skb+0xbf/0x420 net/core/dev.c:5178
  tun_rx_batched.isra.56+0x4ba/0x8c0 drivers/net/tun.c:1572
  tun_get_user+0x2ac9/0x42c0 drivers/net/tun.c:1982
  tun_chr_write_iter+0xb9/0x154 drivers/net/tun.c:2010
  call_write_iter include/linux/fs.h:1808 [inline]
  do_iter_readv_writev+0x8b0/0xa80 fs/read_write.c:680
  do_iter_write+0x185/0x5f0 fs/read_write.c:959
  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
  do_writev+0x11a/0x310 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456f41
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 b6 fb ff c3 48  
83 ec 08 e8 da 2c 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 23 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f1641b03ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000002a RCX: 0000000000456f41
RDX: 0000000000000001 RSI: 00007f1641b03bf0 RDI: 00000000000000f0
RBP: 0000000020000640 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000ffffffff
R13: 00000000004d6410 R14: 00000000004c9a96 R15: 0000000000000000
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
