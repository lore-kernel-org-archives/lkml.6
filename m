Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBB426372
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBB426372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934945AbeFZAh5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:37:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934562AbeFZAdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:33:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0Sf9L048047
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96r3fae-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:33:16 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:33:15 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:33:11 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0XAx514221688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:33:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 329A1B2064;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DFA6B2068;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:33:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2870A16CA0A1; Mon, 25 Jun 2018 17:35:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH tip/core/rcu 21/27] doc: Update synchronize_rcu() definition in whatisRCU.txt
Date:   Mon, 25 Jun 2018 17:35:07 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626003448.GA26209@linux.vnet.ibm.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0052-0000-0000-000003040980
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052336; UDB=6.00539469; IPR=6.00830262;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:33:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0053-0000-0000-00005D23DD90
Message-Id: <20180626003513.27812-21-paulmck@linux.vnet.ibm.com>
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

From: Andrea Parri <andrea.parri@amarulasolutions.com>

The synchronize_rcu() definition based on RW-locks in whatisRCU.txt
does not meet the "Memory-Barrier Guarantees" in Requirements.html;
for example, the following SB-like test:

    P0:                      P1:

    WRITE_ONCE(x, 1);        WRITE_ONCE(y, 1);
    synchronize_rcu();       smp_mb();
    r0 = READ_ONCE(y);       r1 = READ_ONCE(x);

should not be allowed to reach the state "r0 = 0 AND r1 = 0", but
the current write_lock()+write_unlock() definition can not ensure
this.  This commit therefore inserts an smp_mb__after_spinlock()
in order to cause this synchronize_rcu() implementation to provide
this memory-barrier guarantee.

Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/RCU/whatisRCU.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 65eb856526b7..94288f1b8759 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -588,6 +588,7 @@ It is extremely simple:
 	void synchronize_rcu(void)
 	{
 		write_lock(&rcu_gp_mutex);
+		smp_mb__after_spinlock();
 		write_unlock(&rcu_gp_mutex);
 	}
 
@@ -609,12 +610,15 @@ don't forget about them when submitting patches making use of RCU!]
 
 The rcu_read_lock() and rcu_read_unlock() primitive read-acquire
 and release a global reader-writer lock.  The synchronize_rcu()
-primitive write-acquires this same lock, then immediately releases
-it.  This means that once synchronize_rcu() exits, all RCU read-side
-critical sections that were in progress before synchronize_rcu() was
-called are guaranteed to have completed -- there is no way that
-synchronize_rcu() would have been able to write-acquire the lock
-otherwise.
+primitive write-acquires this same lock, then releases it.  This means
+that once synchronize_rcu() exits, all RCU read-side critical sections
+that were in progress before synchronize_rcu() was called are guaranteed
+to have completed -- there is no way that synchronize_rcu() would have
+been able to write-acquire the lock otherwise.  The smp_mb__after_spinlock()
+promotes synchronize_rcu() to a full memory barrier in compliance with
+the "Memory-Barrier Guarantees" listed in:
+
+	Documentation/RCU/Design/Requirements/Requirements.html.
 
 It is possible to nest rcu_read_lock(), since reader-writer locks may
 be recursively acquired.  Note also that rcu_read_lock() is immune
-- 
2.17.1

