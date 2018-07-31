Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFADC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EAF208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVEjJBYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EAF208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbeGaOWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:22:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44491 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbeGaOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:22:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so6046168pff.11;
        Tue, 31 Jul 2018 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=czQrc5zAWL2rKaKV69gLCCe/J9cFZmnCXCITC3HUCI8=;
        b=MVEjJBYiyQ/Ec1XsSvLX33h3gBdxsOmbXOxnav6lrNvRrwwFbOvVaH0lYoTZKvyHue
         esWTK5otGOaiiDo68TRYRwZF42bDWSp/qMkXz6HzzZ/K1ZXVefA1f7ewlBews2aFwYl8
         9uHC4x0neDagwZJ/SGg5DmOCCTcpAB66tfyPWSzjWFCbUp8/5JDMYoGwyz8pZuu39QvV
         kWe8c/RbujEaRuMsyw2DTvnvwYkocx8EmBMrMF1oOXb8skVOWn2MtIxrqON0iRJ1EocK
         h+AfIvVi/AEF69YuwtA9ZXfwOOoBLcRwh5r5utOBesm0VBH+r2U7B+CV1YUH1YTSYRZu
         0/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czQrc5zAWL2rKaKV69gLCCe/J9cFZmnCXCITC3HUCI8=;
        b=YuH1hx0uwCxbbRhoXUXgVH0+FiSFM8f95pK7SeXh3FYqvPZ/igHHfPbpx4YZ444BOC
         LBl+ZUPe2WTLniczZ+TNodExbU+L98AID33axCpRPLRlz1ufGHrwOpto29s0Z2qg+D84
         NkP6togVeWrx2RdTzZil8Pr00IwI4pQPDNcfY8MIuEgn1vrZGbP1VUwRS5jOAZwdXACO
         HbdKV4DEV+YMevpd9pE7Aqut2N0WazQLsDfBUHHVCDByjVkz7VjyxwwcYtDkI8uNqjtm
         BNoWmWvpup6JcVvc57oOtATuyjAJV7MNpGXIZRubHQuIFxpv511+G6SdcDIDYRBJCZ6O
         zubg==
X-Gm-Message-State: AOUpUlHt5gr+Q19oy1Ns24JmZtPNrV1pXcRMIUhe58XR8IhNAZ4kgQfl
        zRI4bUtoFnmMPVT7kJ88mOM=
X-Google-Smtp-Source: AAOMgpfEIcNhVMHKbNFhq5vlNNcoxCbiS36qEY3iR55RitM9kmDo1st6dD0Psfq8JICQ9bWMAbX5Rg==
X-Received: by 2002:a62:45d2:: with SMTP id n79-v6mr21911450pfi.137.1533040918135;
        Tue, 31 Jul 2018 05:41:58 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id e7-v6sm29596593pgc.55.2018.07.31.05.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 05:41:57 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
To:     syzbot <syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com>,
        christian.brauner@ubuntu.com, davem@davemloft.net,
        dsahern@gmail.com, fw@strlen.de, jbenc@redhat.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Sabrina Dubroca <sd@queasysnail.net>
