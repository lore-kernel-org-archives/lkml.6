Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DF5208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSkt/Z0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DF5208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeGaNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:30:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41722 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbeGaNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:30:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so5980131pfn.8;
        Tue, 31 Jul 2018 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WnSBNI1txwa/pyHFMeV90WJISb5IxJOu9MsD8F1kuPo=;
        b=VSkt/Z0mPpAc1e2Y62lCC0usrLRqXbPklESSTDfu6xhf47lOOA1TiM1Jq5bI9yak0f
         x388b9iAjVRnrkNKlTI3sDA6C1UgEyVVw4Sq+O/BU4vjqwgaJExmcVbnytDQRRKiCpRR
         aHcEIZCiaQoi9Tvuar6O47626sCs1UJSqtU8iPwchwHIdi4LHFj+PcUXhtGXUN3B4ozk
         JimKDepRUZ+4nc1D1Gm2s7+9/fyLQgiVyc9YfbYp5SqIO8Y0QjYLPnbzAovk4e46/aP+
         wPwxZCRyk1gOrJSj6TIdPP76BuxtVzfITc//7j+FNk0AT4hiWofq/sUc7RzyWkz0QOOy
         iXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WnSBNI1txwa/pyHFMeV90WJISb5IxJOu9MsD8F1kuPo=;
        b=bPDQ3o/UU0lIf99QHQVvkEXSmprLqv0EDOKhWD6q3sdNBvcEw3bnzbFzzgrR1/c5jb
         xh129doMvZ79Mig+kZAVWbSvjk5jGJLgCAtPcY/14uQ/OJVQtuh8NEXs9AwMB6iw5uxm
         Bi7m3uNVwOsHNwfb1YjLIjOBm/BDSUj2kJQosGNSN6Su+YR1We2cj2HOwDL6u1555/2w
         9bZbg7P3KcdXtsKzw0UqT591alplIRRlU87Abu3bITr94vtn6hmMweNlGDAMsublFvLS
         UdtQX4Wm436CcLj0kbOLd8zSd3n6Sp9mP+EgEcVTAnbSZEBzop6qZZtBhMnX+zu4KPzd
         3Z/A==
X-Gm-Message-State: AOUpUlGzKlrdmVREZWoGBdtDMdLowc28fhOmBBFrJFzwDc1DF2hs596t
        CEqzcOw7jyavgQOkpWqEIMU=
X-Google-Smtp-Source: AAOMgpd/De/DRroBOokxTy/LckR49PHtF9iAXES1ZjG3NTU9KC7xrAvY/emEQQ6IOlh6TZH5KdBaTA==
X-Received: by 2002:a63:4951:: with SMTP id y17-v6mr20422038pgk.32.1533037842481;
        Tue, 31 Jul 2018 04:50:42 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id a77-v6sm26150504pfj.38.2018.07.31.04.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:50:41 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in refcount_sub_and_test
