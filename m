Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeAaXPf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:15:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51668 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754225AbeAaXEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:04:33 -0500
From: daniel.m.jordan@oracle.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        Dave.Dice@oracle.com, dave@stgolabs.net, khandual@linux.vnet.ibm.com,
        ldufour@linux.vnet.ibm.com, mgorman@suse.de, mhocko@kernel.org,
        pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        yossi.lev@oracle.com
Subject: [RFC PATCH v1 02/13] mm: allow compaction to be disabled
Date: Wed, 31 Jan 2018 18:04:02 -0500
Message-Id: <20180131230413.27653-3-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
References: <20180131230413.27653-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=908
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310283
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a temporary hack to avoid the non-trivial refactoring of the
compaction code that takes lru_lock in this prototype.  This refactoring
can be done later.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 03ff7703d322..96412c3939c5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -231,7 +231,6 @@ config BALLOON_COMPACTION
 # support for memory compaction
 config COMPACTION
 	bool "Allow for memory compaction"
-	def_bool y
 	select MIGRATION
 	depends on MMU
 	help
-- 
2.16.1
