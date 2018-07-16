Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF2B20779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF2B20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeGPIsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:48:15 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:55603 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeGPIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:48:15 -0400
Received: by mail-io0-f199.google.com with SMTP id u23-v6so33496669iol.22
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vu5zN9LjbZ84Yv+2OwE/88SqE8S7z+Y1V8cKe1ZXODQ=;
        b=sTRi7AVdbhz4/Cu6DBfXGSusJ4jkMNAe4JsEgAjvyGblOq6I/voEpi7O3NHJOzRD4A
         ElgXq5mLFIqMNsHapqw47ejkyuLSMa6ShDVu9nN1uqNEkiVOwz37sBtnF0u0mu7ogmYB
         4U9p5qsOATVEyIHXCFIpovn7csT7eoycezuVqe/ggMH7oHuZLL2I/gnDTr9OmdFoeixh
         XeBBxqcCLKGbdq0j/yzrHhSAHJp+6wuS235zaGZNiM+N7rInvLzgJaJoGjXJtsNpSZ7V
         NaWDNtJbt5dGx1LBiLzbOCFmo+5LrAtlsxcN155K5Sbw1hCi+N3xtnxJsLWd1ed2+DeN
         FL6w==
X-Gm-Message-State: AOUpUlGgZ8egyRLj+VExyXw4ajsLjUsDSZ6YuUKhm9s8+35dwNYsT7gX
        UlSfTVAnpOHDnjJCLHZ5olSd/p1+6basj497vTX0S2bipz1m
X-Google-Smtp-Source: AAOMgpeG3oviTxgahXsYGtY6CeB3ZL4+FQtxfqx+UMOB7Zu3cPxBLrPrjO+v2/Vl6J1bdwr0fbs6Gt5Yb3+/oi9vKlAvlN2XhYdc
MIME-Version: 1.0
X-Received: by 2002:a6b:7407:: with SMTP id s7-v6mr6836532iog.78.1531729321904;
 Mon, 16 Jul 2018 01:22:01 -0700 (PDT)
Date:   Mon, 16 Jul 2018 01:22:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fd8cd0571198657@google.com>
Subject: KASAN: use-after-free Read in inet_create (2)
From:   syzbot <syzbot+222be66e5d94f87d8015@syzkaller.appspotmail.com>
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

HEAD commit:    483d835c8189 Add linux-next specific files for 20180713
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c231c2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60e5ac2478928314
dashboard link: https://syzkaller.appspot.com/bug?extid=222be66e5d94f87d8015
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+222be66e5d94f87d8015@syzkaller.appspotmail.com

team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
==================================================================
BUG: KASAN: use-after-free in inet_create+0xfdb/0x1070  
net/ipv4/af_inet.c:339
Read of size 4 at addr ffff8801b09a87c4 by task kworker/u4:1/22

CPU: 1 PID: 22 Comm: kworker/u4:1 Not tainted 4.18.0-rc4-next-20180713+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krdsd rds_connect_worker
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  inet_create+0xfdb/0x1070 net/ipv4/af_inet.c:339
  __sock_create+0x53c/0x940 net/socket.c:1268
  sock_create_kern+0x3b/0x50 net/socket.c:1314
  rds_tcp_conn_path_connect+0x2a3/0x960 net/rds/tcp_connect.c:108
  rds_connect_worker+0x190/0x260 net/rds/threads.c:175
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415

Allocated by task 4480:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
  kmem_cache_zalloc include/linux/slab.h:697 [inline]
  net_alloc net/core/net_namespace.c:383 [inline]
  copy_net_ns+0x15b/0x4d0 net/core/net_namespace.c:423
  create_new_namespaces+0x6ad/0x900 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x723/0xfb0 kernel/fork.c:2433
  __do_sys_unshare kernel/fork.c:2501 [inline]
  __se_sys_unshare kernel/fork.c:2499 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2499
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 22:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
  net_free net/core/net_namespace.c:399 [inline]
  net_drop_ns.part.13+0x129/0x150 net/core/net_namespace.c:406
  net_drop_ns net/core/net_namespace.c:405 [inline]
  cleanup_net+0x6bb/0xb50 net/core/net_namespace.c:541
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415

The buggy address belongs to the object at ffff8801b09a80c0
  which belongs to the cache net_namespace of size 8448
The buggy address is located 1796 bytes inside of
  8448-byte region [ffff8801b09a80c0, ffff8801b09aa1c0)
The buggy address belongs to the page:
page:ffffea0006c26a00 count:1 mapcount:0 mapping:ffff8801d9bdae40 index:0x0  
compound_mapcount: 0
flags: 0x2fffc0000008100(slab|head)
raw: 02fffc0000008100 ffffea0007398808 ffffea0007393408 ffff8801d9bdae40
raw: 0000000000000000 ffff8801b09a80c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b09a8680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b09a8700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8801b09a8780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8801b09a8800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801b09a8880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
