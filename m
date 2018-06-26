Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6010C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E53326319
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E53326319
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935224AbeFZAKd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:10:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934558AbeFZAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04di0126797
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96uatjt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:02 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06viR19005800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6439B205F;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F6B0B2064;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 91B8816CA097; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 29/40] doc: Update data-structure documentation for ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:48 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0068-0000-0000-0000030E1829
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0069-0000-0000-000044CF089B
Message-Id: <20180626000859.23572-29-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../Data-Structures/Data-Structures.html      | 118 ++++++++++--------
 1 file changed, 63 insertions(+), 55 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 6c06e10bd04b..f5120a00f511 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -380,31 +380,26 @@ and therefore need no protection.
 as follows:
 
 <pre>
-  1   unsigned long gpnum;
-  2   unsigned long completed;
+  1   unsigned long gp_seq;
 </pre>
 
 <p>RCU grace periods are numbered, and
-the <tt>-&gt;gpnum</tt> field contains the number of the grace
-period that started most recently.
-The <tt>-&gt;completed</tt> field contains the number of the
-grace period that completed most recently.
-If the two fields are equal, the RCU grace period that most recently
-started has already completed, and therefore the corresponding
-flavor of RCU is idle.
-If <tt>-&gt;gpnum</tt> is one greater than <tt>-&gt;completed</tt>,
-then <tt>-&gt;gpnum</tt> gives the number of the current RCU
-grace period, which has not yet completed.
-Any other combination of values indicates that something is broken.
-These two fields are protected by the root <tt>rcu_node</tt>'s
+the <tt>-&gt;gp_seq</tt> field contains the current grace-period
+sequence number.
+The bottom two bits are the state of the current grace period,
+which can be zero for not yet started or one for in progress.
+In other words, if the bottom two bits of <tt>-&gt;gp_seq</tt> are
+zero, the corresponding flavor of RCU is idle.
+Any other value in the bottom two bits indicates that something is broken.
+This field is protected by the root <tt>rcu_node</tt> structure's
 <tt>-&gt;lock</tt> field.
 
-</p><p>There are <tt>-&gt;gpnum</tt> and <tt>-&gt;completed</tt> fields
+</p><p>There are <tt>-&gt;gp_seq</tt> fields
 in the <tt>rcu_node</tt> and <tt>rcu_data</tt> structures
 as well.
 The fields in the <tt>rcu_state</tt> structure represent the
-most current values, and those of the other structures are compared
-in order to detect the start of a new grace period in a distributed
+most current value, and those of the other structures are compared
+in order to detect the beginnings and ends of grace periods in a distributed
 fashion.
 The values flow from <tt>rcu_state</tt> to <tt>rcu_node</tt>
 (down the tree from the root to the leaves) to <tt>rcu_data</tt>.
@@ -512,27 +507,47 @@ than to be heisenbugged out of existence.
 as follows:
 
 <pre>
-  1   unsigned long gpnum;
-  2   unsigned long completed;
+  1   unsigned long gp_seq;
+  2   unsigned long gp_seq_needed;
 </pre>
 
-<p>These fields are the counterparts of the fields of the same name in
-the <tt>rcu_state</tt> structure.
-They each may lag up to one behind their <tt>rcu_state</tt>
-counterparts.
-If a given <tt>rcu_node</tt> structure's <tt>-&gt;gpnum</tt> and
-<tt>-&gt;complete</tt> fields are equal, then this <tt>rcu_node</tt>
+<p>The <tt>rcu_node</tt> structures' <tt>-&gt;gp_seq</tt> fields are
+the counterparts of the field of the same name in the <tt>rcu_state</tt>
+structure.
+They each may lag up to one step behind their <tt>rcu_state</tt>
+counterpart.
+If the bottom two bits of a given <tt>rcu_node</tt> structure's
+<tt>-&gt;gp_seq</tt> field is zero, then this <tt>rcu_node</tt>
 structure believes that RCU is idle.
-Otherwise, as with the <tt>rcu_state</tt> structure,
-the <tt>-&gt;gpnum</tt> field will be one greater than the
-<tt>-&gt;complete</tt> fields, with <tt>-&gt;gpnum</tt>
-indicating which grace period this <tt>rcu_node</tt> believes
-is still being waited for.
+</p><p>The <tt>&gt;gp_seq</tt> field of each <tt>rcu_node</tt>
+structure is updated at the beginning and the end
+of each grace period.
+
+<p>The <tt>-&gt;gp_seq_needed</tt> fields record the
+furthest-in-the-future grace period request seen by the corresponding
+<tt>rcu_node</tt> structure.  The request is considered fulfilled when
+the value of the <tt>-&gt;gp_seq</tt> field equals or exceeds that of
+the <tt>-&gt;gp_seq_needed</tt> field.
 
-</p><p>The <tt>&gt;gpnum</tt> field of each <tt>rcu_node</tt>
-structure is updated at the beginning
-of each grace period, and the <tt>-&gt;completed</tt> fields are
-updated at the end of each grace period.
+<table>
+<tr><th>&nbsp;</th></tr>
+<tr><th align="left">Quick Quiz:</th></tr>
+<tr><td>
+	Suppose that this <tt>rcu_node</tt> structure doesn't see
+	a request for a very long time.
+	Won't wrapping of the <tt>-&gt;gp_seq</tt> field cause
+	problems?
+</td></tr>
+<tr><th align="left">Answer:</th></tr>
+<tr><td bgcolor="#ffffff"><font color="ffffff">
+	No, because if the <tt>-&gt;gp_seq_needed</tt> field lags behind the
+	<tt>-&gt;gp_seq</tt> field, the <tt>-&gt;gp_seq_needed</tt> field
+	will be updated at the end of the grace period.
+	Modulo-arithmetic comparisons therefore will always get the
+	correct answer, even with wrapping.
+</font></td></tr>
+<tr><td>&nbsp;</td></tr>
+</table>
 
 <h5>Quiescent-State Tracking</h5>
 
