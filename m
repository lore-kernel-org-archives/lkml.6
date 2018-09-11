Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F657C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2812086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2812086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeIKLDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:03:43 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:38567 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeIKLDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:03:42 -0400
Received: by mail-it0-f70.google.com with SMTP id h5-v6so19259itb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 23:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sAW8b3ezB6PFH3rUOIzaUixeTmsl+af4Lql+9fFWcT0=;
        b=CQ5YfncVufcxELpajvUAxGPuGd14hDzisACaTeyHNplDmjZuNN23yDvwHseR4uPkrU
         pKPNkRTdfgNokgW3yjdjKYLyUGfLQOntoA/R+wVfWAb+/VensxuwM3JjPOZHcGaFPK6R
         mZFzY75J2aSpb2udvaQQGPl1FfandpGzrWD07hUvBIEGkF2JsampVp626aQbvmyROIFX
         DGl59LNgnJu60ptsiRMZIpRuKfDaXVMhI8OhqjK6yETjshPewiSYmTahPr+iyWNIPiA0
         J0+UJ5nzq4bjXiBLhvIsuTNtxgCRzjyiSr6SByh4DL+E7O2DVsHXaZbfnJf0tqY/dyTN
         aGfQ==
X-Gm-Message-State: APzg51DIsyQR3P211tXMb245TKIlzUI+/tsG2cFXlYaY9uz2eTuHuxbv
        icPrShxDxkI80cMhUXau/7NNj5lXiZH0D9t2NUQNBincc+K9
X-Google-Smtp-Source: ANB0Vdbw/BOM2jIQL1SuZMRdXYXL3CjaTYOUGXMebaAm3Dy5Sy3P33ii1v+ZndTkD7jOxgC3qym8yjHTJ92oLQHVdOMs13ufP/9G
MIME-Version: 1.0
X-Received: by 2002:a5e:9901:: with SMTP id t1-v6mr20735401ioj.41.1536645962194;
 Mon, 10 Sep 2018 23:06:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 23:06:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8e87005759244ec@google.com>
Subject: INFO: rcu detected stall in pppol2tp_sendmsg
From:   syzbot <syzbot+0925ea3f5745e9005733@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    11da3a7f84f1 Linux 4.19-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10577ada400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=0925ea3f5745e9005733
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0925ea3f5745e9005733@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (1 GPs behind) idle=142/1/0x4000000000000002  
softirq=27118/27119 fqs=5247
rcu: 	 (t=10500 jiffies g=38069 q=255)
NMI backtrace for cpu 0
CPU: 0 PID: 11502 Comm: syz-executor2 Not tainted 4.19.0-rc3+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b3/0x1ed lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:162 [inline]
  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1340
  print_cpu_stall.cold.78+0x2d3/0x524 kernel/rcu/tree.c:1478
  check_cpu_stall kernel/rcu/tree.c:1550 [inline]
  __rcu_pending kernel/rcu/tree.c:3276 [inline]
  rcu_pending kernel/rcu/tree.c:3319 [inline]
  rcu_check_callbacks+0xfd9/0x1990 kernel/rcu/tree.c:2665
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
  </IRQ>
RIP: 0010:security_xfrm_policy_lookup+0x58/0xd0 security/security.c:1675
Code: 3b fe 41 0f b6 c5 49 bc 00 00 00 00 00 fc ff df 89 45 d4 e8 1a f2 3b  
fe 48 8d 7b 18 48 89 f8 48 c1 e8 03 42 80 3c 20 00 75 58 <8b> 55 d4 44 89  
fe 4c 89 f7 48 8b 43 18 e8 36 91 9d 04 31 ff 41 89
RSP: 0018:ffff8801ba216ee0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1317fd6 RBX: ffffffff898bfe98 RCX: ffffc90005017000
RDX: 0000000000040000 RSI: ffffffff8342dea6 RDI: ffffffff898bfeb0
RBP: ffff8801ba216f10 R08: ffff8801d2b54480 R09: 1ffffffff12b43d5
R10: ffffed003b5c4732 R11: ffff8801dae23993 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 00000000000000df
  xfrm_sk_policy_lookup+0x32b/0x640 net/xfrm/xfrm_policy.c:1203
  xfrm_lookup_with_ifid+0x2a1/0x2b80 net/xfrm/xfrm_policy.c:2063
  xfrm_lookup net/xfrm/xfrm_policy.c:2200 [inline]
  xfrm_lookup_route+0x3c/0x1f0 net/xfrm/xfrm_policy.c:2211
  ip6_dst_lookup_flow+0x1c6/0x270 net/ipv6/ip6_output.c:1085
  inet6_csk_route_socket+0x8bd/0x1020 net/ipv6/inet6_connection_sock.c:110
  inet6_csk_xmit+0x118/0x630 net/ipv6/inet6_connection_sock.c:125
  l2tp_xmit_core net/l2tp/l2tp_core.c:1030 [inline]
  l2tp_xmit_skb+0x1465/0x1860 net/l2tp/l2tp_core.c:1132
  pppol2tp_sendmsg+0x4b1/0x6c0 net/l2tp/l2tp_ppp.c:329
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x51d/0x930 net/socket.c:2114
  __sys_sendmmsg+0x246/0x6d0 net/socket.c:2209
  __do_sys_sendmmsg net/socket.c:2238 [inline]
  __se_sys_sendmmsg net/socket.c:2235 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2235
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4572a9
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7ab090fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f7ab09106d4 RCX: 00000000004572a9
RDX: 0800000000000059 RSI: 0000000020005fc0 RDI: 0000000000000006
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4a20 R14: 00000000004c8fe5 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
