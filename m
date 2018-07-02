Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFEB25CE3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFEB25CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeGBPPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:15:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752355AbeGBPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:15:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62FEYq2143072
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 11:15:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jykxbf49r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:15:22 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 11:15:20 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 11:15:16 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62FFFtE4981374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 15:15:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E0A3B2066;
        Mon,  2 Jul 2018 11:15:01 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1095B2065;
        Mon,  2 Jul 2018 11:15:00 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 11:15:00 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CD31816C2DEE; Mon,  2 Jul 2018 08:17:28 -0700 (PDT)
Date:   Mon, 2 Jul 2018 08:17:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Jacek Tomaka <jacekt@dug.com>
Subject: Re: [PATCH] sched/nohz: Skip remote tick on idle task entirely
Reply-To: paulmck@linux.vnet.ibm.com
References: <1530203381-31234-1-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530203381-31234-1-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070215-0040-0000-0000-000004485055
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009295; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055510; UDB=6.00541374; IPR=6.00833433;
 MB=3.00021964; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 15:15:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070215-0041-0000-0000-0000084E6C23
Message-Id: <20180702151728.GO3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 06:29:41PM +0200, Frederic Weisbecker wrote:
> Some people have reported that the warning in sched_tick_remote()
> occasionally triggers, especially in favour of some RCU-Torture
> pressure:
> 
> 	WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0
> 	Modules linked in:
> 	CPU: 11 PID: 906 Comm: kworker/u32:3 Not tainted 4.18.0-rc2+ #1
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> 	Workqueue: events_unbound sched_tick_remote
> 	RIP: 0010:sched_tick_remote+0xb6/0xc0
> 	Code: e8 0f 06 b8 00 c6 03 00 fb eb 9d 8b 43 04 85 c0 75 8d 48 8b 83 e0 0a 00 00 48 85 c0 75 81 eb 88 48 89 df e8 bc fe ff ff eb aa <0f> 0b eb
> 	+c5 66 0f 1f 44 00 00 bf 17 00 00 00 e8 b6 2e fe ff 0f b6
> 	Call Trace:
> 	 process_one_work+0x1df/0x3b0
> 	 worker_thread+0x44/0x3d0
> 	 kthread+0xf3/0x130
> 	 ? set_worker_desc+0xb0/0xb0
> 	 ? kthread_create_worker_on_cpu+0x70/0x70
> 	 ret_from_fork+0x35/0x40
> 
> This happens when the remote tick applies on an idle task. Usually the
> idle_cpu() check avoids that, but it is performed before we lock the
> runqueue and it is therefore racy. It was intended to be that way in
> order to prevent from useless runqueue locks since idle task tick
> callback is a no-op.
> 
> Now if the racy check slips out of our hands and we end up remotely
> ticking an idle task, the empty task_tick_idle() is harmless. Still
> it won't pass the WARN_ON_ONCE() test that ensures rq_clock_task() is
> not too far from curr->se.exec_start because update_curr_idle() doesn't
> update the exec_start value like other scheduler policies. Hence the
> reported false positive.
> 
> So let's have another check, while the rq is locked, to make sure we
> don't remote tick on an idle task. The lockless idle_cpu() still applies
> to avoid unecessary rq lock contention.
> 
> Reported-by: Jacek Tomaka <jacekt@dug.com>
> Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  kernel/sched/core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 78d8fac..da8f121 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3127,16 +3127,18 @@ static void sched_tick_remote(struct work_struct *work)
>  		u64 delta;
> 
>  		rq_lock_irq(rq, &rf);
> -		update_rq_clock(rq);
>  		curr = rq->curr;
> -		delta = rq_clock_task(rq) - curr->se.exec_start;
> +		if (!is_idle_task(curr)) {
> +			update_rq_clock(rq);
> +			delta = rq_clock_task(rq) - curr->se.exec_start;
> 
> -		/*
> -		 * Make sure the next tick runs within a reasonable
> -		 * amount of time.
> -		 */
> -		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> -		curr->sched_class->task_tick(rq, curr, 0);
> +			/*
> +			 * Make sure the next tick runs within a reasonable
> +			 * amount of time.
> +			 */
> +			WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
> +			curr->sched_class->task_tick(rq, curr, 0);
> +		}
>  		rq_unlock_irq(rq, &rf);
>  	}
> 
> -- 
> 2.7.4
> 

