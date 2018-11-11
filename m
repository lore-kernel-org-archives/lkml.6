Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942DEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628A620871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628A620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeKLFqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:46:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbeKLFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:46:20 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJs6II055473
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdbnt2hp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:56:52 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:56:51 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:56:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJukEZ19005492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:56:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18FAB2066;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E5B9B2067;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:56:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3563516C5DA8; Sun, 11 Nov 2018 11:56:47 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        tytso@mit.edu, "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 15/20] doc: Make reader aware of rcu_dereference_protected
Date:   Sun, 11 Nov 2018 11:56:40 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111195619.GA6958@linux.ibm.com>
References: <20181111195619.GA6958@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0072-0000-0000-000003C6F415
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116023; UDB=6.00577118; IPR=6.00896124;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:56:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0073-0000-0000-00004A134C0C
Message-Id: <20181111195645.9205-15-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The whatisRCU.txt document says rcu_dereference() cannot be used
outside of rcu_read_lock() protected sections.  The commit adds a
mention of rcu_dereference_protected(), so that the new reader knows
that this API can be used to avoid update-side use of rcu_read_lock()
and rcu_read_unlock().

Cc: tytso@mit.edu
Suggested-by: tytso@mit.edu
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Update wording, including further feedback from Joel. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/whatisRCU.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 7c33445fd0e5..4a6854318b17 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -266,7 +266,7 @@ rcu_dereference()
 	unnecessary overhead on Alpha CPUs.
 
 	Note that the value returned by rcu_dereference() is valid
-	only within the enclosing RCU read-side critical section.
+	only within the enclosing RCU read-side critical section [1].
 	For example, the following is -not- legal:
 
 		rcu_read_lock();
@@ -292,6 +292,19 @@ rcu_dereference()
 	typically used indirectly, via the _rcu list-manipulation
 	primitives, such as list_for_each_entry_rcu().
 
+	[1] The variant rcu_dereference_protected() can be used outside
+	of an RCU read-side critical section as long as the usage is
+	protected by locks acquired by the update-side code.  This variant
+	avoids the lockdep warning that would happen when using (for
+	example) rcu_dereference() without rcu_read_lock() protection.
+	Using rcu_dereference_protected() also has the advantage
+	of permitting compiler optimizations that rcu_dereference()
+	must prohibit.	The rcu_dereference_protected() variant takes
+	a lockdep expression to indicate which locks must be acquired
+	by the caller. If the indicated protection is not provided,
+	a lockdep splat is emitted.  See RCU/Design/Requirements.html
+	and the API's code comments for more details and example usage.
+
 The following diagram shows how each API communicates among the
 reader, updater, and reclaimer.
 
-- 
2.17.1

