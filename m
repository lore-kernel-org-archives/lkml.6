Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C3820685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfAIVhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:37:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbfAIVhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:37:45 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LSZoi009754
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:37:44 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwpxh5q7g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:37:44 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:37:43 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:37:38 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LbbVU24510638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:37:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28311B2065;
        Wed,  9 Jan 2019 21:37:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0843CB205F;
        Wed,  9 Jan 2019 21:37:37 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:37:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CB18716C63D3; Wed,  9 Jan 2019 13:37:36 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/3] doc: Now jiffies_till_sched_qs solicits help from cond_resched()
Date:   Wed,  9 Jan 2019 13:37:33 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109213302.GA1723@linux.ibm.com>
References: <20190109213302.GA1723@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0072-0000-0000-000003E73E46
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144148; UDB=6.00595710; IPR=6.00924410;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:37:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0073-0000-0000-00004ABF6EAB
Message-Id: <20190109213735.3405-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcutree.jiffies_till_sched_qs kernel boot parameter used to solicit
help only from rcu_note_context_switch(), but now also solicits help
from cond_resched().  This commit therefore updates kernel-parameters.txt
accordingly.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..4974966451e2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3654,19 +3654,6 @@
 			latencies, which will choose a value aligned
 			with the appropriate hardware boundaries.
 
-	rcutree.jiffies_till_sched_qs= [KNL]
-			Set required age in jiffies for a
-			given grace period before RCU starts
-			soliciting quiescent-state help from
-			rcu_note_context_switch().  If not specified, the
-			kernel will calculate a value based on the most
-			recent settings of rcutree.jiffies_till_first_fqs
-			and rcutree.jiffies_till_next_fqs.
-			This calculated value may be viewed in
-			rcutree.jiffies_to_sched_qs.  Any attempt to
-			set rcutree.jiffies_to_sched_qs will be
-			cheerfully overwritten.
-
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
@@ -3678,6 +3665,20 @@
 			quiescent states.  Units are jiffies, minimum
 			value is one, and maximum value is HZ.
 
+	rcutree.jiffies_till_sched_qs= [KNL]
+			Set required age in jiffies for a
+			given grace period before RCU starts
+			soliciting quiescent-state help from
+			rcu_note_context_switch() and cond_resched().
+			If not specified, the kernel will calculate
+			a value based on the most recent settings
+			of rcutree.jiffies_till_first_fqs
+			and rcutree.jiffies_till_next_fqs.
+			This calculated value may be viewed in
+			rcutree.jiffies_to_sched_qs.  Any attempt to set
+			rcutree.jiffies_to_sched_qs will be cheerfully
+			overwritten.
+
 	rcutree.kthread_prio= 	 [KNL,BOOT]
 			Set the SCHED_FIFO priority of the RCU per-CPU
 			kthreads (rcuc/N). This value is also used for
-- 
2.17.1

