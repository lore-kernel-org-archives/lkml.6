Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C990FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D0E2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbeLTMKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:10:05 -0500
Received: from mail-ot1-f70.google.com ([209.85.210.70]:44789 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbeLTMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:10:04 -0500
Received: by mail-ot1-f70.google.com with SMTP id z22so993915oto.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=So5MRVzapq1oKJagfTZLbGsWSfeVzABXE3FSpGfOLBQ=;
        b=ePme3InZ3lKb+2pbzZQPgdB6Uvr/9yF1srmuOTzFic3dHwpf6iyPNibfsGUffdN3PU
         8AhjYhHCwBEr//1loZ5GNuyore0YZ9V9rKHLlh+IFX7IgTOoXvoK8LO3XAeQrT1Z926l
         UyBEOLSpsuotuxVsNwzgh5AkVLQGvKWnb8jeTs46T8tGw+TzR/4zt42cOgIzde89bRk2
         7eHUB1FAEqk7ALUrDzxpex9OiocAv3AioRvKW+h2xj2fgMvHMHcTfiKYbsl2vFJgMiO8
         fb1Qam79AUzAJcYdUlTwcR7Dx1psqtFlmKbmrFe/18U9HM2hjJqzBoX7HRfXCTm/CVai
         2Xcw==
X-Gm-Message-State: AA+aEWbXfImjw3njujakC80VxJV1N/r5/VFNob185ox2lcaPzqrbJmOr
        oCcV18R1PWN92Vl3royFLHC5PRhZ43XPCiJZtB22ekr/cr7W
X-Google-Smtp-Source: AFSGD/VS3cNfpWgnZJgtboHEY4z35stRiAK4xnQsQVlwQv0cTEgtqc08rtGc+cJUWraY2ppoFE5FwsW7WnLEq/dalT/lvb8HLrVr
MIME-Version: 1.0
X-Received: by 2002:a9d:12f5:: with SMTP id g108mr21816410otg.57.1545307803117;
 Thu, 20 Dec 2018 04:10:03 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:10:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac7057057d730213@google.com>
Subject: KASAN: slab-out-of-bounds Read in xfrm_policy_lookup_bytype
From:   syzbot <syzbot+485623f77eab9345799d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    33f18c96afdf net: ethernet: don't set phylib state CHANGEL..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17648ab3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=485623f77eab9345799d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+485623f77eab9345799d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __xfrm_policy_eval_candidates  
net/xfrm/xfrm_policy.c:2019 [inline]
BUG: KASAN: slab-out-of-bounds in xfrm_policy_eval_candidates  
net/xfrm/xfrm_policy.c:2053 [inline]
BUG: KASAN: slab-out-of-bounds in xfrm_policy_lookup_bytype+0xe5d/0xe80  
net/xfrm/xfrm_policy.c:2116
Read of size 4 at addr ffff8881c178e0b4 by task syz-executor5/21772

CPU: 1 PID: 21772 Comm: syz-executor5 Not tainted 4.20.0-rc6+ #353
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  __xfrm_policy_eval_candidates net/xfrm/xfrm_policy.c:2019 [inline]
  xfrm_policy_eval_candidates net/xfrm/xfrm_policy.c:2053 [inline]
  xfrm_policy_lookup_bytype+0xe5d/0xe80 net/xfrm/xfrm_policy.c:2116
  xfrm_policy_lookup+0x7e/0x80 net/xfrm/xfrm_policy.c:2148
  xfrm_bundle_lookup net/xfrm/xfrm_policy.c:2942 [inline]
  xfrm_lookup_with_ifid+0x972/0x2b80 net/xfrm/xfrm_policy.c:3083
  xfrm_lookup net/xfrm/xfrm_policy.c:3175 [inline]
  xfrm_lookup_route+0x3c/0x1f0 net/xfrm/xfrm_policy.c:3186
  ip_route_output_flow+0xb1/0xc0 net/ipv4/route.c:2582
  raw_sendmsg+0xfe2/0x2ac0 net/ipv4/raw.c:647
  inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1c03de9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000020000040 R09: 0000000000000010
R10: 000000000404c0c0 R11: 0000000000000246 R12: 00007f1c03dea6d4
R13: 00000000004c452d R14: 00000000004d7590 R15: 00000000ffffffff

Allocated by task 12834:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
  getname_flags+0xd0/0x590 fs/namei.c:140
  user_path_at_empty+0x2d/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_stat include/linux/fs.h:3165 [inline]
  __do_sys_newstat+0x8f/0x110 fs/stat.c:339
  __se_sys_newstat fs/stat.c:335 [inline]
  __x64_sys_newstat+0x54/0x80 fs/stat.c:335
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 12834:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x83/0x290 mm/slab.c:3760
  putname+0xf2/0x130 fs/namei.c:261
  filename_lookup+0x39a/0x520 fs/namei.c:2357
  user_path_at_empty+0x40/0x50 fs/namei.c:2608
  user_path_at include/linux/namei.h:57 [inline]
  vfs_statx+0x129/0x210 fs/stat.c:185
  vfs_stat include/linux/fs.h:3165 [inline]
  __do_sys_newstat+0x8f/0x110 fs/stat.c:339
  __se_sys_newstat fs/stat.c:335 [inline]
  __x64_sys_newstat+0x54/0x80 fs/stat.c:335
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881c178e3c0
  which belongs to the cache names_cache of size 4096
The buggy address is located 780 bytes to the left of
  4096-byte region [ffff8881c178e3c0, ffff8881c178f3c0)
The buggy address belongs to the page:
page:ffffea000705e380 count:1 mapcount:0 mapping:ffff8881da980e00 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000714a388 ffffea0006312b08 ffff8881da980e00
raw: 0000000000000000 ffff8881c178e3c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c178df80: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881c178e000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881c178e080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                      ^
  ffff8881c178e100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881c178e180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
