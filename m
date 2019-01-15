Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C50C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61782054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbfAOQrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:47:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:44415 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbfAOQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:47:04 -0500
Received: by mail-it1-f200.google.com with SMTP id x82so3183225ita.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:47:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yx3qZU+tlki+++hhOwdgRn46Gw3oKTgUEGHYgwmlHh4=;
        b=I+/B3ljXbqi3KwldqSLu25JPXA3ZezB/ysV+zhKVK/EDHdaOj4iQge6/P5cgRBCppD
         FSf5Lw7jOZxct1nJ5KJ6VtpQ2JOF+oWE2fCJ6YU0HHi+Ut5L0gxsS/+7ouNLKmn6Suk2
         TXFeoqAiBOui8FdJ1g441yUY1KC8VE+TO/8yG7GI+ODLv6/J61X/7lgxa/XnMYK1HNgy
         Y2S7H73Beo76o2iq+kp+VWGiSYRvWd17Gn8TNPI864NO1vIAPQMkxHOi21zwAPUYjY1O
         d+Uydb1v7xEa4hfrezzOV0ofymnPDPQiSC3PT36MvC5URLl3bruepnRbGixDRVuAgpLn
         vWRQ==
X-Gm-Message-State: AJcUukdznt56g6WQTsxKT1iC+wqonkRYfuDfkDpFgTckuXQHxMKHkqIj
        /cm1FbpeBkjmCbKhzJp+9g1PH/7WG278sboHooCTOIWMM8iN
X-Google-Smtp-Source: ALg8bN4DHMQd9AjTKqpfyYfyZcJJUeNa2Bm522MyAX3HBs+gKagEJneyMGlUIqO/X9mHaEzA2NxOKaCxrSxwn2DTBPP/npB9iqga
MIME-Version: 1.0
X-Received: by 2002:a24:4105:: with SMTP id x5mr2996381ita.33.1547570823301;
 Tue, 15 Jan 2019 08:47:03 -0800 (PST)
Date:   Tue, 15 Jan 2019 08:47:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003036f4057f81e98e@google.com>
Subject: KASAN: use-after-free Read in ila_nf_input
From:   syzbot <syzbot+03a25358f4cba0bc4cb6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, keescook@chromium.org, ktkhai@virtuozzo.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        syzkaller-bugs@googlegroups.com, tom@herbertland.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ab8b6f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b03c5892bb940c76
dashboard link: https://syzkaller.appspot.com/bug?extid=03a25358f4cba0bc4cb6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+03a25358f4cba0bc4cb6@syzkaller.appspotmail.com

netlink: 'syz-executor2': attribute type 15 has an invalid length.
IPv6: RTM_NEWROUTE with no NLM_F_CREATE or NLM_F_REPLACE
==================================================================
BUG: KASAN: use-after-free in rht_key_hashfn include/linux/rhashtable.h:143  
[inline]
BUG: KASAN: use-after-free in __rhashtable_lookup  
include/linux/rhashtable.h:492 [inline]
BUG: KASAN: use-after-free in rhashtable_lookup  
include/linux/rhashtable.h:534 [inline]
BUG: KASAN: use-after-free in rhashtable_lookup_fast  
include/linux/rhashtable.h:560 [inline]
BUG: KASAN: use-after-free in ila_lookup_wildcards  
net/ipv6/ila/ila_xlat.c:133 [inline]
BUG: KASAN: use-after-free in ila_xlat_addr net/ipv6/ila/ila_xlat.c:658  
[inline]
BUG: KASAN: use-after-free in ila_nf_input+0xf52/0x1100  
net/ipv6/ila/ila_xlat.c:191
Read of size 4 at addr ffff88808ba80ccc by task ksoftirqd/0/9

CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 4.20.0+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report mm/kasan/report.c:412 [inline]
  kasan_report.cold+0x8c/0x2ba mm/kasan/report.c:396
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
  rht_key_hashfn include/linux/rhashtable.h:143 [inline]
  __rhashtable_lookup include/linux/rhashtable.h:492 [inline]
  rhashtable_lookup include/linux/rhashtable.h:534 [inline]
  rhashtable_lookup_fast include/linux/rhashtable.h:560 [inline]
  ila_lookup_wildcards net/ipv6/ila/ila_xlat.c:133 [inline]
  ila_xlat_addr net/ipv6/ila/ila_xlat.c:658 [inline]
  ila_nf_input+0xf52/0x1100 net/ipv6/ila/ila_xlat.c:191
  nf_hook_entry_hookfn include/linux/netfilter.h:119 [inline]
  nf_hook_slow+0xbf/0x1f0 net/netfilter/core.c:511
  nf_hook include/linux/netfilter.h:244 [inline]
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ipv6_rcv+0x3b9/0x650 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x160/0x210 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x76d/0x1930 net/core/dev.c:6412
  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 7721:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc mm/kasan/kasan.c:553 [inline]
  kasan_kmalloc+0xce/0xf0 mm/kasan/kasan.c:531
  __do_kmalloc_node mm/slab.c:3684 [inline]
  __kmalloc_node+0x51/0x80 mm/slab.c:3691
  kmalloc_node include/linux/slab.h:589 [inline]
  kvmalloc_node+0xbd/0x100 mm/util.c:416
  kvmalloc include/linux/mm.h:577 [inline]
  kvzalloc include/linux/mm.h:585 [inline]
  bucket_table_alloc+0x9f/0x540 lib/rhashtable.c:176
  rhashtable_init+0x525/0xa60 lib/rhashtable.c:1065
  ila_xlat_init_net+0x26f/0x3d0 net/ipv6/ila/ila_xlat.c:623
  ila_init_net+0x16/0x20 net/ipv6/ila/ila_main.c:63
  ops_init+0x109/0x5d0 net/core/net_namespace.c:129
  setup_net+0x326/0x8c0 net/core/net_namespace.c:314
  copy_net_ns+0x2ae/0x4b0 net/core/net_namespace.c:437
  create_new_namespaces+0x4ce/0x930 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x6d7/0xfb0 kernel/fork.c:2544
  __do_sys_unshare kernel/fork.c:2612 [inline]
  __se_sys_unshare kernel/fork.c:2610 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2610
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 14703:
  save_stack+0x45/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  kvfree+0x61/0x70 mm/util.c:445
  bucket_table_free+0xde/0x260 lib/rhashtable.c:108
  rhashtable_free_and_destroy+0x155/0x8f0 lib/rhashtable.c:1163
  ila_xlat_exit_net+0x22b/0x420 net/ipv6/ila/ila_xlat.c:632
  ila_exit_net+0x16/0x20 net/ipv6/ila/ila_main.c:75
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x51d/0xb10 net/core/net_namespace.c:551
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88808ba80cc0
  which belongs to the cache kmalloc-32k of size 32768
The buggy address is located 12 bytes inside of
  32768-byte region [ffff88808ba80cc0, ffff88808ba88cc0)
The buggy address belongs to the page:
page:ffffea00022ea000 count:1 mapcount:0 mapping:ffff88812c3f2380 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00022db008 ffffea000298d008 ffff88812c3f2380
raw: 0000000000000000 ffff88808ba80cc0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808ba80b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88808ba80c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88808ba80c80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                               ^
  ffff88808ba80d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88808ba80d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
