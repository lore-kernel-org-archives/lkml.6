Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69033C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172ED2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeLPTES convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:04:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730097AbeLPTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:04:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBGJ3rjM054062
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 14:04:16 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pdfg5njnb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 14:04:16 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 16 Dec 2018 19:04:14 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Dec 2018 19:04:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBGJ4Ask19464254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 16 Dec 2018 19:04:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0437B2067;
        Sun, 16 Dec 2018 19:04:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7817EB2065;
        Sun, 16 Dec 2018 19:04:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.153.1])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 16 Dec 2018 19:04:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8A1F416C3421; Sun, 16 Dec 2018 11:04:12 -0800 (PST)
Date:   Sun, 16 Dec 2018 11:04:12 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, arjan@linux.intel.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __rcu_read_unlock
Reply-To: paulmck@linux.ibm.com
References: <0000000000005e47a2057d0edc49@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0000000000005e47a2057d0edc49@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121619-0064-0000-0000-000003874684
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010237; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01132728; UDB=6.00588781; IPR=6.00912860;
 MB=3.00024712; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-16 19:04:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121619-0065-0000-0000-00003BB4049D
Message-Id: <20181216190412.GE4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-16_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=847 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812160178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 04:41:03AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    2aa55dccf83d hns3: prevent building without CONFIG_INET
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15628f6d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=43f6755d1c2e62743468
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125fda8b400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135e54cd400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com
> 
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> WARNING: CPU: 0 PID: -2035180937 at kernel/rcu/tree_plugin.h:438
> __rcu_read_unlock+0x266/0x2e0 kernel/rcu/tree_plugin.h:432
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: -2035180937 Comm:  L����� Not tainted 4.20.0-rc6+ #344
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  panic+0x2ad/0x55c kernel/panic.c:188
>  __warn.cold.8+0x20/0x45 kernel/panic.c:540
>  report_bug+0x254/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> RIP: 0010:__rcu_read_unlock+0x266/0x2e0 kernel/rcu/tree_plugin.h:432
> Code: 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 0f b6 04 02 84 c0 74 04
> 3c 03 7e 6f 41 c7 84 24 70 03 00 00 00 00 00 00 e9 5a fe ff ff <0f>
> 0b e9 da fe ff ff 4c 89 f7 e8 1b 14 59 00 e9 2a fe ff ff 4c 89
> RSP: 0018:ffff8881dae075e8 EFLAGS: 00010006
> RAX: dffffc0000000000 RBX: 1ffff1103b5c0ebe RCX: ffffffff8153f599
> RDX: 1ffff1103b5c0eca RSI: ffffffff8153f5bb RDI: 0000000000000005
> RBP: ffff8881dae076b8 R08: ffff8881bf1f4540 R09: ffffed103b5c3ef8
> R10: ffffed103b5c3ef8 R11: ffff8881dae1f7c7 R12: 00000000fdb21501
> R13: 1ffff1103b5c0eca R14: ffff8881bf1f48b0 R15: ffff8881dae07690
>  rcu_read_unlock include/linux/rcupdate.h:660 [inline]
>  __atomic_notifier_call_chain kernel/notifier.c:184 [inline]
>  atomic_notifier_call_chain+0xd0/0x190 kernel/notifier.c:193
>  notify_die+0x1bd/0x2d0 kernel/notifier.c:549
>  do_general_protection+0x16d/0x2f0 arch/x86/kernel/traps.c:557
>  general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1142
> RIP: 0010:task_css include/linux/cgroup.h:477 [inline]
> RIP: 0010:task_ca kernel/sched/cpuacct.c:43 [inline]
> RIP: 0010:cpuacct_account_field+0x140/0x3d0 kernel/sched/cpuacct.c:365
> Code: b6 97 08 00 85 c0 74 0d 80 3d 69 bb b2 08 00 0f 84 a4 01 00 00
> 49 8d 7e 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80>
> 3c 02 00 0f 85 4e 02 00 00 4d 8b 7e 10 49 81 ff 20 23 58 89 0f
> RSP: 0018:ffff8881dae078a8 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: ffff8881dae07918 RCX: 0000000000000000
> RDX: 000000000000000e RSI: 00000000ffff8881 RDI: 0000000000000072
> RBP: ffff8881dae07940 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffed1037304851 R11: 0000000000000007 R12: 0000000000982e14
> R13: dffffc0000000000 R14: 0000000000000062 R15: ffff8881bf1f4540
>  cgroup_account_cputime_field include/linux/cgroup.h:775 [inline]
>  task_group_account_field kernel/sched/cputime.c:108 [inline]
>  account_system_index_time+0x1e8/0x5d0 kernel/sched/cputime.c:171
>  irqtime_account_process_tick.isra.6+0x35b/0x490 kernel/sched/cputime.c:388
>  account_process_tick+0x282/0x350 kernel/sched/cputime.c:483
>  update_process_times+0x21/0x70 kernel/time/timer.c:1634
>  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
>  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
>  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
>  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
>  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
>  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>  </IRQ>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..


Hmmm...  Line 432 is the "t->rcu_read_lock_nesting = 0;" below
and Line 438 is the int "rrln = READ_ONCE(t->rcu_read_lock_nesting);"
below.  Are you saying that the value of "current" is NULL?  If you
do that, you have voided your RCU warranty.  ;-)

Or should I be looking elsewhere than v4.20-rc5?

							Thanx, Paul

------------------------------------------------------------------------

void __rcu_read_unlock(void)
{
	struct task_struct *t = current;

	if (t->rcu_read_lock_nesting != 1) {
		--t->rcu_read_lock_nesting;
	} else {
		barrier();  /* critical section before exit code. */
		t->rcu_read_lock_nesting = INT_MIN;
		barrier();  /* assign before ->rcu_read_unlock_special load */
		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
			rcu_read_unlock_special(t);
		barrier();  /* ->rcu_read_unlock_special load before assign */
		t->rcu_read_lock_nesting = 0;
	}
#ifdef CONFIG_PROVE_LOCKING
	{
		int rrln = READ_ONCE(t->rcu_read_lock_nesting);

		WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);
	}
#endif /* #ifdef CONFIG_PROVE_LOCKING */
}

