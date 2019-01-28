Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC4EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C902084A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfA1Qni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:43:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388725AbfA1QXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:23 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SGJaBl019717
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:23:22 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qa2cvh3yc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:23:22 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 28 Jan 2019 16:23:20 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 16:23:19 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SGNIja19267692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 16:23:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7698EB2064;
        Mon, 28 Jan 2019 16:23:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5917BB205F;
        Mon, 28 Jan 2019 16:23:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 16:23:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 29BD516C5F77; Mon, 28 Jan 2019 08:23:18 -0800 (PST)
Date:   Mon, 28 Jan 2019 08:23:18 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 028/304] srcu: Prevent __call_srcu() counter
 wrap with read-side critical section
Reply-To: paulmck@linux.ibm.com
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-28-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128154341.47195-28-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012816-0068-0000-0000-0000038A1CF1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010493; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153048; UDB=6.00601113; IPR=6.00933410;
 MB=3.00025324; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 16:23:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012816-0069-0000-0000-0000474CA849
Message-Id: <20190128162318.GS4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:39:05AM -0500, Sasha Levin wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> [ Upstream commit 0607ba8403c4cdb253f8c5200ecf654dfb7790cc ]
> 
> Ever since cdf7abc4610a ("srcu: Allow use of Tiny/Tree SRCU from
> both process and interrupt context"), it has been permissible
> to use SRCU read-side critical sections in interrupt context.
> This allows __call_srcu() to use SRCU read-side critical sections to
> prevent a new SRCU grace period from ending before the call to either
> srcu_funnel_gp_start() or srcu_funnel_exp_start completes, thus preventing
> SRCU grace-period counter overflow during that time.
> 
> Note that this does not permit removal of the counter-wrap checks in
> srcu_gp_end().  These check are necessary to handle the case where
> a given CPU does not interact at all with SRCU for an extended time
> period.
> 
> This commit therefore adds an SRCU read-side critical section to
> __call_srcu() in order to prevent grace period counter wrap during
> the funnel-locking process.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hello, Sasha,

I recommend -against- backporting this one.  It is a theoretical bug
that requires rather long preemption, so the risk of backporting likely
greatly exceeeds the risk of the bug actually happening, especially on
64-bit systems.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index a180abc8c925..697a2d7e8e8a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -860,6 +860,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
>  		 rcu_callback_t func, bool do_norm)
>  {
>  	unsigned long flags;
> +	int idx;
>  	bool needexp = false;
>  	bool needgp = false;
>  	unsigned long s;
> @@ -873,6 +874,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
>  		return;
>  	}
>  	rhp->func = func;
> +	idx = srcu_read_lock(sp);
>  	local_irq_save(flags);
>  	sdp = this_cpu_ptr(sp->sda);
>  	spin_lock_rcu_node(sdp);
> @@ -894,6 +896,7 @@ void __call_srcu(struct srcu_struct *sp, struct rcu_head *rhp,
>  		srcu_funnel_gp_start(sp, sdp, s, do_norm);
>  	else if (needexp)
>  		srcu_funnel_exp_start(sp, sdp->mynode, s);
> +	srcu_read_unlock(sp, idx);
>  }
> 
>  /**
> -- 
> 2.19.1
> 

