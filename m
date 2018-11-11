Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD5B214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD5B214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeKLFqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:46:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728760AbeKLFqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:46:23 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs4Qv112471
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:55 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npd3sapve-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:54 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:53 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJulOq25297114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B0BAB2068;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 341F0B2065;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0A5A916C5DA0; Sun, 11 Nov 2018 11:56:47 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kernel-team@android.com,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 07/20] doc: rcu: Better clarify the rcu_segcblist ->len field
Date:   Sun, 11 Nov 2018 11:56:32 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111195619.GA6958@linux.ibm.com>
References: <20181111195619.GA6958@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-2213-0000-0000-00000315A871
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00578735; IPR=6.00896124;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-2214-0000-0000-00005C386F94
Message-Id: <20181111195645.9205-7-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=905 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

An important note under the rcu_segcblist description could use a more
detailed description. Especially explanation of the scenario where the
->head field may be temporarily NULL making it not wise to rely on it
to determine if callbacks are associated with the rcu_segcblist.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: <kernel-team@android.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../Data-Structures/Data-Structures.html      | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 28b241074c86..3ed5f0182bc4 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -928,17 +928,24 @@ this <tt>rcu_segcblist</tt> structure, <i>not</i> the <tt>-&gt;head</tt>
 pointer.
 The reason for this is that all the ready-to-invoke callbacks
 (that is, those in the <tt>RCU_DONE_TAIL</tt> segment) are extracted
-all at once at callback-invocation time.
+all at once at callback-invocation time (<tt>rcu_do_batch</tt>), due
+to which <tt>-&gt;head</tt> may be set to NULL if there are no not-done
+callbacks remaining in the <tt>rcu_segcblist</tt>.
 If callback invocation must be postponed, for example, because a
 high-priority process just woke up on this CPU, then the remaining
-callbacks are placed back on the <tt>RCU_DONE_TAIL</tt> segment.
-Either way, the <tt>-&gt;len</tt> and <tt>-&gt;len_lazy</tt> counts
-are adjusted after the corresponding callbacks have been invoked, and so
-again it is the <tt>-&gt;len</tt> count that accurately reflects whether
-or not there are callbacks associated with this <tt>rcu_segcblist</tt>
-structure.
+callbacks are placed back on the <tt>RCU_DONE_TAIL</tt> segment and
+<tt>-&gt;head</tt> once again points to the start of the segment.
+In short, the head field can briefly be <tt>NULL</tt> even though the
+CPU has callbacks present the entire time.
+Therefore, it is not appropriate to test the <tt>-&gt;head</tt> pointer
+for <tt>NULL</tt>.
+
+<p>In contrast, the <tt>-&gt;len</tt> and <tt>-&gt;len_lazy</tt> counts
+are adjusted only after the corresponding callbacks have been invoked.
+This means that the <tt>-&gt;len</tt> count is zero only if
+the <tt>rcu_segcblist</tt> structure really is devoid of callbacks.
 Of course, off-CPU sampling of the <tt>-&gt;len</tt> count requires
-the use of appropriate synchronization, for example, memory barriers.
+careful use of appropriate synchronization, for example, memory barriers.
 This synchronization can be a bit subtle, particularly in the case
 of <tt>rcu_barrier()</tt>.
 
-- 
2.17.1

