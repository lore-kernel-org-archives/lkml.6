Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F58C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3A92175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393220AbfBMRiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:38:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393137AbfBMRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:37:52 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DHTn5t021435
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:37:51 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qmpenuxga-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:37:50 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Feb 2019 17:37:50 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 17:37:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1DHbhwa24183020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 17:37:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80529B206C;
        Wed, 13 Feb 2019 17:37:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A76FB2068;
        Wed, 13 Feb 2019 17:37:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.41])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Feb 2019 17:37:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C242B16C5FBF; Wed, 13 Feb 2019 09:37:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH memory-model 4/7] tools/memory-model: Update README for addition of SRCU
Date:   Wed, 13 Feb 2019 09:37:40 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213173650.GA26078@linux.ibm.com>
References: <20190213173650.GA26078@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19021317-0068-0000-0000-000003934B0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010589; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01160548; UDB=6.00605725; IPR=6.00941102;
 MB=3.00025565; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-13 17:37:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021317-0069-0000-0000-0000477EC7E8
Message-Id: <20190213173743.26682-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130124
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

