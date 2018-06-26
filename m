Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB51F25C26
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB51F25C26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935078AbeFZAeR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:34:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755131AbeFZAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:33:18 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0Sc4m048659
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:17 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96qkch6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:17 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:33:15 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:33:11 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0XA5P19071278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:33:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47C88B2065;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F2BBB206B;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 469CE16CA095; Mon, 25 Jun 2018 17:35:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        NeilBrown <neilb@suse.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 26/27] rculist: Improve documentation for list_for_each_entry_from_rcu()
Date:   Mon, 25 Jun 2018 17:35:12 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626003448.GA26209@linux.vnet.ibm.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0052-0000-0000-00000304097F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539469; IPR=6.00830262;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:33:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0053-0000-0000-00005D23DD91
Message-Id: <20180626003513.27812-26-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>

Unfortunately the patch for adding list_for_each_entry_from_rcu()
wasn't the final patch after all review.  It is functionally
correct but the documentation was incomplete.

This patch adds this missing documentation which includes an update to
the documentation for list_for_each_entry_continue_rcu() to match the
documentation for the new list_for_each_entry_from_rcu(), and adds
list_for_each_entry_from_rcu() and the already existing
hlist_for_each_entry_from_rcu() to section 7 of whatisRCU.txt.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/RCU/whatisRCU.txt |  2 ++
 include/linux/rculist.h         | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 94288f1b8759..c2a7facf7ff9 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -820,11 +820,13 @@ RCU list traversal:
 	list_next_rcu
 	list_for_each_entry_rcu
 	list_for_each_entry_continue_rcu
+	list_for_each_entry_from_rcu
 	hlist_first_rcu
 	hlist_next_rcu
 	hlist_pprev_rcu
 	hlist_for_each_entry_rcu
 	hlist_for_each_entry_rcu_bh
+	hlist_for_each_entry_from_rcu
 	hlist_for_each_entry_continue_rcu
 	hlist_for_each_entry_continue_rcu_bh
 	hlist_nulls_first_rcu
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 36df6ccbc874..4786c2235b98 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -396,7 +396,16 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * @member:	the name of the list_head within the struct.
  *
  * Continue to iterate over list of given type, continuing after
- * the current position.
+ * the current position which must have been in the list when the RCU read
+ * lock was taken.
+ * This would typically require either that you obtained the node from a
+ * previous walk of the list in the same RCU read-side critical section, or
+ * that you held some sort of non-RCU reference (such as a reference count)
+ * to keep the node alive *and* in the list.
+ *
+ * This iterator is similar to list_for_each_entry_from_rcu() except
+ * this starts after the given position and that one starts at the given
+ * position.
  */
 #define list_for_each_entry_continue_rcu(pos, head, member) 		\
 	for (pos = list_entry_rcu(pos->member.next, typeof(*pos), member); \
@@ -411,6 +420,14 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  *
  * Iterate over the tail of a list starting from a given position,
  * which must have been in the list when the RCU read lock was taken.
+ * This would typically require either that you obtained the node from a
+ * previous walk of the list in the same RCU read-side critical section, or
+ * that you held some sort of non-RCU reference (such as a reference count)
+ * to keep the node alive *and* in the list.
+ *
+ * This iterator is similar to list_for_each_entry_continue_rcu() except
+ * this starts from the given position and that one starts from the position
+ * after the given position.
  */
 #define list_for_each_entry_from_rcu(pos, head, member)			\
 	for (; &(pos)->member != (head);					\
-- 
2.17.1

