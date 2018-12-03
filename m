Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5967FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23ED62087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23ED62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLCXKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:10:08 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40516 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:10:06 -0500
Received: by mail-io1-f70.google.com with SMTP id u2so15636383iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3uWd2UDXInU1q8QzwLh/tficAoNgjuSPGl2BRCoUUXs=;
        b=jTfIt/Toctom4P2YZbHRAVJh+Qo40F/9eAg67+yxLpTMjtgnfzaPYPa+q1n49qHkYc
         S1qIhUI3vtJt4AojHtSPULMyuWLiHALQcQdn4OY58VU2vpRALb3PFIKYiwHaq7jqbwy8
         UIgtd3hZXC0UBUPS7ZaWuXQIgwc+vCm22Vh0RyRI69v2ca11sVXhAiLt1UIYTVKvxLG3
         aAcTkWCbXOEtUorKy4pU4KI5PedLyvldPO00ymtX2s1mB4Zh5wgoyOHD7jM/XUYyumdc
         CpB8n9EYEeI3Vph37vRyz9imBJ0EJcwJ/6erzsuu1eMTEnSqxFdPb3EYNYTkX6YhkJvY
         lznw==
X-Gm-Message-State: AA+aEWb2jDvHiH8+rR8p/uEDSNE/cJdUuo1Ou10GUiqv4wyo3FU2CXAM
        p/UNCuD2V0C4POp8Xa9LrGib9ZEkMFYnzLnVeU2Gnqvy/1jg
X-Google-Smtp-Source: AFSGD/VU48xV5jjqaZzDaEMVtvpeI9xO+kbyabvE6Sot6nVIXnh/Bj5oFUaxh9tNpgEIfdOc9OItqJU3KlXrtGsld7/apiRXd+Xk
MIME-Version: 1.0
X-Received: by 2002:a24:8342:: with SMTP id d63mr8849063ite.26.1543878605274;
 Mon, 03 Dec 2018 15:10:05 -0800 (PST)
Date:   Mon, 03 Dec 2018 15:10:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d803f9057c263f74@google.com>
Subject: WARNING in userfaultfd_ioctl
From:   syzbot <syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d8f190ee836a Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d5f293400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4602730af4f872ef
dashboard link: https://syzkaller.appspot.com/bug?extid=06c7092e7d71218a2c16
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112711a3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169eb87d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+06c7092e7d71218a2c16@syzkaller.appspotmail.com

audit: type=1800 audit(1543692860.969:30): pid=5864 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 1 PID: 6019 at fs/userfaultfd.c:1569 userfaultfd_unregister  
fs/userfaultfd.c:1569 [inline]
WARNING: CPU: 1 PID: 6019 at fs/userfaultfd.c:1569  
userfaultfd_ioctl+0x3d30/0x5610 fs/userfaultfd.c:1845
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6019 Comm: syz-executor263 Not tainted 4.20.0-rc4+ #358
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:userfaultfd_unregister fs/userfaultfd.c:1569 [inline]
RIP: 0010:userfaultfd_ioctl+0x3d30/0x5610 fs/userfaultfd.c:1845
Code: 85 c0 f6 ff ff 48 c1 e8 03 42 80 3c 30 00 0f 84 a3 fa ff ff 48 8b bd  
c0 f6 ff ff e8 4a 60 db ff e9 92 fa ff ff e8 20 07 98 ff <0f> 0b e9 cd f7  
ff ff e8 14 07 98 ff 48 8b 95 f0 f6 ff ff b9 01 00
RSP: 0018:ffff8881c1417270 EFLAGS: 00010293
RAX: ffff8881c1e32300 RBX: 00000000080000d0 RCX: ffffffff81e77b7b
RDX: 0000000000000000 RSI: ffffffff81e783b0 RDI: 0000000000000007
RBP: ffff8881c1417c00 R08: ffff8881c1e32300 R09: 0000000000000008
R10: 0000000000003cb4 R11: ffff8881c1e32300 R12: 0000000020011000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8881c2b6e460
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ad9
Code: 23 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00000000007dff68 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc8f046ee0 RCX: 0000000000440ad9
RDX: 0000000020d62fe0 RSI: 000000008010aa01 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000217 R12: 0000000000402270
R13: 0000000000402300 R14: 0000000000000000 R15: 0000000000000000
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
