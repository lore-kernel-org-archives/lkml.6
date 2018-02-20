Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeBTX0h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:26:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751957AbeBTXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:05 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 08/12] memory-barriers: Fix description of data dependency barriers
Date: Tue, 20 Feb 2018 15:25:08 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022023-2213-0000-0000-000002730526
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008566; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992685; UDB=6.00504342; IPR=6.00772031;
 MB=3.00019661; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-20 23:25:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022023-2214-0000-0000-0000592F0724
Message-Id: <1519169112-20593-8-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802200276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

In the description of data dependency barriers the words 'before' is
used erroneously. Since such barrier order dependent loads one after
the other. So substitute 'before' with 'after'.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 74ad222d11ed..0d83333b84a9 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -400,7 +400,7 @@ Memory barriers come in four basic varieties:
      where two loads are performed such that the second depends on the result
      of the first (eg: the first load retrieves the address to which the second
      load will be directed), a data dependency barrier would be required to
-     make sure that the target of the second load is updated before the address
+     make sure that the target of the second load is updated after the address
      obtained by the first load is accessed.
 
      A data dependency barrier is a partial ordering on interdependent loads
-- 
2.5.2
