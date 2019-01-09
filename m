Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07596C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36A82075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfAIVSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:18:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfAIVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:18:45 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LIh0n094060
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:18:44 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq4rmdmu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:18:42 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:37 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:32 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIUbq24838162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F220B2066;
        Wed,  9 Jan 2019 21:18:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E9C7B2064;
        Wed,  9 Jan 2019 21:18:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2B1DD16C63D3; Wed,  9 Jan 2019 13:18:30 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:18:30 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/12] RCU flavor consolidation cleanups for v5.1
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010921-0072-0000-0000-000003E73CC1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00595707; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0073-0000-0000-00004ABF64D1
Message-Id: <20190109211830.GA30595@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=831 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains additional cleanups for RCU flavor consolidation:

1-2.	Replace scheduler _sched() APIs with _rcu() counterparts.

3.	Renaming and commenting changes due to only one rcuo kthread
	per CPU.

4.	Make expedited IPI handler return after handling critical section.
	This is a maintainability and performance change.

5.	Inline force_quiescent_state() into rcu_force_quiescent_state().

6.	Eliminate RCU_BH_FLAVOR and RCU_SCHED_FLAVOR.

7.	Inline rcu_kthread_do_work() into its sole remaining caller.

8.	Determine expedited-GP IPI handler at build time.

9.	Consolidate PREEMPT and !PREEMPT synchronize_rcu_expedited().

10.	Consolidate PREEMPT and !PREEMPT synchronize_rcu().

11.	Inline _synchronize_rcu_expedited() into synchronize_rcu_expedited().

12.	Discard separate per-CPU callback counts.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Expedited-Grace-Periods/ExpSchedFlow.svg             |   18 
 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html |   26 -
 Documentation/RCU/stallwarn.txt                                               |   15 
 kernel/rcu/rcu.h                                                              |    2 
 kernel/rcu/tree.c                                                             |  123 +++--
 kernel/rcu/tree.h                                                             |    9 
 kernel/rcu/tree_exp.h                                                         |  244 ++++------
 kernel/rcu/tree_plugin.h                                                      |  129 -----
 kernel/sched/cpufreq.c                                                        |    4 
 kernel/sched/cpufreq_schedutil.c                                              |    2 
 kernel/sched/sched.h                                                          |    2 
 kernel/sched/topology.c                                                       |    4 
 12 files changed, 237 insertions(+), 341 deletions(-)

