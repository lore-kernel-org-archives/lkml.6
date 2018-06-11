Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9sRJMrWSHlvqGAAAmS7hNA
	; Mon, 11 Jun 2018 15:18:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9F34607E4; Mon, 11 Jun 2018 15:18:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 181BF60791;
	Mon, 11 Jun 2018 15:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 181BF60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbeFKPSL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:18:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932678AbeFKPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:18:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BFFAAC123617
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:18:04 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jhudt8mrd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:18:03 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Jun 2018 11:18:03 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 11:18:00 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5BFHxNA3998072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 15:17:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 098FFB206C;
        Mon, 11 Jun 2018 11:17:59 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E78D7B2065;
        Mon, 11 Jun 2018 11:17:58 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.157.62])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jun 2018 11:17:58 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 98B7B16C997C; Mon, 11 Jun 2018 05:56:58 -0700 (PDT)
Date: Mon, 11 Jun 2018 05:56:58 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 1/2] rcutorture: Disable RT throttling for boost tests
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180610234544.150933-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610234544.150933-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061115-2213-0000-0000-000002B6E842
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009170; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01045450; UDB=6.00535337; IPR=6.00824427;
 MB=3.00021581; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-11 15:18:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061115-2214-0000-0000-00005A7111FF
Message-Id: <20180611125658.GR3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 04:45:43PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Currently rcutorture is not able to torture RCU boosting properly. This
> is because the rcutorture's boost threads which are doing the torturing
> may be throttled due to RT throttling.
> 
> This patch makes rcutorture use the right torture technique (unthrottled
> rcutorture boost tasks) for torturing RCU so that the test fails
> correctly when no boost is available.
> 
> Currently this requires accessing sysctl_sched_rt_runtime directly, but
> that should be Ok since rcutorture is test code. Such direct access is
> also only possible if rcutorture is used as a built-in so make it
> conditional on that.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you, Joel!  I have queued these for testing and review.
Peter Zijlstra might have some feedback on variable access, but will
test first.

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 5219e7ccd8a4..00e06349d7bb 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -55,6 +55,7 @@
>  #include <linux/torture.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched/sysctl.h>
> 
>  #include "rcu.h"
> 
> @@ -772,6 +773,32 @@ static void rcu_torture_boost_cb(struct rcu_head *head)
>  	smp_store_release(&rbip->inflight, 0);
>  }
> 
> +static int old_rt_runtime = -1;
> +
> +static void rcu_torture_disable_rt_throttle(void)
> +{
> +	/*
> +	 * Disable RT throttling so that rcutorture's boost threads don't get
> +	 * throttled. Only possible if rcutorture is built-in otherwise the
> +	 * user should manually do this by setting the sched_rt_period_us and
> +	 * sched_rt_runtime sysctls.
> +	 */
> +	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
> +		return;
> +
> +	old_rt_runtime = sysctl_sched_rt_runtime;
> +	sysctl_sched_rt_runtime = -1;
> +}
> +
> +static void rcu_torture_enable_rt_throttle(void)
> +{
> +	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
> +		return;
> +
> +	sysctl_sched_rt_runtime = old_rt_runtime;
> +	old_rt_runtime = -1;
> +}
> +
>  static int rcu_torture_boost(void *arg)
>  {
>  	unsigned long call_rcu_time;
> @@ -1510,6 +1537,7 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
>  	mutex_lock(&boost_mutex);
>  	t = boost_tasks[cpu];
>  	boost_tasks[cpu] = NULL;
> +	rcu_torture_enable_rt_throttle();
>  	mutex_unlock(&boost_mutex);
> 
>  	/* This must be outside of the mutex, otherwise deadlock! */
> @@ -1526,6 +1554,7 @@ static int rcutorture_booster_init(unsigned int cpu)
> 
>  	/* Don't allow time recalculation while creating a new task. */
>  	mutex_lock(&boost_mutex);
> +	rcu_torture_disable_rt_throttle();
>  	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
>  	boost_tasks[cpu] = kthread_create_on_node(rcu_torture_boost, NULL,
>  						  cpu_to_node(cpu),
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 
