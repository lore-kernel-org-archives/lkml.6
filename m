Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933519AbeCGR1Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:27:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932537AbeCGR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:27:14 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 3/4] tools/memory-order: Add documentation of new litmus test
Date: Wed,  7 Mar 2018 09:27:39 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180307172627.GA15805@linux.vnet.ibm.com>
 <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030717-0048-0000-0000-0000024630B9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008629; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999660; UDB=6.00508497; IPR=6.00779066;
 MB=3.00019896; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 17:27:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030717-0049-0000-0000-0000445D27B2
Message-Id: <1520443660-16858-3-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The litmus-tests/README file lacks any mention of the new litmus test
ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore
adds a description of this test.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/litmus-tests/README | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index dca7d823ad57..04096fb8b8d9 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -32,6 +32,12 @@ IRIW+poonceonces+OnceOnce.litmus
 	order of a pair of writes, where each write is to a different
 	variable by a different process?
 
+ISA2+pooncelock+pooncelock+pombonce.litmus
+	Tests whether the ordering provided by a lock-protected S
+	litmus test is visible to an external process whose accesses are
+	separated by smp_mb().	This addition of an external process to
+	S is otherwise known as ISA2.
+
 ISA2+poonceonces.litmus
 	As below, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
-- 
2.5.2
