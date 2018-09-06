Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF45C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4054820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4054820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIFHuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:50:15 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:54555 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeIFHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:50:14 -0400
Received: by mail-it0-f72.google.com with SMTP id r19-v6so10572896itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 20:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7QcoBJ6rc2zksRQBWTYTR7ODFMrfeMAVRnXCReYZQ94=;
        b=dlEw6d2XPPc0dzJNG2H27Wlw40uQ46M129wo2Ib2EbXjLYqssViCGhE0q9M3JO7kLb
         UaUbMrqzPO74Wdp+LSALVsF09vGjEITqAdptbUUVRN6D+bVy9/805jWhIyE4AdTpM9F+
         ARVWsKru95yVbZ1nCHWnd1AjKhATCEg/Kvr1rfJ11qFf/Bd0/8UTdkUIZnLICrndcgEH
         VmLVsM7OG+5DAl3oTpcajo5KKLR8oomJlAs7EMrbIl/DPEYodr9K3THPLXFswOORCSUG
         s+Z1SZzzX1oHIwoJ+wxES1k1EebQTWG6TN9wdgxaZB2jlySGjDVHVVE9s36X31ERFszv
         /wig==
X-Gm-Message-State: APzg51A4kc50JgirS3xUhvyCEerTBC3T2yEp6/MHdS0tWhwIs1wAaWjv
        vepY2V8nOwH/jdw4sdm5Y7ZAHfCzT1FhIIT5eb38idXfLJxe
X-Google-Smtp-Source: ANB0VdYpIhnTRZ4iJ2zEuFAjivdH69GLlCa4Ut0AJS1rymSsm/TCr4wKSDmagihIezAt9kkMD7tvHpVak3/FXSZmWLZThXhm97fo
MIME-Version: 1.0
X-Received: by 2002:a6b:bf47:: with SMTP id p68-v6mr490014iof.82.1536203822981;
 Wed, 05 Sep 2018 20:17:02 -0700 (PDT)
Date:   Wed, 05 Sep 2018 20:17:02 -0700
In-Reply-To: <0000000000003658b00574dc08cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bef6405752b530b@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6
From:   syzbot <syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        dvyukov@google.com, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164938d1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=acffccec848dc13fe459
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f172e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16399be1400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+acffccec848dc13fe459@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: slab-out-of-bounds in _decode_session6+0x1331/0x14e0  
net/ipv6/xfrm6_policy.c:161
Read of size 1 at addr ffff8801d4a67f07 by task syz-executor092/4673

CPU: 1 PID: 4673 Comm: syz-executor092 Not tainted 4.19.0-rc2+ #223
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  _decode_session6+0x1331/0x14e0 net/ipv6/xfrm6_policy.c:161
  __xfrm_decode_session+0x71/0x140 net/xfrm/xfrm_policy.c:2299
  xfrm_decode_session include/net/xfrm.h:1232 [inline]
  vti6_tnl_xmit+0x3fc/0x1bb1 net/ipv6/ip6_vti.c:542
  __netdev_start_xmit include/linux/netdevice.h:4287 [inline]
  netdev_start_xmit include/linux/netdevice.h:4296 [inline]
  xmit_one net/core/dev.c:3216 [inline]
  dev_hard_start_xmit+0x272/0xc10 net/core/dev.c:3232
  __dev_queue_xmit+0x2ab2/0x3870 net/core/dev.c:3802
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3835
  __bpf_tx_skb net/core/filter.c:2012 [inline]
  __bpf_redirect_common net/core/filter.c:2050 [inline]
  __bpf_redirect+0x5b7/0xae0 net/core/filter.c:2057
  ____bpf_clone_redirect net/core/filter.c:2090 [inline]
  bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2062
  bpf_prog_c39d1ba309a769f7+0xe9e/0x1000

Allocated by task 4673:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc_node mm/slab.c:3682 [inline]
  __kmalloc_node_track_caller+0x47/0x70 mm/slab.c:3696
  __kmalloc_reserve.isra.41+0x3a/0xe0 net/core/skbuff.c:137
  pskb_expand_head+0x230/0x10e0 net/core/skbuff.c:1463
  skb_ensure_writable+0x3dd/0x640 net/core/skbuff.c:5129
  __bpf_try_make_writable net/core/filter.c:1633 [inline]
  bpf_try_make_writable net/core/filter.c:1639 [inline]
  bpf_try_make_head_writable net/core/filter.c:1647 [inline]
  ____bpf_clone_redirect net/core/filter.c:2084 [inline]
  bpf_clone_redirect+0x14a/0x490 net/core/filter.c:2062
  bpf_prog_c39d1ba309a769f7+0xe9e/0x1000

Freed by task 3286:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xd9/0x210 mm/slab.c:3813
  load_elf_binary+0x2569/0x5610 fs/binfmt_elf.c:1118
  search_binary_handler+0x17d/0x570 fs/exec.c:1653
  exec_binprm fs/exec.c:1695 [inline]
  __do_execve_file.isra.35+0x15ff/0x2460 fs/exec.c:1819
  do_execveat_common fs/exec.c:1866 [inline]
  do_execve fs/exec.c:1883 [inline]
  __do_sys_execve fs/exec.c:1964 [inline]
  __se_sys_execve fs/exec.c:1959 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801d4a67d00
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 7 bytes to the right of
  512-byte region [ffff8801d4a67d00, ffff8801d4a67f00)
The buggy address belongs to the page:
page:ffffea00075299c0 count:1 mapcount:0 mapping:ffff8801dac00940 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0007529988 ffffea0007529a48 ffff8801dac00940
raw: 0000000000000000 ffff8801d4a67080 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801d4a67e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8801d4a67e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8801d4a67f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff8801d4a67f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8801d4a68000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

