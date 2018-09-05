Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6FEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99AF20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99AF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeIELmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:42:50 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:55987 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIELmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:42:50 -0400
Received: by mail-it0-f70.google.com with SMTP id m207-v6so6711350itg.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=T9dPrpnbN0vsoWJ1EcqMLCpGOaQdUBPpFCIc9guLm2g=;
        b=CR8nCKrac9NnE+Sv41eIpFX4NBMz8RA/ETmjP1IwojvkYeGWicwA5gT3OjcMD+vTeq
         c7RZq7Z/nrZVfmiZTNelk74K2MH5jYnv8RLgJxJmGtIWqdKTjnSSki9XjfoDi+jmwfaN
         J7g/fZHCuO29tPA8eRuVcJtjzb7qljFeSS9dLtHV93rojMTxUQr3N8IUNF0zNkAVx5au
         d7607wpj4XjKIsaH2BP32Bm/kWdPDzSEyXtzSKtwcvFhPv7PcE3vGyySaoRuuGySqNyv
         YLrkS+Zu4vFPAn1JPDw8vSOV4O5vkoRJJmJd9cz9Qu2csvTwALrZ/iCkaLbC8xAgedX+
         ipuA==
X-Gm-Message-State: APzg51D72PBaXZUbW7ch888TNkVVo6M3I/smMxyUrPlqRGzAyADOE0+W
        gqOngjaffLoVCOmZT9shvHeH5idEbXWtZk2Kb0lYh6nTxAvo
X-Google-Smtp-Source: ANB0VdaYDnbkLLPOAflm5NX/C/HGESvezlB7u+ehU29OrzPGBm/3Dl4wvv0aHqSSJ4M75AiM9fhs14XYsQgxw+MA5r2f28t9YNDi
MIME-Version: 1.0
X-Received: by 2002:a6b:f407:: with SMTP id i7-v6mr16815433iog.131.1536131642397;
 Wed, 05 Sep 2018 00:14:02 -0700 (PDT)
Date:   Wed, 05 Sep 2018 00:14:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df996b05751a84ed@google.com>
Subject: general protection fault in klist_put (2)
From:   syzbot <syzbot+22995b06a543d8f61a59@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    60c1f89241d4 Merge tag 'dma-mapping-4.19-2' of git://git.i..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1405013e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=22995b06a543d8f61a59
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+22995b06a543d8f61a59@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 13591 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #220
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:klist_put+0x50/0x180 lib/klist.c:213
Code: c1 ea 03 80 3c 02 00 0f 85 2b 01 00 00 48 b8 00 00 00 00 00 fc ff df  
49 8b 1c 24 48 83 e3 fe 48 8d 7b 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 fa 00 00 00 48 89 df 4c 8b 73 50 e8 fa e8 06 00
RSP: 0018:ffff880184867228 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90001e8c000
RDX: 000000000000000a RSI: ffffffff86cdb528 RDI: 0000000000000050
RBP: ffff880184867250 R08: fffffbfff1151e35 R09: fffffbfff1151e34
R10: fffffbfff1151e34 R11: ffffffff88a8f1a3 R12: ffff8801ce520ef8
R13: 0000000000000001 R14: 0000000000000001 R15: ffffffff86cdb9ad
FS:  00007f2dc774f700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f766e67d0 CR3: 00000001c8958000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  klist_del lib/klist.c:231 [inline]
  klist_remove+0x241/0x460 lib/klist.c:250
  __device_release_driver drivers/base/dd.c:979 [inline]
  device_release_driver_internal+0x589/0x750 drivers/base/dd.c:999
  device_release_driver+0x19/0x20 drivers/base/dd.c:1024
  usb_driver_release_interface+0x110/0x190 drivers/usb/core/driver.c:604
  proc_disconnect_claim+0x288/0x410 drivers/usb/core/devio.c:2281
  usbdev_do_ioctl+0x17ee/0x3b30 drivers/usb/core/devio.c:2523
  usbdev_ioctl+0x25/0x30 drivers/usb/core/devio.c:2551
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2dc774ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2dc774f6d4 RCX: 0000000000457099
RDX: 0000000020000080 RSI: 000000008108551b RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004ce8f0 R14: 00000000004c4e0b R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace d19413fa3dcc6123 ]---
RIP: 0010:klist_put+0x50/0x180 lib/klist.c:213
Code: c1 ea 03 80 3c 02 00 0f 85 2b 01 00 00 48 b8 00 00 00 00 00 fc ff df  
49 8b 1c 24 48 83 e3 fe 48 8d 7b 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 fa 00 00 00 48 89 df 4c 8b 73 50 e8 fa e8 06 00
RSP: 0018:ffff880184867228 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90001e8c000
IPVS: ftp: loaded support on port[0] = 21
RDX: 000000000000000a RSI: ffffffff86cdb528 RDI: 0000000000000050
RBP: ffff880184867250 R08: fffffbfff1151e35 R09: fffffbfff1151e34
R10: fffffbfff1151e34 R11: ffffffff88a8f1a3 R12: ffff8801ce520ef8
R13: 0000000000000001 R14: 0000000000000001 R15: ffffffff86cdb9ad
FS:  00007f2dc774f700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f766e67d0 CR3: 00000001c8958000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