@@ -626,9 +641,8 @@ normal and expedited grace periods, respectively.
 	</ol>
 
 	<p><font color="ffffff">So the locking is absolutely required in
-	order to coordinate
-	clearing of the bits with the grace-period numbers in
-	<tt>-&gt;gpnum</tt> and <tt>-&gt;completed</tt>.
+	order to coordinate clearing of the bits with updating of the
+	grace-period sequence number in <tt>-&gt;gp_seq</tt>.
 </font></td></tr>
 <tr><td>&nbsp;</td></tr>
 </table>
@@ -1038,15 +1052,15 @@ out any <tt>rcu_data</tt> structure for which this flag is not set.
 as follows:
 
 <pre>
-  1   unsigned long completed;
-  2   unsigned long gpnum;
+  1   unsigned long gp_seq;
+  2   unsigned long gp_seq_needed;
   3   bool cpu_no_qs;
   4   bool core_needs_qs;
   5   bool gpwrap;
   6   unsigned long rcu_qs_ctr_snap;
 </pre>
 
-<p>The <tt>completed</tt> and <tt>gpnum</tt>
+<p>The <tt>-&gt;gp_seq</tt> and <tt>-&gt;gp_seq_needed</tt>
 fields are the counterparts of the fields of the same name
 in the <tt>rcu_state</tt> and <tt>rcu_node</tt> structures.
 They may each lag up to one behind their <tt>rcu_node</tt>
@@ -1054,15 +1068,9 @@ counterparts, but in <tt>CONFIG_NO_HZ_IDLE</tt> and
 <tt>CONFIG_NO_HZ_FULL</tt> kernels can lag
 arbitrarily far behind for CPUs in dyntick-idle mode (but these counters
 will catch up upon exit from dyntick-idle mode).
-If a given <tt>rcu_data</tt> structure's <tt>-&gt;gpnum</tt> and
-<tt>-&gt;complete</tt> fields are equal, then this <tt>rcu_data</tt>
+If the lower two bits of a given <tt>rcu_data</tt> structure's
+<tt>-&gt;gp_seq</tt> are zero, then this <tt>rcu_data</tt>
 structure believes that RCU is idle.
-Otherwise, as with the <tt>rcu_state</tt> and <tt>rcu_node</tt>
-structure,
-the <tt>-&gt;gpnum</tt> field will be one greater than the
-<tt>-&gt;complete</tt> fields, with <tt>-&gt;gpnum</tt>
-indicating which grace period this <tt>rcu_data</tt> believes
-is still being waited for.
 
 <table>
 <tr><th>&nbsp;</th></tr>
@@ -1070,13 +1078,13 @@ is still being waited for.
 <tr><td>
 	All this replication of the grace period numbers can only cause
 	massive confusion.
-	Why not just keep a global pair of counters and be done with it???
+	Why not just keep a global sequence number and be done with it???
 </td></tr>
 <tr><th align="left">Answer:</th></tr>
 <tr><td bgcolor="#ffffff"><font color="ffffff">
-	Because if there was only a single global pair of grace-period
+	Because if there was only a single global sequence
 	numbers, there would need to be a single global lock to allow
-	safely accessing and updating them.
+	safely accessing and updating it.
 	And if we are not going to have a single global lock, we need
 	to carefully manage the numbers on a per-node basis.
 	Recall from the answer to a previous Quick Quiz that the consequences
@@ -1091,8 +1099,8 @@ CPU has not yet passed through a quiescent state,
 while the <tt>-&gt;core_needs_qs</tt> flag indicates that the
 RCU core needs a quiescent state from the corresponding CPU.
 The <tt>-&gt;gpwrap</tt> field indicates that the corresponding
-CPU has remained idle for so long that the <tt>completed</tt>
-and <tt>gpnum</tt> counters are in danger of overflow, which
+CPU has remained idle for so long that the
+<tt>gp_seq</tt> counter is in danger of overflow, which
 will cause the CPU to disregard the values of its counters on
 its next exit from idle.
 Finally, the <tt>rcu_qs_ctr_snap</tt> field is used to detect
@@ -1130,10 +1138,10 @@ The CPU advances the callbacks in its <tt>rcu_data</tt> structure
 whenever it notices that another RCU grace period has completed.
 The CPU detects the completion of an RCU grace period by noticing
 that the value of its <tt>rcu_data</tt> structure's
-<tt>-&gt;completed</tt> field differs from that of its leaf
+<tt>-&gt;gp_seq</tt> field differs from that of its leaf
 <tt>rcu_node</tt> structure.
 Recall that each <tt>rcu_node</tt> structure's
-<tt>-&gt;completed</tt> field is updated at the end of each
+<tt>-&gt;gp_seq</tt> field is updated at the beginnings and ends of each
 grace period.
 
 <p>
-- 
2.17.1

