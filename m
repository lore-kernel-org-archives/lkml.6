Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914B1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EDF2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EDF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJ3Xxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:53:53 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54584 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeJ3Xxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:53:53 -0400
Received: by mail-io1-f69.google.com with SMTP id q26-v6so11152813ioi.21
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GExJtGqr/oFOEkynqIDnieJF0TXcG9PXhIv9t+TQQFM=;
        b=hY2VHVGjC79HNrOVQhquOD0nKlJYLaTGkous7uS7500hpmR9pn9AkfvfnpnxYrenV2
         XNalE0Nzr/5tERVw4YfxBVlcsyZkLP26jtIi9iBmiRCvn/jPvJMCQAeJeZyr71fVTpsr
         wCO2Czpo4u2zhf0ukkhj/xo2r5QoK50teVbgXtUy3kv3uo0xpg9ki72YZAgqfR6w+CPL
         9dVSdyRSQ9OZAqc+XTbMGamheE9i3Sk5m9ngzpMz13h0phhZ5cJKMway5GNHNwgzJBy7
         OktvhW059v8M9OJy4hXNYV7RTtwjFST3L8xvzuyO6mGD4XChf+uh1Vj9viQFAAu1tGVg
         4cnw==
X-Gm-Message-State: AGRZ1gK009n8h1g7Lw/AhozoO7qXuXb9fgJrjOx6exakgsLKNdzRJaHl
        YWP9WYTOxM9J+PuohHPmWBpmZdfsiuvuQ9kB6MgilNuPFO8W
X-Google-Smtp-Source: AJdET5cxQ5QnCfFQVYH7uSQFCnyDVLxLy/9quCo5g3G+Gdv9Hgzekkz+grtPoBYI/E4c7nUrVgV9wk6uVzzy7fT0yr8afSjp8i55
MIME-Version: 1.0
X-Received: by 2002:a6b:c786:: with SMTP id x128-v6mr7152712iof.1.1540911603690;
 Tue, 30 Oct 2018 08:00:03 -0700 (PDT)
Date:   Tue, 30 Oct 2018 08:00:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4ba820579737025@google.com>
Subject: KASAN: slab-out-of-bounds Read in _decode_session6 (2)
From:   syzbot <syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d8fd9e106fbc bpf: fix wrong helper enablement in cgroup lo..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=174157cb400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cb981ee01463dea
dashboard link: https://syzkaller.appspot.com/bug?extid=240f9766d6be3d69431e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10828e4d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fdf2eb400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: slab-out-of-bounds in _decode_session6+0x134a/0x1500  
net/ipv6/xfrm6_policy.c:161
Read of size 1 at addr ffff8801ca971707 by task syz-executor081/5431

CPU: 0 PID: 5431 Comm: syz-executor081 Not tainted 4.19.0+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  _decode_session6+0x134a/0x1500 net/ipv6/xfrm6_policy.c:161
  __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
  xfrm_decode_session include/net/xfrm.h:1232 [inline]
  vti6_tnl_xmit+0x3fc/0x1c10 net/ipv6/ip6_vti.c:542
  __netdev_start_xmit include/linux/netdevice.h:4336 [inline]
  netdev_start_xmit include/linux/netdevice.h:4345 [inline]
  xmit_one net/core/dev.c:3252 [inline]
  dev_hard_start_xmit+0x295/0xc90 net/core/dev.c:3268
  __dev_queue_xmit+0x2f71/0x3ad0 net/core/dev.c:3838
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3871
  __bpf_tx_skb net/core/filter.c:2017 [inline]
  __bpf_redirect_common net/core/filter.c:2055 [inline]
  __bpf_redirect+0x5cf/0xb20 net/core/filter.c:2062
  ____bpf_clone_redirect net/core/filter.c:2095 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2067
  bpf_prog_c39d1ba309a769f7+0x800/0x1000

Allocated by task 5431:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
  __kmalloc_reserve.isra.40+0x41/0xe0 net/core/skbuff.c:137
  pskb_expand_head+0x230/0x10f0 net/core/skbuff.c:1460
  skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5071
  __bpf_try_make_writable net/core/filter.c:1638 [inline]
  bpf_try_make_writable net/core/filter.c:1644 [inline]
  bpf_try_make_head_writable net/core/filter.c:1652 [inline]
  ____bpf_clone_redirect net/core/filter.c:2089 [inline]
  bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2067
  bpf_prog_c39d1ba309a769f7+0x800/0x1000

Freed by task 4022:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  load_elf_binary+0x25b4/0x5620 fs/binfmt_elf.c:1118
  search_binary_handler+0x17d/0x570 fs/exec.c:1653
  exec_binprm fs/exec.c:1695 [inline]
  __do_execve_file.isra.33+0x162f/0x2540 fs/exec.c:1819
  do_execveat_common fs/exec.c:1866 [inline]
  do_execve fs/exec.c:1883 [inline]
  __do_sys_execve fs/exec.c:1964 [inline]
  __se_sys_execve fs/exec.c:1959 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801ca971500
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 7 bytes to the right of
  512-byte region [ffff8801ca971500, ffff8801ca971700)
The buggy address belongs to the page:
page:ffffea00072a5c40 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea00072a6088 ffffea00072a7808 ffff8801da800940
raw: 0000000000000000 ffff8801ca971000 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ca971600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801ca971680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801ca971700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff8801ca971780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8801ca971800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
