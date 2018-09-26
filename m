Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCA8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033B72152C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033B72152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeI0Ano (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:43:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbeI0Ann (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:43:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QIT9Ss124973
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:29:28 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mrekc2fgb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:29:28 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 26 Sep 2018 14:29:28 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 14:29:23 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QITMwX43384952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 18:29:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61A0FB2067;
        Wed, 26 Sep 2018 14:27:42 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED92CB2066;
        Wed, 26 Sep 2018 14:27:41 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.155.193])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Sep 2018 14:27:41 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A9E9616C3662; Wed, 26 Sep 2018 11:29:21 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 1/5] tools/memory-model: Add litmus-test naming scheme
Date:   Wed, 26 Sep 2018 11:29:16 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926182845.GA24839@linux.ibm.com>
References: <20180926182845.GA24839@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18092618-0060-0000-0000-000002B6CBAB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009776; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094026; UDB=6.00565497; IPR=6.00874064;
 MB=3.00023518; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-26 18:29:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092618-0061-0000-0000-000046A52DCC
Message-Id: <20180926182920.27644-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

This commit documents the scheme used to generate the names for the
litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Apply feedback from Andrea Parri and Will Deacon. ]
Acked-by: Will Deacon <will.deacon@arm.com>
---
 tools/memory-model/litmus-tests/README | 104 ++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 4581ec2d3c57..5ee08f129094 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -1,4 +1,6 @@
-This directory contains the following litmus tests:
+============
+LITMUS TESTS
+============
 
 CoRR+poonceonce+Once.litmus
 	Test of read-read coherence, that is, whether or not two
@@ -36,7 +38,7 @@ IRIW+poonceonces+OnceOnce.litmus
 ISA2+pooncelock+pooncelock+pombonce.litmus
 	Tests whether the ordering provided by a lock-protected S
 	litmus test is visible to an external process whose accesses are
-	separated by smp_mb().	This addition of an external process to
+	separated by smp_mb().  This addition of an external process to
 	S is otherwise known as ISA2.
 
 ISA2+poonceonces.litmus
@@ -151,3 +153,101 @@ Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
 A great many more litmus tests are available here:
 
 	https://github.com/paulmckrcu/litmus
+
+==================
+LITMUS TEST NAMING
+==================
+
+Litmus tests are usually named based on their contents, which means that
+looking at the name tells you what the litmus test does.  The naming
+scheme covers litmus tests having a single cycle that passes through
+each process exactly once, so litmus tests not fitting this description
+are named on an ad-hoc basis.
+
+The structure of a litmus-test name is the litmus-test class, a plus
+sign ("+"), and one string for each process, separated by plus signs.
+The end of the name is ".litmus".
+
+The litmus-test classes may be found in the infamous test6.pdf:
+https://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test6.pdf
+Each class defines the pattern of accesses and of the variables accessed.
+For example, if the one process writes to a pair of variables, and
+the other process reads from these same variables, the corresponding
+litmus-test class is "MP" (message passing), which may be found on the
+left-hand end of the second row of tests on page one of test6.pdf.
+
+The strings used to identify the actions carried out by each process are
+complex due to a desire to have short(er) names.  Thus, there is a tool to
+generate these strings from a given litmus test's actions.  For example,
+consider the processes from SB+rfionceonce-poonceonces.litmus:
+
+	P0(int *x, int *y)
+	{
+		int r1;
+		int r2;
+
+		WRITE_ONCE(*x, 1);
+		r1 = READ_ONCE(*x);
+		r2 = READ_ONCE(*y);
+	}
+
+	P1(int *x, int *y)
+	{
+		int r3;
+		int r4;
+
+		WRITE_ONCE(*y, 1);
+		r3 = READ_ONCE(*y);
+		r4 = READ_ONCE(*x);
+	}
+
+The next step is to construct a space-separated list of descriptors,
+interleaving descriptions of the relation between a pair of consecutive
+accesses with descriptions of the second access in the pair.
+
+P0()'s WRITE_ONCE() is read by its first READ_ONCE(), which is a
+reads-from link (rf) and internal to the P0() process.  This is
+"rfi", which is an abbreviation for "reads-from internal".  Because
+some of the tools string these abbreviations together with space
+characters separating processes, the first character is capitalized,
+resulting in "Rfi".
+
+P0()'s second access is a READ_ONCE(), as opposed to (for example)
+smp_load_acquire(), so next is "Once".  Thus far, we have "Rfi Once".
+
+P0()'s third access is also a READ_ONCE(), but to y rather than x.
+This is related to P0()'s second access by program order ("po"),
+to a different variable ("d"), and both accesses are reads ("RR").
+The resulting descriptor is "PodRR".  Because P0()'s third access is
+READ_ONCE(), we add another "Once" descriptor.
+
+A from-read ("fre") relation links P0()'s third to P1()'s first
+access, and the resulting descriptor is "Fre".  P1()'s first access is
+WRITE_ONCE(), which as before gives the descriptor "Once".  The string
+thus far is thus "Rfi Once PodRR Once Fre Once".
+
+The remainder of P1() is similar to P0(), which means we add
+"Rfi Once PodRR Once".  Another fre links P1()'s last access to
+P0()'s first access, which is WRITE_ONCE(), so we add "Fre Once".
+The full string is thus:
+
+	Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once
+
+This string can be given to the "norm7" and "classify7" tools to
+produce the name:
+
+	$ norm7 -bell linux-kernel.bell \
+		Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once | \
+	  sed -e 's/:.*//g'
+	SB+rfionceonce-poonceonces
+
+Adding the ".litmus" suffix: SB+rfionceonce-poonceonces.litmus
+
+The descriptors that describe connections between consecutive accesses
+within the cycle through a given litmus test can be provided by the herd
+tool (Rfi, Po, Fre, and so on) or by the linux-kernel.bell file (Once,
+Release, Acquire, and so on).
+
+To see the full list of descriptors, execute the following command:
+
+	$ diyone7 -bell linux-kernel.bell -show edges
-- 
2.17.1