To:     syzbot <syzbot+8c17db54fd0c0a2ee849@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Sabrina Dubroca <sd@queasysnail.net>
References: <000000000000c5132b0572474587@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <35e26006-8334-a4c7-840c-66be89354b81@gmail.com>
Date:   Tue, 31 Jul 2018 04:50:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000c5132b0572474587@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 01:22 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    61f4b23769f0 netlink: Don't shift with UB on nlk->ngroups
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ed5cf0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
> dashboard link: https://syzkaller.appspot.com/bug?extid=8c17db54fd0c0a2ee849
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8c17db54fd0c0a2ee849@syzkaller.appspotmail.com
> 
> device lo left promiscuous mode
> ==================================================================
> BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
> BUG: KASAN: use-after-free in refcount_sub_and_test+0x9a/0x350 lib/refcount.c:179
> Read of size 4 at addr ffff8801d96d2844 by task syz-executor1/4479
> 
> CPU: 0 PID: 4479 Comm: syz-executor1 Not tainted 4.18.0-rc6+ #34
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
>  kasan_check_read+0x11/0x20 mm/kasan/kasan.c:272
>  atomic_read include/asm-generic/atomic-instrumented.h:21 [inline]
>  refcount_sub_and_test+0x9a/0x350 lib/refcount.c:179
>  refcount_dec_and_test+0x1a/0x20 lib/refcount.c:212
>  fib6_metrics_release+0x4f/0x90 net/ipv6/ip6_fib.c:178
>  fib6_drop_pcpu_from net/ipv6/ip6_fib.c:899 [inline]
>  fib6_purge_rt+0x5ec/0x7f0 net/ipv6/ip6_fib.c:934
>  fib6_del_route net/ipv6/ip6_fib.c:1784 [inline]
>  fib6_del+0xc11/0x1310 net/ipv6/ip6_fib.c:1815
>  fib6_clean_node+0x3ee/0x5e0 net/ipv6/ip6_fib.c:1976
>  fib6_walk_continue+0x4b1/0x8e0 net/ipv6/ip6_fib.c:1899
>  fib6_walk+0x95/0xf0 net/ipv6/ip6_fib.c:1947
>  fib6_clean_tree+0x1ea/0x360 net/ipv6/ip6_fib.c:2024
>  __fib6_clean_all+0x21c/0x420 net/ipv6/ip6_fib.c:2040
>  fib6_clean_all+0x27/0x30 net/ipv6/ip6_fib.c:2051
>  rt6_sync_down_dev net/ipv6/route.c:4083 [inline]
>  rt6_disable_ip+0x111/0x7e0 net/ipv6/route.c:4088
>  addrconf_ifdown+0x16f/0x1670 net/ipv6/addrconf.c:3650
>  addrconf_notify+0x6e9/0x27f0 net/ipv6/addrconf.c:3575
>  notifier_call_chain+0x180/0x390 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1735
>  call_netdevice_notifiers net/core/dev.c:1753 [inline]
>  dev_close_many+0x447/0x8d0 net/core/dev.c:1505
>  rollback_registered_many+0x52b/0xef0 net/core/dev.c:7452
>  rollback_registered+0x1e9/0x420 net/core/dev.c:7517
>  unregister_netdevice_queue+0x32f/0x660 net/core/dev.c:8561
>  unregister_netdevice include/linux/netdevice.h:2548 [inline]
>  __tun_detach+0x11d1/0x15e0 drivers/net/tun.c:727
>  tun_detach drivers/net/tun.c:744 [inline]
>  tun_chr_close+0xe3/0x180 drivers/net/tun.c:3271
>  __fput+0x355/0x8b0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1b08/0x2750 kernel/exit.c:865
>  do_group_exit+0x177/0x440 kernel/exit.c:968
>  __do_sys_exit_group kernel/exit.c:979 [inline]
>  __se_sys_exit_group kernel/exit.c:977 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x456a09
> Code: Bad RIP value.
> RSP: 002b:00007fffa8ff4908 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000456a09
> RDX: 00000000004104e0 RSI: 0000000000a44bd0 RDI: 0000000000000045
> RBP: 00000000004c1904 R08: 000000000000000b R09: 0000000000000000
> R10: 0000000001445940 R11: 0000000000000246 R12: 0000000001446940
> R13: 0000000000000000 R14: 000000000000057e R15: badc0ffeebadface
> 
> Allocated by task 28651:
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
> Freed by task 4479:
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
>  fib6_clean_all+0x27/0x30 net/ipv6/ip6_fib.c:2051
>  rt6_sync_down_dev net/ipv6/route.c:4083 [inline]
>  rt6_disable_ip+0x111/0x7e0 net/ipv6/route.c:4088
>  addrconf_ifdown+0x16f/0x1670 net/ipv6/addrconf.c:3650
>  addrconf_notify+0x6e9/0x27f0 net/ipv6/addrconf.c:3575
>  notifier_call_chain+0x180/0x390 kernel/notifier.c:93
>  __raw_notifier_call_chain kernel/notifier.c:394 [inline]
>  raw_notifier_call_chain+0x2d/0x40 kernel/notifier.c:401
>  call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1735
>  call_netdevice_notifiers net/core/dev.c:1753 [inline]
>  dev_close_many+0x447/0x8d0 net/core/dev.c:1505
>  rollback_registered_many+0x52b/0xef0 net/core/dev.c:7452
>  rollback_registered+0x1e9/0x420 net/core/dev.c:7517
>  unregister_netdevice_queue+0x32f/0x660 net/core/dev.c:8561
>  unregister_netdevice include/linux/netdevice.h:2548 [inline]
>  __tun_detach+0x11d1/0x15e0 drivers/net/tun.c:727
>  tun_detach drivers/net/tun.c:744 [inline]
>  tun_chr_close+0xe3/0x180 drivers/net/tun.c:3271
>  __fput+0x355/0x8b0 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1b08/0x2750 kernel/exit.c:865
>  do_group_exit+0x177/0x440 kernel/exit.c:968
>  __do_sys_exit_group kernel/exit.c:979 [inline]
>  __se_sys_exit_group kernel/exit.c:977 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801d96d2800
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 68 bytes inside of
>  96-byte region [ffff8801d96d2800, ffff8801d96d2860)
> The buggy address belongs to the page:
> page:ffffea000765b480 count:1 mapcount:0 mapping:ffff8801dac004c0 index:0xffff8801d96d2700
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0006c46348 ffffea0006d0d288 ffff8801dac004c0
> raw: ffff8801d96d2700 ffff8801d96d2000 0000000100000003 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801d96d2700: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801d96d2780: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>> ffff8801d96d2800: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                            ^
>  ffff8801d96d2880: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>  ffff8801d96d2900: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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

This might be caused by 

commit df18b50448fab1dff093731dfd0e25e77e1afcd1
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Mon Jul 30 16:23:10 2018 +0200

    net/ipv6: fix metrics leak


