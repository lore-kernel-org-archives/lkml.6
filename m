Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3696218DA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfBFQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:47:07 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:56644 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbfBFQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:47:05 -0500
Received: by mail-it1-f197.google.com with SMTP id 135so5661726itb.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 08:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ApGPaiYnKZVQ39Um4yazSLv4GHwsIjTc8bTvFWr5lFo=;
        b=fVCuHAY4n8CDIkrMqRGgYmLU6I7dbLv8BJ+TXjbrsMXfTGeZfNHEHX5iLMEHC+MUBo
         tVlRcfwbTNUgJSq3SLUKaDf6e7xLvelUucydd4TyeSI50mXyXhWfFJ71K20BZUPAZ+j2
         1y01hCXNPUFkPxvRxMYmAPTIA8vx6pmK/oHkUnFRbSUiqp6if4avl1UgYro9bojXCNFK
         PdvwKgdSxaLrCAY4ORNvb9VzENL88pAN3f4qwT5/y1D/J/Dy/Jp2liCCmmXaAOrxbnEN
         4aFDQjQJWsKgC9SRBeGteVpJNm+HsfKR7gJWgECwDIkthUwu9p6fdTMzVOgygKSl+o6e
         RPQg==
X-Gm-Message-State: AHQUAuae9QGBXc8e3huPMqaf1gdHelKZaHy8aNvqEalYV0RrJE4okAN5
        7HWWS0F6TnrdjHON8STrj2ebe4nhKL7ISiGGLFlxy2Vpqa7f
X-Google-Smtp-Source: AHgI3IY90p2XiNpZutpfgfZdee4QCY+He2w6CUBhBIORBfXPa8qBggEW1b8NhwKDg8+pTK/QMjp7W5esMY39h7jNkggUTrw+jhEM
MIME-Version: 1.0
X-Received: by 2002:a02:8609:: with SMTP id e9mr6813224jai.8.1549471624337;
 Wed, 06 Feb 2019 08:47:04 -0800 (PST)
Date:   Wed, 06 Feb 2019 08:47:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c24a5e05813c798b@google.com>
Subject: INFO: task hung in tipc_bcast_stop
From:   syzbot <syzbot+8118fd903ae608d128e1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c8101f7729da net: dsa: Fix lockdep false positive splat
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1553f728c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0064f906afee10
dashboard link: https://syzkaller.appspot.com/bug?extid=8118fd903ae608d128e1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8118fd903ae608d128e1@syzkaller.appspotmail.com

bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:3e:c4:ef:c6:e1:9c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:a6:63:10:7b:ed:f3, vlan:0)
INFO: task kworker/u4:4:3054 blocked for more than 140 seconds.
       Not tainted 5.0.0-rc4+ #63
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
net_ratelimit: 66009 callbacks suppressed
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source  
address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source  
address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:3e:c4:ef:c6:e1:9c, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:a6:63:10:7b:ed:f3, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on veth0_to_bridge with own address as source  
address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
kworker/u4:4    D24832  3054      2 0x80000000
Workqueue: netns cleanup_net
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  exp_funnel_lock kernel/rcu/tree_exp.h:319 [inline]
  _synchronize_rcu_expedited.constprop.0+0x4d4/0x530  
kernel/rcu/tree_exp.h:622
  synchronize_rcu_expedited+0x27/0xa0 kernel/rcu/tree_exp.h:762
  synchronize_net+0x3b/0x60 net/core/dev.c:9165
  tipc_bcast_stop+0x198/0x310 net/tipc/bcast.c:545
  tipc_exit_net+0x26/0x40 net/tipc/core.c:102
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x3fb/0x960 net/core/net_namespace.c:551
  process_one_work+0x98e/0x1760 kernel/workqueue.c:2153
  worker_thread+0x98/0xe40 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
