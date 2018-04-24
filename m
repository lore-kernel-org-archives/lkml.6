Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756478AbeDXGnH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:43:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755936AbeDXGkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:40:41 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/7] mm/ksm: docs: extend overview comment and make it "DOC:"
Date: Tue, 24 Apr 2018 09:40:22 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042406-0008-0000-0000-000004EE858A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0009-0000-0000-00001E82ACCA
Message-Id: <1524552028-7017-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing comment provides a good overview of KSM implementation. Let's
update it to reflect recent additions of "chain" and "dup" variants of the
stable tree nodes and mark it as "DOC:" for inclusion into the KSM
documentation.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/ksm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 58c2741..54155b1 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -51,7 +51,9 @@
 #define DO_NUMA(x)	do { } while (0)
 #endif
 
-/*
+/**
+ * DOC: Overview
+ *
  * A few notes about the KSM scanning process,
  * to make it easier to understand the data structures below:
  *
@@ -67,6 +69,21 @@
  * this tree is fully assured to be working (except when pages are unmapped),
  * and therefore this tree is called the stable tree.
  *
+ * The stable tree node includes information required for reverse
+ * mapping from a KSM page to virtual addresses that map this page.
+ *
+ * In order to avoid large latencies of the rmap walks on KSM pages,
+ * KSM maintains two types of nodes in the stable tree:
+ *
+ * * the regular nodes that keep the reverse mapping structures in a
+ *   linked list
+ * * the "chains" that link nodes ("dups") that represent the same
+ *   write protected memory content, but each "dup" corresponds to a
+ *   different KSM page copy of that content
+ *
+ * Internally, the regular nodes, "dups" and "chains" are represented
+ * using the same :c:type:`struct stable_node` structure.
+ *
  * In addition to the stable tree, KSM uses a second data structure called the
  * unstable tree: this tree holds pointers to pages which have been found to
  * be "unchanged for a period of time".  The unstable tree sorts these pages
-- 
2.7.4
