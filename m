Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4482C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BD220846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BD220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbeFTRIs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:08:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932153AbeFTRIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:08:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KGx1MU139361
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:08:46 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqrc6qyks-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:08:46 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 13:08:45 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 13:08:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KH8exI9634254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:08:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6553CB2065;
        Wed, 20 Jun 2018 13:08:28 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 468C7B2068;
        Wed, 20 Jun 2018 13:08:28 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 13:08:28 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 71A1B16C9B49; Wed, 20 Jun 2018 10:10:41 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:10:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/3] rcu: Assign higher prio to RCU threads if
 rcutorture is built-in
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180619221419.41340-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619221419.41340-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062017-0068-0000-0000-0000030BDC52
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009228; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049798; UDB=6.00537943; IPR=6.00828771;
 MB=3.00021761; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 17:08:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0069-0000-0000-000044C0629B
Message-Id: <20180620171041.GY3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 03:14:17PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> rcutorture boost tests fail even with CONFIG_RCU_BOOST set because
> rcutorture's threads are equal priority to the default RCU kthreads (RT
> class with priority of 1).
> 
> This patch checks if RCU torture is built into the kernel and if so,
> assigns a higher priority to the RCU threads. With this the rcutorture
> boost tests pass.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I queued all three for testing and further review.  I reworked the commit
logs a bit and also pulled the error string onto one line to make it
easier on people grepping for the message.  Please let me know if I
messed anything up.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index deb2508be923..92c29439eba6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3884,12 +3884,16 @@ static int __init rcu_spawn_gp_kthread(void)
>  	struct task_struct *t;
> 
>  	/* Force priority into range. */
> -	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
> +	if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 2
> +	    && IS_BUILTIN(CONFIG_RCU_TORTURE_TEST))
> +		kthread_prio = 2;
> +	else if (IS_ENABLED(CONFIG_RCU_BOOST) && kthread_prio < 1)
>  		kthread_prio = 1;
>  	else if (kthread_prio < 0)
>  		kthread_prio = 0;
>  	else if (kthread_prio > 99)
>  		kthread_prio = 99;
> +
>  	if (kthread_prio != kthread_prio_in)
>  		pr_alert("rcu_spawn_gp_kthread(): Limited prio to %d from %d\n",
>  			 kthread_prio, kthread_prio_in);
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 

