Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ADEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A860420644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A860420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeH3Cx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727394AbeH3CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMsBnH000586
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r18mqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:13 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs8Uu27852960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87323B2064;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56D67B2065;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8683D16C91D2; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 11/24] rcu: Clean up flavor-related definitions and comments in rculist.h
Date:   Wed, 29 Aug 2018 15:53:52 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-0000032821BD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE60101
Message-Id: <20180829225405.7275-11-paulmck@linux.vnet.ibm.com>
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
 include/linux/rculist.h | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4786c2235b98..e91ec9ddcd30 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -182,7 +182,7 @@ static inline void list_replace_rcu(struct list_head *old,
  * @list:	the RCU-protected list to splice
  * @prev:	points to the last element of the existing list
  * @next:	points to the first element of the existing list
- * @sync:	function to sync: synchronize_rcu(), synchronize_sched(), ...
+ * @sync:	synchronize_rcu, synchronize_rcu_expedited, ...
  *
  * The list pointed to by @prev and @next can be RCU-read traversed
  * concurrently with this function.
@@ -240,7 +240,7 @@ static inline void __list_splice_init_rcu(struct list_head *list,
  *                        designed for stacks.
  * @list:	the RCU-protected list to splice
  * @head:	the place in the existing list to splice the first list into
- * @sync:	function to sync: synchronize_rcu(), synchronize_sched(), ...
+ * @sync:	synchronize_rcu, synchronize_rcu_expedited, ...
  */
 static inline void list_splice_init_rcu(struct list_head *list,
 					struct list_head *head,
@@ -255,7 +255,7 @@ static inline void list_splice_init_rcu(struct list_head *list,
  *                             list, designed for queues.
  * @list:	the RCU-protected list to splice
  * @head:	the place in the existing list to splice the first list into
- * @sync:	function to sync: synchronize_rcu(), synchronize_sched(), ...
+ * @sync:	synchronize_rcu, synchronize_rcu_expedited, ...
  */
 static inline void list_splice_tail_init_rcu(struct list_head *list,
 					     struct list_head *head,
@@ -359,13 +359,12 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @type:       the type of the struct this is embedded in.
  * @member:     the name of the list_head within the struct.
  *
- * This primitive may safely run concurrently with the _rcu list-mutation
- * primitives such as list_add_rcu(), but requires some implicit RCU
- * read-side guarding.  One example is running within a special
- * exception-time environment where preemption is disabled and where
- * lockdep cannot be invoked (in which case updaters must use RCU-sched,
- * as in synchronize_sched(), call_rcu_sched(), and friends).  Another
- * example is when items are added to the list, but never deleted.
+ * This primitive may safely run concurrently with the _rcu
+ * list-mutation primitives such as list_add_rcu(), but requires some
+ * implicit RCU read-side guarding.  One example is running within a special
+ * exception-time environment where preemption is disabled and where lockdep
+ * cannot be invoked.  Another example is when items are added to the list,
+ * but never deleted.
  */
 #define list_entry_lockless(ptr, type, member) \
 	container_of((typeof(ptr))READ_ONCE(ptr), type, member)
@@ -376,13 +375,12 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @head:	the head for your list.
  * @member:	the name of the list_struct within the struct.
  *
- * This primitive may safely run concurrently with the _rcu list-mutation
- * primitives such as list_add_rcu(), but requires some implicit RCU
- * read-side guarding.  One example is running within a special
- * exception-time environment where preemption is disabled and where
- * lockdep cannot be invoked (in which case updaters must use RCU-sched,
- * as in synchronize_sched(), call_rcu_sched(), and friends).  Another
- * example is when items are added to the list, but never deleted.
+ * This primitive may safely run concurrently with the _rcu
+ * list-mutation primitives such as list_add_rcu(), but requires some
+ * implicit RCU read-side guarding.  One example is running within a special
+ * exception-time environment where preemption is disabled and where lockdep
+ * cannot be invoked.  Another example is when items are added to the list,
+ * but never deleted.
  */
 #define list_for_each_entry_lockless(pos, head, member) \
 	for (pos = list_entry_lockless((head)->next, typeof(*pos), member); \
-- 
2.17.1

