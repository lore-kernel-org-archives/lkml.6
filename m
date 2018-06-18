Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F75C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FD82086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA+XgaYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FD82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934579AbeFRMOz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:14:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33369 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933535AbeFRMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:14:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so8082984pfi.0;
        Mon, 18 Jun 2018 05:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4i9yBji9WpOKYDjjBBLZfNfvwqUX8zt174GBesitNPw=;
        b=TA+XgaYRev9lu3OVzcOXHOG/iKXj93fCd9nCNOKT5pVQi2B3GjeMTFD7Q/X5mtZOJS
         W+5QsnVe3MUjeXwESpJVtXzooelxE1I/lOaKy2thOZGKCVyqtfN8NfVImjKKBFYPB3NL
         ij4MUTCCC+uHyDWX9pdtz8ln6Kl1ci5dBrb75bVMBfY7MrjmTUmrVfA8axAMDd24Il+q
         P+txXG5NFB2M86OAdn4UIxzOx5Sa5lFWSSd5eef9/b4OKfAO3Vgu+Ip5O8J1iQGYWG/V
         IIiFNQSxSTJaBSJ1kYcwQIy532iCpN7dEHPrb7CSuXf9tc6H9S0WOYVXCaP4HmNBkImg
         OsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4i9yBji9WpOKYDjjBBLZfNfvwqUX8zt174GBesitNPw=;
        b=K+qEGM7wNzynqkspPHaa2aMjaNm2RAWJ1O8ppmPeE4oQXh6YrewHDiL1TNO3nI/29Z
         x8yue77a1CjZGODsgq7LxJ9ttlS9J6ud+7kbNYHu5BOiyRZDazPDl712yIBeMtti+FO8
         bdDINOIWqwe+gvrzcxCRrAgIWun4XDo2k8U9Qjw7mGSEBugOsno1CVpQYg5yMA13YPho
         3kjaIroZvzYRLIR/qN7hc4/8ksNQ6Konn7Fv3nFsIpfG60qHpWh3aXtEl8IVE9Th34N7
         hqr5XUP4ph+cNyypukuUK0+75QSjllx2bGBmUqOJRm9VxuWzVgM5yggN0kkJWjW+TM6M
         r37w==
X-Gm-Message-State: APt69E2JWOPNjZbwA6zdaDy5Zt3/XmqsnlRPG1K8pFjzIXr44JJ2iXLN
        CPP5Po8HVyqxZox4WUb3ErvONrMJ
X-Google-Smtp-Source: ADUXVKJdsISSnGrAaI0c7/mh0BN7bY150UqKukx74gjqz1/7U8A3QhSzjGHlddnaD3nrXACiDRMwjg==
X-Received: by 2002:a62:1411:: with SMTP id 17-v6mr13318671pfu.3.1529324090744;
        Mon, 18 Jun 2018 05:14:50 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id z74-v6sm29229191pff.54.2018.06.18.05.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 05:14:50 -0700 (PDT)
