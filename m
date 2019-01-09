Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47907C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B1206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfAIVIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:08:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbfAIVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:07:58 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09KnSbF190826
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:07:57 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwn4qsee6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:07:56 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:07:55 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:07:51 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09L7oMe21037284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:07:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F7C7B206A;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FDE5B205F;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:07:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D89D416C63C9; Wed,  9 Jan 2019 13:07:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, willy@infradead.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC LKMM 1/7] tools/memory-model: Rename some RCU relations
Date:   Wed,  9 Jan 2019 13:07:42 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0064-0000-0000-000003940F0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144138; UDB=6.00595704; IPR=6.00924400;
 MB=3.00025055; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:07:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0065-0000-0000-00003BF95738
Message-Id: <20190109210748.29074-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=2 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

In preparation for adding support for SRCU, rename "crit" to
"rcu-rscs", rename "rscs" to "rcu-rscsi", and remove the restriction
to only the outermost level of nesting.

The name change is needed for disambiguating RCU read-side critical
sections from SRCU read-side critical sections.  Adding the "i" at the
end of "rcu-rscsi" emphasizes that the relation is inverted; it links
rcu_read_unlock() events to their corresponding preceding
rcu_read_lock() events.

The restriction to outermost nesting levels was never essential; it
was included mostly to show that it could be done.  Rather than add
equivalent unnecessary code for SRCU lock nesting, it seemed better to
remove the existing code.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Tested-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 tools/memory-model/linux-kernel.bell |  9 +++------
 tools/memory-model/linux-kernel.cat  | 10 +++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 796513362c05..353c8d68e030 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -34,7 +34,7 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
-let matched = let rec
+let rcu-rscs = let rec
 	    unmatched-locks = Rcu-lock \ domain(matched)
 	and unmatched-unlocks = Rcu-unlock \ range(matched)
 	and unmatched = unmatched-locks | unmatched-unlocks
@@ -46,8 +46,5 @@ let matched = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Rcu-lock \ domain(matched) as unbalanced-rcu-locking
-flag ~empty Rcu-unlock \ range(matched) as unbalanced-rcu-locking
-
-(* Outermost level of nesting only *)
-let crit = matched \ (po^-1 ; matched ; po^-1)
+flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
+flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 8f23c74a96fd..ab9de9c1234b 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -95,7 +95,7 @@ acyclic pb as propagation
  * onward on the one hand and from the rcu_read_unlock() backwards on the
  * other hand.
  *)
-let rscs = po ; crit^-1 ; po?
+let rcu-rscsi = po ; rcu-rscs^-1 ; po?
 
 (*
  * The synchronize_rcu() strong fence is special in that it can order not
@@ -109,10 +109,10 @@ let rcu-link = hb* ; pb* ; prop
  * critical sections (joined by rcu-link) acts as a generalized strong fence.
  *)
 let rec rcu-fence = gp |
-	(gp ; rcu-link ; rscs) |
-	(rscs ; rcu-link ; gp) |
-	(gp ; rcu-link ; rcu-fence ; rcu-link ; rscs) |
-	(rscs ; rcu-link ; rcu-fence ; rcu-link ; gp) |
+	(gp ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; gp) |
+	(gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
+	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; gp) |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
-- 
2.17.1

