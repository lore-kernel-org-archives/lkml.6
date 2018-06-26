Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7174CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3182124143
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3182124143
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932127AbeFZRIw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:08:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752356AbeFZRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4MdE027316
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jup7c1v6v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:50 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:49 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8iuD8716706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1CA8B206C;
        Tue, 26 Jun 2018 13:08:37 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5CCBB2067;
        Tue, 26 Jun 2018 13:08:37 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:37 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 900D416C377B; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/22] rcu: Fix an obsolete ->qsmaskinit comment
Date:   Tue, 26 Jun 2018 10:10:28 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0064-0000-0000-00000320971C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539668; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0065-0000-0000-000039B968C4
Message-Id: <20180626171048.2181-2-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=939 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in the old days, when grace-period initialization blocked CPU
hotplug, the ->qsmaskinit mask was indeed updated at the time that
a given CPU went offline.  However, with the deferral of these updates
until the beginning of the next grace period in commit 0aa04b055e71
("rcu: Process offlining and onlining only at grace-period start"),
it is instead ->qsmaskinitnext that gets updated at that time.

This commit therefore updates the obsolete comment.  It also fixes
punctuation while on the topic of comments mentioning ->qsmaskinit.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bde895507335..d6a3efea5cdd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2438,7 +2438,7 @@ static void rcu_cleanup_dying_cpu(struct rcu_state *rsp)
  * This function therefore goes up the tree of rcu_node structures,
  * clearing the corresponding bits in the ->qsmaskinit fields.  Note that
  * the leaf rcu_node structure's ->qsmaskinit field has already been
- * updated
+ * updated.
  *
  * This function does check that the specified rcu_node structure has
  * all CPUs offline and no blocked tasks, so it is OK to invoke it
@@ -3707,7 +3707,7 @@ void rcu_cpu_starting(unsigned int cpu)
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * The CPU is exiting the idle loop into the arch_cpu_idle_dead()
- * function.  We now remove it from the rcu_node tree's ->qsmaskinit
+ * function.  We now remove it from the rcu_node tree's ->qsmaskinitnext
  * bit masks.
  */
 static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
-- 
2.17.1