Subject: Re: KASAN: use-after-free Read in fib6_table_lookup
To:     syzbot <syzbot+9e6d75e3edef427ee888@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, David Ahern <dsahern@gmail.com>
References: <00000000000031e74b056ee45c71@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7cbcadba-a662-e26f-8523-9d5cabb05b3f@gmail.com>
Date:   Mon, 18 Jun 2018 05:14:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <00000000000031e74b056ee45c71@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/17/2018 11:06 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16725130400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=9e6d75e3edef427ee888
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9e6d75e3edef427ee888@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:188 [inline]
> BUG: KASAN: use-after-free in find_rr_leaf net/ipv6/route.c:705 [inline]
> BUG: KASAN: use-after-free in rt6_select net/ipv6/route.c:761 [inline]
> BUG: KASAN: use-after-free in fib6_table_lookup+0x12b7/0x14d0 net/ipv6/route.c:1823
> Read of size 8 at addr ffff8801b5df2588 by task udevd/1407
> 
> overlayfs: unrecognized mount option "Sl�tI��p�5�Wӌ���c��&�e"�M��q�W����u�r'�v�-brE1n��U(��K�g�==;GZ�� ���<��2    N��𽸩��������l�8_��'�%]�]X�7���aNvD�cA��_�(�"��w��Q��++Q%5�����/��>*4Ϻ��k�{�)<��^rΎ�B��b̆��(�ӷ�ӌ���lå�
> �b��������b�@iO�A�s��N�    � �91�¢��m�Gc����j��\�2G-k��'��UI�\8��}0��.�Gh�P�w�����U�^9�\���Sݐ�ʊ��n��a]��T�E�����gaj=Zڒ�_kP��l!�Þ���r��s��.�9��\�D]��b�y$���mQ�����ڨҙM�q��~vX'��6�ň$5��a+�.}�Uuc9݇o.׃�.S܉I��7�5�e�D8��k��E�M#������m�����Vy����7=jV����:�k[(>M
> #�b���Z秺]k/^�����৴��;�v����`G6�m>���'e0��q
> �s|�wJ�'rA����M�$���r0� u�UU~|��}>P{1flt��i�1+A�    �%۪(7˧Ȯ�?ܟ�����)_�����[�w������9W�
> �،���&B�M�m�2�b֊ɹ�S@�q�
> ��4j�h�%��T�'$'�!�ٌt�4C3�g�nypBŔ���o�B�q�o�'􎪑�}��!�Tp9d˨���c��U`}_EҨ��\�I�X��q^�7-[��v[�-�_G�g)�?#~��h
> CPU: 0 PID: 1407 Comm: udevd Not tainted 4.17.0+ #39
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  __read_once_size include/linux/compiler.h:188 [inline]
>  find_rr_leaf net/ipv6/route.c:705 [inline]
>  rt6_select net/ipv6/route.c:761 [inline]
>  fib6_table_lookup+0x12b7/0x14d0 net/ipv6/route.c:1823
>  ip6_pol_route+0x1c2/0x1020 net/ipv6/route.c:1856
>  ip6_pol_route_output+0x54/0x70 net/ipv6/route.c:2082
>  fib6_rule_lookup+0x211/0x6d0 net/ipv6/fib6_rules.c:122
>  ip6_route_output_flags+0x2c5/0x350 net/ipv6/route.c:2110
>  ip6_route_output include/net/ip6_route.h:82 [inline]
>  icmpv6_xrlim_allow net/ipv6/icmp.c:211 [inline]
>  icmp6_send+0x147c/0x2da0 net/ipv6/icmp.c:535
>  icmpv6_send+0x17a/0x300 net/ipv6/ip6_icmp.c:43
>  ip6_link_failure+0xa5/0x790 net/ipv6/route.c:2244
>  dst_link_failure include/net/dst.h:427 [inline]
>  ndisc_error_report+0xd1/0x1c0 net/ipv6/ndisc.c:695
>  neigh_invalidate+0x246/0x550 net/core/neighbour.c:892
>  neigh_timer_handler+0xaf9/0xde0 net/core/neighbour.c:978
>  call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
>  expire_timers kernel/time/timer.c:1363 [inline]
>  __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
>  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
>  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:284
>  invoke_softirq kernel/softirq.c:364 [inline]
>  irq_exit+0x1d1/0x200 kernel/softirq.c:404
>  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
>  smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
>  </IRQ>
> RIP: 0010:strlen+0x5e/0xa0 lib/string.c:482
> Code: 24 00 74 3b 48 bb 00 00 00 00 00 fc ff df 4c 89 e0 48 83 c0 01 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 0f b6 14 1a 38 ca 7f 04 <84> d2 75 23 80 38 00 75 de 48 83 c4 08 4c 29 e0 5b 41 5c 5d c3 48
> RSP: 0018:ffff8801af117850 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: ffff880197f53bd0 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81c5b06c RDI: ffff880197f53bc0
> RBP: ffff8801af117868 R08: ffff88019a976540 R09: 0000000000000000
> R10: ffff88019a976540 R11: 0000000000000000 R12: ffff880197f53bc0
> R13: ffff880197f53bc0 R14: ffffffff899e4e90 R15: ffff8801d91c6a00
>  strlen include/linux/string.h:267 [inline]
>  getname_kernel+0x24/0x370 fs/namei.c:218
>  open_exec+0x17/0x70 fs/exec.c:882
>  load_elf_binary+0x968/0x5610 fs/binfmt_elf.c:780
>  search_binary_handler+0x17d/0x570 fs/exec.c:1653
>  exec_binprm fs/exec.c:1695 [inline]
>  __do_execve_file.isra.35+0x16fe/0x2710 fs/exec.c:1819
>  do_execveat_common fs/exec.c:1866 [inline]
>  do_execve fs/exec.c:1883 [inline]
>  __do_sys_execve fs/exec.c:1964 [inline]
>  __se_sys_execve fs/exec.c:1959 [inline]
>  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f1576a46207
> Code: 77 19 f4 48 89 d7 44 89 c0 0f 05 48 3d 00 f0 ff ff 76 e0 f7 d8 64 41 89 01 eb d8 f7 d8 64 41 89 01 eb df b8 3b 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 02 f3 c3 48 8b 15 00 8c 2d 00 f7 d8 64 89 02
> RSP: 002b:00007ffff2784568 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
> RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f1576a46207
> RDX: 0000000001215b10 RSI: 00007ffff2784660 RDI: 00007ffff2785670
> RBP: 0000000000625500 R08: 000000000000589c R09: 000000000000589c
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001215b10
> R13: 0000000000000007 R14: 0000000001204250 R15: 0000000000000005
> 
> Allocated by task 12188:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
>  kmalloc include/linux/slab.h:513 [inline]
>  kzalloc include/linux/slab.h:706 [inline]
>  fib6_info_alloc+0xbb/0x280 net/ipv6/ip6_fib.c:152
>  ip6_route_info_create+0x782/0x2b50 net/ipv6/route.c:3013
>  ip6_route_add+0x23/0xb0 net/ipv6/route.c:3154
>  ipv6_route_ioctl+0x5a5/0x760 net/ipv6/route.c:3660
>  inet6_ioctl+0x100/0x1f0 net/ipv6/af_inet6.c:546
>  sock_do_ioctl+0xe4/0x3e0 net/socket.c:973
>  sock_ioctl+0x30d/0x680 net/socket.c:1097
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 1402:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  fib6_info_destroy+0x29b/0x350 net/ipv6/ip6_fib.c:207
>  fib6_info_release include/net/ip6_fib.h:286 [inline]
>  __ip6_del_rt_siblings net/ipv6/route.c:3235 [inline]
>  ip6_route_del+0x11c4/0x13b0 net/ipv6/route.c:3316
>  ipv6_route_ioctl+0x616/0x760 net/ipv6/route.c:3663
>  inet6_ioctl+0x100/0x1f0 net/ipv6/af_inet6.c:546
>  sock_do_ioctl+0xe4/0x3e0 net/socket.c:973
>  sock_ioctl+0x30d/0x680 net/socket.c:1097
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16f0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801b5df2580
>  which belongs to the cache kmalloc-256 of size 256
> The buggy address is located 8 bytes inside of
>  256-byte region [ffff8801b5df2580, ffff8801b5df2680)
> The buggy address belongs to the page:
> page:ffffea0006d77c80 count:1 mapcount:0 mapping:ffff8801da8007c0 index:0xffff8801b5df2e40
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea0006c5cc48 ffffea0007363308 ffff8801da8007c0
> raw: ffff8801b5df2e40 ffff8801b5df2080 0000000100000006 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801b5df2480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801b5df2500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>> ffff8801b5df2580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                       ^
>  ffff8801b5df2600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801b5df2680: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
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


