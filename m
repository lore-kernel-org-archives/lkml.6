Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2B3C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E703E206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfAIVI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:08:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbfAIVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:07:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Kn2bU083482
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:07:57 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwq2x44mc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:07:56 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:56 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:07:51 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09L7oRF20119704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:07:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 426BDB2064;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22A5BB2066;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E5E7D16C63C3; Wed,  9 Jan 2019 13:07:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, willy@infradead.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 4/7] tools/memory-model: Update README for addition of SRCU
Date:   Wed,  9 Jan 2019 13:07:45 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0040-0000-0000-000004AF34BE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144138; UDB=6.00593882; IPR=6.00924400;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:07:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0041-0000-0000-000008BA3947
Message-Id: <20190109210748.29074-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates the section on LKMM limitations to no longer say
that SRCU is not modeled, but instead describe how LKMM's modeling of
SRCU departs from the Linux-kernel implementation.

TL;DR:  There is no known valid use case that cares about the Linux
kernel's ability to have partially overlapping SRCU read-side critical
sections.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/README | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 0f2c366518c6..9d7d4f23503f 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -221,8 +221,29 @@ The Linux-kernel memory model has the following limitations:
 		additional call_rcu() process to the site of the
 		emulated rcu-barrier().
 
-	e.	Sleepable RCU (SRCU) is not modeled.  It can be
-		emulated, but perhaps not simply.
+	e.	Although sleepable RCU (SRCU) is now modeled, there
+		are some subtle differences between its semantics and
+		those in the Linux kernel.  For example, the kernel
+		might interpret the following sequence as two partially
+		overlapping SRCU read-side critical sections:
+
+			 1  r1 = srcu_read_lock(&my_srcu);
+			 2  do_something_1();
+			 3  r2 = srcu_read_lock(&my_srcu);
+			 4  do_something_2();
+			 5  srcu_read_unlock(&my_srcu, r1);
+			 6  do_something_3();
+			 7  srcu_read_unlock(&my_srcu, r2);
+
+		In contrast, LKMM will interpret this as a nested pair of
+		SRCU read-side critical sections, with the outer critical
+		section spanning lines 1-7 and the inner critical section
+		spanning lines 3-5.
+
+		This difference would be more of a concern had anyone
+		identified a reasonable use case for partially overlapping
+		SRCU read-side critical sections.  For more information,
+		please see: https://paulmck.livejournal.com/40593.html
 
 	f.	Reader-writer locking is not modeled.  It can be
 		emulated in litmus tests using atomic read-modify-write
-- 
2.17.1

