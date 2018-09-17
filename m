Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51770ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25932088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25932088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeIRCwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:52:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33847 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeIRCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:52:11 -0400
Received: by mail-io1-f69.google.com with SMTP id z20-v6so20094130iol.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SB6W0m4L1mbs21g7dSQIWEQhZsTDXuSucqNFRYyu7jc=;
        b=RyicSyfVcIvLxU2NPVHxaGXuezpv3rMzyJ3RP2dy4wsWQLUOyJA+mBEK6KKsSYT98a
         ou/8ME26R6ZfuxcU9PawBeVQ2ysXDXUo0/P2Y/bVy1ai6/ZIZ3pvUaMXl9xEXOR5GelB
         b2m8k9eTS8KKp+vbrmQ78SKXsol3qtglkQxzG0BA8ht+rPb7fnR2CREh/E0IvYDZAJTq
         w13wBErqC9+Z5haAtoJJ+OYl+s/gwCYiYW05u2delLJz5uAiK2qHnZQyu+5SSjP8oSRR
         VOssXJwos4aI+d2jssAkoF+KEKyqtXIAxwmCjEaSteD9mklY+cKbuNNp4UhEwgruhj0e
         4E0g==
X-Gm-Message-State: APzg51CKT+B8asxKddMo3DFqJQZUyNAQpqzAqs9RaqZ4E2lFwREDWTc1
        J7RXAxXgw39DdQ1Etgu0ujqk4u/nqGvhlC42BNvt1o2mUfN9
X-Google-Smtp-Source: ANB0Vda6Li3R5AO1vgMOsY/rNQirZkgnyoFe0PmJ7PLBeuQCYyVDR784+YQRNxFDbDaEjUTEaxJDA8AmrV+gkYFGXpq6gYMHXTcY
MIME-Version: 1.0
X-Received: by 2002:a6b:c305:: with SMTP id t5-v6mr20875886iof.115.1537219383878;
 Mon, 17 Sep 2018 14:23:03 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:23:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005175bf057617c71d@google.com>
Subject: KASAN: slab-out-of-bounds Read in ip6_tnl_parse_tlv_enc_lim
From:   syzbot <syzbot+68dce7caebd8543121de@syzkaller.appspotmail.com>
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

HEAD commit:    3a5af36b6d0e Merge tag '4.19-rc3-smb3-cifs' of git://git.s..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c727be400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c4a80625153107e
dashboard link: https://syzkaller.appspot.com/bug?extid=68dce7caebd8543121de
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1068a44e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146386c6400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+68dce7caebd8543121de@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: slab-out-of-bounds in ip6_tnl_parse_tlv_enc_lim+0x5df/0x660  
net/ipv6/ip6_tunnel.c:417
Read of size 1 at addr ffff8801d21187c7 by task syz-executor281/5345

CPU: 1 PID: 5345 Comm: syz-executor281 Not tainted 4.19.0-rc3+ #238
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  ip6_tnl_parse_tlv_enc_lim+0x5df/0x660 net/ipv6/ip6_tunnel.c:417
  ip6ip6_tnl_xmit net/ipv6/ip6_tunnel.c:1339 [inline]
  ip6_tnl_start_xmit+0x3e2/0x2370 net/ipv6/ip6_tunnel.c:1403
  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
  xmit_one net/core/dev.c:3216 [inline]
  dev_hard_start_xmit+0x27f/0xc70 net/core/dev.c:3232
  __dev_queue_xmit+0x2f3b/0x3980 net/core/dev.c:3802
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3835
  __bpf_tx_skb net/core/filter.c:2012 [inline]
  __bpf_redirect_common net/core/filter.c:2050 [inline]
  __bpf_redirect+0x5cf/0xb20 net/core/filter.c:2057
  ____bpf_clone_redirect net/core/filter.c:2090 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
  bpf_prog_759a992c578a3894+0x741/0x1000

Allocated by task 5345:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
  __kmalloc_reserve.isra.39+0x41/0xe0 net/core/skbuff.c:137
  pskb_expand_head+0x230/0x10f0 net/core/skbuff.c:1460
  skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5126
  __bpf_try_make_writable net/core/filter.c:1633 [inline]
  bpf_try_make_writable net/core/filter.c:1639 [inline]
  bpf_try_make_head_writable net/core/filter.c:1647 [inline]
  ____bpf_clone_redirect net/core/filter.c:2084 [inline]
  bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2062
  bpf_prog_759a992c578a3894+0x741/0x1000

Freed by task 3895:
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

The buggy address belongs to the object at ffff8801d21185c0
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 7 bytes to the right of
  512-byte region [ffff8801d21185c0, ffff8801d21187c0)
The buggy address belongs to the page:
page:ffffea0007484600 count:1 mapcount:0 mapping:ffff8801da800940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007484008 ffffea0007487e88 ffff8801da800940
raw: 0000000000000000 ffff8801d21180c0 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d2118680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801d2118700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801d2118780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                            ^
  ffff8801d2118800: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff8801d2118880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
