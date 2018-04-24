Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756269AbeDXGlD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:41:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756158AbeDXGkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:40:51 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 6/7] docs/vm: ksm: udpate description of stable_node_{dups,chains}
Date: Tue, 24 Apr 2018 09:40:27 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042406-0044-0000-0000-0000054B71A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0045-0000-0000-0000288BA327
Message-Id: <1524552028-7017-7-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove implementation details from sysfs parameter descriptions.
Also move the paragraph discussing fragmentation issues and their possible
solution to the "Design" section.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/ksm.rst | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/vm/ksm.rst b/Documentation/vm/ksm.rst
index 18d7c71..afcf5a8 100644
--- a/Documentation/vm/ksm.rst
+++ b/Documentation/vm/ksm.rst
@@ -170,10 +170,9 @@ pages_volatile
 full_scans
         how many times all mergeable areas have been scanned
 stable_node_chains
-        number of stable node chains allocated, this is effectively
         the number of KSM pages that hit the ``max_page_sharing`` limit
 stable_node_dups
-        number of stable node dups queued into the stable_node chains
+        number of duplicated KSM pages
 
 A high ratio of ``pages_sharing`` to ``pages_shared`` indicates good
 sharing, but a high ratio of ``pages_unshared`` to ``pages_sharing``
@@ -185,15 +184,6 @@ The maximum possible ``pages_sharing/pages_shared`` ratio is limited by the
 ``max_page_sharing`` tunable. To increase the ratio ``max_page_sharing`` must
 be increased accordingly.
 
-The ``stable_node_dups/stable_node_chains`` ratio is also affected by the
-``max_page_sharing`` tunable, and an high ratio may indicate fragmentation
-in the stable_node dups, which could be solved by introducing
-fragmentation algorithms in ksmd which would refile rmap_items from
-one stable_node dup to another stable_node dup, in order to free up
-stable_node "dups" with few rmap_items in them, but that may increase
-the ksmd CPU usage and possibly slowdown the readonly computations on
-the KSM pages of the applications.
-
 Design
 ======
 
@@ -247,6 +237,15 @@ deduplication factor at the expense of slower worst case for rmap
 walks for any KSM page which can happen during swapping, compaction,
 NUMA balancing and page migration.
 
+The ``stable_node_dups/stable_node_chains`` ratio is also affected by the
+``max_page_sharing`` tunable, and an high ratio may indicate fragmentation
+in the stable_node dups, which could be solved by introducing
+fragmentation algorithms in ksmd which would refile rmap_items from
+one stable_node dup to another stable_node dup, in order to free up
+stable_node "dups" with few rmap_items in them, but that may increase
+the ksmd CPU usage and possibly slowdown the readonly computations on
+the KSM pages of the applications.
+
 The whole list of stable_node "dups" linked in the stable_node
 "chains" is scanned periodically in order to prune stale stable_nodes.
 The frequency of such scans is defined by
-- 
2.7.4