I will test the following fix, and sent it formally.

Fixes: a64efe142f5e ("net/ipv6: introduce fib6_info struct and helpers")

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 5cba71d2dc44b9ea2366725ff68c9f668f639345..71b9043aa0e7995c7e61f17b4493acd99410d1bc 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -170,6 +170,7 @@ struct fib6_info {
                                        unused:3;
 
        struct fib6_nh                  fib6_nh;
+       struct rcu_head                 rcu;
 };
 
 struct rt6_info {
@@ -273,7 +274,7 @@ static inline void ip6_rt_put(struct rt6_info *rt)
 }
 
 struct fib6_info *fib6_info_alloc(gfp_t gfp_flags);
-void fib6_info_destroy(struct fib6_info *f6i);
+void fib6_info_destroy_rcu(struct rcu_head *head);
 
 static inline void fib6_info_hold(struct fib6_info *f6i)
 {
@@ -283,7 +284,7 @@ static inline void fib6_info_hold(struct fib6_info *f6i)
 static inline void fib6_info_release(struct fib6_info *f6i)
 {
        if (f6i && atomic_dec_and_test(&f6i->fib6_ref))
-               fib6_info_destroy(f6i);
+               call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
 }
 
 enum fib6_walk_state {
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 39d1d487eca25faceacbc3619fc6c4c38088d62a..1fb2f3118d60c73433e09f3a71abdbf9a8d92227 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -167,8 +167,9 @@ struct fib6_info *fib6_info_alloc(gfp_t gfp_flags)
        return f6i;
 }
 
-void fib6_info_destroy(struct fib6_info *f6i)
+void fib6_info_destroy_rcu(struct rcu_head *head)
 {
+       struct fib6_info *f6i = container_of(head, struct fib6_info, rcu);
        struct rt6_exception_bucket *bucket;
        struct dst_metrics *m;
 
@@ -206,7 +207,7 @@ void fib6_info_destroy(struct fib6_info *f6i)
 
        kfree(f6i);
 }
-EXPORT_SYMBOL_GPL(fib6_info_destroy);
+EXPORT_SYMBOL_GPL(fib6_info_destroy_rcu);
 
 static struct fib6_node *node_alloc(struct net *net)
 {


