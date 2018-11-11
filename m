Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA173C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC4C20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC4C20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeKLFqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:46:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727540AbeKLFqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:46:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs4Z1134115
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:54 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdbght3f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:54 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:53 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJulVk36962430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B61FCB2064;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F3B4B205F;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3AC9316C5DA9; Sun, 11 Nov 2018 11:56:47 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 16/20] doc: Remove obsolete (non-)requirement about disabling preemption
Date:   Sun, 11 Nov 2018 11:56:41 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111195619.GA6958@linux.ibm.com>
References: <20181111195619.GA6958@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0052-0000-0000-0000035422DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00578735; IPR=6.00896124;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0053-0000-0000-00005EBB257C
Message-Id: <20181111195645.9205-16-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The Requirements.html document says "Disabling Preemption Does
Not Block Grace Periods".  However this is no longer true with
the RCU consolidation.  This commit therefore removes the obsolete
(non-)requirement entirely.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../RCU/Design/Requirements/Requirements.html | 50 -------------------
 1 file changed, 50 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 7efc1c1da7af..4fae55056c1d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -900,8 +900,6 @@ Except where otherwise noted, these non-guarantees were premeditated.
 	Grace Periods Don't Partition Read-Side Critical Sections</a>
 <li>	<a href="#Read-Side Critical Sections Don't Partition Grace Periods">
 	Read-Side Critical Sections Don't Partition Grace Periods</a>
-<li>	<a href="#Disabling Preemption Does Not Block Grace Periods">
-	Disabling Preemption Does Not Block Grace Periods</a>
 </ol>
 
 <h3><a name="Readers Impose Minimal Ordering">Readers Impose Minimal Ordering</a></h3>
@@ -1259,54 +1257,6 @@ of RCU grace periods.
 <tr><td>&nbsp;</td></tr>
 </table>
 
-<h3><a name="Disabling Preemption Does Not Block Grace Periods">
-Disabling Preemption Does Not Block Grace Periods</a></h3>
-
-<p>
-There was a time when disabling preemption on any given CPU would block
-subsequent grace periods.
-However, this was an accident of implementation and is not a requirement.
-And in the current Linux-kernel implementation, disabling preemption
-on a given CPU in fact does not block grace periods, as Oleg Nesterov
-<a href="https://lkml.kernel.org/g/20150614193825.GA19582@redhat.com">demonstrated</a>.
-
-<p>
-If you need a preempt-disable region to block grace periods, you need to add
-<tt>rcu_read_lock()</tt> and <tt>rcu_read_unlock()</tt>, for example
-as follows:
-
-<blockquote>
-<pre>
- 1 preempt_disable();
- 2 rcu_read_lock();
- 3 do_something();
- 4 rcu_read_unlock();
- 5 preempt_enable();
- 6
- 7 /* Spinlocks implicitly disable preemption. */
- 8 spin_lock(&amp;mylock);
- 9 rcu_read_lock();
-10 do_something();
-11 rcu_read_unlock();
-12 spin_unlock(&amp;mylock);
-</pre>
-</blockquote>
-
-<p>
-In theory, you could enter the RCU read-side critical section first,
-but it is more efficient to keep the entire RCU read-side critical
-section contained in the preempt-disable region as shown above.
-Of course, RCU read-side critical sections that extend outside of
-preempt-disable regions will work correctly, but such critical sections
-can be preempted, which forces <tt>rcu_read_unlock()</tt> to do
-more work.
-And no, this is <i>not</i> an invitation to enclose all of your RCU
-read-side critical sections within preempt-disable regions, because
-doing so would degrade real-time response.
-
-<p>
-This non-requirement appeared with preemptible RCU.
-
 <h2><a name="Parallelism Facts of Life">Parallelism Facts of Life</a></h2>
 
 <p>
-- 
2.17.1

