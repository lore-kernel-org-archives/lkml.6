Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753105AbeCUTXV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:23:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753023AbeCUTXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:23:15 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 02/32] docs/vm: balance: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:18 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18032119-0008-0000-0000-000004E0DF6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032119-0009-0000-0000-00001E7403DD
Message-Id: <1521660168-14372-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210221
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/balance | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/balance b/Documentation/vm/balance
index 9645954..6a1fadf 100644
--- a/Documentation/vm/balance
+++ b/Documentation/vm/balance
@@ -1,3 +1,9 @@
+.. _balance:
+
+================
+Memory Balancing
+================
+
 Started Jan 2000 by Kanoj Sarcar <kanoj@sgi.com>
 
 Memory balancing is needed for !__GFP_ATOMIC and !__GFP_KSWAPD_RECLAIM as
@@ -62,11 +68,11 @@ for non-sleepable allocations. Second, the HIGHMEM zone is also balanced,
 so as to give a fighting chance for replace_with_highmem() to get a
 HIGHMEM page, as well as to ensure that HIGHMEM allocations do not
 fall back into regular zone. This also makes sure that HIGHMEM pages
-are not leaked (for example, in situations where a HIGHMEM page is in 
+are not leaked (for example, in situations where a HIGHMEM page is in
 the swapcache but is not being used by anyone)
 
 kswapd also needs to know about the zones it should balance. kswapd is
-primarily needed in a situation where balancing can not be done, 
+primarily needed in a situation where balancing can not be done,
 probably because all allocation requests are coming from intr context
 and all process contexts are sleeping. For 2.3, kswapd does not really
 need to balance the highmem zone, since intr context does not request
@@ -89,7 +95,8 @@ pages is below watermark[WMARK_LOW]; in which case zone_wake_kswapd is also set.
 
 
 (Good) Ideas that I have heard:
+
 1. Dynamic experience should influence balancing: number of failed requests
-for a zone can be tracked and fed into the balancing scheme (jalvo@mbay.net)
+   for a zone can be tracked and fed into the balancing scheme (jalvo@mbay.net)
 2. Implement a replace_with_highmem()-like replace_with_regular() to preserve
-dma pages. (lkd@tantalophile.demon.co.uk)
+   dma pages. (lkd@tantalophile.demon.co.uk)
-- 
2.7.4