INFO: task syz-executor1:17203 blocked for more than 140 seconds.
       Not tainted 5.0.0-rc4+ #63
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D30144 17203   7626 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:584 [inline]
  rwsem_down_write_failed+0x774/0xc30 kernel/locking/rwsem-xadd.c:613
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0x53/0x90 kernel/locking/rwsem.c:72
  register_netdevice_notifier+0x7e/0x630 net/core/dev.c:1634
  bcm_init+0x1a8/0x220 net/can/bcm.c:1502
  can_create+0x28a/0x4b0 net/can/af_can.c:183
  __sock_create+0x3e6/0x750 net/socket.c:1275
  sock_create net/socket.c:1315 [inline]
  __sys_socket+0x103/0x220 net/socket.c:1345
  __do_sys_socket net/socket.c:1354 [inline]
  __se_sys_socket net/socket.c:1352 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1352
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
Code: Bad RIP value.
RSP: 002b:00007f2b02d39c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000000000002 RSI: 0000000000000002 RDI: 000000000000001d
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2b02d3a6d4
R13: 00000000004c60f6 R14: 00000000004db1e0 R15: 00000000ffffffff
INFO: task syz-executor1:17207 blocked for more than 140 seconds.
       Not tainted 5.0.0-rc4+ #63
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D29872 17207   7626 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  __rwsem_down_write_failed_common kernel/locking/rwsem-xadd.c:584 [inline]
  rwsem_down_write_failed+0x774/0xc30 kernel/locking/rwsem-xadd.c:613
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0x53/0x90 kernel/locking/rwsem.c:72
  register_netdevice_notifier+0x7e/0x630 net/core/dev.c:1634
  bcm_init+0x1a8/0x220 net/can/bcm.c:1502
  can_create+0x28a/0x4b0 net/can/af_can.c:183
  __sock_create+0x3e6/0x750 net/socket.c:1275
  sock_create net/socket.c:1315 [inline]
  __sys_socket+0x103/0x220 net/socket.c:1345
  __do_sys_socket net/socket.c:1354 [inline]
  __se_sys_socket net/socket.c:1352 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1352
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e39
Code: Bad RIP value.
RSP: 002b:00007f2b02d18c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e39
RDX: 0000000000000002 RSI: 0000000000000002 RDI: 000000000000001d
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2b02d196d4
R13: 00000000004c60f6 R14: 00000000004db1e0 R15: 00000000ffffffff

Showing all locks held in the system:
3 locks held by ksoftirqd/1/16:
1 lock held by khungtaskd/1040:
  #0: 00000000e3131bf8 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:4389
3 locks held by kworker/u4:4/3054:
  #0: 000000002f6c8bac ((wq_completion)"%s""netns"){+.+.}, at:  
__write_once_size include/linux/compiler.h:220 [inline]
  #0: 000000002f6c8bac ((wq_completion)"%s""netns"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000002f6c8bac ((wq_completion)"%s""netns"){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000002f6c8bac ((wq_completion)"%s""netns"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
  #0: 000000002f6c8bac ((wq_completion)"%s""netns"){+.+.}, at: set_work_data  
kernel/workqueue.c:617 [inline]
  #0: 000000002f6c8bac ((wq_completion)"%s""netns"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000002f6c8bac ((wq_completion)"%s""netns"){+.+.}, at:  
process_one_work+0x87e/0x1760 kernel/workqueue.c:2124
  #1: 00000000356e77de (net_cleanup_work){+.+.}, at:  
process_one_work+0x8b4/0x1760 kernel/workqueue.c:2128
  #2: 0000000070308617 (pernet_ops_rwsem){++++}, at: cleanup_net+0xae/0x960  
net/core/net_namespace.c:518
1 lock held by rsyslogd/7473:
2 locks held by getty/7586:
  #0: 000000007d8d2e99 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000009ac587d5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7587:
  #0: 000000009302afb1 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000be8c1a8d (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7588:
  #0: 0000000082755b9e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000a2bc657f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7589:
  #0: 00000000d211856e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000279c75af (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7590:
  #0: 000000000111820e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000db1c3ad5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7591:
  #0: 00000000756df6ea (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000026a342a6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
2 locks held by getty/7592:
  #0: 00000000f85959b5 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000a7cf75cc (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2154
1 lock held by syz-executor1/17203:
  #0: 0000000070308617 (pernet_ops_rwsem){++++}, at:  
