Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA2C28CF3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB6920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756803AbeFSVQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:16:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755415AbeFSVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:16:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5JLEce7038107
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:16:51 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jq882ucdb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:16:51 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 19 Jun 2018 17:16:50 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Jun 2018 17:16:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5JLGj8O11207086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 21:16:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31C44B205F;
        Tue, 19 Jun 2018 17:16:35 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0189EB2064;
        Tue, 19 Jun 2018 17:16:35 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Jun 2018 17:16:34 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B3D4116C3BD3; Tue, 19 Jun 2018 14:18:46 -0700 (PDT)
Date:   Tue, 19 Jun 2018 14:18:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Dipankar Sarma <dipankar@in.ibm.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH 2/2] rcu,debug_core: allow the kernel debugger to
 reset the rcu stall timer
Reply-To: paulmck@linux.vnet.ibm.com
References: <1281330732-17164-1-git-send-email-jason.wessel@windriver.com>
 <1281330732-17164-2-git-send-email-jason.wessel@windriver.com>
 <1281330732-17164-3-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1281330732-17164-3-git-send-email-jason.wessel@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061921-0068-0000-0000-0000030B5935
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009222; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049407; UDB=6.00537710; IPR=6.00828380;
 MB=3.00021747; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 21:16:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061921-0069-0000-0000-000044BDE2F8
Message-Id: <20180619211846.GO3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2010 at 12:12:12AM -0500, Jason Wessel wrote:
> When returning from the kernel debugger allow a reset of the rcu
> jiffies_stall value to prevent the rcu stall detector from sending NMI
> events which stack dumps on all the cpus in the system.

Not sure where the 2010 date came from, but it almost fooled me into
deleting your emails unread.  ;-)

> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> CC: Dipankar Sarma <dipankar@in.ibm.com>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Ingo Molnar <mingo@elte.hu>
> ---
>  include/linux/rcupdate.h  |    8 ++++++++
>  kernel/debug/debug_core.c |    2 ++
>  kernel/rcutree.c          |    9 +++++++++
>  3 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 9fbc54a..abd3ab6 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -599,4 +599,12 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
>  #define rcu_dereference_index_check(p, c) \
>  	__rcu_dereference_index_check((p), (c))
> 
> +#ifdef CONFIG_RCU_CPU_STALL_DETECTOR
> +extern void rcu_cpu_stall_reset(void);
> +#else /* #ifdef CONFIG_RCU_CPU_STALL_DETECTOR */
> +static inline void rcu_cpu_stall_reset(void)
> +{
> +}
> +#endif /* #ifdef CONFIG_RCU_CPU_STALL_DETECTOR */
> +
>  #endif /* __LINUX_RCUPDATE_H */
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index e4d6819..1600e90 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -47,6 +47,7 @@
>  #include <linux/pid.h>
>  #include <linux/smp.h>
>  #include <linux/mm.h>
> +#include <linux/rcupdate.h>
> 
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -474,6 +475,7 @@ static void dbg_touch_watchdogs(void)
>  {
>  	touch_softlockup_watchdog_sync();
>  	clocksource_touch_watchdog();
> +	rcu_cpu_stall_reset();
>  }
> 
>  static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs)
> diff --git a/kernel/rcutree.c b/kernel/rcutree.c
> index d5bc439..209b755 100644
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -532,6 +532,9 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
> 
>  	if (rcu_cpu_stall_panicking)
>  		return;
> +	/* Gracefully handle a watch dog reset when jiffies_stall == 0 */
> +	if (!rsp->jiffies_stall)
> +		return;

Why not just use the existing rcu_cpu_stall_reset()?  It sets the next
stall a long way into the future, like 2 billion jiffies on 32-bit
systems.

>  	delta = jiffies - rsp->jiffies_stall;
>  	rnp = rdp->mynode;
>  	if ((rnp->qsmask & rdp->grpmask) && delta >= 0) {
> @@ -561,6 +564,12 @@ static void __init check_cpu_stall_init(void)
>  	atomic_notifier_chain_register(&panic_notifier_list, &rcu_panic_block);
>  }
> 
> +void rcu_cpu_stall_reset(void)
> +{
> +	rcu_sched_state.jiffies_stall = 0;
> +	rcu_bh_state.jiffies_stall = 0;

This should get you a compiler warning given the existing
rcu_cpu_stall_reset().  It also fails to do anything about
rcu_preempt_state on PREEMPT=y kernels.

What happens if you just remove the rcutree.c changes from your
series and test with the result?

							Thanx, Paul

> +}
> +
>  #else /* #ifdef CONFIG_RCU_CPU_STALL_DETECTOR */
> 
>  static void record_gp_stall_check_time(struct rcu_state *rsp)
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

