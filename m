Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B01C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111252176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbeLTMKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:10:04 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69]:37688 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbeLTMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:10:04 -0500
Received: by mail-ot1-f69.google.com with SMTP id t13so1016411otk.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 04:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b0GYcMhBurBdoYurKeUqk25wVCFA8I6mKzNvcFyA4jA=;
        b=hsT1LLu97fB3KaEU6WD1AAzqABP1gRLeL9rIvilQcZ+n8JdwenwMPbmkc+UMHjVUzP
         9oab8od6tYET6bwxu5xZ2CleHaRoNw1JP+OBadBsHFbj7k8jxk3oPX4ay3S3yZPCWJt3
         qVLXHoQ4YB4x8UGUiKE3k7ZkyOz8Pbtn1XjAfqpfaW81/Fq2lUT8UsFFVaW6AFoahPmz
         +nTtqyP4TRjMvQhVlSdd6qBU38InNAUYr0ViliTsopU4d6xs3z5oUlxFk4+OWuoXhD9f
         6SCNyVIkgKsIVYfKhzNTH3faK+En0EJm70CE0oNsC7xN235dxFYSa+ftHQr8llHyWtvw
         z91w==
X-Gm-Message-State: AA+aEWYFTp+wxD/HCDp1/yAxSIe1TVjg0v4c2mRY5NF6ZSRwW+bm0NxO
        0c0avXW/mCt+F9stKeNTlWPHdON6ZYJ3RrLjMo87qqOPNdc1
X-Google-Smtp-Source: AFSGD/V1yDHZlHj/2r7ymUXB1N2tZHT012UalnHgJemzaoTa3P4LR0wQwMoQpeq6DNRuiKgzioQMlekP7bkVN81rOGHHXN99upLI
MIME-Version: 1.0
X-Received: by 2002:a9d:7986:: with SMTP id h6mr20872650otm.6.1545307802909;
 Thu, 20 Dec 2018 04:10:02 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:10:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a945b2057d730263@google.com>
Subject: KASAN: use-after-free Read in xfrm_policy_lookup_bytype
From:   syzbot <syzbot+87da0517ca1d154f0610@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=160b54cd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=87da0517ca1d154f0610
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87da0517ca1d154f0610@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __xfrm_policy_eval_candidates  
net/xfrm/xfrm_policy.c:2019 [inline]
BUG: KASAN: use-after-free in xfrm_policy_eval_candidates  
net/xfrm/xfrm_policy.c:2053 [inline]
BUG: KASAN: use-after-free in xfrm_policy_lookup_bytype+0xe5d/0xe80  
net/xfrm/xfrm_policy.c:2116
Read of size 4 at addr ffff8881d82352b4 by task syz-executor2/15691

CPU: 1 PID: 15691 Comm: syz-executor2 Not tainted 4.20.0-rc6+ #353
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
  ip_route_connect include/net/route.h:309 [inline]
  __ip4_datagram_connect+0x70e/0x1330 net/ipv4/datagram.c:51
  ip4_datagram_connect+0x2f/0x50 net/ipv4/datagram.c:92
  inet_dgram_connect+0x154/0x2e0 net/ipv4/af_inet.c:571
  make_send_sock net/netfilter/ipvs/ip_vs_sync.c:1509 [inline]
  start_sync_thread+0xf0c/0x2d20 net/netfilter/ipvs/ip_vs_sync.c:1877
  do_ip_vs_set_ctl+0x10cb/0x1d70 net/netfilter/ipvs/ip_vs_ctl.c:2360
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x7d/0xd0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0xd8/0xf0 net/ipv4/ip_sockglue.c:1260
  udp_setsockopt+0x62/0xa0 net/ipv4/udp.c:2611
  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:2986
  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
  __do_sys_setsockopt net/socket.c:1913 [inline]
  __se_sys_setsockopt net/socket.c:1910 [inline]
  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe3ddccec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000457669
RDX: 000000000000048b RSI: 0000000000000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000018 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 00007fe3ddccf6d4
R13: 00000000004ca9b0 R14: 00000000004d7968 R15: 00000000ffffffff

Allocated by task 5933:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  syslog_print kernel/printk/printk.c:1301 [inline]
  do_syslog+0xb9b/0x1690 kernel/printk/printk.c:1469
  kmsg_read+0x8f/0xc0 fs/proc/kmsg.c:40
  proc_reg_read+0x2a3/0x3d0 fs/proc/inode.c:231
  __vfs_read+0x117/0x9b0 fs/read_write.c:416
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 5933:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  syslog_print kernel/printk/printk.c:1352 [inline]
  do_syslog+0x147b/0x1690 kernel/printk/printk.c:1469
  kmsg_read+0x8f/0xc0 fs/proc/kmsg.c:40
  proc_reg_read+0x2a3/0x3d0 fs/proc/inode.c:231
  __vfs_read+0x117/0x9b0 fs/read_write.c:416
  vfs_read+0x17f/0x3c0 fs/read_write.c:452
  ksys_read+0x101/0x260 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d8235200
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 180 bytes inside of
  1024-byte region [ffff8881d8235200, ffff8881d8235600)
The buggy address belongs to the page:
page:ffffea0007608d00 count:1 mapcount:0 mapping:ffff8881da800ac0 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 ffffea000734f608 ffffea0007021a88 ffff8881da800ac0
raw: 0000000000000000 ffff8881d8234000 0000000100000007 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d8235180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d8235200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d8235280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8881d8235300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d8235380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
