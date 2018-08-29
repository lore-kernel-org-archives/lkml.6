Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88254C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F3E20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F3E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH3Cwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:52:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727316AbeH3Cwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:52:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMnDnT124485
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:53:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m615dfkqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:53:46 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:53:45 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:53:41 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMreDW3604884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:53:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4719EB206A;
        Wed, 29 Aug 2018 18:52:36 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2610CB2067;
        Wed, 29 Aug 2018 18:52:36 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:52:36 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9BCFB16C91B7; Wed, 29 Aug 2018 15:53:40 -0700 (PDT)
Date:   Wed, 29 Aug 2018 15:53:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/24] Additional RCU-consolidation cleanups for
 v4.20/v5.0
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082922-2213-0000-0000-000002E509D4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:53:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-2214-0000-0000-00005B6033AC
Message-Id: <20180829225340.GA7019@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains yet more cleanups for RCU flavor consolidation:

1.	Inline the now-trivial increment_cpu_stall_ticks() into its sole
	caller.

2.	Pull the rcu_gp_kthread() function's force-quiescent-state loop
	into a separate function

3.	Consolidate RCU-bh update-side function definitions, putting
	them all in one place at the end of rcupdate.h.

4.	Consolidate RCU-sched update-side function definitions, putting
	them all in one place at the end of rcupdate.h.

5.	Add RCU-bh and RCU-sched support for extended readers, so that
	rcutorture will mix and match all RCU read-side primitives.

6.	Stop testing RCU-bh and RCU-sched.

7-8.	Remove the "rcu_bh" and "sched" torture types.

9.	Remove now-unused rcutorture APIs.

10-21.	Clean up flavor-related definitions and comments.

22.	Remove !PREEMPT code from rcu_note_voluntary_context_switch(),
	since it now has meaning only in PREEMPT kernels.

23.	Define rcu_all_qs() only in !PREEMPT builds, since that is
	now the only place it is used.

24.	Inline _rcu_barrier() into its sole remaining caller.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt            |    6 
 include/linux/rculist.h                                    |   32 -
 include/linux/rcupdate.h                                   |  100 ++-
 include/linux/rcupdate_wait.h                              |   14 
 include/linux/rcutiny.h                                    |   47 -
 include/linux/rcutree.h                                    |   28 
 include/trace/events/rcu.h                                 |   20 
 kernel/rcu/Kconfig                                         |   20 
 kernel/rcu/rcu.h                                           |   28 
 kernel/rcu/rcuperf.c                                       |   65 --
 kernel/rcu/rcutorture.c                                    |  125 ---
 kernel/rcu/srcutree.c                                      |    2 
 kernel/rcu/tiny.c                                          |   10 
 kernel/rcu/tree.c                                          |  414 +++----------
 kernel/rcu/tree.h                                          |    5 
 kernel/rcu/tree_exp.h                                      |   22 
 kernel/rcu/tree_plugin.h                                   |   83 +-
 kernel/rcu/update.c                                        |   58 -
 tools/testing/selftests/rcutorture/configs/rcu/TINY02.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE06.boot |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot |    2 
 24 files changed, 366 insertions(+), 725 deletions(-)

