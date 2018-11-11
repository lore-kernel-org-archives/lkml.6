Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EDEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C662148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C662148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeKLEHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:07:19 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:37385 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbeKLEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:07:18 -0500
Received: by mail-io1-f72.google.com with SMTP id w26-v6so7897938ioa.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 10:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9RHTApCzojvvipQUWaC0rnunuhg75GQJq1cI2VvYjeM=;
        b=jWwxiB+jV2neX2Ee0rV2szQLNkJ8sEdl1MU1+namAW/knW1lMFrz9fbqe8YGB7K7By
         Tf/DnnHQWQirxyTH9YBrBptnc3VwVo+OVbSH1fkXU9SUw2NjoKO5ZGTALgHbPQcrLHeu
         53caWo1nHBJb5oZBGUhlu9cpN7Rnp2kfyHPQ6P4kwm/xk6ruVBfnQ58aUqD1mcPemJ9z
         LYeep+vBSfMFz2oEa+0enTj0iYI5+TLV3kORgBIJWMFKnF5fJ/stUp8GYmK0VqlS97sS
         wlvOkVMCy3o1dGthkFW/6IUvZhuqzeONRR4Lg2oX5vKD2gdQh9uuckOZgVQxqlP/vOHD
         x/bg==
X-Gm-Message-State: AGRZ1gIeF2emL55UO7vKgFI83vg88gP59G3ZmYDXGXNvEP2w5WLud9aI
        +JcbRGR76cdpndYGpFLAs9r5+IFfrEFQCm9tmi7651lU3WU5
X-Google-Smtp-Source: AJdET5eGnvZQqS6Qz1EB6CJMg/vR5TzOZ913rAjjyZht2di8rNrRZMGbaFx3YzK2k5cReFP+3Tl8Rs/tCfAZYo1bbyGY1CKcNe2v
MIME-Version: 1.0
X-Received: by 2002:a24:6908:: with SMTP id e8-v6mr8533428itc.7.1541960284060;
 Sun, 11 Nov 2018 10:18:04 -0800 (PST)
Date:   Sun, 11 Nov 2018 10:18:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd464c057a679adb@google.com>
Subject: KASAN: use-after-free Read in update_blocked_averages
From:   syzbot <syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    12ceaf8864c2 infiniband: nes: Fix more direct skb list acc..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15a82783400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcbea7daf3ea3e3e
dashboard link: https://syzkaller.appspot.com/bug?extid=0dbf864d3b52555e8265
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ae6d5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dbd77b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0dbf864d3b52555e8265@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in skip_blocked_update kernel/sched/fair.c:3324  
[inline]
BUG: KASAN: use-after-free in update_blocked_averages+0x1533/0x1e00  
kernel/sched/fair.c:7400
kasan: CONFIG_KASAN_INLINE enabled
Read of size 8 at addr ffff8801bf0d6ea0 by task syz-executor841/6015

kasan: GPF could be caused by NULL-ptr deref or user memory access
CPU: 1 PID: 6015 Comm: syz-executor841 Not tainted 4.20.0-rc1+ #289
general protection fault: 0000 [#1] PREEMPT SMP KASAN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
CPU: 0 PID: 6272 Comm: syz-executor841 Not tainted 4.20.0-rc1+ #289
Call Trace:
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
RIP: 0010:vmalloc_fault+0x426/0x770 arch/x86/mm/fault.c:405
Code: e0 e8 fe 25 47 00 48 b8 00 00 00 00 00 88 ff ff 48 ba 00 00 00 00 00  
fc ff df 48 01 c3 4d 21 e5 4c 01 eb 48 89 d9 48 c1 e9 03 <80> 3c 11 00 0f  
85 b2 02 00 00 48 8b 1b 31 ff 49 89 dc 49 83 e4 9f
RSP: 0018:ffff8801d9d624c8 EFLAGS: 00010002
RAX: ffff880000000000 RBX: 000f100180000040 RCX: 0001e20030000008
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
RDX: dffffc0000000000 RSI: ffffffff813864c2 RDI: 0000000000000007
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
RBP: ffff8801d9d624f8 R08: ffff8801bbb56700 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000fffffc0000000
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
R13: 000f880180000000 R14: ffffc90001159838 R15: 1ffffffff12a3f98
  skip_blocked_update kernel/sched/fair.c:3324 [inline]
  update_blocked_averages+0x1533/0x1e00 kernel/sched/fair.c:7400
FS:  0000000001f7d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001159838 CR3: 00000001ba705000 CR4: 00000000001406f0
Call Trace:
Modules linked in:
---[ end trace f6450057874cc9c7 ]---
RIP: 0010:vmalloc_fault+0x426/0x770 arch/x86/mm/fault.c:405
Code: e0 e8 fe 25 47 00 48 b8 00 00 00 00 00 88 ff ff 48 ba 00 00 00 00 00  
fc ff df 48 01 c3 4d 21 e5 4c 01 eb 48 89 d9 48 c1 e9 03 <80> 3c 11 00 0f  
85 b2 02 00 00 48 8b 1b 31 ff 49 89 dc 49 83 e4 9f
RSP: 0018:ffff8801d9d624c8 EFLAGS: 00010002
RAX: ffff880000000000 RBX: 000f100180000040 RCX: 0001e20030000008
RDX: dffffc0000000000 RSI: ffffffff813864c2 RDI: 0000000000000007
RBP: ffff8801d9d624f8 R08: ffff8801bbb56700 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000fffffc0000000
R13: 000f880180000000 R14: ffffc90001159838 R15: 1ffffffff12a3f98
FS:  0000000001f7d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001159838 CR3: 00000001ba705000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
