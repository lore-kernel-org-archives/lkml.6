Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A40C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E82206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E82206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJBSZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:25:57 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51923 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeJBSZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:25:56 -0400
Received: by mail-io1-f69.google.com with SMTP id w23-v6so1998427iob.18
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 04:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/4cfpHU4knTs/0mok5SL3tvjZlpcqUWNozsLj69OLbE=;
        b=BjSDTSLWP4tnXKnE2yqQRX7DuJO+IW4p4bFtQ87qSbphCMgJ8m5kBWtoEoWJ9iOIyk
         bEJJwJZufYh90Mgno36tmOkeGHJNhUx2edmPJJkbhH3Y4QUuRhcttxlOLeUOVjJ4rSHz
         UA9Ff5CUwT1Qpil9UYcpGh2O4r2FaoiMDa+siXryGaQZ5QVtHVkSvJP3JMsf43Cr2iE8
         xOG2QRuEBagd1RgrFhe78AUXjzprtlFeU15HeN942XUo1Ga+olbXxvgK500xcafXulDz
         9zUkUj26Uw9i71/pYgpI2KQobuP0QlCnRVqfNBX44VFq3csaxJ21pAK23Y4CGoENnIav
         TQ2w==
X-Gm-Message-State: ABuFfogwA9C3AebykmYcnRPa0iq5Chz6EzrknYX/0Y0TM1t0OVa7P6gU
        4U5mntHQ83Z30hJiSr61c5AK4Cm0e7yfujyNXUiga9KUUuWW
X-Google-Smtp-Source: ACcGV63UDMNWan0ucgU8EHwLYkdBpQXSkttBXwxYJpmYdjgExXbTxCxaNA2eNl8ykxlkUb/7hjWO6HuaiCoYr+RdnhLiisNp2LNB
MIME-Version: 1.0
X-Received: by 2002:a24:5495:: with SMTP id t143-v6mr1455457ita.34.1538480582961;
 Tue, 02 Oct 2018 04:43:02 -0700 (PDT)
Date:   Tue, 02 Oct 2018 04:43:02 -0700
In-Reply-To: <000000000000f7af8605773cc09f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4360105773d6c8b@google.com>
Subject: Re: general protection fault in fuse_dev_do_write
From:   syzbot <syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    62f3d25900c9 Add linux-next specific files for 20181002
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e2a94e400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77a6dfae97d4b496
dashboard link: https://syzkaller.appspot.com/bug?extid=c1e36d30ee3416289cc0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b46781400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a54b81400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c1e36d30ee3416289cc0@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6059 Comm: syz-executor343 Not tainted  
4.19.0-rc6-next-20181002+ #85
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1741 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1801 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1834 [inline]
RIP: 0010:fuse_dev_do_write+0x1dc2/0x3810 fs/fuse/dev.c:1913
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 dc 17 00 00 49 8b 9d 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 82
RSP: 0018:ffff8801bb6ff4b8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8287fbc1
RDX: 0000000000000000 RSI: ffffffff8287fbd3 RDI: 0000000000000004
RBP: ffff8801bb6ffa50 R08: ffff8801bb5d4500 R09: ffffed003a915b7e
R10: ffffed003a915b7e R11: ffff8801d48adbf3 R12: 0000000000000000
R13: ffff8801d48adbd0 R14: 0000000000000000 R15: 0000000000000030
FS:  0000000002337880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455080 CR3: 00000001d3b53000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  fuse_dev_write+0x19a/0x240 fs/fuse/dev.c:1997
  call_write_iter include/linux/fs.h:1844 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440299
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffef8f938a8 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440299
RDX: 0000000000000030 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401b20
R13: 0000000000401bb0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 6ca075609cbc5a19 ]---
RIP: 0010:fuse_retrieve fs/fuse/dev.c:1741 [inline]
RIP: 0010:fuse_notify_retrieve fs/fuse/dev.c:1801 [inline]
RIP: 0010:fuse_notify fs/fuse/dev.c:1834 [inline]
RIP: 0010:fuse_dev_do_write+0x1dc2/0x3810 fs/fuse/dev.c:1913
Code: 00 48 c1 e0 2a 80 3c 02 00 0f 85 dc 17 00 00 49 8b 9d 58 01 00 00 b8  
ff ff 37 00 48 c1 e0 2a 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 82
RSP: 0018:ffff8801bb6ff4b8 EFLAGS: 00010247
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8287fbc1
RDX: 0000000000000000 RSI: ffffffff8287fbd3 RDI: 0000000000000004
RBP: ffff8801bb6ffa50 R08: ffff8801bb5d4500 R09: ffffed003a915b7e
R10: ffffed003a915b7e R11: ffff8801d48adbf3 R12: 0000000000000000
R13: ffff8801d48adbd0 R14: 0000000000000000 R15: 0000000000000030
FS:  0000000002337880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455080 CR3: 00000001d3b53000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

