Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeENXeF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 19:34:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752498AbeENXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 19:32:35 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 16/19] tools/memory-model: Fix coding style in 'lock.cat'
Date: Mon, 14 May 2018 16:33:54 -0700
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051423-2213-0000-0000-000002A53F86
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009026; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032383; UDB=6.00527784; IPR=6.00811515;
 MB=3.00021114; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 23:32:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051423-2214-0000-0000-00005A1EAECF
Message-Id: <1526340837-12222-16-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140230
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

This commit uses tabs for indentation and adds spaces around binary
operator.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/lock.cat | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index cd002a33ca8a..305ded17e741 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -84,16 +84,16 @@ let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
 
 (* rfe for LF events *)
 let all-possible-rfe-lf =
-  (*
-   * Given an LF event r, compute the possible rfe edges for that event
-   * (all those starting from LKW events in other threads),
-   * and then convert that relation to a set of single-edge relations.
-   *)
-  let possible-rfe-lf r =
-    let pair-to-relation p = p ++ 0
-    in map pair-to-relation ((LKW * {r}) & loc & ext)
-  (* Do this for each LF event r that isn't in rfi-lf *)
-  in map possible-rfe-lf (LF \ range(rfi-lf))
+	(*
+	 * Given an LF event r, compute the possible rfe edges for that event
+	 * (all those starting from LKW events in other threads),
+	 * and then convert that relation to a set of single-edge relations.
+	 *)
+	let possible-rfe-lf r =
+		let pair-to-relation p = p ++ 0
+		in map pair-to-relation ((LKW * {r}) & loc & ext)
+	(* Do this for each LF event r that isn't in rfi-lf *)
+	in map possible-rfe-lf (LF \ range(rfi-lf))
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
@@ -110,10 +110,10 @@ let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
 
 (* rfe for RU events: an RU may read from an external UL or the initial write *)
 let all-possible-rfe-ru =
-   let possible-rfe-ru r =
-     let pair-to-relation p = p ++ 0
-     in map pair-to-relation (((UL|IW) * {r}) & loc & ext)
-  in map possible-rfe-ru RU
+	let possible-rfe-ru r =
+		let pair-to-relation p = p ++ 0
+		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
+	in map possible-rfe-ru RU
 
 (* Generate all rf relations for RU events *)
 with rfe-ru from cross(all-possible-rfe-ru)
-- 
2.5.2
