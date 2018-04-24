Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756321AbeDXGlP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:41:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756102AbeDXGk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:40:58 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 5/7] docs/vm: ksm: update stable_node_chains_prune_millisecs description
Date: Tue, 24 Apr 2018 09:40:26 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18042406-0040-0000-0000-00000450C4E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0041-0000-0000-000020F530B9
Message-Id: <1524552028-7017-6-git-send-email-rppt@linux.vnet.ibm.com>
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

Make the description of stable_node_chains_prune_millisecs sysfs parameter
less implementation aware and add a few words about this parameter in the
"Design" section.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/ksm.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/vm/ksm.rst b/Documentation/vm/ksm.rst
index 00961b8..18d7c71 100644
--- a/Documentation/vm/ksm.rst
+++ b/Documentation/vm/ksm.rst
@@ -150,14 +150,12 @@ max_page_sharing
         traversals are always schedule friendly themselves.
 
 stable_node_chains_prune_millisecs
-        How frequently to walk the whole list of stable_node "dups"
-        linked in the stable_node "chains" in order to prune stale
-        stable_nodes. Smaller milllisecs values will free up the KSM
-        metadata with lower latency, but they will make ksmd use more
-        CPU during the scan. This only applies to the stable_node
-        chains so it's a noop if not a single KSM page hit the
-        ``max_page_sharing`` yet (there would be no stable_node chains in
-        such case).
+        specifies how frequently KSM checks the metadata of the pages
+        that hit the deduplication limit for stale information.
+        Smaller milllisecs values will free up the KSM metadata with
+        lower latency, but they will make ksmd use more CPU during the
+        scan. It's a noop if not a single KSM page hit the
+        ``max_page_sharing`` yet.
 
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
 
@@ -249,6 +247,11 @@ deduplication factor at the expense of slower worst case for rmap
 walks for any KSM page which can happen during swapping, compaction,
 NUMA balancing and page migration.
 
+The whole list of stable_node "dups" linked in the stable_node
+"chains" is scanned periodically in order to prune stale stable_nodes.
+The frequency of such scans is defined by
+``stable_node_chains_prune_millisecs`` sysfs tunable.
+
 Reference
 ---------
 .. kernel-doc:: mm/ksm.c
-- 
2.7.4