register_netdevice_notifier+0x7e/0x630 net/core/dev.c:1634
1 lock held by syz-executor1/17207:
  #0: 0000000070308617 (pernet_ops_rwsem){++++}, at:  
register_netdevice_notifier+0x7e/0x630 net/core/dev.c:1634

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1040 Comm: khungtaskd Not tainted 5.0.0-rc4+ #63
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:203 [inline]
  watchdog+0x9df/0xee0 kernel/hung_task.c:287
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.389  
msecs
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.0.0-rc4+ #63
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rol32 include/linux/bitops.h:83 [inline]
RIP: 0010:jhash2 include/linux/jhash.h:128 [inline]
RIP: 0010:hash_stack lib/stackdepot.c:161 [inline]
RIP: 0010:depot_save_stack+0x76/0x460 lib/stackdepot.c:230
Code: 0f 86 ec 01 00 00 44 89 cb 44 89 c8 48 89 ca 03 5a 08 41 83 e8 03 48  
83 c2 0c 44 03 4a f4 03 42 f8 45 89 cb 41 89 d9 41 29 db <41> c1 c1 04 01  
c3 45 31 d9 44 29 c8 41 89 c2 44 89 c8 41 01 d9 c1
RSP: 0018:ffff8880a9886ed8 EFLAGS: 00000206
RAX: 00000000ce5caf29 RBX: 00000000b5fb600c RCX: ffff8880a9886f38
RDX: ffff8880a9886f68 RSI: 0000000000490220 RDI: 0000000000000016
RBP: ffff8880a9886f10 R08: 0000000000000020 R09: 00000000b5fb600c
R10: 000000008a18bda7 R11: 000000001a539322 R12: 0000000000490220
R13: ffff8880a9886f20 R14: 0000000000000000 R15: ffff88812c3f0940
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000457e0f CR3: 00000000a4f2e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  save_stack+0xa9/0xd0 mm/kasan/common.c:79
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:496 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:469
  kasan_kmalloc mm/kasan/common.c:504 [inline]
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:411
  slab_post_alloc_hook mm/slab.h:444 [inline]
  slab_alloc_node mm/slab.c:3324 [inline]
  kmem_cache_alloc_node_trace+0x13c/0x720 mm/slab.c:3650
  __do_kmalloc_node mm/slab.c:3672 [inline]
  __kmalloc_node_track_caller+0x3d/0x70 mm/slab.c:3687
  __kmalloc_reserve.isra.0+0x40/0xf0 net/core/skbuff.c:140
  __alloc_skb+0x10b/0x5e0 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1011 [inline]
  nlmsg_new include/net/netlink.h:654 [inline]
  fdb_notify+0x9f/0x190 net/bridge/br_fdb.c:706
  br_fdb_update net/bridge/br_fdb.c:601 [inline]
  br_fdb_update+0x2fd/0xa70 net/bridge/br_fdb.c:562
  br_handle_frame_finish+0x84f/0x14c0 net/bridge/br_input.c:97
  br_nf_hook_thresh+0x2ec/0x380 net/bridge/br_netfilter_hooks.c:1009
  br_nf_pre_routing_finish_ipv6+0x708/0xdc0  
net/bridge/br_netfilter_ipv6.c:210
  NF_HOOK include/linux/netfilter.h:289 [inline]
  br_nf_pre_routing_ipv6+0x3c4/0x740 net/bridge/br_netfilter_ipv6.c:238
  br_nf_pre_routing+0xe80/0x13a0 net/bridge/br_netfilter_hooks.c:482
  nf_hook_entry_hookfn include/linux/netfilter.h:119 [inline]
  nf_hook_slow+0xbf/0x1f0 net/netfilter/core.c:511
  nf_hook include/linux/netfilter.h:244 [inline]
  NF_HOOK include/linux/netfilter.h:287 [inline]
  br_handle_frame+0x95b/0x1450 net/bridge/br_input.c:305
  __netif_receive_skb_core+0xa96/0x3010 net/core/dev.c:4902
  __netif_receive_skb_one_core+0xa8/0x1a0 net/core/dev.c:4971
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x4fa/0x1070 net/core/dev.c:6412
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
