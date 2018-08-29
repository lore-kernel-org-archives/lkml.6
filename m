Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C11C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E3220644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E3220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeH3Cx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727574AbeH3CxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs2Fj047513
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:16 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64f00ckb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:16 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:15 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs8Ki25165956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7ED2B2068;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C00C2B2066;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BDE5116C2B70; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 21/24] rcu: Clean up flavor-related definitions and comments in update.c
Date:   Wed, 29 Aug 2018 15:54:02 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-00000467593D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860735;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E731C
Message-Id: <20180829225405.7275-21-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/update.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index ee366faecea6..fa089ead4bd6 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -332,7 +332,7 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 	int i;
 	int j;
 
-	/* Initialize and register callbacks for each flavor specified. */
+	/* Initialize and register callbacks for each crcu_array element. */
 	for (i = 0; i < n; i++) {
 		if (checktiny &&
 		    (crcu_array[i] == call_rcu ||
@@ -697,19 +697,19 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/*
 		 * Wait for all pre-existing t->on_rq and t->nvcsw
-		 * transitions to complete.  Invoking synchronize_sched()
+		 * transitions to complete.  Invoking synchronize_rcu()
 		 * suffices because all these transitions occur with
-		 * interrupts disabled.  Without this synchronize_sched(),
+		 * interrupts disabled.  Without this synchronize_rcu(),
 		 * a read-side critical section that started before the
 		 * grace period might be incorrectly seen as having started
 		 * after the grace period.
 		 *
-		 * This synchronize_sched() also dispenses with the
+		 * This synchronize_rcu() also dispenses with the
 		 * need for a memory barrier on the first store to
 		 * ->rcu_tasks_holdout, as it forces the store to happen
 		 * after the beginning of the grace period.
 		 */
-		synchronize_sched();
+		synchronize_rcu();
 
 		/*
 		 * There were callbacks, so we need to wait for an
@@ -736,7 +736,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 * This does only part of the job, ensuring that all
 		 * tasks that were previously exiting reach the point
 		 * where they have disabled preemption, allowing the
-		 * later synchronize_sched() to finish the job.
+		 * later synchronize_rcu() to finish the job.
 		 */
 		synchronize_srcu(&tasks_rcu_exit_srcu);
 
@@ -786,20 +786,20 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 * cause their RCU-tasks read-side critical sections to
 		 * extend past the end of the grace period.  However,
 		 * because these ->nvcsw updates are carried out with
-		 * interrupts disabled, we can use synchronize_sched()
+		 * interrupts disabled, we can use synchronize_rcu()
 		 * to force the needed ordering on all such CPUs.
 		 *
-		 * This synchronize_sched() also confines all
+		 * This synchronize_rcu() also confines all
 		 * ->rcu_tasks_holdout accesses to be within the grace
 		 * period, avoiding the need for memory barriers for
 		 * ->rcu_tasks_holdout accesses.
 		 *
-		 * In addition, this synchronize_sched() waits for exiting
+		 * In addition, this synchronize_rcu() waits for exiting
 		 * tasks to complete their final preempt_disable() region
 		 * of execution, cleaning up after the synchronize_srcu()
 		 * above.
 		 */
-		synchronize_sched();
+		synchronize_rcu();
 
 		/* Invoke the callbacks. */
 		while (list) {
-- 
2.17.1