References: <0000000000004fe2be05724ac084@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
Date:   Tue, 31 Jul 2018 05:41:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0000000000004fe2be05724ac084@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 05:31 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    61f4b23769f0 netlink: Don't shift with UB on nlk->ngroups
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a9de58400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
> dashboard link: https://syzkaller.appspot.com/bug?extid=41f9c04b50ef70c66947
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com
> 
> TCP: request_sock_TCPv6: Possible SYN flooding on port 20002. Sending cookies.  Check SNMP counters.
> ==================================================================
> BUG: KASAN: use-after-free in rtnetlink_put_metrics+0x621/0x690 net/core/rtnetlink.c:754
> Read of size 4 at addr ffff8801b3cd8b00 by task udevd/2613
> 
> CPU: 0 PID: 2613 Comm: udevd Not tainted 4.18.0-rc6+ #34
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>  rtnetlink_put_metrics+0x621/0x690 net/core/rtnetlink.c:754
>  rt6_fill_node+0x7d9/0x1540 net/ipv6/route.c:4753
>  inet6_rt_notify+0x161/0x2c0 net/ipv6/route.c:4985
>  fib6_del_route net/ipv6/ip6_fib.c:1788 [inline]
>  fib6_del+0xf4d/0x1310 net/ipv6/ip6_fib.c:1815
>  fib6_clean_node+0x3ee/0x5e0 net/ipv6/ip6_fib.c:1976
>  fib6_walk_continue+0x4b1/0x8e0 net/ipv6/ip6_fib.c:1899
>  fib6_walk+0x95/0xf0 net/ipv6/ip6_fib.c:1947
>  fib6_clean_tree+0x1ea/0x360 net/ipv6/ip6_fib.c:2024
>  __fib6_clean_all+0x21c/0x420 net/ipv6/ip6_fib.c:2040
>  fib6_clean_all net/ipv6/ip6_fib.c:2051 [inline]
>  fib6_run_gc+0x182/0x3d0 net/ipv6/ip6_fib.c:2107
>  fib6_gc_timer_cb+0x20/0x30 net/ipv6/ip6_fib.c:2124
>  call_timer_fn+0x242/0x970 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x7a6/0xc70 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:372 [inline]
>  irq_exit+0x1d4/0x210 kernel/softirq.c:412
>  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
>  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
> RIP: 0010:qlink_free mm/kasan/quarantine.c:150 [inline]
> RIP: 0010:qlist_free_all+0xf8/0x160 mm/kasan/quarantine.c:166
> Code: c7 40 10 00 00 00 00 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 57 b8 a4 ff 48 83 3d 67 b4 37 06 00 74 56 48 89 df 57 9d <0f> 1f 44 00 00 eb af ba 00 00 00 80 48 01 c2 72 43 48 b9 00 00 00
> RSP: 0018:ffff8801b54a7b08 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: 0000000000000286 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8801b5498a38 RDI: 0000000000000286
> RBP: ffff8801b54a7b40 R08: ffff8801b5498a38 R09: 0000000000000006
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8801dad85dc0 R14: ffff8801b37ace00 R15: ffffffff87f1b0a0
>  quarantine_reduce+0x163/0x1a0 mm/kasan/quarantine.c:259
>  kasan_kmalloc+0x99/0xe0 mm/kasan/kasan.c:538
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  slab_post_alloc_hook mm/slab.h:444 [inline]
>  slab_alloc mm/slab.c:3392 [inline]
>  kmem_cache_alloc+0x11b/0x760 mm/slab.c:3552
>  getname_flags+0xd0/0x5a0 fs/namei.c:140
>  user_path_at_empty+0x2d/0x50 fs/namei.c:2584
>  do_readlinkat+0x14b/0x400 fs/stat.c:394
>  __do_sys_readlink fs/stat.c:427 [inline]
>  __se_sys_readlink fs/stat.c:424 [inline]
>  __x64_sys_readlink+0x78/0xb0 fs/stat.c:424
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7efd8271b577
> Code: f0 ff ff 77 02 f3 c3 48 8b 15 bd 38 2b 00 f7 d8 64 89 02 83 c8 ff c3 90 90 90 90 90 90 90 90 90 90 90 90 b8 59 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 38 2b 00 31 d2 48 29 c2 64
> RSP: 002b:00007ffe27d23688 EFLAGS: 00000246 ORIG_RAX: 0000000000000059
> RAX: ffffffffffffffda RBX: 00000000021de250 RCX: 00007efd8271b577
> RDX: 0000000000000400 RSI: 00007ffe27d23690 RDI: 00007ffe27d23b70
> RBP: 00007ffe27d243b0 R08: 00007ffe27d243b0 R09: 00007efd8276fdc0
> R10: 7665642f7379732f R11: 0000000000000246 R12: 00007ffe27d23b70
> R13: 0000000000000400 R14: 00000000021de250 R15: 00000000021e3e10
> 
> Allocated by task 8953:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>  kmalloc include/linux/slab.h:513 [inline]
>  kzalloc include/linux/slab.h:707 [inline]
>  fib6_metric_set+0x163/0x2c0 net/ipv6/ip6_fib.c:645
>  fib6_add_rt2node+0xe36/0x27f0 net/ipv6/ip6_fib.c:1000
>  fib6_add+0xaae/0x14d0 net/ipv6/ip6_fib.c:1308
>  __ip6_ins_rt+0x54/0x80 net/ipv6/route.c:1163
>  ip6_route_add+0x6d/0xc0 net/ipv6/route.c:3171
>  addrconf_prefix_route.isra.48+0x51d/0x720 net/ipv6/addrconf.c:2347
>  inet6_addr_modify net/ipv6/addrconf.c:4627 [inline]
>  inet6_rtm_newaddr+0x112e/0x1b50 net/ipv6/addrconf.c:4743
>  rtnetlink_rcv_msg+0x46e/0xc30 net/core/rtnetlink.c:4665
>  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2453
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:4683
>  netlink_unicast_kernel net/netlink/af_netlink.c:1315 [inline]
>  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1341
>  netlink_sendmsg+0xa18/0xfd0 net/netlink/af_netlink.c:1906
>  sock_sendmsg_nosec net/socket.c:642 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:652
>  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2126
>  __sys_sendmsg+0x11d/0x290 net/socket.c:2164
>  __do_sys_sendmsg net/socket.c:2173 [inline]
>  __se_sys_sendmsg net/socket.c:2171 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2171
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 2613:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  fib6_metrics_release+0x77/0x90 net/ipv6/ip6_fib.c:179
>  fib6_drop_pcpu_from net/ipv6/ip6_fib.c:899 [inline]
>  fib6_purge_rt+0x5ec/0x7f0 net/ipv6/ip6_fib.c:934
>  fib6_del_route net/ipv6/ip6_fib.c:1784 [inline]
>  fib6_del+0xc11/0x1310 net/ipv6/ip6_fib.c:1815
>  fib6_clean_node+0x3ee/0x5e0 net/ipv6/ip6_fib.c:1976
>  fib6_walk_continue+0x4b1/0x8e0 net/ipv6/ip6_fib.c:1899
>  fib6_walk+0x95/0xf0 net/ipv6/ip6_fib.c:1947
>  fib6_clean_tree+0x1ea/0x360 net/ipv6/ip6_fib.c:2024
>  __fib6_clean_all+0x21c/0x420 net/ipv6/ip6_fib.c:2040
>  fib6_clean_all net/ipv6/ip6_fib.c:2051 [inline]
>  fib6_run_gc+0x182/0x3d0 net/ipv6/ip6_fib.c:2107
>  fib6_gc_timer_cb+0x20/0x30 net/ipv6/ip6_fib.c:2124
>  call_timer_fn+0x242/0x970 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x7a6/0xc70 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2e8/0xb17 kernel/softirq.c:292
> 
> The buggy address belongs to the object at ffff8801b3cd8b00
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 0 bytes inside of
>  96-byte region [ffff8801b3cd8b00, ffff8801b3cd8b60)
> The buggy address belongs to the page:
> page:ffffea0006cf3600 count:1 mapcount:0 mapping:ffff8801dac004c0 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0006a6f3c8 ffffea0007018608 ffff8801dac004c0
> raw: 0000000000000000 ffff8801b3cd8000 0000000100000020 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801b3cd8a00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801b3cd8a80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>> ffff8801b3cd8b00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                    ^
>  ffff8801b3cd8b80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801b3cd8c00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.

Probably also caused by :


commit df18b50448fab1dff093731dfd0e25e77e1afcd1
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Mon Jul 30 16:23:10 2018 +0200

    net/ipv6: fix metrics leak
