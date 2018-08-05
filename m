Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE19C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 06:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A8421748
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 06:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A8421748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeHEIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 04:02:26 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:35536 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeHEIC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 04:02:26 -0400
Received: by mail-io0-f199.google.com with SMTP id y4-v6so7463819iol.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 22:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nle5kfuFoppCTMUt646HSbSPlUMSHyx8BUji338zqnM=;
        b=YBJssyMwKYeE+C3tSnVK9f3Uy5p0dixr2I55LPgON3Q9pGdGj+KTLB1gzQ3siOr1w8
         ATN1pduhKn3QuZBL3NLmHBO7bB6mJFkGjoWYgDBofuG9h1AKovS9oY0HMXNt0TcZSd19
         cqoPh7MHEN/8aAS4QuWUvKPjB4Lql2LuxUp9jOTuiANCceMzzVziwQdFrki/hb/D0ZkZ
         P+U3UbDsunLvIXMRDHDIUmwpZMRIEwyIheFvddmbPDdtn4to9YOTDubDNx6hRn0t6hYI
         7l9rMlsal9dnByGBLL7wjQADi8nPqjzhy//T5HUTV/7VTVzaZuw1MrUcc3PVkyDNVrZq
         akfw==
X-Gm-Message-State: AOUpUlF217yOA5n41J2UegTTPHDW9daRYlJrgV7aK8yZgqNQgCk58U8b
        Qz+8Hag+iTfm8SOIKeeg2zFWPd65Sk2NWkJn26ZyUxdU8xBU
X-Google-Smtp-Source: AAOMgpeDDXkzvFsSS3ct+FOHBau55nKiYvpMCi9CBYrsCpdkf8169t7I8WupyDEWIhcbvRQCkWuT2SXrlcETGE8O2WpsKPN8Vs23
MIME-Version: 1.0
X-Received: by 2002:a24:2853:: with SMTP id h80-v6mr2649691ith.27.1533448742797;
 Sat, 04 Aug 2018 22:59:02 -0700 (PDT)
Date:   Sat, 04 Aug 2018 22:59:02 -0700
In-Reply-To: <00000000000086f39e057245c3ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000988b9c0572a9db97@google.com>
Subject: Re: WARNING: ODEBUG bug in rfcomm_dlc_free
From:   syzbot <syzbot+1f6d4ad860c650c2f215@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        keescook@chromium.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    116b181bb646 Add linux-next specific files for 20180803
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1010268c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4f38be7c2c519d5
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6d4ad860c650c2f215
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=101200e2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121d3bdc400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f6d4ad860c650c2f215@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
urandom_read: 1 callbacks suppressed
random: sshd: uninitialized urandom read (32 bytes read)
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:  
rfcomm_dlc_timeout+0x0/0x70 include/linux/list.h:64
WARNING: CPU: 0 PID: 4267 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4267 Comm: syz-executor929 Not tainted  
4.18.0-rc7-next-20180803+ #31
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
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:996
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Code: 3a 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
60 a8 3a 87 4c 89 f6 48 c7 c7 00 9e 3a 87 e8 26 70 e2 fd <0f> 0b 83 05 09  
33 26 05 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff8801b686f648 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816366f1 RDI: 0000000000000001
RBP: ffff8801b686f688 R08: ffff8801cb852380 R09: ffffed003b603ec2
R10: ffffed003b603ec2 R11: ffff8801db01f617 R12: 0000000000000001
R13: ffffffff87f9d1c0 R14: ffffffff873aa2a0 R15: ffffffff816988b0
  __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
  debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:818
  kfree+0xc7/0x260 mm/slab.c:3812
  rfcomm_dlc_free+0x1e/0x30 net/bluetooth/rfcomm/core.c:328
  rfcomm_dlc_put include/net/bluetooth/rfcomm.h:258 [inline]
  __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
  rfcomm_create_dev net/bluetooth/rfcomm/tty.c:486 [inline]
  rfcomm_dev_ioctl+0x1dfe/0x2240 net/bluetooth/rfcomm/tty.c:588
  rfcomm_sock_ioctl+0x89/0xb0 net/bluetooth/rfcomm/sock.c:902
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:950
  sock_ioctl+0x30d/0x680 net/socket.c:1074
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4406d9
Code: e8 2c af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff697e60e8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004406d9
RDX: 0000000020000000 RSI: 00000000400452c8 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000013d1880 R11: 0000000000000213 R12: 0000000000009731
R13: 0000000000401c30 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

