Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EBEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744EF205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744EF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeLJHuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:50:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47959 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeLJHuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:50:04 -0500
Received: by mail-io1-f72.google.com with SMTP id s25so10551196ioc.14
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vRRazgDxpchBWb9ZsrNpbuUqM/RRkDSg42+4V/dYF8w=;
        b=BY4RYlAkS+64G4oyIhc3B5PUSBxUvM8GUo1y7RUVNHYet12CbtlcRjslBbStQTEII8
         E3zXNhWvRY+kirTpRhGEbJZ+Z9tddlUQylBDCOpUxPBNtoN9tKUQvr7HNE/b4JMqKoa1
         f8BLyoKqCqSukv4lhy3C8kvsRRQ+1B16nalgLmC+Wvh5dW1pZPyNgIWTUySzMo57ewBX
         fegSjDFNnNnkWAAKp3HFeJ7zlTWErVqLKPg9Fe7W/38e5nwPIiRJYb++NTCnlCSgtFn6
         5sSBKA97Cc11qjUIkcQ1UyxHnl6Pr0TfPzoPoMVJ0xkN+23gzOx096HxQKF1wAE7xatk
         /MZg==
X-Gm-Message-State: AA+aEWY6FFjhHuY2O1X8K0t7Z5gVGRlL3uZR8mDJFpMvsi2lC34BIJ2a
        fZ37LINoUT00OG6Ha6z0/F4fgkehb82NLvWSW0d4Xzkr8W+d
X-Google-Smtp-Source: AFSGD/X1y3MVxvughMnNbHxrDhNwo4FCaFMj/U235X2GorDGZlS2XZ2ZW0SRrgxnOV3VT7CB2ucFTZbQem+6jpKYxMsQi/5Xj3OH
MIME-Version: 1.0
X-Received: by 2002:a5e:8913:: with SMTP id k19mr8648271ioj.7.1544428203668;
 Sun, 09 Dec 2018 23:50:03 -0800 (PST)
Date:   Sun, 09 Dec 2018 23:50:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075fe86057ca6367e@google.com>
Subject: INFO: rcu detected stall in xfrm_hash_rebuild
From:   syzbot <syzbot+592df0494801b6648ec6@syzkaller.appspotmail.com>
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

HEAD commit:    74c4a24df7ca Add linux-next specific files for 20181207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17dbb3d5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e9413388bf37bed
dashboard link: https://syzkaller.appspot.com/bug?extid=592df0494801b6648ec6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+592df0494801b6648ec6@syzkaller.appspotmail.com

device bridge_slave_1 entered promiscuous mode
IPv6: ADDRCONF(NETDEV_UP): veth0_to_bridge: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1_to_bridge: link is not ready
bond0: Enslaving bond_slave_0 as an active interface with an up link
bond0: Enslaving bond_slave_1 as an active interface with an up link
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=3e2/1/0x4000000000000002  
softirq=136882/136885 fqs=5250
rcu: 	 (t=10501 jiffies g=189801 q=2008)
NMI backtrace for cpu 1
CPU: 1 PID: 6200 Comm: kworker/1:2 Not tainted 4.20.0-rc5-next-20181207+  
#163
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events xfrm_hash_rebuild
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1211
  print_cpu_stall.cold.70+0x218/0x40a kernel/rcu/tree.c:1348
  check_cpu_stall kernel/rcu/tree.c:1422 [inline]
  rcu_pending kernel/rcu/tree.c:3018 [inline]
  rcu_check_callbacks+0xf3b/0x13f0 kernel/rcu/tree.c:2521
  update_process_times+0x2d/0x70 kernel/time/timer.c:1635
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:161
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:804
  </IRQ>
RIP: 0010:__read_once_size include/linux/compiler.h:182 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:69 [inline]
RIP: 0010:write_comp_data+0x22/0x70 kernel/kcov.c:122
Code: 90 90 90 90 90 90 90 90 55 48 89 e5 65 4c 8b 04 25 40 ee 01 00 65 8b  
05 7c f6 81 7e a9 00 01 1f 00 75 51 41 8b 80 d8 12 00 00 <83> f8 03 75 45  
49 8b 80 e0 12 00 00 45 8b 80 dc 12 00 00 4c 8b 08
RSP: 0018:ffff8881872f7320 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff86d1d8db
RDX: 0000000000000003 RSI: 000000000000000e RDI: 0000000000000005
RBP: ffff8881872f7320 R08: ffff8881872ea1c0 R09: 0000000000000008
R10: 0000000000000005 R11: ffff8881872ea1c0 R12: dffffc0000000000
R13: ffff8881b628ca14 R14: ffff8881b4050114 R15: 0000000000000000
  __sanitizer_cov_trace_const_cmp4+0x16/0x20 kernel/kcov.c:188
  selector_cmp net/xfrm/xfrm_policy.c:1390 [inline]
  xfrm_policy_insert_list+0x62b/0x1020 net/xfrm/xfrm_policy.c:1534
  xfrm_policy_inexact_insert+0x166/0xee0 net/xfrm/xfrm_policy.c:1195
  xfrm_hash_rebuild+0xfba/0x1380 net/xfrm/xfrm_policy.c:1317
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
