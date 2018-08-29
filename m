Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F4620658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F4620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeH3CVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:21:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727294AbeH3CVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:21:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIibc038604
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:22:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7uc22-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:22:20 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:22:19 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:22:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMMEaR46727296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:22:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDC1DB2064;
        Wed, 29 Aug 2018 18:21:09 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCDB0B2067;
        Wed, 29 Aug 2018 18:21:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:21:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3B8EB16C91B7; Wed, 29 Aug 2018 15:22:14 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:22:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/19] RCU flavor-consolidation changes for
 v4.20/v5.0
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180829222021.GA29944@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-000003996727
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080739; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:22:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EABFA
Message-Id: <20180829222214.GA19014@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:20:21PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains the RCU flavor consolidation, along with some initial
> cleanup work enabled by that consolidation (and some that became apparent
> while cleaning up):
> 
> 1.	Refactor rcu_{nmi,irq}_{enter,exit}(), saving a branch on the
> 	idle entry/exit hotpaths, courtesy of Byungchul Park,
> 
> 2.	Defer reporting RCU-preempt quiescent states when disabled.
> 	This is the key commit that consolidates the RCU-bh and RCU-sched
> 	flavors into RCU, however, the RCU-bh and RCU-sched flavors
> 	still exist independently as well at this point.
> 
> 3.	Test extended "rcu" read-side critical sections.  This commit
> 	causes rcutorture to test RCU's new-found ability to act as
> 	the combination of RCU, RCU-bh, and RCU-sched.
> 
> 4.	Allow processing deferred QSes for exiting RCU-preempt readers.
> 	This is a optimization.
> 
> 5.	Remove now-unused ->b.exp_need_qs field from the rcu_special union.
> 
> 6.	Add warning to detect half-interrupts.  Test the claim that
> 	the Linux kernel no longer does half-interrupts.
> 
> 7.	Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe, that is,
> 	make the consolidated RCU inherit RCU-bh's denial-of-service
> 	avoidance mechanism.
> 
> 8.	Report expedited grace periods at context-switch time.  This is
> 	an optimization enabled by the RCU flavor consolidation.
> 
> 9.	Define RCU-bh update API in terms of RCU.  This commit gets rid
> 	of the RCU-bh update mechanism.
> 
> 10.	Update comments and help text to account for the removal of
> 	the RCU-bh update mechanism.
> 
> 11.	Drop "wake" parameter from rcu_report_exp_rdp().
> 
> 12.	Fix typo in rcu_get_gp_kthreads_prio() header comment.
> 
> 13.	Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds.
> 	Although this commit gets rid of the RCU-sched update mechanism
> 	from PREEMPT builds, it of course remains as the sole RCU flavor
> 	for !PREEMPT && !SMP builds.
> 
> 14.	Express Tiny RCU updates in terms of RCU rather than RCU-sched.
> 	This will enable additional cleanups and code savings.
> 
> 15.	Remove RCU_STATE_INITIALIZER() in favor of just using an open-coded
> 	initializer for the sole remaining rcu_state structure.
> 
> 16.	Eliminate rcu_state structure's ->call field, as it is now always
> 	just call_rcu().
> 
> 17.	Remove rcu_state structure's ->rda field, as there is now only one
> 	set of per-CPU rcu_data structures.

And last, but perhaps not least:

18.	Remove rcu_state_p pointer to default rcu_state structure, now
	that there is only one rcu_state structure.

19.	Remove rcu_data_p pointer to default rcu_data structure, now that
	there is only one set of per-CPU rcu_data structures.

							Thanx, Paul

> ------------------------------------------------------------------------
> 
>  Documentation/RCU/Design/Requirements/Requirements.html |   50 -
>  include/linux/rcupdate.h                                |   48 -
>  include/linux/rcupdate_wait.h                           |    6 
>  include/linux/rcutiny.h                                 |   61 +
>  include/linux/rcutree.h                                 |   31 
>  include/linux/sched.h                                   |    6 
>  kernel/rcu/Kconfig                                      |   10 
>  kernel/rcu/rcutorture.c                                 |    1 
>  kernel/rcu/tiny.c                                       |  163 +--
>  kernel/rcu/tree.c                                       |  655 +++++-----------
>  kernel/rcu/tree.h                                       |   44 -
>  kernel/rcu/tree_exp.h                                   |  256 +++---
>  kernel/rcu/tree_plugin.h                                |  523 ++++++------
>  kernel/rcu/update.c                                     |    2 
>  kernel/softirq.c                                        |    3 
>  15 files changed, 836 insertions(+), 1023 deletions(-)

